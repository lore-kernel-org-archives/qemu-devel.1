Received: from eggs.gnu.org ([2001:4830:134:3::10]:57316)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d2QEX-0002e1-Ba
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:43:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d2QEU-0001vG-6y
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:43:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:57658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d2QET-0001v6-R1
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 18:43:54 -0400
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
	<CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
Date: Mon, 24 Apr 2017 00:45:39 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="it7tV9LLv0SGver7jcrSujGUWVE4pFqcQ"
Subject: Re: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--it7tV9LLv0SGver7jcrSujGUWVE4pFqcQ
From: Kamil Rytarowski <n54@gmx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <3c22d799-1f28-a220-59d7-4218307748e5@gmx.com>
Subject: Re: [Qemu-devel] NetBSD maintenance
References: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
 <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-ycgLSU9aX1Ywd1Pky2bquqefJbsRpNvo4DuaXOyL3SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.04.2017 12:19, Peter Maydell wrote:
> On 23 April 2017 at 00:27, Kamil Rytarowski <n54@gmx.com> wrote:
>> I noted a call for NetBSD maintainers in the 2.9.0 release notes.
>>
>> I'm willing to attach a NetBSD machine to CI cluster and volunteer bas=
ic
>> maintenance. I'm mostly interested in NetBSD as host & as guest as thi=
s
>> is my daily and work driver on my desktop and development machines.
>=20
> Thanks for the offer of assistance. At the moment I have a
> NetBSD VM set up so I can run the usual make/make check
> tests that I run on other hosts. So the most immediate
> requirement is for somebody to investigate and send patches
> for the bugs which mean it doesn't build at all.
> My initial investigation suggests that at least one bug is that
> ivshmem-server uses shm_open but doesn't link -lrt, so
> some fixes to the build machinery are needed.
>=20

I will have a look and try to build qemu from git (master branch).

I also find it surprising that there was a call for CI machines and
there is no infrastructure for it.

>> As of today NetBSD patches for qemu are maintained in pkgsrc. There ar=
e
>> also at least DragonFly and SunOS (SmartOS) diffs available.
>> https://github.com/NetBSD/pkgsrc/tree/trunk/emulators/qemu/patches
>=20
> Accumulating patches downstream like this is I think
> a big part of the problem -- if QEMU has bugs on NetBSD
> then we need NetBSD users to report the problems and
> provide us with fixes. Otherwise you get what's happened:
> we try to build NetBSD with upstream QEMU, find it doesn't
> even compile, and conclude that obviously nobody's using
> QEMU on NetBSD because nobody's complained that it doesn't
> work, so we might as well drop it.
>=20

We should maintain buildable and functional version for major BSDs (Net,
Free, Open, DragonFly), Linux, Darwin and SunOS in pkgsrc. Not
necessarily every release is verified on each Operating System, but our
users at some point managed to get it functional on all of them.

> (I recall hitting that "ssp/unistd.h defines macros for read, etc"
> bug a few years back when I last tried NetBSD as a host;
> it looks like it's fixed in the headers on newer NetBSD, though,
> so maybe those patches could just be dropped if we're lucky.)
>=20

I will have a look.

>> Qemu is one of the core tools in NetBSD development and it's used in o=
ur
>> release engineering infrastructure:
>>
>> http://releng.netbsd.org/test-results.html
>=20
> Do you use/test the bsd-user code, or just system emulation?
> I know the FreeBSD folks have extensive patches to the usermode
> code, but does it work OK on NetBSD hosts, or is it just unused?
>=20

I'm afraid that there is no support in qemu usermode on NetBSD right now.=


I just used unicorn-engine (qemu fork) for this purpose.

>> I will start with upstreaming local diffs and move on to running tests=
=2E
>=20
> Thanks, I think that is the right place to start.
>=20

Thanks for reply!

> -- PMM
>=20



--it7tV9LLv0SGver7jcrSujGUWVE4pFqcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY/S6dAAoJEEuzCOmwLnZs85IP/jKu6GwBsF3KNH+9cXSTIX5E
MAxiGi2TrV6xt2SJSnHVL/Ies5BdU7z5vPGZdl3HUESrACfJ0Ur7/xl0Bh2ik51t
0EiisJNqHZ8mw5T+PafF+i6RFHnBpGscnK3vEiW0z5Y4UDnLI05pjnPx9XH/hUZD
ZhHhRY0A/btczQzO09fA6cLhsjPSWFq8tVRQ3JmV2Zhv7WPKxvV7CZ2CqUWe90lQ
ppKhBgm9j18IM5nkr+EtFV/Rku4oCNV1V1VNEYAGM9dXZVD4Ot4f0s8QFl2mg6WY
4RbP/vv4JbDlt7DjgMfAe9veJyjhG4KQjJ4soB6z1MP1RvDTR/cMgateS8iFBUAv
FGE6ffxVpyCHJSrUp0K7R+VoD3cWGxIDs7Rqyw1wGGsqfYv3+m/0vy+S+sJEQEaH
/wPjnUZehiLvnxagR4fNtYX1wfpqSwps9vVkCJejE8sadCZgj8ugrrIi9VKAuRla
Hj/OICWyBUc3OhchonosulxqGZ7DDK0PA0JyIQkUTNYlu/prPuvdRmO/sq6C6hp9
1fSxYWFU/0KgS4zth61GS/sc/XW9EVr3/NrNUOcxqzdKEZEsrk0OLpzHnWzXOUoe
+RQU59zk2puUcTsYIMKEElH/+kXmISP5aWy037g0NBybAu2n+J0l33B+XLjjeUK5
2Sos/crJMhLQ13BHTWsA
=Tj3n
-----END PGP SIGNATURE-----

--it7tV9LLv0SGver7jcrSujGUWVE4pFqcQ--
