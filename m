Received: from eggs.gnu.org ([209.51.188.92]:55313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz38p-0005Au-GY
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:37:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gz38n-00061M-51
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 12:37:11 -0500
Date: Wed, 27 Feb 2019 17:36:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190227173634.GG927@stefanha-x1.localdomain>
References: <20190226153549.17867-1-stefanha@redhat.com>
	<8a8d76d1-1280-f3d9-3d72-1c662d1ad666@redhat.com>
	<20190227153311.GH22539@stefanha-x1.localdomain>
	<20190227155627.GN31688@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <20190227155627.GN31688@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] file-posix: add drop-cache=on|off option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Neil Skrypuch <neil@tembosocial.com>


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27, 2019 at 03:56:27PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Feb 27, 2019 at 03:33:11PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Feb 26, 2019 at 10:54:55AM -0600, Eric Blake wrote:
> > > On 2/26/19 9:35 AM, Stefan Hajnoczi wrote:
> > > > Commit dd577a26ff03b6829721b1ffbbf9e7c411b72378 ("block/file-posix:
> > > > implement bdrv_co_invalidate_cache() on Linux") introduced page cac=
he
> > > > invalidation so that cache.direct=3Doff live migration is safe on L=
inux.
> > > >=20
> > > > The invalidation takes a significant amount of time when the file is
> > > > large and present in the page cache.  Normally this is not the case=
 for
> > > > cross-host live migration but it can happen when migrating between =
QEMU
> > > > processes on the same host.
> > > >=20
> > > > On same-host migration we don't need to invalidate pages for correc=
tness
> > > > anyway, so an option to skip page cache invalidation is useful.  I
> > > > investigated optimizing invalidation and detecting same-host migrat=
ion,
> > > > but both are hard to achieve so a user-visible option will suffice.
> > > >=20
> > > > As a bonus this option means that the cache invalidation feature wi=
ll
> > > > now be detectable by libvirt via QMP schema introspection.
> > >=20
> > > Do you still want to pursue the QMP query-qemu-features command, or d=
oes
> > > this delay that for another day?
> >=20
> > The presence of this new option doesn't guarantee that dropping caches
> > works.  It is currently only implemented on Linux.
> >=20
> > We still need query-qemu-features so that libvirt can detect whether
> > this QEMU binary can drop caches (e.g. on Linux vs FreeBSD).
>=20
> The commit message said that libvirt would use this new option to
> detect availability of the cache drop feature. That should probably
> be removed from the commit message, as this caveat about non-portable
> impl means libvirt can't actually rely on it.

Okay, will fix.

Stefan

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdsqhAAoJEJykq7OBq3PIk70H/Ao7IP3W5RY7623HsZ8PkqAe
J+BBix4930dcMN5yb/RNhrRLB+RHBfmX+HbF0uqaeSdayY9Wpnwubpat6uRx7nUE
/8pzXeHsOGIJ9nVRP8rWpHyqilWetvgTcoRP/IFJfJBc8CaA6hW3dfIt0JP04oez
0OweR/eFn/hqHXYdeFmbCn1uyrixfjpctCk9+YJ/V6yx/t8fGNVFDdYVpvqVEGZc
ppISwAa8zNFGIK/+lp0vnH4ReFrb+fvoUcYTMiuZNqe3dHEx1O9Xnxlg0R2P1k+z
jsMkOn/ngnALuiznHY+Usb2WOso9PIC973LHf6AU0NniEHTTTb2tcuybyImgncE=
=F2Oi
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
