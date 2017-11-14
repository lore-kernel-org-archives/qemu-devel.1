Received: from eggs.gnu.org ([2001:4830:134:3::10]:42039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcWK-0002Bw-Ju
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:49:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eEcWG-0006E4-Bp
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:49:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eEcWG-0006DM-2K
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 09:48:56 -0500
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-2-makovick@gmail.com>
	<20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
	<99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <adc0fbc3-6bf6-d235-e0db-f79157ad7104@redhat.com>
Date: Tue, 14 Nov 2017 15:48:47 +0100
MIME-Version: 1.0
In-Reply-To: <99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hiNb600UrMhdhevl3qp0EKd98LgEF6Ck4"
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
--hiNb600UrMhdhevl3qp0EKd98LgEF6Ck4
From: Max Reitz <mreitz@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Cole Robinson <crobinso@redhat.com>
Message-ID: <adc0fbc3-6bf6-d235-e0db-f79157ad7104@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] sdl2: Fix broken display updating after
 the window is hidden
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
 <20171112193032.9724-1-makovick@gmail.com>
 <20171112193032.9724-2-makovick@gmail.com>
 <20171113123914.qvj7bjhdx4h5rx4d@sirius.home.kraxel.org>
 <99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
In-Reply-To: <99826cbb-2f99-8100-484f-85eab0b4731c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-13 17:35, Max Reitz wrote:
> On 2017-11-13 13:39, Gerd Hoffmann wrote:
>> On Sun, Nov 12, 2017 at 08:30:25PM +0100, Jindrich Makovicka wrote:
>>> With SDL 2.0.6, calling SDL_ShowWindow during SDL_WINDOWEVENT_HIDDEN
>>> blocks all subsequent display updates.
>>>
>>> Instead of trying to override the change, just update the scon->hidde=
n
>>> flag.
>>
>> Has for me the side effect that sometimes I have to press ctrl-alt-2
>> twice.  Showing window first time works.  Hiding the window works too.=

>> Showing it the second time needs the double keypress.
>>
>> Added fprintfs to figure why [1].  Reason for that seems to be a suspi=
ous
>> SDL_WINDOWEVENT_SHOWN event from SDL, so qemu thinks the window is
>> visible even though it actually is hidden.
>>
>> Have a slightly older SDL version (2.0.3).  Do you see that effect wit=
h
>> 2.0.6 too?
>>
>> cheers,
>>   Gerd
>>
>> https://www.kraxel.org/cgit/qemu/commit/?h=3Dtesting/sdl&id=3D8235bfb6=
6e7c82870ff1b1f47bdaaf4f522c5444
>=20
> The only thing I can say is that I submitted
> https://bugzilla.libsdl.org/show_bug.cgi?id=3D2818 as a result.  Nobody=

> has replied to that in three years, but when testing it on SDL 2.0.7,
> the issue appears to be fixed.

Having done a bisect, SDL2 revision 11151:7cfe088fafba seems to have
fixed the issue (for 2.0.6).  See also:

https://bugzilla.libsdl.org/show_bug.cgi?id=3D3410

Max


--hiNb600UrMhdhevl3qp0EKd98LgEF6Ck4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloLAk8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACxwH/jKCIGHwFVUehELZPWDM8qZkBEslfjtq
AIVDoV4bhiDNz37+aBfbfH5+5tg922+vQrzwQsfa3EWj+hE/sEgSR6K1BIxryoRf
49YkpULHaelbF5/TT0SlP59cquj4s+f8g7ym+92d6mdX7vi8XsGk8bziBvflXdHb
XUzFYNUuxShDujX/tg6wGV1DKXyW0cOdZacK9DGzfQYH+j0UE2w/YlgrhUfZzHnV
NWgr3VUflhCiwPJJ/+lF87um33CIRi0xKV704THN+9AqsuyzUJKajKclJ+U9y9bT
OxLIScXTvO2FpqscTC8mH8Y1tYi9L6YAjr30LsNuulXMDJG/ncusCp0=
=L3Uv
-----END PGP SIGNATURE-----

--hiNb600UrMhdhevl3qp0EKd98LgEF6Ck4--
