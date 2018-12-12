Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX6Ll-0000HW-8g
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX6Lf-0007xo-Lg
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:23:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47892
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gX6Lf-0007xI-Da
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:22:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBCFEVmx002579
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:22:54 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2pb4cm1w1p-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:22:54 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 12 Dec 2018 15:22:53 -0000
Reply-To: jjherne@linux.ibm.com
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-2-git-send-email-jjherne@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 12 Dec 2018 10:22:45 -0500
MIME-Version: 1.0
In-Reply-To: <1544623878-11248-2-git-send-email-jjherne@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <2eb74ef9-4513-8bde-610f-9ab6451a44d1@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 01/15] s390 vfio-ccw: Add
 bootindex property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, Farhan Ali <alifm@linux.ibm.com>, borntraeger@de.ibm.com, Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>

On 12/12/18 9:11 AM, Jason J. Herne wrote:
> ...
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 9246729..6f480c6 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -20,23 +20,12 @@
>   #include "hw/sysbus.h"
>   #include "hw/vfio/vfio.h"
>   #include "hw/vfio/vfio-common.h"
> +#include "hw/vfio/ccw.h"

Oops #1: This should be:
+ #include "hw/s390x/vfio-ccw.h"

Will fix for v2.

>   #include "hw/s390x/s390-ccw.h"
>   #include "hw/s390x/ccw-device.h"
>   #include "exec/address-spaces.h"
>   #include "qemu/error-report.h"
> 

 > ...
> diff --git a/roms/SLOF b/roms/SLOF
> index 9b7ab2f..2317427 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 9b7ab2fa020341dee8bf9df6c9cf40003e0136df
> +Subproject commit 2317427ce76006723f7ae103a6998ab41dd79c68

Oops #2: This snuck into the patch unexpectedly. Removed for v2.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
