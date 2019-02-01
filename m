Received: from eggs.gnu.org ([209.51.188.92]:60277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpVid-0002JV-7w
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:06:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpVic-0002YD-9Q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:06:43 -0500
Date: Fri, 1 Feb 2019 18:06:22 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201100622.GB30277@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190201042928.GC23131@stefanha-x1.localdomain>
	<20190201090908.vtb2u5pwvouej7ei@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <20190201090908.vtb2u5pwvouej7ei@steredhat>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio-blk: add "discard-wzeroes"
 boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 10:09:08AM +0100, Stefano Garzarella wrote:
> On Fri, Feb 01, 2019 at 12:29:28PM +0800, Stefan Hajnoczi wrote:
> > On Thu, Jan 31, 2019 at 04:19:11PM +0100, Stefano Garzarella wrote:
> > > In order to avoid migration issues, we enable DISCARD and
> > > WRITE ZEROES features only for machine type >=3D 4.0
> >=20
> > Please use two separate properties that correspond to the
> > VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_WRITE_ZEROES virtio-blk feature
> > bits.
>=20
> Okay.
> As Michael suggested, what do you think if I use a similar approach of
> virtio-net, adding an host_features variable and setting a corresponding
> feature bit?

Yes, that's a clean way of supporting feature bit options.

Stefan

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcVBoeAAoJEJykq7OBq3PIgDUH/2qVx+d6gSvS0JHdJA9GRipR
AxkBFbOwlxYmfoDEysdmkWYmBoC6hxys5uDs0AAfC3BL8lN6SH9EfgXg7OiHWoOY
q4CD0R1QfelJNnnVhwisYPDyxCWIvdtYvBExjXkBiW/RHPYpUTBuF2+U67mSm2Xk
BR9tcVZ8JLIGsVXwp9EJMLxv14Md4GwjUiKhGHO+U3pMS/5Je52CsMk4vR/N5SU6
5F+CJ+khLZOUY8XZWETDvcQmbp/c3oHArt1C4ZxtxKwHlPvccFKUSJSoGQv9wToy
1JDXaRITuZkQOrGbUM7QKJ5AoC6+OU0ME001nqY7Jw91Fd5r372uwgcE4Favikw=
=DQuD
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
