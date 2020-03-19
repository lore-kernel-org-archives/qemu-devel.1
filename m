Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF30C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C32B20774
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 20:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYUVEMJX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C32B20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jF248-0005d1-Gp
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 16:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jF230-0004MR-Ty
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:45:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jF22z-0003s6-M1
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:45:46 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:36601)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jF22z-0003rp-G7
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 16:45:45 -0400
Received: by mail-oi1-x231.google.com with SMTP id k18so4247549oib.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 13:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u8i+STaYIVMKJpdw0yrvzes4GxekyH6+mEdvx45gyUE=;
 b=UYUVEMJXZboEpZAUnNLpweVgdpo4v6tQCjjtN/bRj0hdS1zmGi1+RYYPpO8XEi4nTN
 SbKQFVwT8WNRQVh1Q4KmgstPP09MVGcBSTXIsGncSEJH8VqEiz2mB5geIQGgkPGHPElT
 mhYK6n/OJ88oo4MHOrbRi9tmiTgdjEzJYS6A6KB25248UNLmBeejr3keWAl0hlJ+GEtY
 jmtyYDvhp4QrCaFfpH9Cb6wkQcHAT6TZKvP1nZR8HY8DnO7AnzxPBF6Zp250IDkilqaX
 ZnYQLLnvzUStzI5QAIm4ekntNj/z52wUiHnmNANkmpG8nJXDW8o9lxLtjMFmgeiXyMKl
 UbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u8i+STaYIVMKJpdw0yrvzes4GxekyH6+mEdvx45gyUE=;
 b=HGqsH4GvPIRfr+LlBtK+LP+qFnk8w/Y4rDDNALQ6gO0VQkq9Hyw06q1pKOhKGd7va0
 vMkLgM+uUenXVZNi0hVYUfokbX/rPhL1MZHm9v/HJhQlgg0ubW/SPBmqu4zt21fP+SLz
 Qo9sXWbTL94SU7ux0LPAl1xgXE9y7ImBVQ+LxNRG8U7GvJihDvMKJyMadIDIVQuxengq
 virn5IjJil3J0jfQ8iqhS4TkRqW5AjQzvqthQvmuaAAMPOXpI2zEOuyjI1IZzaR90LML
 pdFCZ41/rIeDIQCLlyWoOiI1LoEllCoPH8elEQrSzynzPU2JvlaiNByxV9R4QcJzVXhH
 eUcg==
X-Gm-Message-State: ANhLgQ3q5l5UuJFUS2YAwRrepU0D3Zyn/BsnVD9fxPs66vsfesikn8WZ
 d+DUDJxvRJmuJAAHaxtI3uSeHXGKa6njHaSt8f9GRQ==
X-Google-Smtp-Source: ADFU+vtxT4gsdf4BmMJYz2x7lBvHIeiXx2Y7YzWjC89o6urJ5vQBdvBBDO9r9BHBjP26FVMlyvyQDsnqBJmRstzvGEs=
X-Received: by 2002:aca:190f:: with SMTP id l15mr3721504oii.48.1584650744411; 
 Thu, 19 Mar 2020 13:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200319092627.51487-1-laurent@vivier.eu>
In-Reply-To: <20200319092627.51487-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Mar 2020 20:45:33 +0000
Message-ID: <CAFEAcA_rHYVD35BGjHLv9vbevj9dX8FM+H-ctiYVvwiwrkabyg@mail.gmail.com>
Subject: Re: [PULL v3 00/16] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 at 09:29, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 373c7068dd610e97f0b551b5a6d0a27cd6da4506:
>
>   qemu.nsi: Install Sphinx documentation (2020-03-09 16:45:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to c91518bb0649f09e2c636790603907ef93ea95d4:
>
>   linux-user, openrisc: sync syscall numbers with kernel v5.5 (2020-03-19 09:22:21 +0100)
>
> ----------------------------------------------------------------
> update syscall numbers to linux 5.5 (with scripts)
> add futex_time64/clock_gettime64/clock_settime64
> add AT_EXECFN
> Emulate x86_64 vsyscalls
>
> v3: remove syscall.tbl series
> v2: guard copy_to_user_timezone() with TARGET_NR_gettimeofday
>     remove "Support futex_time64" patch
>     guard sys_futex with TARGET_NR_exit
>
> ----------------------------------------------------------------

Still fails:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
-L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting
RAX=000000000000003f RBX=000000006ffffe34 RCX=0000004000800b18
RDX=0000004000813180
RSI=0000000000000064 RDI=0000004000800670 RBP=000000006fffff40
RSP=0000004000800668
R8 =0000000000000000 R9 =0000004000800b45 R10=0000004000801a18
R11=0000004000801260
R12=00000040008008c0 R13=0000000000000008 R14=0000000000400040
R15=00000040008032d0
RIP=00000040008117e9 RFL=00000246 [---Z-P-] CPL=3 II=0 A20=1 SMM=0 HLT=0
ES =0000 0000000000000000 00000000 00000000
CS =0033 0000000000000000 ffffffff 00effb00 DPL=3 CS64 [-RA]
SS =002b 0000000000000000 ffffffff 00cff300 DPL=3 DS   [-WA]
DS =0000 0000000000000000 00000000 00000000
FS =0000 0000000000000000 00000000 00000000
GS =0000 0000000000000000 00000000 00000000
LDT=0000 0000000000000000 0000ffff 00008200 DPL=0 LDT
TR =0000 0000000000000000 0000ffff 00008b00 DPL=0 TSS64-busy
GDT=     000000400091a000 0000007f
IDT=     0000004000919000 000001ff
CR0=80010001 CR2=0000000000000000 CR3=0000000000000000 CR4=00000220
DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
DR3=0000000000000000
DR6=00000000ffff0ff0 DR7=0000000000000400
EFER=0000000000000500
Makefile:6: recipe for target 'test' failed
make: *** [test] Error 127

thanks
-- PMM

