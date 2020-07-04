Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28792C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:13:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D84E62145D
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6n2jsij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D84E62145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrmfH-0005Ly-4C
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:13:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrmeZ-0004jg-1H; Sat, 04 Jul 2020 14:12:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrmeX-00078Q-1h; Sat, 04 Jul 2020 14:12:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id z15so24790543wrl.8;
 Sat, 04 Jul 2020 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dR5yAbM94Oarj3h8zuGYtWJaMflsDMqLOxHo7EbP8gI=;
 b=u6n2jsij5oAqs6s+fzbL8Jk30AKCjpTP3V+d/MUa3F29sfC+NU3p0TuAHlBJq2tUXI
 w4/BoQpthsGaZdYWUW/T07EpyNQYh2q78UumTwp2KNxsFe8vAKl0sdK6cW8/DjaCYo8i
 FwNSf77oq4kAprNundvFZWgHGL43IdYtGMXQ6Ma1XGcD0UTOnIlj4Z4cyt+wDLnFhA5T
 HkponJU6Rv5WH2YRA5Yw5K0ZQFfRJULheyqYSM9WaDlvPw2gIXeToIlFgtRhpW9PhCTA
 0RnkOXfCJfxLyoqm/dRKGk/YefB9WtZN41MLkmeSfDaEgoPZqF/gyLBU9WIJPNIFZ55I
 uIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dR5yAbM94Oarj3h8zuGYtWJaMflsDMqLOxHo7EbP8gI=;
 b=Wzp4GiGx8V1trrrYVlDSeU7zvVfnQ6uBUq4tRBhIW4aLMF1mDa3CmNmmf4GaJblwhh
 pRj1BGk5StMfeBAYdDoiRsXYQXFmloNt+e8sbnUbGqpY3L9jAyTbHs+EgLO2lGxuy7OQ
 opxynPw0pPdSiEfRDnvOCWOCMzEfl59+zLI2j/EIb0e/Hb2wspwfeZ/CVkVupDBp3VKj
 olVsEC16Csoz6wdmGUZDsvTkIELAQVvufC7SfDfEtJbmdlBxa3dj9pRU0bnYEobe5e7M
 fin0AsRmQu9WgRHQXbEuElxy4Y/tznGdFhpuVmBMJ7K7CIYosmEvLGKuhCeCtd+gynPV
 cLkg==
X-Gm-Message-State: AOAM532Jffkpr1KfSMbMM66i7nR9J7IMN+Oxy9aYDrVBEzdr5S6Nwpwm
 9HYZ24UzQDwSt73t6uDxSSA=
X-Google-Smtp-Source: ABdhPJxOLfAMmahMaoYf1dyoxeHrbYNeWnj1XcQlMEhgj7aLv2DVhmCoQZ8rP4y0uYhA5TedskmrPw==
X-Received: by 2002:adf:c44d:: with SMTP id a13mr42892704wrg.205.1593886358792; 
 Sat, 04 Jul 2020 11:12:38 -0700 (PDT)
Received: from [192.168.1.39] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h13sm17258467wml.42.2020.07.04.11.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Jul 2020 11:12:37 -0700 (PDT)
Subject: Re: [PATCH 24/26] hw/usb/usb-hcd: Use UHCI type definitions
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-25-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2007041916060.92265@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f19dc1c9-8b72-695b-bce1-660e547e5658@amsat.org>
Date: Sat, 4 Jul 2020 20:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2007041916060.92265@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paul Zimmerman <pauldzim@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/4/20 7:17 PM, BALATON Zoltan wrote:
> On Sat, 4 Jul 2020, Philippe Mathieu-Daudé wrote:
>> Various machine/board/soc models create UHCI device instances
>> with the generic QDEV API, and don't need to access USB internals.
>>
>> Simplify header inclusions by moving the QOM type names into a
>> simple header, with no need to include other "hw/usb" headers.
>>
>> Suggested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>> include/hw/usb/usb-hcd.h |  6 ++++++
>> hw/i386/pc_piix.c        |  3 ++-
>> hw/i386/pc_q35.c         | 13 +++++++------
>> hw/isa/piix4.c           |  3 ++-
>> hw/mips/fuloong2e.c      |  5 +++--
>> hw/usb/hcd-uhci.c        | 19 ++++++++++---------
>> 6 files changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/include/hw/usb/usb-hcd.h b/include/hw/usb/usb-hcd.h
>> index 74af3a4533..c9d0a88984 100644
>> --- a/include/hw/usb/usb-hcd.h
>> +++ b/include/hw/usb/usb-hcd.h
>> @@ -24,4 +24,10 @@
>> #define TYPE_FUSBH200_EHCI          "fusbh200-ehci-usb"
>> #define TYPE_CHIPIDEA               "usb-chipidea"
>>
>> +/* UHCI */
>> +#define TYPE_PIIX3_USB_UHCI         "piix3-usb-uhci"
>> +#define TYPE_PIIX4_USB_UHCI         "piix4-usb-uhci"
>> +#define TYPE_VT82C686B_USB_UHCI     "vt82c686b-usb-uhci"
>> +#define TYPE_ICH9_USB_UHCI(n)       "ich9-usb-uhci" #n
> 
> What is that #n at the end? Looks like a typo. Does it break compilation?

#n is a C preprocessor feature that expand the 'n' argument to a "n"
string, so:

TYPE_ICH9_USB_UHCI(1) = "ich9-usb-uhci" #1
                      = "ich9-usb-uhci" "1"
                      = "ich9-usb-uhci1"

I'm pretty sure we use that elsewhere. If not, I can add a definition
for each 1 ... 6 typenames.

> 
> Regards,
> BALATON Zoltan
> 
>> +
>> #endif
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index 4d1de7cfab..0024c346c6 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -37,6 +37,7 @@
>> #include "hw/pci/pci.h"
>> #include "hw/pci/pci_ids.h"
>> #include "hw/usb/usb.h"
>> +#include "hw/usb/usb-hcd.h"
>> #include "net/net.h"
>> #include "hw/ide/pci.h"
>> #include "hw/irq.h"
>> @@ -275,7 +276,7 @@ static void pc_init1(MachineState *machine,
>> #endif
>>
>>     if (pcmc->pci_enabled && machine_usb(machine)) {
>> -        pci_create_simple(pci_bus, piix3_devfn + 2, "piix3-usb-uhci");
>> +        pci_create_simple(pci_bus, piix3_devfn + 2,
>> TYPE_PIIX3_USB_UHCI);
>>     }
>>
>>     if (pcmc->pci_enabled &&
>> x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index b985f5bea1..a80527e6ed 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -51,6 +51,7 @@
>> #include "hw/ide/pci.h"
>> #include "hw/ide/ahci.h"
>> #include "hw/usb/usb.h"
>> +#include "hw/usb/usb-hcd.h"
>> #include "qapi/error.h"
>> #include "qemu/error-report.h"
>> #include "sysemu/numa.h"
>> @@ -68,15 +69,15 @@ struct ehci_companions {
>> };
>>
>> static const struct ehci_companions ich9_1d[] = {
>> -    { .name = "ich9-usb-uhci1", .func = 0, .port = 0 },
>> -    { .name = "ich9-usb-uhci2", .func = 1, .port = 2 },
>> -    { .name = "ich9-usb-uhci3", .func = 2, .port = 4 },
>> +    { .name = TYPE_ICH9_USB_UHCI(1), .func = 0, .port = 0 },
>> +    { .name = TYPE_ICH9_USB_UHCI(2), .func = 1, .port = 2 },
>> +    { .name = TYPE_ICH9_USB_UHCI(3), .func = 2, .port = 4 },
>> };
>>
>> static const struct ehci_companions ich9_1a[] = {
>> -    { .name = "ich9-usb-uhci4", .func = 0, .port = 0 },
>> -    { .name = "ich9-usb-uhci5", .func = 1, .port = 2 },
>> -    { .name = "ich9-usb-uhci6", .func = 2, .port = 4 },
>> +    { .name = TYPE_ICH9_USB_UHCI(4), .func = 0, .port = 0 },
>> +    { .name = TYPE_ICH9_USB_UHCI(5), .func = 1, .port = 2 },
>> +    { .name = TYPE_ICH9_USB_UHCI(6), .func = 2, .port = 4 },
>> };
>>
>> static int ehci_create_ich9_with_companions(PCIBus *bus, int slot)
>> diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
>> index f634bcb2d1..e11e5fae21 100644
>> --- a/hw/isa/piix4.c
>> +++ b/hw/isa/piix4.c
>> @@ -29,6 +29,7 @@
>> #include "hw/southbridge/piix.h"
>> #include "hw/pci/pci.h"
>> #include "hw/isa/isa.h"
>> +#include "hw/usb/usb-hcd.h"
>> #include "hw/sysbus.h"
>> #include "hw/intc/i8259.h"
>> #include "hw/dma/i8257.h"
>> @@ -255,7 +256,7 @@ DeviceState *piix4_create(PCIBus *pci_bus, ISABus
>> **isa_bus, I2CBus **smbus)
>>     pci = pci_create_simple(pci_bus, devfn + 1, "piix4-ide");
>>     pci_ide_create_devs(pci);
>>
>> -    pci_create_simple(pci_bus, devfn + 2, "piix4-usb-uhci");
>> +    pci_create_simple(pci_bus, devfn + 2, TYPE_PIIX4_USB_UHCI);
>>     if (smbus) {
>>         *smbus = piix4_pm_init(pci_bus, devfn + 3, 0x1100,
>>                                isa_get_irq(NULL, 9), NULL, 0, NULL);
>> diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
>> index 8ca31e5162..b6d33dd2cd 100644
>> --- a/hw/mips/fuloong2e.c
>> +++ b/hw/mips/fuloong2e.c
>> @@ -33,6 +33,7 @@
>> #include "hw/mips/mips.h"
>> #include "hw/mips/cpudevs.h"
>> #include "hw/pci/pci.h"
>> +#include "hw/usb/usb-hcd.h"
>> #include "qemu/log.h"
>> #include "hw/loader.h"
>> #include "hw/ide/pci.h"
>> @@ -258,8 +259,8 @@ static void vt82c686b_southbridge_init(PCIBus
>> *pci_bus, int slot, qemu_irq intc,
>>     dev = pci_create_simple(pci_bus, PCI_DEVFN(slot, 1), "via-ide");
>>     pci_ide_create_devs(dev);
>>
>> -    pci_create_simple(pci_bus, PCI_DEVFN(slot, 2),
>> "vt82c686b-usb-uhci");
>> -    pci_create_simple(pci_bus, PCI_DEVFN(slot, 3),
>> "vt82c686b-usb-uhci");
>> +    pci_create_simple(pci_bus, PCI_DEVFN(slot, 2),
>> TYPE_VT82C686B_USB_UHCI);
>> +    pci_create_simple(pci_bus, PCI_DEVFN(slot, 3),
>> TYPE_VT82C686B_USB_UHCI);
>>
>>     *i2c_bus = vt82c686b_pm_init(pci_bus, PCI_DEVFN(slot, 4), 0xeee1,
>> NULL);
>>
>> diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
>> index 1d4dd33b6c..da078dc3fa 100644
>> --- a/hw/usb/hcd-uhci.c
>> +++ b/hw/usb/hcd-uhci.c
>> @@ -39,6 +39,7 @@
>> #include "qemu/main-loop.h"
>> #include "qemu/module.h"
>> #include "usb-internal.h"
>> +#include "hw/usb/usb-hcd.h"
>>
>> #define FRAME_TIMER_FREQ 1000
>>
>> @@ -1358,21 +1359,21 @@ static void uhci_data_class_init(ObjectClass
>> *klass, void *data)
>>
>> static UHCIInfo uhci_info[] = {
>>     {
>> -        .name       = "piix3-usb-uhci",
>> +        .name      = TYPE_PIIX3_USB_UHCI,
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82371SB_2,
>>         .revision  = 0x01,
>>         .irq_pin   = 3,
>>         .unplug    = true,
>>     },{
>> -        .name      = "piix4-usb-uhci",
>> +        .name      = TYPE_PIIX4_USB_UHCI,
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82371AB_2,
>>         .revision  = 0x01,
>>         .irq_pin   = 3,
>>         .unplug    = true,
>>     },{
>> -        .name      = "vt82c686b-usb-uhci",
>> +        .name      = TYPE_VT82C686B_USB_UHCI,
>>         .vendor_id = PCI_VENDOR_ID_VIA,
>>         .device_id = PCI_DEVICE_ID_VIA_UHCI,
>>         .revision  = 0x01,
>> @@ -1380,42 +1381,42 @@ static UHCIInfo uhci_info[] = {
>>         .realize   = usb_uhci_vt82c686b_realize,
>>         .unplug    = true,
>>     },{
>> -        .name      = "ich9-usb-uhci1", /* 00:1d.0 */
>> +        .name      = TYPE_ICH9_USB_UHCI(1), /* 00:1d.0 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI1,
>>         .revision  = 0x03,
>>         .irq_pin   = 0,
>>         .unplug    = false,
>>     },{
>> -        .name      = "ich9-usb-uhci2", /* 00:1d.1 */
>> +        .name      = TYPE_ICH9_USB_UHCI(2), /* 00:1d.1 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI2,
>>         .revision  = 0x03,
>>         .irq_pin   = 1,
>>         .unplug    = false,
>>     },{
>> -        .name      = "ich9-usb-uhci3", /* 00:1d.2 */
>> +        .name      = TYPE_ICH9_USB_UHCI(3), /* 00:1d.2 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI3,
>>         .revision  = 0x03,
>>         .irq_pin   = 2,
>>         .unplug    = false,
>>     },{
>> -        .name      = "ich9-usb-uhci4", /* 00:1a.0 */
>> +        .name      = TYPE_ICH9_USB_UHCI(4), /* 00:1a.0 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI4,
>>         .revision  = 0x03,
>>         .irq_pin   = 0,
>>         .unplug    = false,
>>     },{
>> -        .name      = "ich9-usb-uhci5", /* 00:1a.1 */
>> +        .name      = TYPE_ICH9_USB_UHCI(5), /* 00:1a.1 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI5,
>>         .revision  = 0x03,
>>         .irq_pin   = 1,
>>         .unplug    = false,
>>     },{
>> -        .name      = "ich9-usb-uhci6", /* 00:1a.2 */
>> +        .name      = TYPE_ICH9_USB_UHCI(6), /* 00:1a.2 */
>>         .vendor_id = PCI_VENDOR_ID_INTEL,
>>         .device_id = PCI_DEVICE_ID_INTEL_82801I_UHCI6,
>>         .revision  = 0x03,
>>

