Received: from eggs.gnu.org ([209.51.188.92]:44757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr262-0004TT-3k
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:53:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gr1sH-00055X-8E
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 09:38:58 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<20190204094621.GB5855@linux.fritz.box>
	<87d0o7psz6.fsf@dusky.pond.sub.org>
	<b448da30-7e0d-98be-d3dc-578fffc55de8@virtuozzo.com>
	<20190205100039.GC5273@linux.fritz.box>
	<8bdd3e6e-f83f-e73a-6dad-870d05698334@virtuozzo.com>
	<20190205142855.GD5273@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b20608a8-e0bf-cc4d-625c-b2c7a631f49a@redhat.com>
Date: Tue, 5 Feb 2019 08:38:13 -0600
MIME-Version: 1.0
In-Reply-To: <20190205142855.GD5273@linux.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gEoc3GYuG1BIxDtPgprtFjce9Vjfl5vk2"
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap
 directory entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gEoc3GYuG1BIxDtPgprtFjce9Vjfl5vk2
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, "mreitz@redhat.com"
 <mreitz@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Message-ID: <b20608a8-e0bf-cc4d-625c-b2c7a631f49a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org> <20190204094621.GB5855@linux.fritz.box>
 <87d0o7psz6.fsf@dusky.pond.sub.org>
 <b448da30-7e0d-98be-d3dc-578fffc55de8@virtuozzo.com>
 <20190205100039.GC5273@linux.fritz.box>
 <8bdd3e6e-f83f-e73a-6dad-870d05698334@virtuozzo.com>
 <20190205142855.GD5273@linux.fritz.box>
In-Reply-To: <20190205142855.GD5273@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/5/19 8:28 AM, Kevin Wolf wrote:

>> How about the following:
>>
>> @in-use: This flag is set while bitmap is in use by software and it's =
data in
>> qcow2 image may be out of date when actual bitmap data is managed by s=
oftware.
>> Presence of this flag in offline image means that bitmap was not saved=
 correctly
>> after last usage and it's data may be inconsistent.
>=20
> Yes, I think this has the information it needs to have.
>=20
> It needs some spelling and grammar fixes, but before I make them, I'll
> wait if Eric would phrase it in a different way that sounds more natura=
l
> to him as a native speaker.

@in-use: This flag is set by any process actively modifying the qcow2
file, and cleared when the updated bitmap is flushed to the qcow2 image.
Presence of this flag in an offline image means that the bitmap was not
saved correctly after its last usage, and may contain inconsistent data.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--gEoc3GYuG1BIxDtPgprtFjce9Vjfl5vk2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxZn9UACgkQp6FrSiUn
Q2oDaAgAps6ufcSA1YIDRsy7ywZxdMca+8r5q7FO4catEQR1i8kmB3qtB0koEIeW
QtbpnaYeg8JyQaMJ3RdrPeoa71mYlMv5P3mN8DMafxKzQ724Jf/V5hS5Zzq4JANC
MBs+Zdrg9f/kP2a4I+8oPLbgQVgI5RUlIwLQv4pglc6oN5EWmDzVf+jnsAv7zez4
mhognmnXAkMG9BXwsUWYyS1QqlhDvaoa6kfspG0atx7N9PQV04krpjASmKd6kOx1
4S7fk3ThPprPUqZPNjMGKs1G9YlDh9SsBTOzOiQsTYf0pMu3zILU2tjRxMlKs1cU
0ZSdZcs70iXq9rFc9n60faJcsBYYdw==
=s9fe
-----END PGP SIGNATURE-----

--gEoc3GYuG1BIxDtPgprtFjce9Vjfl5vk2--
