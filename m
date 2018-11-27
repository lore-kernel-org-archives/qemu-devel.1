Received: from eggs.gnu.org ([2001:4830:134:3::10]:58443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRifP-0004ZZ-0y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:05:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRifK-0006Jx-CG
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:05:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gRifK-0006JU-3q
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:04:58 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wARIwavi145449
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:04:56 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p18y37qu9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:04:56 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 27 Nov 2018 19:04:56 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 27 Nov 2018 14:04:49 -0500
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a3a73709-e354-758a-a7f0-219eafd593ab@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
> index 078e46f9623d..a6f9f84526e2 100644
> --- a/drivers/s390/cio/vfio_ccw_private.h
> +++ b/drivers/s390/cio/vfio_ccw_private.h
> @@ -3,9 +3,11 @@
>    * Private stuff for vfio_ccw driver
>    *
>    * Copyright IBM Corp. 2017
> + * Copyright Red Hat, Inc. 2018
>    *
>    * Author(s): Dong Jia Shi<bjsdjshi@linux.vnet.ibm.com>
>    *            Xiao Feng Ren<renxiaof@linux.vnet.ibm.com>
> + *            Cornelia Huck<cohuck@redhat.com>
>    */
>   
>   #ifndef_VFIO_CCW_PRIVATE_H_
> @@ -19,6 +21,38 @@
>   #include "css.h"
>   #include "vfio_ccw_cp.h"
>   
> +#define VFIO_CCW_OFFSET_SHIFT   40
> +#define VFIO_CCW_OFFSET_TO_INDEX(off)	(off >> VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_INDEX_TO_OFFSET(index)	((u64)(index) << VFIO_CCW_OFFSET_SHIFT)
> +#define VFIO_CCW_OFFSET_MASK	(((u64)(1) << VFIO_CCW_OFFSET_SHIFT) - 1)
> +

Why is the offset shift 40? I know vfio-pci is also using the same 
offset shift, but I am curious about the reasoning behind why we are 
using this? :)
