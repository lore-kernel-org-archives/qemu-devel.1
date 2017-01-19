Received: from eggs.gnu.org ([2001:4830:134:3::10]:44815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cU9Id-0001VD-BH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cU9Ia-0004Cp-A9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:46:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38856
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cU9Ia-0004CW-3f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:46:28 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0J9jnTS095726
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 04:46:27 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 282qheqhhk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 04:46:26 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 19 Jan 2017 09:46:25 -0000
Date: Thu, 19 Jan 2017 10:46:19 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1484772931-16272-2-git-send-email-mst@redhat.com>
References: <1484772931-16272-1-git-send-email-mst@redhat.com>
	<1484772931-16272-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170119104619.2219a7f4.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] virtio: fix up max size checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org

On Wed, 18 Jan 2017 22:55:40 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Coverity reports that ARRAY_SIZE(elem->out_sg) (and all the others too)
> is wrong because elem->out_sg is a pointer.
> 
> However, the check is not in the right place and the max_size argument
> of virtqueue_map_iovec can be removed.  The check on in_num/out_num
> should be moved to qemu_get_virtqueue_element instead, before the call
> to virtqueue_alloc_element.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Fixes: 3724650db07057333879484c8bc7d900b5c1bf8e ("virtio: introduce virtqueue_alloc_element")
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/virtio/virtio.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
