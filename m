Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6899DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A9692078E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A9692078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrJ2-0000X9-1T
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46160)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jkrI2-0008P4-Kv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:44:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40568)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1jkrI0-0005fr-7d
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:44:50 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FFW2Zv022396
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:44:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31n42kanbh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:44:46 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FFWTs1025084
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 11:44:46 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31n42kanb4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:44:46 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FFZAhM024056;
 Mon, 15 Jun 2020 15:44:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma02wdc.us.ibm.com with ESMTP id 31mpe8bjms-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 15:44:45 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FFiib847382848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 15:44:44 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B677F2805C;
 Mon, 15 Jun 2020 15:44:44 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D61528059;
 Mon, 15 Jun 2020 15:44:43 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2020 15:44:43 +0000 (GMT)
Subject: Re: [PATCH v2 2/5] tpm: Extend TPMIfClass with get_irqnum() function
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20200615142327.671546-1-stefanb@linux.vnet.ibm.com>
 <20200615142327.671546-3-stefanb@linux.vnet.ibm.com>
 <CAMxuvayUv9zpnzW93pcQXCFpFX5BZ7ZSRNvJ_XRgLPiyjfa_pQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9bd4cd70-1e0a-68be-fb83-9604cd7aba12@linux.ibm.com>
Date: Mon, 15 Jun 2020 11:44:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAMxuvayUv9zpnzW93pcQXCFpFX5BZ7ZSRNvJ_XRgLPiyjfa_pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_06:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 cotscore=-2147483648 adultscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150123
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Stefan Berger <stefanb@sbct-2.pok.ibm.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 "Bonzini, Paolo" <pbonzini@redhat.com>,
 Philippe Mathieu Daude <philmd@redhat.com>,
 Marek Kedzierski <mkedzier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 11:11 AM, Marc-André Lureau wrote:
> Hi
>
> On Mon, Jun 15, 2020 at 6:23 PM Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> From: Stefan Berger <stefanb@sbct-2.pok.ibm.com>
>>
>> Implement get_irqnum() as part of the TPMIfClass to be get the assigned
> ^^ to get
>
>> IRQ number.
>>
> Since it is TIS ISA specific (at least for now), perhaps a dedicated
> tpm_tis_get_irq_num() is more appropriate?


There's no caller from ARM at the moment but at least it is preparing it 
to support getting the IRQ number since it also allows passing it in via 
command lie. So it wouldn't have any side-effects on ARM for as long as 
no extra code was added there. And once sysbus was to use it, it would 
funnel through the same tpm_get_irqnum code. Other option is to drop the 
parts for sysbus entirely.


>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   hw/tpm/tpm_tis_isa.c    |  9 +++++++++
>>   hw/tpm/tpm_tis_sysbus.c |  9 +++++++++
>>   include/sysemu/tpm.h    | 10 ++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
>> index 30ba37079d..63b62f4c21 100644
>> --- a/hw/tpm/tpm_tis_isa.c
>> +++ b/hw/tpm/tpm_tis_isa.c
>> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_isa_get_tpm_version(TPMIf *ti)
>>       return tpm_tis_get_tpm_version(s);
>>   }
>>
>> +static uint8_t tpm_tis_isa_get_irqnum(TPMIf *ti)
>> +{
>> +    TPMStateISA *isadev = TPM_TIS_ISA(ti);
>> +    TPMState *s = &isadev->state;
>> +
>> +    return s->irq_num;
>> +}
>> +
>>   static void tpm_tis_isa_reset(DeviceState *dev)
>>   {
>>       TPMStateISA *isadev = TPM_TIS_ISA(dev);
>> @@ -148,6 +156,7 @@ static void tpm_tis_isa_class_init(ObjectClass *klass, void *data)
>>       dc->reset = tpm_tis_isa_reset;
>>       tc->request_completed = tpm_tis_isa_request_completed;
>>       tc->get_version = tpm_tis_isa_get_tpm_version;
>> +    tc->get_irqnum = tpm_tis_isa_get_irqnum;
>>   }
>>
>>   static const TypeInfo tpm_tis_isa_info = {
>> diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
>> index eced1fc843..6cf45e5057 100644
>> --- a/hw/tpm/tpm_tis_sysbus.c
>> +++ b/hw/tpm/tpm_tis_sysbus.c
>> @@ -80,6 +80,14 @@ static enum TPMVersion tpm_tis_sysbus_get_tpm_version(TPMIf *ti)
>>       return tpm_tis_get_tpm_version(s);
>>   }
>>
>> +static uint8_t tpm_tis_sysbus_get_irqnum(TPMIf *ti)
>> +{
>> +    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(ti);
>> +    TPMState *s = &sbdev->state;
>> +
>> +    return s->irq_num;
>> +}
>> +
>>   static void tpm_tis_sysbus_reset(DeviceState *dev)
>>   {
>>       TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(dev);
>> @@ -137,6 +145,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
>>       dc->reset = tpm_tis_sysbus_reset;
>>       tc->request_completed = tpm_tis_sysbus_request_completed;
>>       tc->get_version = tpm_tis_sysbus_get_tpm_version;
>> +    tc->get_irqnum = tpm_tis_sysbus_get_irqnum;
>>   }
>>
>>   static const TypeInfo tpm_tis_sysbus_info = {
>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>> index 03fb25941c..b94a8a2b16 100644
>> --- a/include/sysemu/tpm.h
>> +++ b/include/sysemu/tpm.h
>> @@ -41,6 +41,7 @@ typedef struct TPMIfClass {
>>       enum TpmModel model;
>>       void (*request_completed)(TPMIf *obj, int ret);
>>       enum TPMVersion (*get_version)(TPMIf *obj);
>> +    uint8_t (*get_irqnum)(TPMIf *obj);
>>   } TPMIfClass;
>>
>>   #define TYPE_TPM_TIS_ISA            "tpm-tis"
>> @@ -74,4 +75,13 @@ static inline TPMVersion tpm_get_version(TPMIf *ti)
>>       return TPM_IF_GET_CLASS(ti)->get_version(ti);
>>   }
>>
>> +static inline uint8_t tpm_get_irqnum(TPMIf *ti)
>> +{
>> +    if (!ti || !TPM_IF_GET_CLASS(ti)->get_irqnum) {
>> +        return 0;
>> +    }
>> +
>> +    return TPM_IF_GET_CLASS(ti)->get_irqnum(ti);
>> +}
>> +
>>   #endif /* QEMU_TPM_H */
>> --
>> 2.24.1
>>


