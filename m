Received: from eggs.gnu.org ([2001:4830:134:3::10]:39708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1W18-00079Y-OY
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1W15-0000id-Iv
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:46:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50048
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=0626c35109=borntraeger@de.ibm.com>)
	id 1f1W15-0000iT-CZ
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 07:46:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2TBiEJV131541
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 07:46:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h0x0h42gu-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 29 Mar 2018 07:46:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 29 Mar 2018 12:46:48 +0100
References: <1522316251-16399-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Mar 2018 13:46:45 +0200
MIME-Version: 1.0
In-Reply-To: <1522316251-16399-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ee0b89fe-6d09-efb3-bdf9-9e98f3e852f9@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: Increase virtio
 timeout to 30 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, ldoktor@redhat.com



On 03/29/2018 11:37 AM, Thomas Huth wrote:
> The current timeout is set to only three seconds - and considering that
> vring_wait_reply() or rather get_second() is not doing any rounding,
> the real timeout is likely rather 2 seconds in most cases. When the
> host is really badly loaded and we run the guest in TCG mode instead
> of KVM, it's possible that we hit this timeout by mistake. So let's
> increase the timeout to 30 seconds instead to ease this situation (30
> seconds is also the timeout that is used by the Linux SCSI subsystem
> for example, so this seems to be a sane value for block IO timeout).
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1549079
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

I think this should go into 2.12 with a rebuild


> ---
>  pc-bios/s390-ccw/virtio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
> index 817e7f5..cdb66f4 100644
> --- a/pc-bios/s390-ccw/virtio.c
> +++ b/pc-bios/s390-ccw/virtio.c
> @@ -14,7 +14,7 @@
>  #include "virtio-scsi.h"
>  #include "bswap.h"
> 
> -#define VRING_WAIT_REPLY_TIMEOUT 3
> +#define VRING_WAIT_REPLY_TIMEOUT 30
> 
>  static VRing block[VIRTIO_MAX_VQS];
>  static char ring_area[VIRTIO_RING_SIZE * VIRTIO_MAX_VQS]
> 
