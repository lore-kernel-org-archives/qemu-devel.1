Received: from eggs.gnu.org ([2001:4830:134:3::10]:42368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNe60-0008Bx-KA
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fNe5v-0000yK-QB
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:51:24 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:47954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fNe5v-0000xO-Jl
	for qemu-devel@nongnu.org; Tue, 29 May 2018 08:51:19 -0400
Received: from player729.ha.ovh.net (unknown [10.109.108.13])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id B652D137B95
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 14:51:17 +0200 (CEST)
References: <20180518164405.11804-1-clg@kaod.org>
	<20180518164405.11804-5-clg@kaod.org>
	<20180528171833.40499816@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4fa46a92-5305-0150-d0b2-75f58d9ea919@kaod.org>
Date: Tue, 29 May 2018 14:51:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180528171833.40499816@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] spapr: introduce a new IRQ backend
 using fixed IRQ number ranges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>

>> +static void spapr_irq_range_free_msi(sPAPRMachineState *spapr, int irq, int num)
>> +{
>> +    bitmap_clear(spapr->irq_map, irq, num);
>> +}
>> +
>> +/*
>> + * New XICS IRQ backend
>> + *
>> + * using the IRQ ranges and device indexes
>> + */
>> +static void spapr_irq_init_2_13(sPAPRMachineState *spapr, Error **errp)
> 
> FYI, next QEMU version will likely be 3.0:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04879.html
> 
> Also, it is useful to add version information to the name in case of
> existing machine types. I guess _default or _new is a better choice
> here.

What about :

	_legacy for the former XICS backend
	_xics for the new XICS backend
	_xive for the coming XIVE backend 

? 

Thanks,

C.
