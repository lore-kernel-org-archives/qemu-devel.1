Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985D3C282DD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68A2A20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 18:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHSRDgcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68A2A20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iotfi-0005Oa-6q
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 13:33:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ioteL-0004IJ-4Z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ioteI-0006Vl-1E
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:32:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53024
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ioteH-0006SR-4V
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 13:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578421929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAO4GZaducOmiJA9eNV+8tQmiJfWJK4rGCsPRhtg2nI=;
 b=hHSRDgcVTEw1PhnqSukQvVcCa72SR28+/XqGKbnw/ZFXUIwFTgA1+sx59I/w5nFJ5jCba3
 FsuE6DY+ZcxVTQXjplz6mi7TeUQecCVXXIB+jssmFkiVyNgwZMeUV/J03l9HxdwvKH3ub1
 20WxLJWI3jDSGUyohdiZk4eM4Q0adj8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-QALckWQ2Piuc0BG00CrFYw-1; Tue, 07 Jan 2020 13:32:08 -0500
Received: by mail-wr1-f69.google.com with SMTP id z10so291984wrt.21
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 10:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QxpIqJOqETg4I2qPGCiFG8StDt46lrcyXnCRG8Wa3Ko=;
 b=uZ2Bpm5/B5C/gM4NFlkfz+h2WtYYm4xLE0b2BM5tTYhFWGPekwcCLJLPFpTgwsKKuS
 Z/A0lo9uuKQlfJ8XhGcUZnpNn7N3bIr64C32jCr4lvcr05tOe9WaWk34G/UssChEXNCe
 nI7+W8sEDhRMjteeP1cdLsdwoHCW9Ufu+K4rA9BXUwJTu6tmepbM7ZSXTx9Lkz896uvl
 YC8+6S9AqUpKadWylzy0PdIvNO91PXpET/XrkyMaSvLDDoAOR/5xpK7aA0JI4m4kurHC
 sGCvPwjrBsl7vuE2B1TZMWHUJr85DX6Io3/7FHxAK3VIX23eZuqf33AMcrbFw2Ig8xdS
 k+UA==
X-Gm-Message-State: APjAAAUHytMbGulUj0dqWKnv6alT9rhfDzSkczjLr681+i4N5ZCpIkUI
 KAc2dICsubo+Am2agJ0Y/VDV9DFo+zFVnVqBlIMHC/tXQvlyibI3/6vf/NWBasL/oDP/CS5okv8
 kvKNT6+O7HYGNhco=
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr421925wmo.12.1578421924984; 
 Tue, 07 Jan 2020 10:32:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqwp0ziUqjuwoyQQwSxfI2Ew5Z9z6ULU4AXWzM0VIyAoQ6yDeMPPaS5R41cP96XoKHcnMur/Bg==
X-Received: by 2002:a05:600c:230d:: with SMTP id
 13mr421909wmo.12.1578421924766; 
 Tue, 07 Jan 2020 10:32:04 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id l17sm807207wro.77.2020.01.07.10.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 10:32:04 -0800 (PST)
Subject: Re: [PATCH 2/2] pnv/psi: Consolidate some duplicated code in
 pnv_psi_realize()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <157841289975.66386.6463139590245180762.stgit@bahia.tlslab.ibm.com>
 <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <56272b35-c0ed-65de-310d-f97090e2b8c1@redhat.com>
Date: Tue, 7 Jan 2020 19:32:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157841476667.66386.13659183399113837990.stgit@bahia.tlslab.ibm.com>
Content-Language: en-US
X-MC-Unique: QALckWQ2Piuc0BG00CrFYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Greg,

On 1/7/20 5:32 PM, Greg Kurz wrote:
> The proper way to do that would be to use device_class_set_parent_realize=
(),
> but defining a Pnv8PsiClass and a Pnv9PsiClass types with a parent_realiz=
e
> pointer adds a fair amount of code. Calling pnv_psi_realize() explicitely
> is fine for now.
>=20
> This should probably be achieved with a device realize hook in the
> PSI base class and device_class_set_parent_realize() in the children
> classes.

Can you add a note explaining why the POWER10 PSI doesn't need it?

>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/pnv_psi.c |   19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
> index 6c94781e377d..546232106756 100644
> --- a/hw/ppc/pnv_psi.c
> +++ b/hw/ppc/pnv_psi.c
> @@ -469,6 +469,16 @@ static void pnv_psi_reset_handler(void *dev)
>       device_reset(DEVICE(dev));
>   }
>  =20
> +static void pnv_psi_realize(DeviceState *dev, Error **errp)
> +{
> +    PnvPsi *psi =3D PNV_PSI(dev);
> +
> +    /* Default BAR for MMIO region */
> +    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> +
> +    qemu_register_reset(pnv_psi_reset_handler, dev);
> +}
> +
>   static void pnv_psi_power8_instance_init(Object *obj)
>   {
>       Pnv8Psi *psi8 =3D PNV8_PSI(obj);
> @@ -528,9 +538,6 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, ps=
i,
>                             "psihb", PNV_PSIHB_SIZE);
>  =20
> -    /* Default BAR for MMIO region */
> -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> -
>       /* Default sources in XIVR */
>       for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
>           uint8_t xivr =3D irq_to_xivr[i];
> @@ -538,7 +545,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
>               ((uint64_t) i << PSIHB_XIVR_SRC_SH);
>       }
>  =20
> -    qemu_register_reset(pnv_psi_reset_handler, dev);
> +    pnv_psi_realize(dev, errp);
>   }
>  =20
>   static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xsco=
m_offset)
> @@ -873,9 +880,7 @@ static void pnv_psi_power9_realize(DeviceState *dev, =
Error **errp)
>       memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_=
ops, psi,
>                             "psihb", PNV9_PSIHB_SIZE);
>  =20
> -    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
> -
> -    qemu_register_reset(pnv_psi_reset_handler, dev);
> +    pnv_psi_realize(dev, errp);
>   }
>  =20
>   static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
>=20
>=20


