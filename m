Received: from eggs.gnu.org ([2001:4830:134:3::10]:45322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFRFQ-0007n5-AN
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eFRFN-0006v8-77
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:58:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42526
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eFRFN-0006u7-0E
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 15:58:53 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAGKsojC100803
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:58:52 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e9gvekxkx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Nov 2017 15:58:51 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 Nov 2017 20:58:50 -0000
References: <20171116170526.12643-1-david@redhat.com>
	<20171116170526.12643-2-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 16 Nov 2017 21:58:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171116170526.12643-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bb83d3ed-80ab-7456-5613-a3a625c5a71a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 1/3] s390x: fix storing CPU
 status (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>



On 11/16/2017 06:05 PM, David Hildenbrand wrote:
> Looks like the last fix + cleanup introduced another bug. (for now Linux
> guests don't seem to care) - we store the crs into ars.
> 
> Fixes: 947a38bd6f13 ("s390x/kvm: fix and cleanup storing CPU status")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  target/s390x/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index f78983dd6a..246ba20f0d 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -279,7 +279,7 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
>          sa->ars[i] = cpu_to_be32(cpu->env.aregs[i]);
>      }
>      for (i = 0; i < 16; ++i) {
> -        sa->ars[i] = cpu_to_be64(cpu->env.cregs[i]);
> +        sa->crs[i] = cpu_to_be64(cpu->env.cregs[i]);
>      }
> 
>      cpu_physical_memory_unmap(sa, len, 1, len);
> 
