Received: from eggs.gnu.org ([2001:4830:134:3::10]:51518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5YN9-00019o-51
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e5YN6-0007GM-1P
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:34:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e5YN5-0007Fn-P3
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 10:33:59 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9KEUnkK104087
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:33:55 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dqe5q76mg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 10:33:54 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 20 Oct 2017 15:33:52 +0100
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<711b1e41-693a-de7d-9c13-fbe0f964c53c@linux.vnet.ibm.com>
	<20171020150043.383b2117.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 20 Oct 2017 16:33:47 +0200
MIME-Version: 1.0
In-Reply-To: <20171020150043.383b2117.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c17eb441-f22b-2e92-dd39-01c3caddec19@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/20/2017 03:00 PM, Cornelia Huck wrote:
> On Thu, 19 Oct 2017 18:39:37 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/15/2017 09:27 AM, Cornelia Huck wrote:
>>>>>     
>>>>>> +    DEFINE_PROP_UINT8("chpid_type", CcwTesterDevice, chpid_type,
>>>>>> +                       0x98),  
>>> This might also need re-evaluation - we should not really need a new
>>> chpid type.
>>>   
>>
>> I'm back at ccw-tester again (for v2). I've realized we did not agree
>> on what to use here (chpid_type). Shall I use 0x25 (Fibre Channel) or
>> EMULATED_CCW_3270_CHPID_TYPE, or even 0x32 (virtio-ccw) as a default
>> value? And should EMULATED_CCW_3270_CHPID_TYPE be called like that
>> (is it really supposed to be specific to 3270?
>>
>> Sorry I did not notice sooner.
> 
> It might make sense to pick whatever z/VM commonly uses for emulated
> devices. (Or ask them if they reserved something explicitly for testing
> -- that would be an even better match.)
> 

OK, I will approach the z/VM guys. About EMULATED_CCW_3270_CHPID_TYPE,
does it really make sense to have a separate chpid type for 3270? (You
have missed that question, so I'm asking it again).

Halil
