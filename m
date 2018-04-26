Received: from eggs.gnu.org ([2001:4830:134:3::10]:58841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBXI7-0003YK-Pg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 23:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBXI6-0007sx-94
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 23:09:51 -0400
Date: Thu, 26 Apr 2018 13:06:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180426030633.GC8800@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
	<20180321032924.GP3905@umbus.fritz.box>
	<08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
	<16bbd1be-1d4a-b158-884b-9cda30502816@ilande.co.uk>
	<a16e6be7-a927-3ede-b5c4-c75d440d3213@ilande.co.uk>
	<a4f18bda-f67c-197c-c7fd-9bfc31c26f36@ilande.co.uk>
	<20180425063424.GU19804@umbus.fritz.box>
	<1e426fef-9504-f53b-2e5d-3376ed9b6032@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <1e426fef-9504-f53b-2e5d-3376ed9b6032@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 17/19] uninorth: create new uninorth device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:58:31AM +0100, Mark Cave-Ayland wrote:
> On 25/04/18 07:34, David Gibson wrote:
>=20
> > On Wed, Apr 25, 2018 at 07:06:03AM +0100, Mark Cave-Ayland wrote:
> > > On 06/04/18 06:33, Mark Cave-Ayland wrote:
> > >=20
> > > > On 25/03/18 22:11, Mark Cave-Ayland wrote:
> > > >=20
> > > > > Just to follow up on this, I spent a bit looking at what this
> > > > > register is trying to do and from the Darwin source I can see that
> > > > > in fact it is simply a hard-wired hardware register which should
> > > > > return the revision of the UniNorth hardware.
> > > > >=20
> > > > > So in fact the code in its current form is completely bogus which=
 is
> > > > > visible when trying to boot FreeBSD, which as the register is nev=
er
> > > > > written to, returns a completely different random number each tim=
e.
> > > > >=20
> > > > > David - are you okay to change DEVICE_NATIVE_ENDIAN to
> > > > > DEVICE_BIG_ENDIAN and then apply this and the final patch to your
> > > > > for-2.13 queue? I can then follow up with another patch later that
> > > > > will implement this register (and also the matching PCI revision =
ID)
> > > > > correctly.
> > > >=20
> > > > Ping? I can see that more patches are being added to the for-2.13 b=
ranch
> > > > so I was just wondering if there is now anything else needed from m=
e in
> > > > order to get the last 3 patches from this patchset queued?
> > >=20
> > > Ping again? The reason for asking is because my next set of Mac branc=
hes are
> > > all rebased on this patchset since they rely on this, plus the final =
two
> > > patches in this series which remove the need for qdev_connect_gpio_ou=
t()
> > > when wiring up macio devices.
> >=20
> > Uh... sorry.  I completely missed this series.  And, apparently, your
> > earlier ping.  Can you resend, please.  Make sure you explicitly CC
> > me, I occasionally go through the lists but it's easy for me to miss
> > stuff there.
>=20
> No it's okay - you've already got the majority of the patchset applied to
> ppc-for-2.13 (see
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04312.html) but
> it's the last 3 patches which are still missing, presumably because Phili=
ppe
> had some questions about them at
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06026.html and y=
ou
> queried the DEVICE_NATIVE_ENDIAN at
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg05597.html.
>=20
> If you're happy to consider patch 17 as just code movement and touch it up
> locally to use DEVICE_BIG_ENDIAN rather than have me resend, then does th=
at
> allow the remaining patches 17-19 to be applied to ppc-for-2.13?

Uh.. right.  Yeah, I've lost my context on this, sorry.  Can you
rebase and resend just the patches that aren't included yet.

> Once they are there I can send a follow-up patch which will completely
> remove the original implementation in patch 17 and replace it with a prop=
er
> versioned register, updating the PCI config space to match accordingly.
>=20
> In short: without the follow-up patch the code for the uninorth register
> both before and after patch 17 is wrong regardless of which endian is use=
d,
> so that itself doesn't affect whether or not it can be applied.
>=20
>=20
> ATB,
>=20
> Mark.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrhQjYACgkQbDjKyiDZ
s5LNCA/+JvdHnOurCBcL+mTbNC8lFsvY3iRa/fC0YFr1iOqm+H/C//cfMA7y0ZoM
Qhc07Bg0S3iBjgrK2Mqzs8xQmv3QX03ZwRVxfp3TgRXkZ5zlxMu0ka4ka1JfCDph
ZXlr8Ja7M+C2ULFZYJpv3eXGIaxvVcUlb+7IQpG+eBUS/SB8BOulFQmnbuNcZwJj
0UwIhwSrLodrV6AVBPXsc7NQxFB+o6HTq7Qd1nStjb6K3ZbnWK513q7+iyt9zRBM
elXpDivmidIAYbo4w0r1N+yIUDMlPuLc9b1H4lZM2pILRUJM9H8OH1qRyDmINXaY
dJuN1LGWgHfmEf3f82Uyp0szdEGopzJ4vu1dWHGHnJl2rqUZneAxIBKQ6dpy31S1
7Un9He97qyjeqFgYojomWXl7/vmNhcLBX/SKrA/4GaDfsLIAW6+U8QktMYSf4PVL
7BlhRI+4oFi6kNQhELd6vcuO6CxDgnWHjCoLJ9EX22iVhGHku4LYdNnmb/IYv/eQ
GxaVmE+K4V9OinVvmx3wdead3I+xscfGp0TUGOCUzqGrBvLGdzlIUnGpnLJs+rPX
K7nq0GfE9U93H1krojsKZdkNyqxZH+NU96jwsV+YEC8SuvmrFZTAPgC96E/uHLy/
i6O6upH6eiCOKe8AnopA2yWWFzkZU3QgxN96IAH/M6jXLAiBYOI=
=26PZ
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
