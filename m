Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FA4C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57845218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 12:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57845218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2DqW-0001zi-JJ
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 07:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j2Dph-00016F-MT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j2Dpg-0006ur-EQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:43:05 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44835)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j2Dpg-0006t2-4y
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 07:43:04 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N5n81-1jZcy41Sln-017Bwn; Thu, 13 Feb 2020 13:42:47 +0100
Subject: Re: [PATCH v3 0/9] linux-user: Update syscall numbers to kernel 5.5
 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1581596954-2305-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ba093983-a40e-13af-0f11-795b9dd90693@vivier.eu>
Date: Thu, 13 Feb 2020 13:42:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1581596954-2305-1-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+g6T/uxcaL78ElaqYfeyWTt5FG9EhFTF3d4Finv/070d2tOhoFx
 6FuL1F0IYKPjrIv+JspL30GSypYefaB0Ckiv4+/Var9Bn1dOUx9RVDUgiP3TEw6JKnI/pRL
 ZPODlB5HdsHb3ZqkXpd9hEdqXAQkHsBswF5o/OoLzIuyVehe/PFhNnwjNTbNcAT7DxjzoeF
 opXIuvObu+mMGvkQdq01g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N+men0ddEGc=:XbVrcOg5DtvdBDOmvKjQPi
 vcspA9ZzjprIOhL+IT94fH4PTHoixvGT1z6pha0JNjKxY9T67jXJnyMzgAAQjY3jC+/x1yP1d
 TxXIBYpd292JC0foftfVnDyjPnPxLKBR6DP6bFuy4bpbiGCjajkPHjHR0IMD1I6BZTwHhcg+W
 SlwdSMqYmMMHY3s3O/MtP2tvyOPnkFPNYAKfj45L5ZofdFpuSaHXF4Hpud6CQyD0itbXBbcls
 /Rjb8LslHMY6MuHnWMiK/0d7+U7X4MKAxZTAWv1G0uwuH8SXXxxKZn1I82mVIiVs5CVQKUUrH
 LaPxzw2IyYsOUCk81WGBJy2Q9XQoXTTRaJ3gGHOUK1+t9NPCDem2XjTRfAZl6bbnIt6DBmdoT
 e+Uxo6NrzgptCXcLPfwIK1e59Y6RiddYpyc/yh56+jURk2jQDQnaxXSt9TzfeX14yg1L6dOP/
 J45tPCYkWqOfw1eHWXKMbp3izcFKh4qwTKX4G5f24tpNmvuGLein4gtV/07YT5DYloky5vUu3
 DXpIbtdlSPVxD8iLjRLct3+y7zSirt7IGmP+cwc3UE+OVa7jhFKLb+oKTVxKCpZZJ3fA/zaqL
 X8ectcPlokafjyd9onF26kvWrdTaIkWrb5Wj10oZ/eNL3IbtqbdEBbcT4YwCXzqh447jAK2j6
 2woMLhEscvvnuV/A93n3buJMDJr0V9/8MCwlb1nNw8YyXsR0lU8K7H9bEuFyWn+YBUohVcbDq
 PYi70Su7ey1T5+k04C5O6hTYsdRuix5bBDC1Gw77MQN9WOo9rvWwxcYsNssSI7eRy0FFVh2Re
 l668s/2SMwSgXDOsFixsII4hcRZdpKAoBXemYKn/Ux9oKom4odmnc/bhg5DH5DHy5D/rKZr
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 13/02/2020 à 13:29, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> v2->v3:
> 
>   - corrected number of arguments for two mips syscalls
> 
> v1->v2:
> 
>   - corrected mips parts based on Laurent's review
> 
> This series is a spin-off of another larger linux-user series
> that become too large to handle, hence these patches related to
> syscall numbers are now in this, separate, series.
> 
> This series covers updating syscall numbers defined in the following
> files:
> 
>   - linux-user/alpha/syscall_nr.h
>   - linux-user/arm/syscall_nr.h
>   - linux-user/m68k/syscall_nr.h
>   - linux-user/microblaze/syscall_nr.h
>   - linux-user/mips/cpu_loop.c
>   - linux-user/mips/syscall_nr.h
>   - linux-user/mips64/syscall_nr.h
>   - linux-user/sh4/syscall_nr.h
>   - linux-user/x86_64/syscall_nr.h
>   - linux-user/xtensa/syscall_nr.h
> 
> ----------------------------------------------------------------------
> 
> Aleksandar Markovic (9):
>   linux-user: alpha: Update syscall numbers to kernel 5.5 level
>   linux-user: arm: Update syscall numbers to kernel 5.5 level
>   linux-user: m68k: Update syscall numbers to kernel 5.5 level
>   linux-user: microblaze: Update syscall numbers to kernel 5.5 level
>   linux-user: mips: Update syscall numbers to kernel 5.5 level
>   linux-user: sh4: Update syscall numbers to kernel 5.5 level
>   linux-user: x86_64: Update syscall numbers to kernel 5.5 level
>   linux-user: xtensa: Update syscall numbers to kernel 5.5 level
>   linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count
> 
>  linux-user/alpha/syscall_nr.h      | 35 ++++++++++++++++
>  linux-user/arm/syscall_nr.h        | 44 ++++++++++++++++++++
>  linux-user/m68k/syscall_nr.h       | 50 ++++++++++++++++++++++-
>  linux-user/microblaze/syscall_nr.h | 45 +++++++++++++++++++++
>  linux-user/mips/syscall_nr.h       | 45 +++++++++++++++++++++
>  linux-user/mips64/syscall_nr.h     | 50 ++++++++++++++++++++++-
>  linux-user/sh4/syscall_nr.h        | 48 ++++++++++++++++++++++
>  linux-user/x86_64/syscall_nr.h     | 24 +++++++++++
>  linux-user/xtensa/syscall_nr.h     | 36 ++++++++++++++++-
>  linux-user/mips/cpu_loop.c         | 83 +++++++++++++++++++++++++++++++++++++-
>  10 files changed, 454 insertions(+), 6 deletions(-)
> 

I've applied the series to my linux-user for 5.0 branch.

Thanks,
Laurent

