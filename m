Received: from eggs.gnu.org ([2001:4830:134:3::10]:47166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gHYra-0007Fr-R4
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gHYrT-0001Kc-8V
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:35:36 -0400
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gHYrJ-0001BW-VG
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:35:22 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.76])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 5CEA013F843
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 19:35:18 +0100 (CET)
References: <20180730171748.18562-1-clg@kaod.org>
	<33c16125-8127-a24a-718a-361f0066b853@kaod.org>
	<20180913021138.GQ7978@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <fce4bbb4-6eb0-16e9-0da4-ac1147b0ddab@kaod.org>
Date: Tue, 30 Oct 2018 19:35:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180913021138.GQ7978@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/1] ppc/pnv: Add model for Power8 PHB3
 PCIe Host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Andrea Bolognani <abologna@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hello,

On 9/13/18 4:11 AM, David Gibson wrote:
> On Wed, Sep 12, 2018 at 10:04:05AM +0200, C=E9dric Le Goater wrote:
>> On 07/30/2018 07:17 PM, C=E9dric Le Goater wrote:
>>> This is a model of the PCIe Host Bridge (PHB3) controller found on a
>>> Power8 processor. The Power8 processor comes in different flavors:
>>> Venice, Murano, Naple, each having a different number of PHBs. Multi
>>> chip is supported, each chip adding its set of PHB3 controllers.
>>>
>>> There is no default device layout and PCI devices should be added to
>>> the machine using command line options such as :
>>>
>>>   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,a=
ddr=3D0x0
>>>   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,b=
r=3Dvirbr0,id=3Dhostnet0
>>>
>>>   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
>>>   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2=
,cache=3Dnone
>>>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=
=3Ddrive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
>>>
>>> Git tree available here for testing, based on David's branch:
>>>
>>> 	https://github.com/legoater/qemu/tree/phb3-3.0
>>>
>>
>> Would it be possible to have some feedback on this model ? It has prov=
ed=20
>> to be useful these last years and it has been extensively modified to=20
>> to fit mainline best practices.
>=20
> Yeah, sorry, I've just been swamped with higher priority stuff.
>=20

The patch still applies correctly on top of the future 3.1.=20
What more is expected for this model ?=20

It would be nice to complete P8 before sending the support for the=20
P9 Processor.=20

Thanks,

C.=20
