Received: from eggs.gnu.org ([2001:4830:134:3::10]:60161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZbpt-0005b9-E9
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZbpq-0003iS-BT
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:47:41 -0400
Received: from 6.mo3.mail-out.ovh.net ([188.165.43.173]:50845)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZbpq-0003ht-4e
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:47:38 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 2CBF7123EE9
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 13:47:35 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
	<1500894439.10674.76.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c94d515a-0d8b-921e-1ccb-bd92284c3967@kaod.org>
Date: Mon, 24 Jul 2017 13:47:28 +0200
MIME-Version: 1.0
In-Reply-To: <1500894439.10674.76.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 08/26] ppc/xive: add flags to the XIVE
 interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 01:07 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-07-24 at 19:50 +1000, David Gibson wrote:
>> On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote=
:
>>> On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
>>>> On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=C3=A9dric Le Goater wrot=
e:
>>>>> These flags define some characteristics of the source :
>>>>>
>>>>>  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
>>>>>                        specific hcall H_INT_ESB
>>>>
>>>> What's the other option?
>>>
>>> Direct MMIO access. Normally all interrupts use normal MMIOs,
>>> each interrupts has an associated MMIO page with special MMIOs
>>> to control the source state (PQ bits). This is something I added
>>> to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
>>> to work around broken HW (which happens on some P9 versions).
>>
>> Ok.. and that's something that can be decided at runtime?
>=20
> Well, at this point I think nothing will set that flag.... It's there
> for workaround around HW bugs on some chips. At least in full emu it
> shouldn't happen unless we try to emulate those bugs. Hopefully direct
> MMIO will just work.

Nevertheless I have added support for the hcall in Linux and QEMU.
To use, I think we could create a specific source.=20

C.=20
