Received: from eggs.gnu.org ([2001:4830:134:3::10]:56675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAht-0005Df-U1
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:19:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1coAhp-0001x8-0u
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:19:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1coAho-0001w3-Ov
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 11:19:16 -0400
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
	<1489582656-31133-3-git-send-email-armbru@redhat.com>
	<3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com>
	<87vara8tes.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e7fece0-7f01-947f-8562-4096cad4f861@redhat.com>
Date: Wed, 15 Mar 2017 10:19:14 -0500
MIME-Version: 1.0
In-Reply-To: <87vara8tes.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PwgscOUnDcQWKEiNBNIERnpdksU9k9nVI"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
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
--PwgscOUnDcQWKEiNBNIERnpdksU9k9nVI
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <1e7fece0-7f01-947f-8562-4096cad4f861@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.9 02/47] qapi: Make doc comments
 optional where we don't need them
References: <1489582656-31133-1-git-send-email-armbru@redhat.com>
 <1489582656-31133-3-git-send-email-armbru@redhat.com>
 <3a9be3bd-4634-8ce8-8d95-04b4efa645d0@redhat.com>
 <87vara8tes.fsf@dusky.pond.sub.org>
In-Reply-To: <87vara8tes.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 10:13 AM, Markus Armbruster wrote:

>>> +Pragma's scope is currently the complete schema.  Setting it to
>>
>> You can do:
>>
>> { 'pragma': { 'doc-required': true } }
>> { 'pragma': { 'whitelist': [...] } }
>>
>> what you can't do is:
>>
>> { 'pragma': { 'doc-required': true } }
>> { 'pragma': { 'doc-required': false } }
>>
>> Maybe s/Setting it/Setting a given pragma name/
>=20
> Yes, that's better.  Perhaps "Setting the same pragma to ..."

Works for me.

>=20
>>> +different values in parts of the schema doesn't work.
>=20
> I considered rejecting all but the first pragma for any given pragma,
> but decided just add this note for now.

Yeah, I noticed. Coding up rejection is harder than just documenting
that repetition is undefined.  And it's not like we're adding new pragma
usages into our *.json files on a daily basis ;)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PwgscOUnDcQWKEiNBNIERnpdksU9k9nVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyVtyAAoJEKeha0olJ0NqnOkH/34w0kbx931K0ec3MQBRJsay
Oue+qlDPraId26DpztzW8I7FVQLTtYg5hr6x0WNGS4h5GSmmFeneij7EY4L9F/Fd
Gc5LXdhTXzMFOdatcN08eoRgv8oSFRXhLh0Ijo84m9T/c3YTivxSGR8e4MLLGHTE
ucgKK9YOEGM8cb5Tc7TbSfJsKwXHcPDx3wqXKdLLC97IJfX5B+P/3DXk0XmJ699E
EAKLvfk/i+MuuYzZWGTJlW2fm0Dz5Y08uE5q/qF0ubbcLXUJ3rWhFcyYGk2b2/qw
+0noNbBQidFcpaJOwr5hy9ts2bQY8873BvONBh3MRhnarUjogVD/Tgmey6HpedA=
=tvTG
-----END PGP SIGNATURE-----

--PwgscOUnDcQWKEiNBNIERnpdksU9k9nVI--
