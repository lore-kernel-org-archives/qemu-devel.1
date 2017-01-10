Received: from eggs.gnu.org ([2001:4830:134:3::10]:44423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQunm-00078c-Ho
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cQunj-0002P3-FS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:41:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cQunj-0002Or-9L
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:41:15 -0500
Message-ID: <1484048471.19018.85.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Jan 2017 12:41:11 +0100
In-Reply-To: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
References: <1483969123-14839-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio-gpu: fix issues with VM load
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

On Mo, 2017-01-09 at 13:38 +0000, Peter Maydell wrote:
> These patches fix a couple of issues with the VM load code
> which I noticed while investigating a coverity warning.
>=20
> The first patch fixes a problem with the accounting for
> host pixmap memory usage -- we didn't recalculate the
> current usage following a VM migration, but instead
> started again at zero, which means that if you keep
> bumping the VM from host to host you can sidestep the
> host_maxmem limit.
>=20
> The second patch fixes the coverity warning (that if we
> fail in the "creating resources" loop in the load function
> we will leak memory and so on). The leak isn't very
> serious, because if we fail the inbound migration then
> the whole QEMU process is pretty useless for anything,
> but it's easy enough to fix "correctly", ie so that a
> subsequent system reset will put the device back into
> a sane state.
>=20
> Peter Maydell (2):
>   virtio-gpu: Recalculate VirtIOGPU::hostmem on VM load
>   virtio-gpu: Fix memory leak in virtio_gpu_load()
>=20
>  hw/display/virtio-gpu.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
Added to vga queue.

thanks,
  Gerd
