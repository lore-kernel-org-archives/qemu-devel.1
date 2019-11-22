Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2BEC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:52:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F021D20718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 13:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F021D20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY9M6-0003on-4c
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 08:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56735)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iY9IU-0001fn-Gg
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iY9IT-0007IE-7v
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:48:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iY9IT-0007HY-0H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 08:48:29 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xAMDlCXH006083
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:48:27 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wdu63k7cm-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 08:48:27 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Fri, 22 Nov 2019 13:48:24 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Fri, 22 Nov 2019 13:48:22 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xAMDmK0S49873018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Nov 2019 13:48:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DDB8052051;
 Fri, 22 Nov 2019 13:48:20 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.30.219])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 70F5C5204E;
 Fri, 22 Nov 2019 13:48:20 +0000 (GMT)
Subject: Re: [PATCH 09/15] s390x: protvirt: SCLP interpretation
To: Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20191120114334.2287-1-frankja@linux.ibm.com>
 <20191120114334.2287-10-frankja@linux.ibm.com>
 <20191121151118.4caa8523.cohuck@redhat.com>
 <509daeba-7c4f-0514-6122-fadbe65776a1@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri, 22 Nov 2019 14:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <509daeba-7c4f-0514-6122-fadbe65776a1@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19112213-0012-0000-0000-0000036ACAFC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112213-0013-0000-0000-000021A6638E
Message-Id: <1eff4ef5-432c-ad99-ce25-410350d34376@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-22_02:2019-11-21,2019-11-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=801 phishscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911220123
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: thuth@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-21 15:24, Janosch Frank wrote:
> On 11/21/19 3:11 PM, Cornelia Huck wrote:
>> On Wed, 20 Nov 2019 06:43:28 -0500
>> Janosch Frank <frankja@linux.ibm.com> wrote:
>>
>>> SCLP for a protected guest is done over the SIDAD, so we need to use
>>> the s390_cpu_virt_mem_* functions to access the SIDAD instead of guest
>>> memory when reading/writing SCBs.
>>>
>>> To not confuse the sclp emulation, we set 0x42000 as the address, but
>>> ignore it for reading/writing the SCCB.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>   hw/s390x/sclp.c         | 16 ++++++++++++++++
>>>   include/hw/s390x/sclp.h |  2 ++
>>>   target/s390x/kvm.c      |  8 +++++++-
>>>   3 files changed, 25 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>> index f57ce7b739..00d08adc7f 100644
>>> --- a/hw/s390x/sclp.c
>>> +++ b/hw/s390x/sclp.c
>>> @@ -193,6 +193,22 @@ static void sclp_execute(SCLPDevice *sclp, SCCB *sccb, uint32_t code)
>>>       }
>>>   }
>>>   
>>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>> +                                uint32_t code)
>>> +{
>>> +    SCLPDevice *sclp = get_sclp_device();
>>> +    SCLPDeviceClass *sclp_c = SCLP_GET_CLASS(sclp);
>>> +    SCCB work_sccb;
>>> +    hwaddr sccb_len = sizeof(SCCB);
>>> +
>>> +    s390_cpu_virt_mem_read(env_archcpu(env), 0, 0, &work_sccb, sccb_len);
>>> +    sclp_c->execute(sclp, &work_sccb, code);
>>> +    s390_cpu_virt_mem_write(env_archcpu(env), 0, 0, &work_sccb,
>>> +                            be16_to_cpu(work_sccb.h.length));
>>> +    sclp_c->service_interrupt(sclp, sccb);
>>> +    return 0;
>>> +}
>>> +
>>>   int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>>   {
>>>       SCLPDevice *sclp = get_sclp_device();
>>> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
>>> index c54413b78c..c0a3faa37d 100644
>>> --- a/include/hw/s390x/sclp.h
>>> +++ b/include/hw/s390x/sclp.h
>>> @@ -217,5 +217,7 @@ void s390_sclp_init(void);
>>>   void sclp_service_interrupt(uint32_t sccb);
>>>   void raise_irq_cpu_hotplug(void);
>>>   int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code);
>>> +int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>> +                                uint32_t code);
>>>   
>>>   #endif
>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>> index 58251c0229..0f2458b553 100644
>>> --- a/target/s390x/kvm.c
>>> +++ b/target/s390x/kvm.c
>>> @@ -1172,7 +1172,13 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
>>>       sccb = env->regs[ipbh0 & 0xf];
>>>       code = env->regs[(ipbh0 & 0xf0) >> 4];
>>>   
>>> -    r = sclp_service_call(env, sccb, code);
>>> +    if (run->s390_sieic.icptcode == ICPT_PV_INSTR ||
>>> +        run->s390_sieic.icptcode == ICPT_PV_INSTR_NOT) {
>>> +        r = sclp_service_call_protected(env, 0x42000, code);
>> I fear that confuses the reader instead of the emulation :)
>>
>> Especially as you end up passing that value to
>> sclp_c->service_interrupt()...
> Pierre has some more opinions on that, so I'll let him present his
> planned changes to this patch :)


Hum, sorry but I can not present any thing at the moment.
I will study the problem, it will take some time.


>
>>> +    } else {
>>> +        r = sclp_service_call(env, sccb, code);
>>> +    }
>>> +
>>>       if (r < 0) {
>>>           kvm_s390_program_interrupt(cpu, -r);
>>>       } else {
>
-- 
Pierre Morel
IBM Lab Boeblingen


