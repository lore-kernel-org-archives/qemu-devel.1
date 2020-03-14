Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2010C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:00:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 977EF2051A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 22:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3n/1dLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 977EF2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDEpu-0002vF-UE
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 18:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDEoz-0002Mk-1H
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDEox-0004PC-HG
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:59:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22066
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDEox-0004O9-DU
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 17:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584223191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ew9CrdK+kA19Vb8ecJwdOfg4MQFT/+3q/eqPQ44+ac=;
 b=Y3n/1dLPKky2mFJ5FYHnf0BB+bbZWE3JbuYSb+bG+D9uqDWtvsMGtCyJdkQom0RrjHtqEY
 alykPcB+JxuwQAP3X7UEIqk3eOtrMu0/KFCrXJFXVmKpa+Rh3nGjQ4QSItrmp/vYMpL3AK
 7MpWZG/kpmaAZ5Q9djxX9pvjSJwybf4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-zFQM1Ma_NMSMpm501BYY2Q-1; Sat, 14 Mar 2020 17:59:49 -0400
X-MC-Unique: zFQM1Ma_NMSMpm501BYY2Q-1
Received: by mail-wr1-f71.google.com with SMTP id n11so5997560wrs.13
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 14:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDx6BnLAy6tzAaPar9VG3sNRIKPCaCpjL3mqBYf0RYU=;
 b=A+IXmSV/ehtV4ksgRkfW7/wjc2CZHPesTWseQ3rpScCHm31OuHyJ1jZnamxOWqmEDU
 xST2RM/Nbh/qskkYMyTljmB3q6hcwx7F+In0NEyyXqJ2V9z0zqqWnDZ17D1V2cA5/M1g
 0Gghl4tXiwPgKT9GOVCVE5g62e7wIiIBsqY1Q8oeH3Pfxdg0U9Pgs/vUz6vJ56YCHcEL
 /VfXV7RAlC8J743FYZ+yahFFCYmkfVFQY51n/Sg1EuIMqFAAGQRaXGbqdbw/QupIu07w
 UORYANUfh5ckJUNyx9/fa35+9KlTkLpcoQLgkfEHUK8ej9EBsnSsqmkzOY6MWq1SoeID
 MTHQ==
X-Gm-Message-State: ANhLgQ3EmH7NGLEKD88M9BQuQDC+qeJJpcqGG/HO5Fvm7KcrEU3IMXPk
 ch2ILApPjFpUGh/osduJKZE6vnuto7AYmmWRAunOHGwqkLRS3DtsXZLaBZOswrG7hGaEbeKfd1l
 fyDlJt0zyaZQ9+vI=
X-Received: by 2002:adf:82b0:: with SMTP id 45mr12879290wrc.120.1584223188147; 
 Sat, 14 Mar 2020 14:59:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUWmCjoWMLAumw53bQbOBiyHS2/SL4IHQFxLlfgSsDYsqjvZL0aIcZ9Zv3p8miWd4TT/a4cg==
X-Received: by 2002:adf:82b0:: with SMTP id 45mr12879267wrc.120.1584223187915; 
 Sat, 14 Mar 2020 14:59:47 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id v14sm50107535wrr.34.2020.03.14.14.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 14:59:47 -0700 (PDT)
Subject: Re: [PATCH 1/8] hw/ide: Get rid of piix3_init functions
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <adddfa21552783020d64e1314318cab6d24362c3.1584134074.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4b7c83a6-618a-41a4-9c87-32c21a1f1129@redhat.com>
Date: Sat, 14 Mar 2020 22:59:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <adddfa21552783020d64e1314318cab6d24362c3.1584134074.git.balaton@eik.bme.hu>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/13/20 10:14 PM, BALATON Zoltan wrote:
> This removes pci_piix3_ide_init() and pci_piix3_xen_ide_init()
> functions similar to clean up done to other ide devices.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

> ---
>   hw/i386/pc_piix.c | 10 +++++-----
>   hw/ide/pci.c      |  1 +
>   hw/ide/piix.c     | 21 +--------------------
>   include/hw/ide.h  |  2 --
>   4 files changed, 7 insertions(+), 27 deletions(-)
>=20
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index e2d98243bc..c399398739 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -39,6 +39,7 @@
>   #include "hw/usb.h"
>   #include "net/net.h"
>   #include "hw/ide.h"
> +#include "hw/ide/pci.h"
>   #include "hw/irq.h"
>   #include "sysemu/kvm.h"
>   #include "hw/kvm/clock.h"
> @@ -242,11 +243,10 @@ static void pc_init1(MachineState *machine,
>       ide_drive_get(hd, ARRAY_SIZE(hd));
>       if (pcmc->pci_enabled) {
>           PCIDevice *dev;
> -        if (xen_enabled()) {
> -            dev =3D pci_piix3_xen_ide_init(pci_bus, hd, piix3_devfn + 1)=
;
> -        } else {
> -            dev =3D pci_piix3_ide_init(pci_bus, hd, piix3_devfn + 1);
> -        }
> +
> +        dev =3D pci_create_simple(pci_bus, piix3_devfn + 1,
> +                                xen_enabled() ? "piix3-ide-xen" : "piix3=
-ide");
> +        pci_ide_create_devs(dev, hd);
>           idebus[0] =3D qdev_get_child_bus(&dev->qdev, "ide.0");
>           idebus[1] =3D qdev_get_child_bus(&dev->qdev, "ide.1");
>           pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 1a6a287e76..4fc76c5225 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -476,6 +476,7 @@ const VMStateDescription vmstate_ide_pci =3D {
>       }
>   };
>  =20
> +/* hd_table must contain 4 block drivers */
>   void pci_ide_create_devs(PCIDevice *dev, DriveInfo **hd_table)
>   {
>       PCIIDEState *d =3D PCI_IDE(dev);
> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
> index bc575b4d70..8bcd6b72c2 100644
> --- a/hw/ide/piix.c
> +++ b/hw/ide/piix.c
> @@ -197,15 +197,6 @@ int pci_piix3_xen_ide_unplug(DeviceState *dev, bool =
aux)
>       return 0;
>   }
>  =20
> -PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int=
 devfn)
> -{
> -    PCIDevice *dev;
> -
> -    dev =3D pci_create_simple(bus, devfn, "piix3-ide-xen");
> -    pci_ide_create_devs(dev, hd_table);
> -    return dev;
> -}
> -
>   static void pci_piix_ide_exitfn(PCIDevice *dev)
>   {
>       PCIIDEState *d =3D PCI_IDE(dev);
> @@ -217,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>       }
>   }
>  =20
> -/* hd_table must contain 4 block drivers */
> -/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
> -PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn)
> -{
> -    PCIDevice *dev;
> -
> -    dev =3D pci_create_simple(bus, devfn, "piix3-ide");
> -    pci_ide_create_devs(dev, hd_table);
> -    return dev;
> -}
> -
>   /* hd_table must contain 4 block drivers */
>   /* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>   PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int de=
vfn)
> @@ -239,6 +219,7 @@ PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo =
**hd_table, int devfn)
>       return dev;
>   }
>  =20
> +/* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>   static void piix3_ide_class_init(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc =3D DEVICE_CLASS(klass);
> diff --git a/include/hw/ide.h b/include/hw/ide.h
> index dea0ecf5be..883bbaeb9b 100644
> --- a/include/hw/ide.h
> +++ b/include/hw/ide.h
> @@ -12,8 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int io=
base2, int isairq,
>                           DriveInfo *hd0, DriveInfo *hd1);
>  =20
>   /* ide-pci.c */
> -PCIDevice *pci_piix3_xen_ide_init(PCIBus *bus, DriveInfo **hd_table, int=
 devfn);
> -PCIDevice *pci_piix3_ide_init(PCIBus *bus, DriveInfo **hd_table, int dev=
fn);
>   PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int de=
vfn);
>   int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>  =20
>=20


