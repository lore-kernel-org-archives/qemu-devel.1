Received: from eggs.gnu.org ([2001:4830:134:3::10]:53033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbM-0007j2-Ax
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dJHbJ-00061A-8u
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 06:57:12 -0400
Date: Fri, 9 Jun 2017 20:49:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170609104910.GM26521@umbus.fritz.box>
References: <20170530160445.12810-1-lvivier@redhat.com>
	<20170531043557.GI12163@umbus.fritz.box>
	<149695205346.23353.3484869110998357783@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pFpMklMRdxwSC3Yi"
Content-Disposition: inline
In-Reply-To: <149695205346.23353.3484869110998357783@loki>
Subject: Re: [Qemu-devel] [PATCH] spapr: manage hotplugged devices while the
 VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--pFpMklMRdxwSC3Yi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2017 at 03:00:53PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-05-30 23:35:57)
> > On Tue, May 30, 2017 at 06:04:45PM +0200, Laurent Vivier wrote:
> > > For QEMU, a hotlugged device is a device added using the HMP/QMP
> > > interface.
> > > For SPAPR, a hotplugged device is a device added while the
> > > machine is running. In this case QEMU doesn't update internal
> > > state but relies on the OS for this part
> > >=20
> > > In the case of migration, when we (libvirt) hotplug a device
> > > on the source guest, we (libvirt) generally hotplug the same
> > > device on the destination guest. But in this case, the machine
> > > is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
> > > the OS will manage it as an hotplugged device as it will
> > > be "imported" by the migration.
> > >=20
> > > This patch changes the meaning of "hotplugged" in spapr.c
> > > to manage a QEMU hotplugged device like a "coldplugged" one
> > > when the machine is awaiting an incoming migration.
> > >=20
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> >=20
> > So, I think this is a reasonable concept, at least in terms of
> > cleanliness and not doing unnecessary work.  However, if it's fixing
> > bugs, I suspect that means we still have problems elsewhere.
>=20
> I was hoping a lot of these issues would go away once we default
> the initial/reset DRC states to "coldplugged". I think your pending
> patch:
>=20
>   "spapr: Make DRC reset force DRC into known state"
>=20
> But I didn't consider the fact that libvirt will be issuing these
> hotplugs *after* reset, so those states would indeed need to
> be fixed up again to reflect boot-time,attached as opposed to
> boot-time,unattached before starting the target.

So, something I haven't written yet, but I'm considering for my DRC
cleanup series is to force a reset of the DRC objects (and just the
DRC objects) at CAS time.  Since that's when the guest gets the final
version of the device tree, that should ensure that the DRC state is
in sync with whether the guest sees the device as hotplugged or
coldplugged.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pFpMklMRdxwSC3Yi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOn0jAAoJEGw4ysog2bOS6pcP/05xkHXIvbmm116r3+EQHLi9
ZDJa0BGGMLAe78eZ50av9Lvl9DICKEMljaGc248XYz8++Ynhy/Yo8RtXSrX3tfKJ
Ctn8AmY2QZcjyqkMDE1CUzclLCeKdojkLz+jI4LwrkcHRYF/SH5cMkg3hHEcyBo6
DXcJVw0ZLvPUIy6P/dh2AAJRlco1XkXk6tUaj5fuZ8jORS/bp5zC7LaKFo305c5e
JEMQmVkFtNuOATMf8JGVUQsYeJ0EfIpUtJvxNiWh5ra0b0Ok5IuCui5NBwqMLE5+
UPpz8KIvs4TkezgSVPK5GxUi0enijoHzizkdFxSc/tzee1+OcjQCA0ueDh0+OPx5
sn+60XYx7WINH5x46HCEnwQs34JpGCoyzWq7nYL8ype2deWZDkjkcAXjcc/c5DcP
i6IyVUpZyIbTrgxGecIUzkQ/Bm+9+rMX2pBIcN/CdskyRXNozhmSpIh69ceBHs4L
GpTCl8WwL+rSVOymJNtR3kT3pliYQ/NRixeUbzxWhplOcFgISmdYy95XLClPN35/
/JYb1GTI+UDpfg5LQ9LoKUoVbi3kukoVSQ+EqRKLVlTtKz0LrLvqQqcAqV4mV/xh
NCDvtkRikqTsz2vcs1aR4YooU2kuWljTYsWy1b2O1wLswnKBlo7MCxvesRCrRPAa
dNqToW3DtEw/MXmcaaUS
=c0xp
-----END PGP SIGNATURE-----

--pFpMklMRdxwSC3Yi--
