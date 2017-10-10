Received: from eggs.gnu.org ([2001:4830:134:3::10]:56499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1t1s-0006tW-8H
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:48:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e1t1p-000770-4o
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:48:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39282
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e1t1o-00076o-V3
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 07:48:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9ABmjns113571
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:48:49 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgt5qupr8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 07:48:49 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 10 Oct 2017 12:48:35 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
	<da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
	<0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
	<20171010133923.081f7d23.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 13:48:31 +0200
MIME-Version: 1.0
In-Reply-To: <20171010133923.081f7d23.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <45ba0e4d-7091-a7c1-5662-b63c7d6b72b9@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 10/10/2017 01:39 PM, Cornelia Huck wrote:
> On Tue, 10 Oct 2017 12:28:35 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 09.10.2017 17:00, Halil Pasic wrote:
>>>
>>>
>>> On 10/09/2017 01:07 PM, Thomas Huth wrote:  
> 
>>>> Then, in the follow up patches, you do something like this:
>>>>
>>>>    return (IOInstEnding){.cc = 0};
>>>>
>>>> ... and that just looks very, very ugly in my eyes. The more I look at  
>>>
>>> Interesting, I found this quite expressive.  
>>
>> C'mon, we're writing C code, not Java ;-)
> 
> Every time I read that construct, I die a little bit inside...
> 
>> Well, you already gave a description in your comment in the  struct
>> IOInstEnding, so maybe something similar? Or maybe this could even be
>> merged with the definitions for the SIGP status codes:
>>
>> #define SIGP_CC_ORDER_CODE_ACCEPTED 0
>> #define SIGP_CC_STATUS_STORED       1
>> #define SIGP_CC_BUSY                2
>> #define SIGP_CC_NOT_OPERATIONAL     3
> 
> I'd rather not reuse the definitions for a different instruction, even
> if they are similar in semantics.
> 
>>> Sorry, I may be a bit to persistent on this one: I don't think it's
>>> a huge difference, but I don't feel great about changing something to
>>> what I think is (slightly) worse without being first convinced that
>>> I was wrong.  
>>
>> In the end, the code has to be accepted by the maintainers, so let's
>> leave the decision up to them whether they like this typedef struct
>> IOInstEnding or not...
> 
> Here's a strong 'do not like' from me... using an enum or define is
> fine with me.
> 

Got the message. Could we first reach an agreement on the rest of the
series? As I've said, I might need to go back to indicating exceptions
too (depending on how do we like #3), and that would mean a changed
situation. If the price for getting this in is sacrificing my strongly
type checked condition code type I can live with that.

Halil
t
