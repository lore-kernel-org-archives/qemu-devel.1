Received: from eggs.gnu.org ([2001:4830:134:3::10]:32936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9QQV-0007la-Db
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f9QQS-0007qx-A9
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41012
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f9QQS-0007p1-46
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:25:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3K7OHg1084857
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:25:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hf76b2kss-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:25:42 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 20 Apr 2018 08:25:41 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-3-git-send-email-thuth@redhat.com>
	<0be89209-6ee5-2f12-fae2-21709fcf6f8a@de.ibm.com>
	<7ebf0874-1b70-47e4-fce6-15566887270f@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 20 Apr 2018 09:25:37 +0200
MIME-Version: 1.0
In-Reply-To: <7ebf0874-1b70-47e4-fce6-15566887270f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <552d8ee4-665d-f6da-9fa2-f645582fa19a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.13 2/4] pc-bios/s390-ccw/net: Stop
 virtio-net device before jumping into the OS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Collin Walling <walling@linux.ibm.com>



On 04/20/2018 08:31 AM, Thomas Huth wrote:
> On 19.04.2018 17:49, Christian Borntraeger wrote:
>> On 04/18/2018 02:31 PM, Thomas Huth wrote:
>>> The virtio-net receive buffers are filled asynchronously, so we should
>>> make sure to properly shut down the virtio-net device before we jump into
>>> the loaded kernel. Otherwise an incoming packet could destroy memory of
>>> the OS kernel if it did not re-initialize the virtio-net device fast
>>> enough yet.
>>
>> The normal bios does a full subsystem reset before we enter the OS.
>> (see jump_to_IPL_code the diag 308). That should reset all virtio 
>> devices on the qemu level. Shouldnt we rather do the same for
>> the net bios?
> 
> That should fix this issue, too, right. I'll give it a try and include
> it in v2 if I can make it work...

The advantage is that it also put the sclp console into a default state.
> 
>  Thomas
> 
