Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536B8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1F2E206BE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKme6Y9e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1F2E206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtpo-0004Q5-QS
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kQtow-0003nD-DD; Fri, 09 Oct 2020 10:56:34 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:37174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kQtou-0001Ss-Sp; Fri, 09 Oct 2020 10:56:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id o8so9254776otl.4;
 Fri, 09 Oct 2020 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=cwvcMoVEGULkCpiukNVGdWIa8siXf1a3XmAe3ERC6Sc=;
 b=IKme6Y9emfT7xlZS6Hw3l4udp8bvgUw+N5uA2Ex7suU67Z0u6+YRR/YIqgnPFiNuv2
 KZUSu6Wg5zfUSN+AwwT26j8xV9G9e0jGdmpF1zMBkuAGUGjWEd6BLcBc2P8D3mZW1yu4
 uRuQaUzHdRRgKg0RUNyQE9x8LlgP27YxEjKA5VWiethTC4Y8LrzUOxAemCjMjviLfPp3
 iycybWvyLZK3E+byfoO+8JkY+PLp8EgOOjKDlnir5WUkTcatZ3Kj5uxMnjmYTz2GuqKY
 ERrThUmuGrbEl/M2ANMmH4aEwbo4H6kLsqkU3YjvLTVraccjkVC+5/0PvqSTVuCX+xNK
 Yd+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=cwvcMoVEGULkCpiukNVGdWIa8siXf1a3XmAe3ERC6Sc=;
 b=DzRWJeLJD8fWuwno5g94X/efPjSyGwx4he3qpEYrz7BRycUKuB6dOx84AppMQ/cjOv
 36ZCaNlDQJScgWNMG8T0WlK+at0DsQqEV6R/FvsbZgc81Dy9RRwYUx9dJQq3XihgtcwZ
 9ZxrjpZpfx/i2qHKaaB5cds4Dnrdnz907CxlfrSvYydaLcs7OXvrWdbG/eryVhX6KKZw
 aAK7jfXqJJNPm31Pv9JRdaox5tvQxIFXaJ2B0n22Tutf0DY2N1QHjqNrjnaYmUGbiTlt
 F0AqhtUF6QApKRdYRD2H3IaXfD0xNnuAqudIRjQPlmhxwBu4fefJqQtv1OWUvqkwnN2/
 U6gQ==
X-Gm-Message-State: AOAM530WxXxIemqAj6/M/+q/URooHPvU7cySZFlxkwgldbZVA+vRe7LQ
 B2+dR3NnGhLxpE/yV5dXCfJkkNi/5SrkD52xDyE=
X-Google-Smtp-Source: ABdhPJx0MG3okHUhDeYY6XZQbAPOsJRPKYah9gFTiszmM1VQ1f1Jmx4dYmsajCqiSI14/DfhuNb/ncZAaJT9MWdZBsw=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr8731978oti.333.1602255390851; 
 Fri, 09 Oct 2020 07:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
In-Reply-To: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 9 Oct 2020 22:55:55 +0800
Message-ID: <CAKXe6SLdE=10OjDjjYTPS61T8ss7OZ_yp9CZdd1KXUsBc2+CpA@mail.gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
To: Elena Afanasova <eafanasova@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 qemu-ppc@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Elena Afanasova <eafanasova@gmail.com> =E4=BA=8E2020=E5=B9=B410=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=8810:03=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From 09905773a00e417d3a37c12350d9e55466fdce8a Mon Sep 17 00:00:00 2001
> From: Elena Afanasova <eafanasova@gmail.com>
> Date: Fri, 9 Oct 2020 06:41:36 -0700
> Subject: [PATCH] hw/net: move allocation to the heap due to very large st=
ack
>  frame
>
> Signed-off-by: Elena Afanasova <eafanasova@gmail.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  hw/net/spapr_llan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
> index 2093f1bad0..581320a0e7 100644
> --- a/hw/net/spapr_llan.c
> +++ b/hw/net/spapr_llan.c
> @@ -688,7 +688,8 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cp=
u,
>      SpaprVioDevice *sdev =3D spapr_vio_find_by_reg(spapr->vio_bus, reg);
>      SpaprVioVlan *dev =3D VIO_SPAPR_VLAN_DEVICE(sdev);
>      unsigned total_len;
> -    uint8_t *lbuf, *p;
> +    uint8_t *p;
> +    g_autofree uint8_t *lbuf =3D NULL;
>      int i, nbufs;
>      int ret;
>
> @@ -729,7 +730,7 @@ static target_ulong h_send_logical_lan(PowerPCCPU *cp=
u,
>          return H_RESOURCE;
>      }
>
> -    lbuf =3D alloca(total_len);
> +    lbuf =3D g_malloc(total_len);
>      p =3D lbuf;
>      for (i =3D 0; i < nbufs; i++) {
>          ret =3D spapr_vio_dma_read(sdev, VLAN_BD_ADDR(bufs[i]),
> --
> 2.25.1
>
>
>

