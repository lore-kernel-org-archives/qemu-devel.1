Received: from eggs.gnu.org ([2001:4830:134:3::10]:52782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSoP0-0006ap-0j
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dSoOv-0004B8-1u
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:47:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dSoOu-0004Ap-Oo
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:47:44 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v65HldAs036834
	for <qemu-devel@nongnu.org>; Wed, 5 Jul 2017 13:47:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bh38kccn8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 13:47:27 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 5 Jul 2017 11:46:27 -0600
References: <1499268345-12552-1-git-send-email-thuth@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 5 Jul 2017 19:46:21 +0200
MIME-Version: 1.0
In-Reply-To: <1499268345-12552-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <25d456d5-3c85-e8cb-b67f-4d043ce9ddde@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix endianness problem with
 netboot_start_addr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>

On 07/05/2017 05:25 PM, Thomas Huth wrote:
> The start address has to be stored in big endian byte order
> in the iplb.ccw block for the guest.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/ipl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
> index 4e6469d..cc36003 100644
> --- a/hw/s390x/ipl.c
> +++ b/hw/s390x/ipl.c
> @@ -418,7 +418,7 @@ void s390_ipl_prepare_cpu(S390CPU *cpu)
>              error_report_err(err);
>              vm_stop(RUN_STATE_INTERNAL_ERROR);
>          }
> -        ipl->iplb.ccw.netboot_start_addr = ipl->start_addr;
> +        ipl->iplb.ccw.netboot_start_addr = cpu_to_be64(ipl->start_addr);
>      }
>  }
> 

Thanks also applied to s390-next.
