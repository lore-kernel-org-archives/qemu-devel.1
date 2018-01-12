Received: from eggs.gnu.org ([2001:4830:134:3::10]:53106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2Vm-0003tV-NB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea2Vl-0000xb-NY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 11:48:58 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-6-vsementsov@virtuozzo.com>
	<dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
	<0e1fe4e6-f496-4891-c428-e43b8d09887c@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6e25b6d1-130f-7e8d-be62-cf33be8166d2@redhat.com>
Date: Fri, 12 Jan 2018 10:48:38 -0600
MIME-Version: 1.0
In-Reply-To: <0e1fe4e6-f496-4891-c428-e43b8d09887c@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XXEoQdBo4NDMWyPGp1uEBH8NTBbaKhipP"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] iotests: implement
 QemuIoInteractive class
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XXEoQdBo4NDMWyPGp1uEBH8NTBbaKhipP
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <6e25b6d1-130f-7e8d-be62-cf33be8166d2@redhat.com>
Subject: Re: [PATCH v2 5/6] iotests: implement QemuIoInteractive class
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-6-vsementsov@virtuozzo.com>
 <dd58d0a5-3838-5ef7-cb8b-0b74e5e22d27@redhat.com>
 <0e1fe4e6-f496-4891-c428-e43b8d09887c@virtuozzo.com>
In-Reply-To: <0e1fe4e6-f496-4891-c428-e43b8d09887c@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 05:56 AM, Vladimir Sementsov-Ogievskiy wrote:

>> My python is not strong; it looks good overall, although I have a few
>> questions that may warrant a v3 before I give R-b.
>>
>>> +class QemuIoInteractive:
>>> +=C2=A0=C2=A0=C2=A0 def __init__(self, *args):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.args =3D qemu_io_arg=
s + list(args)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self._p =3D subprocess.Po=
pen(self.args, stdin=3Dsubprocess.PIPE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdout=3Dsub=
process.PIPE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stderr=3Dsub=
process.STDOUT)
>> Why STDOUT instead of STDERR?=C2=A0 Is the redirection intentional?
>=20
> this special flag means: "send subprocess stderr to the same place as
> stdout", so,
> I'll have both stdout and stderr in one .PIPE. I don't print these
> outputs, but return
> them to the user.

Okay, makes sense (my python inexperience is showing ;)

I'd welcome a review from anyone else, but since the resulting test
passes, I'm not opposed to taking the patch as-is.  If it goes through
my NBD queue, it will get my S-o-b (because I'll have to touch it); but
if it goes through anyone else's queue, that maintainer can add this
(weaker than R-b, but at least says I'm okay with it):

Acked-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XXEoQdBo4NDMWyPGp1uEBH8NTBbaKhipP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpY5uYACgkQp6FrSiUn
Q2oOxAgAiX9znO593j7+wdFe9XM/Jvym5aCy3TW4OBumehucTL+s8Jg2xJCKnehz
DvV1NPnf13ls4wc4arJ3mG4pJmiAFqHjUnO0d3eXnbpEIwMb3XZc2nny8MsdROOg
Lssba9R+ganxXvQlfRAvi4fd5p5b70zfktKyhEZJ9l0pdR6VINWJHIDIWmZCXQBR
dfCjVOZXxL2W58ZwyMxg1djfOUYCM5DdrP8RgGpnj8ftCHy/rB8i/DYf/9hq7K7u
5IJBpO8iaeCI7aOo0d6Bc+CIFd5CuUVkHd4jZD1mPgtyNodnb267aG0LYACwHWQL
jPeL4aFh3rCGSh2BakSEyRAqCvX1IA==
=5wgW
-----END PGP SIGNATURE-----

--XXEoQdBo4NDMWyPGp1uEBH8NTBbaKhipP--
