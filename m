Received: from eggs.gnu.org ([2001:4830:134:3::10]:36015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCZPn-0003F5-1r
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCZPl-0004a8-Sv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 18:05:47 -0500
References: <151017987286.354.17484911984782218867@bafd83ae6430>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7741570f-5544-be75-840e-99aa44f19e9f@redhat.com>
Date: Wed, 8 Nov 2017 17:05:34 -0600
MIME-Version: 1.0
In-Reply-To: <151017987286.354.17484911984782218867@bafd83ae6430>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fXnlkqpQOffOmL31A8D8WVGLWJFQTHQlC"
Subject: Re: [Qemu-devel] [PATCH v2 0/7] various NBD fixes for 2.11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fXnlkqpQOffOmL31A8D8WVGLWJFQTHQlC
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com,
 vsementsov@virtuozzo.com, qemu-block@nongnu.org
Message-ID: <7741570f-5544-be75-840e-99aa44f19e9f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] various NBD fixes for 2.11
References: <151017987286.354.17484911984782218867@bafd83ae6430>
In-Reply-To: <151017987286.354.17484911984782218867@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 04:24 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed automatic build test. Please find the testing comman=
ds and
> their output below. If you have docker installed, you can probably repr=
oduce it
> locally.
>=20

> 140         - output mismatch (see 140.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/140.out	2017-11-08 22:20:18.0=
00000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/140.out.bad	2017-11-08 22:2=
2:51.888146974 +0000
> @@ -5,11 +5,11 @@
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> -read 65536/65536 bytes at offset 0
> -64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +can't open device nbd+unix:///drv?socket=3DTEST_DIR/nbd: request for w=
rite access conflicts with read-only export
>  {"return": {}}

Fixup in the form of 2.5/7 already sent.

> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

But I'm not sure if there is an easy way to tell patchew to include a
fixup patch and re-test the series, short of sending a v3.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fXnlkqpQOffOmL31A8D8WVGLWJFQTHQlC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloDjb4ACgkQp6FrSiUn
Q2orAAf+NNthZL+ATyd+hTEzv2vENDLMw/Ud4xFzd7Zt2eSGNA0PLr+kPyGbck47
JhNHryOLjUTKPGWIPsaCQmp0aDYXusBVqm47QwUtry77kDtcj8iNTIQKu4GrXf1r
R/yG6gUgPMh0W8UgumQM1yK1RPCakUdqgP5gagrJ4nrRH72yyo+m0t2Hka4cwywu
9aKNw06wdCyGJZPdEgBXpx8/H1b/RApiO/9+P3wCEwfm7IlIFlzQ02doNcPRYp+E
/ISxbKBgag5PNHQxjlY732hH7fgmTFg6aLg6FoAc2kfLfI33Wk1xbkWUxNiNLrYs
xFQRXxiKzauwk3t6OVgRkW+tvNUGdg==
=+RD2
-----END PGP SIGNATURE-----

--fXnlkqpQOffOmL31A8D8WVGLWJFQTHQlC--
