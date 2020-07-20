Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA2BC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFC62080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 20:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFC62080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxc3p-00067D-Qc
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 16:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jxc3C-0005Qy-Vg; Mon, 20 Jul 2020 16:06:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5838)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jxc3A-0000bh-2m; Mon, 20 Jul 2020 16:06:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06KK3XVZ043781; Mon, 20 Jul 2020 16:06:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d5peyw3c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 16:06:08 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KK3ijO044511;
 Mon, 20 Jul 2020 16:06:08 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32d5peyw32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 16:06:08 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KK4x4v004885;
 Mon, 20 Jul 2020 20:06:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03wdc.us.ibm.com with ESMTP id 32brq8v067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2020 20:06:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06KK66O916384300
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Jul 2020 20:06:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3040C78066;
 Mon, 20 Jul 2020 20:06:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 163FE7805F;
 Mon, 20 Jul 2020 20:06:04 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.191.4])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 20 Jul 2020 20:06:04 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] s390/sclp: rework sclp boundary and length checks
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-4-walling@linux.ibm.com>
 <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <c7ba363c-a142-9fb9-2ecf-a8dc56a6e6f8@linux.ibm.com>
Date: Mon, 20 Jul 2020 16:06:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-20_09:2020-07-20,
 2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 16:06:09
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 4:17 AM, David Hildenbrand wrote:
> On 24.06.20 22:23, Collin Walling wrote:
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
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>>  hw/s390x/sclp.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
>>  1 file changed, 44 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>> index 181ce04007..5899c1e3b8 100644
>> --- a/hw/s390x/sclp.c
>> +++ b/hw/s390x/sclp.c
>> @@ -49,6 +49,34 @@ static inline bool sclp_command_code_valid(uint32_t code)
>>      return false;
>>  }
>>  
>> +static bool sccb_verify_boundary(uint64_t sccb_addr, uint32_t code,
>> +                                 SCCBHeader *header)
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
> 
> ^ what is that?
> 
>     if ((code & SCLP_CMD_CODE_MASK) && sccb_max_addr < sccb_boundary) {
>         return true;
>     }
> 

I agree it looks pointless in this patch, but it makes more sense in
patch #6 where we introduce cases for the SCLP commands that bypass
these checks if the extended-length sccb feature is enabled.

>> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>> +    return false;
> 
> So we return "false" on success? At least I consider that weird when
> returning the bool type. Maybe make it clearer what the function indicates
> 

Hmmm... I figured since there were more paths that can lead to success
(i.e. when I introduce the feat check in a later patch), then it made
more sense to to return false at the end. sclp_command_code_valid has
similar logic.

But if boolean functions traditionally return true as the last return
value, I can rework it to align to coding preferences / standards.

> "sccb_boundary_is_invalid"
> 

Unless it's simply the name that is confusing?

> or leave it named as is and switch from return value "bool" to "int",
> using "0" on success and "-EINVAL" on error.
> 

Is the switch statement an overkill? I thought of it as a cleaner way to
later show which commands have a special conditions (introduced in patch
6 for the ELS stuff) instead of a nasty long if statement.

The alternative...

/* Comment explaining this check */
if ((code & SCLP_CMD_CODE_MASK) & (SCLP_CMDW_READ_SCP_INFO |
	SCLP_CMDW_READ_SCP_INFO_FORCED | SCLP_CMDW_READ_CPU_INFO) &&
	s390_has_feat(S390_FEAT_EXTENDED_LENGTH_SCCB)) {
	return true;
}

if (sccb_max_addr < sccb_boundary) {
        return true;
}

header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
return false;

[...]

-- 
Regards,
Collin

Stay safe and stay healthy

