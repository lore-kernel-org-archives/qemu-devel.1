Received: from eggs.gnu.org ([2001:4830:134:3::10]:54575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfVX-00022V-W0
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gWfVS-0005Xq-Qq
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:43:19 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:58805)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gWfVS-0005TT-Iw
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 05:43:14 -0500
Received: from player729.ha.ovh.net (unknown [10.109.143.201])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D000A42F6F
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 11:43:12 +0100 (CET)
References: <20181209194610.29727-1-clg@kaod.org>
	<20181209194610.29727-4-clg@kaod.org>
	<20181210042747.GM4261@umbus.fritz.box>
	<157aa1c9-20a6-e177-eac7-f47f40188df3@kaod.org>
	<20181211013710.GC4261@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <079ddd99-4c35-c3be-0b27-59c2ce39ef21@kaod.org>
Date: Tue, 11 Dec 2018 11:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <20181211013710.GC4261@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 03/19] ppc/xive: introduce a simplified
 XIVE presenter
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

On 12/11/18 2:37 AM, David Gibson wrote:
> On Mon, Dec 10, 2018 at 08:15:40AM +0100, C=E9dric Le Goater wrote:
>> On 12/10/18 5:27 AM, David Gibson wrote:
>>> On Sun, Dec 09, 2018 at 08:45:54PM +0100, C=E9dric Le Goater wrote:
>>>> The last sub-engine of the XIVE architecture is the Interrupt
>>>> Virtualization Presentation Engine (IVPE). On HW, the IVRE and the
>>>> IVPE share elements, the Power Bus interface (CQ), the routing table
>>>> descriptors, and they can be combined in the same HW logic. We do th=
e
>>>> same in QEMU and combine both engines in the XiveRouter for
>>>> simplicity.
>>>>
>>>> When the IVRE has completed its job of matching an event source with=
 a
>>>> Notification Virtual Target (NVT) to notify, it forwards the event
>>>> notification to the IVPE sub-engine. The IVPE scans the thread
>>>> interrupt contexts of the Notification Virtual Targets (NVT)
>>>> dispatched on the HW processor threads and if a match is found, it
>>>> signals the thread. If not, the IVPE escalates the notification to
>>>> some other targets and records the notification in a backlog queue.
>>>>
>>>> The IVPE maintains the thread interrupt context state for each of it=
s
>>>> NVTs not dispatched on HW processor threads in the Notification
>>>> Virtual Target table (NVTT).
>>>>
>>>> The model currently only supports single NVT notifications.
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>
>>> Applied.
>>>
>>> I think the tctx_word2() should have the byteswap, rather than having
>>> it in the callers, but that can be fixed later.
>>
>> I thought it was better to explicitly show in the code where the=20
>> byteswaps were needed. Anyway, this is very localized, so, yes,=20
>> we can change it later on.
>=20
> To clarify my thinking here; the important thing is not knowing where
> the byteswaps are, but being able to tell as easily as possible what
> endianness a given piece of data is right now.
>=20
> The convention I'm aiming for here - which is one I try to use most
> places is that structures - at least structures which map to specific
> in-memory things - are in the required endianness for that stuff in
> memory.  However bare integers - uint32_t or uint64_t or whatever -
> are, well, numbers, in native endian.
>=20

ok. Adding that to the TODO list.

C.
