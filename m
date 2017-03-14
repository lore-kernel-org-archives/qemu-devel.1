Received: from eggs.gnu.org ([2001:4830:134:3::10]:60590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cnieq-0002rr-6J
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cniel-0000YY-7U
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:22:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59958
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cniel-0000Xv-0v
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 05:22:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2E9J6Jg006049
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:22:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 295xm3qkja-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 05:22:13 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 14 Mar 2017 09:22:10 -0000
Date: Tue, 14 Mar 2017 10:22:06 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <1489460502-6686-2-git-send-email-jasowang@redhat.com>
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
	<1489460502-6686-2-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170314102206.00df412f.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH V3 1/3] virtio: guard against NULL pfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 14 Mar 2017 11:01:40 +0800
Jason Wang <jasowang@redhat.com> wrote:

> To avoid access stale memory region cache after reset, this patch
> check the existence of virtqueue pfn for all exported virtqueue access
> helpers before trying to use them.
> 
> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V2:
> - return 1 instead of 0 for virtio_queue_empty_*(), and return as
>   early as possible
> ---
>  hw/virtio/virtio.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
