Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 01:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC281208A9
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 01:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC281208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Jpl-0001fP-4e
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 21:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44350)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likaige@loongson.cn>)
 id 1k1JpC-00018l-Qy; Thu, 30 Jul 2020 21:27:06 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59994 helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <likaige@loongson.cn>)
 id 1k1JpA-0007Ct-5d; Thu, 30 Jul 2020 21:27:06 -0400
Received: from [10.130.0.69] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxOMRXcyNfZ8YCAA--.485S3;
 Fri, 31 Jul 2020 09:26:49 +0800 (CST)
Subject: Re: [PATCH v2 2/2] target/arm: Fix compile error.
To: Peter Maydell <peter.maydell@linaro.org>
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
 <1596110248-7366-2-git-send-email-likaige@loongson.cn>
 <CAFEAcA85xA=T389_M5_vjvm=TPirMqxNDt0za65G2NOfaDHdWA@mail.gmail.com>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <50913cde-f753-f1d3-efb6-8f71f54353d9@loongson.cn>
Date: Fri, 31 Jul 2020 09:26:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA85xA=T389_M5_vjvm=TPirMqxNDt0za65G2NOfaDHdWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxOMRXcyNfZ8YCAA--.485S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW3XryfAry7AFyrJrWfAFb_yoW8Jw43pF
 4fJwsIqF45JrWrCrs2kw48Xw15C3s3KryUAa17trn3WF1DGF1FqrZ7KrWakay2gF1DGw45
 Way7Z345Wan5AaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJV
 W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
 8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
 026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
 JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
 vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
 uYvjxUc2NtUUUUU
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=likaige@loongson.cn;
 helo=loongson.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 21:26:57
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
Cc: David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/31/2020 04:45 AM, Peter Maydell wrote:

> On Thu, 30 Jul 2020 at 12:58, Kaige Li <likaige@loongson.cn> wrote:
>> When I compile qemu with such as:
>>
>> git clone https://git.qemu.org/git/qemu.git
>> cd qemu
>> git submodule init
>> git submodule update --recursive
>> ./configure
>> make
>>
>> There is error log:
>>
>> /home/LiKaige/qemu/target/arm/translate-a64.c: In function ‘disas_ldst’:
>> /home/LiKaige/qemu/target/arm/translate-a64.c:3392:5: error: ‘fn’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>       fn(cpu_reg(s, rt), clean_addr, tcg_rs, get_mem_index(s),
>>       ^
>> /home/LiKaige/qemu/target/arm/translate-a64.c:3318:22: note: ‘fn’ was declared here
>>       AtomicThreeOpFn *fn;
>>                        ^
>> cc1: all warnings being treated as errors
>>
>> So, add an initiallization value NULL for fn to fix this.
>>
>> Signed-off-by: Kaige Li <likaige@loongson.cn>
> Hi; I've taken this patch (but not patch 1 in the series)
> into target-arm.next, with the commit message cleaned up
> to quote the compiler version.
Hi, did you mean I should commit this patch separately, not in a series 
of patches?
and the submission information should be added to the gcc version and 
cpu architecture?

Thanks for your patience and suggestion .
Kaige.
> thanks
> -- PMM


