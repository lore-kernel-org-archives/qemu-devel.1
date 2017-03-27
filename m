Received: from eggs.gnu.org ([2001:4830:134:3::10]:57912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csSun-0005fR-S0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1csSuk-0007dy-0L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:34:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1csSuj-0007dS-RK
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 07:34:21 -0400
References: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00d28fcc-446b-eff6-a5a3-6675216802b9@redhat.com>
Date: Mon, 27 Mar 2017 13:34:17 +0200
MIME-Version: 1.0
In-Reply-To: <1490690365-21109-1-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH] virtio-blk: add DISCARD
 support to virtio-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@lst.de
Cc: qemu-devel@nongnu.org



On 28/03/2017 10:39, Changpeng Liu wrote:
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> +		q->limits.discard_zeroes_data = 0;

Maybe you could use another feature bit to populate discard_zeroes_data.

Paolo

> +		q->limits.discard_alignment = blk_size;
> +		q->limits.discard_granularity = blk_size;
> +		blk_queue_max_discard_sectors(q, UINT_MAX);
> +		blk_queue_max_discard_segments(q, 1);
> +		queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, q);
> +	}
> +
