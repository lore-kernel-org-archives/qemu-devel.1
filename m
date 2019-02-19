Received: from eggs.gnu.org ([209.51.188.92]:58285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvtb2-0000Jy-LQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:49:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvtb1-0005Gk-J8
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 19:49:16 -0500
References: <20190131175549.11691-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6f5e1b7b-27cb-2b10-785c-c937c982c855@redhat.com>
Date: Tue, 19 Feb 2019 01:49:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RVip61Q0GOanwLvOOujfYDzcuhQqY3ieS"
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] qcow2: External data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RVip61Q0GOanwLvOOujfYDzcuhQqY3ieS
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <6f5e1b7b-27cb-2b10-785c-c937c982c855@redhat.com>
Subject: Re: [RFC PATCH 00/11] qcow2: External data files
References: <20190131175549.11691-1-kwolf@redhat.com>
In-Reply-To: <20190131175549.11691-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.01.19 18:55, Kevin Wolf wrote:
> There are use cases where raw images are given (e.g. existing physical
> disks), but advanced features like dirty bitmaps or backing files are
> wanted that require use of a proper image format like qcow2.
>=20
> This series adds an incompatible feature bit to qcow2 which allows to
> use an external data file: Metadata is kept in the qcow2 file like
> usual, but guest data is written to an external file. Clusters in the
> data file are not reference counted, instead we use a flat layout where=

> host cluster offset =3D=3D guest cluster offset. The external data file=
 is
> therefore readable as a raw image (though writing to it invalidates the=

> associated qcow2 metadata). Features that require refcounting such as
> internal snapshots or compression are not supposed in such setups.

Overall the design to me looks as simple as it could be, which means
there is equally little I could object to.  I raised some technical
things, but this is an RFC anyway, so, yeah.

Looks good!

About testing...  I really don't know either.  I'll think about it,
maybe I come up with something.

Max


--RVip61Q0GOanwLvOOujfYDzcuhQqY3ieS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxrUoUACgkQ9AfbAGHV
z0DrcQf/YVCgSD5BIgvfYx/0BrUvx0nXKj4sZXo296hknDDrrS8bL8+n9q5QZjgL
y6asbp9hCZbpt+1WuGHAUyCLZKPvgjtDRKoYbaXeJ1o+4RAPlpjupSuPNuRfNw/g
X80NzvP6KZSfEDDkuLmbarnDPHp0bTyTggwG7qOtBlPE6cvsvzTwNPtyuyvFmdRy
GSZUommifUGxxJZ9lvPKvcfm5++Bd+vRDSTIbzp+6XKucNx9BUdJb+bs21eNtpx6
UWONXfDHkN04F3ok1vjvYFwDU5Ail9uJ7hcfpa0KcA5xuopwnEwGel1G8szEgc3B
q8fJfigsOlvX5P+LlO5UwD3doQ2QZQ==
=Uz1C
-----END PGP SIGNATURE-----

--RVip61Q0GOanwLvOOujfYDzcuhQqY3ieS--
