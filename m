Received: from eggs.gnu.org ([2001:4830:134:3::10]:45358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRjUP-00044N-AU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gRjUK-0006PP-5I
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:57:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gRjUJ-0006PC-Sm
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 14:57:40 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wARJtZEA015550
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:57:38 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p18y39g9d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:57:38 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Tue, 27 Nov 2018 19:57:37 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Tue, 27 Nov 2018 14:57:31 -0500
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-4-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d7084481-b638-e128-eb91-49911882e39e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
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
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 565669f95534..c01472ec77ea 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -304,6 +304,7 @@ struct vfio_region_info_cap_type {
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
>   
> +

Whitespace error?

>   #define VFIO_REGION_TYPE_GFX                    (1)
>   #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
>   
> @@ -354,6 +355,9 @@ struct vfio_region_gfx_edid {
>   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
>   };
>   
> +/* ccw sub-types */
> +#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> +
