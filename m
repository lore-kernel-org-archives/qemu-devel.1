Received: from eggs.gnu.org ([2001:4830:134:3::10]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvLg-0000cc-Hg
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:19:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ckvLd-0008Qg-C0
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:19:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ckvLd-0008QU-5f
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:18:57 -0500
References: <148878895545.4635.12311472774377490920.stgit@bahia>
	<148878898250.4635.16941960568938577780.stgit@bahia>
From: Eric Blake <eblake@redhat.com>
Message-ID: <06296436-d489-04e3-6eda-02cfb98d7975@redhat.com>
Date: Mon, 6 Mar 2017 10:18:53 -0600
MIME-Version: 1.0
In-Reply-To: <148878898250.4635.16941960568938577780.stgit@bahia>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WLxRBpcffluTBa5hG1venbmhjNw6WuXmj"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] 9pfs: fix vulnerability in
 openat_dir() and local_unlinkat_common()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WLxRBpcffluTBa5hG1venbmhjNw6WuXmj
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <06296436-d489-04e3-6eda-02cfb98d7975@redhat.com>
Subject: Re: [PATCH v2 2/2] 9pfs: fix vulnerability in openat_dir() and
 local_unlinkat_common()
References: <148878895545.4635.12311472774377490920.stgit@bahia>
 <148878898250.4635.16941960568938577780.stgit@bahia>
In-Reply-To: <148878898250.4635.16941960568938577780.stgit@bahia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/06/2017 02:29 AM, Greg Kurz wrote:
> We should pass O_NOFOLLOW otherwise openat() will follow symlinks and m=
ake
> QEMU vulnerable.
>=20
> While here, we also fix local_unlinkat_common() to use openat_dir() for=

> the same reasons (it was a leftover in the original patchset actually).=

>=20
> This fixes CVE-2016-9602.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
> --
> v2: - keep O_PATH (Eric Blake)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--WLxRBpcffluTBa5hG1venbmhjNw6WuXmj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYvYvuAAoJEKeha0olJ0NqrukH/0/ioYBhuGrgPZZKB3F5jQF/
XM8+lZM+j2aRGksCHpkzwVWDxoTo9rqyZh5oy9rhLkLXYH7JfAKv0A7ZroME1Y7Y
CyQEhdeUl0w/O7N2i69AgCS4t8RVdCEKKKXBlX+KnMDbhEKNbaES+VmXU8YkuSaW
ilHyh+G2b9UlS2xbIFrLafRds4ujMBrwLZScZtNi9Ar+Cw3nQiSp/vu+rSZ16PYg
cfsJqDvn8RSyGlkiIM8MnXaGDCo0bAf9Gw8IM1oeUgwzOgybh0SjNrJX/egLU6xQ
I0Qc/bJtU2WtYHePYgLAWQZpTs78VTU5ee9vWPTk3qsIEm2OSCLd5mlIAFIcZNQ=
=dOxh
-----END PGP SIGNATURE-----

--WLxRBpcffluTBa5hG1venbmhjNw6WuXmj--
