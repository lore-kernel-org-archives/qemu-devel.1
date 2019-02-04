Received: from eggs.gnu.org ([209.51.188.92]:57867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqg6H-0006uL-D8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:23:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gqg6G-0000jD-Ee
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 10:23:57 -0500
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
	<87pnsbxsi7.fsf@dusky.pond.sub.org>
	<2850e8a6-e0c4-c8b0-602b-2192af8d7a3b@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <29b9255a-929a-9f73-3ded-03e5e7c0a008@redhat.com>
Date: Mon, 4 Feb 2019 09:23:29 -0600
MIME-Version: 1.0
In-Reply-To: <2850e8a6-e0c4-c8b0-602b-2192af8d7a3b@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ly2mLukXR8oeSRdmtiE45MC2DjX5PLn9s"
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>, Denis Lunev <den@virtuozzo.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ly2mLukXR8oeSRdmtiE45MC2DjX5PLn9s
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>
Message-ID: <29b9255a-929a-9f73-3ded-03e5e7c0a008@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v11 2/3] qemu-img info lists bitmap directory
 entries
References: <1548942405-760115-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1548942405-760115-3-git-send-email-andrey.shinkevich@virtuozzo.com>
 <87pnsbxsi7.fsf@dusky.pond.sub.org>
 <2850e8a6-e0c4-c8b0-602b-2192af8d7a3b@virtuozzo.com>
In-Reply-To: <2850e8a6-e0c4-c8b0-602b-2192af8d7a3b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2/4/19 1:49 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> +++ b/qapi/block-core.json

>>>   ##
>>> +# @Qcow2BitmapInfoFlags:
>>> +#
>>> +# An enumeration of flags that a bitmap can report to the user.
>>> +#
>>> +# @in-use: The bitmap was not saved correctly and may be inconsisten=
t.
>>
>> I doubt the casual reader could guess the meaning from the name.  What=

>> about @dirty?
>=20
> I'd prefer to keep it matching Qcow2 format specification. This Info ai=
ms
> to export qcow2 specifics as is. And Qcow2 spec is not something qemu-i=
nternal,

Indeed, but we CAN reword the qcow2 spec to pick more useful names, if
the existing names there are confusing.  (The name in the spec does not
matter, so much as the layout described by the name)

> why is it worse than QQPI, and why to have different name for the same =
thing
> in different parts of spec?
>=20
> We may instead rephrase it like
>=20
> The bitmap is possibly in use by other process or was not saved correct=
ly (and
> therefore this flag was not cleared). The data of the bitmap may be inc=
onsistent.

s/other/another/

but that rewording works for me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ly2mLukXR8oeSRdmtiE45MC2DjX5PLn9s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxYWPIACgkQp6FrSiUn
Q2pdBgf8CWXeg+tBHgNMrCU+E1ypFhbsjp3hMHacorF06qlqEr87wSd46dWoNwmL
dFCyuvu1Y9jlKPuEv0+Q/pFqj4csh9swriqbDzUif+AH0zeTHyInW/SIOrmxr2sc
XAiPXOUOaoabV+lwvfpPN9N3gxOkc0wCU+dHJxip4bI+8vcE2VROj79Bv2jHk3kw
4PYpwGzA7+EGtTmnuJWKUgK9npMRku3X5lTllID92lu44ToqvJGterxqZLCelDjg
N4fYpcIKDQcr4aO/X9ZB+WFY2qhnRli2MkNDv4af27UMAirjzeIYQ+0GABbmM9CZ
Q8lo78FcbvN1/AEbcSmKsJvrMuv1jw==
=J+Om
-----END PGP SIGNATURE-----

--ly2mLukXR8oeSRdmtiE45MC2DjX5PLn9s--
