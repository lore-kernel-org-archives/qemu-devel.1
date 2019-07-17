Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD5DC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:53:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6B012173E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 12:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B012173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnjQo-0000zv-6c
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 08:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hnjQd-0000Zo-Bj
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hnjQc-0004Z6-0r
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:53:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:2558
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hnjQb-0004X5-RG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 08:53:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6HCpPJm054218
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:53:00 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tt0pn1fp5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 08:53:00 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
 Wed, 17 Jul 2019 13:52:59 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 17 Jul 2019 13:52:56 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6HCqtsb52036062
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jul 2019 12:52:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19D8AAC05B;
 Wed, 17 Jul 2019 12:52:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D69E0AC059;
 Wed, 17 Jul 2019 12:52:54 +0000 (GMT)
Received: from [9.60.89.78] (unknown [9.60.89.78])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jul 2019 12:52:54 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
References: <20190708125433.16927-1-cohuck@redhat.com>
 <20190708125433.16927-2-cohuck@redhat.com>
 <58b28817-58e5-1cba-6f71-a35093be5cb6@de.ibm.com>
 <0dd71cfe-a9e9-7ac3-523e-065f05479a57@linux.ibm.com>
 <20190710102041.6be31940.cohuck@redhat.com>
 <20190716172002.77863317.cohuck@redhat.com>
 <f72fb90b-8383-a2f8-b768-b09be5845fb5@linux.ibm.com>
 <20190717105435.64047ca3.cohuck@redhat.com>
 <e0bd4df3-4f25-ee02-ecdd-7306b3b14250@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 17 Jul 2019 08:52:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <e0bd4df3-4f25-ee02-ecdd-7306b3b14250@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19071712-2213-0000-0000-000003B23E9D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011445; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01233450; UDB=6.00649930; IPR=6.01014775; 
 MB=3.00027759; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-17 12:52:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071712-2214-0000-0000-00005F47D2AA
Message-Id: <60169464-240f-d5e3-209f-9c5371ee3e6f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-17_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907170155
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH for-4.1 1/2] s390x/pci: add
 some fallthrough annotations
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
Cc: David Hildenbrand <david@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 5:27 AM, Christian Borntraeger wrote:
> 
> 
> On 17.07.19 10:54, Cornelia Huck wrote:
>> On Tue, 16 Jul 2019 14:34:22 -0400
>> Collin Walling <walling@linux.ibm.com> wrote:
>>
>>> On 7/16/19 11:20 AM, Cornelia Huck wrote:
>>>> On Wed, 10 Jul 2019 10:20:41 +0200
>>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>>    
>>>>> On Tue, 9 Jul 2019 18:55:34 -0400
>>>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>>>   
>>>>>> On 7/8/19 9:23 AM, Christian Borntraeger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 08.07.19 14:54, Cornelia Huck wrote:
>>>>>>>> According to the comment, the bits are supposed to accumulate.
>>>>>>>>
>>>>>>>> Reported-by: Stefan Weil <sw@weilnetz.de>
>>>>>>>> Fixes: 5d1abf234462 ("s390x/pci: enforce zPCI state checking")
>>>>>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>>>>>
>>>>>>> This patch does not change behaviour, so it is certainly not wrong.
>>>>>>>
>>>>>>> So lets have a look at if the bug report was actually a real bug or
>>>>>>> just a missing annotation.
>>>>>>>         
>>>>>>>> ---
>>>>>>>>     hw/s390x/s390-pci-inst.c | 2 ++
>>>>>>>>     1 file changed, 2 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>>>>>>>> index 61f30b8e55d2..00235148bed7 100644
>>>>>>>> --- a/hw/s390x/s390-pci-inst.c
>>>>>>>> +++ b/hw/s390x/s390-pci-inst.c
>>>>>>>> @@ -1209,8 +1209,10 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
>>>>>>>>          * FH Enabled bit is set to one in states of ENABLED, BLOCKED or ERROR. */
>>>>>>>>         case ZPCI_FS_ERROR:
>>>>>>>>             fib.fc |= 0x20;
>>>>>>>> +        /* fallthrough */
>>>>>>>
>>>>>>> This is correct, in case of an error we are also blocked.
>>>>>>>         
>>>>>>
>>>>>> Agreed. This is definitely correct based on our architecture.
>>>>>>       
>>>>>>>>         case ZPCI_FS_BLOCKED:
>>>>>>>>             fib.fc |= 0x40;
>>>>>>>> +        /* fallthrough */
>>>>>>>
>>>>>>> I think this is also correct, but  it would be good if Collin could verify.
>>>>>>>         
>>>>>>
>>>>>> I failed to find anything to support setting the function control
>>>>>> enabled bit when the function state is in error / blocked. I'm
>>>>>> assuming this might be some QEMU hack to get things working? I'll have
>>>>>> to dive further to understand why this was done this way, as it doesn't
>>>>>> align with how the s390x architecture is documented. It's confusing.
>>>>>
>>>>> Might this also be a real issue? Not matching the architecture is not a
>>>>> good sign...
>>>>
>>>> Friendly ping. If we still want to have this patch or a fix in 4.1, we
>>>> need to find out soon...
>>>>    
>>>
>>> Let's take it for now.
>>>
>>> Acked-by: Collin Walling <walling@linux.ibm.com>
>>>
>>
>> Just to be clear: You think that the current code is correct AFAYCS?
>   
> I also looked into this again.
> There is a possibility to also be in disabled state.
>  From what I can see, it makes sense that blocked and error belong to the enable state
> so the patch seems correct.
> 

Yes I agree. The material I referenced required me to look over a few
times and ask around a bit. The patch is good. Apologies for my
ambiguous response.


