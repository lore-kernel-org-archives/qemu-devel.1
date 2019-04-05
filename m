Received: from eggs.gnu.org ([209.51.188.92]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNCp-0001X4-S9
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCN2a-00018U-Hx
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:29:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCN2Z-00013I-GE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:29:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so7527661wrx.9
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:29:47 -0700 (PDT)
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<20190405131616.071a6390.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
Date: Fri, 5 Apr 2019 13:29:44 +0200
MIME-Version: 1.0
In-Reply-To: <20190405131616.071a6390.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY"
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
 <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
 <20190405125918.462c6ae4.olaf@aepfle.de>
 <20190405131616.071a6390.olaf@aepfle.de>
In-Reply-To: <20190405131616.071a6390.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:16 PM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 12:59:18 +0200
> schrieb Olaf Hering <olaf@aepfle.de>:
>=20
>> This used to work still in January with c9d18c1c150c84e7a976df989ad04d=
df01083f46.
>=20
> It is not possible to just override EFIROM=3D$(type -P EfiRom) because =
this variable is also used by ipxe.git.

Yes, lets got back with the overridable form previous to f590a812c210:

-- >8 --
diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c30..fc501a6c30c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -49,3 +49,3 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 #
-EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom

---

I'll submit that patch.

Thanks,

Phil.


--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynPCgACgkQoqP9bt6t
wN6k4w/+PmHNHwibZHNfXo8PzO6jCq2m8yr8cRz2HWHboYojjeBuNfTeo/sBKnIh
clegStBhmEzMhjVAqEe5BfxDG5cwZ8dK5jY/Ep0pz7NH1IA/Sz4NNU98pxkTir2B
h8HwmgBENKMH7WnWgGcjvOxERFvt/9NuqKb6SmURDip8DUpdrLWT4KJWRS5UlbSg
v/a90XAh7wLxp40E1FF8mm20sPdonNJqVW3YR4hB1BsuyqZPxgYbipp/ze1Kh4tU
aceDon7lCz4x/pR2zY96BqR4WlUaI7BP8lLa0co6I3fNF8WxE24kJrkW8LE8witP
wyuN4xGyq0kHx2WrvJOlU0omSlxuABOXuEjbWujxcnF2+KEnHOKKNZjtmWdxpSNZ
WvVPPUY1raRihSIcCMfpLH7fWP0iXS1qfDd0gchagXPsbIUc3xyOkfUNxl7p/znt
u1dC3mb33yrBJ+Qxxi5uKJcfcSrps+K4jFpf2uUZ4jddXWpNcc65rvZSaJGh4Roh
n0vyjM7zAEvwRlGFWruRVJZFGX4DmkRWs8tjPwkm/um7H/R+XUxxYyO5KFQy45ME
Rzpy8LHb2698a8yQZow3f1FUhwPYfPEz5/AThmGNIjIpI1q6b5v2oFO+xpBM3TkP
SeccH3FdGeXhhir1xtNDpmdwNomjKniE0DWKweErsV1eluUfxFY=
=6oag
-----END PGP SIGNATURE-----

--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY--
