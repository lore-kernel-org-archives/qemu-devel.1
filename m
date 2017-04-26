Received: from eggs.gnu.org ([2001:4830:134:3::10]:41921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddx-0007ve-LK
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d3Ddu-0000FY-GB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:29:29 -0400
Date: Wed, 26 Apr 2017 12:51:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170426025134.GM16882@umbus.fritz.box>
References: <201704212158.v3LLwNYl031738@linux03a.ddci.com>
	<20170423231722.GA14558@umbus.fritz.box>
	<OF7D33B8CD.4B2CD628-ON8625810C.00022270-8625810C.000378AB@ddci.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="00sTfE/IIAT5d2r5"
Content-Disposition: inline
In-Reply-To: <OF7D33B8CD.4B2CD628-ON8625810C.00022270-8625810C.000378AB@ddci.com>
Subject: Re: [Qemu-devel] Subject: [PATCH] target-ppc: Add global timer
 group A to open-pic.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alarson@ddci.com
Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--00sTfE/IIAT5d2r5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 23, 2017 at 07:37:55PM -0500, alarson@ddci.com wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote on 04/23/2017 06:17:22=
=20
> PM:
>=20
> > From: David Gibson <david@gibson.dropbear.id.au>
> > To: Aaron Larson <alarson@ddci.com>
> > Cc: agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
> > Date: 04/23/2017 06:54 PM
> > Subject: Re: Subject: [PATCH] target-ppc: Add global timer group A to=
=20
> open-pic.
> >=20
> > On Fri, Apr 21, 2017 at 02:58:23PM -0700, Aaron Larson wrote:
> > > Add global timer group A to open-pic.  This patch is still somewhat
> > > dubious because I'm not sure how to determine what QEMU wants for the
> > > timer frequency.  Suggestions solicited.
> >=20
> > This commit message really needs some more context.  What's a "global
> > time group A" a and why do we want it?
>=20
> The open-pic spec includes two sets/groups of timers, groups A and B,
> 4 timers in each group.  Previously in QEMU the timer group A
> registers were implemented but they did not "count" or generate any
> interrupts.  The patch makes the timers to do both (count and generate
> interrupts).

Ok, sounds good, but this is exactly the sort of thing that needs to
go in the commit message.

> About a year ago I mentioned that we had implemented this and offered
> to submit a patch, which seemed to be acceptable.  Sadly, when I
> reviewed the implementation it had several egregious errors that I
> didn't know how to fix until recently.

Ok.  Now that you mention that, it rings a vague bell.

> Quite frankly I didn't expect the patch to be accepted in its current
> form for the reason mentioned in the above commit log and was hoping
> for some guidance.  If this is no longer a desirable patch, I can
> certainly continue to maintain it locally for our use.

That's fine - but I need context of what the patch is attempting to
do, and why that's desirable in order to properly review it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--00sTfE/IIAT5d2r5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAAs2AAoJEGw4ysog2bOSHYoP/iboJjzupEAc93kdfBvX/Cpv
erQ/dvKOd76V7RGgNP/vk09xCllRAx3JJD8PwQYB27urb790ulAsmcniN5aXNIA0
TiUHPBn8ryGHcrNS2dKE/GDpe+kJLyU0vGz35xrEBfuTCp4TE6SdmRXpGdhmzdc/
Ukd784sgGYiKP5QOxHO1Z5+mNe48wFlRv2GlXlHXJvrr0Uagsi9XSVSsmKzeQKvE
uvyHZxGY9cc7zxQ2lSXnpHu6EG03mvSIOa/yiV5TnkoEXvfUCL5gxOhrYHnGIBsx
WsAsP+bMq9HfABXSHekbxasW18JOzrBnVA7yZ3QMYsDr0hS3TWWyZ9vakfIDHivK
NIM8Wt0TRHrGUF7/Pg9nKkypa+1lIbdSbz26hkyMCBBTSc/uHx7GF5Z2b9VrY+u6
LuK9RXbJS6oJ5p6vl/stSxGdGoqctLxTx6eiB6Ik3jRItJugQP04VWUwRCSueU4J
4FWMMPCbFte3brdJLABnRhjYxY4vTAInDPYnbbw7whf82gwCtKRwMQAj+yx3XO+o
gzZv4lDZyDAsemjTYJyc2A1EacNY7zaigvV/OHQFjUcfmKjCMantdSbn9+MWovJm
2O5e7QghPfHzaHSPhLs1IBisWwC5JPUIEK0KPw4mKMSTgfzvJ4rYkT85NM8ebXYI
FRgrJwOfL/jd5JbgdjVe
=Hmkr
-----END PGP SIGNATURE-----

--00sTfE/IIAT5d2r5--
