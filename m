Received: from eggs.gnu.org ([2001:4830:134:3::10]:51296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfA3o-00043f-IL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfA3n-0008UH-Es
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 15:21:00 -0400
References: <20170808175711.12203-1-jsnow@redhat.com>
	<20170808175711.12203-3-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb086d6f-262b-e29e-8276-56502c492846@redhat.com>
Date: Tue, 8 Aug 2017 14:20:42 -0500
MIME-Version: 1.0
In-Reply-To: <20170808175711.12203-3-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L6WbFrHQIWX5GTie8IUs9Lnsv1KdPNbdC"
Subject: Re: [Qemu-devel] [PATCH 2/4] IDE: test flush on empty CDROM
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
--L6WbFrHQIWX5GTie8IUs9Lnsv1KdPNbdC
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, pjp@redhat.com
Message-ID: <fb086d6f-262b-e29e-8276-56502c492846@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] IDE: test flush on empty CDROM
References: <20170808175711.12203-1-jsnow@redhat.com>
 <20170808175711.12203-3-jsnow@redhat.com>
In-Reply-To: <20170808175711.12203-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 12:57 PM, John Snow wrote:
> From: Kevin Wolf <kwolf@redhat.com>
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  tests/ide-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20

> +static void test_flush_empty_drive(void)
> +{
> +    QPCIDevice *dev;
> +    QPCIBar bmdma_bar, ide_bar;
> +
> +    ide_test_start("-device ide-cd,bus=3Dide.0");
> +    dev =3D get_pci_device(&bmdma_bar, &ide_bar);
> +
> +    /* FLUSH CACHE command on device 0*/

Space before */

Reviewed-by: Eric Blake <eblake@redhat.com>

I agree with your assessment of 1 and 2 being 2.10 material.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--L6WbFrHQIWX5GTie8IUs9Lnsv1KdPNbdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmKDwoACgkQp6FrSiUn
Q2rGgQgAjtKXDu6IaI70M0QClPw3fEkd47uWc5ch9PLxOdOwv4b9ER4sB5r/J7Cn
iygM/ge2rtRRppagOeHDqHtukamhK6HSJ5B12IbWkSmUrvg6phkTflkC3dik+7w8
PPCCtKnJ13sfw21u5qY4tKr4asn9IlWw3184KwLVFjJxITILoxU1lDDPP3jEBRJf
KcceaFCIfFLHUGjgu4d31wriuZ0IX8ojYGyKlTZNjDFElXsHTkSc4Gr9SsJgABDx
KZDUH96JiATZe07qsF9hd1bumeoc8akKdPjWSFU6QBe59FLkyzTz8kuWqnNDtwDa
qTMndJuvq1BFjKnONQkTZ84yNGFJAw==
=9KXP
-----END PGP SIGNATURE-----

--L6WbFrHQIWX5GTie8IUs9Lnsv1KdPNbdC--
