Received: from eggs.gnu.org ([209.51.188.92]:38584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHrZ-0000Us-Gu
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hEHrX-00043u-Ni
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 14:22:21 -0400
References: <20190409210655.777-1-jsnow@redhat.com>
	<87y34i2zbt.fsf@dusky.pond.sub.org>
	<3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
Date: Wed, 10 Apr 2019 13:22:09 -0500
MIME-Version: 1.0
In-Reply-To: <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ"
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Message-ID: <e050a83f-4603-db8d-c869-53593027bf01@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
References: <20190409210655.777-1-jsnow@redhat.com>
 <87y34i2zbt.fsf@dusky.pond.sub.org>
 <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
In-Reply-To: <3d851b56-4f52-4c47-662d-bcbddf5db362@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/10/19 12:37 PM, John Snow wrote:
>=20
>=20
> On 4/10/19 1:39 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>>
>>> It turns out that having options listed in three places continues to =
be
>>> a bad idea. I'm still toying with the idea of an improved infrastruct=
ure
>>> here, but in the meantime, another bandaid.
>>>

>>
>> Nice to have in 4.0.
>>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>>
>=20
> If it can go in for 4.0, who stages it? Kevin?

At this point, we've missed -rc3; the fix on its own is not a
release-blocker, but if something else comes up that requires -rc4 for
an actual release blocker, we can sort out someone sending a pull
request for this one at the same time. (I'm aware of a couple of iotest
fixups in the same boat... Guess it's time to start updating the wiki to
point to email threads where we document 'wish list' patches)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyuNFEACgkQp6FrSiUn
Q2o5xwf9EtKJgQbBEnV7buNM89Z7a3lLWfW1GhWFEiNt61BGcMG2WqlsQGTbvbP9
hY1i4+KUDaAhJ11YeyZvIUS5jV6wzhFl+MoS2wlZ3v++g4aisUm9ll04JXpzpyrX
UDLpOTXLWUSpavX8z1UV+Rj3FU4csTfRQmA7iiDjnTAqYRZ2i+rvvHhr5lwCoj+b
mUO3Taavdhi6uONirYyHnvabBnT0Hzj5UgGXW8ybL1A5c9iC8PpcC5R6iYoIBZn/
gYj6HVIHQT5xiLxdQW7hMuTUnuNsyOFq3yiBsle8tWimQiES/AN2GaaksSGcrtyn
6Q28QFRgi9+4sR89zOPAiycHj6bDrA==
=hLYg
-----END PGP SIGNATURE-----

--HUKSuqAU5tfKfvZxavBJImSgOFHCrrUdZ--
