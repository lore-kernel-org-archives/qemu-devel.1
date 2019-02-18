Received: from eggs.gnu.org ([209.51.188.92]:56720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gva2I-0001vO-Kf
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gva2H-0007Xb-QA
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 22:56:06 -0500
Date: Mon, 18 Feb 2019 14:24:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190218032444.GB9345@umbus.fritz.box>
References: <20190215133005.15955-1-david@redhat.com>
	<20190215162652-mutt-send-email-mst@kernel.org>
	<1fd9fd75-6bd3-c120-22cf-495c1aab0652@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <1fd9fd75-6bd3-c120-22cf-495c1aab0652@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/6] tests: Add device unplug tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Greg Kurz <groug@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 11:09:32PM +0100, David Hildenbrand wrote:
> On 15.02.19 22:27, Michael S. Tsirkin wrote:
> > On Fri, Feb 15, 2019 at 02:29:59PM +0100, David Hildenbrand wrote:
> >> This is a set of tests to test basic device unplugging functionality f=
or
> >> - some PCI implementations
> >> - CCW devices on s390x
> >> - spapr memory and cpu core devices
> >>
> >> I plaed with ACPI CPU unplug but getting that to run with qtest is more
> >> involved. (remove devices on reset, trick cpu-hotplug-legacy property,
> >> somehow create cpu hotplug state objects ...). Well we no have at least
> >> one unplug test for DIMMs and one for CPUs.
> >>
> >> @David, I dropped you t-b and r-b due to many changes but would be hap=
py
> >> to readd them ;)
> >=20
> >=20
> > Series:
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >=20
> >=20
> > I think it's mostly spapr things so feel free to merge through
> > that tree.
>=20
> Thanks, I'll address the minor review comments next week and most
> probably resend on Monday. I also agree that spapr would be a good fit.

Ah, ok.  I can do that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxqJXsACgkQbDjKyiDZ
s5KL+BAArIJTnT6BnhglJD+PBEUGcdnRjQzRCaHd9tUE8kSIkMfKpd8mKc/+nJdf
LZuqknISfQ35q3CNNDLgKEPMWCR3DFKBFQOAaF/BRF2ti1ths0FjoIuC6TBSQ8Pv
T7TB9l/kQcVFr1CglMx32dLCR8BusVn1kNep2eEYJ0KItZJOKF3JOsY+rLbdCsOX
M79Zz878hx1IOPyo8M2dZLRetPGWDIKoWlkxNk01mzV6vAq/aGzjBRmdwYf7cYMf
9kwy+MJksc4kcCuhYoKPbwqoCHFd9/2bVexDtWUpJCEQZRfp+D1hjFVVfPfS5j5V
Gi2n/jEUlMcHIFplXw0ffN2xa/gbwfPJAVN48oKiqnGmAKF8udvulFmP9HfujhcQ
oW/nnA7JoOa+bMZVSYVo9Ho/LtA8pn7uWZtHRACF7eGfnbK3WWtZ7CssxbjX12B/
fpyAzdrGpGnEHMdJLiWnmMNS32ofdD0AL2e6FR+AncvjsSB/LJWFSxCDieXv5vn5
4XI2plchfHebz1sUjv4x5FuBgH9W0WmjtGuSAG6VgB+IrP2IXsNioV8ZIVqL//5r
O6RIZYodqlTxuQ1KNZax4ag7PkbpuhWh6+xjWD3qruIQE7M9dUTizHQWzp8CiDta
THVhpV7vo3hP+lyWY6Z26aPnJU5P+Gyqb80VU4HHN1Clp46eL34=
=08OX
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
