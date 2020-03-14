Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A1BC0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:35:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB5B32072A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 17:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB5B32072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDAgs-0000cc-Ue
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 13:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jDAgF-0008WS-EQ
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jDAgD-0000rm-RU
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 13:34:35 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:51049)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jDAgD-0000ow-Ic; Sat, 14 Mar 2020 13:34:33 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N3sNa-1jMD9O2HB2-00zjuH; Sat, 14 Mar 2020 18:34:18 +0100
Subject: Re: [PATCH] linux-user: Update TASK_UNMAPPED_BASE for aarch64
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200313002813.3857-1-yuanzi@google.com>
 <CAL1e-=ghc+6GRMd3NToF6+DeAz1VSR6bxuKd7dBtSJwrj50ovQ@mail.gmail.com>
 <e7ce2848-fb44-3837-65bc-6b449c0e518e@vivier.eu>
 <CAL1e-=hwWP4ztFuLeXsywzz_JvE-j7_1U2CNsU=p7pFS9eva2w@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1a654687-0809-b142-7116-5958c51d8cd1@vivier.eu>
Date: Sat, 14 Mar 2020 18:34:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=hwWP4ztFuLeXsywzz_JvE-j7_1U2CNsU=p7pFS9eva2w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:t9Ezj9zvWQqK/iJyG6ZvaV1QlWLJoXtPxGJPCkaBTS5zNYNgx0w
 bAb45wim6vIWWrSybYnw0td8BQZpICGk6iwOgUXmeK+ddOlFAZlY/+1yr46Ie+gkPlEurQI
 jMjvTGKo6ND8PscC8hNJrNcV7Gc1rQzuiPm/Eih0hJ4aEwid4Y3iCeGSXD4dfIUyC+JrSix
 dbHoHOZxkOlr5TbzurDtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:V1pYdUk8wWE=:FR2AryxJ8dysWAG4Rq+Mne
 6aryX5cR5Li5EjQpZWraFAzS8+RiOd+JyjJy9b7OcF6TehRjqo8Hj/PlncdIPIXTwQgT/Kk8m
 /S+wz+EMRNetxQZ0TJ7vY3TmIIFVOpJSwsUJhzm7uauF6mm+sTiTQL6ytqD2U2ola0B01l7df
 GB2skA3J2JWkDSylEfJY3LNvFJF+D1raqHfh7pJe0heKjpCd5vS6P5Egdp0zSIJ0sThgmirFe
 Vu7j4LxPmgagilBClw9S3ModNipU4FlQ9c/9t7KhFSbqoVJdE8z5+9VgoXhi79vGWI4YYDR3L
 NvUEFIbCTXJvalvifBP45NS+z4u+g1FgKX4JfNSe7ptYvOayg9Q8wQrvO00LyxlxWumu54EwC
 HPYlzhepmKgq7ld4MQ9B9Od8V7ILkQ/YHn6jwUwYzuAj/4ymn1eGCM9UZMDfxWtQJkWE5RAoM
 BTIeRZjqm1hJqNVMBphZCh2oNiGYjN9aiznYg6tdvI7+vs7h0nqJ/rlVNHQiYOYKqcG7JJdoc
 7NimHjJLOJXytcMWu6veQYYwbnA8FP5AWXAvPSTiKxRhj1nnaTSGm/LW7LyEQkkwQiex461hb
 tle8RJ5/b/jeCzMiwWHAdzS50iP84OR7H6EryD9yqh/NDDiTyOealeAbHhdEsug8Bi4jBVne7
 Jmbg4+5hhY6qDFBD8DrUrV4v8SIf6pF7slumscTBc4bhVxpnKxKNyDI8hI4MGIgwe9BKqXKA2
 R8sshMKSuLL6HQS3henUptj1GoyBxlo9cT6N6C/A8whpJdCoOC/ASE6VWQW0GbTXsmbVLT72y
 I9TjieoId+enjjxrqtnEv+7bAHrxNlSWOROoN+uS4/RyYszu0q+2aSJSJAFXuY5PRLXBTWg
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>,
 Lirong Yuan <yuanzi@google.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Josh Kunz <jkz@google.com>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/03/2020 à 18:01, Aleksandar Markovic a écrit :
> On Sat, Mar 14, 2020 at 11:45 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 14/03/2020 à 04:06, Aleksandar Markovic a écrit :
>>> On Fri, Mar 13, 2020 at 1:28 AM Lirong Yuan <yuanzi@google.com> wrote:
>>>>
>>>> This change updates TASK_UNMAPPED_BASE (the base address for guest programs) for aarch64. It is needed to allow qemu to work with Thread Sanitizer (TSan), which has specific boundary definitions for memory mappings on different platforms:
>>>> https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h
>>>>
>>>> Signed-off-by: Lirong Yuan <yuanzi@google.com>
>>>> ---
>>>>  linux-user/mmap.c | 4 ++++
>>>>  1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
>>>> index 8685f02e7e..e378033797 100644
>>>> --- a/linux-user/mmap.c
>>>> +++ b/linux-user/mmap.c
>>>> @@ -184,7 +184,11 @@ static int mmap_frag(abi_ulong real_start,
>>>>  }
>>>>
>>>>  #if HOST_LONG_BITS == 64 && TARGET_ABI_BITS == 64
>>>> +#ifdef TARGET_AARCH64
>>>> +# define TASK_UNMAPPED_BASE  0x5500000000
>>>
>>> Hi, Lirong,
>>>
>>> Can you point from which line of the file you linked to did you
>>> arrive to the value 0x5500000000?
>>>
>>> Second question: What about other targets?
>>
>> Personally, I prefer to not change the value for other targets if it is
>> not required by someone that had some problems with the current value.
>>
>> It needs to be changed carefully and to be well tested after change.
>>
> 
> Sure, but again, from where " 0x5500000000" comes from?

The URL is in the comment, but more precisely I guess:

 https://github.com/llvm/llvm-project/blob/master/compiler-rt/lib/tsan/rtl/tsan_platform.h#L164

Thanks,
Laurent


