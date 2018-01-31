Received: from eggs.gnu.org ([2001:4830:134:3::10]:55135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyWD-0002yg-Fs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egyWC-0000Bd-Ly
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 14:58:05 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b884917-c70a-c500-3416-64b6c6aaee4d@redhat.com>
Date: Wed, 31 Jan 2018 20:57:54 +0100
MIME-Version: 1.0
In-Reply-To: <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4aMFcl8jaEungviMchOnue1cbri2g5Xty"
Subject: Re: [Qemu-devel] [PATCH v3 16/39] qcow2: Prepare l2_allocate() for
 adding L2 slice support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4aMFcl8jaEungviMchOnue1cbri2g5Xty
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <9b884917-c70a-c500-3416-64b6c6aaee4d@redhat.com>
Subject: Re: [PATCH v3 16/39] qcow2: Prepare l2_allocate() for adding L2 slice
 support
References: <cover.1516978645.git.berto@igalia.com>
 <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
In-Reply-To: <db0de08fbcb9cc8d77e7bd5040e89e167cbe1adf.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> Adding support for L2 slices to l2_allocate() needs (among other
> things) an extra loop that iterates over all slices of a new L2 table.
>=20
> Putting all changes in one patch would make it hard to read because
> all semantic changes would be mixed with pure indentation changes.
>=20
> To make things easier this patch simply creates a new block and
> changes the indentation of all lines of code inside it. Thus, all
> modifications in this patch are cosmetic. There are no semantic
> changes and no variables are renamed yet. The next patch will take
> care of that.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cluster.c | 55 ++++++++++++++++++++++++++++---------------=
--------
>  1 file changed, 30 insertions(+), 25 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--4aMFcl8jaEungviMchOnue1cbri2g5Xty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpyH8MSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AdSkH/AgnwlAwo2QPWxMCvUZ0cHzvH5Hq3K6V
aOh8czPPOmgiMNYnT/+1M781MnicJwWmB30jbXKF4uWggI30oK0dEhLcnFT56tlr
FZOviOedIeZorEC+WdjoDaNprouP0+cAukHoXSHZ7dtimjCLdG9qH4GuvBbJvV1j
m++NfPEvwTgLaLqYAj4PWrRn18ID8t3iBZyCAtymMFDLlWC57QRE5PXuEaXNfEF7
rwniRcngIQw0WpEoWeDhEQpccTkzAJUxuHg01VUqFrUWPrerTjLRnBhSeyxALkDi
uN411WEMypQWXux6QF7b6m59Sayb8HAOv5D4VHRWX43jWnhnW5AA63c=
=8Ftd
-----END PGP SIGNATURE-----

--4aMFcl8jaEungviMchOnue1cbri2g5Xty--
