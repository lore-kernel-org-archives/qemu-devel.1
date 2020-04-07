Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F306BC2BB54
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA7A02078C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 10:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA7A02078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLlQ8-0000LN-1O
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 06:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <farman@linux.ibm.com>) id 1jLlJI-0005aD-4t
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:18:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <farman@linux.ibm.com>) id 1jLlJG-0001jZ-Ni
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 06:18:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32319
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <farman@linux.ibm.com>)
 id 1jLlJG-0001j9-IR; Tue, 07 Apr 2020 06:18:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 037A3YxJ072314; Tue, 7 Apr 2020 06:18:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 308q7m0t6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2020 06:18:21 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 037A4Erk075822;
 Tue, 7 Apr 2020 06:18:21 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 308q7m0t5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2020 06:18:21 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 037AEv5j001341;
 Tue, 7 Apr 2020 10:18:19 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26]) by ppma01dal.us.ibm.com with ESMTP id 306hv6d1mq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2020 10:18:19 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 037AIJqp14680870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Apr 2020 10:18:19 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03E07124054;
 Tue,  7 Apr 2020 10:18:19 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79B80124052;
 Tue,  7 Apr 2020 10:18:18 +0000 (GMT)
Received: from [9.160.96.56] (unknown [9.160.96.56])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue,  7 Apr 2020 10:18:18 +0000 (GMT)
Subject: Re: [RFC PATCH v2 1/7] vfio-ccw: Return IOINST_CC_NOT_OPERATIONAL for
 EIO
To: Cornelia Huck <cohuck@redhat.com>
References: <20200206214509.16434-1-farman@linux.ibm.com>
 <20200206214509.16434-2-farman@linux.ibm.com>
 <20200324180430.3597ca94.cohuck@redhat.com>
 <20200325032428.11dd27a2.pasic@linux.ibm.com>
 <20200401105258.3e885efb.cohuck@redhat.com>
 <06a9fc5c-be2d-f152-de61-e815d7454692@linux.ibm.com>
 <20200407082851.5cc3655a.cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Message-ID: <ce0580ad-da65-54da-ecb5-3ab49c0a7cbd@linux.ibm.com>
Date: Tue, 7 Apr 2020 06:18:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200407082851.5cc3655a.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-04-07_01:2020-04-07,
 2020-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070082
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 4/7/20 2:28 AM, Cornelia Huck wrote:
> On Mon, 6 Apr 2020 14:21:17 -0400
> Eric Farman <farman@linux.ibm.com> wrote:
> 
>> On 4/1/20 4:52 AM, Cornelia Huck wrote:
>>> On Wed, 25 Mar 2020 03:24:28 +0100
>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>   
>>>> On Tue, 24 Mar 2020 18:04:30 +0100
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>  
>>>>> On Thu,  6 Feb 2020 22:45:03 +0100
>>>>> Eric Farman <farman@linux.ibm.com> wrote:
>>>>>     
>>>>>> From: Farhan Ali <alifm@linux.ibm.com>
>>>>>>
>>>>>> EIO is returned by vfio-ccw mediated device when the backing
>>>>>> host subchannel is not operational anymore. So return cc=3
>>>>>> back to the guest, rather than returning a unit check.
>>>>>> This way the guest can take appropriate action such as
>>>>>> issue an 'stsch'.    
>>>>
>>>> I believe this is not the only situation when vfio-ccw returns
>>>> EIO, or?
>>>>  
>>>>>>
>>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>>> Signed-off-by: Eric Farman <farman@linux.ibm.com>
>>>>>> ---
>>>>>>
>>>>>> Notes:
>>>>>>     v1->v2: [EF]
>>>>>>      - Add s-o-b
>>>>>>      - [Seems the discussion on v1 centered on the return code
>>>>>>        set in the kernel, rather than anything that needs to
>>>>>>        change here, unless I've missed something.]    
>>>>
>>>> Does this need to change here? If the kernel is supposed to return ENODEV
>>>> then this does not need to change.
>>>>  
>>>>>
>>>>> I've stared at this and at the kernel code for some time again; and I'm
>>>>> not sure if "return -EIO == not operational" is even true. That said,
>>>>> I'm not sure a unit check is the right response, either. The only thing
>>>>> I'm sure about is that the kernel code needs some review of return
>>>>> codes and some documentation...    
>>>>
>>>> I could not agree more, this is semantically uapi and needs to be
>>>> properly documented.
>>>>
>>>> With regards to "linux error codes: vs "ionist cc's" an where
>>>> the mapping is different example:
>>>>
>>>> """
>>>> /**                                                                             
>>>>  * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt        
>>>>  * and clear ordinally if subchannel is valid.                                  
>>>>  * @sch: subchannel on which to perform the cancel_halt_clear operation         
>>>>  * @iretry: the number of the times remained to retry the next operation        
>>>>  *                                                                              
>>>>  * This should be called repeatedly since halt/clear are asynchronous           
>>>>  * operations. We do one try with cio_cancel, three tries with cio_halt,        
>>>>  * 255 tries with cio_clear. The caller should initialize @iretry with          
>>>>  * the value 255 for its first call to this, and keep using the same            
>>>>  * @iretry in the subsequent calls until it gets a non -EBUSY return.           
>>>>  *                                                                              
>>>>  * Returns 0 if device now idle, -ENODEV for device not operational,            
>>>>  * -EBUSY if an interrupt is expected (either from halt/clear or from a         
>>>>  * status pending), and -EIO if out of retries.                                 
>>>>  */                                                                             
>>>> int cio_cancel_halt_clear(struct subchannel *sch, int *iretry)   
>>>>
>>>> """
>>>> Here -ENODEV is not operational.  
>>>
>>> Ok, I went through the kernel code and checked which error may be
>>> returned in which case (hope I caught all of them). Here's what I
>>> currently have:  
>>
>> Thanks for doing all this mapping!
>>
>>>
>>> diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
>>> index fca9c4f5bd9c..43f375a03cce 100644
>>> --- a/Documentation/s390/vfio-ccw.rst
>>> +++ b/Documentation/s390/vfio-ccw.rst

...snip...

>>>
>>> The other return codes look sane, and the return codes for the async
>>> region also seem sane (but have the same issue with -EIO == "device in
>>> wrong state").
>>>
>>> Looking at the QEMU handling, I think the -EIO handling is a bit
>>> questionable (without an obvious solution), while mapping -EBUSY to cc
>>> 2 is the only reasonable thing to do given that the interface does not
>>> differentiate between "busy" and "status pending". The rest seems sane.
>>>   
>>
>> So maybe with all this data, and absent a better solution, it's best to
>> just drop this patch from v3?
> 
> Yes, I agree. I'll post the documentation update as a separate patch.
> 

Sounds good; thanks!

