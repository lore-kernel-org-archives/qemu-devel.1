Received: from eggs.gnu.org ([209.51.188.92]:55828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpQSb-0007Gt-Og
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 23:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpQSb-0005Kw-3i
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 23:29:49 -0500
Date: Fri, 1 Feb 2019 12:29:28 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201042928.GC23131@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20190131151914.164903-3-sgarzare@redhat.com>
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


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 31, 2019 at 04:19:11PM +0100, Stefano Garzarella wrote:
> In order to avoid migration issues, we enable DISCARD and
> WRITE ZEROES features only for machine type >= 4.0

Please use two separate properties that correspond to the
VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_WRITE_ZEROES virtio-blk feature
bits.

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcU8soAAoJEJykq7OBq3PIWLUH/RvX+VztGd7ZQxRcPEQJdELR
3C4JbZZ3Hi72ssJQ2xaFs0j281wHL8frZ9SzTAIxJ0ycL/04dYmxQsWU/9l4LsnS
q2viH3ysxJy9TGt+l/5X9ZM9f90FXrMOm1vfGVriNErhsAXGQn3CSQBXy7YSeWpW
ckHn+94zl65ihnKD4UV6zS+KSO+w6FW6MRBfG1C0z7njni68FfZ81829pGH2agmg
nm+3NJCZNd18algjW4gRxUuox+5BinPMnengcKL5QQuV7gQ11qnJzoLeFhBkitmi
1K8ub/4MleoCjwoDygQS0wW9Ql9sfXB1h7HjBH6/Jy1aZaYBQops4nzYVQn643M=
=UF3F
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
