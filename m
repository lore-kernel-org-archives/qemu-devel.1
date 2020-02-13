Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F52C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508BB21734
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508BB21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2J9D-00015N-BK
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jjherne@linux.ibm.com>) id 1j2Ioi-0007xA-K4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jjherne@linux.ibm.com>) id 1j2Iof-0004YJ-JW
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:02:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34002)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
 id 1j2Iof-0004TF-Ak; Thu, 13 Feb 2020 13:02:21 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01DHniZP077250; Thu, 13 Feb 2020 13:02:19 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j86s20d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2020 13:02:18 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01DHnrUl077686;
 Thu, 13 Feb 2020 13:02:17 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j86s1yw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2020 13:02:17 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DI0Zit011024;
 Thu, 13 Feb 2020 18:02:16 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 2y5bc000d1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 13 Feb 2020 18:02:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01DI2Fw319726724
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2020 18:02:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6E1CD6E050;
 Thu, 13 Feb 2020 18:02:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 109176E052;
 Thu, 13 Feb 2020 18:02:14 +0000 (GMT)
Received: from [9.60.75.232] (unknown [9.60.75.232])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
 Thu, 13 Feb 2020 18:02:14 +0000 (GMT)
Subject: Re: [PATCH] pc-bios/s390x: Pack ResetInfo struct
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, cohuck@redhat.com
References: <20200205182126.13010-1-jjherne@linux.ibm.com>
 <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Organization: IBM
Message-ID: <bf3f44b5-f0fe-59f4-9152-54edd8c9822e@linux.ibm.com>
Date: Thu, 13 Feb 2020 13:02:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <e3baa1e0-e1d3-d67c-cca9-a626d42c5489@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-13_06:2020-02-12,
 2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130127
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
Reply-To: jjherne@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/6/20 5:09 AM, Christian Borntraeger wrote:
> 
> 
> On 05.02.20 19:21, Jason J. Herne wrote:
>> This fixes vfio-ccw when booting non-Linux operating systems. Without this
>> struct being packed, a few extra bytes of low core memory get overwritten when
>> we  assign a value to memory address 0 in jump_to_IPL_2. This is enough to
>> cause some non-Linux OSes of fail when booting.
>>
>> The problem was introduced by:
>> 5c6f0d5f46a77d77 "pc-bios/s390x: Fix reset psw mask".
>>
>> The fix is to pack the struct thereby removing the 4 bytes of padding that get
>> added at the end, likely to allow an array of these structs to naturally align
>> on an 8-byte boundary.
>>
>> Fixes: 5c6f0d5f46a7 ("pc-bios/s390x: Fix reset psw mask")
>> CC: Janosch Frank <frankja@linux.ibm.com>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/jump2ipl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
>> index da13c43cc0..1e9eaa037f 100644
>> --- a/pc-bios/s390-ccw/jump2ipl.c
>> +++ b/pc-bios/s390-ccw/jump2ipl.c
>> @@ -18,7 +18,7 @@
>>   typedef struct ResetInfo {
>>       uint64_t ipl_psw;
>>       uint32_t ipl_continue;
>> -} ResetInfo;
>> +} __attribute__((packed)) ResetInfo;
>>   
>>   static ResetInfo save;
> 
> Just looked into that.
> 
> We do save the old content in "save" and restore the old memory content.
> 
> static void jump_to_IPL_2(void)
> {
>      ResetInfo *current = 0;
> 
>      void (*ipl)(void) = (void *) (uint64_t) current->ipl_continue;
> --->*current = save;
>      ipl(); /* should not return */
> }
> 
> void jump_to_IPL_code(uint64_t address)
> {
>      /* store the subsystem information _after_ the bootmap was loaded */
>      write_subsystem_identification();
> 
>      /* prevent unknown IPL types in the guest */
>      if (iplb.pbt == S390_IPL_TYPE_QEMU_SCSI) {
>          iplb.pbt = S390_IPL_TYPE_CCW;
>          set_iplb(&iplb);
>      }
> 
>      /*
>       * The IPL PSW is at address 0. We also must not overwrite the
>       * content of non-BIOS memory after we loaded the guest, so we
>       * save the original content and restore it in jump_to_IPL_2.
>       */
>      ResetInfo *current = 0;
> 
> --->save = *current;
> 
> 
> 
> does something like
> 
> 
> diff --git a/pc-bios/s390-ccw/jump2ipl.c b/pc-bios/s390-ccw/jump2ipl.c
> index da13c43cc0..8839226803 100644
> --- a/pc-bios/s390-ccw/jump2ipl.c
> +++ b/pc-bios/s390-ccw/jump2ipl.c
> @@ -18,6 +18,7 @@
>   typedef struct ResetInfo {
>       uint64_t ipl_psw;
>       uint32_t ipl_continue;
> +    uint32_t pad;
>   } ResetInfo;
>   
>   static ResetInfo save;
> 
> 
> also work? If yes, both variants are valid. Either packed or explicit padding.
> 

I don't believe this will work. I think the problem is that we're overwriting too much 
memory when we cast address 0 as a ResetInfo and then overwrite it (*current = save). I 
think we need the struct to be sized at 12-bytes instead of 16.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)

