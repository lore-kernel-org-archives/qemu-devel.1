Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E3C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94997206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94997206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJHP-0007sH-I0
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52316)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iIHTA-0002jJ-1H
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iIHT7-0006gg-Ns
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:17:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iIHT7-0006fw-BS
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:17:53 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3458B2CE905
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:17:52 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id n135so2945608qke.23
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5Z1lbJyLmfkG493rnJvBSTwZ4AJSxGiXUH6MwWMjsvA=;
 b=XAJZ9EAF0H+xm5KeO1/lWuADvrjgtbmIibU8CCa+dv5mC+DgeSww1sU1d8qIK6SWrz
 edivB0kG48YF/aH+UENn18GQMeoRMSSbFnqBIOo5OogwSqnqlRIWwIE9FRh/jtrnkJmr
 JMGNYiWRRRQm4U3HYP+9XNmDrbCok7TuSA4TfUfbS2Figy2Dq2DkCSNcbt2YwLCMl8sb
 JDE4wJMCTpiDde8MxlHZ8Hrv0R81NfJ2U8x/vyGzr+jdvoaXadgpH/UJ0yPhqDl0Nxv0
 itUEJqQdZrm3BPzDV9s3a7pNVlIeTMF+rQJIjl1naU5rNtu+sNVZG6L0riPVrjPcFMAV
 vpaA==
X-Gm-Message-State: APjAAAX0M1oND9c9wj6Ye7GbhLvp5watXDi9Chd2tLBckh4ICw5srSPp
 tryIqCgJIU/rjrLLerMX4wy1hDl50pWsYut/OUUE+e6klC5U5Q6qPdGQgVWdUn2BGi6jYQoO+4j
 jxcn+YDGEb1nJz5k=
X-Received: by 2002:a0c:8964:: with SMTP id 33mr2135280qvq.241.1570648671491; 
 Wed, 09 Oct 2019 12:17:51 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKnXBbNftbYnk7HLVkRyFw9ZshhnD/+dxnGLbd7edME+1z8MO4FoqQ4E6+0RMuruHaY2Z3/g==
X-Received: by 2002:a0c:8964:: with SMTP id 33mr2135250qvq.241.1570648671239; 
 Wed, 09 Oct 2019 12:17:51 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 139sm1418694qkf.14.2019.10.09.12.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2019 12:17:50 -0700 (PDT)
Date: Wed, 9 Oct 2019 15:17:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/8] hw/acpi/piix4: Convert reset handler to DeviceReset
Message-ID: <20191009151638-mutt-send-email-mst@kernel.org>
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191008142539.7793-2-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Aleksandar Rikalo <arikalo@wavecomp.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 08, 2019 at 04:25:32PM +0200, Philippe Mathieu-Daud=E9 wrote:
> The PIIX4/PM is a PCI device within the PIIX4 chipset, it will be reset
> when the PCI bus it stands on is reset.
>=20
> Convert its reset handler into a proper Device reset method.
>=20
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to take through the misc tree.


> ---
>  hw/acpi/piix4.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 5742c3df87..4e079b39bd 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -27,7 +27,6 @@
>  #include "hw/pci/pci.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/acpi/acpi.h"
> -#include "sysemu/reset.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
> @@ -344,9 +343,9 @@ static const VMStateDescription vmstate_acpi =3D {
>      }
>  };
> =20
> -static void piix4_reset(void *opaque)
> +static void piix4_pm_reset(DeviceState *dev)
>  {
> -    PIIX4PMState *s =3D opaque;
> +    PIIX4PMState *s =3D PIIX4_PM(dev);
>      PCIDevice *d =3D PCI_DEVICE(s);
>      uint8_t *pci_conf =3D d->config;
> =20
> @@ -542,7 +541,6 @@ static void piix4_pm_realize(PCIDevice *dev, Error =
**errp)
> =20
>      s->machine_ready.notify =3D piix4_pm_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
> -    qemu_register_reset(piix4_reset, s);
> =20
>      piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
>                                     pci_get_bus(dev), s);
> @@ -692,6 +690,7 @@ static void piix4_pm_class_init(ObjectClass *klass,=
 void *data)
>      k->device_id =3D PCI_DEVICE_ID_INTEL_82371AB_3;
>      k->revision =3D 0x03;
>      k->class_id =3D PCI_CLASS_BRIDGE_OTHER;
> +    dc->reset =3D piix4_pm_reset;
>      dc->desc =3D "PM";
>      dc->vmsd =3D &vmstate_acpi;
>      dc->props =3D piix4_pm_properties;
> --=20
> 2.21.0

