Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1om-0002W8-VU
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:10:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ds1ol-0005do-O2
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:10:40 -0400
References: <20170911172022.4738-1-eblake@redhat.com>
	<20170911172022.4738-10-eblake@redhat.com>
	<8c2d1317-5b95-b8de-cf97-0b2618c86b25@redhat.com>
	<c70cd17a-4d29-8f23-e5dd-bb409182ac55@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e9e76b67-3490-8c1d-3062-960889ba9cd4@redhat.com>
Date: Wed, 13 Sep 2017 09:10:22 +0200
MIME-Version: 1.0
In-Reply-To: <c70cd17a-4d29-8f23-e5dd-bb409182ac55@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="geA4qVppOWPvv7GEVqqfX8bDCmhKV7Isx"
Subject: Re: [Qemu-devel] [PATCH v7 09/38] libqos: Track QTestState with
 QVirtioBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, "open list:virtio-blk" <qemu-block@nongnu.org>, armbru@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--geA4qVppOWPvv7GEVqqfX8bDCmhKV7Isx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.09.2017 15:28, Eric Blake wrote:
> On 09/12/2017 02:21 AM, Thomas Huth wrote:
[...]
>> I fail to see why we need a separate bus object here for each device.
>> The bus is only available one time, not multiple times, isn't it? So
>> there should also only be one bus object floating around, not multiple=

>> ones... or do I miss something?
>=20
> You are right that there is only one bus for the machine - the problem
> is that the object representing the bus is dynamically created on the
> fly at the point where the device is first grabbed, rather than up fron=
t
> as part of creating the machine (in other words, the device search is
> not performed on a pre-existing bus object).
>=20
> Contrast qpci_device_find() (lookup based on a pre-existing bus) with
> qvirtio_mmio_init_device() (lookup that did not use a pre-existing bus)=
;
> also note that qvirtio_pci_device_find() takes a pre-existing QPCIBus
> (since on that architecture, the QVirtioBus is itself a device on the
> QPCIBus).
>=20
> I suppose that we could indeed refactor the code to require callers to
> create the QVirtioBus object up front, and then make the device lookup
> (both qvirtio_mmio_init_device() and qvirtio_pci_device_find()) take a
> QVirtioBus parameter instead of QTestState or QPCIBus.  That's slightly=

> more work, but I'm happy to attempt it if you think it will be better.

At least to me, that sounds like the right way to go. I guess we might
run into other problems later if we have multiple instances of the bus
object floating around ... so sorry if this is extra work, but I'd say
let's better do it properly now instead of having to rework this again
later.

 Thomas


--geA4qVppOWPvv7GEVqqfX8bDCmhKV7Isx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZuNnjAAoJEC7Z13T+cC21ZakQAJESihByGGDbwGQX85WJdbCy
ZsPWNbH3rgMZ30R4DqHx/HRMNsx3RiFPabAt7pwH5Bojefk404qCbdKCvFh2rIaL
w+n170Y0jrauybm0QgcLGCX3zlUHIHs0nj+2QdomZcGXox8mh/K9hQe2Nrw4oDk6
fscrs0fSfKdMg+oAjLV1LXGwQLRnMOKdJdKSCVU+oRnnWMplMDpN++MSoQbBWMNe
PEZi9FKlg6JvzeScK4jnGkh/G3kUPYZX0TI3HFatOfvk1abweuxT1Z0z2SkjjVhy
c5suLpgDqpWwI+W2zB+kaOK3EBR6azJdpeU4tw1+m0ODYBxR/qqE8vADabzoKg5Q
YOYC17ISXh/PL9EFXMX9zugHpIfk891Pw5451MQNWLcgDG4clN3z0ZwNZANA233G
b3b0udN2E/fC0/C0rQTrCCtq6JeEflVBYa46oZngx7SmtHQcrpuebrZ1v8roRby7
WHgBJRFVe20idWrXaCNUFcRhteiinaMXO3eF2bscOZKe9/QXzF/u7ZXEyj7k9fzU
F/q2VFkgZjU7VJltd6AG2+kexU90syHIjfI5m7xhM03qgss6G4ZW3jNE30WOVcWe
utR7vxrHO9eO2uYp8hhpmiDwZ4w4TneNPkxzR5JMKV0qCrDSnSs6+3tcvyUBz1hm
GLZdOTnsfVVpl5aTa9IA
=gvUy
-----END PGP SIGNATURE-----

--geA4qVppOWPvv7GEVqqfX8bDCmhKV7Isx--
