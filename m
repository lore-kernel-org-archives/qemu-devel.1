Received: from eggs.gnu.org ([2001:4830:134:3::10]:41919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flSxp-0000TB-DF
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1flSxm-0007yO-C0
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 01:49:25 -0400
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
	<CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
	<alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
	<CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
	<20180802070824.GC11211@umbus.fritz.box>
	<CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
	<20180802140744.GD11211@umbus.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <21de1d73-448a-36c2-0989-3de1f9d64a02@redhat.com>
Date: Fri, 3 Aug 2018 07:49:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180802140744.GD11211@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vhDYEKLfzPaHF9lVPEeKjzd2pTbaOhmt4"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vhDYEKLfzPaHF9lVPEeKjzd2pTbaOhmt4
From: Thomas Huth <thuth@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, BALATON Zoltan <balaton@eik.bme.hu>
Message-ID: <21de1d73-448a-36c2-0989-3de1f9d64a02@redhat.com>
Subject: Re: [Qemu-ppc] [PULL 0/2] ppc-for-3.0 queue 20180801
References: <20180801035357.7804-1-david@gibson.dropbear.id.au>
 <CAFEAcA-FitsqU3kQJTFGSFgOh6Zsf2Zy2fO3OTnL5c+Tzi5pog@mail.gmail.com>
 <alpine.BSF.2.21.1808011300070.7488@zero.eik.bme.hu>
 <CAFEAcA-=c7O+h3c-gQ=31q0oyLzJhDNmEBzv4X2Yp_TBfYhC-w@mail.gmail.com>
 <20180802070824.GC11211@umbus.fritz.box>
 <CAFEAcA8sGVjGgXxR8ivSWJ6oDKJPfEGnWUuHh_quZK2GDSgU2A@mail.gmail.com>
 <20180802140744.GD11211@umbus.fritz.box>
In-Reply-To: <20180802140744.GD11211@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/02/2018 04:07 PM, David Gibson wrote:
> On Thu, Aug 02, 2018 at 10:16:32AM +0100, Peter Maydell wrote:
>> On 2 August 2018 at 08:08, David Gibson <david@gibson.dropbear.id.au> =
wrote:
>>> The macio fix, however, *is* a regression from 2.12.  Whether it's
>>> severe enough to warrant another -rc, I'm not sure.  It is a bad
>>> pointer access which is, well, bad.  It doesn't seem to bite
>>> obviously, needing valgrind to pick it up, but possibly that's just
>>> luck.
>>
>> I thought those introspection-bugs like the macio ones weren't
>> regressions ?
>=20
> Well, I ran Thomas's testcase on master and it generates several
> valgrind warnings, which don't appear on either 2.12 or master+the
> patch.

Maybe the macio bug is something new, but we had plenty of these
introspetion bugs in the other code (mainly the ARM code) which were
clearly there since a looong time already and nobody ever complained. So
it seems quite unusual that upper layer tools / the users are using the
introspection feature of QEMU. Thus I'd say this bug is not important
enough to block the release. We could fix it in the stable branch instead=
=2E

 Thomas


--vhDYEKLfzPaHF9lVPEeKjzd2pTbaOhmt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJbY+zeAAoJEC7Z13T+cC21xjcP/imK+XUzEVMzhiAs44WRKrq+
lnBh7jNKsfs9HN4VM3YFNeWl63Gsr7hyTC4I1vGktTKcAFo2KkJEHdHxe/euXLTN
PZyrCwxdHqQBZilBsZQ7WVGHy3FXPmRQcTqrovHiyw1hoqRwS0/L/G8rsa8tEd7M
P50etPFk4LNHrwgUyyn4rsralnTp7g5GGIw59TWtzGj510YHjEeg4HP7vYqjDq4d
Amu/S8gCXyRuNfBcOnJ2sqb2eWQhhK6/5JYV3b4l6HlmQ3sIQHNYj28JSHzEkYUd
jo1PrDSnnFwgRHesxkBVyReryR9V++Nm7W+HnwjRyaWVSHBLovwM6uNM/HXg6G7d
0vhy2e+VpQ/aj2SVnxSutoR7fjuVD8AH0JeA2hv4BQaHAQEZFJskRmPajjEolkYf
K9wHNxRyPWe8v3GEfme2iJw7hqk4Wbb5WIb1la9cY2ijDhG8f9rO0XhayKWz1VFH
N0x+YZNg5AmZSQYh0IKF4l2z73at/7B+TrIHkjOiTku1qxwLo9P3gDut3puIfJQN
DJqaDAyN9fmCDcWPVU9pX/B7wKrHk7MioD9enbe5Ve7M4A3L06yLrlkwR3XxEEp2
Clc7Z9rgP1k6Kb7qZOtQTa1sUh4FkiW396rmjg46o4Y1AWZvpYDjyFGUFWoXbTMy
2B1wbouWllMk38x4gwqj
=eOGs
-----END PGP SIGNATURE-----

--vhDYEKLfzPaHF9lVPEeKjzd2pTbaOhmt4--
