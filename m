Received: from eggs.gnu.org ([2001:4830:134:3::10]:43748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g00Cy-00040r-P7
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1g008Y-0000g0-8H
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:04:37 -0400
Received: from 7.mo179.mail-out.ovh.net ([46.105.61.94]:35765)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1g008T-0000Zt-30
	for qemu-devel@nongnu.org; Wed, 12 Sep 2018 04:04:30 -0400
Received: from player697.ha.ovh.net (unknown [10.109.159.159])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 66779F9AF3
	for <qemu-devel@nongnu.org>; Wed, 12 Sep 2018 10:04:15 +0200 (CEST)
References: <20180730171748.18562-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <33c16125-8127-a24a-718a-361f0066b853@kaod.org>
Date: Wed, 12 Sep 2018 10:04:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180730171748.18562-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
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

On 07/30/2018 07:17 PM, C=C3=A9dric Le Goater wrote:
> This is a model of the PCIe Host Bridge (PHB3) controller found on a
> Power8 processor. The Power8 processor comes in different flavors:
> Venice, Murano, Naple, each having a different number of PHBs. Multi
> chip is supported, each chip adding its set of PHB3 controllers.
>=20
> There is no default device layout and PCI devices should be added to
> the machine using command line options such as :
>=20
>   -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,add=
r=3D0x0
>   -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0
>=20
>   -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
>   -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,c=
ache=3Dnone
>   -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3D=
drive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2
>=20
> Git tree available here for testing, based on David's branch:
>=20
> 	https://github.com/legoater/qemu/tree/phb3-3.0
>=20

Would it be possible to have some feedback on this model ? It has proved=20
to be useful these last years and it has been extensively modified to=20
to fit mainline best practices.=20

Thanks,
=20
C.
