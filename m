Received: from eggs.gnu.org ([2001:4830:134:3::10]:57853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dJHwJ-0001Jo-71
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dJHwF-000647-GW
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:18:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:16113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dJHwF-000633-6k
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 07:18:47 -0400
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Fri, 9 Jun 2017 11:18:42 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73925B11D@shsmsx102.ccr.corp.intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 0/6] Virtio-balloon Enhancement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "david@redhat.com" <david@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>

On Friday, June 9, 2017 6:42 PM, Wang, Wei W wrote:
> To: virtio-dev@lists.oasis-open.org; linux-kernel@vger.kernel.org; qemu-
> devel@nongnu.org; virtualization@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-mm@kvack.org; mst@redhat.com;
> david@redhat.com; Hansen, Dave <dave.hansen@intel.com>;
> cornelia.huck@de.ibm.com; akpm@linux-foundation.org;
> mgorman@techsingularity.net; aarcange@redhat.com; amit.shah@redhat.com;
> pbonzini@redhat.com; Wang, Wei W <wei.w.wang@intel.com>;
> liliang.opensource@gmail.com
> Subject: [PATCH v11 0/6] Virtio-balloon Enhancement
>=20
> This patch series enhances the existing virtio-balloon with the following=
 new
> features:
> 1) fast ballooning: transfer ballooned pages between the guest and host i=
n
> chunks, instead of one by one; and
> 2) cmdq: a new virtqueue to send commands between the device and driver.
> Currently, it supports commands to report memory stats (replace the old s=
tatq
> mechanism) and report guest unused pages.

v10->v11 changes:
1) virtio_balloon: use vring_desc to describe a chunk;
2) virtio_ring: support to add an indirect desc table to virtqueue;
3)  virtio_balloon: use cmdq to report guest memory statistics.

>=20
> Liang Li (1):
>   virtio-balloon: deflate via a page list
>=20
> Wei Wang (5):
>   virtio-balloon: coding format cleanup
>   virtio-balloon: VIRTIO_BALLOON_F_PAGE_CHUNKS
>   mm: function to offer a page block on the free list
>   mm: export symbol of next_zone and first_online_pgdat
>   virtio-balloon: VIRTIO_BALLOON_F_CMD_VQ
>=20
>  drivers/virtio/virtio_balloon.c     | 781 ++++++++++++++++++++++++++++++=
++--
> --
>  drivers/virtio/virtio_ring.c        | 120 +++++-
>  include/linux/mm.h                  |   5 +
>  include/linux/virtio.h              |   7 +
>  include/uapi/linux/virtio_balloon.h |  14 +
>  include/uapi/linux/virtio_ring.h    |   3 +
>  mm/mmzone.c                         |   2 +
>  mm/page_alloc.c                     |  91 +++++
>  8 files changed, 950 insertions(+), 73 deletions(-)
>=20
> --
> 2.7.4
