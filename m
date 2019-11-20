Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE707C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B2F217F9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dzAvP2ZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B2F217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRDV-0003Kn-Or
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXRCf-0002CX-Dg
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXRCd-0000KR-QT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:43:33 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXRCd-0000KD-IW
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:43:31 -0500
Received: by mail-ot1-x341.google.com with SMTP id l14so21362065oti.10
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=eyH95iXzwqVPctM03ym0ehyegdwyy0SYqqU7IC+0Hzs=;
 b=dzAvP2ZPlHJChl0HN55knK2GclTfRzJbO4+HYzNQD6D24rNcbzfo27+JQAAi4UtQxO
 hy70Hj1RI38L4fRbhok5JSpg4jRjuLsejyYLCwSqkZrU/5HEcexw7qlakR7SRP/dDPtW
 /++KshhMLZIauetvQrOYWrhuChL8CSM6Zh1ovrMaY+Qx0iRJg9utDHhuEOvGieW3Pr4W
 AwSli5ysEI99NdDqnJm65SFZmZKSLT03RvA5Ig7gcVv1ZGhQhJuqk2kD0Vbvtb8MYFW0
 agNmo42ZAmp92djAC4EJYBAgmzJoptoo/746k6bbxaIh2A+IwLDJvTJFD0DKDDLGndkR
 ldvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eyH95iXzwqVPctM03ym0ehyegdwyy0SYqqU7IC+0Hzs=;
 b=asYAoa2mWPk8hdEdXjU4U33chjNw2W5GbgDZiRQ5gPV5Uymk1/678tyUG+2A9Lmmoe
 QrIxs8IgTHzMixX3XKGO2nZyjdQI7JH7wS+eC9Jlg4/aYSZ19SznnoHtQD+MObT5/PJU
 0vezqRxuw4IfbnSBBtQ2mmHk8oYs2nyD0/B+lUyh5C2azJ9G7FHP/uz3TRhhFu9rhD4P
 N5bWtxQFpBKGEpnWYDEK49s+eFmx4kwd8Bmk4kUUjMKJCyU59hgKWXKt6Yp1ing/i5aH
 HLBtZaax6Y04JC0EJomJ5rfXq67ws5FWJb/Icxez+v6HmxJkvGYLrC0dyLlrLB+OeI56
 q15g==
X-Gm-Message-State: APjAAAVGgC4po7a1Mbs5RQnbIZ/hCExSWobq5SIt/aRHHF7dYAGk/4jX
 JT60pTDQVzIEJ+MPKpri9yjeubh76Q1iqA==
X-Google-Smtp-Source: APXvYqw9A+px0vx28I90GB3zE4jQljA8yKAcCxeg1V6OprrCibU/qYKki28QZ1GPyJFwLcWrHnHRlw==
X-Received: by 2002:a9d:82e:: with SMTP id 43mr2377918oty.23.1574261009452;
 Wed, 20 Nov 2019 06:43:29 -0800 (PST)
Received: from [192.168.42.211] ([172.58.110.132])
 by smtp.gmail.com with ESMTPSA id r4sm8474854otg.55.2019.11.20.06.43.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 Nov 2019 06:43:28 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Taylor Simpson <tsimpson@quicinc.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
 <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
 <BYAPR02MB48867B036ADC1111CF04B023DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2bdd3e40-1530-90f6-f179-8bf12e223ec1@linaro.org>
Date: Wed, 20 Nov 2019 15:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB48867B036ADC1111CF04B023DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 1:51 PM, Taylor Simpson wrote:
>>> +static inline target_ulong hack_stack_ptrs(CPUHexagonState *env,
>>> +                                           target_ulong addr) {
>>> +    target_ulong stack_start = env->stack_start;
>>> +    target_ulong stack_size = 0x10000;
>>> +    target_ulong stack_adjust = env->stack_adjust;
>>> +
>>> +    if (stack_start + 0x1000 >= addr && addr >= (stack_start - stack_size)) {
>>> +        return addr - stack_adjust;
>>> +    }
>>> +    return addr;
>>> +}
>>
>> An explanation would be welcome here.
>> [Taylor]  I will add a comment.  One of the main debugging techniques is to use "-d cpu" and compare against LLDB output when single stepping.  However, the target and qemu put the stacks in different locations.  This is used to compensate so the diff is cleaner.
> 
> Ug.  I understand why you want this, but... ug.
> 
> [Taylor] Not sure what to say - I guess there's a fine line between elegance and mayhem.

The hack may work for now, but I would certainly expect this code to go away
eventually.  Sooner rather than later.

If you want dumps between LLDB and QEMU to match, then just put the stack at
the same spot.  Messing about with the pointers after the fact is insane.


> [Taylor] To clarify, this is for a rare case when a hardware loop body is a single packet.  Here's an example.  It's the portion of memset that gets called when the number of bytes is small
>   400404:       10 40 02 60     60024010 {      loop0(0x40040c,r2)
>   400408:       08 c0 02 10     1002c008        p0 = cmp.eq(r2,#0); if (p0.new) jump:nt 0x400414 <memset+0x34> }
>   40040c:       01 81 03 a1     a1038101 {      memb(r3+#1) = r1
>   400410:       10 c1 03 ab     ab03c110        memb(r3++#2) = r1 }  :endloop0
> The loop0 instruction sets the start address and the iteration count.  The :endloop0 marks the end of the loop and tells the hardware to decrement the counter and go back to the start if it's not zero.  So, the loop at 0x40040c-0x400410 is a single packet.  In this case the hardware single step will execute the entire loop.  Finally, if the loop has more than one packet, the single stepping will go through each iteration as you describe.

The behaviour inconsistency between a single packet
loop and a two packet loop sounds to me like a HW bug.
Perhaps of the WONTFIX variety, but still...


>>> +static void decode_packet(CPUHexagonState *env, DisasContext *ctx) {
>>> +    size4u_t words[4];
>>> +    int i;
>>> +    /* Brute force way to make sure current PC is set */
>>> +    tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], ctx->base.pc_next);
>>
>> What's this for?
>> [Taylor] Honestly, I'm not sure.  If I remove it, nothing works - not even "hello world".

It's because you forgot to update PC before raising the exception for trap #0.
Which also ought to set DISAS_NORETURN to end the TB, since it longjmp's out.


>>> +    for (i = 0; i < 4; i++) {
>>> +        words[i] = cpu_ldl_code(env, ctx->base.pc_next + i * sizeof(size4u_t));
>>> +    }
>>
>> And this?
>> [Taylor] It's reading from the instruction memory.  The switch statement below uses it.
> 
> I thought packets are variable length and ended by a bit set.  Therefore why the fixed iteration to 4?  Also...
> 
> 
> [Taylor] The maximum size of a packet is 4 words, so I go ahead and read that much.  Once the packet is decoded, I set ctx->base.pc_next appropriately.  Note that most of the instructions in the switch add 4, but one of them adds 8.

This is where you will need to take more care wrt the end of the packet and the
end of the page.  I would expect something like

    max = -(dc->base.pc_next | TARGET_PAGE_MASK) / 4;
    if (max < 4) {
        /* this packet *might* cross a page boundary */
        if (dc->base.num_insns == 1) {
            /* this is the first packet in the TB -- allow it */
            max = 4;
        }
    } else {
        max = 4;
    }

    found_end = false;
    for (i = 0; i < 4; i++) {
        words[i] = load(...);
        if (end_of_packet(words[i])) {
            max = i + 1;
            found_end = true;
            break;
        }
    }
    if (!found_end) {
        if (i == 4) {
            /* illegal packet -- read all 4 without an end */
            gen_illegal_insn_or_whatever();
            dc->base.is_jmp = DISAS_NORETURN;
            return;
        }
        /* the packet crosses a page boundary -- defer to next tb */
        dc->base.is_jmp = DISAS_TOO_MANY;
        return;
    }

    ...

    case insn that needs two words:
        assert(i + 2 <= max);
        ...


r~

