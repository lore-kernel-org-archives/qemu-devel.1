Received: from eggs.gnu.org ([2001:4830:134:3::10]:47847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewsBs-0004EJ-4i
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewsBo-000259-U2
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:26:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53728
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ewsBo-00024k-Ol
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 12:26:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GGQSMK081830
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:26:44 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2grej50q44-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 12:26:43 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 16:26:41 -0000
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
	<fe9a2f52-6833-df90-b2e9-96e8db047904@linux.vnet.ibm.com>
	<b3ffd5a5-4bf2-c620-9bf6-6e1404d9ab54@linux.vnet.ibm.com>
	<41e3c19a-0be4-4926-2c76-c04198c8fa18@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 17:26:36 +0100
MIME-Version: 1.0
In-Reply-To: <41e3c19a-0be4-4926-2c76-c04198c8fa18@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <29b474bd-bb95-f3d2-5ae9-859f6e81d4ec@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, qemu-s390x@nongnu.org, cohuck@redhat.com, heiko.carstens@de.ibm.com, agraf@suse.de, borntraeger@de.ibm.com, alex.williamson@redhat.com, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 03/16/2018 04:53 PM, Tony Krowiak wrote:
> On 03/16/2018 11:36 AM, Halil Pasic wrote:
>>
>> On 03/16/2018 04:29 PM, Tony Krowiak wrote:
>>>>> However it is a general switch for the VM.
>>>>> It looks strange to have this inside the realize callback
>>>>>
>>>> I kind of semi agree.
>>>>
>>>> The previous solution (having this transparent for QEMU) had
>>>> benefits. Why did we move away from that again?
>>> This was done to address the multitude of objections and opinions related to
>>> how/when/where ECA_APIE is set. Pierre summed it up best with his comment "we
>>> need to separate the CPU feature defining 'if AP instructions are available'
>>> from the QEMU property defining 'How we provide the instructions'. I agree and
>>> this is how I chose to implement that.
>> It's even more separated if the one is controlled via a
>> userspace facing interface (cpu models) and the other
>> is controlled via an in-kernel interface (e.g. like
>> done previously in vfio open AFAIR).
> There were objections to that.

AFAIR we agreed that keeping that interface is OK, but I may be wrong.
You being more specific that 'there were objections'  and 'multitude
of objections and opinions' would have been appreciated. But never
mind.

AFAIU Pierre is nagging you about this in the corresponding kernel
thread. I will let Pierre drive this discussion.

>>
>> I can not accept this answer. I don't recall the multitude
>> and I think I've showed that the 'need to separate' argument
>> does not work.
> I suppose it depends upon how you define multitude. I counted at
> at least 11 - actually more - review comments related to the
> CPU model feature and setting ECA_APIE. I suggest you go back
> and look at the thread.
> 
> Where did you show that the 'need to separate' argument does
> not work?

You answered to that part with 'There were objections to that'.
As I've said before never mind.

Halil
