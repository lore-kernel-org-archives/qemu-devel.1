Received: from eggs.gnu.org ([2001:4830:134:3::10]:49091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUEFI-0003gl-Vq
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:12:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUEFB-0005sx-Ei
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:12:28 -0500
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:37517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUEFA-0005mp-Tj
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 12:12:21 -0500
Received: from player763.ha.ovh.net (unknown [10.109.146.53])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id E1A7E204530
	for <qemu-devel@nongnu.org>; Tue,  4 Dec 2018 18:12:16 +0100 (CET)
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-11-clg@kaod.org>
	<20181128005255.GT2251@umbus.fritz.box>
	<64aef78f-e374-9c6d-1a1f-892c4e3b0677@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <42cb5e91-0006-3b63-5240-5f09b275c04a@kaod.org>
Date: Tue, 4 Dec 2018 18:12:11 +0100
MIME-Version: 1.0
In-Reply-To: <64aef78f-e374-9c6d-1a1f-892c4e3b0677@kaod.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 10/36] spapr/xive: introduce a XIVE
 interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ ... ]

>>> +void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
>>> +{
>>> +    int i;
>>> +    uint32_t offset = 0;
>>> +
>>> +    monitor_printf(mon, "XIVE Source %08x .. %08x\n", offset,
>>> +                   offset + xive->source.nr_irqs - 1);
>>> +    xive_source_pic_print_info(&xive->source, offset, mon);
>>> +
>>> +    monitor_printf(mon, "XIVE EAT %08x .. %08x\n", 0, xive->nr_irqs - 1);
>>> +    for (i = 0; i < xive->nr_irqs; i++) {
>>> +        xive_eas_pic_print_info(&xive->eat[i], i, mon);
>>> +    }
>>> +
>>> +    monitor_printf(mon, "XIVE ENDT %08x .. %08x\n", 0, xive->nr_ends - 1);
>>> +    for (i = 0; i < xive->nr_ends; i++) {
>>> +        xive_end_pic_print_info(&xive->endt[i], i, mon);
>>> +    }
>>
>> AIUI the PAPR model hides the details of ENDs, EQs and NVTs - instead
>> each logical EAS just points at a (thread, priority) pair, which under
>> the hood has exactly one END and one NVT bound to it.
>>
>> Given that, would it make more sense to reformat the info here to show
>> things in terms of those (thread, priority) pairs, rather than the
>> internal EAS and END details?
> 
> Yes. I had a version doing something like that before. I will rework
> the ouput a little for sPAPR.  

I would like to keep the 'advanced' monitor output in some ways and have
two possible outputs : simple and long.

Is it possible to add command line options or arguments to the Monitor 
interface ? 

Thanks,

C. 
