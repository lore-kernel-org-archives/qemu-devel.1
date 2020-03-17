Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78037C18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:06:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7A4205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 14:06:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7A4205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jECrU-00070s-Ep
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 10:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jECqc-0006aY-UI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jECqX-0000wd-SG
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 10:05:34 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:38707)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jECqS-0007TF-Ux; Tue, 17 Mar 2020 10:05:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E0A88747E0B;
 Tue, 17 Mar 2020 15:05:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B9B3F747E06; Tue, 17 Mar 2020 15:05:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B79F8747E0A;
 Tue, 17 Mar 2020 15:05:15 +0100 (CET)
Date: Tue, 17 Mar 2020 15:05:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 2/7] hw/ide: Get rid of piix4_init function
In-Reply-To: <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003171455360.40468@zero.eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
 <3240656814c804513de08bdbbf318f2f590df241.1584437958.git.balaton@eik.bme.hu>
 <c43e2f9b-3002-32f0-08fa-7164a98f3b9f@redhat.com>
 <f70ea487-c8e8-d76d-fbe5-9213284a8574@redhat.com>
 <2038186d-3f18-d430-2305-5697097397e9@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-180044680-1584453889=:40468"
Content-ID: <alpine.BSF.2.22.395.2003171505130.40468@zero.eik.bme.hu>
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
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-180044680-1584453889=:40468
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-ID: <alpine.BSF.2.22.395.2003171505131.40468@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Mar 2020, John Snow wrote:
> On 3/17/20 6:49 AM, Philippe Mathieu-Daud=E9 wrote:
>> On 3/17/20 11:41 AM, Philippe Mathieu-Daud=E9 wrote:
>>> On 3/17/20 10:39 AM, BALATON Zoltan wrote:
>>>> This removes pci_piix4_ide_init() function similar to clean up done =
to
>>>> other ide devices.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>>
>>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>>
>> Please disregard this tag (I withdraw it), I mis-read the pci variable
>> was not assigned.
>>
>
> Is there an issue you've noticed, or you are just no longer certain
> enough to give an RB?

My previous replies to this question:

https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg04356.html
https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg04381.html

End result after all patches in the series looks like this:

DeviceState *piix4_create(PCIBus *pci_bus, ISABus **isa_bus, I2CBus **smb=
us)
{
     PCIDevice *pci;
     DeviceState *dev;

     pci =3D pci_create_simple_multifunction(pci_bus, PCI_DEVFN(10, 0),
                                           true, TYPE_PIIX4_PCI_DEVICE);
     dev =3D DEVICE(pci);
     if (isa_bus) {
         *isa_bus =3D ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
     }

     pci =3D pci_create_simple(pci_bus, pci->devfn + 1, "piix4-ide");
     pci_ide_create_devs(pci);

     pci_create_simple(pci_bus, pci->devfn + 2, "piix4-usb-uhci");
     if (smbus) {
         *smbus =3D piix4_pm_init(pci_bus, pci->devfn + 3, 0x1100,
                                isa_get_irq(NULL, 9), NULL, 0, NULL);
    }

     return dev;
}

I think it's clear enough what the pci variable is used for here and ther=
e=20
was no further reply from Philippe and Michael and others were OK with=20
this so there was no definitive decision here. Mayby Philippe still does=20
not like reusal of this variable enough to give Reviewed tag but there=20
should be no other problem with it otherwise.

Regards,
BALATON Zoltan
--3866299591-180044680-1584453889=:40468--

