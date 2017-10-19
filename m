Received: from eggs.gnu.org ([2001:4830:134:3::10]:33927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5J3J-0002wK-Pr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5J3F-0001xA-R3
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:12:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e5J3F-0001wr-Hm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 18:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B390783F3F
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 22:12:28 +0000 (UTC)
References: <20171016131644.9565-1-kraxel@redhat.com>
	<20171016131644.9565-8-kraxel@redhat.com>
	<e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <58a70aa2-c318-b9de-de07-540b7c19d423@redhat.com>
Date: Thu, 19 Oct 2017 17:12:24 -0500
MIME-Version: 1.0
In-Reply-To: <e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bL5TiSRxE1uK8KFPguJjIjA399PKaTXkr"
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
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
--bL5TiSRxE1uK8KFPguJjIjA399PKaTXkr
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <58a70aa2-c318-b9de-de07-540b7c19d423@redhat.com>
Subject: Re: [Qemu-devel] [PULL 07/11] tools: add qemu-keymap
References: <20171016131644.9565-1-kraxel@redhat.com>
 <20171016131644.9565-8-kraxel@redhat.com>
 <e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
In-Reply-To: <e41b2fbc-98ed-cabb-4236-2126b887626c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 05:09 PM, Eric Blake wrote:
> On 10/16/2017 08:16 AM, Gerd Hoffmann wrote:
>> qemu-keymap generates qemu reverse keymaps from xkb keymaps,
>> which can be used with the qemu "-k" command line switch.
>>
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>> Message-id: 20171005153330.19210-2-kraxel@redhat.com
>> ---
>>  configure     |  23 ++++++
>>  Makefile      |   5 ++
>>  qemu-keymap.c | 258 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 286 insertions(+)
>>  create mode 100644 qemu-keymap.c
>=20
> For in-tree builds, this forgot to update .gitignore so that
> 'qemu-keymap' isn't accidentally checked in via 'git add -a'.

And on a related note, commit 2e1d70b pollutes the tree with a new
ui/shader/texture-blit-flip-vert.h, that should also be mentioned in
=2Egitignore.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--bL5TiSRxE1uK8KFPguJjIjA399PKaTXkr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnpI0gACgkQp6FrSiUn
Q2p5MAf/TbtMjHe7h9HRWKbpnwlwDUdQf43l56jJcMWr3c5LkRMpujt7tijhment
qd6/fGl/FMxugNB0WOaBIjuk8N4X+PNgmwPSqQ4EB97hCr33JVZ0N9xxiAuWYnlS
a4wz6hL+WipygaOkadIMqBO3bNk78a68Uljex7fyleIs97Y+ioxIdlXcKEqNFj1C
21pfp6YpF8B5YJSO9vN7RTB27RjCLbgNUPDyXnOovn0FGhWBl3cWVJRQmmZ7jxH+
P4k5x7fboZmrw0E2hfkC0813BfZsVIl4tcS/1Cbx+ML6h2Q0al44XPg+04bwrSAr
jWl3+Sg0bdC9DVJz5+Jj08mfWY1itA==
=seao
-----END PGP SIGNATURE-----

--bL5TiSRxE1uK8KFPguJjIjA399PKaTXkr--
