Received: from eggs.gnu.org ([2001:4830:134:3::10]:38236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEHhc-0001mm-4P
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEHhY-0002zC-U1
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:35:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eEHhY-0002yA-Fu
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 11:35:12 -0500
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-2-makovick@gmail.com>
	<20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
Date: Mon, 13 Nov 2017 17:35:03 +0100
MIME-Version: 1.0
In-Reply-To: <20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dClslqwlBElLBUq0iWq9J67PIfAsnI7Fn"
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating
 after the window is hidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dClslqwlBElLBUq0iWq9J67PIfAsnI7Fn
From: Max Reitz <mreitz@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Cole Robinson <crobinso@redhat.com>
Message-ID: <99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating after
 the window is hidden
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
 <20171112193032.9724-1-makovick@gmail.com>
 <20171112193032.9724-2-makovick@gmail.com>
 <20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
In-Reply-To: <20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-13 13:39, Gerd Hoffmann wrote:
> On Sun, Nov 12, 2017 at 08:30:25PM +0100, Jindrich Makovicka wrote:
>> With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
>> blocks all subsequent display updates.
>>
>> Instead of trying to override the change, just update the scon->hidden=

>> flag.
>=20
> Has for me the side effect that sometimes I have to press ctrl-alt-2
> twice.  Showing window first time works.  Hiding the window works too.
> Showing it the second time needs the double keypress.
>=20
> Added fprintfs to figure why [1].  Reason for that seems to be a suspio=
us
> SDL_WINDOWEVENT_SHOWN event from SDL, so qemu thinks the window is
> visible even though it actually is hidden.
>=20
> Have a slightly older SDL version (2.0.3).  Do you see that effect with=

> 2.0.6 too?
>=20
> cheers,
>   Gerd
>=20
> https://www.kraxel.org/cgit/qemu/commit/?h=3Dtesting/sdl&id=3D8235bfb66=
e7c82870ff1b1f47bdaaf4f522c5444

The only thing I can say is that I submitted
https://bugzilla.libsdl.org/show_bug.cgi?id=3D2818 as a result.  Nobody
has replied to that in three years, but when testing it on SDL 2.0.7,
the issue appears to be fixed.

Max


--dClslqwlBElLBUq0iWq9J67PIfAsnI7Fn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloJybcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9As9oH/0dcwaXjbccC26M8ToiVtjmJlxgAZFU1
uSljeOHBXKsN6ybghwaOmYo1RDCq4A7EABMtisuqNuIScQTAejgiQ8EVyoOtiAQi
JT2Xs0Z6hnKYhohzBoFSbq7J3cwYj+OjwVw/NAmBgezE4oKIaKj8J09z9DdwQMws
Cn/SijPjAUdPAe0DVa+ohYz+sdZXYsM7QLodbVvZM3XP9XDyLY5FqZz7q628CpT+
XDvhyeOMBDhneScZ8RQmOmDKU4NDIK8PETCMHXpewyWl74y5m/FG+HdWedBh8VYm
vgRHf/NoEaIo03Eub+Yy04vicsvy6pj6c+ig9IiPp9X/fr5xeklYcBo=
=zCr2
-----END PGP SIGNATURE-----

--dClslqwlBElLBUq0iWq9J67PIfAsnI7Fn--
