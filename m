Received: from eggs.gnu.org ([2001:4830:134:3::10]:39880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrY2-0003mN-TJ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCrXy-0004XH-UE
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:55:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCrXy-0004Wl-Lk
	for qemu-devel@nongnu.org; Mon, 22 May 2017 13:55:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B6AC155E4
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:55:09 +0000 (UTC)
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
	<1495471335-23707-4-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <02f35a78-5004-9023-1e7d-3add147f0450@redhat.com>
Date: Mon, 22 May 2017 12:55:07 -0500
MIME-Version: 1.0
In-Reply-To: <1495471335-23707-4-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="agi2dbRaV2RrSERKVv3mwS69n6vOu27uq"
Subject: Re: [Qemu-devel] [PATCH 3/4] tests/qapi-schema: Avoid 'str' in
 alternate test cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--agi2dbRaV2RrSERKVv3mwS69n6vOu27uq
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mlureau@redhat.com
Message-ID: <02f35a78-5004-9023-1e7d-3add147f0450@redhat.com>
Subject: Re: [PATCH 3/4] tests/qapi-schema: Avoid 'str' in alternate test
 cases
References: <1495471335-23707-1-git-send-email-armbru@redhat.com>
 <1495471335-23707-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1495471335-23707-4-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/22/2017 11:42 AM, Markus Armbruster wrote:
> The next commit is going to make alternate members of type 'str'
> conflict with other scalar types.  Would break a few test cases that
> don't actually require 'str'.  Flip them from 'str' to 'bool' or
> 'EnumOne'.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--agi2dbRaV2RrSERKVv3mwS69n6vOu27uq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIyX7AAoJEKeha0olJ0Nq+ncH/iLc1Tz0Xy7UiVARuDgmBbM9
9JGZ1ulI649xPCX7Bhw8YdK+a1ZRtjsbJbArhOtQvc/d+0IV1qN1pNE6r937/R8j
Oop9Sn8T5mMCqoZJjeVAKXxnCALRTivYUy2/kqd23VYMwMUai99hYJLbKDaJF1al
JY+YT5w/DnEYioS6KP1p3wtPjCIltMegK7RPuY8nAziPInBlktIafiSCN3On8COD
hhytcAR1Mc9/LelK2Q5H8T6g4cV9cDxx+1Zuu+ZXMddZxUxeRl6PjkeFfFG9vjCI
g8zlhd3kZU9P7EoPW9ByyVqoXLdSxbMb57XJyikeIsf79qF3mjODddTyEdn/erg=
=8GJQ
-----END PGP SIGNATURE-----

--agi2dbRaV2RrSERKVv3mwS69n6vOu27uq--
