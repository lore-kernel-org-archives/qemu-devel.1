Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1F0C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:27:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3069206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 09:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3069206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOHqu-00036V-42
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 05:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1jOHqD-0002cs-ML
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@jedlik.phy.bme.hu>) id 1jOHqC-00028U-ED
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:26:49 -0400
Received: from jedlik.phy.bme.hu ([152.66.102.83]:51654)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@jedlik.phy.bme.hu>)
 id 1jOHqC-0001qF-4C
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 05:26:48 -0400
Received: by jedlik.phy.bme.hu (Postfix, from userid 1000)
 id D8E02A0112; Tue, 14 Apr 2020 11:26:37 +0200 (CEST)
Date: Tue, 14 Apr 2020 11:26:37 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [PATCH-for-5.1 1/3] hw/ide/ahci: Use qdev gpio rather than
 qemu_allocate_irqs()
In-Reply-To: <CAKmqyKNP73-h02ubQaFvMC4UyhCjbLmRVPmC8OQ7NRJgyL4zBQ@mail.gmail.com>
Message-ID: <alpine.LMD.2.03.2004141125090.18346@eik.bme.hu>
References: <20200412212943.4117-1-f4bug@amsat.org>
 <20200412212943.4117-2-f4bug@amsat.org>
 <CAKmqyKNP73-h02ubQaFvMC4UyhCjbLmRVPmC8OQ7NRJgyL4zBQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LMD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="1117279078-1045050326-1586856397=:18346"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 152.66.102.83
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
 Qemu-block <qemu-block@nongnu.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stafford Horne <shorne@gmail.com>, John Snow <jsnow@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1117279078-1045050326-1586856397=:18346
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 13 Apr 2020, Alistair Francis wrote:
> On Sun, Apr 12, 2020 at 2:29 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org> wrote:
>> Switch to using the qdev gpio API which is preferred over
>> qemu_allocate_irqs(). One step to eventually deprecate and
>> remove qemu_allocate_irqs() one day.

Not only that, it also fixes leaking allocated irqs if ahci can be=20
plugged. (That was the reason for the original patch to fix the leak.)

Regards,
BALATON Zoltan

>> Patch created mechanically using spatch with this script
>> inspired from commit d6ef883d9d7:
>>
>>   @@
>>   typedef qemu_irq;
>>   identifier irqs, handler;
>>   expression opaque, count, i;
>>   @@
>>   -   qemu_irq *irqs;
>>       ...
>>   -   irqs =3D qemu_allocate_irqs(handler, opaque, count);
>>   +   qdev_init_gpio_in(DEVICE(opaque), handler, count);
>>       <+...
>>   -   irqs[i]
>>   +   qdev_get_gpio_in(DEVICE(opaque), i)
>>       ...+>
>>   ?-  g_free(irqs);
>>
>> Inspired-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
>> ---
>>  hw/ide/ahci.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index 13d91e109a..ef0a0a22ee 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -1534,19 +1534,18 @@ void ahci_init(AHCIState *s, DeviceState *qdev)
>>
>>  void ahci_realize(AHCIState *s, DeviceState *qdev, AddressSpace *as, in=
t ports)
>>  {
>> -    qemu_irq *irqs;
>>      int i;
>>
>>      s->as =3D as;
>>      s->ports =3D ports;
>>      s->dev =3D g_new0(AHCIDevice, ports);
>>      ahci_reg_init(s);
>> -    irqs =3D qemu_allocate_irqs(ahci_irq_set, s, s->ports);
>> +    qdev_init_gpio_in(DEVICE(s), ahci_irq_set, s->ports);
>>      for (i =3D 0; i < s->ports; i++) {
>>          AHCIDevice *ad =3D &s->dev[i];
>>
>>          ide_bus_new(&ad->port, sizeof(ad->port), qdev, i, 1);
>> -        ide_init2(&ad->port, irqs[i]);
>> +        ide_init2(&ad->port, qdev_get_gpio_in(DEVICE(s), i));
>>
>>          ad->hba =3D s;
>>          ad->port_no =3D i;
>> @@ -1554,7 +1553,6 @@ void ahci_realize(AHCIState *s, DeviceState *qdev,=
 AddressSpace *as, int ports)
>>          ad->port.dma->ops =3D &ahci_dma_ops;
>>          ide_register_restart_cb(&ad->port);
>>      }
>> -    g_free(irqs);
>>  }
>>
>>  void ahci_uninit(AHCIState *s)
>> --
>> 2.21.1
>>
>>
>
>
--1117279078-1045050326-1586856397=:18346--

