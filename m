Received: from eggs.gnu.org ([2001:4830:134:3::10]:46321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=421499f3a=Paul.Durrant@citrix.com>)
	id 1drmIT-0006VV-JT
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=421499f3a=Paul.Durrant@citrix.com>)
	id 1drmIQ-0003WU-Gu
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:36:17 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:23936
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=421499f3a=Paul.Durrant@citrix.com>)
	id 1drmIQ-0003Sh-6M
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 10:36:14 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 12 Sep 2017 14:33:32 +0000
Message-ID: <b766d2aa5a5441e4a195f6281345e452@AMSPEX02CL03.citrite.net>
References: <59B80A35020000780017A344@prv-mh.provo.novell.com>
	<59B80A35020000780017A344@prv-mh.provo.novell.com>
In-Reply-To: <59B80A35020000780017A344@prv-mh.provo.novell.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] xen_disk: avoid use of g_malloc0_n()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Jan Beulich' <JBeulich@suse.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>

> -----Original Message-----
> From: Jan Beulich [mailto:JBeulich@suse.com]
> Sent: 12 September 2017 07:24
> To: qemu-devel@nongnu.org
> Cc: Paul Durrant <Paul.Durrant@citrix.com>; Stefano Stabellini
> <sstabellini@kernel.org>; xen-devel <xen-devel@lists.xenproject.org>
> Subject: [PATCH] xen_disk: avoid use of g_malloc0_n()
>=20
> Prefer g_new() / g_new0() to be farther backwards compatible with older
> glib versions. As there's no point in zeroing the allocation here (the
> loop right afterwards fully initializes the memory), use the former.
>=20
> Signed-off-by: Jan Beulich <jbeulich@suse.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

>=20
> --- a/hw/block/xen_disk.c
> +++ b/hw/block/xen_disk.c
> @@ -1232,7 +1232,7 @@ static int blk_connect(struct XenDevice
>          return -1;
>      }
>=20
> -    domids =3D g_malloc0_n(blkdev->nr_ring_ref, sizeof(uint32_t));
> +    domids =3D g_new(uint32_t, blkdev->nr_ring_ref);
>      for (i =3D 0; i < blkdev->nr_ring_ref; i++) {
>          domids[i] =3D blkdev->xendev.dom;
>      }
>=20
>=20
