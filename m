Received: from eggs.gnu.org ([2001:4830:134:3::10]:49215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gZ0pl-0005wN-FU
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 16:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1gZ0pg-0004TZ-Fr
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 16:53:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54530
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1gZ0pg-0004S2-9T
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 16:53:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBHLrkxo049433
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:53:46 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pehwenfnq-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 16:53:45 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 17 Dec 2018 21:53:40 -0000
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 17 Dec 2018 16:53:34 -0500
MIME-Version: 1.0
In-Reply-To: <20181122165432.4437-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <d3442c5d-06e9-d87a-3bc3-903f40b0cedf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>



On 11/22/2018 11:54 AM, Cornelia Huck wrote:

...snip...

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 813102810f53..565669f95534 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -297,6 +297,7 @@ struct vfio_region_info_cap_type {
>   
>   #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
>   #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> +#define VFIO_REGION_TYPE_CCW			(1 << 30)

Oof.  So the existing VFIO_REGION_TYPE_PCI_VENDOR_TYPE gets OR'd with 
another value (e.g., 8086).  But in 4.20, there was a 
VFIO_REGION_TYPE_GFX is added as simply "1" ... Which direction are 
these definitions being added from?  I guess asked another way, is 
_TYPE_CCW going to be OR'd with anything else that necessitates its 
presence as an identifier with some Other Thing, or should this follow 
the TYPE_GFX enumeration?  Perhaps the type field needs to be tidied up 
to help this sit more cleanly now?  (Sorry!)

  - Eric

>   
>   /* 8086 Vendor sub-types */
>   #define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
> 
