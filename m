Received: from eggs.gnu.org ([2001:4830:134:3::10]:60711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDE18-0003vE-Hg
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eDE17-0005v2-Hx
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 13:27:02 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
	<w51375mv4by.fsf@maestria.local.igalia.com>
	<d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
	<w51tvy2t9m1.fsf@maestria.local.igalia.com>
	<45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <81f03429-dab4-5e86-9ca5-fecc4cfc91c7@redhat.com>
Date: Fri, 10 Nov 2017 12:26:49 -0600
MIME-Version: 1.0
In-Reply-To: <45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pviTh4g4obSUTdC84H3pvS85Ps5A6iN82"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pviTh4g4obSUTdC84H3pvS85Ps5A6iN82
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <81f03429-dab4-5e86-9ca5-fecc4cfc91c7@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
 <20171109203025.27493-5-mreitz@redhat.com>
 <w51375mv4by.fsf@maestria.local.igalia.com>
 <d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
 <w51tvy2t9m1.fsf@maestria.local.igalia.com>
 <45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
In-Reply-To: <45294d61-b108-3e96-2bdc-59b3d471fefa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/10/2017 11:29 AM, Max Reitz wrote:

>>>> It seems that in this patch you're indenting with spaces but this fi=
le
>>>> uses tabs.
>>>
>>> Yes, but tabs are wrong. :-)
>>
>> I actually agree with you, but don't mix them in the file :-)
>=20
> I can whistle and say here, too, that Eric liked it. O:-)

I don't really pay attention to which files have pre-existing TABs.
You're right that preserving whole-file TABs is a bit nicer from
consistency than reformatting a file wholesale; but then you have to
tell checkpatch that preserving TABs was intentional.  Mixed mode
indentation is not as consistent, but at least keeps checkpatch happy
without effort, and may make it easier for a patch down the road to
finally do wholesale conversion of the rest of the file to avoid TABs.

So when it comes to a file with existing TABs, I'm okay whether the
patch preserves TABs (with documentation that it is doing so
intentionally) or switches to mixed-mode spaces.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pviTh4g4obSUTdC84H3pvS85Ps5A6iN82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloF72kACgkQp6FrSiUn
Q2qA/wf/Z4PRwQOBZyGd3QB6q4UZbiqHou9D6SjJ3QIpTsU2ywiN5rk8ezTkEREy
kVWl6GPfNh+8JtCV0pOayxm4n1ODI2AOEwNJDEaxMb/BdP61XrNFt5lyK30qZt27
/liG5pbf5n76irNpft5qs26um+MQ3iWncmB+lHYSFSTwFfDWySDvOeS5SPK9iobM
w0J1i7cyWKSWJVjR6D2MFbEde/B/T+YPV//DcIrj/IkkFVmLzym+ubXgGSf8MBhi
KsfhGrknlRO96WxhwMNN/qIYRleTOu1DEES2l9ZYocSHbcScdLZzE/jToraiU57L
wHlcSpNh8SqNvVRQ53/y2BIphEGFzw==
=1J68
-----END PGP SIGNATURE-----

--pviTh4g4obSUTdC84H3pvS85Ps5A6iN82--
