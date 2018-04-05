Received: from eggs.gnu.org ([2001:4830:134:3::10]:55017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f40YF-0007Hs-5t
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:47:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f40YC-0003CB-1s
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:47:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54064
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f40YB-0003Bs-SL
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:47:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w358hsgI098787
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 04:47:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h5g4d16tx-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 04:47:18 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 5 Apr 2018 09:47:16 +0100
References: <20180326092036.12780-1-david@redhat.com>
	<11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
	<01b7db2f-d3a7-f9b1-2e76-9f33107cff4c@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 5 Apr 2018 10:47:11 +0200
MIME-Version: 1.0
In-Reply-To: <01b7db2f-d3a7-f9b1-2e76-9f33107cff4c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <ce5e370a-3f39-71c2-3615-d7e9573a7cab@de.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH RFC] s390x/kvm: call
 cpu_synchronize_state() on every kvm_arch_handle_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>



On 04/05/2018 10:19 AM, Thomas Huth wrote:
> On 05.04.2018 09:53, Christian Borntraeger wrote:

>> So currently we only handle the case with base reg == 0 correctly.
>> So
>> diag x,y,0x500(0) 
>> works
>>
>>
>> but things like
>> lghi 1,0x500
>> diag x,y,0(1)
>>
>> not unless I miss something.
> 
> FWIW: Sounds like a good idea for a new kvm-unit-test... any volunteers?

It will require some special handling in the test as eventfd will handle diag
in the kvm kernel module most of the time. So such a test must have 2 pathes
with and without eventfd. As a virtio device we could simply use null-co or 
something like that.
