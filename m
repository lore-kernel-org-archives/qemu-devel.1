Received: from eggs.gnu.org ([2001:4830:134:3::10]:59202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZGAL-00075b-1h
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gZGAF-0004pm-EY
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gZGAF-0004pR-7e
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 09:16:03 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so16022912wrt.13
	for <qemu-devel@nongnu.org>; Tue, 18 Dec 2018 06:16:01 -0800 (PST)
Date: Tue, 18 Dec 2018 13:13:01 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181218131301.GD30223@stefanha-x1.localdomain>
References: <20181213210057.3676-1-quintela@redhat.com>
	<20181213210057.3676-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20181213210057.3676-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/16] virtio: split vhost user blk bits
 from virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 13, 2018 at 10:00:48PM +0100, Juan Quintela wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/virtio/Makefile.objs        |   1 +
>  hw/virtio/vhost-user-blk-pci.c | 101 +++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c         |  60 --------------------
>  hw/virtio/virtio-pci.h         |  18 ------
>  4 files changed, 102 insertions(+), 78 deletions(-)
>  create mode 100644 hw/virtio/vhost-user-blk-pci.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGPJdAAoJEJykq7OBq3PI9/kH/0gCwp0qm/8nW4SQZCTkgwGT
h2R2T+swplqNBgMTbgPH7l+6ZMuLw6ntZwjqBQtRSb8YgugzeasJ4TFLIJQA1+yd
Xn5/pEs80WyVjs30tiKQf+hzRbW1bxm3PHqMmpRyD8CCPYDsCPYTp3wXXUiFnGhU
B8FEADZ1QlS030KOiZuGiDwqdSqdACtB2qNx/FO9JnoyTBl7y8WRjd3Kq/ycGz9p
QbbLV+LFgAs3tkijVEwjBbLrEJmhlIOAlbBivFGzUpCgBUN60RrdSpQAzw++Hp7N
llZJK0hF0Yq+bVloD10mWU8QlhSSkkOfgjPCi5xb1UzNfWpcng7AL6/wEuyasqo=
=YRmY
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
