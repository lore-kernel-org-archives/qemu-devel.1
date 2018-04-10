Received: from eggs.gnu.org ([2001:4830:134:3::10]:36115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5kFR-000104-Fh
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f5kFO-00023w-B8
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:47:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60928 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f5kFO-00023a-5w
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 23:47:06 -0400
References: <1522846444-31725-1-git-send-email-wexu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a939f45d-3c14-198e-b871-3034a0142d21@redhat.com>
Date: Tue, 10 Apr 2018 11:46:47 +0800
MIME-Version: 1.0
In-Reply-To: <1522846444-31725-1-git-send-email-wexu@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 0/8] virtio-net 1.1 userspace backend
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wexu@redhat.com, mst@redhat.com, tiwei.bie@intel.com, jfreimann@redhat.com, qemu-devel@nongnu.org



On 2018=E5=B9=B404=E6=9C=8804=E6=97=A5 20:53, wexu@redhat.com wrote:
> From: Wei Xu <wexu@redhat.com>
>
> This is a prototype for virtio-net 1.1 support in userspace backend,
> only minimum part are included in this RFC(roughly synced to v8 as
> Jason and Tiwei's RFC).
>
> Test has been done together with Tiwei's RFC guest virtio-net driver
> patch, ping and a quick iperf test successfully.
>
> Issues:
> 1. Rx performance of Iperf is much slower than TX.
>      TX: 13-15Gb
>      RX: 100-300Mb

This needs to be investigated. What's the pps of TX/RX then? (Maybe you=20
can try Jen's dpdk code too).

Thanks

>
> Missing:
> - device and driver
> - indirect descriptor
> - migration
> - vIOMMU support
> - other revisions since v8
> - see FIXME
>
> Wei Xu (8):
>    virtio: feature bit, data structure for packed ring
>    virtio: memory cache for packed ring
>    virtio: add empty check for packed ring
>    virtio: add detach element for packed ring(1.1)
>    virtio: notification tweak for packed ring
>    virtio: flush/push support for packed ring
>    virtio: get avail bytes check for packed ring
>    virtio: queue pop support for packed ring
>
>   hw/virtio/virtio.c                             | 618 ++++++++++++++++=
+++++++--
>   include/hw/virtio/virtio.h                     |  12 +-
>   include/standard-headers/linux/virtio_config.h |   2 +
>   3 files changed, 601 insertions(+), 31 deletions(-)
>
