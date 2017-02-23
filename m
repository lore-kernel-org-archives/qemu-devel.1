Received: from eggs.gnu.org ([2001:4830:134:3::10]:53581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2ix-0003dd-B7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch2iw-0005t9-1u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 18:22:59 -0500
Date: Fri, 24 Feb 2017 09:53:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223225358.GD17615@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zS7rBR6csb6tI2e1"
Content-Disposition: inline
In-Reply-To: <98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v3 03/10] target/ppc: support for 32-bit
 carry and overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--zS7rBR6csb6tI2e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 09:34:32AM +1100, Richard Henderson wrote:
> On 02/23/2017 05:40 PM, Nikunj A Dadhania wrote:
> > Richard Henderson <rth@twiddle.net> writes:
> > > These functions are becoming quite large.  Are they performance criti=
cal enough
> > > that they need to stay as inline code, or should they be moved to hel=
pers and
> > > share code with cpu_read/write_xer?
> >=20
> > Just to boot to login prompt, these are the numbers for gen_read/write_=
xer:
> >=20
> > helper_myprint - rd_count 231103, wr_count 68897
> >=20
> > And it keeps on incrementing, maybe scope of optimization here.
>=20
> That's not very large considering the total number of instructions execut=
ed
> during a boot to prompt.
>=20
> Thoughts, David?

Hm, I'm not clear if that's the number of executions, or the number of
translations.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zS7rBR6csb6tI2e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr2gGAAoJEGw4ysog2bOSGMcP/3bKI2DEsTKcxBjeu/sLRHav
AVODERBScacq2Gfl6TWU9gX9M5oZFk2npl40uhcqoSTivYyxJQUMY4Vl1BzfrLud
SU7w0tyCGJM/SAekCl9bqN3EIrkpCzl9yC8kdF4rgcPkQRzhb+GTH73fPrCmXr5U
ZznDdbJLhn2HYaXKnocfo667GLaRlErcgrLppywcBdr0GthxLndL416GCEQOei2c
nxBj7rDUKjMhhSL04sP38FMs8U601yi7HoHior+rPgfEUvTZjfTpCJHdVpdQwnqv
j+MOEbe8QtqONyA4fxo4WJWcJAn5aBjDlZFhSGBihhUE387tFjEbNIDL1KJ5XekK
DogT5LJcuQ7EZ9HZyetGVfrhb7amKbeLBbu/r2ZLGdouHR9UuwplRbyovfsYpUR8
wJ0gYodxRbL2Jo2sXNUEsJexdmMeu3UabecfAmevO0XNWYrYsV/HAsYjlHWv2Tjc
R3fsRGEnbGLWUPrQqKUkreL80CgX/nORZUMXfKZ0Crn+iFm/bCxUb4ORy4EuORXX
ejJa9eJvibZRT3DFt/yWg4AXq50ESMHlEWaOp8x7dUAoiL6XgqUindjw5iAX1San
cgyubT7bXeA10GaroNh7qLAKJqVdQYaL0jMH2l1AZwU4ZZgk2FDg25sXymi3knm7
YOjlI6V1yqL1hBHQJmlB
=ZQZ6
-----END PGP SIGNATURE-----

--zS7rBR6csb6tI2e1--
