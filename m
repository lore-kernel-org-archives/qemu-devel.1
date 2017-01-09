Received: from eggs.gnu.org ([2001:4830:134:3::10]:54098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQQkJ-0008Vf-VS
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQQkI-00082y-GR
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 22:35:43 -0500
Date: Mon, 9 Jan 2017 13:54:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170109025414.GG12515@umbus.fritz.box>
References: <20170106050451.11793-1-david@gibson.dropbear.id.au>
	<53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
	<20170106214052-mutt-send-email-mst@kernel.org>
	<9cc108a2-4e56-e5ed-9ba4-4e0e0faac072@redhat.com>
	<20170108234824.GC12515@umbus.fritz.box>
	<20170109035746-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <20170109035746-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [RFC] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, ehabkost@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2017 at 03:58:03AM +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 09, 2017 at 10:48:24AM +1100, David Gibson wrote:
> > On Sun, Jan 08, 2017 at 10:17:12AM +0200, Marcel Apfelbaum wrote:
> > > On 01/06/2017 09:41 PM, Michael S. Tsirkin wrote:
> > > > On Fri, Jan 06, 2017 at 08:13:11AM +0200, Marcel Apfelbaum wrote:
> > > > > On 01/06/2017 07:04 AM, David Gibson wrote:
> > > > > > The PCI Expander Bridge (PXB) device is essentially a hack to a=
llow
> > > > > > different PCIe devices to be assigned to different NUMA nodes o=
n x86.  Each
> > > > > > PXB is sort-of a separate PCI host bridge, except that its conf=
ig space
> > > > > > is shared with the config space of the main PCI host bridge, ra=
ther than
> > > > > > being independent.
> > > > > >=20
> > > > >=20
> > > > > Hi David,
> > > > >=20
> > > > > > This is only necessary if the platform doesn't (easily) allow t=
ruly
> > > > > > independent PCI host bridges.  AFAIK that's just x86.
> > > > > >=20
> > > > >=20
> > > > > Indeed, it is possible to support independent PCI host bridges on=
 x86 by
> > > > > using a separate MMCONFIG space for each one and enable separate =
PCI domains.
> > > > > We simply didn't need this until now, but maybe will be implement=
ed it in the future.
> > > >=20
> > > > In fact I would say that's the cleanest way to do this on q35.
> > >=20
> > > Message received :)
> >=20
> > Just so I'm clear, these last two comments are essentially suggesting
> > a follow up cleanup on x86, rather than suggesting a different
> > approach for non-PC platforms, yes?
> >=20
> > If there are no objections to my original patch do you want to take it
> > through your tree Michael, or should I take it through mine?
> >=20
>=20
>=20
>=20
> Go ahead and take it through  yours pls.
>=20
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Done, thanks.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcvtWAAoJEGw4ysog2bOSbRgQAMZwRDklXDxBO3gGwRsezTX/
gsk5wXkGmXTMRClgeo7jNjBYzASLmKk+B1KcZIyyVck8z1rrqPZq362GfXa3Qvkd
RjNVKoxgSFwYA07g4kWI5yQ8YzXR1H59UR0Z2sE6cdx/x1m5XgeERyIAWeJFgQzT
7K+ddP4tlCDLSEFXWcL1NTcRcVrDNqbrvBrOY6UCks126VxfYZWJ4ykOvpiERb9O
EWTRjugpWRZbHXZj1MQejWKm5n5dK8C7z6MRmsl517aDN+lJItkPKncjh062J36S
7xKcdCY2h7GG0obyszug5sXJNccsVs9GjDvTAZZN8DfEoIissfJ4gjOjBRbNjrBO
QzFzR10Al0y99aY/F6HMAMhmWQJtDMOEsaDpneLtruwlspd6CVwZU3lsbDHTsqXE
Kr4Q4oUpVxDZR5I4R+ltWMXkGaYVZ8znJocYhWAXPy/dXtDMn/K99Fw9CIMXqnco
JTADxQWjQUSEH9E5eiYsLw8sUQBZbR9Qc2GzQ+iCmLj1C4JDUxUfOYnZrFJWP1Sz
eeql5REMj+nuXSeGPyfNav2viPOtIcDYQNlqKkV1BdPOgXTYlCDOaTIE/1pvq6ai
tgdpV2D1Req+dwsnx6cZEv/GcTFv1xM/Psn5/FcsCAoBtTr+JElfErpX+eA+hXBf
5QYUk7UJ9IzEhDgCAQyw
=XN2t
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
