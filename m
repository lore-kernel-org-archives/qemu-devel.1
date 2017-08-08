Received: from eggs.gnu.org ([2001:4830:134:3::10]:48700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df640-00009p-Ta
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df63z-0001PU-Es
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1df63z-0001OU-6G
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:04:55 -0400
References: <150107094952.114.932926322923994155@5d477a5b5989>
	<e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
	<87fud24drm.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b289a6e6-9773-c490-6c12-d43a6920d1c3@redhat.com>
Date: Tue, 8 Aug 2017 10:04:48 -0500
MIME-Version: 1.0
In-Reply-To: <87fud24drm.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ucdk8jJ6cH10As8jdUjlrwohEVFHXngCT"
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, kraxel@redhat.com, famz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ucdk8jJ6cH10As8jdUjlrwohEVFHXngCT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, no-reply@patchew.org, kraxel@redhat.com,
 famz@redhat.com
Message-ID: <b289a6e6-9773-c490-6c12-d43a6920d1c3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
References: <150107094952.114.932926322923994155@5d477a5b5989>
 <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
 <87fud24drm.fsf@dusky.pond.sub.org>
In-Reply-To: <87fud24drm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/08/2017 04:20 AM, Markus Armbruster wrote:
> Just back from the signed-vs-unsigned swamp, still catching up, sorry
> for the delay...
>=20

>>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py=
", line 160, in texi_members
>>>     items +=3D member_func(section.member) + desc + '\n'
>>>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py=
", line 133, in texi_enum_value
>>>     return '@item @code{%s}\n' % value.name
>>> AttributeError: 'NoneType' object has no attribute 'name'
>>
>> Eww, we have a bug in our qapi generator (a stack dump instead of a ni=
ce
>> error message).  I suspect this is caused by your use of '@ac_*' inste=
ad
>> of spelling out all the ac_ members added in qapi-schema.json in 4/5 -=

>=20
> Yes, we require doc comments to match the schema.  Wildcards aren't
> supported.  They could be, if we want them badly enough.
>=20
>> but it IS something that needs to be fixed on your end to quit trippin=
g
>> up the doc generator.
>=20
> Has anyone worked on a fix for qapi2texi.py?

We worked around the generator bug in the meantime, so the qapi2texi.py
bug is still latent (sadly, it's not my highest priority)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ucdk8jJ6cH10As8jdUjlrwohEVFHXngCT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJ0xAACgkQp6FrSiUn
Q2qd2wgAlm2hiImUbGzEEp7SWrrZ0YGEoVKldcyEGdZZtOmj9YXs9AZnG3t7xLlF
rG4jwLZa5nUCZxouK3L5pMr9D0CQAcwGfSpfThAFRK2mwLeGRL7+nCi4M2YD8PUa
nKiNwp9xNbJcGXhMG4q04yt/T4lzYoMtLL9FqXV1dBPz5AkDrOzD9rbo5OaKRYz5
M5nC92pi6RC1bELfF0k370WGtzLVV7YLXZxRIK35Z9zdKnEbiQZYSiPgyJvs0K5B
SQ73u8xnS+L44eGpUyf9Tz8wm0eRumdy6HVQduyvh/CXKdQSe8gOHzyVchpjWIiw
NjCuONQURnbx9z6mU+WIKAQrYgrlug==
=XC/J
-----END PGP SIGNATURE-----

--Ucdk8jJ6cH10As8jdUjlrwohEVFHXngCT--
