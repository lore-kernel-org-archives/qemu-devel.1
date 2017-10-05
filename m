Received: from eggs.gnu.org ([2001:4830:134:3::10]:53881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07tJ-000822-Cz
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e07tG-0004L7-4h
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39916)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e07tF-0004KE-OC
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:16:46 -0400
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-20-armbru@redhat.com>
	<CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
	<87sheyi4uj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8ae659b1-dbe5-e446-7fbe-bc044f4f8fa7@redhat.com>
Date: Thu, 5 Oct 2017 10:16:43 -0500
MIME-Version: 1.0
In-Reply-To: <87sheyi4uj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D6tdEPPNJP64uPo4hQUtRn0pMbfV7rNcD"
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted
 strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D6tdEPPNJP64uPo4hQUtRn0pMbfV7rNcD
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <8ae659b1-dbe5-e446-7fbe-bc044f4f8fa7@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 19/32] qapi: Accept double-quoted strings
References: <20171002152552.27999-1-armbru@redhat.com>
 <20171002152552.27999-20-armbru@redhat.com>
 <CAJ+F1CJYd4LqyPtkmr40tnCKhDV63urnAhUgkX=M++njtPmgYw@mail.gmail.com>
 <87sheyi4uj.fsf@dusky.pond.sub.org>
In-Reply-To: <87sheyi4uj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 11:41 PM, Markus Armbruster wrote:

> Sadly, the schema language is neither JSON, nor an established extensio=
n
> of JSON, nor Python.  This commit brings the schema language one step
> closer to a superset of JSON.  I feel "homegrown superset" is a slightl=
y
> less bad idea than "homegrown with large overlap".
>=20
> Naming the schema files .json was in bad taste.

Would it make sense to rename all of our files from .json to .qapi?
Then it is obvious that we are using a homegrown syntax; and it is also
easy enough to tweak things like .dir-locals.el to recognize that suffix
as triggering specific formatting rules.  Git rename detection means it
is still reasonable to blame across file renames.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--D6tdEPPNJP64uPo4hQUtRn0pMbfV7rNcD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnWTNsACgkQp6FrSiUn
Q2qh3Af/dXxI6UeYvQPbwHF+8l2viepoeSIuwkkAHi5LWgb//qN719S2+51X125W
vGzMaBxxfbmwof2NHhI86LntaiMHOFd5kZrl84TAwOB84C/ya/m4JsOChcbMPq6b
QYuTHAOGNoSux7zflVuYW86D608p1bvJG2BGEG1SA3RjEfqF0K25RxEqZSauncPv
zBv0LppZfrSiE6fLZXOPRzq4czz2MXEjd77wsLdd1TkG2iFmIiO/g0uTb+FkmC9H
RcM5vCFwqbghBw5vmrhbxRL4ruyGhWROkJ9pIzAg8+rbLwhEKLn9ZwhoaRueZg4O
uzTNGYmuPVmccpoDwPS5y2swKVgDLg==
=MqkZ
-----END PGP SIGNATURE-----

--D6tdEPPNJP64uPo4hQUtRn0pMbfV7rNcD--
