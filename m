Received: from eggs.gnu.org ([2001:4830:134:3::10]:58461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK5QR-0000C4-IK
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eK5QM-0004YO-40
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:31 -0500
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:35084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eK5QL-0004XW-U2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 11:41:26 -0500
Received: from player731.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 79518D3FF5
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 17:41:24 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-9-clg@kaod.org>
	<20171129124904.13a30582@bahia.lan>
	<1eb874c0-6ffb-0a2f-15e7-86c1edcd020e@kaod.org>
	<20171129165159.56187e5b@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b1c520f3-d5d3-609a-5b06-deec8a30a587@kaod.org>
Date: Wed, 29 Nov 2017 17:41:17 +0100
MIME-Version: 1.0
In-Reply-To: <20171129165159.56187e5b@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 08/25] spapr: introduce a
 skeleton for the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

>>>> +static const VMStateDescription vmstate_spapr_xive = {
>>>> +    .name = TYPE_SPAPR_XIVE,
>>>> +    .version_id = 1,
>>>> +    .minimum_version_id = 1,
>>>> +    .needed = vmstate_spapr_xive_needed,
>>>> +    .fields = (VMStateField[]) {
>>>> +        VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>>>> +        VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1,
>>>> +                                           vmstate_spapr_xive_ive, XiveIVE),  
>>>
>>> Hmm... this array is allocated at realize and this will cause
>>> the migration code to re-allocate it again with the same size,
>>> and leak memory IIUC.  
>>
>> I thought so but something was going wrong on the receive side (memory 
>> corruption detected by valgrind). I did not find why yet.
>>
> 
> Have you tried VMSTATE_STRUCT_VARRAY_POINTER_UINT32() ?

yes. tcg/intel only though.

C. 
