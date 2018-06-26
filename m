Received: from eggs.gnu.org ([2001:4830:134:3::10]:60353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXjkR-0002gS-Le
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fXjkP-0006Nz-3B
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:54:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50384
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fXjkO-0006Ng-Tc
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:54:49 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5Q8s8eC032952
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 04:54:48 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2jugf25113-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 04:54:47 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 26 Jun 2018 09:54:45 +0100
References: <20180622194736.GA5794@roeck-us.net>
	<126ac556-0602-b927-58f5-cb5f65a5e0ec@de.ibm.com>
	<88d9afed-f91d-c320-13c8-9a93fc52b700@de.ibm.com>
	<20180625100548.64222dad.cohuck@redhat.com>
	<d56829a3-fecf-b812-d002-8ee22ae08da2@de.ibm.com>
	<20180626102954.73965b42.cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 26 Jun 2018 10:54:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180626102954.73965b42.cohuck@redhat.com>
Content-Language: en-US
Message-Id: <8617698e-0d1a-15d8-7e6d-e63408857b1c@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] s390 qemu boot failure in -next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>



On 06/26/2018 10:29 AM, Cornelia Huck wrote:
[...]
>>>>  
>>>>          if (ipl->initrd) {
>>>>              ram_addr_t initrd_offset;
>>>>
>>>> would put the command line in no matter what the start address is.  
>>>
>>> I'm for putting that one in (and backporting it to qemu-stable). It's a
>>> bit worrying, though, that our ipl code is so fragile...  
>>
>> We actually have to combine this with Thomas fix (to check for rom_ptr returning
>> something sane). It seems that ipl->commandline is always there, so we have to
>> check for strlen!=0 it seems..
>>
>> I mean if somebody ask for "-append something" we can certainly always write something
>> if there is rom/ram.
> 
> Given that the uncompressed image is not supposed to be bootable
> anymore, does it make sense to add this anyway?

I think we can drop this patch for now.

> 
> I'll go ahead and queue Thomas' fix, though.

yes, please
