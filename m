Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBE0h-0004HN-Cc
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fBE0g-0004ti-3U
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 02:34:35 -0400
Date: Wed, 25 Apr 2018 16:34:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180425063424.GU19804@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-18-mark.cave-ayland@ilande.co.uk>
	<20180321032924.GP3905@umbus.fritz.box>
	<08c7c486-850c-ce0b-71f8-1cb505028d5c@amsat.org>
	<16bbd1be-1d4a-b158-884b-9cda30502816@ilande.co.uk>
	<a16e6be7-a927-3ede-b5c4-c75d440d3213@ilande.co.uk>
	<a4f18bda-f67c-197c-c7fd-9bfc31c26f36@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6wUvnnXCCq76soZt"
Content-Disposition: inline
In-Reply-To: <a4f18bda-f67c-197c-c7fd-9bfc31c26f36@ilande.co.uk>
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


--6wUvnnXCCq76soZt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 07:06:03AM +0100, Mark Cave-Ayland wrote:
> On 06/04/18 06:33, Mark Cave-Ayland wrote:
>=20
> > On 25/03/18 22:11, Mark Cave-Ayland wrote:
> >=20
> > > Just to follow up on this, I spent a bit looking at what this
> > > register is trying to do and from the Darwin source I can see that
> > > in fact it is simply a hard-wired hardware register which should
> > > return the revision of the UniNorth hardware.
> > >=20
> > > So in fact the code in its current form is completely bogus which is
> > > visible when trying to boot FreeBSD, which as the register is never
> > > written to, returns a completely different random number each time.
> > >=20
> > > David - are you okay to change DEVICE_NATIVE_ENDIAN to
> > > DEVICE_BIG_ENDIAN and then apply this and the final patch to your
> > > for-2.13 queue? I can then follow up with another patch later that
> > > will implement this register (and also the matching PCI revision ID)
> > > correctly.
> >=20
> > Ping? I can see that more patches are being added to the for-2.13 branch
> > so I was just wondering if there is now anything else needed from me in
> > order to get the last 3 patches from this patchset queued?
>=20
> Ping again? The reason for asking is because my next set of Mac branches =
are
> all rebased on this patchset since they rely on this, plus the final two
> patches in this series which remove the need for qdev_connect_gpio_out()
> when wiring up macio devices.

Uh... sorry.  I completely missed this series.  And, apparently, your
earlier ping.  Can you resend, please.  Make sure you explicitly CC
me, I occasionally go through the lists but it's easy for me to miss
stuff there.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6wUvnnXCCq76soZt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrgIXAACgkQbDjKyiDZ
s5LpYg/9Hl7c3y4CwjfzLUauJwvwNJiM2y8HIPkXi6xddyfhuNrs7zmnrFqGFB05
TtKJHv4kS1pCNoNMUsWUE2Zfihq0A9nXcE+MtNsrg+T9rklnK8/LXW/5baS1YeeJ
goapzcYThmao1SrZLo6MfcUpd3VLJBFCJSE79XNKOEK1YPrWx4QehYQclBvsqKxX
K2bDFvW6vfXeKhZolLzeKz9qThakxEmsu8vPOvGCtJe5KGA1boRpV2ZBTtytlf+y
yRXN0+IBZBV07dh41vk/BufoyBG96D46paIpRm1Xg2/LwqzBpn0QXJ2wllGpE4MV
bOF/CVQt1bbnAOm1ls1C4UYQ33pna3ER2eWC15cNpFZqgORflmsSbkUDEV4w3eQR
8i6JkdTVDGgKaqpxyXtH3RQZ/9n8hanL8BTNERtXX323Fv4UQ8RAAe5v+6N95EhU
I7QsCObYDOFSCLaykOsTTNaBz9PFn1H9AqrIkWs1HvU0VAyCABxfsJtnUxj7vnaM
TuYtCMvlanxR1z7IuY9GZwl00L8bivVRZRzRw6JrTdZcZUiXWc3SO5JP9Dp54nS6
UO31hXpWWMabvpjeu7afz9+GQo3oUERbproLn2keR9j8RNoWf68GyUt5UY39cWOh
n6CdLXtBLini6pVi8S2YV++WfAXrdfAjI0pY36Zei42I/KoTwjw=
=Psvj
-----END PGP SIGNATURE-----

--6wUvnnXCCq76soZt--
