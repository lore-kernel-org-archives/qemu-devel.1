Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3758C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8373206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8373206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtC9z-00038G-1j
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ysato@users.sourceforge.jp>)
 id 1jtC98-0002hg-7U
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:38:06 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:60114)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1jtC95-0006Br-TO
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:38:05 -0400
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp
 [153.127.30.23]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 2D02DFEB59;
 Thu,  9 Jul 2020 00:37:57 +0900 (JST)
Received: from www.ysato.name (localhost [IPv6:::1])
 by sakura.ysato.name (Postfix) with ESMTPA id B92D91C0BF8;
 Thu,  9 Jul 2020 00:37:56 +0900 (JST)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 09 Jul 2020 00:37:56 +0900
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
In-Reply-To: <6e36f1f3-06e2-9635-960d-e2f7f75b2040@redhat.com>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
 <1448b050-4f78-2ae3-95db-6c47baad5909@amsat.org>
 <878sfv9xmi.wl-ysato@users.sourceforge.jp>
 <6e36f1f3-06e2-9635-960d-e2f7f75b2040@redhat.com>
Message-ID: <c03d8c455ddac5240a13d2c363debfe0@users.sourceforge.jp>
X-Sender: ysato@users.sourceforge.jp
User-Agent: Roundcube Webmail/1.3.11
Received-SPF: softfail client-ip=202.224.55.15;
 envelope-from=ysato@users.sourceforge.jp; helo=mail03.asahi-net.or.jp
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:37:58
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud?= =?UTF-8?Q?=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

2020-07-08 00:06 に Thomas Huth さんは書きました:
> On 07/07/2020 17.02, Yoshinori Sato wrote:
>> On Mon, 29 Jun 2020 18:58:56 +0900,
>> Philippe Mathieu-Daudé wrote:
>>> 
>>> Hi Yoshinori,
>>> 
>>> On 6/25/20 11:25 AM, Peter Maydell wrote:
>>>> On Sun, 21 Jun 2020 at 13:54, Philippe Mathieu-Daudé 
>>>> <f4bug@amsat.org> wrote:
>>>>> 
>>>>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>> 
>>>>> renesas_tmr: 8bit timer modules.
>>>> 
>>>> Hi; the recent Coverity run reports a potential bug in this
>>>> code: (CID 1429976)
>>>> 
>>>> 
>>>>> +static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
>>>>> +{
>>>>> +    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>>> +    int elapsed, ovf = 0;
>>>>> +    uint16_t tcnt[2];
>>>> 
>>>> Here we declare tcnt[] but do not initialize its contents...
>>>> 
>>>>> +    uint32_t ret;
>>>>> +
>>>>> +    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / 
>>>>> tmr->input_freq;
>>>>> +    if (delta > 0) {
>>>>> +        tmr->tick = now;
>>>>> +
>>>>> +        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
>>>>> +            /* timer1 count update */
>>>>> +            elapsed = elapsed_time(tmr, 1, delta);
>>>>> +            if (elapsed >= 0x100) {
>>>>> +                ovf = elapsed >> 8;
>>>>> +            }
>>>>> +            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
>>>>> +        }
>>>>> +        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
>>>>> +        case INTERNAL:
>>>>> +            elapsed = elapsed_time(tmr, 0, delta);
>>>>> +            tcnt[0] = tmr->tcnt[0] + elapsed;
>>>>> +            break;
>>>>> +        case CASCADING:
>>>>> +            if (ovf > 0) {
>>>>> +                tcnt[0] = tmr->tcnt[0] + ovf;
>>>>> +            }
>>>>> +            break;
>>>>> +        }
>>>> 
>>>> ...but not all cases here set both tcnt[0] and tcnt[1]
>>>> (for instance in the "case CASCADING:" if ovf <=0 we
>>>> won't set either of them)...
>>>> 
>>>>> +    } else {
>>>>> +        tcnt[0] = tmr->tcnt[0];
>>>>> +        tcnt[1] = tmr->tcnt[1];
>>>>> +    }
>>>>> +    if (size == 1) {
>>>>> +        return tcnt[ch];
>>>>> +    } else {
>>>>> +        ret = 0;
>>>>> +        ret = deposit32(ret, 0, 8, tcnt[1]);
>>>>> +        ret = deposit32(ret, 8, 8, tcnt[0]);
>>>>> +        return ret;
>>>> 
>>>> ...and so here we will end up returning uninitialized
>>>> data. Presumably the spec says what value is actually
>>>> supposed to be returned in these cases?
>>>> 
>>>> PS: the "else" branch with the deposit32() calls could be
>>>> rewritten more simply as
>>>>   return lduw_be_p(tcnt);
>>>> 
>>>>> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>>>>> +{
>>>> 
>>>> In this function Coverity reports a missing "break" (CID 1429977):
>>>> 
>>>>> +    case A_TCORA:
>>>>> +        if (size == 1) {
>>>>> +            return tmr->tcora[ch];
>>>>> +        } else if (ch == 0) {
>>>>> +            return concat_reg(tmr->tcora);
>>>>> +        }
>>>> 
>>>> Here execution can fall through but there is no 'break' or '/* 
>>>> fallthrough */'.
>>>> 
>>>>> +    case A_TCORB:
>>>>> +        if (size == 1) {
>>>>> +            return tmr->tcorb[ch];
>>>>> +        } else {
>>>>> +            return concat_reg(tmr->tcorb);
>>>>> +        }
>>>> 
>>>> Is it correct that the A_TCORA and A_TCORB code is different?
>>>> It looks odd, so if this is intentional then a comment describing
>>>> why it is so might be helpful to readers.
>>> 
>>> Can you address Peter's comments please?
>> 
>> This register can 8bit and 16bit access.
>> 8bit case return separate single TCORA or TCORB.
>> 16bit case return merged two channel's TCORA or TCORB.
>> high byte: channel 0 register.
>> low byte: channel 1 register
> 
> So could you please provide a patch that either adds the missing
> "break;" statement between the cases here, or adds a "/* fallthrough 
> */"
> comment between the cases?
> 
>  Thanks,
>   Thomas

OK.
This part will be cleaned up more.

Thanks.

