Received: from eggs.gnu.org ([2001:4830:134:3::10]:56245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHm3V-0006K8-W3
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 01:31:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHm3S-0003zX-Re
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 01:31:46 -0500
Date: Fri, 16 Dec 2016 15:19:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161216041936.GF12146@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
	<20161212003055.GC12127@umbus.fritz.box>
	<CALAZu38RiyxcnV5uXucUcyyV9aeWqXXpEznUF9z2gNrn0Fy4tQ@mail.gmail.com>
	<20161212040733.GB31441@umbus.fritz.box>
	<87d1guc32t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/aVve/J9H4Wl5yVO"
Content-Disposition: inline
In-Reply-To: <87d1guc32t.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/6] target-ppc: implement
 xxextractuw instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: Nikunj Dadhania <nikunj.dadhania@gmail.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>


--/aVve/J9H4Wl5yVO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 14, 2016 at 02:14:26PM +0530, Nikunj A Dadhania wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > [ Unknown signature status ]
> > On Mon, Dec 12, 2016 at 09:31:11AM +0530, Nikunj Dadhania wrote:
> >> On 12 December 2016 at 06:00, David Gibson <david@gibson.dropbear.id.a=
u> wrote:
> >> > On Fri, Dec 09, 2016 at 05:47:24PM +0530, Nikunj A Dadhania wrote:
> >> >> xxextractuw: VSX Vector Extract Unsigned Word
> >> >>
> >> >> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> >> >> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
> >> >> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
> >> >> +        return;                                                 \
> >> >
> >> > So, I know the architecture says it is undefined.  But since you're
> >> > testing for the bogus case anyway, why not turn this into an
> >> > exception. That seems like it would be more helpful for debugging the
> >> > guest than just setting the result to zero.  Or is this done to match
> >> > actual hardware behaviour?
> >>=20
> >> I havent had a change to run on the real hardware, but on the system
> >> simulator, it happily
> >> returns extracted content even if UIMM > 12.
> >
> > Hm.  Returns what exactly?
>=20
> So for LE case extracting from 15 returns following, basically its
> rounding up to 0.

> xxextractuw: 15 - ooTSET a si sihT
>                   ________ihTo____

Ok.  IIRC your implementation did not do this - it set the
"overflowed" bytes to 0 instead of wrapping round and taking them from
the other end of the input.  If think we should either match hardware
behaviour or simply trap here, rather than do something else.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/aVve/J9H4Wl5yVO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYU2tWAAoJEGw4ysog2bOSxEsQAJ3XA9QslIDGLJ8sKW5Zp8zk
XujKzbow02D4j/jgBaE+kIxu/c7uSUAhwoIl2bNMKZiDO1Jdti13OcOo7QkPOOJ1
vczjd+gekSFJSdwdFS26usXbhMiFkk/IuKf+md7SgLmfx5F93XdRH04CInAa86Hc
ec8ZZG6ixaDV0BdHqh4Jpz9Mdkpuxfjb7kkPqKSR2KPH6UAMT66Y7PlaRjvnjvUp
gdAPWCY8tSo6O8z3Kjop2mKo1awE5G/3tgKeEhtAghO9+aLkPl0+PbH6MkfpzqAc
J1Fj0+GpQ6LcAXo5S/s787yGTxsYPHmxGtbyv/eCcXjEN1CIQzthycoMrK6Nq/uz
uixapSmo9acFPYimvaPtxdlXMseDzzzc6YFLtNlhVDRYqLM+P/H3X/5Qjo3dDIHA
LSEWvZaLk7KqG83b/5HPwobggozup500JOuuDdaUtHJJEyVhVUvS5gNO7gJY9upc
d+NWf5WaYwXh+TKDHymJQuuGYHEwClGmISueSBPdoWerwQuQz/jQ61NLKbeP1gGm
WxxemA/o4Ho2rW7Y/ZjKT0AC9xOqbe3ZQf/VC9kdWmRlz80coNKrhWoO96ypSXpI
8xnErs0loTDtqgihsQb2phZiRS7hjqD9Anm0pRjPu/Ey5pjLdlHYOIeXupAqef3+
MJHZGzDPJca/Rufa0lZy
=6+FL
-----END PGP SIGNATURE-----

--/aVve/J9H4Wl5yVO--
