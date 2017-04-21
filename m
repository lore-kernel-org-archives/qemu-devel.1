Received: from eggs.gnu.org ([2001:4830:134:3::10]:36655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Zey-0001hX-5V
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1Zev-00089k-3P
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:35:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38726)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d1Zeu-00089S-Px
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 10:35:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74A8772AFA
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 14:35:39 +0000 (UTC)
References: <20170421122710.15373-1-famz@redhat.com>
	<20170421122710.15373-7-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fc043ba-af58-a94c-246e-ebbc5bbdc6c7@redhat.com>
Date: Fri, 21 Apr 2017 09:35:33 -0500
MIME-Version: 1.0
In-Reply-To: <20170421122710.15373-7-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="odVx2r0BsqrJGVUAg7AuJGDlMiIH0GmQu"
Subject: Re: [Qemu-devel] [PATCH 06/14] crypto: Make errp the last parameter
 of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--odVx2r0BsqrJGVUAg7AuJGDlMiIH0GmQu
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <2fc043ba-af58-a94c-246e-ebbc5bbdc6c7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/14] crypto: Make errp the last parameter
 of functions
References: <20170421122710.15373-1-famz@redhat.com>
 <20170421122710.15373-7-famz@redhat.com>
In-Reply-To: <20170421122710.15373-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 07:27 AM, Fam Zheng wrote:
> Move opaque to 2nd instead of the 2nd to last, so that compilers help
> check with the convertion.

s/convertion/conversion/

>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/crypto.c            | 12 ++++++------
>  crypto/block-luks.c       | 21 +++++++++------------
>  include/crypto/block.h    | 12 ++++++------
>  tests/test-crypto-block.c | 12 ++++++------
>  4 files changed, 27 insertions(+), 30 deletions(-)
>=20

crypto/block-qcow.c also refers to the changed the types, but does not
care about its parameters, so it looks like you got everything.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--odVx2r0BsqrJGVUAg7AuJGDlMiIH0GmQu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+hi1AAoJEKeha0olJ0NqV6kIAIJ16vzljqNaplW4AgBgpVMI
gtNRbCW4hnSzIoUv5y2NZJz6eGwladq6Mjq30KAwzSES4H12CUumyhzY5klBk+zF
4GGrmt08Z7r59GbewMlG+m8Dl4QUi6HaBTv8FVlAjmtENvQ6eJFGvittt13H490X
RpGdgoXAcXq/k2qGOfKl8gIWf5mMDgsxefKNfpIBEoOoPP3i1dpJRwFNFqOGT/RP
0H3sUX+GxFcxLqt3wEs3rm5RT8C9uTMJYTUvceAtwbay0D51zA+nmZEaKtej06J4
iCQrqPZWWQI0Q1/yj2Xh7CXd7wtn5T1nDsjo1Zj2R89c7aFlJVKTPyntDcTOpAM=
=C1hx
-----END PGP SIGNATURE-----

--odVx2r0BsqrJGVUAg7AuJGDlMiIH0GmQu--
