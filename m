Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC6DC433E6
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:09:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DC9206F0
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 23:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYGA0k3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92DC9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCWRZ-0004wX-Mb
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 19:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWR0-0004Xp-GX
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:08:26 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCWQy-0002vv-Jh
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 19:08:26 -0400
Received: by mail-pl1-x644.google.com with SMTP id t11so2168491plr.5
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 16:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=L32qPn6d3OgTFcYj5S94dmkroQw3qwhUDfrVnsPKhaY=;
 b=NYGA0k3ywZZjlHyIuANCu/0i+EV/LwBCkxDE11SAYIGIX/3Xmfa9MorPYmvKV6025k
 blAD9chLwQMWiCkBRd7Vz74FbmKHsIZNvlCCbblJC6gGyLZ0IXyEgddtAhdP0Xe8tbB7
 JkHYG85lCy+ifaA4rinz99g8hMUlKU3D49zEztmSLQJ+FP782DEMG/ivOWn02aOgoOR8
 GEv+a6vem+e8cqtit4hqtwntHlGL2nAc9z/KWx+9SjtO/NqT4fg9mxd0LsIcRek6EDQG
 lpvxZSHpMuMdIjJ52SCrxhmhVpMzKjibE5bwf+8qAhZ0ILk4oHEFV7NQDL4WsYWDIEpD
 A+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L32qPn6d3OgTFcYj5S94dmkroQw3qwhUDfrVnsPKhaY=;
 b=U+ohOu06dcFUkSdzc2nNHWvcmhImgDq7slpZgRnJR11FoSMwDuEa596KKJvltuWny/
 vQWRui1ytamWVZdknPVxfdcw4WAKjSJRkGHCZAIGF0+HCYpxYYwaaPinW6ZcTRhI4feN
 MegcZJ5hctjkVnXzqwAZjltq4thogzlhxjtXRV7ZAe7XgcUMyN+KiBdx2Ud44XlhYm/Y
 +F/h5JzuX+SmCS9O8WSPO4mea9zOrWwy90bcSo+Fg+gno58dm5JI5GZ9Z7a/sZ4e1weC
 FAwBOWC0LX8ELe4gmk7ZnFYJqAN2FpbOfNI+DZYljQW+gklFGfsQAUu1Dqg1lx0emeW+
 yC2g==
X-Gm-Message-State: AOAM532yvgME6iK6P4RlI3fOVWb5ZKDZS1xZfSQgxEVNPz48yxDbxyCt
 Lb5QAbBM0CINKHJjbkBl6y/cXQ==
X-Google-Smtp-Source: ABdhPJxSq5Pp3jvdaFFuhwdbMCKKGQMudAxKKYfHyycOGMkhsiWn3jQ1o9j8WGTLWomhKroIrNsk1w==
X-Received: by 2002:a17:90b:1182:: with SMTP id
 gk2mr8613710pjb.172.1598828902870; 
 Sun, 30 Aug 2020 16:08:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 124sm5826317pfb.19.2020.08.30.16.08.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Aug 2020 16:08:22 -0700 (PDT)
Subject: Re: [RFC PATCH v3 31/34] Hexagon (target/hexagon) translation
To: Taylor Simpson <tsimpson@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-32-git-send-email-tsimpson@quicinc.com>
 <00686989-8fdb-2334-d8f3-93c6301c142d@linaro.org>
 <BYAPR02MB488647E77E043F2A20CEF007DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a8f99274-a865-0ffb-d49b-648e8be8170c@linaro.org>
Date: Sun, 30 Aug 2020 16:08:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR02MB488647E77E043F2A20CEF007DE500@BYAPR02MB4886.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.207,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: "ale@rev.ng" <ale@rev.ng>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "philmd@redhat.com" <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "aleksandar.m.mail@gmail.com" <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/30/20 12:37 PM, Taylor Simpson wrote:
> I'm actually checking two conditions here.
> 1) packet crossing a page boundary
> 2) reading too many words without finding the end of the packet.
> I guess it would be better to separate them.
> 
> What is the correct behavior for the second case?  Should we return an error code from here and have the higher level code generate the invalid packet exception?

I would return an error code.

In fact, I would also pass in the max number of words to read:

static int read_packet_words(CPUHexagonState *env,
                             DisasContext *ctx,
                             uint32_t words[PACKET_WORDS_MAX],
                             int max_words)
{
   // stuff
   return !found_end ? 0 : nwords;
}


Then, in translate_packet,


    uint32_t words[PACKET_WORDS_MAX];
    int nwords = read_packet_words(env, ctx, words,
                                   PACKET_WORDS_MAX);

    if (nwords == 0) {
        // raise exception
        return;
    }

    decode_and_translate_packet(env, ctx, words, nwords);

    /* If we're going to try for another packet... */
    if (ctx->base.is_jmp == DISAS_NEXT &&
        ctx->base.num_insns < ctx->base.num_insns) {
        /*
         * Remember the end of the page containing the
         * first packet.  Note that the first packet
         * is allowed to span two pages, so this is not
         * necessarily the same as the end of the page
         * containing ctx->base.pc_start.
         */
        if (ctx->base.num_insns == 1) {
            ctx->page_end
                = TARGET_PAGE_ALIGN(ctx->base.pc_next);
        }

        /*
         * If there are not PACKET_WORDS_MAX remaining on
         * the page, check to see if a full packet remains.
         * If not, split the TB so that the packet that
         * crosses the page begins the next TB.
         */
        target_long left = ctx->page_end - ctx->base.pc_next;
        tcg_debug_assert(left >= 0);
        if (left == 0
            || (left < PACKET_WORDS_MAX * 4 &&
                !read_packet_words(env, ctx, words, left / 4)) {
            ctx->base.is_jmp = DISAS_TOO_MANY;
        }
    }


The reason for all this is to properly capture the behaviour of instruction
execution vs SIGSEGV.

First, during translate we do not want to read from the next page unless
absolutely necessary.  Doing so could raise SIGSEGV before it would be
appropriate, e.g. because the TB should have branched away (or raised SIGFPE,
or anything else) before getting that far.

Second, when dispatching a TB, we check the 1 or 2 pages that the TB occupies
for validity.  If the second page is invalid, we raise SIGSEGV without
executing the TB at all.  Which makes it appear as if the SIGSEGV happened at
the first insn of the TB.  Which is correct if and only if the first insn is
the one that did cross the page.

>> Surely you don't need to actually set PC for every PC?
> 
> What do other targets do?

If you have a pc-relative instruction, e.g. x86_64's

  lea  offset(%rip), %rax

then you just use the known immediate for %rip:

  tcg_gen_movi_tl(cpu_reg[eax], ctx->base.pc_next + offset);

Normally, PC is only valid when explicitly returning to the cpu loop
(tcg_gen_exit_tb, static exception), for indirect branching
(tcg_gen_lookup_and_goto_ptr), or after dynamic exception unwinding
(restore_state_to_opc).

When using goto_tb, we can get away with *assuming* static state, because the
values get baked into the link to a specific next-TB.  That's why the general
form is

  tcg_gen_goto_tb(n);
  gen_set_pc_im(s, dest);
  tcg_gen_exit_tb(s->base.tb, n);

The first time we cross link N, the link is unset, which causes the goto_tb to
continue to the next tcg opcode.  Which then sets all of the static state that
has been assumed (often, as here, just the pc).  We then exit, telling the
cpu_loop to examine cpu state, locate the next TB, and fill in link N from the
current TB.

The second time we cross link N, the link is set, which causes the goto_tb to
continue immediately to the next TB.  We do not execute the store to PC, as it
is implied by next_tb->pc.


r~

