Received: from eggs.gnu.org ([2001:4830:134:3::10]:53626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnam-0004Fi-Mq
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eKnZz-0004Et-TH
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:51:08 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:34223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eKnZz-0004DP-L2
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:50:19 -0500
Received: by mail-wr0-x22a.google.com with SMTP id y21so10550444wrc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 07:50:19 -0800 (PST)
Date: Fri, 1 Dec 2017 10:02:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171201100220.GE23501@stefanha-x1.localdomain>
References: <20171129185026.23632-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Content-Disposition: inline
In-Reply-To: <20171129185026.23632-1-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/7] Rework vhost memory region updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, maxime.coquelin@redhat.com, mst@redhat.com


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2017 at 06:50:19PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Hi,
>   This is an experimental set that reworks the way the vhost
> code handles changes in physical address space layout that
> came from a discussion with Igor.
>=20
> Instead of updating and trying to merge sections of address
> space on each add/remove callback, we wait until the commit phase
> and go through and rebuild a list by walking the Flatview of
> memory and end up producing an ordered list.
> We compare the list to the old list to trigger updates.
>=20
> Note, only very lightly tested so far, I'm just trying to see if it's
> the right shape.

The cover letter doesn't mention why this change is necessary.  It would
be helpful to know :).

Stefan

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaISisAAoJEJykq7OBq3PImH0H/jehl7I2IzXQ7XvXsI4mNkvt
Baw7K6gxh3zjd/uO+ulfMUcZ/ZviLExDK5AEm+tQ3Brfa7SQmYpv9MiaoEMyrDTb
97pdhKSsk9eo+Biy9tYtqotRkeHkZOzgXjafS4KDapo3bfhy0rW6Ad9Kq74QD3o/
sOkDBnXCSr9ISiXjjDAtirCIWEK0ud6AkwDBJaMjWdrb5etHDB1KVOgS0nuVWhfi
5DGK0/VrOWLtuiuq9uOdhqFQhWWYlyxflz2bCVQ3ZjdrvLMzlxHl/Agu+MtQKKay
EG4H576k17bhaHEoHMj6lReF1CW1hIF5lpYCowexWB0fW5jwpbCN5tu4189Ajak=
=EnTI
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
