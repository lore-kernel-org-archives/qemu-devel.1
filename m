Received: from eggs.gnu.org ([2001:4830:134:3::10]:33228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xhs-0004CQ-RU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f8Xhl-0001wr-6b
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 17:00:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45802 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f8XhY-0000BN-Ct
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 16:59:56 -0400
References: <20180412124834.GA2025@ruderich.org>
	<68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
	<510ceca2c869bb1e8d4bdd87986f23170b779047.1523537181.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e7f00ec2-9f62-d732-5c18-030c9a06ea64@redhat.com>
Date: Tue, 17 Apr 2018 15:59:39 -0500
MIME-Version: 1.0
In-Reply-To: <510ceca2c869bb1e8d4bdd87986f23170b779047.1523537181.git.simon@ruderich.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eKUeabmZGspOz4j1UiLrq791SzeX4VJHu"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] hmp: don't truncate size in
 hmp_memsave/hmp_pmemsave
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
--eKUeabmZGspOz4j1UiLrq791SzeX4VJHu
From: Eric Blake <eblake@redhat.com>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Message-ID: <e7f00ec2-9f62-d732-5c18-030c9a06ea64@redhat.com>
Subject: Re: [PATCH v2 4/5] hmp: don't truncate size in
 hmp_memsave/hmp_pmemsave
References: <20180412124834.GA2025@ruderich.org>
 <68c390f22ae2afc6539cd7b127063e3d9534d50b.1523537181.git.simon@ruderich.org>
 <510ceca2c869bb1e8d4bdd87986f23170b779047.1523537181.git.simon@ruderich.org>
In-Reply-To: <510ceca2c869bb1e8d4bdd87986f23170b779047.1523537181.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 07:50 AM, Simon Ruderich wrote:
> The called function takes an uint64_t as size parameter and
> qdict_get_int() returns an uint64_t. Don't truncate it needlessly to an=

> uint32_t.
>=20
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>  hmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eKUeabmZGspOz4j1UiLrq791SzeX4VJHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrWYDsACgkQp6FrSiUn
Q2oO2Qf/VKofeOy08z9WG0Nd9OKwIsK3EAADQBtzOpzuQxIlN4nBkzqvWu5iX4IR
lzsW9Su2eRs2v4ybYypTkxg8v10BRAVRPJwCW3jOtLxkF3wZ2KmFcUffTtQMFHt/
Y0MbhBSJEjexnIB7oBtyA7Ui+PzGQ5njCTFv8WiQyWGS2Zb8qME9Pn7DEROg8JXQ
HkSj6cdbCVDAucdGZuuIMC9Z82HrobxJBW8po1f3WEfQwGU+HLpJVYr+MKPsCTBN
8/5hJlZFaqXWd83GYjFq7BmifeWm5RJ9/2CEmhSl6BLzi6K4ZrAQSBbv4JN0ZuWG
TH4LXS0L3opuVEQZLlWxHDMd92IEjg==
=Ubx7
-----END PGP SIGNATURE-----

--eKUeabmZGspOz4j1UiLrq791SzeX4VJHu--
