Received: from eggs.gnu.org ([2001:4830:134:3::10]:46085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egGlB-0003Yd-Tw
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:14:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1egGl8-0002nh-Kf
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:14:37 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:51546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1egGl8-0002n9-Ct
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 16:14:34 -0500
Received: by mail-wm0-x22d.google.com with SMTP id r71so17112177wmd.1
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 13:14:34 -0800 (PST)
Date: Mon, 29 Jan 2018 21:14:31 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180129211431.GA1640@stefanha-x1.localdomain>
References: <151675071042.29381.16225631028845063799.stgit@bahia.lan>
	<151675076332.29381.6289851186190918274.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <151675076332.29381.6289851186190918274.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 5/7] tests: virtio-9p: add WRITE operation
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 12:39:23AM +0100, Greg Kurz wrote:
> +/* size[4] Twrite tag[2] fid[4] offset[8] count[4] data[count] */
> +static P9Req *v9fs_twrite(QVirtIO9P *v9p, uint32_t fid, uint64_t offset,
> +                          uint32_t count, const void *data, uint16_t tag)
> +{
> +    P9Req *req;
> +
> +    req = v9fs_req_init(v9p,  4 + 8 + 4 + count, P9_TWRITE, tag);

(uint32_t)(4 + 8 + 4 + (uint32_t)count) can overflow.  I didn't look
closely at the code and it's just a test case, but it seems safer to use
types that avoid overflows or to handle them explicitly.

It may not be an issue in a test case, but if someone copy pastes this
code it could become a security issue.

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJab463AAoJEJykq7OBq3PITYsH/jnqtYeW15q+NqA8/u954WVl
lFGhusYmNt8UxSw8Td4Ei/Dw5oyEb9b7xnMigA5Xfh/qHtSd8DR5iTYIJTeiOP/m
+X1kppW48YZvjCMMvQ0OEiy9O6P2LFTI1Xo8I7KVeFCgeIRlsstHdEXsimNHHi2M
o6ioaUFPr8oRxSy9RL3uaHv58aznpPbT7+TKjgl9oVkRKn4GIKfYIQiRYQfKMX+t
oTp7mxgiPDzVttx9I277rIQZy8SrkubZo0EckoTfcSSV+WLOM+rDK85J4/+jSOqv
yEAVhsJCKUfIsdc7uJP2WKkPWBlqNhghuhx5x0VA8uzQyDmwSAQG8ipWEw/ZVOE=
=Sqth
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
