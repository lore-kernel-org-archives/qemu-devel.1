Received: from eggs.gnu.org ([2001:4830:134:3::10]:34130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiiyr-0007Fb-GE
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eiiyo-0005fV-6A
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eiiyn-0005dl-Te
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:46:50 -0500
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-4-armbru@redhat.com>
	<1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
	<87vafe4fvv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef0c08bb-e277-1e86-cb3c-b4be13c0a0f4@redhat.com>
Date: Mon, 5 Feb 2018 09:46:44 -0600
MIME-Version: 1.0
In-Reply-To: <87vafe4fvv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LEFJDlyS4cg7jEvXx2XEnMzXNZjPmMpGZ"
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LEFJDlyS4cg7jEvXx2XEnMzXNZjPmMpGZ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <ef0c08bb-e277-1e86-cb3c-b4be13c0a0f4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 03/21] qapi: New classes QAPIGenC,
 QAPIGenH, QAPIGenDoc
References: <20180202130336.24719-1-armbru@redhat.com>
 <20180202130336.24719-4-armbru@redhat.com>
 <1cb0a904-25ff-fcac-bfac-7376683ed80d@redhat.com>
 <87vafe4fvv.fsf@dusky.pond.sub.org>
In-Reply-To: <87vafe4fvv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2018 02:49 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 02/02/2018 07:03 AM, Markus Armbruster wrote:
>>> These classes encapsulate accumulating and writing output.
>>>
>>> Convert C code generation to QAPIGenC and QAPIGenH.  The conversion i=
s
>>> rather shallow: most of the output accumulation is not converted.
>>> Left for later.
>>>
>>> The indentation machinery uses a single global variable indent_level,=

>>> even though we generally interleave creation of a .c and its .h.  It
>>> should become instance variable of QAPIGenC.  Also left for later.
>>>
>>> Documentation generation isn't converted, and QAPIGenDoc isn't used.
>>> This will change shortly.
>>>

>>>  schema =3D QAPISchema(input_file)
>>> -gen =3D QAPISchemaGenEventVisitor()
>>> -schema.visit(gen)
>>> -fdef.write(gen.defn)
>>> -fdecl.write(gen.decl)
>>> +vis =3D QAPISchemaGenEventVisitor()
>>> +schema.visit(vis)
>>> +genc.body(vis.defn)
>>> +genh.body(vis.decl)
>>
>> I don't know if it is worth a sentence in the commit message that the
>> visitor variable is renamed from 'gen' to 'vis' for less confusion wit=
h
>> the new class instances 'genc' and 'genh'.
>=20
> Did the rename give you pause when reviewing?

Enough to question whether it was intentional, since it wasn't mentioned
in the commit message (I obviously figured out that it was intentional
and useful, but the fact that I even pointed it out meant that I did
pause during the review).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LEFJDlyS4cg7jEvXx2XEnMzXNZjPmMpGZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp4fGQACgkQp6FrSiUn
Q2qNhwf+ILplFRKehTrbsYRZDPe4xusM5Fwp7xOjxWnVssoWIw0EKIgo9cyXx6Ix
+9g23y4qKG87OSQD8pF2IwCJLCavXiSCSVne/6wM3EVDllJpaD3Q60xG7Gujpx65
K3qPNmsKqh3bbA6Wh9F7FqOJHU4yVdxDYrO6a5BI3CgoKDWgI98asMSYPJim/Yrl
VRwoINd3EKZ1u9+J163B560641+NcRSn7rsvPbxgh9yKA6mCPRgmDyQFtSjEBtn6
Z1lt7nTqJwzEVcHBB1fZx+W2Og45RmfTu1O9IVgK9q3raif4sFn+EI9nNRPNY+ig
pMmlLOBBtcKTbEKLAtnzDDD6d2nh4A==
=xL7T
-----END PGP SIGNATURE-----

--LEFJDlyS4cg7jEvXx2XEnMzXNZjPmMpGZ--
