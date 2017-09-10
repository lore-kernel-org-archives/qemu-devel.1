Received: from eggs.gnu.org ([2001:4830:134:3::10]:50531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsrA-00018Y-Pp
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:24:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqsr9-0005r1-SJ
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 23:24:24 -0400
Date: Sun, 10 Sep 2017 13:24:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910032413.GB2735@umbus.fritz.box>
References: <1504100343-26607-1-git-send-email-thuth@redhat.com>
	<b98a4c56-f386-f827-5aa7-9a00e6fdf790@amsat.org>
	<CAFEAcA8O5T5cX8XqBVZqXLt5MPvF7qEcJK8Az2GBei07P0dZGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sPkBZsy7C+1fV4MN"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8O5T5cX8XqBVZqXLt5MPvF7qEcJK8Az2GBei07P0dZGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-2.11] hw/misc/ivshmem: Fix
 ivshmem_recv_msg() to also work on big endian systems
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>


--sPkBZsy7C+1fV4MN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2017 at 03:59:07PM +0100, Peter Maydell wrote:
> On 30 August 2017 at 15:53, Philippe Mathieu-Daud=E9 <f4bug@amsat.org> wr=
ote:
> > On 08/30/2017 10:39 AM, Thomas Huth wrote:
> >> The problem is that the server side code in ivshmem_server_send_one_ms=
g()
> >> correctly translates all messages IDs into little endian 64-bit values,
> >> but the client side code in the ivshmem_recv_msg() function does not s=
wap
> >> the byte order back. Fix it by passing the value through le64_to_cpu().
> >
> >
> > Yes, we lack BE testing :(
>=20
> My pre-pull-request test set includes s390 and ppc64 bigendian.
> This one was just missed because the 'slow' tests aren't in
> 'make check'.

I'm not what makes sense for staging this fix.  I could take it
through my tree, but it's not an obvious match, since this isn't
really related to ppc at all.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sPkBZsy7C+1fV4MN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0sF0ACgkQbDjKyiDZ
s5JL3Q/+Ji8DsCsJIFVYfPchCFbPYIowKAF2c1VyBFHH1Tb6OPNSNoOQmcKBe8hq
ajBPlbpz88DGZJR+ZJNkjBOVcGimHpkC56kZsIvYYcYczerf43x2L8ZFHFeVmDiA
zLiCmL4oWU6BvytOri8SstJyAQiyyQJpDPCZVgsolFB04V0HJ4XAJIU6BKmF5CvX
6Xe0amEFRVa2a1A7aaAW9EjVt72J6XxDe44Ebk6bQYIvfYDnL8Y35rTMBOXwQyEk
LJ6EBuzA8TGxT8EOoysd1eggPa/BG59nGF152I5djDoOYZotZ1W26Azvyv/bOifS
/2OX1mWSexskUcg2Ewgfo2GodwKrAupgmLxpKg7JmsnbGEY06tLbS+oBrJKwPc5i
+zenahnfjampu7PPsgvxJfs074KCTl/chR5XpIBHmGw2Bl1I86XOsdju20tUHR/U
vbSfrYhdlKmIPdXElKOAdGKyR13K/OhiV9frxBLBLlPiK9k8EMJWo/BiD7eOIQjo
LTNvRyhZ1WZLObMmLrlWRYTJ6sxkT04684iHoZPM9Nk6JWjHP7BfkALtsLK7TAr4
TQTyRKyQCsQoX/uw27//QbO12iDptf1L4xZoVljPcmEONKOvolZYxgNfhYmFYsVD
G57PvOLfc/AzlLVgkDevHY8jv3dfj67bIDoG48MjTclCHbZd9Jk=
=VJm5
-----END PGP SIGNATURE-----

--sPkBZsy7C+1fV4MN--
