Received: from eggs.gnu.org ([2001:4830:134:3::10]:46050)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dKllN-0004im-To
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dKllJ-0003zM-LT
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:21:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:63830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dKllJ-0003xO-9o
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 09:21:37 -0400
References: <CABUdOL7gP=h8deWfuxz01eER2DkUFkFLZSdQcGhDJFzcmzGyZw@mail.gmail.com>
	<CAFEAcA-7MMVi-ubFGi9882WMgYUWMcbLiF9MVOT+cg-1A20cgA@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <c080b9c8-0728-753f-685a-7ae3d1f335cb@gmx.com>
Date: Tue, 13 Jun 2017 15:23:45 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-7MMVi-ubFGi9882WMgYUWMcbLiF9MVOT+cg-1A20cgA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="he53NM4ijhVCIpsdfj8BCmOuqv9PA7IKd"
Subject: Re: [Qemu-devel] Emulation without RWX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Antonio Groza <antoniogroza@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--he53NM4ijhVCIpsdfj8BCmOuqv9PA7IKd
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Antonio Groza <antoniogroza@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <c080b9c8-0728-753f-685a-7ae3d1f335cb@gmx.com>
Subject: Re: [Qemu-devel] Emulation without RWX
References: <CABUdOL7gP=h8deWfuxz01eER2DkUFkFLZSdQcGhDJFzcmzGyZw@mail.gmail.com>
 <CAFEAcA-7MMVi-ubFGi9882WMgYUWMcbLiF9MVOT+cg-1A20cgA@mail.gmail.com>
In-Reply-To: <CAFEAcA-7MMVi-ubFGi9882WMgYUWMcbLiF9MVOT+cg-1A20cgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.06.2017 14:44, Peter Maydell wrote:
> On 13 June 2017 at 12:54, Antonio Groza <antoniogroza@gmail.com> wrote:=

>> Hello, i am trying to emulate x86 on a platform that won't allow me to=
 map
>> memory pages as RWX(Apple's iOS) and i was wondering if there was any =
way
>> of running qemu without doing that. I've had a brief look at your
>> documentation and it looks like you are transpiling between 2 differen=
t
>> instruction sets and i don't know how that would be possible without a=
 rwx
>> page.
>=20
> It's certainly possible in theory -- you'd just need to be more
> careful than we are currently about mapping the memory RW when
> writing or patching code and then R-X when executing. (Now we're
> multithreaded this is probably trickier than when we only had
> a single thread, though.) But we don't do it currently and it
> would require (possibly complicated) code changes to do it.
>=20
> thanks
> -- PMM
>=20

MacOSX and NetBSD both have this RWX MPROTECT restriction and both have
option to relax it on per-page basis.

Example code inspiration is in LLVM's: Memory::AllocateRWX
(llvm/lib/Support/Unix/Memory.inc). [NetBSD code is still pending
upstream in review]

Proper PaX MPROTECT is not about toggling RW-RX memory region, as once a
memory page was allocated with W mode, it won't in regular circumstances
mapped to X anymore.


--he53NM4ijhVCIpsdfj8BCmOuqv9PA7IKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZP+dpAAoJEEuzCOmwLnZsRPUP/2VNfPUqIDjedVQlHMoaHIg0
DfrMmUmi50tOP6YqOQrHylpkOj5tWRu5vt2X6f682RzLHrpIyZHeHZvCrhnbVVe3
obCAdJV8wZ0uyp5I0WWt8W17EvRTKxMmLLEiGP3R8Y7O0r1v46UG3scHrIYCz5a1
t1dQH/aJJ6Lby22GSMi9EDVFW7v/P/xPwu/DR/7iDGWC+45NZDvCy2+iEY53mi0m
TBlsHaSrf4iYraAMNSB3bHezPlpkebcN8pNl3knwQDWL86/YDm1MB6eb26qaahla
hxRTyHkhzyoOdfvowBRI9rkT+3BHj2mNk04+17eoWbWP6d6SpVVnSkeblKZZhbfz
qw+RW9ZjLoESz1DXRvXGj4DgQgrGXm9at4qUTxFwz5pJjGQT+TniKbHG2zrd5wgb
HnFY83HDDHf5czXqW034ZoEF1voIUW4QSxBKPe6ziouAFUbv6T3/ZaJ1TUPEGFfc
quOgY63LEEKn4RWewdAB1DoDY7qPbUw8ExsY8jK6ZauR9HIvc6DWH7YUNv8XhZsT
r52JcI0Rsm0APe7q5LWeEqraHEpuee8lN5V2Zl8AQFqW3ytl3J3qBnNXWa/z6cet
WmgfiKB2iMQ761C359Mo0nST/XISxrOJgGe7PF414gJIQWgCMnsuNN7qHR+3Vv2H
NP4MH/cGyNlCPGNZeEIb
=Tqf4
-----END PGP SIGNATURE-----

--he53NM4ijhVCIpsdfj8BCmOuqv9PA7IKd--
