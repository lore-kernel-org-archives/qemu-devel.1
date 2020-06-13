Return-Path: <SRS0=+z+v=72=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2136FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:28:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD1902078A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2020 18:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1902078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkAtY-00055S-7D
	for qemu-devel@archiver.kernel.org; Sat, 13 Jun 2020 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAsd-0004Bf-CR; Sat, 13 Jun 2020 14:27:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:12136)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkAsa-0002WQ-Lw; Sat, 13 Jun 2020 14:27:46 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4E36B746307;
 Sat, 13 Jun 2020 20:27:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2A49E745702; Sat, 13 Jun 2020 20:27:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28C5E7456F8;
 Sat, 13 Jun 2020 20:27:34 +0200 (CEST)
Date: Sat, 13 Jun 2020 20:27:34 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 5/5] mac_oldworld: Map macio to expected address at
 reset
In-Reply-To: <627a963a-2bd7-eab2-2276-3a79eb97821d@amsat.org>
Message-ID: <alpine.BSF.2.22.395.2006132023130.82630@zero.eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <c637ae5d399e5681bb4f21662c7240590e7182e1.1592055375.git.balaton@eik.bme.hu>
 <627a963a-2bd7-eab2-2276-3a79eb97821d@amsat.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-2108862080-1592072854=:82630"
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-2108862080-1592072854=:82630
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 13 Jun 2020, Philippe Mathieu-Daudé wrote:
> On 6/13/20 3:36 PM, BALATON Zoltan wrote:
>> Add a reset function that maps macio to the address expected by the
>> firmware of the board at startup.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/mac.h          | 12 ++++++++++++
>>  hw/ppc/mac_oldworld.c | 17 +++++++++++++++--
>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/mac.h b/hw/ppc/mac.h
>> index 6af87d1fa0..35a5f21163 100644
>> --- a/hw/ppc/mac.h
>> +++ b/hw/ppc/mac.h
>> @@ -57,6 +57,18 @@
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
>> +    PCIDevice *macio_pci;
>> +} HeathrowMachineState;
>> +
>>  /* New World IRQs */
>>  #define NEWWORLD_CUDA_IRQ      0x19
>>  #define NEWWORLD_PMU_IRQ       0x19
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 9138752ccb..fa9527410d 100644
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
>> +    pci_default_write_config(m->macio_pci, PCI_COMMAND, PCI_COMMAND_MEMORY, 2);
>> +    pci_default_write_config(m->macio_pci, PCI_BASE_ADDRESS_0, 0xf3000000, 4);
>
> Hmm either this should be the default reset state of the device,
> or we miss a 'BIOS' boot code that sets this state before you can
> run your code.

"My code" here that I've tried _is_ the "BIOS" (actually openprom) 
firmware ROM from real machine which does not seem to do anything to get 
this mapped there so this seems to be there on reset but I don't know how 
that gets there on real hardware. This change makes the ROM happy and does 
not seem to break OpenBIOS either but if anyone knows a better way let 
us know.

Regards,
BALATON Zoltan
--3866299591-2108862080-1592072854=:82630--

