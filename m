Received: from eggs.gnu.org ([2001:4830:134:3::10]:44251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUa7l-0005JP-J4
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:57:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUa7k-0004J5-QC
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:57:21 -0400
Date: Mon, 10 Jul 2017 15:57:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710145709.GH14195@stefanha-x1.localdomain>
References: <20170705133635.11850-1-famz@redhat.com>
	<20170705133635.11850-4-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
In-Reply-To: <20170705133635.11850-4-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/6] block: Introduce bdrv_dma_map and
 bdrv_dma_unmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <keith.busch@intel.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Karl Rister <krister@redhat.com>


--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 09:36:32PM +0800, Fam Zheng wrote:
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 15fa602..4092669 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -381,6 +381,10 @@ struct BlockDriver {
>                               uint64_t parent_perm, uint64_t parent_share=
d,
>                               uint64_t *nperm, uint64_t *nshared);
> =20
> +    /* Map and unmap a buffer for I/O, as a performance hint to the
> +     * driver. */
> +    void (*bdrv_dma_map)(BlockDriverState *bs, void *host, size_t size);
> +    void (*bdrv_dma_unmap)(BlockDriverState *bs, void *host);

It's unclear what this API does and how to use it correctly.  Please
flesh out the doc comments a bit to explain its use.

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY5XFAAoJEJykq7OBq3PIqcQH/RS7JJ440cFTB1FsvYVYW0QZ
nHW6eJfdzeMs1JO8R3h0WacKNos24cP9i4KTUXV6ovN4DojXHCogsLilhtjBZatM
YBe32krdqFBCxjxAaOpAojf7hSD0iUYP1tU9Ey72hhG3Tt09bTgvd6bnnJmWE+ma
zfDBQauggRHDHwUftfXljIUdsxLeW0OoFklZpsSWNfcQ3VMjgHoTkuYezn+QNLfO
MfAVaFYuMZJ9SSM8KqwjxuRDuli2WTkjxPbknYeKmjpWx1vzG5fj9SlFg1Xftidw
7BZ3wHbYYGJpM5XleDvc1VwXu6d1hnyixs/NHgplQxFyGktlncVUR5DqdX/Yqiw=
=mvTQ
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--
