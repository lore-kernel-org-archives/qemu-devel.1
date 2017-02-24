Received: from eggs.gnu.org ([2001:4830:134:3::10]:57624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Cm-0006HK-Ul
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch8Cj-0004jD-QG
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 00:14:08 -0500
Date: Fri, 24 Feb 2017 15:50:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224045026.GV17615@umbus.fritz.box>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-4-git-send-email-nikunj@linux.vnet.ibm.com>
	<913ec2bb-2fd4-3488-e142-75d3574dfaf1@twiddle.net>
	<87a89dtnox.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
	<98b51c07-f7b2-ddb3-7b59-336d109d005b@twiddle.net>
	<20170223225358.GD17615@umbus.fritz.box>
	<CALAZu3_3TkjFbLUAraQRgG5Ytm0a08QLzQSdYLKF5EYPD-imxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sr8SBrQ3fbgntwtR"
Content-Disposition: inline
In-Reply-To: <CALAZu3_3TkjFbLUAraQRgG5Ytm0a08QLzQSdYLKF5EYPD-imxA@mail.gmail.com>
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
To: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>


--sr8SBrQ3fbgntwtR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 06:11:30AM +0530, Nikunj Dadhania wrote:
> On 24 February 2017 at 04:23, David Gibson <david@gibson.dropbear.id.au> =
wrote:
> > On Fri, Feb 24, 2017 at 09:34:32AM +1100, Richard Henderson wrote:
> >> On 02/23/2017 05:40 PM, Nikunj A Dadhania wrote:
> >> > Richard Henderson <rth@twiddle.net> writes:
> >> > > These functions are becoming quite large.  Are they performance cr=
itical enough
> >> > > that they need to stay as inline code, or should they be moved to =
helpers and
> >> > > share code with cpu_read/write_xer?
> >> >
> >> > Just to boot to login prompt, these are the numbers for gen_read/wri=
te_xer:
> >> >
> >> > helper_myprint - rd_count 231103, wr_count 68897
> >> >
> >> > And it keeps on incrementing, maybe scope of optimization here.
> >>
> >> That's not very large considering the total number of instructions exe=
cuted
> >> during a boot to prompt.
> >>
> >> Thoughts, David?
> >
> > Hm, I'm not clear if that's the number of executions, or the number of
> > translations.
>=20
> That is number of executions.

Ok, I guess that's not that big, then.  I guess moving them into
helpers would make sense.

Although I guess they'd shrink right down again if we put an
env->xer_mask in.  Thoughts on that option Richard?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sr8SBrQ3fbgntwtR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr7uRAAoJEGw4ysog2bOSkmwP/0XETI7I5t1t3raGTg95FW9C
fFmtVAIlDL1ZeYzBn/W2mAouZ2uPwPrM5eaPxIIfIpJEqXjNr2bvE7pGJyybRvJb
sZhvEGpa9ktZ3w9EusrUyu7SV2sTN1qrBHJrxvQNz1SL50P9P7btXaeBLdlm+ERb
jKpjgnAOtxy8rh/xtkrmGiWkH5M5jdtp+5IDupmmXYoWP0KzV0Zw40TsCRCSaqIk
T68tD1j+GIvEZnESVMfhxKqubfr7LaMnyJPENNV6CufTtRm23DpF3F+xNvn4wU03
pOSh/UVRPq0e8vtGeMKQWcFWCrIPhFPqzMXBf5Bo5gRylz6am1GxOErnKvILIb79
WF5nGWKiIVj8xH5/JjquI9WSWZbNs6OJy7Oafibu5pchS5wWfj9lwm/bKfokWQh/
GGgZHWAixzTFe0LLVjx0BjSJVN2w0uf1Kl4jp8rBKdmramfOrsYZnGP/dUe7f/oV
CrL3+eKNWcWEGCYEF6OI0kvHxrZbKLZZl1XC0CO8NjmyqG+lMjDVSdhH1uSFiGjc
U0uTJ6L+SBpR1/XaNII6kEpZPVFwTR8BAY+cHTsg4JfL+olSi57jBtmAdLBlKz9M
KLpj6l/Ndv1xxNHVA2T+xkubPogk9mclX5pkp9aOOLkMNcCl0LY6OLGdZRmk36xY
Fw5BAk4pmzxhbIEi+tmh
=PQBX
-----END PGP SIGNATURE-----

--sr8SBrQ3fbgntwtR--
