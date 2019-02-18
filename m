Received: from eggs.gnu.org ([209.51.188.92]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvoHG-0004pk-Ma
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.ibm.com>) id 1gvoHF-0003i2-W5
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:08:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43420
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.ibm.com>)
	id 1gvoHE-0003el-9z
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 14:08:28 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1IJ3xa0138016
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:08:25 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qr1tya94t-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 14:08:25 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.ibm.com>;
	Mon, 18 Feb 2019 19:08:24 -0000
References: <1550512800-9922-1-git-send-email-akrowiak@linux.ibm.com>
From: Tony Krowiak <akrowiak@linux.ibm.com>
Date: Mon, 18 Feb 2019 14:08:16 -0500
MIME-Version: 1.0
In-Reply-To: <1550512800-9922-1-git-send-email-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b712101f-49dd-0ba7-0e8e-f90e4c34dbee@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] s390x/vfio-ap: hot plug/unplug
 vfio-ap device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, pmorel@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, fiuczy@linux.ibm.com

On 2/18/19 12:59 PM, Tony Krowiak wrote:


PLEASE IGNORE THIS PATCH SERIES. A v3 VERSION IS FORTHCOMING. VERSION
v2 has already been posted and reviewed.

> This patch series introduces hot plug/unplug of a vfio-ap device.
> 
> A vfio-ap device can be hot plugged only if:
> 
> 1. The guest does not yet have a vfio-ap device (only one is allowed
>     per guest)
> 
> 2. The guest was started with the following CPU model features enabled:
>     * ap=on
>     * apft=on
> 
> To hot plug a vfio-ap device, the QEMU device_add function may be used:
> 
>     (qemu) device_add vfio-ap,sysfsdev=$path-to-mdev
> 
>     Where $path-to-mdev is the absolute path to the mediated matrix device
>     to be used to configure the guest's AP device matrix.
> 
> A vfio-ap device can be hot unplugged only if:
> 
> 1. The guest was started with a vfio-ap device configured for it:
> 
>     -device vfio-ap,sysfsdev=$path-to-mdev
> 
> 2. The guest was started with the following CPU model features enabled:
>     * ap=on
> 
> Tony Krowiak (2):
>    s390x/vfio-ap: Implement hot plug/unplug of vfio-ap device
>    s390x/vfio-ap: document hot plug/unplug of vfio-ap device
> 
>   docs/vfio-ap.txt     | 58 +++++++++++++++++++++++++++++++++++++++++++++++-----
>   hw/s390x/ap-bridge.c | 12 ++++++++++-
>   hw/vfio/ap.c         |  2 +-
>   3 files changed, 65 insertions(+), 7 deletions(-)
> 
