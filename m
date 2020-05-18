Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E252C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:20:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0B520758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 15:20:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0B520758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jahZU-0000V1-Jt
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jahU4-0003UO-IA; Mon, 18 May 2020 11:15:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jahU2-0006JK-VT; Mon, 18 May 2020 11:15:16 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04IF77Ao032431; Mon, 18 May 2020 11:15:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312cayd9w1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 11:15:12 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IF7Bkv032979;
 Mon, 18 May 2020 11:15:12 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312cayd9v9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 11:15:12 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04IFC8ap019085;
 Mon, 18 May 2020 15:15:10 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by ppma02wdc.us.ibm.com with ESMTP id 3127t60hcy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 15:15:10 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04IFF8jq28836196
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 15:15:08 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 626D76E052;
 Mon, 18 May 2020 15:15:09 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4ED4B6E04E;
 Mon, 18 May 2020 15:15:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.55])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 18 May 2020 15:15:08 +0000 (GMT)
Subject: Re: [PATCH v2 3/8] s390/sclp: rework sclp boundary and length checks
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-4-walling@linux.ibm.com>
 <2fcd0d94-12c7-e3b8-d6a6-3c512ae25150@linux.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <e8dd0421-0db6-ff92-43af-6fd082d76e7e@linux.ibm.com>
Date: Mon, 18 May 2020 11:15:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <2fcd0d94-12c7-e3b8-d6a6-3c512ae25150@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180129
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 11:15:13
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: thuth@redhat.com, mst@redhat.com, cohuck@redhat.com, david@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 4:50 AM, Janosch Frank wrote:
> On 5/16/20 12:20 AM, Collin Walling wrote:
>> Rework the SCLP boundary check to account for different SCLP commands
>> (eventually) allowing different boundary sizes.
>>
>> Move the length check code into a separate function, and introduce a
>> new function to determine the length of the read SCP data (i.e. the size
>> from the start of the struct to where the CPU entries should begin).
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c | 57 ++++++++++++++++++++++++++++++++++++++++++-------
>>  1 file changed, 49 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 2bd618515e..987699e3c4 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>      return false;
>>  }
>>  
>> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>> +                                    SCCBHeader *header)
>> +{
>> +    uint64_t current_len = sccb_addr + be16_to_cpu(header->length);
>> +    uint64_t allowed_len = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
> 
> Those are addresses not length indications and the names should reflect
> that.

True

> Also don't we need to use PAGE_SIZE - 1?
> 

Technically we need to -1 on both sides since length denotes the size of
the sccb in bytes, not the max address.

How about this:

s/current_len/sccb_max_addr
s/allowed_len/sccb_boundary

-1 to sccb_max_addr

Change the check to: sccb_max_addr < sccb_boundary

?

> I'm still trying to wake up, so take this with a grain of salt.
> 

No worries. I appreciate the review nonetheless :)

>> +
>> +    switch (code & SCLP_CMD_CODE_MASK) {
>> +    default:
>> +        if (current_len <= allowed_len) {
>> +            return true;
>> +        }
>> +    }
>> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    return false;
>> +}
>> +
>> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
>> +static bool sccb_has_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
>> +{
>> +    int required_len = data_len + num_cpus * sizeof(CPUEntry);
>> +
>> +    if (be16_to_cpu(sccb->h.length) < required_len) {
>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +        return false;
>> +    }
>> +    return true;
>> +}
> 
> Hm, from the function name alone I'd not have expected it to also set
> the response code.
> 

It also sets the required length in the header for an extended-length
sccb. Perhaps this function name doesn't hold up well.

Does sccb_check_sufficient_len make more sense?

I think the same could be said of the boundary check function, which
also sets the response code.

What about setting the response code outside the function, similar to
what sclp_comand_code_valid does?

>> +
>>  static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>  {
>>      uint8_t features[SCCB_CPU_FEATURE_LEN] = { 0 };
>> @@ -66,6 +94,16 @@ static void prepare_cpu_entries(MachineState *ms, CPUEntry *entry, int *count)
>>      }
>>  }
>>  
>> +/*
>> + * The data length denotes the start of the struct to where the first
>> + * CPU entry is to be allocated. This value also denotes the offset_cpu
>> + * field.
>> + */
>> +static int get_read_scp_info_data_len(void)
>> +{
>> +    return offsetof(ReadInfo, entries);
>> +}
> 
> Not sure what the policy for this is, but maybe this can go into a
> header file?
> David and Conny will surely make that clear to me :)
> 

Not sure either. If anything it might be a good candidate for an inline
function.

>> +
>>  /* Provide information about the configuration, CPUs and storage */
>>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> @@ -74,16 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      int cpu_count;
>>      int rnsize, rnmax;
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>> +    int data_len = get_read_scp_info_data_len();
>>  
>> -    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +    if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>>          return;
>>      }
>>  
>>      /* CPU information */
>>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
>>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>> -    read_info->offset_cpu = cpu_to_be16(offsetof(ReadInfo, entries));
>> +    read_info->offset_cpu = cpu_to_be16(data_len);
>>      read_info->highest_cpu = cpu_to_be16(machine->smp.max_cpus - 1);
>>  
>>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>> @@ -132,16 +170,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>> +    int data_len = offsetof(ReadCpuInfo, entries);
>>      int cpu_count;
>>  
>> -    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +    if (!sccb_has_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
>>          return;
>>      }
>>  
>>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>>      cpu_info->nr_configured = cpu_to_be16(cpu_count);
>> -    cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
>> +    cpu_info->offset_configured = cpu_to_be16(data_len);
>>      cpu_info->nr_standby = cpu_to_be16(0);
>>  
>>      /* The standby offset is 16-byte for each CPU */
>> @@ -227,6 +265,10 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
>>          goto out_write;
>>      }
>>  
>> +    if (!sccb_has_valid_boundary(sccb, code, &work_sccb.h)) {
>> +        goto out_write;
>> +    }
>> +
>>      sclp_c->execute(sclp, &work_sccb, code);
>>  out_write:
>>      s390_cpu_pv_mem_write(env_archcpu(env), 0, &work_sccb,
>> @@ -272,8 +314,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
>>          goto out_write;
>>      }
>>  
>> -    if ((sccb + be16_to_cpu(work_sccb.h.length)) > ((sccb & PAGE_MASK) + PAGE_SIZE)) {
>> -        work_sccb.h.response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    if (!sccb_has_valid_boundary(sccb, code, &work_sccb.h)) {
>>          goto out_write;
>>      }
>>  
>>
> 
> 


-- 
--
Regards,
Collin

Stay safe and stay healthy

