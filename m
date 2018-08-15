Received: from eggs.gnu.org ([2001:4830:134:3::10]:52781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fq3A6-0004zp-Kf
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fq39q-00022r-7X
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:16:56 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:41277)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fq39j-0001vm-VG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 17:16:42 -0400
Received: from player773.ha.ovh.net (unknown [10.109.143.232])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B7651BFC2A
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 23:16:26 +0200 (CEST)
References: <20180730141134.31153-1-clg@kaod.org>
	<20180730141134.31153-4-clg@kaod.org> <20180810004646.GA4079@umbus>
	<8c3ea427-a373-36e9-dfb3-179584a9b060@kaod.org>
	<20180812025803.GF4079@umbus>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8c574aa9-2baa-354e-f3c6-9d7ebe642651@kaod.org>
Date: Wed, 15 Aug 2018 23:16:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180812025803.GF4079@umbus>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 3/4] spapr: introduce a IRQ controller
 backend to the machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 08/12/2018 04:58 AM, David Gibson wrote:
>=20
> On Fri, Aug 10, 2018 at 09:47:49AM +0200, C=E9dric Le Goater wrote:
>> On 08/10/2018 02:46 AM, David Gibson wrote:
>>> On Mon, Jul 30, 2018 at 04:11:33PM +0200, C=E9dric Le Goater wrote:
>>>> This proposal moves all the related IRQ routines of the sPAPR machin=
e
>>>> behind a sPAPR IRQ backend interface 'spapr_irq' to prepare for futu=
re
>>>> changes. First of which will be to increase the size of the IRQ numb=
er
>>>> space, then, will follow a new backend for the POWER9 XIVE IRQ contr=
oller.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Applied to ppc-for-3.1.
>>
>> I see that you have applied patch 2/4 and not 3/4. I suppose you=20
>> are still reviewing 3/4.
>=20
> Actually, I just forgot to push my tree out.  3/4 should be in there
> now.

yes. Thanks.=20

Next steps will be XIVE. =20

These patches have not changed at all :

[PATCH v4 04/28] ppc/xive: introduce a XIVE interrupt source model
[PATCH v4 05/28] ppc/xive: add support for the LSI interrupt sources
[PATCH v4 06/28] ppc/xive: introduce the XiveFabric interface
[PATCH v4 07/28] ppc/xive: introduce the XiveRouter model
[PATCH v4 08/28] ppc/xive: introduce the XIVE Event Queues
[PATCH v4 09/28] ppc/xive: add support for the EQ Event State buffers
[PATCH v4 10/28] ppc/xive: introduce the XIVE interrupt thread
[PATCH v4 11/28] ppc/xive: introduce a simplified XIVE presenter
[PATCH v4 12/28] ppc/xive: notify the CPU when the interrupt priority
[PATCH v4 13/28] spapr/xive: introduce a XIVE interrupt controller

These have changed a little :

[PATCH v4 14/28] spapr/xive: use the VCPU id as a VP identifier in
[PATCH v4 15/28] spapr: initialize VSMT before initializing the IRQ
[PATCH v4 16/28] spapr: introdude a new machine IRQ backend for XIVE
[PATCH v4 17/28] spapr: add hcalls support for the XIVE exploitation
[PATCH v4 18/28] spapr: add device tree support for the XIVE
[PATCH v4 19/28] spapr: allocate the interrupt thread context under
[PATCH v4 20/28] spapr: introduce a 'pseries-3.0-xive' QEMU machine


These have changed a lot more :

[PATCH v4 21/28] spapr: add classes for the XIVE models
[PATCH v4 22/28] target/ppc/kvm: add Linux KVM definitions for XIVE
[PATCH v4 23/28] spapr/xive: add common realize routine for KVM
[PATCH v4 24/28] spapr/xive: add KVM support
[PATCH v4 25/28] spapr: fix XICS migration

C.
