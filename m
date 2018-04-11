Received: from eggs.gnu.org ([2001:4830:134:3::10]:37849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67zE-00073h-Em
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:08:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f67zA-0001Oc-EL
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 01:08:00 -0400
Date: Wed, 11 Apr 2018 15:07:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180411050749.GD2124@umbus.fritz.box>
References: <20180409062538.1095-1-bharata@linux.vnet.ibm.com>
	<20180411044558.GC2124@umbus.fritz.box>
	<20180411050128.GB14855@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <20180411050128.GB14855@in.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH v2] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 10:31:28AM +0530, Bharata B Rao wrote:
> On Wed, Apr 11, 2018 at 02:45:58PM +1000, David Gibson wrote:
> > On Mon, Apr 09, 2018 at 11:55:38AM +0530, Bharata B Rao wrote:
[snip]
> > > @@ -2927,6 +3082,15 @@ static void spapr_instance_init(Object *obj)
> > >                                      " place of standard EPOW events =
when possible"
> > >                                      " (required for memory hot-unplu=
g support)",
> > >                                      NULL);
> > > +    object_property_add_bool(obj, "drmem-v2",
> > > +                             spapr_get_drmem_v2,
> > > +                             spapr_set_drmem_v2,
> > > +                             NULL);
> > > +    object_property_set_description(obj, "ibm-dynamic-memory-v2",
> > > +                                    "Use ibm-dynamic-memory-v2 repre=
sentation"
> > > +                                    " in place of ibm-dynamic-memory=
 when"
> > > +                                    " possible",
> > > +                                    NULL);
> >=20
> > I don't really see any point to making this a user configurable
> > option.  Why not just always enable it if the guest says it can
> > support it.
>=20
> Makes sense. While thinking about it, I wonder why other properties like
> modern-hotplug-events remain user configurable.

So, modern-hotplug-events affects the runtime behaviour of the events
subsystem.  That means we have to keep that behaviour consistent
across migration, which means specifically we have to keep the old
behaviour for older machine types.  Generally the easiest way to do
that is to have a compatiblity property whose defaults get set by the
machine type.

dynamic-memory-v2 doesn't affect runtime behaviour, only how stuff is
advertised in the device tree, so there's no need to maintain the old
behaviour even for old machine types: a guest started on an old
version will still have the v1 info from when it booted, and that info
will still work after migrating to a new qemu.  Likewise a guest
started on a new version will still have the v2 info and that will
still work on the DRC objects if migrated to an old version; if it
reboots then it will get v1 info, which is fine.

So, for this case we don't need the backwards compat property.

> Thanks for the review, will post next version with your suggested changes.
>=20
> Regards,
> Bharata.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrNmCMACgkQbDjKyiDZ
s5KCLA//R6diR/SHLvm8+XZGaMh4LwY3IfKvl5+b0GyDBaq2IvqUL9nWptuYqJwS
blDU1fAGJWyNAgOOCCF9Tv4tpQP3gjBl0QHt2ObJi4V+uV1sgFxKXK6UkklhanVq
y5qlvd65a2Zc1tOp9jb5B85dFXGRFQWbooZQDddBsUaerYGTpzNPexyUQ+OrjsAR
X3qPCIzyQQi+0Anj6pyv7Qu69RLYpns/6xA1db5rY/xk0El/gqrHP4Jr88xIx5EX
SEmCHzSXWeARzMHw9KuTTmxhCaMsLSY/PIX5fgC3loKnei15kRZ6LDMnmen74y6R
cYZNc3F8rrO7e4Zdfa4GzVa52yImoMaDRrDbe+B2pzPR41SKjZLGhmTxEktqe4xC
9+mPTBEvuAjIhytlL3GnBuJYPZHUONUxqPYVbNIrpwEvLBQxwd/Y3xIaVGMwcviM
81bw0zuBpIbU/KH0HMXYvrIXKsayOZdU/MMljVBXLyJlxnmIsugJdHMyovrdNp5v
54k2Brn3mzT/r12JDJucPCFBZNr0W4T3c81XXKDEzmwmukLQrilKK3cICQjRDwio
i00nu5MFyze/pexQUEqUmLAiCjde1n3Pme8ehRsrGMtNKkXscMsgUzHDtepLg+Ss
FMYjauuoHB9oVqsQBKzpATxn2Bs/gr3BNJTPS0M1QaLI7I2hQt0=
=HTJk
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
