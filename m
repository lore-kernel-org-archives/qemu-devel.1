Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F13C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:27:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A300020693
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6GZyu0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A300020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8nUG-0008Hd-Fr
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 11:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i8nS3-0006QA-IK
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i8nS2-0003FG-Cg
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 11:25:35 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i8nS2-0003Eo-4g; Fri, 13 Sep 2019 11:25:34 -0400
Received: by mail-ed1-x542.google.com with SMTP id p2so26184231edx.11;
 Fri, 13 Sep 2019 08:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FCl877NqqCGz8u/w1orC7xsxT3SEdlVk8feSHSCN2m0=;
 b=X6GZyu0I4nK8d9knHN1toBMI6D1n4q/pKLABSM7EeGXYpxue+Z5/YD3GvnftSodLZS
 DkPLx3fjIMPHnbn2tizWKSCBVPHAq9Wmb8U2s/VpyHXOldBNatlyolXt1s6wCPblwUHb
 9jhkuXX6bsiMkrRfAd9E7hSj0+DR01G7uEW1bQKkdcG1LAoGQdoPAhjPeKYkCuSyBh08
 N+ww6ERtIIJWmwL4f3z+caVHkzekEho+WDTlbcPIhdqEJ5AvwHiel5hoacgmIazAnFPn
 vruzLWAvOcOAsEJZUz8pbFztIQRfxMu9orwyxfqOEPB8clFpkbhUZClxLYFHLBz2zVPV
 lnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FCl877NqqCGz8u/w1orC7xsxT3SEdlVk8feSHSCN2m0=;
 b=C6GURcdReTFOTIBsIQ2OTfrZ4xXhW1HBfYZa4XDhQo1pv+4aFpH21WvhEOM1zHkQrb
 Tncgt1KWSWBWWlYL0j+Hbz2ItzkiQI9eXTa/JC+TGmboa2OfMwO5/rZy1lA1kfsK/q95
 eSAh8fAJXrJvHWigGmLldrI4K4Ys0ZUZ+RAwQ9ssS+doPVytzq004Q8P7uGNFe6PrWo1
 u4CrDt6hqlr4vtS71F5onMDbG0hvlJEhQdF47Qtns690bujLpipocaRVCm6PoWrr+zcM
 7pHrCE/FVUinsvu7bm18ys5Zq3Eg3Bz/VM3mtRa+Z/mD6eCgUANi1vomuPjBARizyfbj
 UP9w==
X-Gm-Message-State: APjAAAWRPj94RZJhi4YA62GuJNLbekkcUNw2zkviJb226YttByNXyDcb
 dvQmsmv3jMt2CxHDwT7dcSWmGbwDJ5dpSD4o924L4M0c
X-Google-Smtp-Source: APXvYqzj6GmZpmTGRVyOI3EaL9wxbgzT61oPYcZeLCTyFu3mCfQ+t/Eno5m6kN9DromJgJzVxbYX/aIUDY1J/a8xQN0=
X-Received: by 2002:a17:906:57cc:: with SMTP id
 u12mr32665681ejr.170.1568388332360; 
 Fri, 13 Sep 2019 08:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <1567786819-22142-19-git-send-email-bmeng.cn@gmail.com>
 <mhng-81295c42-a2f8-4f95-a54f-f9a319e10a36@palmer-si-x1e>
In-Reply-To: <mhng-81295c42-a2f8-4f95-a54f-f9a319e10a36@palmer-si-x1e>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 13 Sep 2019 23:25:21 +0800
Message-ID: <CAEUhbmUksfEiGLZ0qzsWkaDOaocTvkEYefiSUmGZT7TftYfmEg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v8 18/32] riscv: sifive_u: Set the minimum
 number of cpus to 2
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

Hi Palmer,

On Fri, Sep 13, 2019 at 10:33 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
> > It is not useful if we only have one management CPU.
> >
> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > ---
> >
> > Changes in v8: None
> > Changes in v7: None
> > Changes in v6: None
> > Changes in v5: None
> > Changes in v4: None
> > Changes in v3:
> > - use management cpu count + 1 for the min_cpus
> >
> > Changes in v2:
> > - update the file header to indicate at least 2 harts are created
> >
> >  hw/riscv/sifive_u.c         | 4 +++-
> >  include/hw/riscv/sifive_u.h | 2 ++
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > index 2947e06..2023b71 100644
> > --- a/hw/riscv/sifive_u.c
> > +++ b/hw/riscv/sifive_u.c
> > @@ -10,7 +10,8 @@
> >   * 1) CLINT (Core Level Interruptor)
> >   * 2) PLIC (Platform Level Interrupt Controller)
> >   *
> > - * This board currently uses a hardcoded devicetree that indicates one hart.
> > + * This board currently generates devicetree dynamically that indicates at least
> > + * two harts.
> >   *
> >   * This program is free software; you can redistribute it and/or modify it
> >   * under the terms and conditions of the GNU General Public License,
> > @@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
> >       * management CPU.
> >       */
> >      mc->max_cpus = 4;
> > +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> >  }
> >
> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > index f25bad8..6d22741 100644
> > --- a/include/hw/riscv/sifive_u.h
> > +++ b/include/hw/riscv/sifive_u.h
> > @@ -69,6 +69,8 @@ enum {
> >      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
> >  };
> >
> > +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> > +
> >  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
> >  #define SIFIVE_U_PLIC_NUM_SOURCES 54
> >  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
>
> This fails "make check", so I'm going to squash in this
>
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index ca9f7fea41..adecbf1dd9 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -528,6 +528,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
>      mc->init = riscv_sifive_u_init;
>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> +    mc->default_cpus = mc->max_cpus;

Thank you for fixing the 'make check'. Shouldn't it be:

mc->default_cpus = mc->min_cpus;

?

>  }
>
>  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)

Regards,
Bin

