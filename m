Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8553C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 18:35:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03F7720759
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KV9IWR8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03F7720759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEzW0-0007LC-15
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 14:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEzVA-0006po-4m
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 14:34:56 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42105)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEzV8-0004S8-3Z
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 14:34:55 -0400
Received: by mail-ed1-x543.google.com with SMTP id l63so10551603edl.9
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=//qQ185uRrUdiQJEaUcHiP8sSXOiIysm7ymA8If1X8Y=;
 b=KV9IWR8Gl45ZqbGfQvlWS6bKDVRRhQ7aHgN8AT5yL/zgFXIRtWu7Xoxl66d6SEPyuP
 sFJVvuMccgYdm1quKQ6nqdtqMJdgUrWE0Xj+rROkGAXHvwWvJBBlnhT2WusE4kZXPkXB
 RYfLm6w7WYNRMfS7grMQlKFv1GaJNXvu6MQtynMgQBPG1M/pfw84Evz1KcHcUBUnfSL2
 enNCxFatwKqKzZTy0Ul8A8MdnwrlO7ifQzLPaJUvq/Cj8TgrUfA8HZi7vzQnve2DM4p5
 BIEkMWrAWAaPCu6USD1a0jzRDFssSWMNHCgzPm06M1erKcmB3bFdetA9C0Utk4XmKq2K
 WbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=//qQ185uRrUdiQJEaUcHiP8sSXOiIysm7ymA8If1X8Y=;
 b=h0W9q3c6NMloLWMMV4iRWoLr2Fs9zOxOI7JzSPWIQ2j69TU1ab53s/Xyu/COaWoi7U
 0e5uH+JKQ5BETVAGAmbXvsBEYz7wLM1DMrwXxce4RfnflacoRSTPGHvWNatPYxt4XkkA
 LVH+0fOu3nT7B+U4nykX5TmSQtjQXSdIAo1yG838H0Ye3rHevImI+/2V5BYKDVpy1vpW
 aZ5Sb2sHTcA+p6bibmV+9uDmsQiDcONkgzpKNVKRmHlwlNdF1eSA5Ct/VlHKYYv3eH3B
 SNG8E/V1uL19hiF0aNwKHVdtHCcR2Ah10sYXwEG8YfhFGhvnl6iZntq6dnJloBCcPFBl
 smIA==
X-Gm-Message-State: AOAM533tgXK96tnUb3/x3TEwsL6mC9GU9gLSKeKa6bx+ajH64edkqUFn
 NSUke16cxHfaKM19rdyUdmGnsyH7Unf7R8FHatLXQA==
X-Google-Smtp-Source: ABdhPJwkCu8IH0nd0hBvh0wKpX+fhNsyWGbCL+/NfX6jtO4TszUoYjhGw9ki5VA+vrMVUwIfhv94Inbqlnebv0UgCgo=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr18967475edy.52.1599417292229; 
 Sun, 06 Sep 2020 11:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200906175344.5042-1-pbonzini@redhat.com>
In-Reply-To: <20200906175344.5042-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2020 19:34:41 +0100
Message-ID: <CAFEAcA8qvZAqYHwnrkxWb8NGhgE6h=gKrXBHTDNLk+0YDxfzfQ@mail.gmail.com>
Subject: Re: [PULL v2 00/46] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Sun, 6 Sep 2020 at 18:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 227de21ed0759e275a469394af72c999d0134bb5:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200903' into staging (2020-09-05 15:30:41 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6264b35324d3766d3c2ff369c4e8ecba8bd5b571:
>
>   meson: remove linkage of sdl to baum (2020-09-06 19:50:57 +0200)
>
> ----------------------------------------------------------------
> meson related:
> * convert unit tests
> * bugfixes for mtest2make
> * miscellaneous bugfixes
> * dead code removal and configure cleanups
> * oss-fuzz fixes
> * msys fixes

Build failure, Windows (this is the second "uint" type usage
I've seen today...):

../../tests/test-vmstate.c: In function 'int_cmp':
../../tests/test-vmstate.c:884:5: error: unknown type name 'uint'
     uint ua = GPOINTER_TO_UINT(a);
     ^
../../tests/test-vmstate.c:885:5: error: unknown type name 'uint'
     uint ub = GPOINTER_TO_UINT(b);
     ^
Makefile.ninja:5443: recipe for target
'tests/test-vmstate.exe.p/test-vmstate.c.obj' failed
make: *** [tests/test-vmstate.exe.p/test-vmstate.c.obj] Error 1
make: *** Waiting for unfinished jobs....
../../tests/test-util-filemonitor.c: In function 'test_file_monitor_events':
../../tests/test-util-filemonitor.c:620:17: error: too many arguments
to function 'mkdir'
             if (mkdir(pathsrc, 0700) < 0) {
                 ^
In file included from
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/unistd.h:10:0,
                 from /home/petmay01/qemu-for-merges/include/qemu/osdep.h:93,
                 from ../../tests/test-util-filemonitor.c:21:
/usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/io.h:280:15: note:
declared here
   int __cdecl mkdir (const char *) __MINGW_ATTRIB_DEPRECATED_MSVC2005;
               ^



Build failure, OpenBSD:

In file included from ../src/hw/arm/nseries.c:30:
In file included from /home/qemu/qemu-test.yhbDti/src/include/hw/arm/omap.h:24:
In file included from
/home/qemu/qemu-test.yhbDti/src/include/hw/input/tsc2xxx.h:14:
/home/qemu/qemu-test.yhbDti/src/include/ui/console.h:11:11: fatal
error: 'epoxy/gl.h' file not found
# include <epoxy/gl.h>
          ^~~~~~~~~~~~
1 error generated.
gmake: *** [Makefile.ninja:1735:
libqemu-aarch64-softmmu.fa.p/hw_arm_nseries.c.o] Error 1



Odd warning on most but not all of the builds, though they went on to
complete OK:

make: Entering directory '/home/peter.maydell/qemu-freebsd/build'
/home/peter.maydell/qemu-freebsd/tests/Makefile.include:144: warning:
overriding recipe for target 'check-block'
Makefile.mtest:1345: warning: ignoring old recipe for target 'check-block'
config-host.mak is out-of-date, running configure
cross containers  no

NOTE: guest cross-compilers enabled: aarch64-linux-gnu-gcc cc
aarch64-linux-gnu-gcc cc
/usr/bin/python3 /home/peter.maydell/qemu-freebsd/meson/meson.py
--internal regenerate /home/peter.maydell/qemu-freebsd
/home/peter.maydell/qemu-freebsd/build --backend ninja
The Meson build system
Version: 0.55.1
[etc]


x86-64 clang build failed at the link stage (this is config we've
talked about before with
'../../configure' '--cc=clang' '--cxx=clang++' '--enable-gtk'
'--extra-cflags=-fsanitize=undefined  -fno-sanitize=shift-base
-Werror'
but where the clang++ doesn't work because the right libstdc++ happens
not to be present):

Linking target qemu-alpha
libcommon.fa.p/cpus-common.c.o: In function `cpu_list_add':
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:80:
undefined reference to `__ubsan_handle_type_mismatch_v1'
libcommon.fa.p/cpus-common.c.o: In function `cpu_get_free_index':
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:68:
undefined reference to `__ubsan_handle_type_mismatch_v1'
/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:67:
undefined reference to `__ubsan_handle_type_mismatch_v1'
libcommon.fa.p/cpus-common.c.o:/home/petmay01/linaro/qemu-for-merges/build/clang/../../cpus-common.c:67:
more undefined references to `__ubsan_handle_type_mismatch_v1' follow
collect2: error: ld returned 1 exit status

thanks
-- PMM

