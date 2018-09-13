Received: from eggs.gnu.org ([2001:4830:134:3::10]:51208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1g0Smm-0007QD-Ja
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:40:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1g0Smj-0003RQ-9w
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:40:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1g0Smj-0003R2-1y
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:39:57 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8DEdoST014367
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 10:39:55 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mfppygsvt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 10:39:51 -0400
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 13 Sep 2018 08:39:32 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
	<7e74ef35-e925-30d9-b81d-33fa5a9ce468@redhat.com>
	<74536138-61d8-3003-c5cc-360e9ecc9d67@linux.ibm.com>
	<ce0d3b85-91ab-81ed-2469-866d97b58a99@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu, 13 Sep 2018 10:39:25 -0400
MIME-Version: 1.0
In-Reply-To: <ce0d3b85-91ab-81ed-2469-866d97b58a99@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cb5aa71d-0fa6-1450-0a75-dec18dc42065@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 08/15] s390-bios: Map low core
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 09/13/2018 01:25 AM, Thomas Huth wrote:
> On 2018-09-10 16:17, Jason J. Herne wrote:
>> On 07/17/2018 02:10 PM, Thomas Huth wrote:
>>> On 05.07.2018 19:25, Jason J. Herne wrote:
>>>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
...
>>>
>>> The names of the fields look exactly the same as in the Linux kernel ...
>>> maybe credit them at least in the patch description?
>>
>> Due to some internal issues and bug hunting this has been on the back
>> burner for a while. Getting back into it now...
>>
>> I took lowcore from Qemu code, not the kernel. target/s390x/internal.h.
> 
> Ok, fair, then never mind.
> 
> Just another thought: We've got a couple of structs and defines already
> that we share between the s390-ccw bios and the "normal" QEMU code ...
> maybe we should define a common set of headers that could be used by
> both parts? And put these in includes/hw/s390x/ and let the s390-ccw
> bios code include headers from that folder, too? Or would that be too
> confusing and we better should keep everything separated (and duplicated)?
> 
>   Thomas
> 
> 

I originally thought the same thing. But the issue is that we already 
duplicate a fair amount code and headers from Qemu for the bios. SCLP, 
most i/o routines, some basic machine level stuff, etc. I'd like to see 
a cleanup effort to consolidate this code, but I feel like it would be 
far too much for this patch set.

-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
