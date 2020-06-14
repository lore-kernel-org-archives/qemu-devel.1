Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F29C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87F99206A4
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 14:18:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87F99206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkTSo-00081j-Pt
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTRx-0007U1-N3; Sun, 14 Jun 2020 10:17:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:20110)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jkTRw-00038v-2W; Sun, 14 Jun 2020 10:17:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C4209746331;
 Sun, 14 Jun 2020 16:17:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A40E4746307; Sun, 14 Jun 2020 16:17:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A2B5074633F;
 Sun, 14 Jun 2020 16:17:21 +0200 (CEST)
Date: Sun, 14 Jun 2020 16:17:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 4/5] mac_oldworld: Rename ppc_heathrow_reset reset to
 ppc_heathrow_cpu_reset
In-Reply-To: <1055a4d9-0545-02eb-4b3d-9b791f751e3d@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006141612120.56690@zero.eik.bme.hu>
References: <cover.1592055375.git.balaton@eik.bme.hu>
 <dc05efa9c54fb4cafdcea70c396c0790bf99c849.1592055375.git.balaton@eik.bme.hu>
 <1055a4d9-0545-02eb-4b3d-9b791f751e3d@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Sun, 14 Jun 2020, Mark Cave-Ayland wrote:
> On 13/06/2020 14:36, BALATON Zoltan wrote:
>
>> This function resets a CPU not the whole machine so reflect that in
>> its name.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/mac_oldworld.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 4dd872c1a3..9138752ccb 100644
>> --- a/hw/ppc/mac_oldworld.c
>> +++ b/hw/ppc/mac_oldworld.c
>> @@ -73,7 +73,7 @@ static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
>>      return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
>>  }
>>
>> -static void ppc_heathrow_reset(void *opaque)
>> +static void ppc_heathrow_cpu_reset(void *opaque)
>>  {
>>      PowerPCCPU *cpu = opaque;
>>
>> @@ -127,7 +127,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>
>>          /* Set time-base frequency to 16.6 Mhz */
>>          cpu_ppc_tb_init(env,  TBFREQ);
>> -        qemu_register_reset(ppc_heathrow_reset, cpu);
>> +        qemu_register_reset(ppc_heathrow_cpu_reset, cpu);
>>      }
>>
>>      /* allocate RAM */
>
> Technically this is a board level reset which just happens to pass the CPU for the
> opaque, so I'm not quite sold on this one (as an example look at mac_newworld.c where
> using the ELF load address for the PROM would require a dynamic NIP which is most
> conveniently accessed via a MachineState).

The mac_newworld also registers a per CPU reset function like this one. 
This could be done in the machine level reset I add in next patch but 
there could be multiple CPUs and I don't know how to access those from 
MachineState so I've left this CPU reset functions alone which could be 
cleaned up later.

Ideally I should not need a machine reset to set the initial BAR mapping 
but otherwise the sequence of registered reset funcs are not guaranteed 
and the PCI device is reset during qemu_devices_reset() which clears the 
BARs so it won't stay mapped otherwise. I could not find an easier way to 
map this BAR.

Regards,
BALATON Zoltan

