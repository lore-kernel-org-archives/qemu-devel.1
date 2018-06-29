Received: from eggs.gnu.org ([2001:4830:134:3::10]:40019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYwtg-00011x-Tb
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:09:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fYwtg-0003C4-4C
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:09:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53422 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fYwtf-0003Bi-UA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 13:09:24 -0400
Date: Fri, 29 Jun 2018 18:09:19 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180629170919.GE16547@stefanha-x1.localdomain>
References: <20180627112520.26085-1-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline
In-Reply-To: <20180627112520.26085-1-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-rng: process pending requests
 when driver is ready
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: mst@redhat.com, amit@kernel.org, qemu-devel@nongnu.org, slopezpa@redhat.com


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 27, 2018 at 04:55:20PM +0530, Pankaj Gupta wrote:
> +static void virtio_rng_set_status(VirtIODevice *vdev, uint8_t status)
> +{
> +    VirtIORNG *vrng = VIRTIO_RNG(vdev);
> +
> +    if (!vdev->vm_running) {
> +        return;
> +    }
> +    vdev->status = status;

Please add a comment to explain this, otherwise someone might think this
is unnecessary since virtio.c also does it.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbNme/AAoJEJykq7OBq3PI/D8H/2hrxGTkVoud7iefl4bVABHC
KVkhIk3rY894GUA8brUCWaA4hB8hCGMUTKlzxRv+dFUYPJXcQ0Up1WZYg5GmUuZJ
8S01vcuajBalgRq/cO4l6oQT+yKKVthxOcDI1q9qw7N0hWsJOwoUMLwSVdAEC21T
emNMEIvKXxkfk9R8yvAZ/vI5ZYvPTzEleWwsKcymguUJRH2iH7VC9elm36yYxg7H
pHJXT1WEbNZ4DuHZ9ZsR6MmfjJQsSQGMldfFk9AGRGQ5ckQXOvrPLeT4cfeCB4vr
3X/XsXHS+00o6uWbKjhmj55+vffKX8aydolItg9RBis5XagNpBO/iRQLogj4fDA=
=hogg
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--
