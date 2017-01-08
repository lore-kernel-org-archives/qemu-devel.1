Received: from eggs.gnu.org ([2001:4830:134:3::10]:32858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyt-0002qw-FK
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cQOyp-0000pu-HL
	for qemu-devel@nongnu.org; Sun, 08 Jan 2017 20:42:39 -0500
Date: Mon, 9 Jan 2017 10:48:24 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170108234824.GC12515@umbus.fritz.box>
References: <20170106050451.11793-1-david@gibson.dropbear.id.au>
	<53dcb2da-fa15-63b0-5849-325b6edcac83@redhat.com>
	<20170106214052-mutt-send-email-mst@kernel.org>
	<9cc108a2-4e56-e5ed-9ba4-4e0e0faac072@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <9cc108a2-4e56-e5ed-9ba4-4e0e0faac072@redhat.com>
Subject: Re: [Qemu-devel] [RFC] pxb: Restrict to x86
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, ehabkost@redhat.com, thuth@redhat.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 08, 2017 at 10:17:12AM +0200, Marcel Apfelbaum wrote:
> On 01/06/2017 09:41 PM, Michael S. Tsirkin wrote:
> > On Fri, Jan 06, 2017 at 08:13:11AM +0200, Marcel Apfelbaum wrote:
> > > On 01/06/2017 07:04 AM, David Gibson wrote:
> > > > The PCI Expander Bridge (PXB) device is essentially a hack to allow
> > > > different PCIe devices to be assigned to different NUMA nodes on x8=
6.  Each
> > > > PXB is sort-of a separate PCI host bridge, except that its config s=
pace
> > > > is shared with the config space of the main PCI host bridge, rather=
 than
> > > > being independent.
> > > >=20
> > >=20
> > > Hi David,
> > >=20
> > > > This is only necessary if the platform doesn't (easily) allow truly
> > > > independent PCI host bridges.  AFAIK that's just x86.
> > > >=20
> > >=20
> > > Indeed, it is possible to support independent PCI host bridges on x86=
 by
> > > using a separate MMCONFIG space for each one and enable separate PCI =
domains.
> > > We simply didn't need this until now, but maybe will be implemented i=
t in the future.
> >=20
> > In fact I would say that's the cleanest way to do this on q35.
>=20
> Message received :)

Just so I'm clear, these last two comments are essentially suggesting
a follow up cleanup on x86, rather than suggesting a different
approach for non-PC platforms, yes?

If there are no objections to my original patch do you want to take it
through your tree Michael, or should I take it through mine?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcs/HAAoJEGw4ysog2bOSiFQP/RJ83WAqWM2yU1f+r9UzLGse
O/QvnbIryQyjyYx5QlUSz4zxi6sTOJ564GNKZYRlV2VVYZQ5vpq6pWuTSU1AtmcB
tah5LoSIuFmmTpiNClGRedk7x9HgKV/fcY6Zw++XtKJaoITfjfZTO8KJ+NoXSzVX
EpadjyKzCZPiAAYp6/3BYX2ndiNKTaBcB6erNknR2w595H1VfFJFholyfAlO6XeX
Wi1vdR1YKa8kVwPnCRnGrw2XVB/8Xe1JK1/H7n9JBNDifdI4f/Dw5RmFJIBTr7l3
rilEBMRdhtHUubdQoNWUHXDS9DEfPNVbTt0hTyBW9e9XDYlo4RWqPNaAWinQId5f
DjUtbfSipZjbr5id486xllWj/zqPmmpDLJFNrDybODIaRk3mGO4n+PUXHquHcqEo
nqk6bOdPSvVY6eeRzKVKY5C43s9DXNZRiy0hj/xwgnUf7w4p436jhTvZ4gt8oPZm
ddGd/eVTuEWaCOoVO5VD+AUodDNi7mpzTMT0r3l8npCiEN/zpFEKVrM9EXJbV8XA
dJysLA/BXtczKds6ImdiUgbDfareZ5ZwWY5DHnxbS86bTBeyhTu4MEhayy0vq5ua
gfvRP2c3fZIYEyLU4kF1zJIKhHRt32XuRg+ehr52jNqoxnzr4KtlNytv29VJKlFV
xiYMSYRHQAvbs7fe6iPk
=PnfC
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
