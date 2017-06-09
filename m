Received: from eggs.gnu.org ([2001:4830:134:3::10]:40681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLuu-0001AW-4u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:33:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJLup-0003qk-Ib
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:33:40 -0400
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-2-eblake@redhat.com>
	<CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b3e66ce9-d503-bf6f-cd93-511097418480@redhat.com>
Date: Fri, 9 Jun 2017 10:33:32 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E5fcT9pB7twRrGqRBeoDBsH7n3w76Thnl"
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E5fcT9pB7twRrGqRBeoDBsH7n3w76Thnl
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com
Message-ID: <b3e66ce9-d503-bf6f-cd93-511097418480@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
References: <20170609152017.7286-1-eblake@redhat.com>
 <20170609152017.7286-2-eblake@redhat.com>
 <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 10:28 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Fri, Jun 9, 2017 at 7:20 PM Eric Blake <eblake@redhat.com> wrote:
>=20
>> A recent patch submission was about to use qobject_decref(QOBJECT(E)),=

>> even though we already have QDECREF(E) for that purpose.  While our
>> tree is currently free from the longhand form, we might as well update=

>>
>=20
> Oh?
>=20
>  $ git grep 'object_unref(OBJECT('  | wc -l
> 152

Quit mixing QOM and QObject ;)

$ git grep qobject_'..cref(QOBJECT'
include/qapi/qmp/qobject.h:    qobject_incref(QOBJECT(obj))
scripts/coccinelle/qobject.cocci:- qobject_incref(QOBJECT(E));
scripts/coccinelle/qobject.cocci:- qobject_decref(QOBJECT(E));

Yes, we may want to add a script to clean QOM abuses, but that's a
different project for a different day.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E5fcT9pB7twRrGqRBeoDBsH7n3w76Thnl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOr/MAAoJEKeha0olJ0NqCqUIAJ2dDzernby+VaTxULJ7//q0
gxZ5Nxkh3nye2PvbfthPNIU8drJOu9AaBjrzhNJ7HxQ7zBgcR3xeckbvJXFxwnoj
DTmO6V4aiStv9dMRySVRf9dhwOOJ8NyAqgZgaHm3a7BYolOVzglz4IZKTUWSWn1T
4UaCZhnY9mLSvJRsTU27hpmdJdc3ZwP9o6VwBI5KedBgG+WYBpyRsGsU3UwAzshs
F7T8GzOilfn6WGo5C7IR0vW5dOioNwsQHZgV1pHqGv5osbO3wK0uB8vbk7OswpHf
2zFIelXqaJs4dJeX9hTQIsd4iDb4lgD9qhK/JeLgIsjlR7qoyFIsL4k65ns24rI=
=awMj
-----END PGP SIGNATURE-----

--E5fcT9pB7twRrGqRBeoDBsH7n3w76Thnl--
