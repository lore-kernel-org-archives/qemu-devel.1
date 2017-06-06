Received: from eggs.gnu.org ([2001:4830:134:3::10]:40297)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dIFsA-000362-8v
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:54:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dIFs6-000282-DE
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:54:18 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
	<CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
Date: Tue, 6 Jun 2017 16:56:06 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h6x6dVrvAeEKodsNEK2HSbLvXVUn1RsXt"
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
--h6x6dVrvAeEKodsNEK2HSbLvXVUn1RsXt
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Message-ID: <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
 <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
 <877f0p38tr.fsf@dusky.pond.sub.org>
 <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
 <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
 <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
In-Reply-To: <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.06.2017 16:34, Peter Maydell wrote:
> On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
>> I've linked qemu with the original patch and:
>> ./configure --disable-linux-user --disable-system --static
>>
>> I got some warnings, I think they are originated from our libc and are=

>> not related to qemu:
>>   LINK    sparc64-bsd-user/qemu-sparc64
>> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
>> overridden by definition
>> /usr/lib/crt0.o: warning: defined here
>> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
>> /usr/lib/crt0.o: warning: previous common is here
>> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
>> overridden by definition
>> /usr/lib/crt0.o: warning: defined here
>=20
> Yes, I think I've seen those before on NetBSD -- they look
> like a bug in your libc to me, it shouldn't be confusing itself
> with itself like that :-)
>=20
> thanks
> -- PMM
>=20

I have filed this bug upstream: http://gnats.netbsd.org/52278



--h6x6dVrvAeEKodsNEK2HSbLvXVUn1RsXt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBCAAGBQJZNsKNAAoJEEuzCOmwLnZsA9AP8gOUmYozxD5ONW+z7lMYvEgT
ljr0As+2+y3jpXBlNx0+yLXc8cbUZf1bWhj3ZsHhGfEnUE+vkazQRL0MuNva7+7b
B5rt6uGpwIN5uYDiPKctqM0I9D9NkA4e1kbOBjaXEuDwvSOhp/mn5uTZLWcJaSqy
fzB6cTxIt5LHNHljmXqMyLvWp/rJsly2JPA8ESCDpKUnQE9X/+p8jzFKmvb+F/9/
zHfO5e3PihLIH0kTeF7A5OwlmLlxRa5O1qdNCem+YrcOywHzuMzewcJWY5yp+6V0
/2CyhVU/RY3E4ZIvOKSOJOvxdJRAbvwK2UoP9tuXa5B9etzPWiOF1dxcB8myRuSe
2ZqUAiL96y3zXh9UlVHwAEa7rYru9OANPptvDHbeSaRf4SLSuTHYbeD0tgFz0K7f
XkouGSbkOD7UhqZvtIHdHWLE5R3+ZPvVHeMdq72U9F8e7ixkYb5Toze2Qf2YLAWT
cDGAq76JSZoD0JOIj5z1jODocd2+IxRVjflCmooJLpRSE1qm3Hzhv35DJV2XBFoA
f2HYFCDsgeusYeQ1O5YHotkTNSd5oV+y+1MzzDrQ+xyIK+6rVZ4O0wnismqlZwst
Ny1+Vot5PomWMkmQwMM0sWuM3hcMqR1XzkCV2yanTlDUmLaHBvsH9Q/t3VGwBuHl
BqxWo0w3P2SkkkSrNgA=
=0FC/
-----END PGP SIGNATURE-----

--h6x6dVrvAeEKodsNEK2HSbLvXVUn1RsXt--
