Received: from eggs.gnu.org ([2001:4830:134:3::10]:45803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhdez-0001kO-Pc
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fhdey-0004dI-OH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:26:09 -0400
Date: Mon, 23 Jul 2018 17:25:56 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180723162556.GG20596@stefanha-x1.localdomain>
References: <20180718211256.29774-1-naravamudan@digitalocean.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TKYYegg/GYAC5JIZ"
Content-Disposition: inline
In-Reply-To: <20180718211256.29774-1-naravamudan@digitalocean.com>
Subject: Re: [Qemu-devel] [PATCH] block/file-posix: add
 bdrv_attach_aio_context callback for host dev and cdrom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org


--TKYYegg/GYAC5JIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 18, 2018 at 02:12:56PM -0700, Nishanth Aravamudan wrote:
> In ed6e2161 ("linux-aio: properly bubble up errors from initialzation"),
> I only added a bdrv_attach_aio_context callback for the bdrv_file
> driver. There are several other drivers that use the shared
> aio_plug callback, though, and they will trip the assertion added to
> aio_get_linux_aio because they did not call aio_setup_linux_aio first.
> Add the appropriate callback definition to the affected driver
> definitions.
>=20
> Fixes: ed6e2161 ("linux-aio: properly bubble up errors from initializatio=
n")
> Reported-by: Farhan Ali <alifm@linux.ibm.com>
> Signed-off-by: Nishanth Aravamudan <naravamudan@digitalocean.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: qemu-block@nongnu.org
> Cc: qemu-devel@nongnu.org
> ---
>  block/file-posix.c | 3 +++
>  1 file changed, 3 insertions(+)

This patch looks good.  The remaining s390 crash can be debugged
separately.

The FreeBSD host_cdrom change isn't strictly necessary (no Linux AIO on
FreeBSD), but it doesn't hurt to call raw_aio_attach_aio_context() for
consistency.

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--TKYYegg/GYAC5JIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbVgGUAAoJEJykq7OBq3PIsiIIAJyD8cb+0bqQHzWHFbi2SwSf
SqZrxfjf6NmUXI6smZ4uSRD5xv2RvGmDLAZ/OCbgsY7NeAodYlL0/WD3Hf+SL4Ex
o2RztccQaJdGFdQfMcLWBH4lvKJwY76IGfxToAp+GtxAIT90tW2e8Gv+aFhCXssC
DLH+9rAO6thpmUo9kDwjeDrp8+Ls0JisXm/GJS1t4xvXik30trSVLBEsHhfPDSEG
Z5LqKL2sWuGov2/x3RxQtLehzCirgOwdeUSHG9MlZP3QCevnvN4j8NLoc3DJqMQK
V8MBQ721TE6GCzHJcC1DCO6bRLZE3Q7YDPUj53gfEWIYjJLBCP3APpd4OluekLk=
=hZ4m
-----END PGP SIGNATURE-----

--TKYYegg/GYAC5JIZ--
