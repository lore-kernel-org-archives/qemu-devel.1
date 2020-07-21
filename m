Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A775C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF46620717
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF46620717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxxDp-0003b2-9D
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 14:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jxxBg-000252-51; Tue, 21 Jul 2020 14:40:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64238)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jxxBd-0000cX-Dz; Tue, 21 Jul 2020 14:40:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06LIXic5020740; Tue, 21 Jul 2020 14:40:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xwq5ps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 14:40:18 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LIYETK023333;
 Tue, 21 Jul 2020 14:40:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com
 [169.53.41.122])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xwq5p8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 14:40:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
 by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LIeFcW018187;
 Tue, 21 Jul 2020 18:40:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma04dal.us.ibm.com with ESMTP id 32d5dq2m9t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2020 18:40:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06LIeEQL60555730
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Jul 2020 18:40:14 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0CCC6C6055;
 Tue, 21 Jul 2020 18:40:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AB57C6059;
 Tue, 21 Jul 2020 18:40:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.156])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 21 Jul 2020 18:40:15 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
Subject: Re: [PATCH v4 3/8] s390/sclp: rework sclp boundary and length checks
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-4-walling@linux.ibm.com>
 <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
 <c7ba363c-a142-9fb9-2ecf-a8dc56a6e6f8@linux.ibm.com>
 <bd373fb2-20d3-baf4-f2bc-4eca1f033c2b@redhat.com>
Message-ID: <a4e80383-b244-e47b-8980-8b35fb6a7468@linux.ibm.com>
Date: Tue, 21 Jul 2020 14:40:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <bd373fb2-20d3-baf4-f2bc-4eca1f033c2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-21_14:2020-07-21,
 2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 11:41:50
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
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

On 7/21/20 4:41 AM, David Hildenbrand wrote:
> [...]
> 
>>>> +    switch (code & SCLP_CMD_CODE_MASK) {
>>>> +    default:
>>>> +        if (sccb_max_addr < sccb_boundary) {
>>>> +            return true;
>>>> +        }
>>>> +    }
>>>
>>> ^ what is that?
>>>
>>>     if ((code & SCLP_CMD_CODE_MASK) && sccb_max_addr < sccb_boundary) {
>>>         return true;
>>>     }
> 
> Oh, my tired eyes missed that it's actually only
> 
> if (sccb_max_addr < sccb_boundary) :)
> 
>>>
>>
>> I agree it looks pointless in this patch, but it makes more sense in
>> patch #6 where we introduce cases for the SCLP commands that bypass
>> these checks if the extended-length sccb feature is enabled.
> 
> I am really a friend of introducing stuff where needed. Just use a
> simple "if" here and convert to the switch in patch #6.
> 

I can understand that. This follows the whole "each patch should be
sufficient on its own" way of thinking. A switch with no cases and a
default _does_ look silly.

>>
>>>> +    header->response_code = cpu_to_be16(SCLP_RC_SCCB_BOUNDARY_VIOLATION);
>>>> +    return false;
>>>
>>> So we return "false" on success? At least I consider that weird when
>>> returning the bool type. Maybe make it clearer what the function indicates
>>>
>>
>> Hmmm... I figured since there were more paths that can lead to success
>> (i.e. when I introduce the feat check in a later patch), then it made
>> more sense to to return false at the end. sclp_command_code_valid has
>> similar logic.
>>
>> But if boolean functions traditionally return true as the last return
>> value, I can rework it to align to coding preferences / standards.
>>
>>> "sccb_boundary_is_invalid"
>>>
>>
>> Unless it's simply the name that is confusing?
> 
> The options I would support are
> 
> 1. "sccb_boundary_is_valid" which returns "true" if valid
> 2. "sccb_boundary_is_invalid" which returns "true" if invalid
> 3. "sccb_boundary_validate" which returns "0" if valid and -EINVAL if not.
> 
> Which makes reading this code a bit easier.
> 

Sounds good. I'll takes this into consideration for the next round. (I
may wait just a little longer for that to allow more reviews to come in
from whoever has the time, if that's okay.)

>>
>>> or leave it named as is and switch from return value "bool" to "int",
>>> using "0" on success and "-EINVAL" on error.
>>>
>>
>> Is the switch statement an overkill? I thought of it as a cleaner way to
>> later show which commands have a special conditions (introduced in patch
>> 6 for the ELS stuff) instead of a nasty long if statement.
> 
> I think the switch make sense in patch #6.
> 


-- 
Regards,
Collin

Stay safe and stay healthy

