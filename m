Received: from eggs.gnu.org ([2001:4830:134:3::10]:38146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWhXo-0002hV-JX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:53:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gWhXl-0008On-9D
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:53:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gWhXl-0008OR-2k
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:53:45 -0500
Date: Tue, 11 Dec 2018 12:53:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181211125342.GA21137@stefanha-x1.localdomain>
References: <20181210173151.16629-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20181210173151.16629-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/7] virtio-fs: shared file system for
 virtual machines3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, vgoyal@redhat.com, miklos@szeredi.hu, sweil@redhat.com, swhiteho@redhat.com


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 05:31:44PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Hi,
>   This is the first RFC for the QEMU side of 'virtio-fs';
> a new mechanism for mounting host directories into the guest
> in a fast, consistent and secure manner.  Our primary use
> case is kata containers, but it should be usable in other scenarios
> as well.
>=20
> There are corresponding patches being posted to Linux kernel,
> libfuse and kata lists.
>=20
> For a fuller design description, and benchmark numbers, please see
> Vivek's posting of the kernel set here:
>=20
> https://marc.info/?l=3Dlinux-kernel&m=3D154446243024251&w=3D2
>=20
> We've got a small website with instructions on how to use it, here:
>=20
> https://virtio-fs.gitlab.io/
>=20
> and all the code is available on gitlab at:
>=20
> https://gitlab.com/virtio-fs

A draft specification for the virtio-fs device is available here:

https://stefanha.github.io/virtio/virtio-fs.html#x1-38800010 (HTML)

https://github.com/stefanha/virtio/commit/e1cac3777ef03bc9c5c8ee91bcc6ba478=
272e6b6

Stefan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcD7NWAAoJEJykq7OBq3PIJ/oIAKQYMOXfAB3yXqtBGMBClH38
wy3d73lWJBwTwOeal0L7Ra6/aO5WYE0jOi67d+2ruO3mLigOriZm6ZPlVys8RzVW
9CFOhLfAj36JZ0aC6lb6BlRdCgUtDisyPDWQbkhKDIgLyK6TU+phT93LSEFXaHZ3
H07BYK52j3vVfy9LU1ejgIwajv4dZCh2MI2b2U/flmTUaamMM/418fBcPNXcwqkm
SubEqk2VmXhaAcVQ2fHo1wsvA1Y+FxpLtbM/GZtIk/rQej2OBvXV77b1V1eRExBz
I0m9FJ2+v0Qy1g+DRKSOvKsU/7xVXXc82o5vQq81PGzTj6g++rIVjVkAmMqtKcg=
=+qf+
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
