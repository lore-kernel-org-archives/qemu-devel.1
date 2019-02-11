Received: from eggs.gnu.org ([209.51.188.92]:34602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtFIC-0001TI-0w
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtFIB-0004mI-EU
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:22:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtFI9-0004hl-Fg
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 12:22:51 -0500
Date: Mon, 11 Feb 2019 12:22:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211122058-mutt-send-email-mst@kernel.org>
References: <20190211165756.GN2627@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211165756.GN2627@work-vm>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio-blk io bar size changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, changpeng.liu@intel.com, stefanha@redhat.com, ldoktor@redhat.com

On Mon, Feb 11, 2019 at 04:58:19PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   Luk=C3=A1=C5=A1 reported that there's a migration breakage between 3.=
1 and
> current head with virtio-blk;   it looks like the io bar changes from 6=
4
> to 128 bytes and my bisect suggests it's:
>=20
> commit caa1ee43131c060347b32893abd41fe4865eaa2e (HEAD, refs/bisect/bad)
> Author: Changpeng Liu <changpeng.liu@intel.com>
> Date:   Wed Jan 16 13:19:30 2019 +0800
>=20
>     vhost-user-blk: add discard/write zeroes features support
>=20
>=20
> How do we fix that?
>=20
> Dave

Quickly :)

See the logic around virtio_net_set_config_size
and static VirtIOFeature feature_sizes - we need to
add something similar to virtio blk now.


> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
