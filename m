Received: from eggs.gnu.org ([2001:4830:134:3::10]:57670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUpk-0000nc-5h
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1caUpj-0001pu-Cx
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 16:58:56 -0500
References: <20170123123056.30383-1-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bf4264b1-b04e-a21b-c818-dc1fdbe0f685@redhat.com>
Date: Sun, 5 Feb 2017 22:58:48 +0100
MIME-Version: 1.0
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UJjDd2Fw5nQp8nWbNqP8iS4UtccC1qEAJ"
Subject: Re: [Qemu-devel] [PATCH v12 00/16] block: Image locking series
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UJjDd2Fw5nQp8nWbNqP8iS4UtccC1qEAJ
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org,
 eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com
Message-ID: <bf4264b1-b04e-a21b-c818-dc1fdbe0f685@redhat.com>
Subject: Re: [PATCH v12 00/16] block: Image locking series
References: <20170123123056.30383-1-famz@redhat.com>
In-Reply-To: <20170123123056.30383-1-famz@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 23.01.2017 13:30, Fam Zheng wrote:
> v12: Fix test cases on old systems that doesn't have F_OFD_SETLK, such =
as RHEL
>      6. [Patchew]
>      Trim the commit message of patch 15 to avoid bitrotting.
>=20
> v11: Move lock bytes from 1-2 to 0x10-0x12. [Daniel]
>=20
> v10: While we still don't have comprehensive propagation mechanism that=
 will be
> provided by new op blocker system for "permissive modes", the locking e=
nabled
> by default is regardlessly useful and long overdue. So I think we shoul=
d merge
> this for 2.9 and build user options on top later when the op blocker AP=
I
> settles.

Reasonable, but it's worth noting that on my to-review list op blockers
actually have priority over this for 2.9...

(Or rather, they would have if there was a series posted.)

Max


--UJjDd2Fw5nQp8nWbNqP8iS4UtccC1qEAJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliXoBgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJooH/3DN9MSSYY/SuFJndmyAVMlkXNXAgWhX
DQ9F0IGIueE/Sf/nhme/2NypmBuimJ4Su+NBkoXSR2DlR6/6jIxSMx6lDO94USb3
/w7S6tHK9GwAOxI08dRtvrOEHIxF4KNp6YPcfZ+wqRlZlJJJOp3VRioxvQc5SkrP
2vSjP6Y8Sdu8PRHaIC4NoFEwTdsSUUg8F9GZsjCcv/ixiWmdaXjVczPP6EPAze0M
+YlQQar7X6l/TzC72GXOpTREKyYP1naTj8apxwzng8jYgq1aeICLw3V3ayJP5roo
z3NcWBqbQjy99hMFw++CZjDLNpw24MQ1Rm3UuKp5jEuU2HvPmABFsG4=
=jz/2
-----END PGP SIGNATURE-----

--UJjDd2Fw5nQp8nWbNqP8iS4UtccC1qEAJ--
