Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED860C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EC220644
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 14:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EC220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8mPp-0004NX-Kf
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 10:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1i8mOH-0003QQ-Av
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1i8mOF-0004y2-W9
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:17:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46370)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1i8mOF-0004xT-R7
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 10:17:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id t1so13294784plq.13
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 07:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=GdYA4qhZJ9ndjnRlvQ/KWIY8FcUOBsbtcuThm73Lxio=;
 b=K9F5q01c5oO4cVXJs+owxLzGXJZOVCNVCS//NVrgRqp45KHFXV52N1EzNrdvyAkbF9
 SyZoC5yyYiS2xR0ur8iWhBLlQgpdq++vbGBsr3s+2ZHTaaThF6kzaJajEege4p9uDSWL
 jF0KijkVXywpEI/zOFL36nX/DyjSoR7E72aCv0EXMXFK9fWBWN4DkNbN6BOF8wlpLGRe
 skmvNvEAT3Q5bwX8jn2itoGa5zQJu+T2hOfniTugyR2c6Zlwpz82JaIP5WkOXPiDWT7N
 8OIrCpKRPKJLka3TUdxx+ue2oUYhK1GpaqiZsTBMycIvDzZJI0OqURZzUKjUdvpSx6SN
 +QeQ==
X-Gm-Message-State: APjAAAUFv+JrwYshHHSjMvdCcKcK921Txy1YXjMqfkuMGWc2H9T4PMOZ
 HI738s80M94yVfFzn1ABc9x8KQ==
X-Google-Smtp-Source: APXvYqw9d7GHORuKjJcRzrkYpx2B5vxhphFYWbwpuJljQKgdqEIcDEsnS8wTyfA2/BkBeKyTMj2G/A==
X-Received: by 2002:a17:902:8e8b:: with SMTP id
 bg11mr48441139plb.93.1568384253982; 
 Fri, 13 Sep 2019 07:17:33 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
 by smtp.gmail.com with ESMTPSA id c62sm40302366pfa.92.2019.09.13.07.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2019 07:17:33 -0700 (PDT)
Date: Fri, 13 Sep 2019 07:17:33 -0700 (PDT)
X-Google-Original-Date: Fri, 13 Sep 2019 07:17:05 PDT (-0700)
In-Reply-To: <CAFEAcA94wuW4koj9+v4bbNH+omZQfqkw=JMUjvyDwbu_Eevgag@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <mhng-89941bf7-1034-44fe-956f-a949910f2b52@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.214.195
Subject: Re: [Qemu-devel] [PULL] RISC-V Patches for the 4.2 Soft Freeze,
 Part 1
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Sep 2019 02:17:32 PDT (-0700), Peter Maydell wrote:
> On Wed, 11 Sep 2019 at 09:24, Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>>
>>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>>
>> are available in the Git repository at:
>>
>>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-sf1
>>
>> for you to fetch changes up to 1b2d0961bfaaa2db3a237f53273527b6c5e3498a:
>>
>>   target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point (2019-09-10 06:08:42 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V Patches for the 4.2 Soft Freeze, Part 1
>>
>> This contains quite a few patches that I'd like to target for 4.2.
>> They're mostly emulation fixes for the sifive_u board, which now much
>> more closely matches the hardware and can therefor run the same fireware
>> as what gets loaded onto the board.  Additional user-visible
>> improvements include:
>>
>> * support for loading initrd files from the command line into Linux, via
>>   /chosen/linux,initrd-{start,end} device tree nodes.
>> * The conversion of LOG_TRACE to trace events.
>> * The addition of clock DT nodes for our uart and ethernet.
>>
>> This also includes some preliminary work for the H extension patches,
>> but does not include the H extension patches as I haven't had time to
>> review them yet.
>>
>> This passes my OE boot test on 32-bit and 64-bit virt machines, as well
>> as a 64-bit upstream Linux boot on the sifive_u machine.
>>
>
> Hi; this fails 'make check' on all platforms:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=riscv32-softmmu/qemu-system-riscv32
> QTEST_QEMU_IMG=qemu-img t
> ests/qom-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="qom-test"
> PASS 1 qom-test /riscv32/qom/spike
> PASS 2 qom-test /riscv32/qom/virt
> PASS 3 qom-test /riscv32/qom/none
> PASS 4 qom-test /riscv32/qom/spike_v1.10
> qemu-system-riscv32: Invalid SMP CPUs 1. The min CPUs supported by
> machine 'sifive_u' is 2
> socket_accept failed: Resource temporarily unavailable
> **
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:266:qtest_init_without_qmp_handshake:
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> /home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:135:
> kill_qemu() tried to terminate QEMU process but encountered exit
> status 1
> ERROR - Bail out!
> ERROR:/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:266:qtest_init_without_qmp_handshake:
> assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
> Aborted (core dumped)
> /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:900:
> recipe for target 'check-qtest-riscv32' failed

Sorry about that, I ran the tests on the wrong branch.  I'll submit another PR 
with the issue fixed.

