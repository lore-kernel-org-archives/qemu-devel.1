Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0EAC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:22:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9C720825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9C720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZbH-0007Ni-7U
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaZaW-0006p3-NH; Thu, 05 Nov 2020 02:21:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shiliyang@huawei.com>)
 id 1kaZaT-0003gc-9C; Thu, 05 Nov 2020 02:21:40 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CRZh43tznzLsns;
 Thu,  5 Nov 2020 15:21:24 +0800 (CST)
Received: from [10.108.235.13] (10.108.235.13) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Thu, 5 Nov 2020 15:21:20 +0800
Subject: Re: [PATCH 1/4] bsd-user: space required after semicolon
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth
 <thuth@redhat.com>, <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <alex.bennee@linaro.org>, <laurent@vivier.eu>
References: <fc9d7415-a17f-2958-69fd-0b5f54e553a1@huawei.com>
 <b7231b6c-97ad-5b4c-0932-08fa331dbb30@huawei.com>
 <28961057-f570-a203-e098-6ec0d5be3f75@redhat.com>
 <52c7980b-33bc-7e76-b985-9df77259f33b@redhat.com>
From: shiliyang <shiliyang@huawei.com>
Message-ID: <407b8311-7177-e2bb-202c-d8386488fc55@huawei.com>
Date: Thu, 5 Nov 2020 15:21:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <52c7980b-33bc-7e76-b985-9df77259f33b@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.108.235.13]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=shiliyang@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:50:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: alex.chen@huawei.com, hunongda@huawei.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/11/4 19:13, Philippe Mathieu-Daudé wrote:
> On 11/4/20 12:08 PM, Thomas Huth wrote:
>> On 04/11/2020 11.20, shiliyang wrote:
>>> This patch fixes error style problems found by checkpatch.pl:
>>> ERROR: space required after that ';'
>>>
>>> Signed-off-by: Liyang Shi <shiliyang@huawei.com>
>>>
>>> ---
>>>  bsd-user/elfload.c | 2 +-
>>>  bsd-user/syscall.c | 4 ++--
>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/bsd-user/elfload.c b/bsd-user/elfload.c
>>> index 9f4210af9a..25e625d86b 100644
>>> --- a/bsd-user/elfload.c
>>> +++ b/bsd-user/elfload.c
>>> @@ -1227,7 +1227,7 @@ int load_elf_binary(struct linux_binprm *bprm, struct target_pt_regs *regs,
>>>      end_data = 0;
>>>      interp_ex.a_info = 0;
>>>
>>> -    for(i=0;i < elf_ex.e_phnum; i++) {
>>> +    for(i=0; i < elf_ex.e_phnum; i++) {
>>
>> While you're at it, please also add white spaces around the "=" in that line.
> 
Yes, thanks for your review, I will fix it.
> IOW please run checkpatch after fixing a checkpatch issue ;)
> 
Thanks for your advise, I missed this operation. I will fix other checkpatch issues first then send new patch.
> .
> 
Thanks.

