Received: from eggs.gnu.org ([208.118.235.92]:57585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKo37-0006Ne-4O
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKo1i-0001ok-JS
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:20:24 -0500
Received: from 16.mo3.mail-out.ovh.net ([188.165.56.217]:60713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKo1e-0001hz-Cw
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:18:55 -0500
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id E9B5B1777E2
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 09:02:15 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-13-clg@kaod.org>
	<20171129051110.GI3023@umbus.fritz.box>
	<b0fd23cc-bc15-8023-69da-508ce5f6d0fe@kaod.org>
	<20171130040604.GV3023@umbus.fritz.box>
	<d35fe0fe-ae4a-3bba-ac74-ea07701d331b@kaod.org>
	<20171201040301.GD30161@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <73311645-1a3b-e8c1-c2fb-cb56d2172b13@kaod.org>
Date: Fri, 1 Dec 2017 09:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <20171201040301.GD30161@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/25] spapr: introduce a XIVE interrupt
 presenter model
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

>>> That'd be ok.  Or call if sPAPRIVPE.  Or even call it TIMA.  I'd be
>>> fine with any of those.
>>
>> In this model, I am making a lot of shortcuts in the XIVE concepts
>> (which I don't master completely yet ...) 
>>
>> The IVPE is the part of the overall controller doing the interrupt 
>> presentation.
>>
>> The TIMA refers to the MMIO region in which the thread interrupt 
>> management is done. 
>>
>> The XIVE structure that contains the 'virtual processor' interrupt 
>> state is the NVT: Notification Virtual Target. An index to an NVT 
>> is stored in the EQs to do the routing. I did not introduce the NVT 
>> in sPAPRXive because it's rather big, 128 bytes, and we don't need 
>> much of it (NSR, CPPR, PIPR, IPB) but we could use a shorten one.
>>
>> So I think sPAPRXiveNVT, or sPAPRXiveVP (VP for virtual processor)
>> would be better names.
> 
> Ok.  I prefer sPAPRXiveNVT of these two.

Fine. Also what about the location of the files. They are under
hw/intc/ but shouldn't we consider moving them under hw/spapr/ ? 

Thanks,

C.
