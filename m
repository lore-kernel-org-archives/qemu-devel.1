Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D65C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BC5820872
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 05:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JU57ynTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BC5820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCd2d-0006xe-7K
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 01:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iCczW-0004SW-85
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iCczU-0003Yt-VQ
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 01:03:57 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:43725)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iCczU-0003Uc-Jl; Tue, 24 Sep 2019 01:03:56 -0400
Received: by mail-lj1-x244.google.com with SMTP id n14so442514ljj.10;
 Mon, 23 Sep 2019 22:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMy0hE377EdIQzisWHOHk32ZjceNv6dInUCOb3CZ2FM=;
 b=JU57ynTzcQjD3acUNVuM4fsZi+CtA/cpf5czweTMeIXmUXYjesgHngCqy6WJsNTn5g
 A30v/LEjwZtCLIJAk2SR39AY39bQq4aABP6eepBeITgc/V67lwSYyNPne0jRuTEjXQpC
 mKutqvJVwRLBnSVoY1K8GghkTNOTZBhM92vVxifugKMZH8l/Ms9EUUrp5hTCekUi5wkv
 hNap+Qd3Pbtb/ocxoiVikQLqwdnilmtkmYTgG7CCWnzdkABQJvfWpL3VJg2azzxpzmuy
 e5paspT9u/P1/7a7op99bw5UjqrAKMCshvNQmFegQ/eHT31jvFBEaw6eNS2aFxJHrPR9
 Fx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMy0hE377EdIQzisWHOHk32ZjceNv6dInUCOb3CZ2FM=;
 b=bZULb/ws0pMX0+jAcUD0QJSLRqs/kfV7kxQ/j+PW9CBt/fBYT5iPrDsRp8vOq1f2Kx
 bx8j988mOalWmogW6MFDTsKbjTzsijEfIS8dHZw82tDTiWofPrcgffvdiD7DpSbN/I/Q
 ffdOb+SAxtE5x8P8IgGJIIFx6LxyJsfQExWh9avOPUF2mDmaBImT8fBonoXTNChQbLGY
 FvfVGigJqZiXlVscjpfgbRKaVRYjfdDlbrHNESTr1MzQYLxsP1og78QwFxo8oxmvK2Sx
 mfcMv4nRyB1CfUOdwhW20U8l8s181KDcnRDousGHlPMFP5aXetxOD5KMXOKIDdvK1dJ7
 4g2Q==
X-Gm-Message-State: APjAAAW5X7heqmlNJg0F2xsVm/2ggL2GFSBpRqPqwiv47nhbWfjoGFUH
 YBoGjAX6oFu0+PdL+tmBFLM8tFlUyeJB4Ruor9s=
X-Google-Smtp-Source: APXvYqwAXTnHIjwRR6ENN1i0qIqtB+OQPn1AypUIBJgpsDy2S8T4/AZpFw9H0ly/fOPbZQwOa0kFFvt+++1KYbcKkIo=
X-Received: by 2002:a2e:91c7:: with SMTP id u7mr594338ljg.146.1569301435037;
 Mon, 23 Sep 2019 22:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <1569301232-7128-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1569301232-7128-1-git-send-email-guoren@kernel.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Sep 2019 22:03:27 -0700
Message-ID: <CAKmqyKO9=FuqsEDbuA_iw3+W8fpcGxudxV76vu2ZucRLeExQUA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Bugfix reserved bits in PTE for RV64
To: guoren@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Guo Ren <ren_guo@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 23, 2019 at 10:01 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Highest 10 bits of PTE are reserved in riscv-privileged, ref: [1], so we
> need to ignore them. They can not be a part of ppn.
>
> 1: The RISC-V Instruction Set Manual, Volume II: Privileged Architecture
>    4.4 Sv39: Page-Based 39-bit Virtual-Memory System
>    4.5 Sv48: Page-Based 48-bit Virtual-Memory System
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 87dd6a6..3c5e8f6 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -260,6 +260,7 @@ restart:
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>  #elif defined(TARGET_RISCV64)
>          target_ulong pte = ldq_phys(cs->as, pte_addr);
> +        pte = pte << 10 >> 10;

You can just AND with a mask instead of shifting both directions.

Alistair

>  #endif
>          hwaddr ppn = pte >> PTE_PPN_SHIFT;
>
> --
> 2.7.4
>

