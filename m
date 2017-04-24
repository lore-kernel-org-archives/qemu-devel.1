Received: from eggs.gnu.org ([2001:4830:134:3::10]:44668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gCc-0005lz-N0
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d2gCZ-000532-Lg
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:47:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d2gCZ-00052Q-BU
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 11:46:59 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3843DC059741
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 15:46:58 +0000 (UTC)
References: <20170424153615.18614-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9f7a11d1-0bd7-84cc-8406-5bed86c74166@redhat.com>
Date: Mon, 24 Apr 2017 10:46:55 -0500
MIME-Version: 1.0
In-Reply-To: <20170424153615.18614-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3Afvwf3bM23BPDg4sBE3otwPer5LLHntJ"
Subject: Re: [Qemu-devel] [PATCH] crypto: move 'opaque' parameter to
 (nearly) the end of parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3Afvwf3bM23BPDg4sBE3otwPer5LLHntJ
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Message-ID: <9f7a11d1-0bd7-84cc-8406-5bed86c74166@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: move 'opaque' parameter to (nearly)
 the end of parameter list
References: <20170424153615.18614-1-berrange@redhat.com>
In-Reply-To: <20170424153615.18614-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 10:36 AM, Daniel P. Berrange wrote:
> Previous commit moved 'opaque' to be the 2nd parameter in the list:
>=20
>   commit 375092332eeaa6e47561ce47fd36144cdaf964d0
>   Author: Fam Zheng <famz@redhat.com>
>   Date:   Fri Apr 21 20:27:02 2017 +0800
>=20
>     crypto: Make errp the last parameter of functions
>=20
>     Move opaque to 2nd instead of the 2nd to last, so that compilers he=
lp
>     check with the conversion.
>=20
> this puts it back to the 2nd to last position.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3Afvwf3bM23BPDg4sBE3otwPer5LLHntJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/h3vAAoJEKeha0olJ0NqNDcH/25fdfryhpz/Ppjyjrhi31Io
hft0WKUgM4xEm3HOjiL9/kiDAtL1ZrCx9uUPSsV1ZwD2Q/aQ8VJRoCBt55oqgFcY
HaAQr7M+YTmU87RoudOyxqcStP5OsA0ExjqB4JAwTLx39DKvHS1+cz2ajCksF9BX
TrRa7GRwZQEjSMWIdp6QDFazeYoO+EZRg+FeOgsP0u8k/O0B6S5HX3iyunRPeXFD
bP5unodKZjtbmTGtScAlrOVh802Vs9UHvpSPZFFqWztQ6ReCUOIE+tJuWR6WsOIu
cg3Z+QyocZ4U8rjvYcEO9sHduKeOLXuRnHVW0Ode7VOO0iG8Dl0cN6KQpL2PNB0=
=NeBG
-----END PGP SIGNATURE-----

--3Afvwf3bM23BPDg4sBE3otwPer5LLHntJ--
