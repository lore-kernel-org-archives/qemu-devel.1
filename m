Received: from eggs.gnu.org ([2001:4830:134:3::10]:60894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvcd-00083w-Cl
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:15:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eYvcZ-0002FJ-Fy
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:15:27 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eYvcZ-0002Ea-6f
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 10:15:23 -0500
Received: by mail-wr0-x244.google.com with SMTP id w50so5251132wrc.11
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 07:15:23 -0800 (PST)
Date: Tue, 9 Jan 2018 15:15:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180109151520.GB1197@stefanha-x1.localdomain>
References: <1515433816-5700-1-git-send-email-mst@redhat.com>
	<1515433816-5700-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <1515433816-5700-2-git-send-email-mst@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost-user: fix misaligned access to
 payload
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 07:50:44PM +0200, Michael S. Tsirkin wrote:
> We currently take a pointer to a misaligned field of a packed structure.
> clang reports this as a build warning.
> A fix is to keep payload in a separate structure, and access is it
> from there using a vectored write.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 39 ++++++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVNyIAAoJEJykq7OBq3PIPpYIAKyylY3K4mgoZDQdnE7o4LTH
fKixjQD1qTn7NXYoVsJXtbFwWRcxc8o4l0U+ScRcnYfyJYjcZj/fGU1ocEgbZNEk
8wZW+ttRTHqdN8EpKebjmOwaECPTWyLadgSqrnD75TkfOKXgBw60viV89ueBnmKx
Xk+n2JsdzvB6nXeAqzJVD6TyXdFz+3gZwpa0AzWHLrK1ReDO4daSA1pQotBuiQen
KG29nMRm7ff/EBeCn2/isgJR61Go1NkeDPmk9UfLG683jIMS/c7xcKNfMgQAX2jm
H8Hm/Or0AK2aKeOebCJ+U5XV8ealyXuAK2q5esA/7ZlAp11VNTTdVi7ayaBda3k=
=2lc/
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
