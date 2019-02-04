Received: from eggs.gnu.org ([209.51.188.92]:51194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqh3G-0000KS-6f
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqh3D-00011g-VA
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:24:54 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
	<c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
	<877eefsnyh.fsf@dusky.pond.sub.org>
	<45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
Date: Mon, 4 Feb 2019 10:24:05 -0600
MIME-Version: 1.0
In-Reply-To: <45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eYgIJaQStN6lbsvWIqUA4wU4ryQwkwzm2"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eYgIJaQStN6lbsvWIqUA4wU4ryQwkwzm2
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, Denis Lunev <den@virtuozzo.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Message-ID: <8db32102-7daa-6b5a-8752-46727cbef106@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org>
 <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
 <87womjwbwj.fsf@dusky.pond.sub.org>
 <c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
 <877eefsnyh.fsf@dusky.pond.sub.org>
 <45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
In-Reply-To: <45148ff4-ea14-31ff-c298-4c8a349ad08b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 10:03 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> What would QMP clients do with this information?
>>>
>>> 'qemu-img info' is the intended QMP client; and it will print the
>>> unknown-flags along with everything else. In other words, we're tryin=
g
>>> to make qemu-img become useful for inspecting as much useful informat=
ion
>>> as possible from an image with unknown origins.  Knowing that an imag=
e
>>> uses bitmaps with flags unknown to THIS version of qemu is a good
>>> indication that you should be careful about using/altering the image
>>> without first upgrading qemu, as it may destroy data that some other
>>> product desires to utilize.
>>
>> Okay.  Now work that into the documentation :)
>>
>=20
> I'll try:
>=20
> @unknown-flags: any flags except 'in-use' and 'auto' set for the bitmap=
=2E
>                  Presence of non-zero @unknown-flags definitely shows t=
hat
>                  image was created by newer version of software (which
>                  supports more bitmap flags) or corrupted. Image can't =
be
>                  used for r-w with non-zero @unknown-flags in any bitma=
p.

The grammar still feels awkward.  Maybe:

@unknown-flags: If present, this is the value of additional bitmap flags
that were set in the image but not reported in @flags, implying that the
image was created with a newer version of software (that supports new
flags) or has been corrupted. Modifying the image without upgrading qemu
first will likely break the contents of the bitmap.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--eYgIJaQStN6lbsvWIqUA4wU4ryQwkwzm2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxYZyUACgkQp6FrSiUn
Q2qF0Af8DDNzjKWePY/f8U2ObA973pfe3x5ECk+0Im606abTl/KgLduQnyArxg91
PGcbRM83EaCbyeKchJv9Nv0dgDN7zPBxAwbJqvYJ8JCi3tjw2jH19u9kEB+s1sdl
aoyraG4G1KVYcHyXlrr3z0RiHs0DBg/gajwcobP6M+ytciJ2qDlsELuxV+/JXUSl
Hs7/aYB9CDKGagbucN9elLGtPYW0ijzag735WCe0ZcHxV8C2dZ8IgtN4W121QHaz
WByplPn2peKSEYJfNcSIAh0UhhcyHYT20sLeEIW82jz+3BA9VeqX5j88C0r/l+2V
4/At4LsFhAh2cLLbxmeQ7AmjhcUVVw==
=6qV1
-----END PGP SIGNATURE-----

--eYgIJaQStN6lbsvWIqUA4wU4ryQwkwzm2--
