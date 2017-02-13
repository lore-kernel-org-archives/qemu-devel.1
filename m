Received: from eggs.gnu.org ([2001:4830:134:3::10]:59843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHbG-0007NH-6F
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHbD-0004gH-Jb
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:27:30 -0500
Date: Mon, 13 Feb 2017 14:27:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213142724.GJ10361@stefanha-x1.localdomain>
References: <20170207132723.13934-1-famz@redhat.com>
	<20170207132723.13934-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6J7GEvtanOfV9oXA"
Content-Disposition: inline
In-Reply-To: <20170207132723.13934-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] virtio-blk: Remove
 useless condition around g_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>


--6J7GEvtanOfV9oXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 09:27:22PM +0800, Fam Zheng wrote:
> Laszlo spotted and studied this wasteful "if". He pointed out:
>=20
> The original virtio_blk_free_request needed an "if" as it accesses one
> field, since 671ec3f05655 ("virtio-blk: Convert VirtIOBlockReq.elem to
> pointer", 2014-06-11); later on in f897bf751fbd ("virtio-blk: embed
> VirtQueueElement in VirtIOBlockReq", 2014-07-09) the field became
> embedded, so the "if" became unnecessary (at which point we were using
> g_slice_free(), but it is the same.
>=20
> Now drop it.
>=20
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  hw/block/virtio-blk.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--6J7GEvtanOfV9oXA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYocJMAAoJEJykq7OBq3PIL3EIAKgliiDrlhwUpSbZEdkNHHyq
iBjN2VDzpb6GNRw+WSsc1hlRG1Q+B2gVpB4+CDr3x2MpVhXMg3Ej0C3kK5qkjYWq
riiJnndflXnzkWu7Vcjk8IoFXjd6Xq1VkHai1GQ+gzMYi8EwEmZaN0cCDqYGhHsT
wJulwldbY/X5cIuMSdGQ4g1QMc7Wf6vxu4M6jq6c8gGVC2OxkneXCB42u7fx1RNF
DzkNYP0LPFUkkuzt7MY9BoLZ2GgZ6zM6ngfcWPL/2KzhPJR9enbFvgRjdB/0gBlY
Gs3H0wOuwVcEOQdl0lE1Y09iyVwd3Fyuk3qzmOp0/1dr1+dB0X4+Rc09XZ+x+zM=
=ENIK
-----END PGP SIGNATURE-----

--6J7GEvtanOfV9oXA--
