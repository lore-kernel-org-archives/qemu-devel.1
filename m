Received: from eggs.gnu.org ([2001:4830:134:3::10]:45232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOXDe-0000uT-Jx
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:10:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eOXDa-00031e-FU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:10:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47250
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eOXDa-000317-9H
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 18:10:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBBN6ZLh043911
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 18:10:35 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2et0fmgvn1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 18:10:35 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 11 Dec 2017 23:10:33 -0000
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<2ada83cf-1eb6-87c0-7597-13dc11ab09c0@redhat.com>
	<e48d0ac7-4431-dcce-4eb4-0d6863006575@redhat.com>
	<20171207125313.1a5d1c5e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 12 Dec 2017 00:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <20171207125313.1a5d1c5e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <e5aa927d-72f6-3f74-c3c4-5d40308844a6@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH v2 0/3] tests for CCW IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 12/07/2017 12:53 PM, Cornelia Huck wrote:
> On Thu, 7 Dec 2017 10:01:35 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 07.12.2017 07:38, Thomas Huth wrote:
>>> On 08.11.2017 17:54, Halil Pasic wrote:  
>>>> I've keept the title althogh the scope shifted a bit: it's
>>>> more about introducing ccw-testdev than about IDA. The goal
>>>> is to facilitate testing the virtual channel subsystem
>>>> implementation, and the ccw interpretation.
>>>>
>>>> The first patch is the interesting one. See it's cover letter
>>>> for details. The RFC is about discussing some technical issues
>>>> with this patch.
>>>>
>>>> The other two patches are an out of source kernel module which
>>>> is basically only there so you can try out the first patch. The
>>>> tests there should probably be ported to something else. I don't
>>>> know what: maybe kvm-unit-tests, maybe qtest+libqos, or maybe some
>>>> bios based test image. We still have to figure out that.   
>>>
>>> I think both, kvm-unit-tests or qtest+libqos would be good candidates.
>>> Please don't invent a new bios base test image, since kvm-unit-tests
>>> should be very similar already and we really don't need to duplicate
>>> work here.
>>>
>>> Anyway, you'd need to add some CSS infracture there first (in both
>>> kvm-unit-tests and the qtest environments), so it's likely a similar
>>> amount of work. qtest has the advantage that it gets checked
>>> automatically during "make check" each time, so I'd have a weak
>>> preference for that one.  
>>
>> Another thought: I'd also like to see the more complex virtio device
>> qtests enabled for virtio-ccw one day (e.g. tests/virtio-blk-test.c), so
>> I think we sooner or later should have some CSS infrastructure in the
>> qtests anyway ==> May I suggest that you have a try with the qtest approach?
> 
> Agreed, this would be helpful to get more ccw coverage in general.
> 

Yeah qtest+libqos does seem like the most likely candidate. We
are likely to go down this path. I say we, because it seems likely
that the guest counterpart with the unit test suite is going to
be done by somebody having more time to invest into this.

Regards,
Halil
