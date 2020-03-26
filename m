Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA730C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:43:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E7220714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 15:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QrrddaN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E7220714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHUfI-0001mr-IK
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 11:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHUeP-0001E1-CS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHUeO-00052X-1X
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:42:33 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:39340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHUeN-000527-H5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 11:42:31 -0400
Received: by mail-oi1-x22b.google.com with SMTP id d63so5845787oig.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 08:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hnnfRy54DWX9DxViCYc+DrC/eh0RkZhWUUe0+ujrXtU=;
 b=QrrddaN6IbawhfOEmqTMSzUBE25UH2WpG/KE6N4kVRmIwA0kIzpzwE2Gh6oveMHuha
 SWuY9yDFSkqF+hsSecG+aeLKe8cjJS/Ej3j0EDe+DVRzCI/Toq8RIll4ctp5wlnh984F
 Ov8KRsI45uLqYrppng/bpeJnYg8tZhwualQhvtpRotFklVLnVF1J5nwXj9+Tw8DW0diK
 RUEaV9HARNIGYbezijDD9kQ6VKLzcdJMpPer3EHsABrkVLIegWSKKcbsLYH42Q06pD/D
 fObiukdILWvn0abHne8i9pL9jt+tWR7ULqNcF1XSZj444jYiIKQbbn7dFyrLkFV79S2a
 qQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hnnfRy54DWX9DxViCYc+DrC/eh0RkZhWUUe0+ujrXtU=;
 b=mSJMu4vFnKzNT1iVuR0+XVWwdNxkywfnJSCtW3oOP0V6liW22lxHgEaTHc9GMH/mc1
 aRV7OaIvVO+O1r5Z9CS6/KgTAdEQkR7kHBXtrYWbALVxxHj7B2ZwiNySoBH/A5AcM0s9
 u/1RMHtqSD/6YxAphgnvQ5HHNXR6ENV5DUKnsTXjxrpFbDOCJ/Jc906twBc2+UCyxXkc
 TvOMXU4c0/FwsShbdoRf8Gqt5r/AglCtmLL0/dsr0EONvVI78tGiPoiem6kF9HSJwWT7
 uwjD+lAVKhB1+/zgR6fAnkcU5ibLF6+wjXHP4ObhmYcTwOFOlA+738ou0d3QiX+lTBPV
 qdQw==
X-Gm-Message-State: ANhLgQ2vM4ILkQ6tXodgvjlnZ11kzmKv1jf6OVlwoCjJMbPvVbkI+e+U
 ZdN+LhziE5pUbyDg/GKs7ZW2IXTvsxjoQYnpBv7aeQ==
X-Google-Smtp-Source: ADFU+vutD1HIaZFRgfp+5q7DLbRAAO40ZmJy4Y1zpMnhpUmrtoaFDLpwkx5Y/oLjEd6oWex9daHfwNrw7BxZGwH7NR0=
X-Received: by 2002:aca:c608:: with SMTP id w8mr441245oif.163.1585237350768;
 Thu, 26 Mar 2020 08:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200326072352.2056553-1-laurent@vivier.eu>
In-Reply-To: <20200326072352.2056553-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 15:42:19 +0000
Message-ID: <CAFEAcA92zU5Dy9mZNTv1KtO_ApVRXvdxBZh1wsNGEyWAxAeLKQ@mail.gmail.com>
Subject: Re: [PULL 0/6] Linux user for 5.0 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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

On Thu, 26 Mar 2020 at 07:24, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 736cf607e40674776d752acc201f565723e86045:
>
>   Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to a52f5f87bece827a338d6eb3332e3def86fb9c33:
>
>   linux-user: Flush out implementation of gettimeofday (2020-03-26 08:08:54 +0100)
>
> ----------------------------------------------------------------
> Emulate x86_64 vsyscalls
> Fix syscall_nr.h cleanup
>
> ----------------------------------------------------------------

Still fails :-(

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
-L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
qemu: 0x40008117e9: unhandled CPU exception 0x101 - aborting
RAX=000000000000003f RBX=000000006ffffe34 RCX=0000004000800b18
RDX=0000004000813180
RSI=0000000000000064 RDI=0000004000800670 RBP=000000006fffff40
RSP=0000004000800668
R8 =0000000000000000 R9 =0000004000800b44 R10=0000004000801a18
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

thanks
-- PMM

