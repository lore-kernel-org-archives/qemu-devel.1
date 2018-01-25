Received: from eggs.gnu.org ([2001:4830:134:3::10]:45881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefLS-0001dv-Q1
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:05:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eefLO-0006IH-S4
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:05:26 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eefLO-0006Hi-Jx
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 06:05:22 -0500
Received: by mail-wr0-x241.google.com with SMTP id s5so5885370wra.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 03:05:22 -0800 (PST)
Date: Thu, 25 Jan 2018 11:05:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125110519.GE27269@stefanha-x1.localdomain>
References: <alpine.LNX.2.20.13.1801222034370.13989@monopod.intra.ispras.ru>
	<CAFEAcA9_a9wAdgmW_Ttc53hG8S2cJPu3Jw4noKtOAjzAJa9kUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9_a9wAdgmW_Ttc53hG8S2cJPu3Jw4noKtOAjzAJa9kUw@mail.gmail.com>
Subject: Re: [Qemu-devel] [GSoC?] Board autoconfiguration based on DTB info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Monakov <amonakov@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 05:59:00PM +0000, Peter Maydell wrote:
> On 22 January 2018 at 17:52, Alexander Monakov <amonakov@ispras.ru> wrote:
> > Is it feasible to consume a DTB file in Qemu itself to make the board m=
atch the
> > DeviceTree hardware description? For example on Arm there are quite a f=
ew .dts
> > files in Linux tree for various boards; having a "generic" Arm board in=
 Qemu that
> > could [to what degree?] emulate any of those sounds attractive in theor=
y.
>=20
> This is an idea that people have suggested before, and it's certainly
> an attractive theory, but unfortunately it doesn't work. The dtb files
> contain enough information about the hardware to allow an OS (and in
> particular Linux) to boot, but they don't include enough information
> in all cases to allow QEMU to create the hardware in the correct way.
>=20
> (There are some specialized situations where you can do it, for
> instance if you're an SoC manufacturer and you're creating both
> hardware and DTB and QEMU model yourself you can ensure that they're
> all consistent and generated from the same original information and
> the DTB has all the info QEMU needs in it; but we can't do it upstream
> in the general case.)
>=20
> Also, the main reason we don't have support for a wider range of Arm
> boards is that all the devices are different -- it's no good being
> able to read a dtb file that says there is a "mediatek,mt6797-uart" at
> a particular address if we don't actually have a model of that UART.
> Once you have all the device models, wiring up the SoC and board
> level code in QEMU isn't really all that difficult (though we could
> probably manage to make it a bit less boiler-platy).

Thanks for explaining.

Alexander: Thanks for raising the idea for discussion!  If you have
anything else, please don't hesitate to post on qemu-devel.

Stefan

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaabnvAAoJEJykq7OBq3PIKKcIAL6QFrAIdz99CKYkzSMUeyxq
78qrJV/9Wwf/8hHtrw2N3A8qi5DQqQ0oCGIS/U711oRlYd8Jr6ZaquTwx7+hR4px
0EJNmrY/Smmk0MrlI3TJ3tKUBE/MuP0pTP5S4GqFW9CDHCSI7Y5K9ipIi0cl+QdH
oJCDwH0/HzAIseDgt4e3QNRqK+UckmkuNYhSxhfJ6NrUrG+W/G/zOw/klGZAMg2N
I5Pg+bIu7bFdKr/+IXcG+7qjVjWDiF4tcetmZ8nUsfIPBUBhCIsSU+KUYtJySHhI
1CrZxf0PLYzHtm0IgT5DTSLGV0m6kMbFeIGJg2XCPflYShPtPknQ4wXUybNrLyM=
=H6l1
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
