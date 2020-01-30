Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3A5C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20DE5206D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 10:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20DE5206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ix71q-0004Vm-CR
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 05:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1ix71A-00044f-Qs
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1ix719-0001lu-Hc
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:25:48 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:49901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1ix719-0001ki-8J
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 05:25:47 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MfYgC-1jTyvs30NU-00fxBw; Thu, 30 Jan 2020 11:25:40 +0100
Subject: Re: [PATCH] Handling SIGSETXID used by glibc NPTL setuid/setgid
From: Laurent Vivier <laurent@vivier.eu>
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200116115700.127951-1-mkysel@tachyum.com>
 <CAFEAcA_pOAX=pCk0TfbwwUPHUX2YhLtxMonYVazMrGZBvPJkPw@mail.gmail.com>
 <b4ca6094-28a4-28a9-4e6f-315cfad2cf49@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f753ee66-f9e6-e196-9915-a0a875982999@vivier.eu>
Date: Thu, 30 Jan 2020 11:25:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <b4ca6094-28a4-28a9-4e6f-315cfad2cf49@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3E8vcZcoEIHhm7WNhCMilbGRGrHbYsBVeg1RgpjvQ0WpaF0GW14
 nPiXldczeunV45+YfRqMGAjfAHHx7GG2JTHosKM27bVzc2eSMT4sug4ylAdmGhgTCG90Xjz
 RdrlO1ru0VgdzQaxdQKxtueCB2wHNBJM0N7jgMFgp44sW14d75MR9nC8G8qZU/msw15dVWN
 2Q9CUdJaidct6ZZ3UFpaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7eo6jye3MOo=:pcB0Xp+tm8dRqq3aJH19z9
 Db3604PVb/W4C3ZcHR4TrETR6G8ZJTVMCcaYT5VPPz+Pplhf/TaVSRpfF3lcGc8b/m2NXEZL5
 pNbC3P66dwTg/W2earljipV8AkviMTcviNh9ZUeeiApLhkEAx68GuHY7U8ZgI3d162egdS26m
 tM1BcNsbrwF71+EJ8ik6a/gJU9aLWlm2apqnPifn33MjK1ocUd7YWO81gkrPTawHgfIhDkFQO
 3FODQ31HzMGDGPkz+1j+11ArerkO13k1qVsdwQOrUuT+NyUvTx6zptx4KXnH0cglFN2JZegwS
 /R+KGgYoUq383k/NbFMmhIiQOe5wu6D5OYyOvHoYkzXgvneP15fRTuyMHgxtK26xuXwY5avjw
 BrUR/+I9+IRxu2dTdR/h9gPRni9vhy6BMCi2VepaVnPkclb5jpRiPZySfS0KaG4u5NgYm9+Rw
 HyNcGxSK+wrWz50kzVf6asU3IvZkN84ntBR2fW9d1D6JagOX6049groMwJW9OkNUSOJ04LZad
 qOPxZ7teLV4/vNnsqR5pLIk/pXf1FHcXAqkYkeIMvsYG/co5Y8nGweKbMJ/ZS8DOohRlaYz++
 r89I0DptpKadEzzOs7A49MMJnEafRBv4g2NbkSbZUpI3O7M9OFN7l/9Gde05myExXstRM/H21
 2/Mzuyq/lLS8XqWGMOi9vHMKxxCnIMOTPAM2ErTHYFnK6wRjD/tp4FjB14Dji5FDl1Lhchv3j
 24UYJP9byL4kjccvN4IBIFuGjV5FycdcQnc7C7XB8QEPMjkgKajHnpn6a4ZF4xy6uWfuypdk8
 ST5suXDyTMHdurBrVnxQfWHRZDe/bWXjvoK32vbC4bhi/85WrqR1upf5gkD+MTJAHSyjREn
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Riku Voipio <riku.voipio@iki.fi>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Matus Kysel <mkysel@tachyum.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/01/2020 à 17:12, Laurent Vivier a écrit :
> Le 28/01/2020 à 10:26, Peter Maydell a écrit :
>> On Thu, 16 Jan 2020 at 11:58, Matus Kysel <mkysel@tachyum.com> wrote:
>>>
>>> Used same style to handle another glibc reserved signal SIGSETXID (33),
>>> that is used by glibc NPTL setuid/setgid functions. This should fix problems
>>> with application using those functions and failing with error
>>> "qemu:handle_cpu_signal received signal outside vCPU context".
>>>
>>> Signed-off-by: Matus Kysel <mkysel@tachyum.com>
>>> ---
>>>  linux-user/signal.c | 13 +++++++++----
>>>  1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/linux-user/signal.c b/linux-user/signal.c
>>> index 0128bde4d2..c59221fd0a 100644
>>> --- a/linux-user/signal.c
>>> +++ b/linux-user/signal.c
>>> @@ -66,11 +66,16 @@ static uint8_t host_to_target_signal_table[_NSIG] = {
>>>      [SIGPWR] = TARGET_SIGPWR,
>>>      [SIGSYS] = TARGET_SIGSYS,
>>>      /* next signals stay the same */
>>> -    /* Nasty hack: Reverse SIGRTMIN and SIGRTMAX to avoid overlap with
>>> -       host libpthread signals.  This assumes no one actually uses SIGRTMAX :-/
>>> -       To fix this properly we need to do manual signal delivery multiplexed
>>> -       over a single host signal.  */
>>> +    /*
>>> +     * Nasty hack: Swap SIGRTMIN and SIGRTMIN + 1 with SIGRTMAX and SIGRTMAX - 1
>>> +     * to avoid overlap with host libpthread (NPTL glibc) signals.
>>> +     * This assumes no one actually uses SIGRTMAX and SIGRTMAX - 1 :-/
>>> +     * To fix this properly we need to do manual signal delivery multiplexed
>>> +     * over a single host signal.
>>> +     */
>>>      [__SIGRTMIN] = __SIGRTMAX,
>>> +    [__SIGRTMIN + 1] = __SIGRTMAX - 1,
>>> +    [__SIGRTMAX - 1] = __SIGRTMIN + 1,
>>>      [__SIGRTMAX] = __SIGRTMIN,
>>>  };
>>>  static uint8_t target_to_host_signal_table[_NSIG];
>>> --
>>> 2.17.1
>>
>> This is a long-standing known problem, but doing this is likely
>> to break currently-working guest binaries (notably things written
>> in Go). See for example the discussion on this thread:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg03804.html
> 
> Peter,
> 
> I try to fix this problem and I'd like to find a reproducer for the Go
> problem.
> 
> I tried to write an "hello world" program and run it in an arm64/bionic
> chroot but there is no problem (with and without this patch).
> 
> Any hints?

Markus has sent me the information.

I'm able to reproduce the problem with an "Hello World" go program and
go 1.10 (basically ubuntu bionic/arm64).

Thanks,
Laurent


