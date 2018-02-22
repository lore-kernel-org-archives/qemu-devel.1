Received: from eggs.gnu.org ([2001:4830:134:3::10]:57289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1eokf1-00053r-TX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:47:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhenyuw@linux.intel.com>) id 1eokex-00011d-Fn
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:47:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:14430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhenyuw@linux.intel.com>)
	id 1eokew-0000o0-NF
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 01:47:15 -0500
Date: Thu, 22 Feb 2018 14:40:03 +0800
From: Zhenyu Wang <zhenyuw@linux.intel.com>
Message-ID: <20180222064003.yzrcmh7hi6qvgcij@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219151649.13a197f9@w520.home>
	<20180220102814.rtcvsrsdtdndcfez@sirius.home.kraxel.org>
	<20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4uudmaxut5sqcxbt"
Content-Disposition: inline
In-Reply-To: <20180220170417.p7hkqbong5euul7p@sirius.home.kraxel.org>
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


--4uudmaxut5sqcxbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2018.02.20 18:04:17 +0100, Gerd Hoffmann wrote:
>   Hi,
>=20
> > Sneak preview at https://www.kraxel.org/cgit/qemu/log/?h=3Dwork/intel-v=
gpu
> > Note: branch is a moving target ;)
> >=20
> > State:
> >   spice: Partly working (no mouse ptr yet).
>=20
> Working now, in case anyone wants play.
>=20
> Must turn on opengl and use a unix socket, i.e. this:
>=20
>   qemu -spice disable-ticketing,gl=3Don,unix,addr=3D/tmp/spice-vgpu
>=20
> and this:
>=20
>   remote-viewer spice+unix:////tmp/spice-vgpu
>=20
> Host needs a 4.16-rc kernel.
>=20
> Guest can be older, most of the time I'm testing with the Fedora 27 live
> iso (4.13) which works ok.
>=20

Nice! Seems to be the last missing gap for local spice with cursor
dmabuf support, we'll do more testing on that for sure. Btw, another
method might be to add direct cursor dmabuf passing for spice as gl
output, is that correct way?

And really like to see dmabuf support could be in upstream soon. Do
you have any predict for which qemu version?

Thanks!

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--4uudmaxut5sqcxbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCWo5lwwAKCRCxBBozTXgY
J4qwAJ41alj0iAyuzk+xiILnF4TscX3IHwCfTCcoQ/uW5OJuX3dysZnQLliABQ8=
=EUW2
-----END PGP SIGNATURE-----

--4uudmaxut5sqcxbt--
