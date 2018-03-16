Received: from eggs.gnu.org ([2001:4830:134:3::10]:40850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewrfp-00018f-EJ
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:53:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1ewrfk-0006Cl-U9
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:53:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1ewrfk-0006CA-L1
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:53:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GFqCXo057249
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:53:35 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grdtb8pwb-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:53:34 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 09:53:33 -0600
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
	<fe9a2f52-6833-df90-b2e9-96e8db047904@linux.vnet.ibm.com>
	<b3ffd5a5-4bf2-c620-9bf6-6e1404d9ab54@linux.vnet.ibm.com>
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 11:53:23 -0400
MIME-Version: 1.0
In-Reply-To: <b3ffd5a5-4bf2-c620-9bf6-6e1404d9ab54@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <41e3c19a-0be4-4926-2c76-c04198c8fa18@linux.vnet.ibm.com>
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
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net

On 03/16/2018 11:36 AM, Halil Pasic wrote:
>
> On 03/16/2018 04:29 PM, Tony Krowiak wrote:
>>>> However it is a general switch for the VM.
>>>> It looks strange to have this inside the realize callback
>>>>
>>> I kind of semi agree.
>>>
>>> The previous solution (having this transparent for QEMU) had
>>> benefits. Why did we move away from that again?
>> This was done to address the multitude of objections and opinions related to
>> how/when/where ECA_APIE is set. Pierre summed it up best with his comment "we
>> need to separate the CPU feature defining 'if AP instructions are available'
>> from the QEMU property defining 'How we provide the instructions'. I agree and
>> this is how I chose to implement that.
> It's even more separated if the one is controlled via a
> userspace facing interface (cpu models) and the other
> is controlled via an in-kernel interface (e.g. like
> done previously in vfio open AFAIR).
There were objections to that.
>
> I can not accept this answer. I don't recall the multitude
> and I think I've showed that the 'need to separate' argument
> does not work.
I suppose it depends upon how you define multitude. I counted at
at least 11 - actually more - review comments related to the
CPU model feature and setting ECA_APIE. I suggest you go back
and look at the thread.

Where did you show that the 'need to separate' argument does
not work?
>
> Regards,
> Halil
