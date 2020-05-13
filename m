Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA79C43467
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D0920897
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 14:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D0920897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYshO-00074c-1T
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 10:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jYsgC-0006O6-RQ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:48:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbuono@linux.vnet.ibm.com>)
 id 1jYsgB-00070y-5H
 for qemu-devel@nongnu.org; Wed, 13 May 2020 10:48:16 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04DEWKEQ009170; Wed, 13 May 2020 10:48:10 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3101maet5m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 10:48:10 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04DEYsxJ027295;
 Wed, 13 May 2020 10:48:10 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com
 [169.63.121.186])
 by mx0a-001b2d01.pphosted.com with ESMTP id 3101maet4n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 10:48:10 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
 by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04DEl8OU025719;
 Wed, 13 May 2020 14:48:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03wdc.us.ibm.com with ESMTP id 3100ub79bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2020 14:48:08 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04DEm7pd25559398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2020 14:48:07 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9BCE6A051;
 Wed, 13 May 2020 14:48:07 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C47C66A047;
 Wed, 13 May 2020 14:48:06 +0000 (GMT)
Received: from [9.160.50.49] (unknown [9.160.50.49])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2020 14:48:06 +0000 (GMT)
Subject: Re: [PATCH 0/4] Add support for SafeStack
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200429194420.21147-1-dbuono@linux.vnet.ibm.com>
 <51f28cf2-0f34-508f-96f8-02c02b3c8a85@redhat.com>
 <20200505133111.GM764268@redhat.com>
 <c6ac2d0e-34bf-9927-f2fe-2ef0408dcbfb@redhat.com>
From: Daniele Buono <dbuono@linux.vnet.ibm.com>
Message-ID: <7f6916f8-c559-ebae-e6b2-75083f3ff2e5@linux.vnet.ibm.com>
Date: Wed, 13 May 2020 10:48:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c6ac2d0e-34bf-9927-f2fe-2ef0408dcbfb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-13_06:2020-05-13,
 2020-05-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 cotscore=-2147483648 clxscore=1011 malwarescore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005130126
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=dbuono@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 10:48:11
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello everybody, just pinging since it it's been a few days.

On 5/5/2020 9:56 AM, Philippe Mathieu-Daudé wrote:
> On 5/5/20 3:31 PM, Daniel P. Berrangé wrote:
>> On Tue, May 05, 2020 at 03:15:18PM +0200, Philippe Mathieu-Daudé wrote:
>>> +Alex & Daniel who keep track on CI stuff.
>>>
>>> On 4/29/20 9:44 PM, Daniele Buono wrote:
>>>> LLVM supports SafeStack instrumentation to protect against stack buffer
>>>> overflows, since version 3.7
>>>>
>>>>   From https://clang.llvm.org/docs/SafeStack.html:
>>>> "It works by separating the program stack into two distinct regions: 
>>>> the
>>>> safe stack and the unsafe stack. The safe stack stores return 
>>>> addresses,
>>>> register spills, and local variables that are always accessed in a safe
>>>> way, while the unsafe stack stores everything else. This separation
>>>> ensures that buffer overflows on the unsafe stack cannot be used to
>>>> overwrite anything on the safe stack."
>>>>
>>>> Unfortunately, the use of two stack regions does not cope well with
>>>> QEMU's coroutines. The second stack region is not properly set up with
>>>> both ucontext and sigaltstack, so multiple coroutines end up sharing 
>>>> the
>>>> same memory area for the unsafe stack, causing undefined behaviors at
>>>> runtime (and most iochecks to fail).
>>>>
>>>> This patch series fixes the implementation of the ucontext backend and
>>>> make sure that sigaltstack is never used if the compiler is applying
>>>> the SafeStack instrumentation. It also adds a configure flag to enable
>>>> SafeStack, and enables iotests when SafeStack is used.
>>>>
>>>> This is an RFC mainly because of the low-level use of the SafeStack
>>>> runtime.
>>>> When running swapcontext(), we have to manually set the unsafe stack
>>>> pointer to the new area allocated for the coroutine. LLVM does not 
>>>> allow
>>>> this by using builtin, so we have to use implementation details that 
>>>> may
>>>> change in the future.
>>>> This patch has been tested briefly ( make check on an x86 system ) with
>>>> clang v3.9, v4.0, v5.0, v6.0
>>>> Heavier testing, with make check-acceptance has been performed with
>>>> clang v7.0
>>>
>>> I noticed building using SafeStack is slower, and running with it is 
>>> even
>>> sloooower. It makes sense to have this integrated if we use it 
>>> regularly. Do
>>> you have plan for this? Using public CI doesn't seem reasonable.
>>
>> The runtime behaviour is rather odd, given the docs they provide:
>>
>> "The performance overhead of the SafeStack instrumentation is
>>   less than 0.1% on average across a variety of benchmarks
>>   This is mainly because most small functions do not have any
>>   variables that require the unsafe stack and, hence, do not
>>   need unsafe stack frames to be created. The cost of creating
>>   unsafe stack frames for large functions is amortized by the
>>   cost of executing the function.
>>
>>    In some cases, SafeStack actually improves the performance"
> 
> I'm sorry I was testing this with a single core instead of all of 
> them... Thanks for looking at the doc.
> 
>>
>> Regards,
>> Daniel
>>
> 
> 

