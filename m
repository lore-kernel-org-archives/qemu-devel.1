Received: from eggs.gnu.org ([2001:4830:134:3::10]:39363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2dc-0001Mk-KR
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz2dY-0000NP-Mm
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:28:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz2dY-0000N0-DV
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:28:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7683C820F2
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 15:28:03 +0000 (UTC)
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0be694c0-b54f-e6ed-7017-dbf448b7e2e9@redhat.com>
Date: Mon, 2 Oct 2017 10:28:01 -0500
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-3-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PBslFAMNbQSVjrvo1obFoNHMfEJaN9Cll"
Subject: Re: [Qemu-devel] [PATCH 2/8] qemu-options: Fix markup of -netdev
 l2tpv3
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PBslFAMNbQSVjrvo1obFoNHMfEJaN9Cll
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
Message-ID: <0be694c0-b54f-e6ed-7017-dbf448b7e2e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] qemu-options: Fix markup of -netdev
 l2tpv3
References: <20171002140307.5292-1-armbru@redhat.com>
 <20171002140307.5292-3-armbru@redhat.com>
In-Reply-To: <20171002140307.5292-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 09:03 AM, Markus Armbruster wrote:
> The table of option parameters lacks @table and @end table.  The
> parameters become items in the enclosing table of options.  Screwed up
> when l2tpv3 was added in commit 3fb69aa.  Fix the obvious way.
>=20
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  qemu-options.hx | 2 ++
>  1 file changed, 2 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PBslFAMNbQSVjrvo1obFoNHMfEJaN9Cll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSWwEACgkQp6FrSiUn
Q2pATAf6AlEDG4o5/TMMGTRzf2fSUAfYAVAm74YCR1/s7R3GWJhP+hTQ+OsH07EK
sy5hnnCmejpFqrzN38GZ5XsikpOH0ZVl6KBbR23IM/Tca2pwlo1hNAmZWgSRw9Pj
eKz+lYOT2tLLPIP1wayO2+tKUVOXhyABChloNk/HMNuT4wHK1E03ySDGz3MoPx7L
bXIjTOctjKxF2PTU20Pz3BTjq2mepLFViL1B6VGaeP2lZV66ny53uA7WRPFhtw6F
9nJLU0OTIOeFM6ZoxHJskjGaNRI33fRAUXc6pBcy6MtoYyNIB9bpLrpP2C0zJwtC
nkUGJaIO92KueoqNa7df+MwmAVA+WA==
=7Yk9
-----END PGP SIGNATURE-----

--PBslFAMNbQSVjrvo1obFoNHMfEJaN9Cll--
