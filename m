Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321DAC3F68F
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A6C12468D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 14:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6C12468D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwS1S-0008JU-71
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 09:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iwS0o-0007fF-H5
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iwS0n-000578-BX
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 09:38:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iwS0n-00056P-3f; Tue, 28 Jan 2020 09:38:41 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00SEaRqT066617; Tue, 28 Jan 2020 09:38:39 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xtmstn70k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 09:38:39 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00SEaqH5068472;
 Tue, 28 Jan 2020 09:38:38 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xtmstn6yb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 09:38:38 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00SEZihu012380;
 Tue, 28 Jan 2020 14:38:37 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma01dal.us.ibm.com with ESMTP id 2xrda6rhp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jan 2020 14:38:37 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00SEcan448562450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jan 2020 14:38:36 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 341FFC605B;
 Tue, 28 Jan 2020 14:38:36 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 284D2C6062;
 Tue, 28 Jan 2020 14:38:35 +0000 (GMT)
Received: from [9.56.58.87] (unknown [9.56.58.87])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jan 2020 14:38:35 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
To: Cornelia Huck <cohuck@redhat.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <20200127124756.3627f754.cohuck@redhat.com>
 <1cbd5354-d9ca-a10e-0053-a61a00223f53@linux.ibm.com>
 <20200127183504.2de2654f.cohuck@redhat.com>
 <a4bfb688-3641-6c31-ad7b-e72afd5e6d50@linux.ibm.com>
 <20200128122418.7533f4bb.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Organization: IBM
Message-ID: <ac8e9782-e95a-b11a-7749-faaa020ca94f@linux.ibm.com>
Date: Tue, 28 Jan 2020 09:38:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200128122418.7533f4bb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-28_03:2020-01-28,
 2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280117
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/28/20 6:24 AM, Cornelia Huck wrote:
> On Mon, 27 Jan 2020 18:05:36 -0500
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 1/27/20 12:35 PM, Cornelia Huck wrote:
>>> On Mon, 27 Jan 2020 11:39:02 -0500
>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>   
>>>> On 1/27/20 6:47 AM, Cornelia Huck wrote:  
>>>>> On Fri, 24 Jan 2020 17:14:04 -0500
>>>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>>>     
>>
>> [...]
>>
>>>>>>
>>>>>> The availability of this instruction is determined by byte 134, bit 0
>>>>>> of the Read Info block. This coincidentally expands into the space used    
>>>>>
>>>>> "SCLP Read Info"
>>>>>     
>>>>>> for CPU entries by taking away one byte, which means VMs running with
>>>>>> the diag318 capability will not be able to retrieve information regarding
>>>>>> the 248th CPU. This will not effect performance, and VMs can still be
>>>>>> ran with 248 CPUs.    
>>>>>
>>>>> Are there other ways in which that might affect guests? I assume Linux
>>>>> can deal with it? Is it ok architecture-wise?
>>>>>
>>>>> In any case, should go into the patch description :)
>>>>>     
>>>>
>>>> Same as above. I'll try to provide more information regarding what happens
>>>> here in my next reply.  
>>>
>>> I think you can lift some stuff from the cover letter.
>>>   
>>
>> Here's what I found out:
>>
>> Each CPU entry holds info regarding the CPU's address / ID as well as an 
>> indication of the availability of certain CPU features. With these patches,
>> we lose a CPU entry for one CPU (essentially what would be the CPU at the
>> tail-end of the list). This CPU exists, but is essentially in limbo... the
>> machine cannot access any information regarding it.
> 
> s/machine/guest/ ?
> 

Correct.

>>
>> So, a VM can run with the original N max CPUs, but in reality we can only
>> utilize n-1. 
> 
> s/we/the guest/ ?
> 

Correct again.

> With those changes, it makes sense to put your explanations into the
> patch description (for later reference).
> 
>>
>>>>  
>>>>>>  
>>
>> [...]
>>
>>
> 
> 


-- 
Respectfully,
- Collin Walling

