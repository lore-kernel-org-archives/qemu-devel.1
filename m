Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:00:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B42CD2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42CD2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkojJ-00032l-F9
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jkohP-0001Ph-Rp
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:58:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jkohN-0007PB-Re
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:58:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 05FC22Nh185549
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:58:46 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31nrer0tuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:58:46 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FCtY16002166
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 08:58:45 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 31nrer0tu4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 08:58:45 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FCowxJ023606;
 Mon, 15 Jun 2020 12:58:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by ppma02dal.us.ibm.com with ESMTP id 31mpe9cvn9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2020 12:58:44 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 05FCwgLZ12517986
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Jun 2020 12:58:42 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 83E7E6A051;
 Mon, 15 Jun 2020 12:58:43 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C14506A047;
 Mon, 15 Jun 2020 12:58:42 +0000 (GMT)
Received: from [9.160.105.223] (unknown [9.160.105.223])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 15 Jun 2020 12:58:42 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Add support for SafeStack
To: qemu-devel@nongnu.org
References: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <a99b17a0-11f2-374a-28a9-2a65b6c6b6e6@linux.vnet.ibm.com>
Date: Mon, 15 Jun 2020 08:58:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200529205122.714-1-dbuono@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.687
 definitions=2020-06-15_02:2020-06-15,
 2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 08:37:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping?

On 5/29/2020 4:51 PM, Daniele Buono wrote:
> LLVM supports SafeStack instrumentation to protect against stack buffer
> overflows, since version 3.7
> 
>>From https://clang.llvm.org/docs/SafeStack.html:
> "It works by separating the program stack into two distinct regions: the
> safe stack and the unsafe stack. The safe stack stores return addresses,
> register spills, and local variables that are always accessed in a safe
> way, while the unsafe stack stores everything else. This separation
> ensures that buffer overflows on the unsafe stack cannot be used to
> overwrite anything on the safe stack."
> 
> Unfortunately, the use of two stack regions does not cope well with
> QEMU's coroutines. The second stack region is not properly set up with
> both ucontext and sigaltstack, so multiple coroutines end up sharing the
> same memory area for the unsafe stack, causing undefined behaviors at
> runtime (and most iochecks to fail).
> 
> This patch series fixes the implementation of the ucontext backend and
> make sure that sigaltstack is never used if the compiler is applying
> the SafeStack instrumentation. It also adds a configure flag to enable
> SafeStack, and enables iotests when SafeStack is used.
> 
> Changes since v1:
>   - CONFIG_SAFESTACK is now set up in configure, and not in the code
>   - Added option for a --disable-safe-stack in configure
>   - Configure checks if SafeStack is enabled by default in the compiler,
>     and set the CONFIG_SAFESTACK accordingly
>   - Updated some comments in the code and the commit log
> 
> NOTE: I kept configure as Patch #3.
> The reason is that the code changes will not be enabled without the
> configure, making the code fully functional if only Patches #1 or #2 are
> applied.
> On the other hand, the configure patch will produce incorrect code if we
> request SafeStack and the other patches are not applied.
> 
> Daniele Buono (4):
>    coroutine: support SafeStack in ucontext backend
>    coroutine: add check for SafeStack in sigaltstack
>    configure: add flags to support SafeStack
>    check-block: enable iotests with SafeStack
> 
>   configure                    | 73 ++++++++++++++++++++++++++++++++++++
>   include/qemu/coroutine_int.h |  5 +++
>   tests/check-block.sh         | 12 +++++-
>   util/coroutine-sigaltstack.c |  4 ++
>   util/coroutine-ucontext.c    | 26 +++++++++++++
>   5 files changed, 119 insertions(+), 1 deletion(-)
> 

