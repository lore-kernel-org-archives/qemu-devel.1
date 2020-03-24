Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D981C4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EB120658
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwVHomYN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EB120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGiZQ-00058r-8S
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41105)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGiY2-0003wp-7H
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGiY0-0007c3-Ml
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:45 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:38182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGiY0-0007YH-7U
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:20:44 -0400
Received: by mail-oi1-x231.google.com with SMTP id w2so7248308oic.5
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 05:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xWkzAhYaSgs60v8fyWL2tIxcSt403gxRx1JwyLQPfS0=;
 b=SwVHomYNyzZQcci0EFstj5Lb9Zk2lq6+8ZWxpAoGO1o4P8EKll4sBxwrZSK5vGP92b
 1z34reLaTH6FIFZnor4OhrlBcGNn8csaSrckxxpH39NmsiDCrWEPKNVh0MrYnWiS61GS
 yzC8Li5Qvu+yLYusbnQQQmSymXv/wxvQIuC/p273Rcwnll/uzpg/P68SbfV3dkgseagE
 Bkd99gq/ooPbnExtbocUqSf/WeKf9SwajNVBvM+ud+X/q6mTYLsE7HcrevrL6OazW+fB
 GCsZ3LuBVwvbyTjnLM9UmmOqrT6Imc54N9o9pM74+GFU7wtbMF769QU/7XhMdWDzsHsU
 LkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xWkzAhYaSgs60v8fyWL2tIxcSt403gxRx1JwyLQPfS0=;
 b=s4s/nKbdDNtc7deHqfaEX1r5x0M9w7EZ50uXbEfRzySBev64UEyrGfjrZhq9coKP5O
 uQyvv48I7mTT8fNhGxmuJ/bpXGxb+gGYZkI27/mZMyHMt0+vgQYhGv/zttqVH2o885Lm
 eODJpojlReNm93POlzp6E6b982XBFIF166P+WP9MSzkZegtH5aqSCZeRwe/onvpzP4q1
 WjDfwDRKRWX5YXLdW97ITKrzuYO4P90xBnxQNAfWQ3bC3Hz6TFPpYYbuMV46fQP+Qu+S
 jrh2oyz2rCtAIB0kNfGucRHMlIsATdFcnawzuUiGsQwOCe2YcLwmsfZjfVWMRGTiLt9R
 MtWQ==
X-Gm-Message-State: ANhLgQ0RuUKofs5CEasIhngDCm2XO6jiBZg+j6pSNRXjiWNSM+R837bw
 Ojs4etqXN1VSPEE1hizx3rldfgQ/dfd/hKfExp+XsA==
X-Google-Smtp-Source: ADFU+vtlZdWlGq7C+LMVYW31keTXQFg5fehAJetbpJ/kDcmp4SKEXv3t7VDaVBUxEm9BDmuTj3LVYTSTlOnUrIxyeq0=
X-Received: by 2002:aca:c608:: with SMTP id w8mr3198399oif.163.1585052443042; 
 Tue, 24 Mar 2020 05:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200324111700.595531-1-laurent@vivier.eu>
In-Reply-To: <20200324111700.595531-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 12:20:31 +0000
Message-ID: <CAFEAcA9-gYfwNCKLkbbbTx1+xSG6E2ErH0NZ=9JPQwNJvwmVzQ@mail.gmail.com>
Subject: Re: [PULL v2 0/5] Linux user for 5.0 patches
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

On Tue, 24 Mar 2020 at 11:18, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 29e0855c5af62bbb0b0b6fed792e004dad92ba95:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/slirp-pull-request' into staging (2020-03-22 21:00:38 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-5.0-pull-request
>
> for you to fetch changes up to eec24827f7e67ead39349bb78597da566f854a4c:
>
>   linux-user: Flush out implementation of gettimeofday (2020-03-24 12:04:14 +0100)
>
> ----------------------------------------------------------------
> Emulate x86_64 vsyscall
>
> v2: remove trailing space
>
> ----------------------------------------------------------------
>
> Richard Henderson (5):
>   target/i386: Renumber EXCP_SYSCALL
>   linux-user/i386: Split out gen_signal
>   linux-user/i386: Emulate x86_64 vsyscalls
>   linux-user: Add x86_64 vsyscall page to /proc/self/maps
>   linux-user: Flush out implementation of gettimeofday

Fails as before:

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
make: Leaving directory '/home/petmay01/linaro/linux-user-test-0.3'

thanks
-- PMM

