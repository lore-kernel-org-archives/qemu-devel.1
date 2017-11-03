Received: from eggs.gnu.org ([2001:4830:134:3::10]:52988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAghx-0000O6-Pf
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eAghu-0000B9-Kx
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eAghu-0000Ar-Bu
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 14:28:42 -0400
References: <20171103153333.6416-1-berrange@redhat.com>
	<20171103153333.6416-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9da0f03a-0104-6385-f60e-5a45899fdbc3@redhat.com>
Date: Fri, 3 Nov 2017 13:28:40 -0500
MIME-Version: 1.0
In-Reply-To: <20171103153333.6416-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Qv6OIURsDEIkv4MIAL4IPmNbpMkPaVPdl"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] build: don't create temporary files
 in source dir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qv6OIURsDEIkv4MIAL4IPmNbpMkPaVPdl
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9da0f03a-0104-6385-f60e-5a45899fdbc3@redhat.com>
Subject: Re: [PATCH v3 2/5] build: don't create temporary files in source dir
References: <20171103153333.6416-1-berrange@redhat.com>
 <20171103153333.6416-3-berrange@redhat.com>
In-Reply-To: <20171103153333.6416-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/03/2017 10:33 AM, Daniel P. Berrange wrote:
> There are cases where users do VPATH builds with the source directory b=
eing on
> a read-only volume. In such a case they have to manually run the comman=
d
> 'git-submodule.sh ...modules...' ahead of time. When checking for statu=
s we
> should not then write into the source dir.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/git-submodule.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Qv6OIURsDEIkv4MIAL4IPmNbpMkPaVPdl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln8tVgACgkQp6FrSiUn
Q2roeAf9HP1hiI0QQMxnzHl+3TRku82pkn0fwM/stxc1w3JUuU+/uP9CHok/6h1V
pdfOOtmPAShIOd+zd9Ozt2DNqHC9aIQ1ouwYOcAHP1eGOj7bz/CDKAA8vqfmq7a1
iatXJ3V3NNad8OJWWM7ToZbT9eNAXeVv/gwejvn4SsDnSYonuA7vcspV8UyD91Ed
YBiP0Rrb/chxls/zE2IQbl3+MYhTbsIwCnwOR9yRfCK9CimfwpLJgj6hCRiNFEN9
sOSUpmBMveCIsnIJErmZSO5jQgFSKV2JODpJZdSqdu99zFVlsfqYm/9TBAmxqu2L
DouO6r6vqSry9DszzDn2GReg8IRyFA==
=g8su
-----END PGP SIGNATURE-----

--Qv6OIURsDEIkv4MIAL4IPmNbpMkPaVPdl--
