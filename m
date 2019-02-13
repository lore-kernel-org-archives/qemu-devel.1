Received: from eggs.gnu.org ([209.51.188.92]:59116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gtws9-0000lz-9q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gtws1-0000wK-1t
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:54:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54580
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gtwrq-0000io-QV
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 10:54:36 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DFmvvc090557
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 10:54:27 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmn0mcb2d-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 10:54:27 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 13 Feb 2019 15:54:26 -0000
References: <20190212112323.15904-1-david@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 13 Feb 2019 10:54:23 -0500
MIME-Version: 1.0
In-Reply-To: <20190212112323.15904-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e36f47f0-04af-2677-184f-1bd8d8056076@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2] s390x: add zPCI feature to "qemu" CPU
 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

I noticed the qemu-iotests 200 was failing due to the commit
"703fef6fcf3 : s390x/pci: Warn when adding PCI devices without the 
'zpci' feature".

This patch fixes the failure :).

Thanks
Farhan

On 02/12/2019 06:23 AM, David Hildenbrand wrote:
> As we now always have PCI support, let's add it to the "qemu" CPU model,
> taking care of backwards compatibility.
> 
> Signed-off-by: David Hildenbrand<david@redhat.com>
> ---
> 
> v1 -> v2:
> - Use correct model identifiction of the z12 we emulate
> 
>   hw/s390x/s390-virtio-ccw.c  | 3 +++
>   target/s390x/gen-features.c | 8 ++++++--
>   2 files changed, 9 insertions(+), 2 deletions(-)
