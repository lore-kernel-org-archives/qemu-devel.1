Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87782C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C7A20771
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 03:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lo4TvUut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C7A20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyRnt-0000kq-Kt
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 23:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jyRmq-0008Rx-Ub
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:20:48 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jyRmp-0008SZ-6r
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 23:20:48 -0400
Received: by mail-ot1-x344.google.com with SMTP id t18so3387041otq.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BNXpHc2EtQBwYYXOJAAWmqMrbRXKhB/87zHefCPJioY=;
 b=lo4TvUutv+35DdpdN30nF7xhB6x+7l/4n2BGuldG2nxulVskezugQ9EO7hpgeITEfw
 SMVauKqc84Y3PQCm7WrdZuB9uiZ+H4ZBuj4bxmtn2opBjC9qblrbXIMLLNQRtiGZx8OE
 JS2KkWoxKEg8owk0656dWLMOTlvszrY+B0jH97e1jNqTZOHettG8Xf9x6jZ91sDNWxEr
 DrbuaaMnNx9m0weF+qzzsz+lcr8B0OcQTAhHXs1RU4p/LPktaqnFIoncYNk/Aobjrmis
 wF8S7q+3Nm2Jhn8WQSxlHBD8nA2I0P2R8x9vFN7PE4xX/NMRaFiigZyIyiALKQaSZhTL
 VfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BNXpHc2EtQBwYYXOJAAWmqMrbRXKhB/87zHefCPJioY=;
 b=cEF3GCZdGbOQ1LrzkBAPb5AvtDDeowdDIvP7AHUt05oktnZrsXYJnnouIaa23tOcDe
 aUFGyYKYa1hVtCLeF7h2FAepadkdknUod/GjXy3HXIe6ZJFcdx2Rh+fjrc31vzTsw0Ww
 PWUPWgXJTo/iZjCfP0D04BZ7cya2dzMqBvmNQcfuF0lEEzajL5o7IIg8K7jFTlDs54/b
 lXu2PlS/O1+mNRFKz6fLEup4fp8R0qhNC9YB87xksXcmxQSp1ob33IrZ6PnTGWEiWc29
 RVqw5SF/fGwgpPgI7fHITUTs0LiX44XLohoBufHBftxxs1J6PtHWbltyRfkyIM1HnOYb
 PYFQ==
X-Gm-Message-State: AOAM532wRDEwkU3gawDSq4b47h7w8sFY2j01WoK+RWR1bAxVqU50Um2C
 R5hd0sTpIboM/WFmFC271zmRdaNeJtRnalE1X0Sc9w==
X-Google-Smtp-Source: ABdhPJxCHHc/iiTwaXKA24SHwdPiZhCnb+jU0OcvgO+hNPaSBihuX8AsPvCCvWl6Cnhf7yOLteDakkBbLIuEWM3E7zs=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr2771277otj.127.1595474446040; 
 Wed, 22 Jul 2020 20:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595335112.git.zong.li@sifive.com>
 <26ac4734d2079d5ec782adef3a5a40e82082b51f.1595335112.git.zong.li@sifive.com>
 <CAEeofchMe3H35zmuyzbVMOWOKrYZwfEGT9UVRb4k8L18WwW8PQ@mail.gmail.com>
In-Reply-To: <CAEeofchMe3H35zmuyzbVMOWOKrYZwfEGT9UVRb4k8L18WwW8PQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 23 Jul 2020 11:20:36 +0800
Message-ID: <CANXhq0rcvhGX95JkX08OpRWWZBNZyDgeShD35BvbcQax10PBOA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] target/riscv: Fix the translation of physical
 address
To: Alexander Richardson <Alexander.Richardson@cl.cam.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=zong.li@sifive.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 22, 2020 at 5:08 PM Alexander Richardson
<Alexander.Richardson@cl.cam.ac.uk> wrote:
>
> On Tue, 21 Jul 2020 at 13:43, Zong Li <zong.li@sifive.com> wrote:
> >
> > The real physical address should add the 12 bits page offset. It also
> > causes the PMP wrong checking due to the minimum granularity of PMP is
> > 4 byte, but we always get the physical address which is 4KB alignment,
> > that means, we always use the start address of the page to check PMP for
> > all addresses which in the same page.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  target/riscv/cpu_helper.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 75d2ae3434..08b069f0c9 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -543,7 +543,8 @@ restart:
> >              /* for superpage mappings, make a fake leaf PTE for the TLB's
> >                 benefit. */
> >              target_ulong vpn = addr >> PGSHIFT;
> > -            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> > +            *physical = ((ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT) |
> > +                        (addr & ~TARGET_PAGE_MASK);
> >
> >              /* set permissions on the TLB entry */
> >              if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {
> > --
> > 2.27.0
>
> I made the same change for our CHERI fork a few months ago but forgot
> to send the patch upstream (despite marking the commit as a candidate
> for upstreaming). Sorry about the duplicated debugging work!
> (https://github.com/CTSRD-CHERI/qemu/commit/61c8e3f2c0fd4965ec3f316146d1751fae673c12)

No, problem.

