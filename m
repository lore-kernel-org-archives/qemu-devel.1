Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF58AC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9A142184B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 18:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I49reY9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A142184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiNWT-0008Hq-Pb
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 14:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hiLXU-00079j-6P
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:21:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hiLXS-00032H-Vr
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 12:21:52 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:42930)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hiLXS-00031a-Ni; Tue, 02 Jul 2019 12:21:50 -0400
Received: by mail-lf1-x141.google.com with SMTP id x144so11831635lfa.9;
 Tue, 02 Jul 2019 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ayjdndP2oQomGn50vPaWJ1wMJuVcnMT5s/nYkk76XU8=;
 b=I49reY9SdpYvX99YTU0AkglQ5bd3qRClXRqMr/XKEWsaWBkctGy/R/PkNPiwolwqec
 Zku93g6o9Qpfw08H4dOPCmZSf8xDSuOA83v+goz9G4/gP7P17iILwPtPlNmhUYd4520c
 no4wXRD+U4PgUN4p1VfmXe6u6UFYIX/rfgncGFXa/ywDwNNy+/nH3Lxp8Wb6pMN8xd0Y
 p/l9Kn8U1RpQmY9eqedU92L8NBy9APQZSLt7ouyooJuOZAGGdVHXXZH/eT3CpJK0cUoJ
 8tYo7vxQIJO5CeRKPSPjudmhhYaF+T1AcKkraiBLUDi6LLJXQUQVN4Vm8foePBGeLE/L
 URsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ayjdndP2oQomGn50vPaWJ1wMJuVcnMT5s/nYkk76XU8=;
 b=NFGoIuwHohLf3ku/Wvq4R1WYQlioOEL7LMkMdqeNPTViYGvfmHYZ7Gkse1CA7hZ80a
 TqTPrZGWOdVCuifWt6zHxSHhJAoegdVtMWiRRHl0rjhHSt4gxTlOoKDVwcyx6Z7iLhl8
 qRZf41vQJWE0t2DEWU6gwuZjWPhUhFEjIQo1UouDXi6UPsyNj8HK3djHh6XDcB/tbu+8
 4CRDL8cO5RGO1PgTkMucgigpnKRjgmBFEj4ErPTbmjaB+oGoFRkbsL5zYUS8jMV0Qlle
 JZgAJPQRc95qSBCDJbihcLNIPr7lMjeq3OcFage/6A1I6u3R+ttO147o6g05XU6L7j8L
 DzoQ==
X-Gm-Message-State: APjAAAUpvDB/sTwqF3q50SqLqT/6eW06qyJEs0mFGUi6OQFQqV7+P83F
 J6nGtC6mudGbdqkh9YvxAjJr6mUaZ7/upBoUWRI=
X-Google-Smtp-Source: APXvYqzC7tcedpcFGuyHRJv6RiHRe6C4PigdxnPDGjrhKMTFdqaVEqwTu3naiOysS4CSyVa0SrT8F/X/cbQnofd4/FA=
X-Received: by 2002:a19:c6d4:: with SMTP id w203mr2218406lff.135.1562084509460; 
 Tue, 02 Jul 2019 09:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-7-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-7-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2019 09:18:46 -0700
Message-ID: <CAKmqyKOgkt3NrAJzK8ZNqrszSCSjoyekS-XynBLsEXmbX8eghg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH 6/6] hw/net/xilinx_axi: Use
 object_initialize_child for correct ref. counting
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 1, 2019 at 5:38 AM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> As explained in commit aff39be0ed97:
>
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/xilinx_axienet.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index feeaca680e..aa0ae3c013 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -990,15 +990,14 @@ static void xilinx_enet_init(Object *obj)
>      XilinxAXIEnet *s =3D XILINX_AXI_ENET(obj);
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
>
> -    object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
> -                      TYPE_XILINX_AXI_ENET_DATA_STREAM);
> -    object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
> -                      TYPE_XILINX_AXI_ENET_CONTROL_STREAM);
> -    object_property_add_child(OBJECT(s), "axistream-connected-target",
> -                              (Object *)&s->rx_data_dev, &error_abort);
> -    object_property_add_child(OBJECT(s), "axistream-control-connected-ta=
rget",
> -                              (Object *)&s->rx_control_dev, &error_abort=
);
> -
> +    object_initialize_child(OBJECT(s), "axistream-connected-target",
> +                            &s->rx_data_dev, sizeof(s->rx_data_dev),
> +                            TYPE_XILINX_AXI_ENET_DATA_STREAM, &error_abo=
rt,
> +                            NULL);
> +    object_initialize_child(OBJECT(s), "axistream-control-connected-targ=
et",
> +                            &s->rx_control_dev, sizeof(s->rx_control_dev=
),
> +                            TYPE_XILINX_AXI_ENET_CONTROL_STREAM, &error_=
abort,
> +                            NULL);
>      sysbus_init_irq(sbd, &s->irq);
>
>      memory_region_init_io(&s->iomem, OBJECT(s), &enet_ops, s, "enet", 0x=
40000);
> --
> 2.20.1
>
>

