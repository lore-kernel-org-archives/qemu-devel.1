Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:49:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963C207D3
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkrMC-0002a1-Oa
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46702)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jkrL2-0001aD-56; Mon, 15 Jun 2020 11:47:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47580)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jkrL0-0006IW-4I; Mon, 15 Jun 2020 11:47:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FFZ7m3136176; Mon, 15 Jun 2020 11:47:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31p5erp6hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:47:52 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FFY8KA131411;
 Mon, 15 Jun 2020 11:47:51 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31p5erp6h8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 11:47:51 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FFZVM8013144;
 Mon, 15 Jun 2020 15:47:50 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01dal.us.ibm.com with ESMTP id 31mpe96s89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 15:47:50 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FFln9s49152308
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 15:47:49 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 92218124053;
 Mon, 15 Jun 2020 15:47:49 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B905124052;
 Mon, 15 Jun 2020 15:47:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.157.70])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Mon, 15 Jun 2020 15:47:48 +0000 (GMT)
Subject: Re: [PATCH v2 2/8] s390/sclp: check sccb len before filling in data
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-3-walling@linux.ibm.com>
 <ad9bd716-745b-210f-8716-46043ca1b110@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <58bd2552-8cb9-5914-dbfd-a6a05ffdf396@linux.ibm.com>
Date: Mon, 15 Jun 2020 11:47:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ad9bd716-745b-210f-8716-46043ca1b110@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_06:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 priorityscore=1501 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150123
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, mst@redhat.com,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/11/20 8:01 AM, Thomas Huth wrote:
> On 16/05/2020 00.20, Collin Walling wrote:
>> The SCCB must be checked for a sufficient length before it is filled
>> with any data. If the length is insufficient, then the SCLP command
>> is suppressed and the proper response code is set in the SCCB header.
>>
>> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c | 22 ++++++++++------------
>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 61e2e2839c..2bd618515e 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -75,6 +75,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      int rnsize, rnmax;
>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>  
>> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
> 
> You are using cpu_count here ...
> 
>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +        return;
>> +    }
>> +
>>      /* CPU information */
>>      prepare_cpu_entries(machine, read_info->entries, &cpu_count);
> 
> ... but it is only initialized here.
> 
> Even if you replace the code in a later patch, please fix this here,
> too, to maintain bisectability of the code.
> 
>>      read_info->entries_cpu = cpu_to_be16(cpu_count);
>> @@ -83,12 +88,6 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>  
>>      read_info->ibc_val = cpu_to_be32(s390_get_ibc_val());
>>  
>> -    if (be16_to_cpu(sccb->h.length) <
>> -            (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> -        return;
>> -    }
>> -
>>      /* Configuration Characteristic (Extension) */
>>      s390_get_feat_block(S390_FEAT_TYPE_SCLP_CONF_CHAR,
>>                           read_info->conf_char);
>> @@ -135,17 +134,16 @@ static void sclp_read_cpu_info(SCLPDevice *sclp, SCCB *sccb)
>>      ReadCpuInfo *cpu_info = (ReadCpuInfo *) sccb;
>>      int cpu_count;
>>  
>> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
> 
> dito!
> 
>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> +        return;
>> +    }
>> +
>>      prepare_cpu_entries(machine, cpu_info->entries, &cpu_count);
>>      cpu_info->nr_configured = cpu_to_be16(cpu_count);
>>      cpu_info->offset_configured = cpu_to_be16(offsetof(ReadCpuInfo, entries));
>>      cpu_info->nr_standby = cpu_to_be16(0);
>>  
>> -    if (be16_to_cpu(sccb->h.length) <
>> -            (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
>> -        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>> -        return;
>> -    }
>> -
>>      /* The standby offset is 16-byte for each CPU */
>>      cpu_info->offset_standby = cpu_to_be16(cpu_info->offset_configured
>>          + cpu_info->nr_configured*sizeof(CPUEntry));
> 
>  Thanks,
>   Thomas
> 

I'll rework this patch. Thanks for the reviews!

-- 
Regards,
Collin

Stay safe and stay healthy

