Received: from eggs.gnu.org ([2001:4830:134:3::10]:35574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWFj8-0005VU-DN
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:11:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWFj4-0000WQ-9A
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:11:38 -0500
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:47591)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWFj4-0000Sc-19
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 02:11:34 -0500
Received: from player760.ha.ovh.net (unknown [10.109.146.32])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8FC5D1C53D0
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 08:11:32 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-2-clg@kaod.org>
	<20181210041646.GK4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4a60472d-0f37-2669-1dae-1d506f14335e@kaod.org>
Date: Mon, 10 Dec 2018 08:11:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181210041646.GK4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 01/19] ppc/xive: add support for the END
 Event State Buffers
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

On 12/10/18 5:16 AM, David Gibson wrote:
> On Sun, Dec 09, 2018 at 08:45:52PM +0100, C=E9dric Le Goater wrote:
>> The Event Notification Descriptor (END) XIVE structure also contains
>> two Event State Buffers providing further coalescing of interrupts,
>> one for the notification event (ESn) and one for the escalation events
>> (ESe). A MMIO page is assigned for each to control the EOI through
>> loads only. Stores are not allowed.
>>
>> The END ESBs are modeled through an object resembling the 'XiveSource'
>> It is stateless as the END state bits are backed into the XiveEND
>> structure under the XiveRouter and the MMIO accesses follow the same
>> rules as for the XiveSource ESBs.
>>
>> END ESBs are not supported by the Linux drivers neither on OPAL nor on
>> sPAPR. Nevetherless, it provides a mean to study the question in the
>> future and validates a bit more the XIVE model.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v6:
>>
>>  - removed the 'chip-id' field from XiveRouter
>>  - introduced a 'block-id' field in XiveENDSource to lookup the XIVE
>>    END structure when doing a load in the MMIO ESB
>>  - removed reset XiveENDSource handler
>>
>>  include/hw/ppc/xive.h |  21 ++++++
>>  hw/intc/xive.c        | 160 +++++++++++++++++++++++++++++++++++++++++=
-
>>  2 files changed, 179 insertions(+), 2 deletions(-)
>=20
> Applied to ppc-for-4.0.
>=20
> I had some thoughts about maybe-nicer arrangements of things here, but
> nothing important enough to delay this (the things I'm mulling over
> wouldn't break migration, so it's fixable later).

OK. No problem for me to do it afterwards.=20

It's a bit of pain to maintain a pile of 30/40 patches and changing stuff=
  =20
in the first ones.=20

C.
