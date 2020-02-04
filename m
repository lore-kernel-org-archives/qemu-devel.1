Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D92C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178CA2082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178CA2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz6nO-0006lS-Aq
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 17:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iz6me-0006Gc-Kr
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iz6md-0008Os-El
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:35:04 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:57267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iz6md-0008Nr-5o
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:35:03 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M5PVb-1izw7l3aAX-001PLN; Tue, 04 Feb 2020 23:34:45 +0100
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1578947683-21011-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1578947683-21011-6-git-send-email-aleksandar.markovic@rt-rk.com>
 <93e1c210-2f0d-2ab1-d933-2889939396db@vivier.eu>
 <CAL1e-=hMS0-E7c_gW-m9Mk6ZeCSzdDwmhmYnNUGhor2o_KEhBQ@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v5 05/20] linux-user: mips: Update syscall numbers to
 kernel 5.5 rc3 level
Message-ID: <96c7bed8-8292-bd35-ba79-717cf543fa47@vivier.eu>
Date: Tue, 4 Feb 2020 23:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hMS0-E7c_gW-m9Mk6ZeCSzdDwmhmYnNUGhor2o_KEhBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hUpFRbe7jb457KURTMcWYDczKgd4txrx69bUGQcNsrSAyO83h30
 yaK7Oi14ZmlZqo+oX79FQ83kRbFQALHXc/IR97WjGAgXAlC97c9ZUqUaz17769rjuCwID1a
 ogVT6ZsDuDmZi8NoAbP5CkbmhEZV5wwhENSejYN6qYgyD/U35caN85EGvhCDUwcKU5n9PF+
 U7voevF1nt6UpoHsNCHnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EhfbTQoqaYc=:rZVaUTfVUefoznSZumI5YD
 zb3vgrZ+1rg3L/FzdDLhh7r3eZUerTiDkxW+5DNzsEXXo6gVNWXlXw/czifxHVnTrqx3nUj1+
 hsVGNiOYtgYbB5GuecZYSWqwoTyk2zF8N6HkJRq99FAV/T2ZNpe3orFiGhnFms5E/xr93ZZwh
 F0KzH8RuNhBMbSJWRWSKdy6yxuEWXKEb8O1Bcyh9hR6YdvRmnAxfdI8LVGFkve9CnqQN/RUDK
 ZYCtntLCuUVxR2nLOlFhNR0jLAbU6z/OdJTfm3IFlfCn/UpWDqBhCN81ARrZK4dBOafxMOmwo
 YbH0JAVe/iRp2ryVKD6p6ODzNhvSSF1+SKGP3TAkiuz997uaB0neSITgFpdsyK2xAiX+incWr
 0mAyIF5dQkqhFg2zoJTxiwwuELZqkBKp2HGAuNKXQ35uv8oeLilDeZBFyj5QpJSQp5xjxYEru
 p/KlOROIlYqChAzU/sKMQW3xWCPgIE675QkPIARt8/Vdfyeaqjtn2KYziGkdoqjS9Oo63lto5
 kpEltg7D+Waz4BdYCH3xt0E5w/CfCUDSBVwLlngjzBuSFxGVCGXyz5rMOsBcO51B8Onnjp1rS
 m/4eqAog6XYBxNTQS8gxYr1DS0A+dIySMvm0olD1KF3wfLHIh2Zuw4HMKYfWvvHp8XMbqnMSa
 HYP0w6nMQ7usxEblv9HDPE1Vmp+9imH1gdUsj8FhHRdXAYR8k9ensSoQYFOOd27PF4WGzzstq
 P4rJpAB25eY10qf0exCVORM6gM/g5aSqJETjHPMx/tIZAyeB/fhiIs6ywp4UvB5tCqj/mVLFM
 DOfOajCwpCDggva0AG5sHL0IbufcbbNVEalR7cxaTZ2FCLsLsqRfvdoxlObFhr1C44HJwe9
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/02/2020 à 12:56, Aleksandar Markovic a écrit :
> On Tue, Jan 14, 2020 at 5:40 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 13/01/2020 à 21:34, Aleksandar Markovic a écrit :
>>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>>
>>> Update mips syscall numbers based on Linux kernel tag v5.5-rc3
>>> (commit 46cf053e).
>>>
>>> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
>>> ---
>>>  linux-user/mips/cpu_loop.c     | 78 +++++++++++++++++++++++++++++++++++++++++-
>>>  linux-user/mips/syscall_nr.h   | 45 ++++++++++++++++++++++++
>>>  linux-user/mips64/syscall_nr.h | 13 +++++++
>>>  3 files changed, 135 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
>>> index 39915b3..b81479b 100644
>>> --- a/linux-user/mips/cpu_loop.c
>>> +++ b/linux-user/mips/cpu_loop.c
>>> @@ -25,8 +25,9 @@
>>>  #include "internal.h"
>>>
>>>  # ifdef TARGET_ABI_MIPSO32
>>> +#  define MIPS_SYSCALL_NUMBER_UNUSED -1
>>
>> I'm not sure you need to introduce this change.
>>
>> The case already exists (stat, fstat, old_select, lstat, ...) and the
>> entry that was used is:
>>
>>            MIPS_SYS(sys_ni_syscall , 0)
>>
>> perhaps you can do the same ?
>>
> 
> I like better the new way of dealing with this (like in this patch), since it is
> more explicit. For now, I won't change this patch, if you agree, and later on
> I will synchronize all such cases to be the same (but this is not critical for
> the time being).

So Perhaps you can do:

#  define MIPS_SYSCALL_NUMBER_UNUSED 0

And so the real availability of the syscall will be detected in
do_syscall1() based on a "#ifdef TARGET_XXXX" (well, not sure
syscall_nr.h differentiates O32 and N32)

By the way, do we really need this table?

It seems kernel is always copying 4 words from the stack.
But kernel code is not really clear, perhaps I'm missing something...

In the end, as you are the MIPS maintainer, you can choose the solution
you prefer.

Thanks,
Laurent

