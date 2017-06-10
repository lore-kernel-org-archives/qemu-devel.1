Received: from eggs.gnu.org ([2001:4830:134:3::10]:50483)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dJgcW-0002K8-Ax
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dJgcV-00060D-JR
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 09:40:04 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
	<CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
	<6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
Date: Sat, 10 Jun 2017 15:41:34 +0200
MIME-Version: 1.0
In-Reply-To: <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oLiUDL6v0AEC3OiunHAH0pa2GEu9oxJtE"
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oLiUDL6v0AEC3OiunHAH0pa2GEu9oxJtE
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Message-ID: <cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
 <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
 <877f0p38tr.fsf@dusky.pond.sub.org>
 <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
 <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
 <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
 <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
In-Reply-To: <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.06.2017 16:56, Kamil Rytarowski wrote:
> On 06.06.2017 16:34, Peter Maydell wrote:
>> On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
>>> I've linked qemu with the original patch and:
>>> ./configure --disable-linux-user --disable-system --static
>>>
>>> I got some warnings, I think they are originated from our libc and ar=
e
>>> not related to qemu:
>>>   LINK    sparc64-bsd-user/qemu-sparc64
>>> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
>>> overridden by definition
>>> /usr/lib/crt0.o: warning: defined here
>>> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
>>> /usr/lib/crt0.o: warning: previous common is here
>>> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
>>> overridden by definition
>>> /usr/lib/crt0.o: warning: defined here
>>
>> Yes, I think I've seen those before on NetBSD -- they look
>> like a bug in your libc to me, it shouldn't be confusing itself
>> with itself like that :-)
>>
>> thanks
>> -- PMM
>>
>=20
> I have filed this bug upstream: http://gnats.netbsd.org/52278
>=20
>=20


What's the status with this patch?

NetBSD build still breaks due to ivshmem-*.


--oLiUDL6v0AEC3OiunHAH0pa2GEu9oxJtE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZO/ckAAoJEEuzCOmwLnZsGk0P/06By3LePjQknNLbZDunQTo2
/e1vAR7N03NQOWSRfhs+jZCHMGFKemByDh7S7MXXqbUPWE/+X5OMco2DFw4TJvLF
/4fQNYNrE6tOp2V75txYL3cawONoAVXTZnKw1nGGtcbncTBQuAngJtU3x8Sowdr7
iy0fqa21/7o4XT85Tntro6XKWc0udaOFHGnEDWvtK52aZbCP6F0sczislv8fSVLV
0FXpOZ7hnCywU2ubnMZad9kqqjYHjBjbkDprCtINx+0Ibi/Qm3TzG5+Gh2rNF7rI
bXuAXE6Y24DRO7iM8INx3RlLwx58QMnE2FBzdoW3xWwogRaw+ay9iWTtT8OjPjpn
rkzftHKYZVBMlTk2gy3rUUw5smlRwaVF2d/NtJ3jCzLUA+sW8TW82q/vbxMJnQIv
G4mjW/raZJoUkudksipyBhPDIizudXFXsQxUK1Taj9ap9Tx+LB15IpzUTaYVFEVi
MLwbFTD0EPRL6pYwiJKnYb5t6hNBiaIZVGeZqhtfjbF2+UDR4rxGcOiDu159WclO
7RkC0jFh06/SicCd4EIXe2p/4cHouEag37Q3ynBOhq2l/m2isFgzzqGeowU8tNbc
qID9mH2pIdBxRx5j8duIoJk7dTGPyQkGXFvMAQtVK/1skoccaHVr6cyquTokac6C
Uv+23nysTiLGuRzA+SoT
=QFEs
-----END PGP SIGNATURE-----

--oLiUDL6v0AEC3OiunHAH0pa2GEu9oxJtE--
