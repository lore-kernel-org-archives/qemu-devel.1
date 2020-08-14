Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B283C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:44:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0F420715
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 02:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0F420715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Phs-0005qi-Gy
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 22:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likaige@loongson.cn>)
 id 1k6Ph5-0005Qy-PO
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:43:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:55390 helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <likaige@loongson.cn>) id 1k6Ph1-0004v0-RS
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 22:43:47 -0400
Received: from [10.130.0.69] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxKMVX+jVfSbgIAA--.3S3;
 Fri, 14 Aug 2020 10:43:36 +0800 (CST)
Subject: Re: [PATCH 2/2] target/mips: Add definition of Loongson-3A3000 CPU
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
 <1597311707-27565-2-git-send-email-likaige@loongson.cn>
 <7772e88a-1f48-29ef-0004-e6eaa4eb5b60@flygoat.com>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <6c22034f-6bae-22f8-be52-74e00438c3b3@loongson.cn>
Date: Fri, 14 Aug 2020 10:43:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <7772e88a-1f48-29ef-0004-e6eaa4eb5b60@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxKMVX+jVfSbgIAA--.3S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xWFW3KrWkurW5JF4xJFb_yoW8Zw4xpa
 18AF4fCr15XrW3uan3JryUtF15JrWv9Fy8Cay3Kr1fCa40g398Wr4jyFWakFn2qr1kCF1f
 Za109a1UGF1SkrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JV
 WxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
 8wCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
 IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
 6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
 IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU8GZX5UUUUU==
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=likaige@loongson.cn;
 helo=loongson.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 22:43:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/13/2020 06:37 PM, Jiaxun Yang wrote:

>
>
> 在 2020/8/13 下午5:41, Kaige Li 写道:
>> Add definition of the Loongson-3A3000 processor in QEMU.
>
> Hi Kaige,
>
> We're not defining Loongson-3A3000 in QEMU because we have
> some features like Loongson-EXT2, VTLB not available currently, I'd
> prefer define it after we add these features to TCG.
>
> Loongson-3A4000's define is a exception to support KVM.
Ok, I see. This will be defined later, right?
Thanks.
Kaige.
>
> Thanks.
>
> - Jiaxun
>
>>
>> Signed-off-by: Kaige Li <likaige@loongson.cn>
>> ---
>>   target/mips/translate_init.inc.c | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/target/mips/translate_init.inc.c 
>> b/target/mips/translate_init.inc.c
>> index 0740819..2e98aff 100644
>> --- a/target/mips/translate_init.inc.c
>> +++ b/target/mips/translate_init.inc.c
>> @@ -829,6 +829,30 @@ const mips_def_t mips_defs[] = {
>>           .PABITS = 48,
>>           .insn_flags = CPU_LOONGSON3A,
>>           .mmu_type = MMU_TYPE_R4000,
>> +   },
>> +   {
>> +        .name = "Loongson-3A3000",
>> +        .CP0_PRid = 0x14630d,
>> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line 
>> size.  */
>> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << 
>> CP0C0_AT) |
>> +                       (MMU_TYPE_R4000 << CP0C0_MT),
>> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << 
>> CP0C1_MMU) |
>> +                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << 
>> CP0C1_IA) |
>> +                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << 
>> CP0C1_DA) |
>> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << 
>> CP0C1_EP),
>> +        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (5 << 
>> CP0C2_SL) |
>> +                       (15 << CP0C2_SA),
>> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
>> +        .SYNCI_Step = 16,
>> +        .CCRes = 2,
>> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
>> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << 
>> FCR0_F64),
>> +        .CP1_fcr31 = 0,
>> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
>> +        .SEGBITS = 48,
>> +        .PABITS = 48,
>> +        .insn_flags = CPU_LOONGSON3A,
>> +        .mmu_type = MMU_TYPE_R4000,
>>       },
>>       {
>>           .name = "Loongson-3A4000",


