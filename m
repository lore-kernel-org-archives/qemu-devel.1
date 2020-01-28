Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CAC33CB2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A972B214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A972B214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWcA-0006Jl-Og
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:33:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42934)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iwVSg-0006YA-LI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iwVSf-0000uc-70
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:19:42 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:41029)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iwVSe-0000pv-PF
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 13:19:41 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MElhb-1imGi92Wmh-00GJKw; Tue, 28 Jan 2020 19:19:22 +0100
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 0/4] linux-user: Fix some issues in termbits.h files
Message-ID: <994d96ac-ce43-9ff5-7212-eda6e12264fb@vivier.eu>
Date: Tue, 28 Jan 2020 19:19:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579227117-6310-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nDvJHc227Wpfv1exZCsxDLhBA9GSI2Uuytp/pj+RTz8bTL3Yg8x
 vPFbr0Ne+EqasmG4+RtHCtOrsONokgxGKY408Ii3D2DiGxbGcA5vjRmy2hzAxNUdnUPhX1i
 zJQlBey0cBNBSQeqq4vjnERlSUbLfWtc9y8irCLq6VSNnPk/1mUPm9iSJpmJphMK5LuGsw8
 wRvZ+1HrexfEOxjw5SNtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IzbYpwGHuUw=:9n9fm9tdPHyI3+tKIZdBfV
 7DgW9/MYAkZbQWs0qjfZ7K4yZXzM26IQSofW5Li00Z+jAQ+q0j20fKOp8LfwiCplKN6QJQTE0
 yFEyWxc7r2AuJ9zUNrZmfzpo0ddqORmDRqGrbDwUwC25CVypXJGRH0aNpm87hN0fLoqykItoE
 lUQqX+05eQYfyNEWYMW8PRmyReVv+saxBsKmV5xTzhHB/hljTE3meJkxKtqbm/AX4tcOa17rj
 /JzJmnz6e1zdcIsE0k1TjEW9iuKGl/9y/7pYMnjQdCH5gm2nNEf/kXGeO9klz9Py70qS4Ws1z
 wu+p5aK2v7yl88kwwBcA2w73goeWk7cun5NJM9M4R7fy0aws1yyNHrOJbhq5c4s2vYVkI9ufR
 t6KC1dlxFd8NzNdA+wDTw7OA9h/H7sxNPXjNcK6BuRwZaK6LiOpoz/SVFAlaCh/7pwCLI7cGu
 SEmkPzPoe733TzoAaIeAV1LJc9TP1PZ5dxofiERNya2s9rP7p1j/21y6grw/Q2RAC15+HX4KU
 SplES+ROPxie7+R/WMt4oyATutBZQnhlp3ioPV8SWRnczn/uxKbxVNL5x3mSTnoTRVRcfe+i0
 SVi1UjE1/wPol9899xCokyIOgsbBf6zdSZXDRhRSWOjvrMSq47W9ygtHWynFwLR1eq1TQy0yS
 jIo6lDFcnEUx1fWlRtBgk1nPn5CNmUNXJOjMwZK/fPZ/OCNI+CLFFM2TjzCUyRT/obixEQamJ
 pKo/CMcEkLKds8cjk+0aKkbI4KOrJnysbpBHQst3ECi3NmyXMS6kMSLf8gLIbto1eyBAP2NER
 SKQ36oxAQw2rHvHS5c+JV0GTpytab/50sDW36T5xt4JWuna2G0/WDovB0AVgNeeSCllDzDs
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/01/2020 à 03:11, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> This series is a spin-off of v5 of earlier series "linux-user: Misc
> patches for 5.0", that became too large to manage. I will submit the
> rest of that large series separately.
> 
> Files linux-user/<target>/termbits.h seem to be in a very bad shape:
> unsynchronized with kernel, containing wrong elements expressed in
> terms of host instead of target, many being updated wrt kernel
> content at various times, and on top of that all contain visually
> very ugly combinations of tabs and spaces.
> 
> This series attempts to fix great majority of issues in termbits.
> 
> Alpha's and mips' termbits.h were in the worst shape, missing large
> bits and pieces, and for them as complete as possible synchronization
> with kernel code is done - this constitutes the first two patches.
> 
> Xtensa's termbits.h contained the most elements wrongly expressed in
> terms of host instead of target, and that is the reason the changes
> in this file are placed in a separate, third, patch. Previous "R-B"
> given by Max Filippov was transferred to this patch only.
> 
> The fourth patch fixes remaining elements wrongly expressed in
> terms of host instead of target.
> 
> As an additional note, structures "serial_iso7816" and "serial_rs485"
> (at times mentioned as the third argument of certain ioctls) are
> platform-independant in kernel, and do not need "target_" variant
> in QEMU. Also, structure "winsize" (also appearing as the third
> ioctl's argument at times) is defined at multiple places in kernel
> (for several architectures) in kernel, but all such definitions are
> identical, and, therefore, it also does not need "target_" variant
> in QEMU.
> 
> A checkpatch warning related to "#if 0" in patch 2 is benign, and
> should be ignored.
> 
> Aleksandar Markovic (4):
>   linux-user: alpha: Synchronize termbits.h with kernel
>   linux-user: mips: Synchronize termbits.h with kernel
>   linux-user: xtensa: Fix some constants in termbits.h
>   linux-user: Fix some constants in remaining termbits.h
> 
>  linux-user/aarch64/termbits.h    |   4 +-
>  linux-user/alpha/termbits.h      |  82 ++++++++++++++--
>  linux-user/arm/termbits.h        |   4 +-
>  linux-user/cris/termbits.h       |   4 +-
>  linux-user/hppa/termbits.h       |   4 +-
>  linux-user/i386/termbits.h       |   4 +-
>  linux-user/m68k/termbits.h       |   4 +-
>  linux-user/microblaze/termbits.h |   4 +-
>  linux-user/mips/termbits.h       | 140 ++++++++++++++++----------
>  linux-user/nios2/termbits.h      |   4 +-
>  linux-user/openrisc/termbits.h   |  14 +--
>  linux-user/ppc/termbits.h        |   4 +-
>  linux-user/riscv/termbits.h      |   4 +-
>  linux-user/s390x/termbits.h      |  26 ++---
>  linux-user/sh4/termbits.h        |   4 +-
>  linux-user/sparc/termbits.h      |   4 +-
>  linux-user/sparc64/termbits.h    |   4 +-
>  linux-user/tilegx/termbits.h     |  12 ++-
>  linux-user/x86_64/termbits.h     |  26 +++--
>  linux-user/xtensa/termbits.h     | 207 +++++++++++++++++++++------------------
>  20 files changed, 353 insertions(+), 206 deletions(-)
> 

I think we should first introduce a linux-user/generic/termbits.h as we
have an asm-generic/termbits.h in the kernel and use it with all the
targets except alpha, mips, hppa, sparc and xtensa.

I think this linux-user/generic/termbits.h could be copied from
linux-user/openrisc/termbits.h (without the ioctl definitions)

Then you could update the remaining ones.

Thanks,
Laurent

