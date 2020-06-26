Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D7EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 143982089D
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143982089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowwJ-00005N-Bu
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jownD-00067a-OR; Fri, 26 Jun 2020 18:25:55 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:32549)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jownB-0005G8-O3; Fri, 26 Jun 2020 18:25:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4633374632C;
 Sat, 27 Jun 2020 00:25:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2553F745712; Sat, 27 Jun 2020 00:25:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 238E87456F8;
 Sat, 27 Jun 2020 00:25:50 +0200 (CEST)
Date: Sat, 27 Jun 2020 00:25:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 07/11] mac_oldworld: Map macio to expected address at
 reset
In-Reply-To: <d8db3e1f-6421-ea36-8598-60e9d98f54fa@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006270022470.64843@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <a0b567bf6e5b266a19de4eb6f6551270ffe2ce7b.1592315226.git.balaton@eik.bme.hu>
 <d8db3e1f-6421-ea36-8598-60e9d98f54fa@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020, Mark Cave-Ayland wrote:
> On 16/06/2020 14:47, BALATON Zoltan wrote:
>> Add a reset function that maps macio to the address expected by the
>> firmware of the board at startup.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/mac.h          | 12 ++++++++++++
>>  hw/ppc/mac_oldworld.c | 15 ++++++++++++++-
>>  2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
>> index a0d9e47031..79ccf8775d 100644
>> --- a/hw/ppc/mac.h
>> +++ b/hw/ppc/mac.h
>> @@ -55,6 +55,18 @@
>>  #define OLDWORLD_IDE1_IRQ      0xe
>>  #define OLDWORLD_IDE1_DMA_IRQ  0x3
>>
>> +/* g3beige machine */
>> +#define TYPE_HEATHROW_MACHINE MACHINE_TYPE_NAME("g3beige")
>> +#define HEATHROW_MACHINE(obj) OBJECT_CHECK(HeathrowMachineState, (obj), \
>> +                                           TYPE_HEATHROW_MACHINE)
>> +
>> +typedef struct HeathrowMachineState {
>> +    /*< private >*/
>> +    MachineState parent;
>> +
>> +    PCIDevice *macio;
>> +} HeathrowMachineState;
>> +
>>  /* New World IRQs */
>>  #define NEWWORLD_CUDA_IRQ      0x19
>>  #define NEWWORLD_PMU_IRQ       0x19
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index f97f241e0c..13562e26e6 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -73,6 +73,15 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>>  }
>>
>> +static void ppc_heathrow_reset(MachineState *machine)
>> +{
>> +    HeathrowMachineState *m = HEATHROW_MACHINE(machine);
>> +
>> +    qemu_devices_reset();
>> +    pci_default_write_config(m->macio, PCI_COMMAND, PCI_COMMAND_MEMORY, 2);
>> +    pci_default_write_config(m->macio, PCI_BASE_ADDRESS_0, 0xf3000000, 4);
>> +}
>
> As per my comment on a previous version, this doesn't feel right at all - it's either
> mapped at a fixed address (in which case it should be done in the macio device,
> probably via a property), or the BIOS should be programming the BAR accordingly.

The ROM does not seem to do anything to map the BAR before it accesses it. 
We also can't map it in macio's realize because on reset the pci-host will 
clear bars of attached devices so the only way (I know) to do this is from 
a board level reset func. But if you have a simpler way please send 
alternative patch, for me this was the only way I could make it work.

Regards,
BALATON Zoltan

