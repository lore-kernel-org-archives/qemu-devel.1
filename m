Received: from eggs.gnu.org ([2001:4830:134:3::10]:41035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEc3-0000wW-VD
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:54:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eMEc0-0005Nd-2X
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 09:54:24 -0500
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
	<f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
Date: Tue, 5 Dec 2017 08:54:15 -0600
MIME-Version: 1.0
In-Reply-To: <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mcEcdpAvnCUQNXmxxseGapJ0oUx8Sc4MR"
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mcEcdpAvnCUQNXmxxseGapJ0oUx8Sc4MR
From: Eric Blake <eblake@redhat.com>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <71010746-2491-ae85-be6b-bf8b265924db@redhat.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 3/3] s390x: deprecate
 s390-squash-mcss machine prop
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
 <20171201143136.62497-4-pasic@linux.vnet.ibm.com>
 <927acf90-4a00-3fa2-9bf3-e34afc6be199@redhat.com>
 <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
In-Reply-To: <f892b02d-58b6-bb81-439c-f9177259f013@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/05/2017 06:05 AM, Halil Pasic wrote:

> Good catch! Regarding omitting the machine name, I was surprised that
> it works, but it does. Our documentation is a bit strange on this: we
> document the machine name as non-optional:
> "-machine [type=3D]name[,prop=3Dvalue[,...]]"
> but then use -machine prop=3Dvalue in the deprecation section (that's
> with no name).

QemuOpts at their "finest".  If it sees the first hunk as a value
without an =3D, then that value is fed to type=3Dname; but you are also f=
ree
to make the first hunk be an explicit name=3Dvalue (whether type=3Dname o=
r
prop=3Dvalue), at which point it is up to the backend whether type can be=

omitted.  So in this case, '-machine prop=3Dvalue' manages to work just
fine, and it's a question of how you would convey that information in
the --help documentation.

>=20
> Since the documentation doesn't make it clear that the property is
> existent only for the s390-ccw-virtio family of the machines I think
> being your suggestion has a lot of charm. @Connie: do you agree to
> removing the machine name (type)?
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mcEcdpAvnCUQNXmxxseGapJ0oUx8Sc4MR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlomsxcACgkQp6FrSiUn
Q2pdyQf/c9JufRCZPMyaknN5kylIiTX6MpJRIbB//KA0bL4DHW2fy+x7orKK+F/B
KUwbFkH1YxY6ONmJQAY5QuVlZXvIc/gIsagtEx1pKS6xFQ7bSJBwNcVO07ZUgveI
qffUX/cbtdx5lThbg7Ww9P2z+5/ZZwezymWUx0ccnAl7TikRJ2R7Fw47UjNR2U+0
okmpqael1j/S1tBrM5uN/UHr724+ImTU2HfmX6IBo3794/ikS59mFaDiY59l2d9h
4OuLm9qz8vUy0m3XLOf4nLywXOlnc3LtDXP06oUaJmlAEB1xWEmX0ySzVHLnzJWV
utkBJdalVMzBIjlVfTzPYYuFZCmx4Q==
=iC8p
-----END PGP SIGNATURE-----

--mcEcdpAvnCUQNXmxxseGapJ0oUx8Sc4MR--
