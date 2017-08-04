Received: from eggs.gnu.org ([2001:4830:134:3::10]:50833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddcPy-0000SZ-QE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ddc7U-0007iN-OE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:55:15 -0400
Date: Fri, 4 Aug 2017 13:53:16 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170804125316.GF14565@stefanha-x1.localdomain>
References: <cover.1501827395.git.maozy.fnst@cn.fujitsu.com>
	<9f19357ed430981ff7222e836570141962ced3f4.1501827395.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
In-Reply-To: <9f19357ed430981ff7222e836570141962ced3f4.1501827395.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] hw/block: Use errp directly rather
 than local_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 06:26:42PM +0800, Mao Zhongyi wrote:
> Pass the error message to errp directly rather than the local
> variable local_err and propagate it to errp via error_propagate().
>=20
> Cc: John Snow <jsnow@redhat.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
>=20
> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
> ---
>  hw/block/fdc.c        | 17 ++++++-----------
>  hw/block/nvme.c       |  8 +++-----
>  hw/block/virtio-blk.c | 17 +++++------------
>  hw/ide/qdev.c         | 12 ++++--------
>  hw/scsi/scsi-disk.c   | 13 ++++---------
>  hw/usb/dev-storage.c  |  9 +++------
>  6 files changed, 25 insertions(+), 51 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZhG48AAoJEJykq7OBq3PIizkH/AmMJmtTXlYym5hwMYZScbZl
3hhK4qpbjiq/dzW8cM7ns327jVEIHyrDVMIIf5FE/fw1RAKXN4/Bs1s1SpmLr1TJ
Ko1n1Hwuq+FCOdFMEImgB/VWeVX4WKK9HDitbnH5VkReLKVZBeXxnjVCEzozUr3b
No6I1oyerWVOVr9Yqp64xj27MqXlCKpTq+e87JS9P/tv8wy8Cd0/AN/8f4OMaeMa
0Jooe46VVPtUCFLmXlMrFQHSiNL3EJlQT5eXN1aoQmFEs7FjSKqS5StGNdxtpgjP
WGHCwr0vs3eswjVk1/c0GbuRHdWX/hKSKiyZQs3ncg9+rMSKlehSV4uYO7Lq5TU=
=2KN+
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
