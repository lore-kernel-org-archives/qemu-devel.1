Received: from eggs.gnu.org ([2001:4830:134:3::10]:33526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcFrU-0007mJ-85
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcFrP-0003fa-O8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcFrP-0003ex-Db
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:56:11 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
	<7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
	<871soxaumw.fsf@dusky.pond.sub.org>
	<8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42893913-795b-afb8-b87f-66d0be3abc75@redhat.com>
Date: Mon, 31 Jul 2017 13:56:06 -0500
MIME-Version: 1.0
In-Reply-To: <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DAR4vpQTFKQXAVLmwEPGbgpR61Wwvgl94"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DAR4vpQTFKQXAVLmwEPGbgpR61Wwvgl94
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <42893913-795b-afb8-b87f-66d0be3abc75@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com>
 <20170728125759.GO12364@stefanha-x1.localdomain>
 <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
 <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
 <871soxaumw.fsf@dusky.pond.sub.org>
 <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
In-Reply-To: <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 07:34 AM, Eric Blake wrote:
> On 07/31/2017 03:16 AM, Markus Armbruster wrote:
>=20
>>>>> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?
>>>>
>=20
>>> So given the clean bill of health from valgrind, we definitely DO tur=
n
>>> over responsibility for freeing on object to its new wrapper, once it=
 is
>>> passed through %p.  Documentation could be improved to make that clea=
r.
>>>
>>> Eww, what happens if qobject_from_jsonf() can fail halfway through?

Hmm. What if we assert that qobject_from_jsonf() can never fail halfway
through?  Given my research on the other thread, gcc -Wformat will NOT
flag "['%s', %p]",str,obj as a mismatch, although our current code will
try to associate %p with str and probably die horribly when
dereferencing char* as QObject* (and if it does NOT die, we don't even
know that 'obj' was passed as a parameter).  Since the primary usage of
qobject_from_jsonf() is the testsuite, an assertion failure (forcing all
clients to use the interface correctly) is probably simpler than even
trying to have to worry about cleanup after partial failure (regardless
of whether we like the 'none' or 'all' approach).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DAR4vpQTFKQXAVLmwEPGbgpR61Wwvgl94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/fUYACgkQp6FrSiUn
Q2rNYAgAg4ekkTC25WssDm0VFsadLHZQOmHY5CFRa5bi/dUFmu8kztx7XFyLKyp/
7oEgeTexJ0S30aZfiHXojiJlG7RCkCiIMBhE42vcYhADIsocpFZklwZkOGqj+KmC
ow8HdM4LVPj7l2s8mXRnWAWyrgLi6AB9xfkyF+ylOYucBEq3U5bHsc0cyjqM9Wrr
iUPMM6/Y/HCUpUII9E+qZ9HZOXRisNCP6mkdNEsvjiDfDbMWLafMPEN6kKZ3gsP3
xFbYvjuWVA64k/HKTxLXdBnxZVP+Y8nSwLmYQ5gyR6CkaF9d0DnZYyI3EHj4yHDd
M73PCjdbnq/yMLi5Etb+b4Wl3GYnpA==
=cJIt
-----END PGP SIGNATURE-----

--DAR4vpQTFKQXAVLmwEPGbgpR61Wwvgl94--
