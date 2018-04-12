Received: from eggs.gnu.org ([2001:4830:134:3::10]:46757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f6e5x-0005PU-RF
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:25:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f6e5t-0005Am-B4
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:25:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45708
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f6e5t-0005AJ-5Y
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 11:25:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3CFOjWf015460
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:25:00 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ha79hh5qe-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 11:24:58 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Thu, 12 Apr 2018 11:24:53 -0400
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<3cb8a831-325e-2e1a-3dae-30864df27a75@linux.vnet.ibm.com>
	<20180409113244.380a32c4.cohuck@redhat.com>
	<1b0c08f8-c98c-c79c-574f-5c75229decf4@linux.vnet.ibm.com>
	<20180409125104.1103d650.cohuck@redhat.com>
	<ab2f7f24-2c97-943e-ca36-cc2561ef9119@linux.vnet.ibm.com>
	<067a35b6-3eeb-313b-b4ed-685078953f0b@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Thu, 12 Apr 2018 11:24:46 -0400
MIME-Version: 1.0
In-Reply-To: <067a35b6-3eeb-313b-b4ed-685078953f0b@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <ba5eb796-0ba5-6ca3-b222-1e28dcea0e9a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, alex.williamson@redhat.com, eskultet@redhat.com, David Hildenbrand <david@redhat.com>, peter.maydell@linaro.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 04/11/2018 09:50 AM, Halil Pasic wrote:
>
> On 04/11/2018 03:20 PM, Tony Krowiak wrote:
>>>>> I may be all wrong, though... can we at least have a translation of
>>>>> ECA.28 and EECA.28 (the "ap is there" bit and the "ap instructions are
>>>>> interpreted" bit?)
>>>>>     
>>>> I think we have a misunderstanding here. I will wait for Tony. Maybe
>>>> he can understand this better or explain in more accessible way.
>>>   From what I get from your explanation, this approach sounds like a good
>>> way forward. But let's wait for Tony.
>> I agree, this solves the problem with specifying installing AP facilities
>> on the guest (-cpu xxx,ap=on) and not configuring a vfio-ap device
>> (-device vfio-ap,sysfsdev=$path-to-mediated-device).
>>
>> To recap:
>> The realize() function for the vfio-ap device opens the mediated matrix
>> device file descriptor to set up the communication pathway with the vfio_ap
>> kernel driver. When the fd is opened, the vfio_ap driver sets ECA.28 for the
>> guest to instruct SIE to interpret AP instructions. The driver also
>> configures the AP matrix for the guest in its SIE state description. Consequently,
>> if a vfio-ap device is not configured for the guest, but AP facilities are
>> installed, all AP instructions will be intercepted and routed to QEMU. If there
>> are no interception handlers for the AP instructions, QEMU injects an operation
>> exception into the guest. This results in initialization of the AP bus on the
>> guest to terminate. This patch was intended to circumvent that problem.
>>
>> With Halil's suggestion, there is no need to provide these handlers. If ECA.28
>> is set for the guest by default when the AP facilities are installed, then the AP
>> instructions will be interpreted and the AP bus will get initialized on the
>> guest. Since there is no vfio-ap device to provide the AP matrix configuration
>> for the guest, the AP bus will not detect any devices, but that's okay. AP
>> instructions targeting at an APQN will execute successfully and set a response
>> code in the status block returned from the instruction indicating the
>> APQN is invalid .... but there will be no exception unless there is truly
>> an exception condition caused by the execution of the instruction.
> That's exactly the idea, but it will only work out this way if the effective
> ECA.28 bit (i.e. EECA.28) is also set.
>
> Could you please comment the first paragraph quoted in this email?
See my response to Connie's comment in Message ID 
<20180409113244.380a32c4.cohuck@redhat.com>.
My response is in Message ID 
<17b4ab9b-a8c7-37ec-bae4-c57b146ba0b8@linux.vnet.ibm.com>.
>
> Halil
