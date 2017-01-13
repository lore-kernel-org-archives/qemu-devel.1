Received: from eggs.gnu.org ([2001:4830:134:3::10]:33981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7Vy-0002Fq-W5
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:27:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7Vv-0000jO-PT
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:27:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cS7Vv-0000jH-Gb
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:27:51 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CAF636A6C3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:27:50 +0000 (UTC)
References: <1484325849-18314-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0423b2d9-fa4f-86d5-ae08-b5851301120c@redhat.com>
Date: Fri, 13 Jan 2017 13:27:48 -0600
MIME-Version: 1.0
In-Reply-To: <1484325849-18314-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="b3pJEG9QScmJWjT143L6nJ1xAFuL2Vp4w"
Subject: Re: [Qemu-devel] [PULL 000/180] QAPI patches for 2017-01-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b3pJEG9QScmJWjT143L6nJ1xAFuL2Vp4w
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <0423b2d9-fa4f-86d5-ae08-b5851301120c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 000/180] QAPI patches for 2017-01-13
References: <1484325849-18314-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1484325849-18314-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2017 10:44 AM, Markus Armbruster wrote:
> This is Marc-Andr=C3=A9's "[PATCH v8 00/21] qapi doc generation (whole
> version, squashed)" with a few commit messages tweaked, and "[PATCH v8
> 14/21] (SQUASHED) move doc to schema" unsquashed into 161 patches.
>=20
> We did all the respins with in this squashed form to reduce noise.
> However, since the unsquashed form is better suited for review, and
> probably nicer if we have to revisit this part of the work down the
> road, I'm proposing to merge this unsquashed.
>=20
> If you want me to post the unsquashed patches, I'm happy to redo this
> pull request.
>=20
> If you'd rather pull the squashed version, likewise.
>=20
> I'm afraid this is a bit of a doc conflict magnet.  The sooner we can
> get it in, the easier for Marc-Andr=C3=A9 and me.

Indeed - there's already a merge conflict with commit e1ff3c6, which
landed between the time you created the pull request and now.

Also, in trying to merge your branch locally, I get a rejection message
from my git hooks:

$ git commit
tests/qapi-schema/comments.out:7: new blank line at EOF.
tests/qapi-schema/event-case.out:8: new blank line at EOF.
tests/qapi-schema/ident-with-escape.out:10: new blank line at EOF.
tests/qapi-schema/include-relpath.out:7: new blank line at EOF.
tests/qapi-schema/include-repetition.out:7: new blank line at EOF.
tests/qapi-schema/include-simple.out:7: new blank line at EOF.
tests/qapi-schema/indented-expr.out:13: new blank line at EOF.
tests/qapi-schema/qapi-schema-test.out:446: new blank line at EOF.

Worth respinning to fix those issues?

>       qmp-commands: move 'query-memdev' doc to schema

This one is the conflict with current master.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--b3pJEG9QScmJWjT143L6nJ1xAFuL2Vp4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeSo0AAoJEKeha0olJ0NqnZ4H/2mbOeNjoasy8R84zieduK43
sy1hiTSuJ5gGxU2TO/xngF9focS0OYAjwGa/I152e5pS5AAP7rqaB0ewyFyXHv6k
UsUT4P4oiErCvX3mDswb+zsPOPXB/lObWltkMPkDDTf59Q42DhyEq5arsFbhkdLq
+CyQTiYLyiCTuxaTizC0bvVSW5CHZJVSb5pLid5YV2pTFOvqHla/M7csNv14OGIa
xvguzaB6L2X9fN6MiTnfXVvubSGhXZfwZkbDeOISymu8rOiEHDv2Aq2WJsZMwKNY
MXeNFi6EHsPzx1Y/UYhiT1eSfKjGpWza6lROENTXorcPBmyfQH8LZA4AHCucNyM=
=xj5r
-----END PGP SIGNATURE-----

--b3pJEG9QScmJWjT143L6nJ1xAFuL2Vp4w--
