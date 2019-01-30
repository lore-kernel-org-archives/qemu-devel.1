Received: from eggs.gnu.org ([209.51.188.92]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gowE4-0001tC-A2
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:12:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gowE2-0004jQ-7g
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:12:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54386
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gowE0-0004bo-8o
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 15:12:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UK9JYC051550
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:12:30 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qbj0d2231-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 15:12:29 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 30 Jan 2019 20:12:29 -0000
Reply-To: jjherne@linux.ibm.com
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-2-git-send-email-jjherne@linux.ibm.com>
	<20190130175647.6a99ed62.cohuck@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 30 Jan 2019 15:12:24 -0500
MIME-Version: 1.0
In-Reply-To: <20190130175647.6a99ed62.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <06d8afc1-15bd-c229-e719-c26dfadcb934@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 01/15] s390 vfio-ccw: Add bootindex
 property and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On 1/30/19 11:56 AM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 08:29:08 -0500
> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> 
>> Add bootindex property and iplb data for vfio-ccw devices. This allows us to
>> forward boot information into the bios for vfio-ccw devices.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/ipl.c              | 14 ++++++++++++++
>>   hw/s390x/s390-ccw.c         |  9 +++++++++
>>   hw/vfio/ccw.c               | 13 +------------
>>   include/hw/s390x/s390-ccw.h |  1 +
>>   include/hw/s390x/vfio-ccw.h | 38 ++++++++++++++++++++++++++++++++++++++
>>   5 files changed, 63 insertions(+), 12 deletions(-)
>>   create mode 100644 include/hw/s390x/vfio-ccw.h
> 
>> diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
>> new file mode 100644
>> index 0000000..a7d699d
>> --- /dev/null
>> +++ b/include/hw/s390x/vfio-ccw.h
>> @@ -0,0 +1,38 @@
>> +/*
>> + * vfio based subchannel assignment support
>> + *
>> + * Copyright 2018 IBM Corp.
> 
> Why 2018? Should either be 2017 (the original date for hw/vfio/ccw.c)
> or 2019.
> 

Okay. I will fix it.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
