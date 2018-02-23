Received: from eggs.gnu.org ([2001:4830:134:3::10]:56432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1ep3SY-0005OX-TG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:52:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1ep3R2-00065O-AR
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:51:42 -0500
Received: from mga07.intel.com ([134.134.136.100]:17399)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenyuw@linux.intel.com>)
	id 1ep3R1-00060r-O5
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 21:50:08 -0500
Date: Fri, 23 Feb 2018 10:42:57 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
Message-ID: <20180223024257.vrnsisgmefdyarkc@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
	<20180222064003.yzrcmh7hi6qvgcij@zhen-hp.sh.intel.com>
	<20180222093055.u34o2pp6twcx645f@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwzy5ffhrjjmmsga"
Content-Disposition: inline
In-Reply-To: <20180222093055.u34o2pp6twcx645f@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v4 0/7] vfio: add display support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>, intel-gvt-dev@lists.freedesktop.org, qemu-devel@nongnu.org, Tina Zhang <tina.zhang@intel.com>


--rwzy5ffhrjjmmsga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.02.22 10:30:55 +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > Nice! Seems to be the last missing gap for local spice with cursor
> > dmabuf support, we'll do more testing on that for sure. Btw, another
> > method might be to add direct cursor dmabuf passing for spice as gl
> > output, is that correct way?
>=20
> Passing on the cursor sprite needs the hotspot information, so spice
> client can position the cursor correctly.  I didn't got hotspot
> information in my testing yet, but maybe the guest kernel was too old.
> Is that supported meanwhile?  If so, which kernel version is needed?
>

Current gvt dmabuf doesn't support true hotspot info yet which requires
some pv info update as we can't get it from hw state. Tina is pursuing that.

> Spice already has support for setting pointers, we can simply use
> that, at least initially.  Doesn't use dma-bufs.  If it turns out to be
> a performance issue we can add support for using dma-bufs instead, but
> that needs spice server changes.
>=20
> > And really like to see dmabuf support could be in upstream soon. Do
> > you have any predict for which qemu version?
>=20
> I want have this in 2.12, at least the current, initial version.
> Improved cursor support might take a little longer.
>=20

Good to know. Thanks!

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--rwzy5ffhrjjmmsga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWo9/sQAKCRCxBBozTXgY
J16lAJ0X7Ed6gLdnmFbz7UsEwbXwbEOAMwCfRn/utAz1sPS6pRyt/AQX8qhsFMM=
=QDSg
-----END PGP SIGNATURE-----

--rwzy5ffhrjjmmsga--
