Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1E4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:47:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC07B206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 02:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="i7AiMrL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC07B206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxiJ9-0002sL-0s
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 22:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxiIO-0002Qe-2A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:46:20 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:42256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zong.li@sifive.com>)
 id 1jxiIM-0000iC-EO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 22:46:19 -0400
Received: by mail-oi1-x241.google.com with SMTP id t4so16046789oij.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 19:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZvtYBtBKpih4QmDpBqfuD7U/hOUtMDyjJ2qtYKxB568=;
 b=i7AiMrL36RCzMo5/AR2E1Nbopn9ARiUKIdBS0wrikt4n1VW5g5fxOXhDQ93TwuppTe
 OjDg/JhBg3Vul1conSLIpdlp00I7VoGtGcNQkU3vH3Ux8K34q+xH/qgaatV4BUso+SDA
 t9Es63E1/lFIfFl84Emru4cay9asbzyJIsk1VkD1Pfs/R0u0c2NXMSpxLYiWPMd8LkVr
 gAaHthgWXpueU7uVwHHpCmcA+3q9/jZjx880SbcrciedSiCNS7v7kqOoxgR2lhATbdm6
 4VcGWp2ozwJrT9t7so/SzCjJAqA+U8xRA+tHsGuhuPzncwN2saBLFvSjUEKRLi05TkVZ
 r8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZvtYBtBKpih4QmDpBqfuD7U/hOUtMDyjJ2qtYKxB568=;
 b=U3vkCLxMn7OA2hR8TayK03DkJwEA+lqnPW1SCddPJRyenJbL+Xn2vFQ0dsAFPJYvS4
 vbhvjs+vhhIYMwhslfWslo9+8fWaOB7kIN0Xi5xGCkpIpB2Hr8+WTdz9mn0t5lXNdOsd
 co1CSUITgChS/+cmMH4oXAK9nG7Vhgm2i58gIutHfW+tBCs0oqCMU2Ijcb0tHsQfhO1F
 cn8BODNZjEtwF8tERE8r348mAmXcNu2+bETO8pOvYxZnphZ14y0+rSK3yeSlwUO7I4B3
 1tV5Fl/Xn4cYe3pakXOntBUC0eN0acKsrBp7dSwnO3Fuz9lqTuywCASjfnnLAFwnlCqO
 HIjQ==
X-Gm-Message-State: AOAM533U2GZUPCGVl0nI9to2E7iN+IfMDP7/zFymSrZp7YB6CPGUkQNm
 30gDFP1dYYKLAU0ShYKS5LXeQiqQfIH7C0fwKEE1AQ==
X-Google-Smtp-Source: ABdhPJy/t4FSy2xk9r4adOXS9wwLrNXQblEDBrB+S6JFMkdH1iQzpNH3tUlQ5YZwev9K92VzyCeLBA+JGT6CPVLMPaU=
X-Received: by 2002:aca:d509:: with SMTP id m9mr1534190oig.116.1595299577131; 
 Mon, 20 Jul 2020 19:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1595234208.git.zong.li@sifive.com>
 <658e49284fc564d4114307cb559cf23ea3e751fd.1595234208.git.zong.li@sifive.com>
 <CAEUhbmWz0Afs4YotbQi-t96A-eEcQzxzwkYjHtQ4BZxJ7SCgxw@mail.gmail.com>
In-Reply-To: <CAEUhbmWz0Afs4YotbQi-t96A-eEcQzxzwkYjHtQ4BZxJ7SCgxw@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Tue, 21 Jul 2020 10:46:06 +0800
Message-ID: <CANXhq0pd7LyN4-Ysmss=SWjidBZjui_EGq1d1xrOXDmDNN=KeA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/riscv/pmp.c: Fix the index offset on RV64
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=zong.li@sifive.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 21, 2020 at 10:41 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Zong,
>
> On Mon, Jul 20, 2020 at 5:46 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > On RV64, the reg_index is 2 (pmpcfg2 CSR) after the seventh pmp
> > entry, it is not 1 (pmpcfg1 CSR) like RV32. In the original
> > implementation, the second parameter of pmp_write_cfg is
> > "reg_index * sizeof(target_ulong)", and we get the the result
> > which is started from 16 if reg_index is 2, but we expect that
> > it should be started from 8. Separate the implementation for
> > RV32 and RV64 respectively.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  target/riscv/pmp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> > index 2a2b9f5363..adcdd411e6 100644
> > --- a/target/riscv/pmp.c
> > +++ b/target/riscv/pmp.c
> > @@ -320,8 +320,13 @@ void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
> >
> >      for (i = 0; i < sizeof(target_ulong); i++) {
> >          cfg_val = (val >> 8 * i)  & 0xff;
> > +#if defined(TARGET_RISCV32)
> >          pmp_write_cfg(env, (reg_index * sizeof(target_ulong)) + i,
> >              cfg_val);
> > +#elif defined(TARGET_RISCV64)
> > +        pmp_write_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i,
> > +            cfg_val);
> > +#endif
>
> Can you please simplify this by shifting reg_index outside the for
> loop for RV64?
>

OK, that would be great. Change it in the next version, thanks.

> >      }
> >  }
> >
> > @@ -336,7 +341,11 @@ target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index)
> >      target_ulong val = 0;
> >
> >      for (i = 0; i < sizeof(target_ulong); i++) {
> > +#if defined(TARGET_RISCV32)
> >          val = pmp_read_cfg(env, (reg_index * sizeof(target_ulong)) + i);
> > +#elif defined(TARGET_RISCV64)
> > +        val = pmp_read_cfg(env, ((reg_index >> 1) * sizeof(target_ulong)) + i);
> > +#endif
> >          cfg_val |= (val << (i * 8));
> >      }
> >      trace_pmpcfg_csr_read(env->mhartid, reg_index, cfg_val);
>
> Regards,
> Bin

