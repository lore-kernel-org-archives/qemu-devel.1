Received: from eggs.gnu.org ([2001:4830:134:3::10]:56377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4RXH-0001CP-O0
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e4RX5-0007xK-2o
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:03:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e4RX4-0007wd-P2
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:03:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9HD2Ehg100776
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 09:03:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dnen1jwsv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 09:03:36 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 17 Oct 2017 14:03:34 +0100
References: <20171004154144.88995-1-pasic@linux.vnet.ibm.com>
	<20171004154144.88995-3-pasic@linux.vnet.ibm.com>
	<d6d2d73d-65c9-7ae1-fd37-cb8e304781e7@redhat.com>
	<7f454872-fae3-35b0-eff4-227b2aa0f77d@linux.vnet.ibm.com>
	<6c17b274-cd75-7864-94b9-fc8abff1a786@redhat.com>
	<da4228cb-d32c-dc77-0a80-bac306f07c24@linux.vnet.ibm.com>
	<0120aa4c-ffce-79c0-8c87-c7c1100232eb@redhat.com>
	<9d77c8e9-f875-4e42-5306-b847904b4a47@linux.vnet.ibm.com>
	<39f9e450-d618-6c4d-9401-031c5374ed88@redhat.com>
	<2b90291e-62a8-964f-286a-d8f1594b2d94@linux.vnet.ibm.com>
	<0ade56a2-046a-6525-f19d-8febebcfde03@linux.vnet.ibm.com>
	<eef3b6ca-5d4a-115e-3fad-1a76c00bc3be@redhat.com>
	<20171017141352.3b2f7cd8.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 17 Oct 2017 15:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <20171017141352.3b2f7cd8.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <7968a82e-fc9b-6b41-d8a9-86182c645904@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v2 2/8] s390x/css: IO instr
 handler ending control
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



On 10/17/2017 02:13 PM, Cornelia Huck wrote:
> On Tue, 17 Oct 2017 13:28:57 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 17.10.2017 13:10, Halil Pasic wrote:
>>>
>>>
>>> On 10/12/2017 01:44 PM, Halil Pasic wrote:  
>>>>
>>>>
>>>> On 10/12/2017 08:58 AM, Thomas Huth wrote:  
>>>>> On 10.10.2017 13:41, Halil Pasic wrote:  
>>> [..]  
>>>>> So yes, please don't do a "typedef unsigned int IOInstEnding" either. I
>>>>> think the best match for QEMU would be a
>>>>>
>>>>> typedef enum IOInstEnding {
>>>>>     CC_...,
>>>>>     CC_...,
>>>>>     CC_...,
>>>>>     CC_...
>>>>> } IOInstEnding;
>>>>>  
>>>>
>>>> I also prefer this over #define NAME val.
>>>>  
>>>
>>> @Conny @Thomas
>>>
>>> I'm almost done with v3, but I've realized we did not agree on the
>>> names for the enum constants, so before posting something to ugly
>>> again, I would like to inquire your opinion.
>>>
>>> My current version of the enum is the following (but I can easily change
>>> to whatever you like with sed):
>>>
>>> +/*
>>> + * IO instructions conclude according this. Currently we have only
>>> + * cc codes. Valid values are 0,1,2,3 and the generic semantic for IO instructions
>>> + * is described briefly. For more details consult the PoP.
>>> + */
>>> +typedef enum IOInstEnding {
>>> +    IOINST_CC_0 = 0, /* produced expected result */
>>> +    IOINST_CC_1 = 1, /* status conditions were present, or alternate result */
>>> +    IOINST_CC_2 = 2, /* ineffective, busy with previously initiated function */
>>> +    IOINST_CC_3 = 3  /* ineffective, not operational */
>>> +} IOInstEnding;
>>> +
>>>
>>> Alternatives I had in mind are IOINST_CC_0_EXPECTED, IOINST_CC_1_STATUS_PRESENT, 
>>> IOINST_CC_2_BUSY, IOINST_CC_3_NOT_OPERATIONAL or the same without the numerical
>>> code (e.g. just IONIST_CC_EXPECTED).  
>>
>> FWIW, I'd prefer your last suggestion (e.g. IOINST_CC_EXPECTED).
> 
> Either IOINST_CC_0 or IOINST_CC_EXPECTED, whatever you like best.
> 

Thanks, I will go with the non-numerical variant as preferred by
Thomas (I've already changed my patches).
