Received: from eggs.gnu.org ([2001:4830:134:3::10]:47469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQxE-0002dt-Rc
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:40:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eKQxB-0007As-PK
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:40:48 -0500
Received: from 16.mo6.mail-out.ovh.net ([87.98.139.208]:59824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eKQxB-00079k-JW
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 10:40:45 -0500
Received: from player696.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 343FC12610D
	for <qemu-devel@nongnu.org>; Thu, 30 Nov 2017 16:40:44 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
	<e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
	<20171129045941.GH3023@umbus.fritz.box>
	<512a0e63-43c1-bf8c-3060-66ab52bc054f@kaod.org>
	<20171130042624.GZ3023@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <24701893-9d90-3e65-8fd9-75921abca6c1@kaod.org>
Date: Thu, 30 Nov 2017 15:40:40 +0000
MIME-Version: 1.0
In-Reply-To: <20171130042624.GZ3023@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
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

On 11/30/2017 04:26 AM, David Gibson wrote:
> On Wed, Nov 29, 2017 at 02:56:39PM +0100, C=E9dric Le Goater wrote:
>>>>>> +    switch (offset) {
>>>>>> +    case 0:
>>>>>> +        spapr_xive_source_eoi(xive, lisn);
>>>>>
>>>>> Hrm.  I don't love that you're dealing with clearing that LSI bit
>>>>> here, but setting it at a different level.
>>>>>
>>>>> The state machines are doing my head in a bit, is there any way
>>>>> you could derive the STATUS_SENT bit from the PQ bits?
>>>>
>>>> Yes. I should.=20
>>>>
>>>> I am also lacking a guest driver to exercise these LSIs so I didn't
>>>> pay a lot of attention to level interrupts. Any idea ?
>>>
>>> How about an old-school emulated PCI device?  Maybe rtl8139?
>>
>> Perfect. The current model is working but I will see how I can=20
>> improve it to use the PQ bits instead.
>>
>> I also found a couple of issues on the way.=20
>>
>> We do need the "#interrupt-cells" and "interrupt-controller"=20
>> properties. They are missing from the XIVE sPAPR specs but there
>> is no other way to find the parent controller for the LSIs ...=20
>> I have re-asked the pHyp team to include them in the specs and=20
>> fixed the QEMU model.
>=20
> Told ya so :).

I believed you ! I just needed a test case :)

C.
