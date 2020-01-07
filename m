Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A18C32771
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE58A20715
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 01:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTKiszeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE58A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iodnL-0001rl-FH
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 20:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iodlF-000834-Ie
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 20:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iodlE-0000Ux-BM
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 20:34:21 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:42701)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iodlE-0000RR-3p; Mon, 06 Jan 2020 20:34:20 -0500
Received: by mail-lj1-x242.google.com with SMTP id y4so38596543ljj.9;
 Mon, 06 Jan 2020 17:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SX1LrpGOJgG+s8anXrwIhUm+BAt4k9XEhLkb8jJ4rto=;
 b=eTKiszeGb/h7xe4G1VuHcG3DRhIJOwVdP6/v6yJ2iI/XEjRm/15GEGKVMVxpHTQgO9
 k/8I0v7W4fzByU36vFaxu/Mw3K+jVG/SOm3umMfRC5SSXjlbC8RriZdRgzJ/l/w13Ube
 RekimDGRu4ii7/WXCtoUIQSsaqtsHw3zLJYpnSuaCGYL2LiEz0zbT5laFZAEbixNd5UG
 0h9h3lgCkaQPym2BBwT0vkH5g7nHJNi1aAmuCi8Z6VFIHI+0Gd4LhTu4d2p4MKcZRBKf
 a5uCW1sANIAi6Ow6OoWTbAvh9cWzr50QuatlJwD3OCzb3pQbno7D7My3HeEW25qag1x1
 Qa8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SX1LrpGOJgG+s8anXrwIhUm+BAt4k9XEhLkb8jJ4rto=;
 b=tmjafHmyjeMHFy/qFNWKY0Mr7OSAgGVpV7KsMh2cNpl4zVfxr3EMA1jcpuwWWVjBjz
 QbnQYy0PnuaP43kenI7rhx21t9E4LDiMg8q0ON4RkURkMZ+0W30DCLhKqtm3Tl1+3DK4
 oxUFvr3ryotLNwVfkPKQ5q2sz15u/60Gk8QEGTNDl1aWzOrKdLuFw23zGtYFlvs11YpQ
 p4iG4UhmTVfjijuO/n83GDhh3odQ/aVTXF/R5Ej8u24NinuJkHGbJFK5VkM7r6qcCKhx
 xqDxnYITqN+aU+bQx5C1vEUR38CLjnabmxMdMc0h06V1betoyPIkGiFz3iNGoxr2QvU0
 GRQg==
X-Gm-Message-State: APjAAAXI0UYezW5BWM8nmD+0JAZIwVfXuUqvbvHuniGARi9Ifrk382mx
 oAEdJRdOgB3pe5CGTx1yqY6PZ33EVkYZFxK+hSo=
X-Google-Smtp-Source: APXvYqysImuIVppB8EDrBbIVnXs7xMZuCyOt2jnC2bH5up35SREeNIeZOu/kOr22x0pmQvCtaEaedSPQaemjHAt5rEU=
X-Received: by 2002:a2e:9c04:: with SMTP id s4mr43647033lji.147.1578360858165; 
 Mon, 06 Jan 2020 17:34:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575914822.git.alistair.francis@wdc.com>
 <6a38e1a02e9a3d38fc311809772a152f0d99fd7a.1575914822.git.alistair.francis@wdc.com>
 <mhng-23785a15-6ae5-4a3a-8474-9bff5d0c2109@palmerdabbelt-glaptop>
In-Reply-To: <mhng-23785a15-6ae5-4a3a-8474-9bff5d0c2109@palmerdabbelt-glaptop>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jan 2020 17:33:51 -0800
Message-ID: <CAKmqyKNrjbcqo8EBt1_iOVmSXvkfyEj4qxGuAOkyB0tBWMxEsQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/36] target/riscv: Don't set write permissions on
 dirty PTEs
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
 Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 6, 2020 at 9:51 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 09 Dec 2019 10:10:45 PST (-0800), Alistair Francis wrote:
> > Setting write permission on dirty PTEs results in userspace inside a
> > Hypervisor guest (VU) becoming corrupted. This appears to be because it
> > ends up with write permission in the second stage translation in cases
> > where we aren't doing a store.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > ---
> >  target/riscv/cpu_helper.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 767c8762ac..0de3a468eb 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -344,10 +344,8 @@ restart:
> >              if ((pte & PTE_X)) {
> >                  *prot |= PAGE_EXEC;
> >              }
> > -            /* add write permission on stores or if the page is already dirty,
> > -               so that we TLB miss on later writes to update the dirty bit */
> > -            if ((pte & PTE_W) &&
> > -                    (access_type == MMU_DATA_STORE || (pte & PTE_D))) {
> > +            /* add write permission on stores */
> > +            if ((pte & PTE_W) && (access_type == MMU_DATA_STORE)) {
> >                  *prot |= PAGE_WRITE;
> >              }
> >              return TRANSLATE_SUCCESS;
>
> This is at least the second time I've spent a day or two trying to figure out
> what the right thing to do here is, and once again I'm lost.  I think what's
> really getting me is the original comment: why would this cause us to TLB miss,
> wouldn't it cause us to not TLB miss?
>
> Assuming that's the case, it seems to me more like there's some missing fence
> in whatever program is blowing up due to this -- maybe it's just reading from
> the page before marking it as read-only, then relying on writes to trap without
> doing the requisite fence.

Ok, let's drop this for now then. I'll reinvestigate and if this is
still needed I'll add a more detailed explanation.

Alistair

