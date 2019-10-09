Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F27C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 986BB206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986BB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJmC-0007ve-ND
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iIHyg-0001uE-Pu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:50:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iIHye-0004qJ-RJ
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:50:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iIHyc-0004pB-UH
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 15:50:28 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E28892A09A7
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 19:50:24 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so1582839wro.10
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 12:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/E3AeJExrj7DtmKVuZxgjuwvZbpCvxq4YQ46zvIh+mU=;
 b=UNuHztIRUs/BTY+SJYKqSX770iCgfCd/sYj5J7vIMKCbTKaF4GBq0T9QVyc5ufaG5G
 hMg/7Vjhg8NFlY9vQXT0VxpPkBPomCW6qsM2VXZeDKjvxuOpzfvNnRidJc2U1oG1rOCr
 BDHLsL+CieG4HZe4ZKKjw0ADCk5f0A/ACpbe00AEihoN885+eNAu0GkPmpyc+Pk5oFg6
 4LWKRjI/74QnHw7mhtFIMxUJYh6wEovGVI0MRJtuRRmq80pruRS0vYm/8FLveC83Yuxc
 etwdFE4CcG0wkLGimbU75fgRHJ4i43n6QZSAWVDUB0M0a09up+KFUZFrSeRCjQxlVeCJ
 diMg==
X-Gm-Message-State: APjAAAU9HW8XC5AIAMm5wMYE1lMD4vGBlrfa+rym+V33yB/gE8j85s3x
 uR98O3O6FkQKgHb0sOVE+bT1RpA+8DPMt6DVXjW8+rnurXgq90axuxR4xL/7pCixn84KsJMYgGA
 /lkpA+csj0Hr+Dcg=
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr4562708wrr.91.1570650623683;
 Wed, 09 Oct 2019 12:50:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0moQsu9uF0AKRBw7KjZTZ2vqBj7iJ9U7FFMKeBqK7fVHxV/wumInGsD7QXVQBsooA6iVIlQ==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr4562668wrr.91.1570650623090;
 Wed, 09 Oct 2019 12:50:23 -0700 (PDT)
Received: from [192.168.1.35] (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id a3sm5507893wmc.3.2019.10.09.12.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 12:50:22 -0700 (PDT)
Subject: Re: [PATCH v2 3/8] hw/ide/piix: Convert reset handler to DeviceReset
To: Li Qiang <liq3ea@gmail.com>
References: <20191008142539.7793-1-philmd@redhat.com>
 <20191008142539.7793-4-philmd@redhat.com>
 <CAKXe6SJae07AS4OGaBt-WJoxCRpxZNGrOhfy1r68BfGK6wE5xQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b35971b-ed25-1755-3db5-72528c11c872@redhat.com>
Date: Wed, 9 Oct 2019 21:50:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJae07AS4OGaBt-WJoxCRpxZNGrOhfy1r68BfGK6wE5xQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 Qemu Developers <qemu-devel@nongnu.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/9/19 3:08 AM, Li Qiang wrote:
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com <mailto:philmd@redhat.co=
m>> =E4=BA=8E=20
> 2019=E5=B9=B410=E6=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=88=
10:32=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     The PIIX3/IDE is a PCI device within the PIIX3 chipset, it will be =
reset
>     when the PCI bus it stands on is reset.
>=20
>     Convert its reset handler into a proper Device reset method.
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com
>     <mailto:philmd@redhat.com>>
>     ---
>      =C2=A0hw/ide/piix.c | 8 +++-----
>      =C2=A01 file changed, 3 insertions(+), 5 deletions(-)
>=20
>     diff --git a/hw/ide/piix.c b/hw/ide/piix.c
>     index fba6bc8bff..18b2c3b722 100644
>     --- a/hw/ide/piix.c
>     +++ b/hw/ide/piix.c
>     @@ -30,7 +30,6 @@
>      =C2=A0#include "sysemu/block-backend.h"
>      =C2=A0#include "sysemu/blockdev.h"
>      =C2=A0#include "sysemu/dma.h"
>     -#include "sysemu/reset.h"
>=20
>      =C2=A0#include "hw/ide/pci.h"
>      =C2=A0#include "trace.h"
>     @@ -103,9 +102,9 @@ static void bmdma_setup_bar(PCIIDEState *d)
>      =C2=A0 =C2=A0 =C2=A0}
>      =C2=A0}
>=20
>     -static void piix3_reset(void *opaque)
>     +static void piix3_ide_reset(DeviceState *dev)
>      =C2=A0{
>     -=C2=A0 =C2=A0 PCIIDEState *d =3D opaque;
>     +=C2=A0 =C2=A0 PCIIDEState *d =3D PCI_IDE(dev);
>      =C2=A0 =C2=A0 =C2=A0PCIDevice *pd =3D PCI_DEVICE(d);
>      =C2=A0 =C2=A0 =C2=A0uint8_t *pci_conf =3D pd->config;
>      =C2=A0 =C2=A0 =C2=A0int i;
>     @@ -154,8 +153,6 @@ static void pci_piix_ide_realize(PCIDevice *dev=
,
>     Error **errp)
>=20
>      =C2=A0 =C2=A0 =C2=A0pci_conf[PCI_CLASS_PROG] =3D 0x80; // legacy A=
TA mode
>=20
>     -=C2=A0 =C2=A0 qemu_register_reset(piix3_reset, d);
>     -
>      =C2=A0 =C2=A0 =C2=A0bmdma_setup_bar(d);
>      =C2=A0 =C2=A0 =C2=A0pci_register_bar(dev, 4, PCI_BASE_ADDRESS_SPAC=
E_IO,
>     &d->bmdma_bar);
>=20
>     @@ -247,6 +244,7 @@ static void piix3_ide_class_init(ObjectClass
>     *klass, void *data)
>      =C2=A0 =C2=A0 =C2=A0DeviceClass *dc =3D DEVICE_CLASS(klass);
>      =C2=A0 =C2=A0 =C2=A0PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
>=20
>     +=C2=A0 =C2=A0 dc->reset =3D piix3_ide_reset;
>      =C2=A0 =C2=A0 =C2=A0k->realize =3D pci_piix_ide_realize;
>      =C2=A0 =C2=A0 =C2=A0k->exit =3D pci_piix_ide_exitfn;
>      =C2=A0 =C2=A0 =C2=A0k->vendor_id =3D PCI_VENDOR_ID_INTEL;
>     --=20
>=20
>=20
>=20
> Shouldn't we also add the reset callback for piix4 ide device?

Yes! You catched a nice bug which would have rendered the Malta board=20
broken on reboot, thanks a lot!

Phil.

