Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FCC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:23:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 160D120728
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 02:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160D120728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXxbI-0004US-10
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 22:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kXxag-0003yG-8K; Wed, 28 Oct 2020 22:23:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaolichang@huawei.com>)
 id 1kXxad-0006LJ-EY; Wed, 28 Oct 2020 22:23:01 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CM8Nk0CZmzkb7k;
 Thu, 29 Oct 2020 10:22:46 +0800 (CST)
Received: from [10.174.186.238] (10.174.186.238) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 10:22:42 +0800
Subject: Re: [PATCH V2 00/14] fix some comment spelling errors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <a5a68476-0ed8-08f9-f993-464317d798bf@huawei.com>
 <CAAdtpL5HZzb+_gAyNGQfM1N7vBxmLck2TXiGohv9D9dgO16cRw@mail.gmail.com>
From: Lichang Zhao <zhaolichang@huawei.com>
Message-ID: <67ce4e9b-703d-8639-e223-a0e77e54e5cc@huawei.com>
Date: Thu, 29 Oct 2020 10:22:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAAdtpL5HZzb+_gAyNGQfM1N7vBxmLck2TXiGohv9D9dgO16cRw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.186.238]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=zhaolichang@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 22:22:46
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.921,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you very much. But I don't know how to do that. Can you help me?
By the way, this series of patches have been reviewed and four of them have been applied. Can you help me to apply the rest?


On 2020/10/20 14:42, Philippe Mathieu-Daudé wrote:
> You forgot to Cc qemu-devel@.
> 
> (See https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer)
> 
> On Tue, Oct 20, 2020 at 4:46 AM Lichang Zhao <zhaolichang@huawei.com> wrote:
> 
> Now your name is properly displayed, so I assume you finally ran:
> 
> $ git config user.name "Lichang Zhao".
> 
> To fix how your name is displayed in your previous contributions,
> consider sending this patch:
> 
> -- >8 --
> diff --git a/.mailmap b/.mailmap
> index 663819fb017..a56c5ba5ee1 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -113,6 +113,7 @@ Liu Yu <yu.liu@freescale.com>
> Liu Yu <Yu.Liu@freescale.com>
> Li Zhang <zhlcindy@gmail.com>
> Li Zhang <zhlcindy@linux.vnet.ibm.com>
> +Lichang Zhao <zhaolichang@huawei.com>
> Lluís Vilanova <vilanova@ac.upc.edu>
> Lluís Vilanova <xscript@gmx.net>
> Longpeng (Mike) <longpeng2@huawei.com>
> 
> ---
> 
> (or Ack-by it here and I'll send it).
> 
>>
>> On 2020/10/9 14:44, zhaolichang wrote:
>>> I found that there are many spelling errors in the comments of qemu/target/.
>>>
>>> I used spellcheck to check the spelling errors and found some errors in the folder.
>>>
>>>
>>>
>>> The checkpatch.pl file in the Linux kernel can check spelling errors in patches.
>>>
>>> I'm trying to add this function to the checkpatch.pl in qemu,
>>>
>>> so that no similar spelling errors will occur in the feture.
>>>
>>> It's not done yet and I will commit the patch when it's done.
>>>
>>>
>>>
>>> v1 -> v2:
>>>
>>>   add reviewed-by for patch
>>>
>>>
>>>
>>> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
>>>
>>
>> ping
>> This series of patches have been reviewed. Can you help me to pull them?
>>
> .
> 

