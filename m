Received: from eggs.gnu.org ([209.51.188.92]:43233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gtxS4-0006LZ-IY
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:32:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1gtxS3-0000oK-81
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:32:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1gtxS3-0000lv-1Y
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 11:31:59 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DGVqc3155968
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 11:31:58 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qmpdh9cdu-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 11:31:49 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Wed, 13 Feb 2019 16:29:37 -0000
References: <20190212112323.15904-1-david@redhat.com>
	<e36f47f0-04af-2677-184f-1bd8d8056076@linux.ibm.com>
	<20190213172627.3b0a1ef0.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Wed, 13 Feb 2019 11:29:32 -0500
MIME-Version: 1.0
In-Reply-To: <20190213172627.3b0a1ef0.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <797e2c40-8cb5-3d18-d437-0a7844e0606b@linux.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>



On 02/13/2019 11:26 AM, Cornelia Huck wrote:
> On Wed, 13 Feb 2019 10:54:23 -0500
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> I noticed the qemu-iotests 200 was failing due to the commit
>> "703fef6fcf3 : s390x/pci: Warn when adding PCI devices without the
>> 'zpci' feature".
>>
>> This patch fixes the failure :).
> 
> Huh. So it was testing without pci before and now with and it's also
> working? Awesome :)

It was testing with pci, but the reason it fails was because qemu was 
spitting out the warning due to commit 703fef6fcf3. Now David's commit 
adds the zpci to qemu cpu model and qemu doesn't give out a warning message.
> 
>>
>> Thanks
>> Farhan
>>
>> On 02/12/2019 06:23 AM, David Hildenbrand wrote:
>>> As we now always have PCI support, let's add it to the "qemu" CPU model,
>>> taking care of backwards compatibility.
>>>
>>> Signed-off-by: David Hildenbrand<david@redhat.com>
>>> ---
>>>
>>> v1 -> v2:
>>> - Use correct model identifiction of the z12 we emulate
>>>
>>>    hw/s390x/s390-virtio-ccw.c  | 3 +++
>>>    target/s390x/gen-features.c | 8 ++++++--
>>>    2 files changed, 9 insertions(+), 2 deletions(-)
>>
> 
> 
