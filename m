Received: from eggs.gnu.org ([2001:4830:134:3::10]:60012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffNFr-00020s-Bh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ffNFo-0002AF-3J
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:30:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ffNFn-00029W-U1
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:30:48 -0400
Date: Tue, 17 Jul 2018 11:30:42 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180717103042.GA9927@stefanha-x1.localdomain>
References: <20180716173743.133393-1-dgilbert@redhat.com>
	<20180716173743.133393-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20180716173743.133393-3-dgilbert@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for 3.1 2/4] virtio: Check
 qemu_get_virtqueue_element returns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, famz@redhat.com, amit@kernel.org, eblake@redhat.com


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2018 at 06:37:41PM +0100, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Check calls to qemu_get_virtqueue_element for NULL and pass
> up the chain.

What happens to the device state that has been partially deserialized
(e.g. virtio-blk's s->rq linked list)?

It's not clear to me that simply returning NULL is enough to put QEMU
into a sane state without memory leaks or crashes if we decide to retry.

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbTcVSAAoJEJykq7OBq3PIU1sH/3r1r4UJ48HTUdY/5NVRMhY9
uk0Ec/SR8qSdgf8YFzo6sGde8RHhTgR1Aa8WyE5fyb4Tpr2VPwFbBZLdNjbBoOP5
JO2usqnamnFubYYJkEJXey79NMmRGrEw+U3Ym02TI9S8VVolHne9iL9tSx/pLkYI
7tg1NeGOQz0fOEXu5RpMnj33IVSdTduZpPcraalAPI8WfNwll9Uy1DjXSjBT8TXY
Rc2a3SOcCkR0OYqzkMDN3xA/cXjSPgPg6/YPIqjz4tw/rVbTgPhTo26g54YREB8X
VK5o5cXB/k1zTkzXAYvbB44aRCooMUO7FIP1kZYZ0VPxeHXtJDx741yiNHQVnsM=
=xMmf
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
