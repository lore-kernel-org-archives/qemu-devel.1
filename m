Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6d2f-0001P4-6i
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1d6d2a-0005XQ-9z
	for qemu-devel@nongnu.org; Fri, 05 May 2017 09:13:05 -0400
Date: Fri, 5 May 2017 14:12:56 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170505131256.GF11350@stefanha-x1.localdomain>
References: <1493280397-9622-1-git-send-email-ashijeetacharya@gmail.com>
	<1493280397-9622-2-git-send-email-ashijeetacharya@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <1493280397-9622-2-git-send-email-ashijeetacharya@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/7] dmg: Introduce a new struct to
 cache random access points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, mreitz@redhat.com, famz@redhat.com, peter@lekensteyn.nl, qemu-devel@nongnu.org, qemu-block@nongnu.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2017 at 01:36:31PM +0530, Ashijeet Acharya wrote:
> @@ -51,6 +60,7 @@ typedef struct BDRVDMGState {
>      uint8_t *compressed_chunk;
>      uint8_t *uncompressed_chunk;
>      z_stream zstream;
> +    DMGReadState *drs;

This doesn't need to be a pointer.  The object is allocated in
.bdrv_open() and freed in .bdrv_close().  It's simpler to drop the heap
allocation and simply inline the struct:

    DMGReadState drs;

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZDHpYAAoJEJykq7OBq3PIpeAH/Aj/zfa2H45Yf+hJtWsQ/8eF
WBxG0nTdG1Z2JJL85LqIfO6d9oROFDpxzY+RcAlCBkFsMbxgwyjDSmuLZuwcjOkh
GnFPbVnd0nsKb5FmeyYah3TBP8weDPfn80SrUxOcxA5QtHxBPXXfpl/n9Y0gWN8j
SugNMZBNtLqs0Su/sFCnvhgWMKrLd6LZcn5bttu6oJNCF+8ooKpoVtE9efOYxYZh
6yVqXxuQJUADUykeIedViJE5yy4c9PcopyBxsfXH+YkaHwOXDcyYPoqKIYipbdG8
akOyHyGk3+4RTPmkl3pJpCF8PmUi7FvXjyfEH5CgcXVGKvAGSIhGmpd+V2xHEpc=
=WZBX
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
