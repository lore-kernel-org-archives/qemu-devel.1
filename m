Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF113C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CDF122210
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSTWx9t1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDF122210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kW05P-00017d-9y
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzRU-0002hk-08
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVzRR-0005Rq-1j
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:57:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603468639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FI0S6qNYi/9jzC8gUVxersyLo/zq/Zwv/35wVgMW1o8=;
 b=cSTWx9t1ygO95PyJSWPqlUGDRQNkvWPLu8oxNxQX9b0ODsIxJsN40o3FGpRzRr3P5uaGzz
 zx+7QEjt4/0aNAb7C8Iy/iNMGmT65IyH6cZ+XjJnu4m1mK6pvz7wcY47Md+BE74Ugv30Lf
 kYZZ+AJ6FNoLs2gQx4F0AYJ0RaBrusw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-NwUrnVN5P6aLq_1_5iwpEQ-1; Fri, 23 Oct 2020 11:57:15 -0400
X-MC-Unique: NwUrnVN5P6aLq_1_5iwpEQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FC0964152;
 Fri, 23 Oct 2020 15:57:14 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F15360CCC;
 Fri, 23 Oct 2020 15:57:12 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:57:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 9/9] hw/arm/raspi: Add the Raspberry Pi 3 model A+
Message-ID: <20201023175711.74865d7d@redhat.com>
In-Reply-To: <20201018203358.1530378-10-f4bug@amsat.org>
References: <20201018203358.1530378-1-f4bug@amsat.org>
 <20201018203358.1530378-10-f4bug@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 18 Oct 2020 22:33:58 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> The Pi 3A+ is a stripped down version of the 3B:
> - 512 MiB of RAM instead of 1 GiB
> - no on-board ethernet chipset
>=20
> Add it as it is a closer match to what we model.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/arm/raspi.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> index 1510ca01afe..4ea200572ea 100644
> --- a/hw/arm/raspi.c
> +++ b/hw/arm/raspi.c
> @@ -348,6 +348,15 @@ static void raspi2b_machine_class_init(ObjectClass *=
oc, void *data)
>  };
> =20
>  #ifdef TARGET_AARCH64
> +static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> +
> +    rmc->board_rev =3D 0x9020e0;
> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> +};
> +
>  static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
>  {
>      MachineClass *mc =3D MACHINE_CLASS(oc);
> @@ -373,6 +382,10 @@ static const TypeInfo raspi_machine_types[] =3D {
>          .parent         =3D TYPE_RASPI_MACHINE,
>          .class_init     =3D raspi2b_machine_class_init,
>  #ifdef TARGET_AARCH64
> +    }, {
> +        .name           =3D MACHINE_TYPE_NAME("raspi3ap"),
> +        .parent         =3D TYPE_RASPI_MACHINE,
> +        .class_init     =3D raspi3ap_machine_class_init,
>      }, {
>          .name           =3D MACHINE_TYPE_NAME("raspi3b"),
>          .parent         =3D TYPE_RASPI_MACHINE,


