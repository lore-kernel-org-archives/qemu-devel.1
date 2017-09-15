Received: from eggs.gnu.org ([2001:4830:134:3::10]:37112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsqBG-0001id-Ka
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:57:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dsqBB-0005zV-Kx
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:57:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dsqBB-0005yU-Ci
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:57:09 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8FCt933059586
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:57:07 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d0cq47svv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:57:07 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Fri, 15 Sep 2017 08:57:05 -0400
References: <cover.1505403478.git.alifm@linux.vnet.ibm.com>
	<b9b4d8a8c1d17bf3f086b120fdf04c925da0f331.1505403478.git.alifm@linux.vnet.ibm.com>
	<ee7ba6d5-b97a-cf3d-9190-21e97628d51a@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Fri, 15 Sep 2017 08:57:02 -0400
MIME-Version: 1.0
In-Reply-To: <ee7ba6d5-b97a-cf3d-9190-21e97628d51a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <261ebc51-4523-5656-a3a9-95b439b2e05e@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, kraxel@redhat.com, cohuck@redhat.com



On 09/15/2017 03:40 AM, Thomas Huth wrote:
> On 14.09.2017 17:55, Farhan Ali wrote:
>> Wire up the virtio-gpu device for the CCW bus. The virtio-gpu
>> is a virtio-1 device, so disable revision 0.
>>
>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  hw/s390x/virtio-ccw.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/s390x/virtio-ccw.h | 10 ++++++++++
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
Thanks for the review :)
