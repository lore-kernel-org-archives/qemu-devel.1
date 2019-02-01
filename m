Received: from eggs.gnu.org ([209.51.188.92]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpeUX-0004z0-RW
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpeUW-0001au-QI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:28:45 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
	<87womjwbwj.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
Date: Fri, 1 Feb 2019 13:28:32 -0600
MIME-Version: 1.0
In-Reply-To: <87womjwbwj.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nVp3trimZ6U2qn7B2OCuHILtSHARQt2DC"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nVp3trimZ6U2qn7B2OCuHILtSHARQt2DC
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, fam@euphon.net,
 kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Message-ID: <c017dbfe-f619-b626-211a-d3bdafb451aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org>
 <3ed70b8e-f778-f942-2841-905223d3af8d@redhat.com>
 <87womjwbwj.fsf@dusky.pond.sub.org>
In-Reply-To: <87womjwbwj.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/1/19 1:23 PM, Markus Armbruster wrote:

>>>> +# @unknown-flags: any remaining flags not recognized by the current=
 qemu version
>>>
>>> Intended use cases for @unknown-flags?
>>
>> The qcow2 spec defines bit 2 extra_data_compatible; and also leaves th=
e
>> door open for future extensions that may define other bits. If a new
>> version of qemu (or some non-qemu qcow2 creation app) creates an image=

>> with additional feature bits set, THIS version of qemu doesn't know wh=
at
>> name to give those bits, but can still inform the user that those bits=

>> are set via this field. It will be omitted for all images created by
>> this version of qemu.
>=20
> What would QMP clients do with this information?

'qemu-img info' is the intended QMP client; and it will print the
unknown-flags along with everything else. In other words, we're trying
to make qemu-img become useful for inspecting as much useful information
as possible from an image with unknown origins.  Knowing that an image
uses bitmaps with flags unknown to THIS version of qemu is a good
indication that you should be careful about using/altering the image
without first upgrading qemu, as it may destroy data that some other
product desires to utilize.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--nVp3trimZ6U2qn7B2OCuHILtSHARQt2DC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUneAACgkQp6FrSiUn
Q2on2Qf9G43K563jS5JwBtWt5How9+XjiC8SJaL5j28qB1AJClunECV7/YiMWvMD
QXR2tAI/1DwxAAWrbjp9Xe3orhc8YAQTW71zvexwvbHHYnIxuju6EfceQvGOs4Jc
3IXGPw9apKrUD5CdSAaX6lo5gKwAvndNku8poyQlUR0stUiQ4DwnhDL8tDqkS1Dw
MMFH+aFS1TUA9Oh6Y2XBan+BLBwVFh69+JnLjVbldIZBFjv1ln7hF6+UUX8P+pcB
Aw29RaTj1Z03VfEczVKGm1h/IO6Ptl52xEwA7229V0hWXZI2sc8djjOQ4eMQASz2
6O4Sf+SUC/DriXduINJGPQHiTs+QYg==
=/yM0
-----END PGP SIGNATURE-----

--nVp3trimZ6U2qn7B2OCuHILtSHARQt2DC--
