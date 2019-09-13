Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5AC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F1B20CC7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHiPHSI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F1B20CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8hj8-0001gG-GW
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 05:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i8hi6-0000wp-JH
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:17:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i8hi5-0003lI-2h
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:17:46 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:36060)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i8hi4-0003ku-Su
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 05:17:45 -0400
Received: by mail-ot1-x336.google.com with SMTP id 67so28777951oto.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HV9iHkqPa3w30wPUgeODrMfhoUZuB5nZhqfuF9+Wo4U=;
 b=tHiPHSI1BJH/TieF6geOYpFY0S5ozYwQB+NQBxmb0FLDsx8BJUpHCzXMq5hrTp7yjf
 F5+QteVyt6cgX48nuOG5fN5Pbp/brLbNN7UVgpAAIKcUfk/zP9JZxTSQeeaHpZWJHBNQ
 akoqDHgHzGFfXatCd/nAkrH7cImhacUoXCG+f58IgoiolhG+r9JPgFj66YOBkJPjxvia
 lDzgtera9s708zUfUORroKCYetfuoFwTD23wx6XJ9n2dsCmD06c7rGjqwBUouojZvvUy
 tZHdLdeTzu2eGsb/FoV+1ai+Zvexyh/VmJTlOZYT2hHlJo3XcAcdzpdRoi2WRZCB05qZ
 oCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HV9iHkqPa3w30wPUgeODrMfhoUZuB5nZhqfuF9+Wo4U=;
 b=OecSq141q1lnvtFN9KMcOiSeOJA+qSUZyMP8bvtgw5XSiuxm/ISaIONbW/JqRBYyjb
 rLjI+VuTt/Cqo0hEJ6pYmHsHH6UeKCbcZo+FHWtHaLYJOdVf42htyipbSak+8SiH8pg1
 7MgV9LxeZGCsgsTZev0LlBcYqtBGbbc/a1wFKD3qPgPayPXCmMKmp5l3LVIVkv3joXVG
 GWoWA7axYGrXak4vN5/o7oojE5KnxLUt5bY5+WestYq1V4e1bR11iLyInyXvp7W0O+6Q
 F+kH/2on4JzWaxiVbl4/X/zYF9AJ8EzFGT5cPrEwaxWQkg0zcXDeQ2N4PztoPjk/IZr6
 t2/g==
X-Gm-Message-State: APjAAAV2dHW8toLc9YXWzJctJ21eP+/8HCSx62xLg9TDnpuXYKDznSuf
 1CQz9cXjt48OZrLA1u8WpxxrPV8hwUDejVjBeW4OdA==
X-Google-Smtp-Source: APXvYqziwHoNlxdTRlA4bg4pwSqvhC205CW4CXYRAScrAQGUvlnaEgIw9zORrmGKfP1/KIE0Itfdjb5KIB4xpS3fkpM=
X-Received: by 2002:a9d:68d6:: with SMTP id i22mr31233930oto.232.1568366263898; 
 Fri, 13 Sep 2019 02:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190910190513.21160-1-palmer@sifive.com>
In-Reply-To: <20190910190513.21160-1-palmer@sifive.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Sep 2019 10:17:32 +0100
Message-ID: <CAFEAcA94wuW4koj9+v4bbNH+omZQfqkw=JMUjvyDwbu_Eevgag@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::336
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 at 09:24, Palmer Dabbelt <palmer@sifive.com> wrote:
>
> The following changes since commit 89ea03a7dc83ca36b670ba7f787802791fcb04b1:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/m68k-pull-2019-09-07' into staging (2019-09-09 09:48:34 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/palmer-dabbelt/qemu.git tags/riscv-for-master-4.2-sf1
>
> for you to fetch changes up to 1b2d0961bfaaa2db3a237f53273527b6c5e3498a:
>
>   target/riscv: Use TB_FLAGS_MSTATUS_FS for floating point (2019-09-10 06:08:42 -0700)
>
> ----------------------------------------------------------------
> RISC-V Patches for the 4.2 Soft Freeze, Part 1
>
> This contains quite a few patches that I'd like to target for 4.2.
> They're mostly emulation fixes for the sifive_u board, which now much
> more closely matches the hardware and can therefor run the same fireware
> as what gets loaded onto the board.  Additional user-visible
> improvements include:
>
> * support for loading initrd files from the command line into Linux, via
>   /chosen/linux,initrd-{start,end} device tree nodes.
> * The conversion of LOG_TRACE to trace events.
> * The addition of clock DT nodes for our uart and ethernet.
>
> This also includes some preliminary work for the H extension patches,
> but does not include the H extension patches as I haven't had time to
> review them yet.
>
> This passes my OE boot test on 32-bit and 64-bit virt machines, as well
> as a 64-bit upstream Linux boot on the sifive_u machine.
>

Hi; this fails 'make check' on all platforms:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
QTEST_QEMU_BINARY=riscv32-softmmu/qemu-system-riscv32
QTEST_QEMU_IMG=qemu-img t
ests/qom-test -m=quick -k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="qom-test"
PASS 1 qom-test /riscv32/qom/spike
PASS 2 qom-test /riscv32/qom/virt
PASS 3 qom-test /riscv32/qom/none
PASS 4 qom-test /riscv32/qom/spike_v1.10
qemu-system-riscv32: Invalid SMP CPUs 1. The min CPUs supported by
machine 'sifive_u' is 2
socket_accept failed: Resource temporarily unavailable
**
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:266:qtest_init_without_qmp_handshake:
assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:135:
kill_qemu() tried to terminate QEMU process but encountered exit
status 1
ERROR - Bail out!
ERROR:/home/petmay01/linaro/qemu-for-merges/tests/libqtest.c:266:qtest_init_without_qmp_handshake:
assertion failed: (s->fd >= 0 && s->qmp_fd >= 0)
Aborted (core dumped)
/home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:900:
recipe for target 'check-qtest-riscv32' failed

thanks
-- PMM

