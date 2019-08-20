Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6314CC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A0422DD6
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrgZWlON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A0422DD6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i070u-00031g-Bk
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i06zu-0001qI-FW
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i06zs-0003um-W8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:38 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i06zs-0003u3-Q4
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:28:36 -0400
Received: by mail-oi1-x243.google.com with SMTP id a127so4557204oii.2
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 09:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tzMRtwYZ03u7tHw7cZOlVBfr7BswpAxGXZmKHLrisK8=;
 b=FrgZWlONl6KV/S7CCIiLS2RjF3gCTs35UNBISu2WwTfp4KSK6BYm0ZZIeK3rrmW97D
 mkvkpmeDKUrGGUw2AfvkNMQ6tbMFWdv4TpYegOr4L4/vByecDWeOSmFbCfg5QGy+V6tc
 zPqLZGa421V/a8hC8+PkDyuM4GNNCdXdj7q1rbVOtgVQdssKqvDLI4aUgsHQypzpr6UR
 0J+a0pPYlnckyPkx5IGs/ZVejf+Urf3RXKuo6rekow5XZjxxPlCux1J896tDlLwVV9i4
 +cgvHnyVbR+YYbzSrPhkvRpMcnkqp3mNZPzq5Khl1Dapsq/BHdyELqbQpxaGsQ7pWMgR
 wCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tzMRtwYZ03u7tHw7cZOlVBfr7BswpAxGXZmKHLrisK8=;
 b=drWX7w6yJLdK7G0zOASjosHCWjAM15++dStHyjpNZI3seMgO7s4lkXPfJvVhwIMLst
 bHzvAgZAniCjWdzSqC4Zn9u7FGSgWYv/5YMz97As+EMk0bni1IndEp14OFaPiMjB5IPr
 wFlyGIsMXL7uldVtXFM5UQ56StzVQqphZVMfhaciC0OE28gRNCe590iSONlZmkRDEWQF
 l+iHdGxY1WL+Z9WhMIHRecfhEKQI39f79uzkF8F7cOgHESmppDf8Vk+12rJQV9bfhoRw
 xAAeAcpqKsA24vHOujcNOTDMEoS7Ubrh65kjd90oXUMoq7WgG3S8L+xs1Bq7umf9ccs/
 d98w==
X-Gm-Message-State: APjAAAWPBzHfJ/CZgTWe+FP3N/9HMlgOIWsr6hSgTPjFtBQmQo3q8jvM
 oJWkkuhWMTvEilQzhbGvgl0XSAhAwmV4S2ebRtbZiA==
X-Google-Smtp-Source: APXvYqxp+d6iHRjrhK2+5w+mdnkOsQffFq4wzPurh4KHibyB+CVzeek7uEumIseWag51EeVl/Aq0BHF3T72b39PtzLM=
X-Received: by 2002:aca:4a57:: with SMTP id x84mr691142oia.170.1566318515678; 
 Tue, 20 Aug 2019 09:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <1566314861-32709-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566314861-32709-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Aug 2019 17:28:24 +0100
Message-ID: <CAFEAcA8jXewGKbW_WP3oKRNkwbPzGP3DdeEhwje_D=uHN3zTkg@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL v2 00/34] Misc patches for 2019-08-20
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 20 Aug 2019 at 16:28, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 17dc57990320edaad52ac9ea808be9719c91cea6:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-08-20' into staging (2019-08-20 14:14:20 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to f496f8aca311b0b1fab979657694069871426395:
>
>   x86: Intel AVX512_BF16 feature enabling (2019-08-20 17:26:30 +0200)
>
> ----------------------------------------------------------------
> * New KVM PV features (Marcelo, Wanpeng)
> * valgrind fixes (Andrey)
> * Remove clock reset notifiers (David)
> * KConfig and Makefile cleanups (Paolo)
> * Replay and icount improvements (Pavel)
> * x86 FP fixes (Peter M.)
> * TCG locking assertions (Roman)
> * x86 support for mmap-ed -kernel/-initrd (Stefano)
> * Other cleanups (Wei Yang, Yan Zhao, Tony)
> * LSI fix for infinite loop (Prasad)
> * ARM migration fix (Catherine)
> * AVX512_BF16 feature (Jing)
>
> ----------------------------------------------------------------

The linux-user build seems to fail 'make check-tcg':
e104462:bionic:qemu-for-merges$ make -C build/all-linux-static/ check-tcg
make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
make[1]: Entering directory '/home/petmay01/linaro/qemu-for-merges/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/home/petmay01/linaro/qemu-for-merges/slirp'
  BUILD   debian10
  BUILD   debian-buster-arm64-cross
  BUILD   TCG tests for aarch64-linux-user
  BUILD   aarch64 guest-tests with aarch64-linux-gnu-gcc
  RUN     TCG tests for aarch64-linux-user
  BUILD   aarch64 guest-tests with aarch64-linux-gnu-gcc
  RUN     tests for aarch64
  TEST    test-mmap (default) on aarch64
qemu-aarch64: /home/petmay01/linaro/qemu-for-merges/cpus-common.c:219:
cpu_exec_start: Assertion `!qemu_mutex_iothread_locked()' failed.
/home/petmay01/linaro/qemu-for-merges/tests/tcg/multiarch/Makefile.target:30:
recipe for target 'run-test-mmap' failed
make[2]: *** [run-test-mmap] Error 127
/home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.include:71:
recipe for target 'run-guest-tests' failed
make[1]: *** [run-guest-tests] Error 2
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:1075:
recipe for target 'run-tcg-tests-aarch64-linux-user' failed
make: *** [run-tcg-tests-aarch64-linux-user] Error 2
make: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'

Looks like we hit the assertion immediately on startup before
we try to do anything:

Thread 2 (Thread 0x7ffff7ff9700 (LWP 9252)):
#0  0x0000000060340b49 in syscall ()
#1  0x00000000601492af in qemu_futex_wait (f=0x628c9838
<rcu_call_ready_event>, val=4294967295)
    at /home/petmay01/linaro/qemu-for-merges/include/qemu/futex.h:29
#2  0x0000000060149476 in qemu_event_wait (ev=0x628c9838 <rcu_call_ready_event>)
    at /home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:442
#3  0x0000000060152794 in call_rcu_thread (opaque=0x0) at
/home/petmay01/linaro/qemu-for-merges/util/rcu.c:260
#4  0x0000000060149629 in qemu_thread_start (args=0x628d3f20) at
/home/petmay01/linaro/qemu-for-merges/util/qemu-thread-posix.c:502
#5  0x00000000602b19fb in start_thread (arg=0x7ffff7ff9700) at
pthread_create.c:463
#6  0x000000006034292f in clone ()

Thread 1 (Thread 0x628d2940 (LWP 9248)):
#0  0x00000000602d52b7 in raise ()
#1  0x00000000602d5951 in abort ()
#2  0x00000000602c884c in __assert_fail_base ()
#3  0x00000000602c88c2 in __assert_fail ()
#4  0x00000000600f2438 in cpu_exec_start (cpu=0x628f5cd0) at
/home/petmay01/linaro/qemu-for-merges/cpus-common.c:219
#5  0x0000000060094fc7 in cpu_loop (env=0x628fdfa0) at
/home/petmay01/linaro/qemu-for-merges/linux-user/i386/cpu_loop.c:93
#6  0x0000000060064f2c in main (argc=6, argv=0x7fffffffe3b8,
envp=0x7fffffffe3f0)
    at /home/petmay01/linaro/qemu-for-merges/linux-user/main.c:838

This is because for linux-user we're using the stubs/ version
of qemu_mutex_iothread_locked(), which always returns 'true',
so the assertion can never pass...

thanks
-- PMM

