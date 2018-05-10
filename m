Received: from eggs.gnu.org ([2001:4830:134:3::10]:59809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGgmM-0005S6-Pr
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGgmL-00058H-5c
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:18:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fGgmL-00057v-05
	for qemu-devel@nongnu.org; Thu, 10 May 2018 04:18:21 -0400
Date: Thu, 10 May 2018 09:18:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510081819.GB1296@stefanha-x1.localdomain>
References: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
	<1525895585-79023-2-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <1525895585-79023-2-git-send-email-thomas.tai@oracle.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH V2 1/1] virtio-balloon: fix
 internal stat name array to match Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Tai <thomas.tai@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, rob.gardner@oracle.com


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 03:53:05PM -0400, Thomas Tai wrote:
> The Linux kernel commit b40000325044 ("virtio_balloon: add array
> of stat names") defines an array of stat name strings for consumers
> of the virtio interface to use via the virtio_balloon.h header
> file, rather than requiring each consumer to define its own. But at
> present, the stat names defined in this array by the Linux kernel
> do not match up with those defined internally by QEMU.
>=20
> This patch fixes this inconsistency by importing the header file
> from linux and use the new macro to construct the balloon_stat_names
> array.
>=20
> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
> Signed-off-by: Thomas Tai <thomas.tai@oracle.com>
> Cc: Rob Gardner <rob.gardner@oracle.com>
> ---
>  docs/virtio-balloon-stats.txt                   |  2 ++
>  hw/virtio/virtio-balloon.c                      | 13 ++-----------
>  include/standard-headers/linux/virtio_balloon.h | 19 ++++++++++++++++++-
>  3 files changed, 22 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9ABLAAoJEJykq7OBq3PIgiYIAJUyBq7S6cvlpvA8DECPnq7Z
HZLlP83Reo6gUcoMMcndPRtW0BFxCBqjM9Fw0czPpYanzxNgtxU63EUTg+k8yE4d
wd4QSt+Zi4Picq0NX1dH1jEAi4o0uuMxBGHwNWYfpOBrFUGTawzY1cTZtaoRlcFS
HCmDIHlJ88fQV/hZWtazTh92q+RHWFUmlDjHUd2nlYBJFvazz3pF77JSQkyVBsZm
lG9BIBIGD7DaIju+8NbLwb/Qir7eyHgLRh9PlMqAMKO5QyZEDeq9w3id2i0095Wd
EnylN4OnapNJYFOkJJpox0Ywx48nsADgNDgcla7MnJzcXPJOMWp+f91nYc7i8wY=
=x954
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
