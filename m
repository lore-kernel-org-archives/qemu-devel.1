Received: from eggs.gnu.org ([2001:4830:134:3::10]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d6XNv-0001UE-Fp
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1d6XNq-0003vo-Gs
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:10:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1d6XNq-0003v8-8H
	for qemu-devel@nongnu.org; Fri, 05 May 2017 03:10:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4578Zd5009850
	for <qemu-devel@nongnu.org>; Fri, 5 May 2017 03:10:31 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8hf07cxe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 05 May 2017 03:10:31 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 5 May 2017 03:10:30 -0400
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
	<20170426144645.12476-3-farman@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 5 May 2017 09:10:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170426144645.12476-3-farman@linux.vnet.ibm.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Message-Id: <f25222ab-7145-92ce-cfe5-4c3918edcaa2@de.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v1 2/5] pc-bios/s390-ccw: Remove
 duplicate blk_factor adjustment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 04/26/2017 04:46 PM, Eric Farman wrote:
> When using virtio-scsi, we multiply the READ(10) data_size by
> a block factor twice when building the I/O.  This is fine,
> since it's only 1 for SCSI disks, but let's clean it up.
> 
> Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  pc-bios/s390-ccw/virtio-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
> index d850a8d..69b7a93 100644
> --- a/pc-bios/s390-ccw/virtio-scsi.c
> +++ b/pc-bios/s390-ccw/virtio-scsi.c
> @@ -154,7 +154,7 @@ static bool scsi_read_10(VDev *vdev,
>      VirtioCmd read_10[] = {
>          { &req, sizeof(req), VRING_DESC_F_NEXT },
>          { &resp, sizeof(resp), VRING_DESC_F_WRITE | VRING_DESC_F_NEXT },
> -        { data, data_size * f, VRING_DESC_F_WRITE },
> +        { data, data_size, VRING_DESC_F_WRITE },
>      };
> 
>      debug_print_int("read_10  sector", sector);
> 
