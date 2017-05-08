Received: from eggs.gnu.org ([2001:4830:134:3::10]:41262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nZE-0006ny-I6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d7nZD-0007pi-DG
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:39:32 -0400
References: <20170507000552.20847-1-eblake@redhat.com>
	<20170507000552.20847-7-eblake@redhat.com>
	<3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
	<d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <97f9365a-2a46-010f-0aa4-841c01605601@redhat.com>
Date: Mon, 8 May 2017 20:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="venNVgJ9xKFifFwSdgRx4eMAiwvwVPmXn"
Subject: Re: [Qemu-devel] [PATCH v13 06/12] qcow2: Make distinction between
 zero cluster types obvious
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--venNVgJ9xKFifFwSdgRx4eMAiwvwVPmXn
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <97f9365a-2a46-010f-0aa4-841c01605601@redhat.com>
Subject: Re: [PATCH v13 06/12] qcow2: Make distinction between zero cluster
 types obvious
References: <20170507000552.20847-1-eblake@redhat.com>
 <20170507000552.20847-7-eblake@redhat.com>
 <3f3d454b-6ab4-52d4-eaac-adaeec3ca700@redhat.com>
 <d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
In-Reply-To: <d8ba0bbc-b69b-9aae-0496-b1b6feb963d2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.2017 19:15, Eric Blake wrote:
> On 05/08/2017 10:54 AM, Max Reitz wrote:
>> On 07.05.2017 02:05, Eric Blake wrote:
>>> Treat plain zero clusters differently from allocated ones, so that
>>> we can simplify the logic of checking whether an offset is present.
>>> Do this by splitting QCOW2_CLUSTER_ZERO into two new enums,
>>> QCOW2_CLUSTER_ZERO_PLAIN and QCOW2_CLUSTER_ZERO_ALLOC.
>>>
>=20
>> (No, I'm not mentioning the fact that 060.out contains one more mentio=
n
>> of "Data cluster offset" that should definitely be a "Cluster allocati=
on
>> offset" or even "Preallocated zero cluster offset" at
>> block/qcow2-cluster.c:1780, because let's really worry about this late=
r)
>=20
> Oh, you mean this?
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01784.html

http://78.47.108.109:8080/oor0jae2.webm


--venNVgJ9xKFifFwSdgRx4eMAiwvwVPmXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkQu1sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A6IMH/RYphJ7fMwIrsaFBOZCIwltAjQx+4wEy
4Xlsc7SEy6Lm8cP+rOeVo+EUNY9d18+rR/5j9NKOZY767HE3c+BLhlxscY1v7/0r
d5SeC5vD527Vt+2Iguo2KrpwKDuNzv5ZFsH8jbl/GdbBn6Rlz4m2xDsuksH9udtr
vyoOj47QzQjndXCpsZA8xdTUGWBJ+NVVpm5F3XEIgG9q0o+1ttq7cdiHYzAvDB1Z
zLe1XKlKuHxtwMWOvDTCyaY8mgerXTZ3f8JFOXfm7lQCL2CwkwV4YRGvB9SF5h8w
z8xVE0ZWciUk1UKK+3l4tPinIouRPQAGcB3FdgVRF/27zkv9E8f2M0E=
=c/kx
-----END PGP SIGNATURE-----

--venNVgJ9xKFifFwSdgRx4eMAiwvwVPmXn--
