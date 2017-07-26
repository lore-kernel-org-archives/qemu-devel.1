Received: from eggs.gnu.org ([2001:4830:134:3::10]:54838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1daPRT-0005EP-VB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1daPRO-0007uw-Vy
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:45:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1daPRO-0007ue-Gs
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 12:45:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6QGhtHJ038295
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:45:40 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bxshh9pkd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:45:40 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 26 Jul 2017 17:45:38 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v6QGjZax20513040
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 16:45:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73ADEAE04D
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 17:41:55 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BD4EAE045
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 17:41:55 +0100 (BST)
Received: from oc3836556865.ibm.com (unknown [9.152.224.141])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 17:41:55 +0100 (BST)
References: <20170725224442.13383-1-pasic@linux.vnet.ibm.com>
	<20170725224442.13383-2-pasic@linux.vnet.ibm.com>
	<20170726033121.GP7483@bjsdjshi@linux.vnet.ibm.com>
	<af44463e-9a90-d769-32d7-53e43852cb89@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 26 Jul 2017 18:45:34 +0200
MIME-Version: 1.0
In-Reply-To: <af44463e-9a90-d769-32d7-53e43852cb89@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7067811a-825b-adbb-78a9-5d06083f50ec@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/css: check ccw address validity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 07/26/2017 02:05 PM, Halil Pasic wrote:
> 
> 
> On 07/26/2017 05:31 AM, Dong Jia Shi wrote:
>> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-07-26 00:44:41 +0200]:
>>
>>> According to the PoP channel command words (CCW) must be doubleword
>>> aligned and 31 bit addressable for format 1 and 24 bit addressable for
>>> format 0 CCWs.
>>>
>>> If the channel subsystem encounters ccw address which does not satisfy
>>> this alignment requirement a program-check condition is recognised.
>>>
>>> The situation with 31 bit addressable is a bit more complicated: both the
>>> ORB and a format 1 CCW TIC hold the address of the (rest of) the channel
>>                                               ^^^^^^^^^^^^^^^^^^^^
>> Meant to be (?):
>> of the (rest of the)
> 
> Yes.
> 
>>
>> Maybe just saying:
>> the address of a channel probram
>>
> 
> "the rest of the channel program" was supposed to refer to the TIC scenario,
> and "the channel program" to ORB.
> 
>>> program, that is the address of the next CCW in a word, and the PoP
>>> mandates that bit 0 of that word shall be zero -- or a program-check
>>> condition is to be recognized -- and does not belong to the field holding
>>> the ccw address.
>>>
>>> Since in code the corresponding fields span across the whole word (unlike
>>> in PoP where these are defined as 31 bit wide) we can check this by
>>> applying a mask. The 24 addressable case isn't affecting TIC because the
>>> address is composed of a halfword and a byte portion (no additional zero
>>> bit requirements) and just slightly complicates the ORB case where also
>>> bits 1-7 need to be zero.
>>>
>>> Let's make our CSS implementation follow the AR more closely.
>>>
>>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> ---
>>> Note: Checking for 31 bit addressable ain't strictly necessary:
>>> According to the AR the all zero fields of the ORB may or may not be
>>> checked during the execution of SSCH. We do check the corresponding
>>> single bit field of the ORB and respond to it accordingly. Using
>>> the same mask for TIC and for ORB does not hurt.
>>> ---
>>>  hw/s390x/css.c | 18 ++++++++++++++++++
>>>  1 file changed, 18 insertions(+)
>>>
>>> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
>>> index 6a42b95cee..d17e21b7af 100644
>>> --- a/hw/s390x/css.c
>>> +++ b/hw/s390x/css.c
>>> @@ -24,6 +24,9 @@
>>>  #include "hw/s390x/s390_flic.h"
>>>  #include "hw/s390x/s390-virtio-ccw.h"
>>>
>>> +/* CCWs are doubleword aligned and addressable by 31 bit */
>>> +#define CCW1_ADDR_MASK 0x80000007
>>> +
>> Move this hunk to ioinst.h?
>>
>>>  typedef struct CrwContainer {
>>>      CRW crw;
>>>      QTAILQ_ENTRY(CrwContainer) sibling;
>>> @@ -885,6 +888,10 @@ static int css_interpret_ccw(SubchDev *sch, hwaddr ccw_addr,
>>>              ret = -EINVAL;
>>>              break;
>>>          }
>>> +        if (ccw.cda & CCW1_ADDR_MASK) {
>>> +            ret = -EINVAL;
>>> +            break;
>>> +        }
>>>          sch->channel_prog = ccw.cda;
>>>          ret = -EAGAIN;
>>>          break;
>>> @@ -946,6 +953,17 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
>>>          suspend_allowed = true;
>>>      }
>>>      sch->last_cmd_valid = false;
>>> +    if (sch->channel_prog & (CCW1_ADDR_MASK |
>>> +                             sch->ccw_fmt_1 ? 0 : 0xff000000)) {
>> I have problem in recognizing the operator precedence here:
>>     (CCW1_ADDR_MASK | sch->ccw_fmt_1 ? 0 : 0xff000000)
>>
>> Bitwise '|' has higher precedence than '?:', so the above equals to:
>>     (CCW1_ADDR_MASK | sch->ccw_fmt_1) ? 0 : 0xff000000
>>
>> So you will always get a '0', no?
>>
> 
> I'm afraid you are right. Good catch! This was supposed to be
> (CCW1_ADDR_MASK | (sch->ccw_fmt_1 ? 0 : 0xff000000))
> 
> 
>>> +            /* generate channel program check */
>>> +            s->ctrl &= ~SCSW_ACTL_START_PEND;
>>> +            s->cstat = SCSW_CSTAT_PROG_CHECK;
>>> +            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
>>> +            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
>>> +                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
>>> +            s->cpa = sch->channel_prog + 8;
>>> +            return;
>>> +    }
>> I think you could let css_interpret_ccw() do the sanity check on its
>> @ccw_addr parameter when (sch->last_cmd_valid == false), to reuse the
>> code of generating channel program check.
>>
> 
> I'm working on factoring out the code manipulating SCSW (among others). If we
> do that this will look nicer. What you propose is certainly viable, althoug
> maybe little less straight forward.
> 
> Yet another option would be to use a label and jump into the loop (AFAIR that
> would be also valid).
> 
> Let us see what is Connie's opinion.
> 

After re-examining the PoP I'm inclined to say we have to check this on every
iteration because of how "main-storage location is unavailable" is defined in
this context: the definition depends on the ccw format. There is nothing about
this in the ccw chaining section of the pop but it can be found in the
I/O interrupts chapter.

I think I will have to redo this patch :/

Regards,
Halil

> 
>>>      do {
>>>          ret = css_interpret_ccw(sch, sch->channel_prog, suspend_allowed);
>>>          switch (ret) {
>>> -- 
>>> 2.11.2
>>>
>>
> 
> 
