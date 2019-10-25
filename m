Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2ABCA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63962084C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63962084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNzxt-0003Qa-14
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 09:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNzs9-0004cm-7Z
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:43:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNzs7-0006ix-T9
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:43:20 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45667)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iNzs7-0006iI-JV
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 09:43:19 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N3bb1-1hx4x40WtH-010egd; Fri, 25 Oct 2019 15:43:17 +0200
Subject: Re: [PATCH v2 08/12] linux-user/sparc64: Fix target_signal_frame
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-9-richard.henderson@linaro.org>
 <fe46bd7d-d036-3a43-d1b4-d05a25555eb4@vivier.eu>
 <3b51c99f-e7da-31e2-aa65-d497a0aa8633@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <651e4a19-0cc7-e919-9cac-be685bb90385@vivier.eu>
Date: Fri, 25 Oct 2019 15:43:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <3b51c99f-e7da-31e2-aa65-d497a0aa8633@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:C8Ki0LLS2CBUb52o/JNiqQNhW0RThoKv43Bh1no+u/5Nlz/w7Ch
 ahibSZKB+Ag8k2xpVAIszDH0Wm4j8eWFlTU5Kf0XqQPfreErrfWJ720c0CRi4Ln0W5we+gv
 g7ApvJ0DiR+SjMbbra119HFmqHYDQWXWEli3HinWqltYZZe4UvOXz9PCZfY8zo+ror3fB2W
 k95jnCG/ER9UjEGg6fWRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lknaTb7D5fM=:PPJzMZ9YdjYmnXzM69q0Yf
 UnJ4Rv7nJuHRzJObY25lHiaOJ/hziaQn0J2Fq9AQbj863NmTceuE1aXEQ4vBWUWpQIQhUvrZ+
 3QngJhBll+BT7MGWKFutpTR2CrwcgchBmAXUAfDDTi3GaDgy9lbukhgF4/76t0JpA51vj59Gx
 UFkaJzsI5rE8wFxUfclXLowvteieAia4xZhc+FMMMfIQ/yczMxEICuqc4nWJ87v+BibFqcFS/
 FEZyJuTIcdtkGkaKbaVZk7UcmkkZzz1aOahBkFFScE/WCWa/LZNJ/RYlWjTaxdW33LfYUFHpw
 j224TsHa+X2hyvIankkZuq1mqDF4VdMbGhCh6Iim4/vob9XM1twN0Ea0uB/m+PYQUtV9cWwqk
 xEmuQR0UKF8z6RZSDn93UDGztwFgvZK0rZrom/bM3lm3kz50DKUXnnQQTUE5Yi6oJxgqg7c+c
 pBqRMA9dC/55ByY9/KNX4dUqaoiuUkwolVf1/t6ikty/LXP90WjAvgjOBsBcT17DI1wxreNQG
 Z5r7gjYU0piaUei5jfFengQ7pbUSdfMR4MWLlintDrAuwxH/KtqQVAl06QmZAYBDIXhQLlvDh
 PR79/0v4o1ZAiZR5/bbPcnBgWwHTInTpbl5ackyca0kt1LsfcTAT8nJTn8RX31z5pwIkvP1L9
 1N1pO4K03jxZTcZa0MWolV+RC9k/9UvgtRvqDQD9+lQ4EJDSQKqiuOBFzmRPXGgEFZeAbIkoB
 shLQLzPvMeHsriBKZDqhJBe0OubRU6jr1hJ1KfqApA4Z1uYyvVYCHH1hpuKc8peOlHebf5kKC
 vqnBfGpmOL0EOUUgbqIyciz/3CWElxfjj/SQjdnOMXg+XGR5ormcOgGLsB9yKusHTZg9+Ob+g
 RMYLLB4bTrCviyx+OgnJfrT7vFm2xo1eeQaWeCGtk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 15:38, Richard Henderson a écrit :
> On 10/25/19 8:47 AM, Laurent Vivier wrote:
>> Le 25/10/2019 à 13:39, Richard Henderson a écrit :
>>> Instructions are always 4 bytes; use uint32_t not abi_ulong.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  linux-user/sparc/signal.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/linux-user/sparc/signal.c b/linux-user/sparc/signal.c
>>> index efb0df7e2b..ecfdf937e4 100644
>>> --- a/linux-user/sparc/signal.c
>>> +++ b/linux-user/sparc/signal.c
>>> @@ -87,7 +87,7 @@ struct target_signal_frame {
>>>      struct sparc_stackf ss;
>>>      __siginfo_t         info;
>>>      abi_ulong           fpu_save;
>>> -    abi_ulong           insns[2] __attribute__ ((aligned (8)));
>>> +    uint32_t            insns[2] __attribute__ ((aligned (8)));
>>>      abi_ulong           extramask[TARGET_NSIG_WORDS - 1];
>>>      abi_ulong           extra_size; /* Should be 0 */
>>>      qemu_siginfo_fpu_t fpu_state;
>>> @@ -98,7 +98,7 @@ struct target_rt_signal_frame {
>>>      abi_ulong           regs[20];
>>>      sigset_t            mask;
>>>      abi_ulong           fpu_save;
>>> -    unsigned int        insns[2];
>>> +    uint32_t            insns[2];
>>>      stack_t             stack;
>>>      unsigned int        extra_size; /* Should be 0 */
>>>      qemu_siginfo_fpu_t  fpu_state;
>>>
>>
>> This definition is used by sparc and sparc64 (sparc64/signal.c includes
>> sparc/signal.c), so the definition was valid before your changes for
>> sparc and not good for sparc64. Moreover rt_signal_frame for sparc64
>> doesn't look like this one (and signal_frame doesn't exist).
> 
> You're right that target_rt_signal_frame isn't correct for sparc64.  But we
> also don't implement setup_rt_frame yet, so it's also currently unused.
> 
> What's here is just good enough to make setup_frame work, and that is correct
> for both sparc and sparc64.

ok

Reviewed-by: Laurent Vivier <laurent@vivier.eu>



