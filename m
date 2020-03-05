Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE43C3F2D2
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:01:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B57C20870
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 17:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeJFAvRp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B57C20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tsE-0003yy-NJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 12:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j9tla-0000ps-M9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j9tlZ-0000me-M9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:54:34 -0500
Received: from mail-vk1-xa42.google.com ([2607:f8b0:4864:20::a42]:43861)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j9tlW-0000kj-6f; Thu, 05 Mar 2020 11:54:30 -0500
Received: by mail-vk1-xa42.google.com with SMTP id o2so1792280vka.10;
 Thu, 05 Mar 2020 08:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BavO3QYE17WJtn7dKZJxqCSrHa4W4PO4dngsSU3YGOA=;
 b=LeJFAvRpBeekw+8Sxk1Yc9EVHMPZbVEKdm1d5rKLLgzsBzeHYE4l6htJrRqwoGehEs
 qq8+Lxp0pvaJOgpeoUaIezyszE//fG9YkzifIjr6g7aCWyjcdwdd8ybVipCVCWWbemSq
 3rRbYI93pOSz5ZI2EwZhk33SBr4zkT4w6KckOLNaWzqM2Ba/O33MeDI9cBMThngy9KIT
 Sg3297ldmdxofsHvcfoY/gJV6NdSstw2pSvGICIn0vgO9a+6C/Jbm5SmqxpE/OE/xi4m
 Gw7XzPktyqdmvL9NEMtrsNyM9CHCrgNBG+o251dutgWpEcTVN4rJMgo3TOZdNZ7YRt0D
 FPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BavO3QYE17WJtn7dKZJxqCSrHa4W4PO4dngsSU3YGOA=;
 b=o8aYDXOaFXZN4BmYwfdTDxMNQ7XF7573F5ZRiQXGhzV+pzN3wSzoFRpIgmGjUHxKyB
 CrEP5A6wPWq0q2PJPnj3XV0iZoCT7pcQAIAuZx6DmaM7egDbZDronVzUEacpMSzkUleF
 RTCniicg4ap1fVHEBa3Qwv2xLCCExy9MWEmLImDoAcd/I8KyINxlv1gaOl7EU+7gd1cu
 PyRjlEmNho0RWMb9OSyzpTgkVriGk8FVZoLUr1Jr94vUoE17a/rj3XAdePahxIuERiyt
 DZ5tJkNBG1HDwYqD3DTLX69kdTbkq2J2XkEXYXxhOV2Fx/fBHoD/GF8VY4Y5ZWXNHKol
 JgTQ==
X-Gm-Message-State: ANhLgQ01aVQ4CU4JtNebBcyujIs+PkULR6wyfQiqE1SaI/nqApT1R/D3
 0rwCGeGjqu2v48p0NL7fRXHePCcconDHYi6aPOw=
X-Google-Smtp-Source: ADFU+vv/1IwDhGNAtivVyHztV3wmZ6LrKlPauK+nP3aSzZaHHrUsnde+L3B/L6LN2q2vkGHAVX0ocsmmTToqblO1CYg=
X-Received: by 2002:a1f:1f50:: with SMTP id f77mr5359112vkf.37.1583427269502; 
 Thu, 05 Mar 2020 08:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20200303004848.136788-1-palmerdabbelt@google.com>
 <20200303004848.136788-5-palmerdabbelt@google.com>
 <CAFEAcA9gHNXfGutEZiW-PYJbhdUZEd-dPDp8iwO-Ni_cSD9gZw@mail.gmail.com>
In-Reply-To: <CAFEAcA9gHNXfGutEZiW-PYJbhdUZEd-dPDp8iwO-Ni_cSD9gZw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 5 Mar 2020 08:46:47 -0800
Message-ID: <CAKmqyKOrw_sP=8E=DbpPJPs_5zgBq6df8O1FYD9vwq4DfLLwzw@mail.gmail.com>
Subject: Re: [PULL 04/38] target/riscv: Add support for the new execption
 numbers
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::a42
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
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Mar 5, 2020 at 8:52 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 3 Mar 2020 at 00:49, Palmer Dabbelt <palmerdabbelt@google.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The v0.5 Hypervisor spec add new execption numbers, let's add support
> > for those.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  target/riscv/cpu.c        |  8 ++++++++
> >  target/riscv/cpu_bits.h   | 35 +++++++++++++++++++----------------
> >  target/riscv/cpu_helper.c |  7 +++++--
> >  target/riscv/csr.c        |  7 +++++--
> >  4 files changed, 37 insertions(+), 20 deletions(-)
> >
> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > index efbd676edb..2f62f5ea19 100644
> > --- a/target/riscv/cpu.c
> > +++ b/target/riscv/cpu.c
> > @@ -67,6 +67,14 @@ const char * const riscv_excp_names[] = {
> >      "load_page_fault",
> >      "reserved",
> >      "store_page_fault"
> > +    "reserved",
>
> Hi; Coverity (CID 1420223) notice that there's no comma
> after "store_page_fault", which means that there's been
> a concatenation of that string and the following "reserved".
> Could one of you send a patch which adds the missing comma?
>
> > +    "reserved",
> > +    "reserved",
> > +    "reserved",
> > +    "guest_exec_page_fault",
> > +    "guest_load_page_fault",
> > +    "reserved",
> > +    "guest_store_page_fault"
>
> You might also like to add a trailing comma here to avoid
> the bug happening again in future.

Thanks for the report Peter, I'll send a patch.

Alistair

>
> >  };
> >
>
> thanks
> -- PMM
>

