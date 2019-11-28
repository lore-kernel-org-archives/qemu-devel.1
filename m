Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A37C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:30:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E027208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:30:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E027208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaJsS-0004h7-Jf
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:30:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaJdo-00080y-M4
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmorel@linux.ibm.com>) id 1iaJdm-000610-J1
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:15:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42492
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
 id 1iaJdi-0005xk-Ud
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:15:24 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xASD0XU5120538
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:15:20 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2whh5fms0h-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 08:15:20 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
 Thu, 28 Nov 2019 13:15:18 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Nov 2019 13:15:14 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xASDFDn514680250
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Nov 2019 13:15:13 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A14652059;
 Thu, 28 Nov 2019 13:15:13 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.185.119])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BAD9652057;
 Thu, 28 Nov 2019 13:15:12 +0000 (GMT)
Subject: Re: [PATCH v1 0/1] s390x: protvirt: SCLP interpretation
To: Janosch Frank <frankja@linux.ibm.com>, qemu-s390x@nongnu.org
References: <1574935984-16910-1-git-send-email-pmorel@linux.ibm.com>
 <7f2202c7-b9ed-d1c8-7b5c-e6b8871aa931@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 28 Nov 2019 14:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7f2202c7-b9ed-d1c8-7b5c-e6b8871aa931@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19112813-0012-0000-0000-0000036D65F1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112813-0013-0000-0000-000021A912F9
Message-Id: <d1cf8a77-1956-1226-fdf2-715524f7f0f7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_03:2019-11-28,2019-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911280114
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 148.163.158.5
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019-11-28 13:28, Janosch Frank wrote:
> On 11/28/19 11:13 AM, Pierre Morel wrote:
>> A new proposition:
>> I think it would be wise to fork directly from handle_instruction
>> instead to accept per default all instructions with with secure
>> instruction interception code.
>> Just in case future firmware with older QEMU.
>>
>> How ever I let three dors open.
>>
>> 1) This patch accepts the all B2 instructions, mostly I/O.
>> Some of the instructions will not work correctly for PV until patched.
>> This should be fixed, and will be, in a separate patch.
>>
>> 2) The same is true for DIAG instructions.
>>
>> 3) Secure notifications are separated from secure instructions and
>> normal instructions interception because this case is completely new.
>> For B2 instructions we do not have to do anything this just informative.
>> However, one information is of interrest, a notification that
>> SIGP(STOP) is sent to stop the CPUs and terminate QEMU.
> Pierre, I told you this morning that I don't want this and that you
> should leave this untouched until I can explain my thoughts behind the
> initial patch in a f2f.
> Thomas' review of your change only confirmed my concerns about this patch.
>
> This is the wrong patch at the wrong time, which creates noise and work
> for other people. Please stop and work on something else.

!?

- you sent to me info on slack that I did not see until now, next time 
be sure I have acknowledged if it is important.

- You told me to dive into this patch quite abruptly, and it invested 
time to understand how the I/O works with PV, so sorry for the wrong time

- I see no problem with the questions from Thomas, may be you can 
explain this to me

- I have a lot of other things to do so I just close this thread after 
having answered to Thomas.


>
>
>
>>
>>
>> Pierre Morel (1):
>>    s390x: protvirt: SCLP interpretation
>>
>>   hw/s390x/sclp.c         | 18 +++++++++++++
>>   include/hw/s390x/sclp.h |  2 ++
>>   target/s390x/kvm.c      | 56 ++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 75 insertions(+), 1 deletion(-)
>>
>
-- 
Pierre Morel
IBM Lab Boeblingen


