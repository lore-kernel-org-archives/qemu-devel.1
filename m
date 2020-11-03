Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534C7C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B784522226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B784522226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx6P-0005Oi-NI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZwwe-00028N-5A
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:05:56 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.chen@huawei.com>)
 id 1kZwwa-0004Pc-RC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:05:55 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQWlS5Mq7zkZ0k;
 Tue,  3 Nov 2020 22:05:40 +0800 (CST)
Received: from [10.174.187.138] (10.174.187.138) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Nov 2020 22:05:35 +0800
Message-ID: <5FA163AF.2020007@huawei.com>
Date: Tue, 3 Nov 2020 22:05:35 +0800
From: AlexChen <alex.chen@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64;
 rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
References: <5FA12391.8090400@huawei.com>
 <ad70d1f3-ba98-3977-f2ac-a14d03c7e7ba@flygoat.com>
In-Reply-To: <ad70d1f3-ba98-3977-f2ac-a14d03c7e7ba@flygoat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.138]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=alex.chen@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, chenhc@lemote.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020/11/3 17:53, Jiaxun Yang wrote:
> 
> 
> ÔÚ 2020/11/3 17:32, AlexChen Ð´µÀ:
>> According to the loongson spec
>> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
>> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
>> that the ISR size of per CORE is 8, so here we need to divide
>> (addr - R_PERCORE_ISR(0)) by 8, not 4.
> Hi Alex
> 
> Thanks!
> 
> That was my fault.. Per Core ISA is rarely used by kernel..
> 
> Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
> Btw:
> How can you discover this by robot?
> Huawei owns real artifical intelligence technology lol :-£©
> 
> 

Thanks for your review.
EulerRobot is a virtualization software quality automation project that
integrates some tools and test suites such as gcc/clang make test, qemu ut,
qtest, coccinelle scripts and avocado-vt.
The code checking tool found there was a potential array out of bounds at
'r = p->per_core_isr[core]', since 'core' may be 7 which is bigger than
'per_core_isr' array size 3.
So we found this bug.

Thanks,
Alex

> - Jiaxun
>> Signed-off-by: Alex Chen <alex.chen@huawei.com>
>> ---
>>   hw/intc/loongson_liointc.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
>> index 30fb375b72..fbbfb57ee9 100644
>> --- a/hw/intc/loongson_liointc.c
>> +++ b/hw/intc/loongson_liointc.c
>> @@ -130,7 +130,7 @@ liointc_read(void *opaque, hwaddr addr, unsigned int size)
>>
>>       if (addr >= R_PERCORE_ISR(0) &&
>>           addr < R_PERCORE_ISR(NUM_CORES)) {
>> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
>> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>>           r = p->per_core_isr[core];
>>           goto out;
>>       }
>> @@ -173,7 +173,7 @@ liointc_write(void *opaque, hwaddr addr,
>>
>>       if (addr >= R_PERCORE_ISR(0) &&
>>           addr < R_PERCORE_ISR(NUM_CORES)) {
>> -        int core = (addr - R_PERCORE_ISR(0)) / 4;
>> +        int core = (addr - R_PERCORE_ISR(0)) / 8;
>>           p->per_core_isr[core] = value;
>>           goto out;
>>       }
> .
> 


