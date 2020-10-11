Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4CAC433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 02:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A94462076E
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 02:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVj7mzfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A94462076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRR3Q-0002ii-In
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 22:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kRR2H-0001qA-C7; Sat, 10 Oct 2020 22:24:34 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33290)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kRR2B-0007Jp-Vc; Sat, 10 Oct 2020 22:24:31 -0400
Received: by mail-ot1-x343.google.com with SMTP id t15so12689814otk.0;
 Sat, 10 Oct 2020 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LbcoDkWpl9BJGGhkAZo9NDJdhNj4Brlb1Abcc1AN0ME=;
 b=QVj7mzfJoZqdpNj99y6/yfBLFeyhajQfEfz+/qsoDnuLZQ3Y5AT6GD9KjMvKC46zXt
 7tib4uGpBLueDMjkzdKPs7xr2PX/pcsjddU6R0pKUm4a6Ob904VrL9vxkjOBWALVVHIE
 J/dq2zoaAId1YQhtukgY01l7WwZuIHPasYwtbwEXf656kyQUPagf6NKb0z38GtiYV3sX
 i9xKmm3zdKdSinDl2NEsxmkqryCbpK2gEF6PHTbfuNN/q33ul3NOCUgZBJgEHu795o14
 ezZnKiHgbfp5ldO7qitfxNpQz+OmXB3G4MHMJSf1mOriixUcCos4ep6y4Wgt8zoBbjII
 YhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LbcoDkWpl9BJGGhkAZo9NDJdhNj4Brlb1Abcc1AN0ME=;
 b=oQCInwBxjgwTsskUcBGCHa7Ee7lDiN3qwYOHJoAlreYSVJRI7NFFUPiwJxRxD/D9Q0
 lkDy3Nz1oJfiu1zPmn7kIOxUZ6RcrtT5D3e6PHQJbCZMRa1GfGoHneDF2D8oqwwSOH0B
 S72nd4KWsjlcmSlzPZ779jSp+xGqu+9illoamKTGqkyzFkqtMamME76Kdmo7A3swJOt0
 5F3tzunqSftgNZs+Z2UPtOAQViY7skLAbZAnI/dQcgq83MBHQW/NhnCDNUUHkpO+6QM6
 o76cXmaK+Kp0QCGLLWRIWyQ1GRDWkAlyOzeYbwQ0CDe4KXQHF63FJtTZobfZjMuyjcfS
 R/pA==
X-Gm-Message-State: AOAM532tx49lfywlkQ/cLZ1B8Rb9XUnfLIgLTiyilyUdgMdXnTz1MLsz
 yauSe+5rrs8ThHEdiKGZAsLw9Vg7l5belUnOxPs=
X-Google-Smtp-Source: ABdhPJz4rnQKGxoqQ7YxrHd47sPrbyoYg7NMVvlyk6kEMxcfyRXtN+xFGeV3NobaOM+mNIuJNNDCvNisSGRzQPr2OiE=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr13477275oti.333.1602383065916; 
 Sat, 10 Oct 2020 19:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
In-Reply-To: <20201010060745.GK1025389@yekko.fritz.box>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 11 Oct 2020 10:23:49 +0800
Message-ID: <CAKXe6S+k7b0A_wB7uvthfn-jt3Q_jXxxGhg7uy=r6=uYZvvp3w@mail.gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
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
Cc: Elena Afanasova <eafanasova@gmail.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Gibson <david@gibson.dropbear.id.au> =E4=BA=8E2020=E5=B9=B410=E6=9C=
=8810=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=882:34=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Fri, Oct 09, 2020 at 07:02:56AM -0700, Elena Afanasova wrote:
> > >From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> > From: Elena Afanasova <eafanasova@gmail.com>
> > Date: Fri, 9 Oct 2020 06:41:36 -0700
> > Subject: [PATCH] hw/net: move allocation to the heap due to very large =
stack
> >  frame
>
> Patch looks fine, but some more details of the motivation would be
> nice.  I wouldn't have thought that the size of a network packet
> counted as a "very large" stack frame by userspace standards.
>

It is also a best practice to avoid large stack allocation according.
-->https://wiki.sei.cmu.edu/confluence/display/c/MEM05-C.+Avoid+large+stack=
+allocations

Though I don't see any issue here.

Thanks,
Li Qiang

> > Signed-off-by: Elena Afanasova <eafanasova@gmail.com>
> > ---
> >  hw/net/spapr_llan.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> > index 2093f1bad0..581320a0e7 100644
> > --- a/hw/net/spapr_llan.c
> > +++ b/hw/net/spapr_llan.c
> > @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *=
cpu,
> >      SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg=
);
> >      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
> >      unsigned total_len;
> > -    uint8_t *lbuf, *p;
> > +    uint8_t *p;
> > +    g_autofree uint8_t *lbuf =3D NULL;
> >      int i, nbufs;
> >      int ret;
> >
> > @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *=
cpu,
> >          return H_RESOURCE;
> >      }
> >
> > -    lbuf =3D alloca(total_len);
> > +    lbuf =3D g_malloc(total_len);
> >      p =3D lbuf;
> >      for (i =3D 0; i < nbufs; i++) {
> >          ret =3D spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

