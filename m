Received: from eggs.gnu.org ([2001:4830:134:3::10]:52137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duzDx-00083f-3e
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1duzDs-0001wS-95
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:00:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1duzDr-0001uP-W0
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:00:48 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8LB0HeY024187
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 07:00:45 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d4bwb90dg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 07:00:42 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 21 Sep 2017 12:00:39 +0100
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170921112459.0153cc64.cohuck@redhat.com>
	<8abd41f8-e3fd-682f-1669-a5c3870c32fd@linux.vnet.ibm.com>
	<20170921124824.5f613e26.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 21 Sep 2017 13:00:34 +0200
MIME-Version: 1.0
In-Reply-To: <20170921124824.5f613e26.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <eb64f78a-bf78-e453-228a-75f131f238d2@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] 3270 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



On 09/21/2017 12:48 PM, Cornelia Huck wrote:
> On Thu, 21 Sep 2017 12:22:30 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
>> On 09/21/2017 11:24 AM, Cornelia Huck wrote:
>>> On Wed, 20 Sep 2017 19:23:12 +0200
>>> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
>>>   
>>>> Jason found some problems with 3270 which he traced down to insufficient
>>>> output buffer size. I've looked into the underlying issue (and the
>>>> relevant code) and I saw strange things. Among others an unreasonable
>>>> assert requiring the payload of a ccw being less than some more or
>>>> less arbitrary limit (dictated by the size of the output buffer).
>>>>
>>>> Because we were already considering converting 3270 to CcwDataStream I've
>>>> decided to try do get rid of this strange limitation on the length of the
>>>> writes too. 
>>>>
>>>> This series depends on my IDA work, which can be found here:
>>>> https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg03434.html.
>>>>
>>>> Halil Pasic (2):
>>>>   s390x/3270: IDA support for 3270 via CcwDataStream
>>>>   s390x/3270: handle writes of arbitrary length
>>>>
>>>>  hw/char/terminal3270.c      | 46 +++++++++++++++++++++++++++------------------
>>>>  hw/s390x/3270-ccw.c         |  4 ++--
>>>>  include/hw/s390x/3270-ccw.h |  5 ++---
>>>>  3 files changed, 32 insertions(+), 23 deletions(-)
>>>>  
>>>
>>> Are you planning to do some further work on 3270, btw?
>>>   
>>
>> I did not. I jumped in because of IDA, and because I did
>> not agree with increasing the buffer size to another arbitrary
>> an value (and essentially keep the bug). I hope the original
>> authors will do further polishing.
> 
> That was actually a plural 'you' (a pity that English uses the same
> word for both...)
> 

OK, I've projected it to myself.

>>
>> I'm just curious, what's behind the question?
> 
> Just whether I can expect more 3270 changes in the future :) Things
> like support for multiple devices, whatever. Mostly curiousity.
> 

Actually, I wanted to ask the same question from the guy
responsible for the answer. I don't know yet, but I'm sure
now I want to ask (Stefan R.). I will let you know later.

Halil
