Received: from eggs.gnu.org ([2001:4830:134:3::10]:39190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwVBG-0002Kd-Qp
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cwVBD-0001K5-Ik
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:48:06 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:35781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cwVBD-0001Jp-D4
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:48:03 -0400
Received: by mail-wm0-x235.google.com with SMTP id w64so503672wma.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 07:48:03 -0700 (PDT)
Date: Fri, 7 Apr 2017 15:47:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170407144759.GL16146@stefanha-x1.localdomain>
References: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <1491548326-60072-1-git-send-email-weiqi4@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vhost: simple clean up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: weiqi <weiqi4@huawei.com>
Cc: mst@redhat.com, arei.gonglei@huawei.com, qemu-devel@nongnu.org


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 07, 2017 at 02:58:46PM +0800, weiqi wrote:
> From: Wei Qi <weiqi4@huawei.com>
>=20
> It is unnecessary to assign 'hdev->nvqs' to 'i', because 'hdev->nvqs' unu=
sed after assignment, so remove it.
>=20
> Signed-off-by: Wei Qi <weiqi4@huawei.com>
> ---
>  hw/virtio/vhost.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY56afAAoJEJykq7OBq3PIiloIAIsHiXXGfDNOETo9fIywb4Gl
zlum3Y2wJqDfsjWLWK0wXPaVtVCwpOJup71CAm9KhI10dzj9A2rngvnm8J4BjuJi
TjiyDqsgo1B1ROCVV0nfXG6WLbYrLZwy0vEBk5Fg40bLwJkeQvujwY5zITKpD4JR
/U3OK7nFuZwpE/KG95j9BXGkmVA+HGJqdGgGbNpafRkB+Fy/TomguIJWxDznRxLm
rhbldgVksphWEYODDgHlJVAK2DsJJAtgKij2WQJrX1/lVzFnIlw7j01bCHy6JRYo
6kV5vvDbO0juSDfxrZzpWBcCmfkQDpSjv5+za83Z0GrsWxXvgaMtZXZFHLlZu2s=
=k+rc
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
