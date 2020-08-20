Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51117C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2707B207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 07:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2707B207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8fG9-0006YB-E5
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 03:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <likaige@loongson.cn>)
 id 1k8fFb-00067x-2M
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:44:43 -0400
Received: from mail.loongson.cn ([114.242.206.163]:43480 helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <likaige@loongson.cn>) id 1k8fFY-0007UQ-OY
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 03:44:42 -0400
Received: from [10.130.0.69] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX93bKT5feHALAA--.1174S3;
 Thu, 20 Aug 2020 15:44:28 +0800 (CST)
Subject: Re: [PATCH 2/2] target/mips: Add definition of Loongson-3A3000 CPU
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
References: <1597311707-27565-1-git-send-email-likaige@loongson.cn>
 <1597311707-27565-2-git-send-email-likaige@loongson.cn>
 <7772e88a-1f48-29ef-0004-e6eaa4eb5b60@flygoat.com>
 <6c22034f-6bae-22f8-be52-74e00438c3b3@loongson.cn>
 <5ccb1a7e-f56e-0d0e-ee40-3bff1b1ad4c6@flygoat.com>
From: Kaige Li <likaige@loongson.cn>
Message-ID: <40e89d5d-e503-78c2-41bb-a0cf3cb125b6@loongson.cn>
Date: Thu, 20 Aug 2020 15:44:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <5ccb1a7e-f56e-0d0e-ee40-3bff1b1ad4c6@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxX93bKT5feHALAA--.1174S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDXry5Kr4Dtw15Gr17Wrg_yoW3KFc_Cr
 1ak3Z7Ar47GF1IkrWDtFWDJ3ZxWF4kGw45KrWUtr4xZwnFyFyUZ3WDu3s7C3ZxWr48JrZI
 9ryvqa43Cw4fWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbs8YjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
 c2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
 0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
 AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
 CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
 aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
 ZEXa7IU8RBT5UUUUU==
X-CM-SenderInfo: 5olntxtjh6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=likaige@loongson.cn;
 helo=loongson.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:44:30
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



On 08/14/2020 10:48 AM, Jiaxun Yang wrote:
>
>
> 在 2020/8/14 上午10:43, Kaige Li 写道:
>> On 08/13/2020 06:37 PM, Jiaxun Yang wrote:
>>
>>>
>>>
>>> 在 2020/8/13 下午5:41, Kaige Li 写道:
>>>> Add definition of the Loongson-3A3000 processor in QEMU.
>>>
>>> Hi Kaige,
>>>
>>> We're not defining Loongson-3A3000 in QEMU because we have
>>> some features like Loongson-EXT2, VTLB not available currently, I'd
>>> prefer define it after we add these features to TCG.
>>>
>>> Loongson-3A4000's define is a exception to support KVM.
>> Ok, I see. This will be defined later, right?
> Yes..
>
> If you're willing to help I'd suggest you to take a look at how to 
> implement
> Loongson SPW (LDPTE LDDIR etc) in QEMU.
Ok, I'll analyze it carefully.

thanks.
-Kaige
>
>
> Thanks.
>
> - Jiaxun
>
>>
>> Thanks.
>> Kaige.
>>>
>>> Thanks.
>>>
>>> - Jiaxun


