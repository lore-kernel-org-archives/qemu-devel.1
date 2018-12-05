Received: from eggs.gnu.org ([2001:4830:134:3::10]:40859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMAo-0001y9-8u
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gUMAi-0007xy-0X
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:40:19 -0500
Received: from ozlabs.org ([203.11.71.1]:51635)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1gUMAd-0007mT-Tz
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 20:40:14 -0500
Date: Wed, 5 Dec 2018 12:37:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181205013700.GA28910@umbus.fritz.box>
References: <154385426086.17724.4390242199797858265.stgit@gimli.home>
	<154385451622.17724.12272989665681200621.stgit@gimli.home>
	<20181204182748.GE18284@habkost.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20181204182748.GE18284@habkost.net>
Subject: Re: [Qemu-devel] [for-4.0 PATCH v2 8/9] q35/440fx/arm/spapr: Add
 QEMU 4.0 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 04:27:48PM -0200, Eduardo Habkost wrote:
> On Mon, Dec 03, 2018 at 09:28:36AM -0700, Alex Williamson wrote:
> > Including all machine types that might have a pcie-root-port.
> >=20
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> [...]
> > +static void virt_3_1_instance_init(Object *obj)
> > +{
> > +    virt_4_0_instance_init(obj);
> > +}
> [...]
> > +/*
> > + * pseries-4.0
> > + */
> > +static void spapr_machine_4_0_instance_options(MachineState *machine)
> > +{
> > +}
>=20
> Not something specific about patch, but:
>=20
> Why exactly virt and pseries machines need separate instance
> initialization functions?

So looking through, it appears to have been used exactly twice.

1) For pseries-2.7 and earlier we turn off
   spapr->use_hotplug_event_source

That's setting the initial value of a feature flag that can later be
overridden by a property.  I can't actually see any good reason we
want the property, but I guess it's there now.  Regardless it should
be pretty easy to fix - just initialize the state value from one in
the class.

2) For pseries-2.2 and earlier we turn on machine->suppress_vmdesc.

I don't really know what suppress_vmdesc is about.  Again it appears
to be adjustable with a property, which is why it's in MachineState
rather than MachineClass.  It could be fixed as (1), but that's
generic code rather than in my bailiwick.

Note that x86 also appears to set this on the instance for pc-2.2 and
earlier.

> I'd like to eventually make all machine-type-version-specific
> behavior instrospectable, so it needs to be available at
> class_init time.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwHK7cACgkQbDjKyiDZ
s5LZchAA4CQqMuyM6NEzk5SQH8Npf2kGO8U70dc/8BUOujtWoE5zfAeOeK4HCxIZ
htoRQeloD+XY3F17Lx7u06ESAo+VqPXF5ZxQqQDashjB0IzUUTPZxjRx+9AxsKId
+9x6/VjVnpcrxEvFVLfBRz3kqxKWTgAiouyy666h46lInFmyheKZQgAo9gUdVVbt
WqH2M9+Q3dM3p7qhjH79pRaq+mraZ4rQhkuHRo508isG/ibRk8FopGG1xo5kS+7T
WUdFHScLRM1nnSfIZCYuAZvHbNh/5LjdZWZ23w8Ip2+bZKC7rzUCq6nodWupxgWn
2UNhEiv7lQLF5csAGaAqJKw+dUrgOetJugbcLz22jqslbTPrDE99sUg2vd1KSP+r
JmmdRAyquJS2qhni1pm/7tsHZxm7dTZmb7OIF3/MQ23lxsocP4CCq9qMUuHs49FY
kEpGKJDWHsW7UBfIn1aE4i9iEq6xS76mKL7gvTm5y0qkK52DTtOaXYx7UywdlyuY
tJFca9CGEccJtSpr7kFnEC6yUVFeyWUGwY39sltEvmAq5ZvnNKu9/yquQyq6TCND
zYYecNsD8Qv9l/OrwpZB9ovWc24BtpRw5Ed1pNiL69OZoVQP4SMOGLm/8xih7/r7
kAiBPtqi+w7EfZ4WNKgAy4ljzC6ob+hzSPFA96GRfUr4uqMx2r4=
=GS0r
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
