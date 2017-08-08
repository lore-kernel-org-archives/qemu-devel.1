Received: from eggs.gnu.org ([2001:4830:134:3::10]:50477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfA2D-0002aR-CY
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfA2C-0007dD-4T
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:19:21 -0400
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-2-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a33b066-e957-2371-b665-7165a9135a6a@redhat.com>
Date: Tue, 8 Aug 2017 14:19:01 -0500
MIME-Version: 1.0
In-Reply-To: <20170808175711.12203-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="blPbjn4EwI5ni6CMrALRxPJKtoL4c7BWJ"
Subject: Re: [Qemu-devel] [PATCH 1/4] IDE: Do not flush empty CDROM drives
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--blPbjn4EwI5ni6CMrALRxPJKtoL4c7BWJ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com
Message-ID: <5a33b066-e957-2371-b665-7165a9135a6a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] IDE: Do not flush empty CDROM drives
References: <20170808175711.12203-1-jsnow@redhat.com>
 <20170808175711.12203-2-jsnow@redhat.com>
In-Reply-To: <20170808175711.12203-2-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 12:57 PM, John Snow wrote:
> The block backend changed in a way that flushing empty CDROM drives
> is now an error. Amend IDE to avoid doing so until the root problem
> can be addressed for 2.11.
>=20
> Reported-by: Kieron Shorrock <kshorrock@paloaltonetworks.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--blPbjn4EwI5ni6CMrALRxPJKtoL4c7BWJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKDqUACgkQp6FrSiUn
Q2qAXAf8CH1fbvUToTsGSL9Bzga5PaxG6fGznK9wUgu3xbce2fYdkzbDlGjzE1Hl
tW5dE9yKJL4pqi36RPFiMyRRF7Rda5hsZHTOb5VcAO/I2P5Smld+SgfCOVtKY/ll
Gx7+mQsNGWgN8AJc/UoT3Q4vxF8gbabRMS7M5XJPrjDv+nZ0Obw62vXvm5WhD7iC
tBd/mJWXjg2iT0DSzBkHkw3sQtRfzG30MHgHxu64JF/o/DksfdiemMehXmW5VqvW
IjJUCXl42RyXH+Qati+co6ioisznhtBlFI6ZiZePDGHMvmsGxuWsnaIOoTcLcxso
QQQzRwFIeksPj6ZEOjb6tj0EuqtUCQ==
=XlRr
-----END PGP SIGNATURE-----

--blPbjn4EwI5ni6CMrALRxPJKtoL4c7BWJ--
