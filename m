Received: from eggs.gnu.org ([2001:4830:134:3::10]:48943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLOa-00019o-29
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLOV-000694-RF
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLOV-00068e-Kr
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:26:27 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEA567F405
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:26:26 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-6-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bd265d40-30e1-9ce1-bf14-e4e6f0ece24c@redhat.com>
Date: Wed, 26 Jul 2017 07:26:22 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-6-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UeMSKD4EKtriEPDKgXXMEEdnqdir3k0HJ"
Subject: Re: [Qemu-devel] [PATCH 5/5] ps2: enable multimedia keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UeMSKD4EKtriEPDKgXXMEEdnqdir3k0HJ
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bd265d40-30e1-9ce1-bf14-e4e6f0ece24c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] ps2: enable multimedia keys
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-6-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-6-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> Fixes: 8c10e0baf0260b59a4e984744462a18016662e3e
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/input/ps2.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/hw/input/ps2.c b/hw/input/ps2.c

Code fix by deletion is always fun (but is it really by deletion, if all
you are removing is the '#if 0' to re-enable code?)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--UeMSKD4EKtriEPDKgXXMEEdnqdir3k0HJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4im8ACgkQp6FrSiUn
Q2oJqgf9FqpAgscmZuGS3yLFOzBuyiYjTKc2ke37OCd8fhk8dzzE82Tzl/jzhly3
K7Bn5c1v8dWJoOQyJFRWereSQVtEmuPQ+qXPIDLJ1c5wPK+8ilQh+geV1g9SxJ7t
u3T6jbafPHUUG0r/FaBkafdu8UIufxEncpPAFdjcruoQYcvz41fMP83KHt3e810h
lgoIT8aq9nPCWMgwSB0tmt/GfI0n3xk7z9407VXsp3KvSlAa9TUHk9weI5H8o+Oj
CwW8FFabKc3xd2OCFOXpZysdqsDH/WGK8w5wqfeYafevU6PVo/yDcabJEkR/AO/F
h0ZqMAdzP/O22SYgCKoWT05PvV3Hng==
=LAdL
-----END PGP SIGNATURE-----

--UeMSKD4EKtriEPDKgXXMEEdnqdir3k0HJ--
