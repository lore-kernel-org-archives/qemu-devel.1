Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515BFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:37:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8323A20735
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNls4cw2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8323A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1vg-0004ns-73
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kb1uU-0004Iu-JF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:36:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48958
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1kb1uQ-0003Dw-Pf
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:36:10 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0A6DWVSs048295; Fri, 6 Nov 2020 08:36:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sYHLyySwpW9l4QJ6M66w2vctHZddbsZMVbG41gl0xeU=;
 b=JNls4cw2nJ9wFxWwZVheAJO6JhIPuLp/3NKArc9slswf3Ex7gjJ0AOJsDXshWO43y8XG
 f49gPlVBnB49upg4GzCDsjU4r1fbUj0NvqJ3HvQ3LUMF6yq7l3nwqTSbYWkjvAJQ9b70
 UMt2H2qCloKjqsTFhkPxXXPuier6epmVte+2Ggre08Zu4XIXOugiQtV4aGNWVEs7fnsg
 xZMkihZRe08Pu/m5djTgvpZagN9DqZWPWi/CZ1vELeei7Y7qkdAzzn/6DBP7epyPriV4
 Etv9UeYkEHGzKISPY7wkZCX8P+JHM9mBLw8dlLLEyoOHkbz2uUg10QQYxazSZ8EfHJbB uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34n72v9274-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 08:36:04 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6DWfcW049596;
 Fri, 6 Nov 2020 08:36:03 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 34n72v926s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 08:36:03 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6DVYTN029982;
 Fri, 6 Nov 2020 13:36:03 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 34h0236gnc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Nov 2020 13:36:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0A6Da1WX48955700
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Nov 2020 13:36:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE7F56A054;
 Fri,  6 Nov 2020 13:36:01 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4299A6A058;
 Fri,  6 Nov 2020 13:36:01 +0000 (GMT)
Received: from [9.160.36.109] (unknown [9.160.36.109])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Fri,  6 Nov 2020 13:36:01 +0000 (GMT)
Subject: Re: [PATCH v3 0/9] Add support for Control-Flow Integrity
To: Cornelia Huck <cohuck@redhat.com>, Alexander Bulekov <alxndr@bu.edu>
References: <20201105221905.1350-1-dbuono@linux.vnet.ibm.com>
 <20201106134747.7c9a5050.cohuck@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <e2e27a18-a0d0-77c2-5e5d-b4c210fec177@linux.vnet.ibm.com>
Date: Fri, 6 Nov 2020 08:35:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201106134747.7c9a5050.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-06_04:2020-11-05,
 2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060092
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 08:36:05
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Cornelia,

I don't have a real preference either way.

So if it is acceptable to have the clang11+ patches separated and
handled by the maintainers for the proper subsystem, I'd say whatever
the maintainers prefer.

In my opinion, the patches for clang11+ support may be merged
separately.

I'm saying this because, from my tests, the only feature that needs
clang11+ to compile with Control-Flow Integrity is fuzzing.
However, the main way we're fuzzing QEMU is through OSSfuzz, and I don't
think their infrastructure is using a compiler that new, so we wouldn't
be able to enable it anyway. (Alex can chip in to confirm this)
On the other hand, if someone is looking for temporary support in-house,
they can just add -Wno-[...] as extra-cflags until the additional
patches land. (Assuming CFI lands before the clang11+ patches).

Regards,
Daniele

On 11/6/2020 7:47 AM, Cornelia Huck wrote:
> On Thu,  5 Nov 2020 17:18:56 -0500
> Daniele Buono <dbuono@linux.vnet.ibm.com> wrote:
> 
>> This patch adds supports for Control-Flow Integrity checks
>> on indirect function calls.
>>
>> Requires the use of clang, and link-time optimizations
>>
>> Changes in v3:
>>
>> - clang 11+ warnings are now handled directly at the source,
>> instead of disabling specific warnings for the whole code.
>> Some more work may be needed here to polish the patch, I
>> would kindly ask for a review from the corresponding
>> maintainers
> 
> Process question :)
> 
> Would you prefer to have this series merged in one go, or should
> maintainers pick the patches for their subsystem?
> 
>> - Remove configure-time checks for toolchain compatibility
>> with LTO.
>> - the decorator to disable cfi checks on functions has
>> been renamed and moved to include/qemu/compiler.h
>> - configure-time checks for cfi support and dependencies
>> has been moved from configure to meson
>>
>> Link to v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg753675.html
>> Link to v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg718786.html
>>
>> Daniele Buono (9):
>>    fuzz: Make fork_fuzz.ld compatible with LLVM's LLD
>>    s390x: fix clang 11 warnings in cpu_models.c
>>    hw/usb: reorder fields in UASStatus
>>    s390x: Avoid variable size warning in ipl.h
>>    scsi: fix overflow in scsi_disk_new_request_dump
>>    configure,meson: add option to enable LTO
>>    cfi: Initial support for cfi-icall in QEMU
>>    check-block: enable iotests with cfi-icall
>>    configure/meson: support Control-Flow Integrity
>>
>>   accel/tcg/cpu-exec.c          | 11 +++++++++
>>   configure                     | 26 ++++++++++++++++++++
>>   hw/s390x/ipl.h                |  4 +--
>>   hw/scsi/scsi-disk.c           |  4 +++
>>   hw/usb/dev-uas.c              |  2 +-
>>   include/qemu/compiler.h       | 12 +++++++++
>>   meson.build                   | 46 +++++++++++++++++++++++++++++++++++
>>   meson_options.txt             |  4 +++
>>   plugins/core.c                | 37 ++++++++++++++++++++++++++++
>>   plugins/loader.c              |  7 ++++++
>>   target/s390x/cpu_models.c     |  8 +++---
>>   tcg/tci.c                     |  7 ++++++
>>   tests/check-block.sh          | 18 ++++++++------
>>   tests/qtest/fuzz/fork_fuzz.ld | 12 ++++++++-
>>   util/main-loop.c              | 11 +++++++++
>>   util/oslib-posix.c            | 11 +++++++++
>>   16 files changed, 205 insertions(+), 15 deletions(-)
>>
> 
> 

