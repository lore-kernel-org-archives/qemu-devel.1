Received: from eggs.gnu.org ([2001:4830:134:3::10]:40284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3f6e-0005Qv-Ce
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:53:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f3f6b-0005Hv-BB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:53:28 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1f3f6b-0005Hf-38
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 05:53:25 -0400
Received: by mail-wr0-x236.google.com with SMTP id z73so21601449wrb.0
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:53:24 -0700 (PDT)
Date: Wed, 4 Apr 2018 10:53:22 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180404095322.GK4467@stefanha-x1.localdomain>
References: <20180328133435.20112-1-linzhecheng@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jtds+vpI57xq70EV"
Content-Disposition: inline
In-Reply-To: <20180328133435.20112-1-linzhecheng@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] virtio-serial: fix heap-over-flow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, mst@redhat.com
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com, wangxinxin.wang@huawei.com, linzhecheng <linzhecheng@huawei.com>


--Jtds+vpI57xq70EV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2018 at 09:34:35PM +0800, linzhecheng wrote:
> Check device having the feature of VIRTIO_CONSOLE_F_EMERG_WRITE before
> get config->emerg_wr. It is neccessary because sizeof(virtio_console_conf=
ig)
> is 8 byte if VirtIOSerial doesn't have the feature of
> VIRTIO_CONSOLE_F_EMERG_WRITE(see virtio_serial_device_realize),
> read/write emerg_wr will lead to heap-over-flow.
>=20
> Signed-off-by: linzhecheng <linzhecheng@huawei.com>

Michael or Paolo: Please merge for QEMU 2.12

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Jtds+vpI57xq70EV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaxKCSAAoJEJykq7OBq3PI784H/Rmj3TKzSVua9fpIcegpk8C+
+s8GcxFluRrZNrCxc1vT94D9dLrJLrC+Ame8KT7r7s0r6gaHYMBDzJWE6Ya4HcrB
hyyU0hIqyTFF+6Lz7yd2X1Zk8XyWQo+lSkHz2hZsPsmfM5aHSL4Ov3ZaCjxDMHkW
BgXqlYIx1rui5ixOTnOwFUso7CNc2AjxwKA1jS5aQ0GEDZ2pNbBoRZcKT0hPw2Nl
sfNyKZdEq4awCv2VH9b66JNXUCKYDR/nm4YzRGXcK3LDxN6MoTf6bEAPbXE8B0mP
jJIZVzpDzP2eHuH5tw57C73V3byOG2rHfYCxyoXtgKifM12cCEs3bXqREltolfw=
=HNTV
-----END PGP SIGNATURE-----

--Jtds+vpI57xq70EV--
