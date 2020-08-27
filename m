Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F12C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 125F92074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 01:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugn2s7Lh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125F92074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB6lp-0007li-B3
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 21:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6i9-0003gj-I5; Wed, 26 Aug 2020 21:28:17 -0400
Received: from mail-oo1-xc44.google.com ([2607:f8b0:4864:20::c44]:40195)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kB6i6-00066f-VT; Wed, 26 Aug 2020 21:28:17 -0400
Received: by mail-oo1-xc44.google.com with SMTP id j16so880334ooc.7;
 Wed, 26 Aug 2020 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=8NWq3EQI/P5IXayyCobvfgxleBQDbnXft7XlUG7K+Ic=;
 b=Ugn2s7LhnHa5Gxz8qR1l859xxSmSjNP+wpswYnfZyDyVoousYldOwd/riAlSHD9n4C
 dGcxePnBGjwKIK/ZL5LhOSSlJw4Xp//M2PIfLjSCrmvU8dRCob81OyMgc1YhybZChwoV
 mclBAIuuNj48Ay0dgfFN9tRXT886XgSf2bfYKwojY2Vu6+sfaAz6ddSqWD+xv6mH8q6X
 6Bx6rlGTmE502Z1vos1dDx9QbSvud/W+QOvCG2Qq1D/pW3pegoFKL225/C3a8ed0/xTB
 2PboihfMhz9MmYkkUifiF+279b/saFRSMfTQNH3b5RTgwpQ9uUMeHtAsOmBp4jIddnnp
 gvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=8NWq3EQI/P5IXayyCobvfgxleBQDbnXft7XlUG7K+Ic=;
 b=jhC6BVh+WQNKQVIVLPBfE3Ofxsc7ui0pt81oofjS2MN3BaFuq7x0LepbHTth07em6f
 qowDpXIzarwO1j9HmSsnp+WTOE+UZOQLYLPpeuJA/nZua8/lVs5kuLIBEzEqe92CvJxV
 UnFyKGxlrRteuVVUNuK/mpW4WPtM3wmaVRZN7D4DmEtI9OkSTMi9nKSfK24ank4fgZny
 6twEAfKLr757YaDU3qTdv2QkIOmuoPRwL3JnZFwkmLMQBZxVHQpUrSbhMw1c5mtNmgw1
 qY7WxHdGF3MnJpEsx/i3MP2rivKu0gmetsVR7DDoSpgCQgMkLoSEc9k4tnW3Cmth63Yo
 ML9w==
X-Gm-Message-State: AOAM530PlTNeK6PzjLqve7UZhFzuLQjs7HS3rlj/u2rAXhivxyIdjQCE
 F+2ExYZD+zqeQUbLJ9EnotzwZ0QLPdsYpsGHZ+c=
X-Google-Smtp-Source: ABdhPJwurgWHSp450JpVOGdPE2fS1cDGwi0URKz6UZru1GdShzTg132XtYb3OkOcUDxfPHCJG2xwv2etgNYYBi36koE=
X-Received: by 2002:a4a:c587:: with SMTP id x7mr12544204oop.60.1598491693440; 
 Wed, 26 Aug 2020 18:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200826184334.4120620-1-ehabkost@redhat.com>
 <20200826184334.4120620-2-ehabkost@redhat.com>
In-Reply-To: <20200826184334.4120620-2-ehabkost@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 27 Aug 2020 09:27:37 +0800
Message-ID: <CAKXe6S+4wG3-nqqn-=W4x1e9strY3xKCraZwukoSw8a=fHReYA@mail.gmail.com>
Subject: Re: [PATCH 1/8] etsec: Use TYPE_ETSEC_COMMON constant
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c44;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc44.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:46=E5=86=99=E9=81=93=EF=BC=9A
>
> This will make future conversion to use OBJECT_DECLARE* easier.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  hw/net/fsl_etsec/etsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
> index 7035cf4eb9..ad20b22cdd 100644
> --- a/hw/net/fsl_etsec/etsec.c
> +++ b/hw/net/fsl_etsec/etsec.c
> @@ -430,7 +430,7 @@ static void etsec_class_init(ObjectClass *klass, void=
 *data)
>  }
>
>  static TypeInfo etsec_info =3D {
> -    .name                  =3D "eTSEC",
> +    .name                  =3D TYPE_ETSEC_COMMON,
>      .parent                =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size         =3D sizeof(eTSEC),
>      .class_init            =3D etsec_class_init,
> --
> 2.26.2
>
>

