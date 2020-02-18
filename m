Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904F7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59F7024649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="UoE6Q+9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F7024649
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3yoG-0007b1-E8
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yl2-0006HH-Ab
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luc.michel@greensocs.com>) id 1j3yl1-0003VB-9q
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:01:32 -0500
Received: from beetle.greensocs.com ([5.135.226.135]:33556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <luc.michel@greensocs.com>)
 id 1j3ykz-0003Tt-0z; Tue, 18 Feb 2020 04:01:29 -0500
Received: from [172.16.11.100] (tiramisu.bar.greensocs.com [172.16.11.100])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 822B396EF0;
 Tue, 18 Feb 2020 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1582016487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LkwXdyuOlWq9/MwgDTcWPQ2XfiGySFZryCaFbnAKNI=;
 b=UoE6Q+9Xcn3Tyy8johWZGP+VeJD24JXGI//LPtDpzEYjMUVQ/5mAanel13losnlL+NWLdI
 S2ChqvM3u8zsS0XEppA3/jeEtnOCHqBHNpY7f23/2vco3miMn6G1ShoS1qBoO/yQoa3Lcc
 N1brsZmPi+UnBBgt0ZsUV6ZzUgPaLrg=
Subject: Re: [PATCH v2 09/13] hw/arm/bcm2836: Only provide "enabled-cpus"
 property to multicore SoCs
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-10-f4bug@amsat.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <b9734521-d654-4a51-6b08-aed919616e5b@greensocs.com>
Date: Tue, 18 Feb 2020 10:01:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200217114533.17779-10-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-PH
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1582016487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+LkwXdyuOlWq9/MwgDTcWPQ2XfiGySFZryCaFbnAKNI=;
 b=d/4ITs1OGobSMZ3W1h8q1Jq0SmvoxD0HTivS3xmBWP8BHWWg2kJCV5t4YZXjfXESoyTwih
 EPolp44+H7U/pZkogHaL2waJSeoCjvV9XEkAaj4feFlJhtkm/EdR88w7KmEP506Qdlg40C
 +KnJvajvcxizgnqcFfVBTZmyGVpxd7Q=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1582016487; a=rsa-sha256; cv=none;
 b=w7ghlVVMKlC77NNPrTofrgIerpFcehViTmmnHDhuVv2UL0dmrXFxAQv80THC6ek4vYR2+F
 9LynsuY2st+ox4qYvnlGT791pwCikMyCHVsF12/h+AZdOaKIxs3dhgYZzOgwcae2gV7342
 uT20wylcC5h0FYKGXOdUoDXkIVQGX6A=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> It makes no sense to set enabled-cpus=3D0 on single core SoCs.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/bcm2836.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 3b95ad11e9..caaa4b625e 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -32,6 +32,9 @@ typedef struct BCM283XClass {
>  #define BCM283X_GET_CLASS(obj) \
>      OBJECT_GET_CLASS(BCM283XClass, (obj), TYPE_BCM283X)
> =20
> +static Property bcm2836_enabled_cores_property =3D
> +    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
> +
>  static void bcm2836_init(Object *obj)
>  {
>      BCM283XState *s =3D BCM283X(obj);
> @@ -43,6 +46,10 @@ static void bcm2836_init(Object *obj)
>                                  sizeof(s->cpu[n].core), bc->cpu_type,
>                                  &error_abort, NULL);
>      }
> +    if (bc->core_count) {
> +        qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_p=
roperty);
> +        qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_cou=
nt);
> +    }
> =20
>      sysbus_init_child_obj(obj, "control", &s->control, sizeof(s->contr=
ol),
>                            TYPE_BCM2836_CONTROL);
> @@ -154,12 +161,6 @@ static void bcm2836_realize(DeviceState *dev, Erro=
r **errp)
>      }
>  }
> =20
> -static Property bcm2836_props[] =3D {
> -    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus,
> -                       BCM283X_NCPUS),
> -    DEFINE_PROP_END_OF_LIST()
> -};
> -
>  static void bcm283x_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -179,7 +180,6 @@ static void bcm2836_class_init(ObjectClass *oc, voi=
d *data)
>      bc->ctrl_base =3D 0x40000000;
>      bc->clusterid =3D 0xf;
>      dc->realize =3D bcm2836_realize;
> -    device_class_set_props(dc, bcm2836_props);
>  };
> =20
>  #ifdef TARGET_AARCH64
> @@ -194,7 +194,6 @@ static void bcm2837_class_init(ObjectClass *oc, voi=
d *data)
>      bc->ctrl_base =3D 0x40000000;
>      bc->clusterid =3D 0x0;
>      dc->realize =3D bcm2836_realize;
> -    device_class_set_props(dc, bcm2836_props);
>  };
>  #endif
> =20
>=20

