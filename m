Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E92C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DEEF20885
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 22:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DEEF20885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jowmi-0004Me-9S
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 18:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jowkE-0000y2-AB; Fri, 26 Jun 2020 18:22:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:38207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jowkA-0001fK-A1; Fri, 26 Jun 2020 18:22:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 215F47475FA;
 Sat, 27 Jun 2020 00:22:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ECCEC74632C; Sat, 27 Jun 2020 00:22:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EB62674633D;
 Sat, 27 Jun 2020 00:22:42 +0200 (CEST)
Date: Sat, 27 Jun 2020 00:22:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v5 06/11] mac_oldworld: Rename ppc_heathrow_reset to
 ppc_heathrow_cpu_reset
In-Reply-To: <1dfc4c68-c85d-5e56-d3c2-d68ce0b2355c@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2006270009510.64843@zero.eik.bme.hu>
References: <cover.1592315226.git.balaton@eik.bme.hu>
 <c2f41c551f7393b5bde733cbf78a1fcb151f3e89.1592315226.git.balaton@eik.bme.hu>
 <1dfc4c68-c85d-5e56-d3c2-d68ce0b2355c@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1397681742-1593210162=:64843"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 17:57:16
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1397681742-1593210162=:64843
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 26 Jun 2020, Mark Cave-Ayland wrote:
> On 16/06/2020 14:47, BALATON Zoltan wrote:
>
>> This function resets a CPU not the whole machine so reflect that in
>> its name.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/ppc/mac_oldworld.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
>> index 4200008851..f97f241e0c 100644
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
>> @@ -112,7 +112,7 @@ static void ppc_heathrow_init(MachineState *machine)
>>
>>          /* Set time-base frequency to 16.6 Mhz */
>>          cpu_ppc_tb_init(env,  TBFREQ);
>> -        qemu_register_reset(ppc_heathrow_reset, cpu);
>> +        qemu_register_reset(ppc_heathrow_cpu_reset, cpu);
>>      }
>>
>>      /* allocate RAM */
>
> As per my previous comment on your earlier version, I don't agree with this - the
> reset is being registered at board level, it just so happens that as it's only
> touching the CPU due to the opaque being passed in.
>
> I'd be inclined to pass in a suitable HeathrowMachineState object containing a
> reference to the CPU instead.

It's not a board level reset func but a CPU level one. See where it's 
registered here:

https://git.qemu.org/?p=qemu.git;a=blob;f=hw/ppc/mac_oldworld.c;h=f8c204ead73843098084bf5213ac4046d7d843c4;hb=HEAD#l111

One for each CPU and as there could be more than one CPU, this won't work 
with a single reference in HeathrowMachineState. We could reset CPUs in a 
board level reset func (added by next patch) but I don't know how to 
access CPU objects from MachineState (it did not look trivial when I've 
looked) so I just left it as it is for later clean up separate from this 
series. I've just renamed it to avoid confusion with board level reset 
func which is usually named *_reset but I could call that 
ppc_heathrow_board_reset and then we don't need this patch but I think 
this is cleaner.

I don't even know why we need a reset func to reset the CPU, I'd expect 
that to be the default behaviour of any board reset without needing to 
register a func to do it.

Regards,
BALATON Zoltan
--3866299591-1397681742-1593210162=:64843--

