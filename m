Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC3EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:53:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231F0207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 03:53:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231F0207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1M6U-0004HX-9u
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 23:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likaige@loongson.cn>)
 id 1k1M5l-0003m6-OF; Thu, 30 Jul 2020 23:52:21 -0400
Received: from mail.loongson.cn ([114.242.206.163]:34858 helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <likaige@loongson.cn>)
 id 1k1M5i-0004vt-TA; Thu, 30 Jul 2020 23:52:21 -0400
Received: from [10.130.0.69] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX99ilSNf8dQCAA--.603S3;
 Fri, 31 Jul 2020 11:52:03 +0800 (CST)
Subject: Re: [PATCH v2 1/2] virtio-mem: Change PRIx32 to PRIXPTR to fix
 compile error.
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <1596110248-7366-1-git-send-email-likaige@loongson.cn>
 <601c098c-0f39-92be-8800-99f5fe99399f@redhat.com>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <10b4681c-a129-3735-0395-7439b7d48742@loongson.cn>
Date: Fri, 31 Jul 2020 11:52:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <601c098c-0f39-92be-8800-99f5fe99399f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX99ilSNf8dQCAA--.603S3
X-Coremail-Antispam: 1UD129KBjvJXoW7urW8JrWxGw4rJFW8KF13XFb_yoW8CryDpw
 4xJ3ZYkw4UJr13Aan2q3WrWa4DCwn3GrnrtF4aqr15WFn8ur92gr4jkr4rWFW3Zr1DZw43
 uryIgryYq3Z8ZaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
 F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F
 4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
 W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpVbUUUUU
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=likaige@loongson.cn;
 helo=loongson.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 23:52:09
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/30/2020 09:15 PM, Philippe Mathieu-Daudé wrote:
> On 7/30/20 1:57 PM, Kaige Li wrote:
>> When I compile qemu with such as:
>>
>> git clone https://git.qemu.org/git/qemu.git
>> cd qemu
>> git submodule init
>> git submodule update --recursive
>> ./configure
>> make
> ^ this timeless description is pointless (think at a developer
> who read this in 2 weeks, 3 months, 1 year).
Thanks for your suggestions, I will delete it.
>
>> There is error log:
>>
>> /home/LiKaige/qemu/hw/virtio/virtio-mem.c: In function ‘virtio_mem_set_block_size’:
>> /home/LiKaige/qemu/hw/virtio/virtio-mem.c:756:9: error: format ‘%x’ expects argument of type ‘unsigned int’, but argument 7 has type ‘uintptr_t’ [-Werror=format=]
> What compiler are you using? That is the relevant information to
> include.
Gcc version is 4.9.4.
>
>>           error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
>>           ^
>> cc1: all warnings being treated as errors
>> /home/LiKaige/qemu/rules.mak:69: recipe for target 'hw/virtio/virtio-mem.o' failed
>>
>> So, change PRIx32 to PRIXPTR to fix this.
>>
>> Signed-off-by: Kaige Li <likaige@loongson.cn>
>> ---
>>   hw/virtio/virtio-mem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>> index c12e9f7..3dcaf9a 100644
>> --- a/hw/virtio/virtio-mem.c
>> +++ b/hw/virtio/virtio-mem.c
>> @@ -753,7 +753,7 @@ static void virtio_mem_set_block_size(Object *obj, Visitor *v, const char *name,
>>       }
>>   
>>       if (value < VIRTIO_MEM_MIN_BLOCK_SIZE) {
>> -        error_setg(errp, "'%s' property has to be at least 0x%" PRIx32, name,
>> +        error_setg(errp, "'%s' property has to be at least 0x%" PRIXPTR "\n", name,
>>                      VIRTIO_MEM_MIN_BLOCK_SIZE);
>>           return;
>>       } else if (!is_power_of_2(value)) {
>>


