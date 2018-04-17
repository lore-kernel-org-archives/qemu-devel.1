Received: from eggs.gnu.org ([2001:4830:134:3::10]:60967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8XgH-0002Z2-TZ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:58:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8XgF-0005Nq-Bx
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:58:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8XgF-0005J8-3y
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:58:23 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<6ec4d227d2f4614fc79ee3411a5e447ead2d2a71.1523537181.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31db77ae-9fbf-5986-c952-7b490b4beee8@redhat.com>
Date: Tue, 17 Apr 2018 15:58:21 -0500
MIME-Version: 1.0
In-Reply-To: <6ec4d227d2f4614fc79ee3411a5e447ead2d2a71.1523537181.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qx3WaCzWH1laB0Kli1Lqyu4y9I96OQY4Q"
Subject: Re: [Qemu-devel] [PATCH v2 2/5] cpus: convert
 qmp_memsave/qmp_pmemsave to use qemu_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qx3WaCzWH1laB0Kli1Lqyu4y9I96OQY4Q
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <31db77ae-9fbf-5986-c952-7b490b4beee8@redhat.com>
Subject: Re: [PATCH v2 2/5] cpus: convert qmp_memsave/qmp_pmemsave to use
 qemu_open
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
 <6ec4d227d2f4614fc79ee3411a5e447ead2d2a71.1523537181.git.simon@ruderich.org>
In-Reply-To: <6ec4d227d2f4614fc79ee3411a5e447ead2d2a71.1523537181.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 07:50 AM, Simon Ruderich wrote:
> qemu_open() allow passing file descriptors to qemu which is used in

s/allow/allows/

> restricted environments like libvirt where open() is prohibited.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  cpus.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Qx3WaCzWH1laB0Kli1Lqyu4y9I96OQY4Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWX+0ACgkQp6FrSiUn
Q2rgmggAiA+IivQOB7f8odZ6hiDtcbRuA3huQxoUm+Yz/MRwf0f9k9mBhabw9DN9
Sa5xWTHF9xKfKI7nAeqCQUUdW88yf4nt+2C5cJPN7ee3iDpYeXudMv2FGV7AJwT0
tXxR6JvLcykWeBMbm3bHDET8D0ZEk1k/BPtlbilkV5koilulmmkKAV+1Eu08KZl5
xaF8i9SBw5EIaN3+33wtmYdfscqcJ19t4+f31yvb/x9fAKBHmcDkLH+67L8aALp4
Zj12OErPBOx11xIUpj1AaPNjhzXObr4ezZ4gPhmd6h5iBKWHXvE3eodpEJJauyqP
bsFau6fKGuQDiErJBNHh5R5YjMsLww==
=EXq0
-----END PGP SIGNATURE-----

--Qx3WaCzWH1laB0Kli1Lqyu4y9I96OQY4Q--
