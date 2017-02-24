Received: from eggs.gnu.org ([2001:4830:134:3::10]:37330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6Ah-0004I4-GP
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:03:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ch6Ad-00023X-HN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 22:03:51 -0500
Date: Fri, 24 Feb 2017 13:58:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170224025841.GN17615@umbus.fritz.box>
References: <1487879800-12352-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487879800-12352-7-git-send-email-nikunj@linux.vnet.ibm.com>
	<755c77c5-0930-b5ee-0b3b-1e0608301c8d@twiddle.net>
	<87a89cza5l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QQNwO3VdVfodZayb"
Content-Disposition: inline
In-Reply-To: <87a89cza5l.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [PATCH v4 06/15] target/ppc: remove xer split-out
 flags(so, ov, ca)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--QQNwO3VdVfodZayb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 06:18:22AM +0530, Nikunj A Dadhania wrote:
> Richard Henderson <rth@twiddle.net> writes:
>=20
> > On 02/24/2017 06:56 AM, Nikunj A Dadhania wrote:
> >> Now get rid all the split out variables so, ca, ov. After this patch,
> >> all the bits are stored in CPUPPCState::xer at appropriate places.
> >>
> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> ---
> >>  target/ppc/cpu.c        |   8 +---
> >>  target/ppc/cpu.h        |  26 ++++++------
> >>  target/ppc/int_helper.c |  12 +++---
> >>  target/ppc/translate.c  | 106 +++++++++++++++++++++++++--------------=
---------
> >>  4 files changed, 78 insertions(+), 74 deletions(-)
> >
> > I do not think this is a good direction to take this.
>=20
> Hmm, any particular reason?

Right, I suggested this, but based only a suspicion that the split
variables weren't worth the complexity.  I'm happy to be corrected by
someone with better knowledge of TCG, but it'd be nice to know why.

> I can send back the v3 with suggested changes dropping the xer split out
> changes.
>=20
> Regards
> Nikunj
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QQNwO3VdVfodZayb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYr6FhAAoJEGw4ysog2bOSXh0P/2mwJkWcSXO0FwrDBiikKo10
UuVO422Wb9zpA+Jd/HnkpBYzMMFc0lGxFcrr5VpnXhqkBCiyGMy6VNx66KP/JcIO
UA7CBibwDDcpNiUWNoPEZUBGVGUxWLwNxUltTV0vkbc+NopHI0f4OHG/Zz/WhQXb
B2Q+b6bfr5w+q6W5kFZbSMp9yBKcK+81W2slLRhMoCUCLWbWBp4c4PjiOGv91wob
pzWXZFL+Yh2tb5reMrVOIwEbClwmvNg79LUnT9q3UneP2IqPTXviTXqCuIRuHYwk
yFQTtoFo2PJpjBYYogGLSUSZznb0L7TbEzhQ/RSrMY0fd6mUfOgCt4qITPo3A7go
OKfv7EcOLYwhA1bVq+uJqHWAcuNvVKfha0zFa0GnhZb4vjA2YV5Hasza3Aiejk0b
iyeFSci8GxYMcwK17ufmJ9rWIDVARXEvshDDXiH0u6jSp8EStvE9v/xkAFD7pbdG
Xp42cn1XiaDuzIjdytv5ZBrOuu4sCeV5XOx83B8L/nH/cwctcKCSCtL7DJqsdmEb
ajqLpQkReVLC1JXaYd3JJlGBMN3BOWEISBqmP2r4RnCpfXRt6XoYSQDSVN82K7iY
IbKjAUjMBtooaHcPzytp0nhnvc2Jnl4987rnRThzASXL0rmqp/M9DOSgbwl+Zj9r
hnMhsfA/JSWkXsf9rDve
=5A+H
-----END PGP SIGNATURE-----

--QQNwO3VdVfodZayb--
