Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D86C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A75520716
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A75520716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOmg-0006kV-JP
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34026)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jnOm3-0005gj-Mc; Mon, 22 Jun 2020 11:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24326
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jnOm1-0006Em-Hc; Mon, 22 Jun 2020 11:54:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05MFW3JG113194; Mon, 22 Jun 2020 11:54:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31spnv7e40-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 11:54:14 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05MFWZU8118529;
 Mon, 22 Jun 2020 11:54:14 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0b-001b2d01.pphosted.com with ESMTP id 31spnv7e3s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 11:54:13 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05MFZE1j025894;
 Mon, 22 Jun 2020 15:54:13 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 31sa38mv3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2020 15:54:13 +0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05MFsAww17498580
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jun 2020 15:54:10 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5950BE051;
 Mon, 22 Jun 2020 15:54:11 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E1E7DBE054;
 Mon, 22 Jun 2020 15:54:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.169.243])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 22 Jun 2020 15:54:10 +0000 (GMT)
Subject: Re: [PATCH v3 3/8] s390/sclp: rework sclp boundary and length checks
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200618222258.23287-1-walling@linux.ibm.com>
 <20200618222258.23287-4-walling@linux.ibm.com>
 <ebe5f688-cd1a-a926-98c7-fc43879cdbd8@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <e0f3d462-0916-3871-e342-78f3a0e46275@linux.ibm.com>
Date: Mon, 22 Jun 2020 11:54:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ebe5f688-cd1a-a926-98c7-fc43879cdbd8@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-22_08:2020-06-22,
 2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 cotscore=-2147483648 impostorscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220114
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 11:54:15
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 11:22 AM, Christian Borntraeger wrote:
> 
> 
> On 19.06.20 00:22, Collin Walling wrote:
>> Rework the SCLP boundary check to account for different SCLP commands
>> (eventually) allowing different boundary sizes.
>>
>> Move the length check code into a separate function, and introduce a
>> new function to determine the length of the read SCP data (i.e. the size
>> from the start of the struct to where the CPU entries should begin).
>>
>> The format of read CPU info is unlikely to change in the future,
>> so we do not require a separate function to calculate its length.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 49 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 181ce04007..0710138f91 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>      return false;
>>  }
>>  
>> +static bool sccb_has_valid_boundary(uint64_t sccb_addr, uint32_t code,
>> +                                    SCCBHeader *header)
> 
> As you write to the sccb in case of error, mabye
> sccb_verify_boundary instead of has_valid. has_valid feels like a read-only function.
> 
>> +{
>> +    uint64_t sccb_max_addr = sccb_addr + be16_to_cpu(header->length) - 1;
>> +    uint64_t sccb_boundary = (sccb_addr & PAGE_MASK) + PAGE_SIZE;
>> +
>> +    switch (code & SCLP_CMD_CODE_MASK) {
>> +    default:
>> +        if (sccb_max_addr < sccb_boundary) {
>> +            return true;
>> +        }
>> +    }
>> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    return false;
>> +}
>> +
>> +/* Calculates sufficient SCCB length to store a full Read SCP/CPU response */
>> +static bool sccb_sufficient_len(SCCB *sccb, int num_cpus, int data_len)
> 
> same here, maybe sccb_verify_length

Sounds good. I was struggling with a decent naming scheme for these as
well :)

> 
>> +{
>> +    int required_len = data_len + num_cpus * sizeof(CPUEntry);
>> +
>> +    if (be16_to_cpu(sccb->h.length) < required_len) {
>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +        return false;
>> +    }
>> +    return true;
>> +}
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
>> +static inline int get_read_scp_info_data_len(void)
>> +{
>> +    return offsetof(ReadInfo, entries);
>> +}
>> +
>>  /* Provide information about the configuration, CPUs and storage */
>>  static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>> @@ -74,17 +112,16 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      int cpu_count;
>>      int rnsize, rnmax;
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>> +    int data_len = get_read_scp_info_data_len();
>>  
>> -    if (be16_to_cpu(sccb->h.length) <
>> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +    if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
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
>> @@ -133,17 +170,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>>  {
>>      MachineState *machine = MACHINE(qdev_get_machine());
>>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>> +    int data_len = offsetof(ReadCpuInfo, entries);
>>      int cpu_count;
>>  
>> -    if (be16_to_cpu(sccb->h.length) <
>> -          (sizeof(ReadInfo) + machine->possible_cpus->len * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +    if (!sccb_sufficient_len(sccb, machine->possible_cpus->len, data_len)) {
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
>> @@ -229,6 +265,10 @@ int sclp_service_call_protected(CPUS390XState *env, uint64_t sccb,
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
>> @@ -274,8 +314,7 @@ int sclp_service_call(CPUS390XState *env, uint64_t sccb, uint32_t code)
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


-- 
Regards,
Collin

Stay safe and stay healthy

