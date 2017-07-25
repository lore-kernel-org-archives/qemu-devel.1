Received: from eggs.gnu.org ([2001:4830:134:3::10]:50332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZv2W-0000Np-Ox
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZv2S-0002zH-PS
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:18:00 -0400
Received: from 5.mo1.mail-out.ovh.net ([178.33.45.107]:48473)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZv2S-0002wM-JD
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 04:17:56 -0400
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 2E15F88DE5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 10:17:47 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-9-git-send-email-clg@kaod.org>
	<20170724043624.GE17228@umbus.fritz.box>
	<1500879657.10674.64.camel@kernel.crashing.org>
	<20170724095052.GO17228@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0f23cda8-0101-550c-eeb2-3ca08d6c52ea@kaod.org>
Date: Tue, 25 Jul 2017 10:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170724095052.GO17228@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 11:50 AM, David Gibson wrote:
> On Mon, Jul 24, 2017 at 05:00:57PM +1000, Benjamin Herrenschmidt wrote:
>> On Mon, 2017-07-24 at 14:36 +1000, David Gibson wrote:
>>> On Wed, Jul 05, 2017 at 07:13:21PM +0200, C=E9dric Le Goater wrote:
>>>> These flags define some characteristics of the source :
>>>>
>>>>  - XIVE_SRC_H_INT_ESB  the Event State Buffer are controlled with a
>>>>                        specific hcall H_INT_ESB
>>>
>>> What's the other option?
>>
>> Direct MMIO access. Normally all interrupts use normal MMIOs,
>> each interrupts has an associated MMIO page with special MMIOs
>> to control the source state (PQ bits). This is something I added
>> to the PAPR spec (and the OPAL <-> Linux interface) to allow firmware
>> to work around broken HW (which happens on some P9 versions).
>=20
> Ok.. and that's something that can be decided at runtime?
>=20

This is a characteristic of an Interrupt Source and the associated=20
object should be created with such a flag. But I don't think will=20
ever use it in QEMU, maybe with KVM.

C.
