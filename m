Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3F820674
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 15:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVWKvOVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3F820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jspBl-00051F-MV
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jspAs-00049M-Q5
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:06:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:38139
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jspAq-0003Ol-7c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 11:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594134379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=oCBnPQYmrn1xPn5ii2VUn3RGd47YLCZkPMr4koF4Qqw=;
 b=GVWKvOVa4hnZtaabewcaY4jKi/hKhFvQsUKSjrIm7fzcqcJGG7+FCjtPWnV8H0c2rXEYXu
 ZAyDw1nc3DpYg7jE1qlAod4BrxekIbrdIlgrXW6/el5ln0I6O5YxDX2JZPPzFDmYE6mZho
 lzQwTkIZ9neRJ4tB0UQNmRQkPSrBaek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-1x9KNCLbN12V6OE-e1qTWQ-1; Tue, 07 Jul 2020 11:06:17 -0400
X-MC-Unique: 1x9KNCLbN12V6OE-e1qTWQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E66CA108BD09;
 Tue,  7 Jul 2020 15:06:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-35.ams2.redhat.com [10.36.113.35])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C212C0061;
 Tue,  7 Jul 2020 15:06:10 +0000 (UTC)
Subject: Re: [PULL 07/15] hw/timer: RX62N 8-Bit timer (TMR)
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200621124807.17226-1-f4bug@amsat.org>
 <20200621124807.17226-8-f4bug@amsat.org>
 <CAFEAcA8c2dywr=Zxz1ExAV-48JwFU5vbBDDfA=_KE98XamnXiA@mail.gmail.com>
 <1448b050-4f78-2ae3-95db-6c47baad5909@amsat.org>
 <878sfv9xmi.wl-ysato@users.sourceforge.jp>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6e36f1f3-06e2-9635-960d-e2f7f75b2040@redhat.com>
Date: Tue, 7 Jul 2020 17:06:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <878sfv9xmi.wl-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:20:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/07/2020 17.02, Yoshinori Sato wrote:
> On Mon, 29 Jun 2020 18:58:56 +0900,
> Philippe Mathieu-Daudé wrote:
>>
>> Hi Yoshinori,
>>
>> On 6/25/20 11:25 AM, Peter Maydell wrote:
>>> On Sun, 21 Jun 2020 at 13:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> From: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>>
>>>> renesas_tmr: 8bit timer modules.
>>>
>>> Hi; the recent Coverity run reports a potential bug in this
>>> code: (CID 1429976)
>>>
>>>
>>>> +static uint16_t read_tcnt(RTMRState *tmr, unsigned size, int ch)
>>>> +{
>>>> +    int64_t delta, now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>>> +    int elapsed, ovf = 0;
>>>> +    uint16_t tcnt[2];
>>>
>>> Here we declare tcnt[] but do not initialize its contents...
>>>
>>>> +    uint32_t ret;
>>>> +
>>>> +    delta = (now - tmr->tick) * NANOSECONDS_PER_SECOND / tmr->input_freq;
>>>> +    if (delta > 0) {
>>>> +        tmr->tick = now;
>>>> +
>>>> +        if (FIELD_EX8(tmr->tccr[1], TCCR, CSS) == INTERNAL) {
>>>> +            /* timer1 count update */
>>>> +            elapsed = elapsed_time(tmr, 1, delta);
>>>> +            if (elapsed >= 0x100) {
>>>> +                ovf = elapsed >> 8;
>>>> +            }
>>>> +            tcnt[1] = tmr->tcnt[1] + (elapsed & 0xff);
>>>> +        }
>>>> +        switch (FIELD_EX8(tmr->tccr[0], TCCR, CSS)) {
>>>> +        case INTERNAL:
>>>> +            elapsed = elapsed_time(tmr, 0, delta);
>>>> +            tcnt[0] = tmr->tcnt[0] + elapsed;
>>>> +            break;
>>>> +        case CASCADING:
>>>> +            if (ovf > 0) {
>>>> +                tcnt[0] = tmr->tcnt[0] + ovf;
>>>> +            }
>>>> +            break;
>>>> +        }
>>>
>>> ...but not all cases here set both tcnt[0] and tcnt[1]
>>> (for instance in the "case CASCADING:" if ovf <=0 we
>>> won't set either of them)...
>>>
>>>> +    } else {
>>>> +        tcnt[0] = tmr->tcnt[0];
>>>> +        tcnt[1] = tmr->tcnt[1];
>>>> +    }
>>>> +    if (size == 1) {
>>>> +        return tcnt[ch];
>>>> +    } else {
>>>> +        ret = 0;
>>>> +        ret = deposit32(ret, 0, 8, tcnt[1]);
>>>> +        ret = deposit32(ret, 8, 8, tcnt[0]);
>>>> +        return ret;
>>>
>>> ...and so here we will end up returning uninitialized
>>> data. Presumably the spec says what value is actually
>>> supposed to be returned in these cases?
>>>
>>> PS: the "else" branch with the deposit32() calls could be
>>> rewritten more simply as
>>>   return lduw_be_p(tcnt);
>>>
>>>> +static uint64_t tmr_read(void *opaque, hwaddr addr, unsigned size)
>>>> +{
>>>
>>> In this function Coverity reports a missing "break" (CID 1429977):
>>>
>>>> +    case A_TCORA:
>>>> +        if (size == 1) {
>>>> +            return tmr->tcora[ch];
>>>> +        } else if (ch == 0) {
>>>> +            return concat_reg(tmr->tcora);
>>>> +        }
>>>
>>> Here execution can fall through but there is no 'break' or '/* fallthrough */'.
>>>
>>>> +    case A_TCORB:
>>>> +        if (size == 1) {
>>>> +            return tmr->tcorb[ch];
>>>> +        } else {
>>>> +            return concat_reg(tmr->tcorb);
>>>> +        }
>>>
>>> Is it correct that the A_TCORA and A_TCORB code is different?
>>> It looks odd, so if this is intentional then a comment describing
>>> why it is so might be helpful to readers.
>>
>> Can you address Peter's comments please?
> 
> This register can 8bit and 16bit access.
> 8bit case return separate single TCORA or TCORB.
> 16bit case return merged two channel's TCORA or TCORB.
> high byte: channel 0 register.
> low byte: channel 1 register

So could you please provide a patch that either adds the missing
"break;" statement between the cases here, or adds a "/* fallthrough */"
comment between the cases?

 Thanks,
  Thomas


