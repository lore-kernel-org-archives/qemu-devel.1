Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A61C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F8020768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F8020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6jl-00051o-6G
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jo6j8-00046I-RO; Wed, 24 Jun 2020 10:50:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jo6j6-0006ln-PV; Wed, 24 Jun 2020 10:50:14 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05OEWb9G027966; Wed, 24 Jun 2020 10:50:06 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uwymsja6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 10:50:06 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OEWqq5028589;
 Wed, 24 Jun 2020 10:50:05 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31uwymsj7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 10:50:04 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OEaB8T018530;
 Wed, 24 Jun 2020 14:50:00 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma03wdc.us.ibm.com with ESMTP id 31uus1cnw0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2020 14:50:00 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05OEnxDR27263410
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Jun 2020 14:49:59 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29F7E7805C;
 Wed, 24 Jun 2020 14:49:59 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23ECC78060;
 Wed, 24 Jun 2020 14:49:57 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.198.108])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 24 Jun 2020 14:49:57 +0000 (GMT)
Subject: Re: [PATCH v3 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-7-walling@linux.ibm.com>
 <20200624143635.2d87c1ca.cohuck@redhat.com>
 <d627e738-7414-4c7f-52ce-4972dfc30544@redhat.com>
 <20200624145500.69f9ab24.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <7ad94e6b-7e5e-04f6-109a-990075a1d8c2@linux.ibm.com>
Date: Wed, 24 Jun 2020 10:49:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624145500.69f9ab24.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-24_08:2020-06-24,
 2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 cotscore=-2147483648 mlxscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240106
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 10:50:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
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
Cc: frankja@linux.ibm.com, david@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 8:55 AM, Cornelia Huck wrote:
> On Wed, 24 Jun 2020 14:40:58 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 24/06/2020 14.36, Cornelia Huck wrote:
>>> On Thu, 18 Jun 2020 18:22:56 -0400
>>> Collin Walling <walling@linux.ibm.com> wrote:
>>>   
>>>> As more features and facilities are added to the Read SCP Info (RSCPI)
>>>> response, more space is required to store them. The space used to store
>>>> these new features intrudes on the space originally used to store CPU
>>>> entries. This means as more features and facilities are added to the
>>>> RSCPI response, less space can be used to store CPU entries.
>>>>
>>>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
>>>> the RSCPI command and determine if the SCCB is large enough to store a
>>>> complete reponse. If it is not large enough, then the required length
>>>> will be set in the SCCB header.
>>>>
>>>> The caller of the SCLP command is responsible for creating a
>>>> large-enough SCCB to store a complete response. Proper checking should
>>>> be in place, and the caller should execute the command once-more with
>>>> the large-enough SCCB.
>>>>
>>>> This facility also enables an extended SCCB for the Read CPU Info
>>>> (RCPUI) command.
>>>>
>>>> When this facility is enabled, the boundary violation response cannot
>>>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>>>>
>>>> In order to tolerate kernels that do not yet have full support for this
>>>> feature, a "fixed" offset to the start of the CPU Entries within the
>>>> Read SCP Info struct is set to allow for the original 248 max entries
>>>> when this feature is disabled.
>>>>
>>>> Additionally, this is introduced as a CPU feature to protect the guest
>>>> from migrating to a machine that does not support storing an extended
>>>> SCCB. This could otherwise hinder the VM from being able to read all
>>>> available CPU entries after migration (such as during re-ipl).
>>>>
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>   hw/s390x/sclp.c                     | 21 ++++++++++++++++++++-
>>>>   include/hw/s390x/sclp.h             |  1 +
>>>>   target/s390x/cpu_features_def.inc.h |  1 +
>>>>   target/s390x/gen-features.c         |  1 +
>>>>   target/s390x/kvm.c                  |  8 ++++++++
>>>>   5 files changed, 31 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index 0dfbe6e5ec..f7c49e339e 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -56,6 +56,18 @@ static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>>>>       uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>>>>   
>>>>       switch (code & SCLP_CMD_CODE_MASK) {
>>>> +    case SCLP_CMDW_READ_SCP_INFO:
>>>> +    case SCLP_CMDW_READ_SCP_INFO_FORCED:
>>>> +    case SCLP_CMDW_READ_CPU_INFO:
>>>> +        /*
>>>> +         * An extended-length SCCB is only allowed for Read SCP/CPU Info and
>>>> +         * is allowed to exceed the 4k boundary. The respective commands will
>>>> +         * set the length field to the required length if an insufficient
>>>> +         * SCCB length is provided.
>>>> +         */
>>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
>>>> +            return true;
>>>> +        }  
>>>
>>> Add a fallthrough annotation?  
>>
>> ... otherwise Coverity and friends will complain later.
> 
> Nod.
> 

Something simple like...

/* without this feature, these commands must respect the 4k boundary */

?

>>
>>>>       default:
>>>>           if (sccb_max_addr < sccb_boundary) {
>>>>               return true;
>>>> @@ -72,6 +84,10 @@ static bool sccb_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
>>>>   
>>>>       if (be16_to_cpu(sccb->h.length) < required_len) {
>>>>           sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>>>> +        if (s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) &&
>>>> +            sccb->h.control_mask[2] & SCLP_VARIABLE_LENGTH_RESPONSE) {
>>>> +            sccb->h.length = required_len;
>>>> +        }
>>>>           return false;
>>>>       }
>>>>       return true;
>>>> @@ -101,7 +117,9 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>>>    */
>>>>   static inline int get_read_scp_info_data_len(void)
>>>>   {
>>>> -    return offsetof(ReadInfo, entries);
>>>> +    return s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB) ?
>>>> +           offsetof(ReadInfo, entries) :
>>>> +           SCLP_READ_SCP_INFO_FIXED_CPU_OFFSET;
>>>>   }
>>>>   
>>>>   /* Provide information about the configuration, CPUs and storage */
>>>> @@ -116,6 +134,7 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>>>       CPUEntry *entries_start = (void *)sccb + data_len;
>>>>   
>>>>       if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>>>> +        warn_report("insufficient sccb size to store read scp info response");  
>>>
>>> Hm, this warning is triggered by a guest action, isn't it? Not sure how
>>> helpful it is.  
>>
>> I think this should be qemu_log_mask(LOG_GUEST_ERROR, ...) instead?
> 
> Yes, that sounds better.
> 
> 

Sure, sounds good.

-- 
Regards,
Collin

Stay safe and stay healthy

