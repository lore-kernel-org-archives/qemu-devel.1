Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ED7C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:11:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C631205ED
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 12:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C631205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDS6y-0005Ep-Gx
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 08:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jDS42-0003zM-V2
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 08:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jDS41-000424-QE
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 08:08:18 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12387)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jDS3y-0003ey-Bd; Sun, 15 Mar 2020 08:08:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A4093747E04;
 Sun, 15 Mar 2020 13:08:09 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 75A0E747DFD; Sun, 15 Mar 2020 13:08:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 72FE2747DFA;
 Sun, 15 Mar 2020 13:08:09 +0100 (CET)
Date: Sun, 15 Mar 2020 13:08:09 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/8] hw/ide: Get rid of piix4_init function
In-Reply-To: <20200315013319-mutt-send-email-mst@kernel.org>
Message-ID: <alpine.BSF.2.22.395.2003151305001.2802@zero.eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584134074.git.balaton@eik.bme.hu>
 <20200315013319-mutt-send-email-mst@kernel.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
 John Snow <jsnow@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 15 Mar 2020, Michael S. Tsirkin wrote:
> On Fri, Mar 13, 2020 at 10:14:34PM +0100, BALATON Zoltan wrote:
>> This removes pci_piix4_ide_init() function similar to clean up done to
>> other ide devices.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ide/piix.c    | 12 +-----------
>>  hw/isa/piix4.c   |  5 ++++-
>>  include/hw/ide.h |  1 -
>>  3 files changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/ide/piix.c b/hw/ide/piix.c
>> index 8bcd6b72c2..3b2de4c312 100644
>> --- a/hw/ide/piix.c
>> +++ b/hw/ide/piix.c
>> @@ -208,17 +208,6 @@ static void pci_piix_ide_exitfn(PCIDevice *dev)
>>      }
>>  }
>>
>> -/* hd_table must contain 4 block drivers */
>> -/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn)
>> -{
>> -    PCIDevice *dev;
>> -
>> -    dev = pci_create_simple(bus, devfn, "piix4-ide");
>> -    pci_ide_create_devs(dev, hd_table);
>> -    return dev;
>> -}
>> -
>>  /* NOTE: for the PIIX3, the IRQs and IOports are hardcoded */
>>  static void piix3_ide_class_init(ObjectClass *klass, void *data)
>>  {
>> @@ -247,6 +236,7 @@ static const TypeInfo piix3_ide_xen_info = {
>>      .class_init    = piix3_ide_class_init,
>>  };
>>
>> +/* NOTE: for the PIIX4, the IRQs and IOports are hardcoded */
>>  static void piix4_ide_class_init(ObjectClass *klass, void *data)
>>  {
>>      DeviceClass *dc = DEVICE_CLASS(klass);
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index 7edec5e149..0ab4787658 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -35,6 +35,7 @@
>>  #include "hw/timer/i8254.h"
>>  #include "hw/rtc/mc146818rtc.h"
>>  #include "hw/ide.h"
>> +#include "hw/ide/pci.h"
>>  #include "migration/vmstate.h"
>>  #include "sysemu/reset.h"
>>  #include "sysemu/runstate.h"
>> @@ -255,10 +256,12 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus,
>>          *isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
>>      }
>>
>> +    pci = pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
>>      hd = g_new(DriveInfo *, ide_drives);
>>      ide_drive_get(hd, ide_drives);
>> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
>> +    pci_ide_create_devs(pci, hd);
>>      g_free(hd);
>> +
>
> Why not move pci_create_simple down, and declare a new variable?
> -    pci_piix4_ide_init(pci_bus, hd, pci->devfn + 1);
> +    pci_dev = pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
> +    pci_ide_create_devs(pci_dev, hd);
>
> makes it clearer what's going on imho.

Ends up there after patch 6. Do you still think a new variable would be 
needed for this after that patch? It's pretty simple and clear without all 
the hd array stuff even reusing pci variable. (Or I could rename pci to 
pci_dev but really don't think it worth having two once used variable in 
such a simple function. Normally such variables are called dev but in this 
function that name is taken for a DeviceState *variable.)

Regards,
BALATON Zoltan

>
>>      pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
>>      if (smbus) {
>>          *smbus = piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
>> diff --git a/include/hw/ide.h b/include/hw/ide.h
>> index 883bbaeb9b..21bd8f23f1 100644
>> --- a/include/hw/ide.h
>> +++ b/include/hw/ide.h
>> @@ -12,7 +12,6 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int isairq,
>>                          DriveInfo *hd0, DriveInfo *hd1);
>>
>>  /* ide-pci.c */
>> -PCIDevice *pci_piix4_ide_init(PCIBus *bus, DriveInfo **hd_table, int devfn);
>>  int pci_piix3_xen_ide_unplug(DeviceState *dev, bool aux);
>>
>>  /* ide-mmio.c */
>> --
>> 2.21.1
>
>

