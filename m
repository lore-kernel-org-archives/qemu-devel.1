Received: from eggs.gnu.org ([2001:4830:134:3::10]:34927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epABU-0000Vm-Gs
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:02:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1epABK-0002bg-Sq
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:02:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56448)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1epABK-0002ZW-Kp
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 05:02:22 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NA1qbT055733
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:02:21 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gaadcnh16-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 05:02:20 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 23 Feb 2018 10:02:18 -0000
References: <20180223095406.18251-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 23 Feb 2018 11:02:15 +0100
MIME-Version: 1.0
In-Reply-To: <20180223095406.18251-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <9caa0a62-e2cf-837b-a037-76cbcb851b0d@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH] s390x/sclp: remove duplicate
 MAX_AVAIL_SLOTS define
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org



On 02/23/2018 10:54 AM, Cornelia Huck wrote:
> It's already defined in cpu.h (to the same value) and not used in
> the sclp code.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/s390x/sclp.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index 476cbf78f2..f9db243484 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -35,7 +35,6 @@
>  #define SCLP_FC_ASSIGN_ATTACH_READ_STOR         0xE00000000000ULL
>  #define SCLP_STARTING_SUBINCREMENT_ID           0x10001
>  #define SCLP_INCREMENT_UNIT                     0x10000
> -#define MAX_AVAIL_SLOTS                         32
>  #define MAX_STORAGE_INCREMENTS                  1020
> 
>  /* CPU hotplug SCLP codes */
> 
Do we need this define and s390_get_memslot_count at all after removing
the hotplug code?
