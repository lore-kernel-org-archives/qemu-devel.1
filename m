Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D2C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCA7E2081E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA7E2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlqh-0001bl-BD
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irlom-0000Ke-DG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irloi-0002D8-6w
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:46:56 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:33293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irloh-0002CV-UB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 11:46:52 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M1pk6-1ipZxF2jtI-002Hvz; Wed, 15 Jan 2020 17:46:30 +0100
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1579103618-20217-1-git-send-email-Filip.Bozuta@rt-rk.com>
 <1579103618-20217-4-git-send-email-Filip.Bozuta@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 03/12] linux-user: Add support for getting/setting RTC
 periodic interrupt and epoch using ioctls
Message-ID: <b44fea10-5ea8-c6e7-994b-42fb3ea5d753@vivier.eu>
Date: Wed, 15 Jan 2020 17:46:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579103618-20217-4-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DyRO1EkBfeZ+QhvGKbi+1FlfaiKRbOMFHeJZJ0bS5IInXq5uyAo
 Wuj371SVnDyG5KY8VFo/4XCmtce5I65z7P27QiUmQKLgPMmllgF3cxB5wKzHs+3UXaIRPSa
 BorBbCil9L5FGB8oFXolimiaxzBnSO3zlrZQ94yNNP3ljD8o/OHWknqVNtRovyBD4Mk7n55
 NogVg3HONNvgiW9FpoqYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FYNJzsbPZ8k=:YDIe8vkEYDsM1E2afbbhVX
 Ow1shpF0sLkBVQz5cLE9SBcsVwtEMNYVCMG1E1lqbdOg2K3rJ3NAGIJWeE0IMBnAPnHjrLR3U
 I0vUjG8t/LHn4uDgiuFfG9vlKAbrp5PF0GU3OncxGWp6mOK3qSpY4atkLOHNw28rxgVao8tGe
 l5j5Cz4Et/pR+bbA8EiSvZJFSLElZK3Li2opobqxW3oJRX/fE+mbxKJufA7ZmwNOgHbQMxOep
 Gt178PuQ5zMa7PCh6I+7DzMYZ9TJRFev+kYM1bR6FZl+K4T+zdN9iQvZiipqeE/APNKhxngTW
 fpB9vrHQ7Su7YsL3oCjL5SMaMIfBjJ+nrHX/Q6l77Hh0REftos+BxpYYfil7iWuYiuv0wh96S
 zOANMnmr74iF8Qk98SW8mHsPlQZKl5oLpeIsjtGlK2Wv3qWGOnDW7ld/pvr+PFJLAjbIZkKEN
 M6z7WwnySgHfP1ggH0CNqVa+u0HQPgN9bCq7W4y+u58FuEGa2NXOMuaDMCuSop9pLYG3HIYQ+
 RIsZsyVopJc2hgDYk5b6dfA/yK6UVrW/3Co48ds0aH+2UOEXprN7QNcU5Iojp/7qmOb/bymhi
 TwfqPtXqwG+dKTW6GfWPFO7MMjS0LSZ2k0a6mquPw4RV4N4RMZJLI+EXJAC5CNNVP38HGDVKn
 QoSxQrxYpHwBXb9PEZCS9kkjFDMpuI61/qSfbPUTEyWlewDjoLtTkT+KXue4E7CaawRUj+kbw
 r3BLk0O+YQY2h7wS1Yfe0dJV6zny6nlytPJHyIlTnlhDjRtc5WXwbVD4bEZZqdCq4T7fa4aru
 vSZ1pMgTldekgEwTWQcp841xquMzrpmOTnp1h30O6fJfpTLAcY3NqOSDIEZYXkd0/tWTHQd6x
 FffvGMxOTGtb2QJ0MYJv3pyH22QeQXv8M/o4EsgZs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.75
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, arnd@arndb.de,
 richard.henderson@linaro.org, jcmvbkbc@gmail.com, amarkovic@wavecomp.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 15/01/2020 à 16:53, Filip Bozuta a écrit :
> This patch implements functionalities of following ioctls:
> 
> RTC_IRQP_READ, RTC_IRQP_SET - Getting/Setting IRQ rate
> 
>     Read and set the frequency for periodic interrupts, for RTCs
>     that support periodic interrupts. The periodic interrupt must
>     be separately enabled or disabled using the RTC_PIE_ON,
>     RTC_PIE_OFF requests. The third ioctl's argument is an
>     unsigned long * or an unsigned long, respectively. The value
>     is the frequency in interrupts per second. The set of allow‐
>     able frequencies is the multiples of two in the range 2 to
>     8192. Only a privileged process (i.e., one having the
>     CAP_SYS_RESOURCE capability) can set frequencies above the
>     value specified in /proc/sys/dev/rtc/max-user-freq. (This
>     file contains the value 64 by default.)
> 
> RTC_EPOCH_READ, RTC_EPOCH_SET - Getting/Setting epoch
> 
>     Many RTCs encode the year in an 8-bit register which is either
>     interpreted as an 8-bit binary number or as a BCD number. In
>     both cases, the number is interpreted relative to this RTC's
>     Epoch. The RTC's Epoch is initialized to 1900 on most systems
>     but on Alpha and MIPS it might also be initialized to 1952,
>     1980, or 2000, depending on the value of an RTC register for
>     the year. With some RTCs, these operations can be used to
>     read or to set the RTC's Epoch, respectively. The third
>     ioctl's argument is an unsigned long * or an unsigned long,
>     respectively, and the value returned (or assigned) is the
>     Epoch. To set the RTC's Epoch the process must be privileged
>     (i.e., have the CAP_SYS_TIME capability).
> 
> Implementation notes:
> 
>     All ioctls in this patch have a pointer to 'ulong' as their
>     third argument. That is the reason why corresponding parts
>     of added code in linux-user/syscall_defs.h contain special
>     handling related to 'ulong' type: they use 'abi_ulong' type
>     to make sure that ioctl's code is calculated correctly for
>     both 32-bit and 64-bit targets. Also, 'MK_PTR(TYPE_ULONG)'
>     is used for the similar reason in linux-user/ioctls.h.
>     Because ioctls RTC_IRQP_SET and RTC_EPOCH_SET are ioctls of
>     type IOW(writing type) that have unsigned long as their
>     third argument, a case statement for "TYPE_ULONG" was added
>     in the appropriate place for function "abi_ulong do_ioctl"
>     in file "syscall.c". There were no implemented ioctls of
>     type IOW with unsigned long as third argument before this
>     patch, which is the reason why this case statement was added
>     now for the first time.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
> ---
>  linux-user/ioctls.h       | 4 ++++
>  linux-user/syscall.c      | 1 +
>  linux-user/syscall_defs.h | 4 ++++
>  3 files changed, 9 insertions(+)
> 
...
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 74c3c08..c0b7314 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5175,6 +5175,7 @@ static abi_long do_ioctl(int fd, int cmd, abi_long arg)
>          break;
>      case TYPE_PTRVOID:
>      case TYPE_INT:
> +    case TYPE_ULONG:
>          ret = get_errno(safe_ioctl(fd, ie->host_cmd, arg));
>          break;
>      case TYPE_PTR:

I think this can go in a separate patch as it's a fix.

You should also add TYPE_LONG.

Thanks,
Laurent

