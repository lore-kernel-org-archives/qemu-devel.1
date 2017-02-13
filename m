Received: from eggs.gnu.org ([2001:4830:134:3::10]:56397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdKF3-0005G1-5g
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cdKEy-0003lX-RZ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:16:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cdKEy-0003l9-JH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:16:40 -0500
References: <1486134413-19988-1-git-send-email-den@openvz.org>
	<5909b505-fecb-fa98-6ae7-190b846add4c@openvz.org>
	<169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a1049fab-1880-3b03-63bb-6b898ee55b40@redhat.com>
Date: Mon, 13 Feb 2017 18:16:36 +0100
MIME-Version: 1.0
In-Reply-To: <169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="F3ngW53QtrG32g1iXRcxe3pUAXdUetM8F"
Subject: Re: [Qemu-devel] [PATCH 1/1] mirror: do not increase offset during
 initial zero_or_discard phase - pls consider this as V3 patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F3ngW53QtrG32g1iXRcxe3pUAXdUetM8F
From: Max Reitz <mreitz@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>, Jeff Cody
 <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <a1049fab-1880-3b03-63bb-6b898ee55b40@redhat.com>
Subject: Re: [PATCH 1/1] mirror: do not increase offset during initial
 zero_or_discard phase - pls consider this as V3 patch
References: <1486134413-19988-1-git-send-email-den@openvz.org>
 <5909b505-fecb-fa98-6ae7-190b846add4c@openvz.org>
 <169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
In-Reply-To: <169f96e8-0ca5-264d-350a-7f085905bd5b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 08:10, Denis V. Lunev wrote:
> On 02/03/2017 06:08 PM, Denis V. Lunev wrote:
>> On 02/03/2017 06:06 PM, Denis V. Lunev wrote:
>>> From: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>>
>>> If explicit zeroing out before mirroring is required for the target i=
mage,
>>> it moves the block job offset counter to EOF, then offset and len cou=
nters
>>> count the image size twice. There is no harm but stats are confusing,=

>>> specifically the progress of the operation is always reported as 99% =
by
>>> management tools.
>>>
>>> The patch skips offset increase for the first "technical" pass over t=
he
>>> image. This should not cause any further harm.
>>>
>>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> CC: Jeff Cody <jcody@redhat.com>
>>> CC: Kevin Wolf <kwolf@redhat.com>
>>> CC: Max Reitz <mreitz@redhat.com>
>> actually this is V3 patch. Sorry for broken subject.
>>
>> Den
> ping

Didn't Jeff merge v2?

http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg01319.html

Max


--F3ngW53QtrG32g1iXRcxe3pUAXdUetM8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlih6fQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Au+EIALFnfmpOL3bGX6ApHp+afKqMCtewG35L
6ZfbWcfb6hg9ppgUoiWXN5hGtszUl7TEGX5EXGThGS4SOO5a8R/xRy2pNyUfJmpF
Bch+IddES/gV1eQsIEl285/78EgVckfy5UEYn3DjFqRziy7nqT+vC15R0KPm0z14
+3VQUkfQ/1UGnJIXyzPjIoGzztj50nlfaDmFylmLGkdR5IzTydctfiaJ6LMl5VJ/
2UBBgnUjB1e1P6Oucvj8XzjWLUMj73bGbT2NvzNqCkHOiC0J1WZ/L4PMktazbdnu
qOPLTQ8AysJNRjBlOziKFnARlWw1s6HitbPqHLbtWh/XvchfWZQGjjo=
=7y4O
-----END PGP SIGNATURE-----

--F3ngW53QtrG32g1iXRcxe3pUAXdUetM8F--
