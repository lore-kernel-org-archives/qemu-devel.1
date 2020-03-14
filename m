Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A760DC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62C6C221EB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 23:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C6C221EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDGbK-0004Pf-Il
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 19:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jDGab-0003vH-6j
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jDGaZ-0002Fn-SS
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 19:53:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:35498)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jDGaT-0001s7-2S; Sat, 14 Mar 2020 19:53:04 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1C574747E0F;
 Sun, 15 Mar 2020 00:52:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D9545747E04; Sun, 15 Mar 2020 00:52:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D74E9747DF8;
 Sun, 15 Mar 2020 00:52:49 +0100 (CET)
Date: Sun, 15 Mar 2020 00:52:49 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/8] hw/ide: Get rid of piix4_init function
In-Reply-To: <15adeb31-4bbc-0c98-4707-4f6b6c13498a@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003150038340.41905@zero.eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
 <15adeb31-4bbc-0c98-4707-4f6b6c13498a@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2131226626-1584229969=:41905"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2131226626-1584229969=:41905
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On Sat, 14 Mar 2020, Philippe Mathieu-Daud=E9 wrote:
> On 3/13/20 10:14 PM, BALATON Zoltan wrote:
>> This removes pci_piix4_ide_init() function similar to clean up done to
>> other ide devices.
>>=20
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ide/piix.c    | 12 +-----------
>>   hw/isa/piix4.c   |  5 ++++-
>>   include/hw/ide.h |  1 -
>>   3 files changed, 5 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
>> index 8bcd6b72c2..3b2de4c312 100644
>> --- a/hw/ide/piix.c
>> +++ b/hw/ide/piix.c
>> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>>       }
>>   }
>>   -/* hd_table must contain 4 block drivers */
>> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int=20
>> devfn)
>> -{
>> -    PCIDevice *dev;
>> -
>> -    dev =3D pci_create_simple(bus, devfn, "piix4-ide");
>> -    pci_ide_create_devs(dev, hd_table);
>> -    return dev;
>> -}
>> -
>>   /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>>   static void piix3_ide_class_init(ObjectClass *klass, void *data)
>>   {
>> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info =3D {
>>       .class_init    =3D piix3_ide_class_init,
>>   };
>>   +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>>   static void piix4_ide_class_init(ObjectClass *klass, void *data)
>>   {
>>       DeviceClass *dc =3D DEVICE_CLASS(klass);
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index 7edec5e149..0ab4787658 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -35,6 +35,7 @@
>>   #include "hw/timer/i8254.h"
>>   #include "hw/rtc/mc146818rtc.h"
>>   #include "hw/ide.h"
>> +#include "hw/ide/pci.h"
>>   #include "migration/vmstate.h"
>>   #include "sysemu/reset.h"
>>   #include "sysemu/runstate.h"
>> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABu=
s=20
>> **isa_bus,
>>           *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>>       }
>>   +    pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide")=
;
>
> Why are you re-assigning 'pci'?

Need a place to store it to pass to pci_ide_create_devs below and pci is=20
unused at this point so it can be reused for this.  (The variable pci=20
pointing to a PCIDevice was only used at the beginning of the function to=
=20
cast to dev then it's not needed any more.) Since this is very short func=
=20
and the reassign is right after its previous usage this should not be too=
=20
confusing and avoids needing to define another only once used variable fo=
t=20
this. See also patch 6 (http://patchwork.ozlabs.org/patch/1254687/) that=20
simplifies it further.

We could also do without this variable and write:

dev =3D DEVICE(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
              true, TYPE_PIIX4_PCI_DEVICE));

or after patch 6 even

pci_ide_create_devs(pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide=
"));

but I think those are less readable than reusing variable pci here.

Regards,
BALATON Zoltan

>>       hd =3D g_new(DriveInfo *, ide_drives);
>>       ide_drive_get(hd, ide_drives);
>> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
>> +    pci_ide_create_devs(pci, hd);
>>       g_free(hd);
>> +
>>       pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>>       if (smbus) {
>>           *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
>> diff --git a/include/hw/ide.h b/include/hw/ide.h
>> index 883bbaeb9b..21bd8f23f1 100644
>> --- a/include/hw/ide.h
>> +++ b/include/hw/ide.h
>> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int=
=20
>> iobase2, int isairq,
>>                           DriveInfo *hd0, DriveInfo *hd1);
>>     /* ide-pci.c */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int=20
>> devfn);
>>   int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>>     /* ide-mmio.c */
>>=20
>
>
--3866299591-2131226626-1584229969=:41905--

