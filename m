Received: from eggs.gnu.org ([2001:4830:134:3::10]:59867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciAO0-0004Ro-DI
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ciANx-0004wt-A7
	for qemu-devel@nongnu.org; Sun, 26 Feb 2017 20:46:00 -0500
Date: Mon, 27 Feb 2017 12:39:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170227013949.GO17615@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
	<20170223225358.GD17615@umbus.fritz.box>
	<CALAZu3_3TkjFbLUAraQRgG5Ytm0a08QLzQSdYLKF5EYPD-imxA@mail.gmail.com>
	<20170224045026.GV17615@umbus.fritz.box>
	<e589819d-ab5e-3c45-0ed8-5783e23ea5d9@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dLxyWiplEfGRIOx4"
Content-Disposition: inline
In-Reply-To: <e589819d-ab5e-3c45-0ed8-5783e23ea5d9@twiddle.net>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 03/10] target/ppc: support
 for 32-bit carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nikunj Dadhania <nikunj.dadhania@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--dLxyWiplEfGRIOx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 05:30:23PM +1100, Richard Henderson wrote:
> On 02/24/2017 03:50 PM, David Gibson wrote:
> > Although I guess they'd shrink right down again if we put an
> > env->xer_mask in.  Thoughts on that option Richard?
>=20
> Why would xer_mask shrink the code?  I can't see that we'd be able to
> eliminate any code using the mask.

Uh.. I think I was thinking about the qemu code, not the generated
code.  It means we could unconditionally and with the xer_mask in some
places, rather than having fiddly conditionals.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dLxyWiplEfGRIOx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYs4NiAAoJEGw4ysog2bOSLocQAI/5cQaC9I+23N+h5V6JI3ed
aL57tw/0BBxwYjgGGe9E6m5wLfwxIpez2MheKnLMoI98vx1VWI7/N8rvKUlw3ARc
KHNHfHwhG89kRCBLGrYNvEHbFq23688NpHdBQZggfsKNGenrBMieDoh0dWCub+rM
pjTg1VsX1hVjcV3PuWhbvzCTY5nq2SseFjKv1f4LEzXmQZO6sSZy0CBuC3gjZTJ6
LIpt+HlkWEy9kFapBl4Q5FwJe02oByCpkXiVJCz3fpGqObx6wb6iThzAzORKNuty
wiw6C+/KFOORVhCS96pFKe1jvZPr8weN24z1ADk+zThXrE64Nh4mCq4IffKVYiC2
0CDgPRQVlwZsXGCcSUmau1Sy3r6d7PD9DwCbhHly345MxyOHfpdNz1Le8Oq91UjI
gzUxhZwoxmyddvyxgwHKgEbp5pRWvzMefTn6aBGwN4YH2fXVtXjvb2fcVzf1Bop1
KVPuChzbBUhDjYrulIfwFmDxKwI0ZWRZHUnikO7r8XL5bFGgkEATKLH1ZLe80KUB
wrMTfsUaUwbYvjbLdbO8VSr+OTqfiAnoX7bpCP2abJpWPJ1dxKw+QUVHUDRkt8cJ
n2H3W4qyyDUmFcn+ZrNubQfMv1dO/I0BddEm7eXyGdFZYethe9EicRmm7fJ0AXAp
LIe0yZzaFq3neyPlOIM1
=YqVo
-----END PGP SIGNATURE-----

--dLxyWiplEfGRIOx4--
