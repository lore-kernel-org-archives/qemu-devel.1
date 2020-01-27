Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F05C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:53:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5B321739
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 18:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5B321739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw9W2-0007qG-Kh
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 13:53:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47824)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <walling@linux.ibm.com>) id 1iw9VH-0007Lm-4r
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1iw9VF-0004Ce-Tu
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 13:52:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12290)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1iw9VF-0004C2-LM; Mon, 27 Jan 2020 13:52:53 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00RInlHc135640; Mon, 27 Jan 2020 13:52:51 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrgvmaasw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 13:52:51 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 00RIpjJN140380;
 Mon, 27 Jan 2020 13:52:51 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2xrgvmaas4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 13:52:51 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 00RIlldU004545;
 Mon, 27 Jan 2020 18:52:50 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28]) by ppma01dal.us.ibm.com with ESMTP id 2xrda6g842-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jan 2020 18:52:50 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
 [9.57.199.109])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 00RIqn7p54067698
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jan 2020 18:52:49 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A3A1112061;
 Mon, 27 Jan 2020 18:52:49 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DF5D112064;
 Mon, 27 Jan 2020 18:52:49 +0000 (GMT)
Received: from [9.56.58.87] (unknown [9.56.58.87])
 by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jan 2020 18:52:49 +0000 (GMT)
Subject: Re: [PATCH v6 2/2] s390: diagnose 318 info reset and migration support
From: Collin Walling <walling@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <1579904044-20790-1-git-send-email-walling@linux.ibm.com>
 <1579904044-20790-3-git-send-email-walling@linux.ibm.com>
 <380c4902-e67d-0aff-103d-18815b221ac4@redhat.com>
 <11435889-57d6-ed0b-d410-2f715324a20e@linux.ibm.com>
 <899b67fb-a337-c30d-e250-42399276fe38@redhat.com>
 <20200127182942.4071f54f.cohuck@redhat.com>
 <f6708858-78ea-06d1-427f-704c09e75b3a@redhat.com>
 <6d735fe2-5cf8-32da-982d-95af5151eca8@linux.ibm.com>
Organization: IBM
Message-ID: <96145c69-cead-2bf8-07b3-10989121588d@linux.ibm.com>
Date: Mon, 27 Jan 2020 13:52:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6d735fe2-5cf8-32da-982d-95af5151eca8@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-01-27_06:2020-01-24,
 2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270149
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/27/20 1:21 PM, Collin Walling wrote:
> On 1/27/20 12:55 PM, David Hildenbrand wrote:
>> On 27.01.20 18:29, Cornelia Huck wrote:
>>> On Mon, 27 Jan 2020 18:09:11 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>>>> +static void s390_diag318_reset(DeviceState *dev)
>>>>>>> +{
>>>>>>> +    if (kvm_enabled())
>>>>>>> +        kvm_s390_set_diag318_info(0);
>>>>>>> +}
>>>>>>> +
>>>>>>> +static void s390_diag318_class_init(ObjectClass *klass, void *data)
>>>>>>> +{
>>>>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>>>>> +
>>>>>>> +    dc->reset = s390_diag318_reset;
>>>>>>> +    dc->vmsd = &vmstate_diag318;
>>>>>>> +    dc->hotpluggable = false;
>>>>>>> +    /* Reason: Created automatically during machine instantiation */
>>>>>>> +    dc->user_creatable = false;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const TypeInfo s390_diag318_info = {
>>>>>>> +    .class_init = s390_diag318_class_init,
>>>>>>> +    .parent = TYPE_DEVICE,
>>>>>>> +    .name = TYPE_S390_DIAG318,
>>>>>>> +    .instance_size = sizeof(DIAG318State),
>>>>>>> +};
>>>>>>> +
>>>>>>> +static void s390_diag318_register_types(void)
>>>>>>> +{
>>>>>>> +    type_register_static(&s390_diag318_info);
>>>>>>> +}  
>>>>>>
>>>>>> Do we really need a new device? Can't we simply glue that extended state
>>>>>> to the machine state?
>>>>>>  
>>>>>> -> target/s390x/machine.c  
>>>>>>  
>>>>>
>>>>> Those VM States relate to the CPU state... does it make sense to store the
>>>>> diag318 info in a CPU state? (It doesn't seem necessary to store / migrate
>>>>> this info for each CPU).  
>>>>
>>>> I'm sorry, I was looking at the wrong file ...
>>>>
>>>>>
>>>>> Should we store this in the S390CcwMachineState? Or perhaps create a generic
>>>>> S390MachineState for information that needs to be stored once and migrated
>>>>> once?  
>>>>
>>>> ... I actually thought we have something like this already. Personally,
>>>> I think that would make sense. At least spapr seems to have something
>>>> like this already (hw/ppc/spapr.c:spapr_machine_init().
>>>>
>>>> @Conny?
>>>
>>> What are you referring to? I only see the one with the FIXME in front
>>> of it...
>>
>> That's the one I mean. The fixme states something about qdev ... but
>> AFAIK that's only applicable if TYPE_DEVICE is involved. So maybe right
>> now there is no other way than registering the vmstate directly.
>>
> 
> Hmm okay. I'll take a look at how spapr does it. I think I've registered a
> vmstate via register_savevm_live() in an earlier version, but had difficulties
> figuring out where to store the data. I'll revisit this approach.
> 
> Thanks for the feedback!
> 

Err perhaps not entirely in this manner...

docs/devel/migration.rst declares the register_savevm_live() function as the
"legacy way" of doing things. I'll have to see how other VMStateDescriptions
are modeled. I think vmstate_register() is what I want.

Sorry for the confusion.

-- 
Respectfully,
- Collin Walling

