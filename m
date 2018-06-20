Received: from eggs.gnu.org ([2001:4830:134:3::10]:33700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVVUK-0004fi-Kf
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVVUH-0007CV-AO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:17:00 -0400
Received: from 10.mo3.mail-out.ovh.net ([87.98.165.232]:38431)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVVUH-0007C8-3j
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 01:16:57 -0400
Received: from player691.ha.ovh.net (unknown [10.109.120.111])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 965981BDFBB
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 07:16:54 +0200 (CEST)
References: <20180618173402.23405-1-clg@kaod.org>
	<20180618173402.23405-4-clg@kaod.org>
	<20180619010244.GN25461@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6043b94d-1626-f7a7-0b61-b639f428e80d@kaod.org>
Date: Wed, 20 Jun 2018 07:16:49 +0200
MIME-Version: 1.0
In-Reply-To: <20180619010244.GN25461@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] spapr: introduce a fixed IRQ number
 space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

>> diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
>> index e4f5946a2188..c82dc40be0d5 100644
>> --- a/hw/ppc/spapr_events.c
>> +++ b/hw/ppc/spapr_events.c
>> @@ -709,7 +709,11 @@ void spapr_events_init(sPAPRMachineState *spapr)
>>  {
>>      int epow_irq;
>>  
>> -    epow_irq = spapr_irq_findone(spapr, &error_fatal);
>> +    if (spapr->xics_legacy) {
>> +        epow_irq = spapr_irq_findone(spapr, &error_fatal);
>> +    } else {
>> +        epow_irq = SPAPR_IRQ_EPOW;
> 
> Can slightly improve brevity by just initializing epow_irq to this,
> then overwriting it in the legacy case.

and I forgot to add this to v3 ... I can add it later on if there
are no other changes requested or if we move the find routine
under the machine class.

C.
