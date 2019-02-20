Received: from eggs.gnu.org ([209.51.188.92]:56361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUm4-0006JR-4N
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gwUm3-0000ep-8o
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 11:31:08 -0500
Date: Wed, 20 Feb 2019 16:30:58 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190220163058.GH30403@stefanha-x1.localdomain>
References: <20190218140301.197408-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <20190218140301.197408-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 00/10] virtio-blk: add
 DISCARD and WRITE_ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 03:02:51PM +0100, Stefano Garzarella wrote:
> This series adds the support of DISCARD and WRITE_ZEROES commands
> and extends the virtio-blk-test to test these new commands.
>=20
> v5:
> - rebased on master
> - handled the config size for DISCARD and WRITE_ZEROES features as in
>   virtio-net (patches 4 and 5) [Michael, Stefan]
> - fixed an endianness issues on the WRITE_ZEROES test (patches 8 and 9)
> - added a test for DISCARD command to only test the status returned by the
>   request (patch 10)
> - others patches are unchanged (patches 1, 2, 3, 6, 7)

Looks good.  Please fix the patchew failure and resend.

Stefan

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcbYDCAAoJEJykq7OBq3PIgw0H/0GDHxmNZmMKRh50cmUCApr9
y/ajJ9dCpxGuazN1kttPBSizRwR163A40btkEfROJyhnBJEnpwl4cDxajUfqc+s8
iw8FpNCh7PlByMOLAX/nUtC9CuwhZoioG+a+iMrNcRBLlZX6mj/lWzb32FNTc8DS
RGHKEUVE3eYFe7FAZ2HFippxP2qa2UxOndolwbTcmRh3fNCLFpkbFy6m4gP8VdXQ
bnRm+lD4+OusMXi3kNLm+we8FF7OJ3qS+YkTzTZ5eDqDACeNnD1w6+4yVo1pbNUJ
Q/nT32q90GtwHAZT90BycN3AB3Muv+PTmCv11S0vOYmstvTYtQ9dGBjFvUnI8Ek=
=TueK
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
