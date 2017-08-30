Received: from eggs.gnu.org ([2001:4830:134:3::10]:46480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8t9-0006l3-IA
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn8t8-0008VT-Dm
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 15:42:59 -0400
References: <cover.1504112061.git.jcody@redhat.com>
	<8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cfbf937b-8619-da88-bb17-66ab1990f4bd@redhat.com>
Date: Wed, 30 Aug 2017 14:42:51 -0500
MIME-Version: 1.0
In-Reply-To: <8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="q2ebsgJ2nhVeTdx1gkuON6122PFuk9Ggq"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/sheepdog: remove spurious
 NULL check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com, rjones@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--q2ebsgJ2nhVeTdx1gkuON6122PFuk9Ggq
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, kwolf@redhat.com,
 rjones@redhat.com, qemu-block@nongnu.org
Message-ID: <cfbf937b-8619-da88-bb17-66ab1990f4bd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/sheepdog: remove spurious NULL
 check
References: <cover.1504112061.git.jcody@redhat.com>
 <8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
In-Reply-To: <8fe8ddad6b924b460ca4ed4a7e401c18d24c246f.1504112061.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 11:57 AM, Jeff Cody wrote:
> 'tag' is already checked in the lines immediately preceding this check,=

> and set to non-NULL if NULL.  No need to check again, it hasn't changed=
=2E
>=20
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/sheepdog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--q2ebsgJ2nhVeTdx1gkuON6122PFuk9Ggq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnFTsACgkQp6FrSiUn
Q2oMNAf/RbCYjZZwrnUGfUUQSOU81yYbJuMiCwIaLlbRM/Sv2YNSE97g8ybzNWxv
rZ/gi83gSbPQ1LS6xT6l6xiovDEuQjZiqrTl94Pmkxox7/6YRgjlyLsiW3fuCTf1
oBtQxU1OPcLIFCFKNaYcu7slXx/acmlYl2TkaxbcYxSCMtLrk0jj1Aow6dY/guTR
r8Msrl/LqsnLna+PQ4izg7ab0Z9AeaaOupcitC8qffAhz27wrYImDU2wuO0NxAQQ
WDVo8njMIrtxaxIT3ARKW8hbobp4tCT5KA4GmT4laSlfSPG/DcMJPPkjyaeusvrA
hB9zYvOzJy6yKkWeQMfCsYrN9F57cQ==
=amBe
-----END PGP SIGNATURE-----

--q2ebsgJ2nhVeTdx1gkuON6122PFuk9Ggq--
