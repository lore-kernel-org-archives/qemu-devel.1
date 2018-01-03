Received: from eggs.gnu.org ([2001:4830:134:3::10]:50422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWs89-0001gp-I4
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWs86-0004xt-3y
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWs85-0004wf-Qd
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 18:07:26 -0500
References: <151457311672.138.10990872638117953444@5adcb62bf0d6>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7c24661-0816-cf27-6d79-fe6a584e8b7a@redhat.com>
Date: Wed, 3 Jan 2018 17:07:19 -0600
MIME-Version: 1.0
In-Reply-To: <151457311672.138.10990872638117953444@5adcb62bf0d6>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Yc1gIEvlkkZcO8GjjFZariIfbGAN4ioW0"
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Use *at functions instead
 of caching interp_prefix contents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, famz@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Yc1gIEvlkkZcO8GjjFZariIfbGAN4ioW0
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, richard.henderson@linaro.org
Cc: peter.maydell@linaro.org, famz@redhat.com, rth@twiddle.net
Message-ID: <b7c24661-0816-cf27-6d79-fe6a584e8b7a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] linux-user: Use *at functions instead of
 caching interp_prefix contents
References: <151457311672.138.10990872638117953444@5adcb62bf0d6>
In-Reply-To: <151457311672.138.10990872638117953444@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/29/2017 12:45 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/1: linux-user: Use *at functions instead of caching in=
terp_prefix contents...
> ERROR: do not use assignment in if condition
> #25: FILE: linux-user/elfload.c:2206:
> +    if (interp_dirfd < 0

Given that your compact if with embedded assignment makes the syntax
checker unhappy, should we look for a v4 that uses the construct we
debated in v2:

while (1) {
    if (interp_dirfd > 0 && filename[0] =3D=3D '/') {
        fd =3D openat(interp_dirfd, filename + 1, O_RDONLY);
        if (fd >=3D 0 || errno !=3D ENOENT) {
            break;
        }
    }
    fd =3D open(filename, O_RDONLY);
    break;
}


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Yc1gIEvlkkZcO8GjjFZariIfbGAN4ioW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpNYicACgkQp6FrSiUn
Q2r4Uwf+OtmPAyQlOamqzpE7ch8fpFOWCxcU+N8iHkisJRvoD51UNSrgQ+ECgRKe
mFj4yz89k3XLC/x1d4zK0pS+Wtsv01SPf3rP0JbbCg8s0fTEhIY+j8PVvsgfDMJ3
P2f7kkW6tKjEJ8ytRjz46DxDDQZp6T/3VDPjwM0vbG+HPy650DiDzZMHUXF83oKV
TMJviywjfCGMEQTcoB33rlYM0/py4Z/3lB3OmaXcn9YWcuTQz7qQ3/pyOXmVM8SC
BuVGDcB8SdVs/1tOAa/9YuqBpQDsOIzYYh+JuXBxCbR232noL6KY0umohP2XoQC1
cV863t2KGr7Yzi/ku53KNBT6uoLFQQ==
=sNAP
-----END PGP SIGNATURE-----

--Yc1gIEvlkkZcO8GjjFZariIfbGAN4ioW0--
