Received: from eggs.gnu.org ([2001:4830:134:3::10]:41462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciVsz-0002du-Ss
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:43:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1ciVsw-000767-0V
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:43:25 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:36436)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1ciVsv-00075F-Kd
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 19:43:21 -0500
Received: by mail-pg0-x243.google.com with SMTP id 25so2703717pgy.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:43:21 -0800 (PST)
References: <148776029578.5865.5785337570950575739.stgit@bahia>
	<99a3a245-d508-01b8-6b10-0bb32ea54209@ozlabs.ru>
	<20170225114005.109718d8@bahia.lan>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <594cb932-1a70-ecad-4f61-788f1f8a73f2@ozlabs.ru>
Date: Tue, 28 Feb 2017 11:43:14 +1100
MIME-Version: 1.0
In-Reply-To: <20170225114005.109718d8@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RtKaBluAWVWn3lREtNun41pJBA2xM6UXx"
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: populate PCI DT in reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RtKaBluAWVWn3lREtNun41pJBA2xM6UXx
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org,
 Marcel Apfelbaum <marcel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Message-ID: <594cb932-1a70-ecad-4f61-788f1f8a73f2@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] spapr/pci: populate PCI DT in reverse order
References: <148776029578.5865.5785337570950575739.stgit@bahia>
 <99a3a245-d508-01b8-6b10-0bb32ea54209@ozlabs.ru>
 <20170225114005.109718d8@bahia.lan>
In-Reply-To: <20170225114005.109718d8@bahia.lan>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 25/02/17 21:40, Greg Kurz wrote:
> On Sat, 25 Feb 2017 20:39:18 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
>> On 22/02/17 21:56, Greg Kurz wrote:
>>> From: Greg Kurz <gkurz@linux.vnet.ibm.com>
>>>
>>> Since commit 1d2d974244c6 "spapr_pci: enumerate and add PCI device tr=
ee", QEMU
>>> populates the PCI device tree in the opposite order compared to SLOF.=

>>>
>>> Before 1d2d974244c6:
>>>
>>> Populating /pci@800000020000000
>>>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>>>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>>>                      00 1000 (D) : 1af4 1009    virtio [ network ]
>>> Populating /pci@800000020000000/unknown-legacy-device@2
>>>
>>> 7e5294b8 :  /pci@800000020000000
>>> 7e52b998 :  |-- ethernet@0
>>> 7e52c0c8 :  |-- scsi@1
>>> 7e52c7e8 :  +-- unknown-legacy-device@2 ok
>>>
>>> Since 1d2d974244c6:
>>>
>>> Populating /pci@800000020000000
>>>                      00 1000 (D) : 1af4 1009    virtio [ network ]
>>> Populating /pci@800000020000000/unknown-legacy-device@2
>>>                      00 0800 (D) : 1af4 1001    virtio [ block ]
>>>                      00 0000 (D) : 1af4 1000    virtio [ net ]
>>>
>>> 7e5e8118 :  /pci@800000020000000
>>> 7e5ea6a0 :  |-- unknown-legacy-device@2
>>> 7e5eadb8 :  |-- scsi@1
>>> 7e5eb4d8 :  +-- ethernet@0 ok
>>>
>>> This behaviour change is not actually a bug since no assumptions shou=
ld be
>>> made on DT ordering. But it has no real justification either, other t=
han
>>> being the consequence of the way fdt_add_subnode() inserts new elemen=
ts
>>> to the front of the FDT rather than adding them to the tail.
>>>
>>> This patch reverts to the historical SLOF ordering by walking PCI dev=
ices
>>> in reverse order. This reconciles pseries with x86 machine types beha=
vior.
>>> It is expected to make things easier when porting existing applicatio=
ns to
>>> power.
>>>
>>> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
>>> Tested-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
>>> (slight update to the changelog)
>>> Signed-off-by: Greg Kurz <groug@kaod.org>
>>> ---
>>>  hw/pci/pci.c         |   28 ++++++++++++++++++++++++++++
>>>  hw/ppc/spapr_pci.c   |   12 ++++++------
>>>  include/hw/pci/pci.h |    4 ++++
>>>  3 files changed, 38 insertions(+), 6 deletions(-)
>>>
>>> David,
>>>
>>> This patch was posted and already discussed during 2.5 development:
>>>
>>> http://patchwork.ozlabs.org/patch/549925/
>>>
>>> The "consensus" at the time was that guests should not rely on device=

>>> ordering (i.e. use persistent naming instead).
>>>
>>> I got recently contacted by OpenStack people who had several complain=
ts
>>> about the reverse ordering of PCI devices in pseries: different behav=
ior
>>> between ppc64 and x86, lots of time spent in debugging when porting
>>> applications from x86 to ppc64 before realizing that it is caused by =
the
>>> reverse ordering, necessity to carry hacky workarounds... =20
>>
>>
>> x86 does not have a device tree, and PCI id (bus:slot:fn) is the same
>> regardless the scanning order, i.e. "lspci" will show the same picture=
 with
>> either order.
>>
>> How could OpenStack tell the difference and require workaround for wha=
t
>> precisely?
>>
>> I am definitely missing the point here...
>>
>=20
> NICs get probed in reverse order and are assigned different names compa=
red
> to the same setup on x86 (i.e. eth0 becomes eth1). They end up using wr=
ong
> network settings.


The answer I was looking for is that the guest probes devices in the orde=
r
from the device tree rather than doing PCI scan itself and this is how th=
e
order in the device tree matters :)

+1 for the change.


--=20
Alexey


--RtKaBluAWVWn3lREtNun41pJBA2xM6UXx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJYtMeiDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5u9QP/RFz
9DEZnlsx0Hc0WkQ08588GHpzRnVQiFH3GhwRuTMJXTU/rswHu78LmB/7lLk+KKnB
Cq9gL85/xiC4nnRIYxObHbYywYmBXVWo20TIDNIBeSIPhybXAJpDd8F8vxO0EXvC
UPZmefgUbgtsl5Fe98VOMUOhkSdcn+M+tVb0TJXOTbDPotLTFU3ZMYHXaTg5Hw7M
Z6MxzB9r4Awvy8GkcLSi/CiLGaQzgMEFk1HSGquZaRD867RXiqmhVbS5sgdMXCI7
n1V375+Jg1WPp72Mmk8W5MBrFVrXmWEvmF9xYtiahtb7WGCKHJ1V3XPYkbSP0muX
vcj7X3R8iz8NAa0vh7RH+T8Q9aUHhyt7/McBva9j5wUe7OAX47CdOI4Gm5uLWO9A
uZTeko6H2FAm8nrYHDK2tngOgqGp3F91EzfcrbxEOWYMgMh+OfqPlmq+9jWrQ/D2
h+0GAFd4//Zx4/FHv1aDTFuiTZr6JXuNaQ/AGrMAP7jurttNjOasy1uHTK5XFeIF
KbaE0G3rFHr8E5IGUnTxismJgrvxlO6SacSo2zIQPdJd0P9nCnOEojosuI1LLKra
4LcGRq1gkwRXxfXgQE/vZP0gBmziv/ZA/+uuuZtNk/fA0A8nSMuS8dMYSntlbqy3
OktLz8Y/AlUKt+tf81cWbumWcy7/JVpRm0Tu54eD
=5I/L
-----END PGP SIGNATURE-----

--RtKaBluAWVWn3lREtNun41pJBA2xM6UXx--
