Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C2C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:26:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7FEC20848
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 06:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7FEC20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49426 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hR9qT-0006C9-Q4
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 02:26:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hR9pd-0005n4-4f
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hR9pa-0001OS-81
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:25:32 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:58138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hR9pY-0001Kn-9B
	for qemu-devel@nongnu.org; Thu, 16 May 2019 02:25:30 -0400
Received: from player791.ha.ovh.net (unknown [10.108.35.240])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8764C1F0E89
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:25:18 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player791.ha.ovh.net (Postfix) with ESMTPSA id 0F7ED5B33EC3;
	Thu, 16 May 2019 06:25:11 +0000 (UTC)
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
References: <155793986451.464434.12887933000007255549.stgit@bahia.lan>
	<20190516012456.GA3207@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7ece10e9-fd03-e57a-ccb4-06e45a72824b@kaod.org>
Date: Thu, 16 May 2019 08:25:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516012456.GA3207@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 166070237094054869
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleelgddutdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.33.73
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: Sanity checks of OV5 during CAS
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 3:24 AM, David Gibson wrote:
> On Wed, May 15, 2019 at 07:04:24PM +0200, Greg Kurz wrote:
>> If a machine is started with ic-mode=xive but the guest only knows
>> about XICS, eg. an RHEL 7.6 guest, the kernel panics. This is
>> expected but a bit unfortunate since the crash doesn't provide
>> much information for the end user to guess what's happening.
>>
>> Detect that during CAS and exit QEMU with a proper error message
>> instead, like it is already done for the MMU.
>>
>> Even if this is less likely to happen, the opposite case of a guest
>> that only knows about XIVE would certainly fail all the same if the
>> machine is started with ic-mode=xics.
>>
>> Also, the only valid values a guest can pass in byte 23 of OV5 during
>> CAS are 0b00 (XIVE legacy mode) and 0b01 (XIVE exploitation mode). Any
>> other value is a bug, at least with the current spec. Again, it does
>> not seem right to let the guest go on without a precise idea of the
>> interrupt mode it asked for.
>>
>> Handle these cases as well.
>>
>> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
>> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> Seems sensible to me, applied.

yes. I would have splitted the patch though. But this is minor.

Thanks,

C. 


>> ---
>>  hw/ppc/spapr_hcall.c |   24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>
>> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>> index 6c16d2b12040..63a55614b83d 100644
>> --- a/hw/ppc/spapr_hcall.c
>> +++ b/hw/ppc/spapr_hcall.c
>> @@ -1513,6 +1513,7 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>      bool guest_radix;
>>      Error *local_err = NULL;
>>      bool raw_mode_supported = false;
>> +    bool guest_xive;
>>  
>>      cas_pvr = cas_check_pvr(spapr, cpu, &addr, &raw_mode_supported, &local_err);
>>      if (local_err) {
>> @@ -1545,10 +1546,17 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>          error_report("guest requested hash and radix MMU, which is invalid.");
>>          exit(EXIT_FAILURE);
>>      }
>> +    if (spapr_ovec_test(ov5_guest, OV5_XIVE_BOTH)) {
>> +        error_report("guest requested an invalid interrupt mode");
>> +        exit(EXIT_FAILURE);
>> +    }
>> +
>>      /* The radix/hash bit in byte 24 requires special handling: */
>>      guest_radix = spapr_ovec_test(ov5_guest, OV5_MMU_RADIX_300);
>>      spapr_ovec_clear(ov5_guest, OV5_MMU_RADIX_300);
>>  
>> +    guest_xive = spapr_ovec_test(ov5_guest, OV5_XIVE_EXPLOIT);
>> +
>>      /*
>>       * HPT resizing is a bit of a special case, because when enabled
>>       * we assume an HPT guest will support it until it says it
>> @@ -1632,6 +1640,22 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>>                                            ov5_updates) != 0);
>>      }
>>  
>> +    /*
>> +     * Ensure the guest asks for an interrupt mode we support; otherwise
>> +     * terminate the boot.
>> +     */
>> +    if (guest_xive) {
>> +        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_LEGACY) {
>> +            error_report("Guest requested unavailable interrupt mode (XIVE)");
>> +            exit(EXIT_FAILURE);
>> +        }
>> +    } else {
>> +        if (spapr->irq->ov5 == SPAPR_OV5_XIVE_EXPLOIT) {
>> +            error_report("Guest requested unavailable interrupt mode (XICS)");
>> +            exit(EXIT_FAILURE);
>> +        }
>> +    }
>> +
>>      /*
>>       * Generate a machine reset when we have an update of the
>>       * interrupt mode. Only required when the machine supports both
>>
> 


