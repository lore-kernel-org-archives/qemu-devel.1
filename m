Received: from eggs.gnu.org ([2001:4830:134:3::10]:40891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZEMZ-0000hV-0d
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cZEK4-0007wC-Bw
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:09:03 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cZEK4-0007w0-5Q
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 05:09:00 -0500
Received: by mail-wm0-x242.google.com with SMTP id u63so3180064wmu.2
	for <qemu-devel@nongnu.org>; Thu, 02 Feb 2017 02:09:00 -0800 (PST)
Date: Thu, 2 Feb 2017 10:08:56 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170202100856.GA22164@stefanha-x1.localdomain>
References: <20161115124417.GC9226@lemon>
	<20161115144551.GB17672@stefanha-x1.localdomain>
	<20161115150016.GD9226@lemon>
	<20161115192026.GA26428@stefanha-x1.localdomain>
	<CAAo6VWN9uO9-jjEfHxLHCBE5V5tr5Sx52tGY5vu3g8JgcCRqvQ@mail.gmail.com>
	<87eg2bokx0.fsf@dusky.pond.sub.org> <20161116094901.GA31999@lemon>
	<CAJSP0QWvsO8480gsOa=1jiY-8WLwTt6cgPtP6O-CAOfehZab3A@mail.gmail.com>
	<CAAo6VWNMw2GdR-MznT5np7ov+hSGZZ-6t69bm5+TqAjmHZJZPQ@mail.gmail.com>
	<CAAo6VWM26xdQhjX9YGiPAXBBxzUNwSi+AUohWyO1HEXxfPv+LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <CAAo6VWM26xdQhjX9YGiPAXBBxzUNwSi+AUohWyO1HEXxfPv+LQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/2] block/vxhs.c: Add support for a new
 block device type called "vxhs"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ashish mittal <ashmit602@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Venkatesha M.G." <Venkatesha.Mg@veritas.com>, Ashish Mittal <ashish.mittal@veritas.com>, Jeff Cody <jcody@redhat.com>, Rakesh Ranjan <Rakesh.Ranjan@veritas.com>, Ketan Nilangekar <Ketan.Nilangekar@veritas.com>, Abhijit Dey <Abhijit.Dey@veritas.com>, Paolo Bonzini <pbonzini@redhat.com>, Buddhi Madhav <Buddhi.Madhav@veritas.com>, John Ferlan <jferlan@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Nitin Jerath <Nitin.Jerath@veritas.com>, Suraj Singh <Suraj.Singh@veritas.com>, Peter Krempa <pkrempa@redhat.com>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2017 at 05:55:47PM -0800, ashish mittal wrote:
> Hi,
>=20
> There has been some work going on on the VxHS libvirt patches and we
> are making good progress.
>=20
> A suggestion has been made on the libvirt community to check if we can
> change the qemu VxHS device specification syntax as follows.
>=20
> Replace
>=20
> (a) +file.server.host=3D192.168.0.1,file.server.port=3D9999
>=20
> with
>=20
> (b) +file.host=3D192.168.0.1,file.port=3D9999
>=20
> The reasoning being that since we have only one host (true as the
> failover is now being handled completely/transparently) within the
> libqnio library), the "server" part is redundant.

Sounds good to me.

Stefan

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYkwU4AAoJEJykq7OBq3PIta8H/3L7PG/8iRsrm6xf9gtQZYqK
02mjMHJZUzTM2AggbA60/y92icvAniqwNwNvWdYAju/hf+jkSnOre9rNFU1KKspe
Y5qBcH99SuTD9Myj7WUJtMnBF1XQavdbTNkjkukv8jJG2T74289Vmd4djYNFel5A
4j5kkEgOWMv3EAQSWSd7jNTbiLunt13+XtsnDivcGXJe/h7h9lZ60jduT8kOyPWh
EU4D1CG4M4w8fPOD3ZxseDUnqaIw0AYFXdOpftAT+oydDUZgsbrtAT83DCsSTnMx
n2O5E8tpYt6KXJHxU7JSmwLKYJmnfkJWsCzsAXIPwxGq+mzSfQM9irB85HvyrKM=
=pXW5
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
