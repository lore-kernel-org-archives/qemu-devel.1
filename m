Received: from eggs.gnu.org ([2001:4830:134:3::10]:47114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dPo-0000hh-Pq
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2dPl-0001I6-Ik
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 09:20:44 -0400
References: <20171012034720.11947-1-eblake@redhat.com>
	<20171012034720.11947-24-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
Date: Thu, 12 Oct 2017 08:20:16 -0500
MIME-Version: 1.0
In-Reply-To: <20171012034720.11947-24-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="06TfIQahFfOPKqv57HFPBiwMtK7R3Do3i"
Subject: Re: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--06TfIQahFfOPKqv57HFPBiwMtK7R3Do3i
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <61e393f8-fcc5-b098-d6f2-160091c448c2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 23/24] qcow2: Relax is_zero() assertion
References: <20171012034720.11947-1-eblake@redhat.com>
 <20171012034720.11947-24-eblake@redhat.com>
In-Reply-To: <20171012034720.11947-24-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/11/2017 10:47 PM, Eric Blake wrote:
> Now that bdrv_is_allocated accepts non-aligned inputs, we can
> remove the TODO added in earlier refactoring.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

I was a bit too hasty in the copy-and-paste from 22/24 - there is no
assertion in this patch, so the subject would be better as:

qcow2: Reduce is_zero() rounding

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--06TfIQahFfOPKqv57HFPBiwMtK7R3Do3i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfbBAACgkQp6FrSiUn
Q2ppPQf9EBl1dbCPaxtd3WfZjOsFSQ6huEvgGV9h46GFd6EbYccogGKVOVB9oyNz
OC2nTeWsadCkL5kZ8NlpfuvM9cxyajcedrQqYl95wlusRQEvqqWwL0HxxKvoKJzi
4Yr711SedG0pjfqvSfa48+VnhZ45BgwOfF8sTScuYBMoVkKfPxBJkJiH1WvqEDee
2XNaPgBuaCM+F+7hjpRa0FIxku3nkGxA4LgeeI/xB8HYmyeAPuQuldfGB68xKrkg
iyYMRjGAj76UhBjvOrK8SEVshtNmgWFKFixFBdpVlDYfa+JWXS3P8qRWa1f5uPx/
5R7Z2gLHiBTKCSyOJ+RDP2lyc//EvA==
=7K9w
-----END PGP SIGNATURE-----

--06TfIQahFfOPKqv57HFPBiwMtK7R3Do3i--
