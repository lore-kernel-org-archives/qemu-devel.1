Received: from eggs.gnu.org ([2001:4830:134:3::10]:40174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUN2-0003VA-2x
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:42:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eCUMx-0003jD-4K
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:42:36 -0500
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:56585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eCUMw-0003it-SS
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 12:42:31 -0500
Received: by mail-wm0-x231.google.com with SMTP id z3so12500690wme.5
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 09:42:30 -0800 (PST)
Date: Wed, 8 Nov 2017 17:42:27 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171108174227.GC8403@stefanha-x1.localdomain>
References: <20171107104653.8913-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20171107104653.8913-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2017 at 05:46:53AM -0500, Paul Durrant wrote:
> This patch allocates an IOThread object for each xen_disk instance and
> sets the AIO context appropriately on connect. This allows processing
> of I/O to proceed in parallel.
>=20
> The patch also adds tracepoints into xen_disk to make it possible to
> follow the state transtions of an instance in the log.

virtio-blk and virtio-scsi allow the user to specify an IOThread object.
This allows users to configure the device<->IOThread mapping any way
they like (e.g. 1:1, M:N).  Are you sure you want to hard-code the
IOThread mapping?

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaA0IDAAoJEJykq7OBq3PIaZQH/RZk0Ya32uUPjPYIfAOruNgu
rvACDaQmS8ERv4qhxVAQLgYpGxmAIekIn3ULmyHm/AN/tXRmDIDb20okoAxfvAWa
4AWc8NwBFdExt92aGGxgI3A320e4gKNqHfpuk8KJ7QhMIANGX7P2+bJAottFB524
hHoTNhZzSd5MN2YHQdKyVQ1Dkd78hCjunIBBNR8xiteYI988eH7Su0MDeCL6Gp/v
m4roaf+pzmPMZ1fLP1JBhZK5rj7OFoE1mLpkeeAY0+Kf5/lR/wswZRHgon2ld7+R
Jas4+RO8S6BrWZtAl3/d1joX8fcICD5TK5avC3QLbU2yb/dnrtRXZTM8hvNLK+4=
=8+As
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
