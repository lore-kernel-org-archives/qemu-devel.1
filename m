Received: from eggs.gnu.org ([2001:4830:134:3::10]:57209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEGjs-00051a-Kr
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEGjn-0003BX-HA
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:05:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fEGjn-0003B3-5U
	for qemu-devel@nongnu.org; Thu, 03 May 2018 12:05:43 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43G4r9M076243
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 12:05:42 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hr4kvk6tf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 12:05:41 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 3 May 2018 10:05:41 -0600
References: <20180502125221.4877-1-cohuck@redhat.com>
	<cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
	<20180503174412.359494fb.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 3 May 2018 12:05:28 -0400
MIME-Version: 1.0
In-Reply-To: <20180503174412.359494fb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5baae3f1-07ff-3ba0-fb83-81e0eb9a0240@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/03/2018 11:44 AM, Cornelia Huck wrote:
> On Thu, 3 May 2018 11:25:08 -0400
> Farhan Ali <alifm@linux.ibm.com> wrote:
> 
>> On 05/02/2018 08:52 AM, Cornelia Huck wrote:
>>> We currently pass an integer as the subcode parameter. However,
>>> the upper bits of the register containing the subcode need to
>>> be 0, which is not guaranteed unless we explicitly specify the
>>> subcode to be an unsigned long value.
>>>
>>> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
>>> Cc:qemu-stable@nongnu.org
>>> Signed-off-by: Cornelia Huck<cohuck@redhat.com>
>>
>> Sorry for my ignorance, but is there a C standard that says upper bits
>> of an int is not guaranteed to be 0?
> 
> The value (5 resp. 6) is small enough to fit into a regular integer,
> and the compiler generated a lhi for the load, which did not change any
> upper values that might have been in the register previously. Telling
> the compiler to treat the value as an unsigned long makes it generate a
> lghi.
> 

This makes sense now. Thanks for the explanation :)
