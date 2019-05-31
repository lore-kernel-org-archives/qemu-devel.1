Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D7C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1360426AE3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="skMiZDtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1360426AE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44707 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWioP-0008DC-BS
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:47:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWimi-00079o-EX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWimg-0002Xi-I2
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWime-0002Pz-LY
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:45:29 -0400
Received: by mail-ot1-x341.google.com with SMTP id l17so9444364otq.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=etBdTWUHv40hMWae9M0RUsJbcAdpS/y4cGWcIuI0osw=;
	b=skMiZDtVEAISwKRooVlx5y5l2c756MiHzArbwrKObLrwtjWC3E9Tmscq6cE0qQlQIg
	J1/vtLI6g5MVsZKmsvQ8VsVZO1wYKAlNRp3iYjoYomTcYCEuMDnVdVJr5UhjabUd6NKZ
	EjugBocdh1TOpOc0ApDFjIIQP1MQ9W4Q28kulW4zX02dKRSX8wdJjeunBVdhlXhc3TIl
	5g0hjskJf+vgNh68SxQQ45Qtba4J6mdSoBGVumCJ2AI3R3z7t90LJz0st8QxcCvf/g7O
	/as8jbFvqhxxU3rAL1KoKtJ6EW8/uooIrBPAEO1cfMa85Gqg3oMxSQstrtkEiKj97O+5
	AkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=etBdTWUHv40hMWae9M0RUsJbcAdpS/y4cGWcIuI0osw=;
	b=aW6ks1yy6M7AO5+xkZTpuhiDFx7+sZ5VedeCC4uI/ZZbWOHd4AsQWHd1ZwdAg6jfAX
	3cdNGUkNp4cDb1a5gL2DgVnp/aipWqDT41DYPsw8k1EwVFVus1kiDUtz5mYKswdoWOTJ
	ZlH7m8a6P1ZCjpnToKuId8DA/ZMRxas+eaJMt9dO8jACY+zOtsKmOlquASBMzCXI+Ox8
	FeMHVgVmGWYl5ge1bPWac6iShq+C1KRfJUmMg4QAIINu0o0VdSLCMtAeWvcDlb3X0PoA
	CRFnkmfCzCi43cAhqCMsR+YyGdGsU1on3rzwDsHzFwj2e5tvVg722E6QVxrk8KsZMpWX
	Ossw==
X-Gm-Message-State: APjAAAWeLFFLHPNBr7P4j03Jo3Fkvt5qHbrSPN7RZKhTr6M1abcPzuzd
	/Q+0ndWGMdibZq7/sLPsBM9x2Q==
X-Google-Smtp-Source: APXvYqxfseVbR5cxLP8PFuOmcg1HsHPK0Ab7MuytV9XG8K0H/dz8/ccEldsi1gl0BVjQ3LfCN8755Q==
X-Received: by 2002:a9d:6210:: with SMTP id g16mr2084445otj.225.1559313926171; 
	Fri, 31 May 2019 07:45:26 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id o3sm1948020otl.76.2019.05.31.07.45.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 07:45:23 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-5-mrolnik@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <17b55a6e-af48-861d-6c2c-20bab1e45155@linaro.org>
Date: Fri, 31 May 2019 09:45:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530190738.22713-5-mrolnik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH RFC v20 4/8] target-avr: Add instruction
 decoding
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 2:07 PM, Michael Rolnik wrote:
> This includes:
> - encoding of all 16 bit instructions
> - encoding of all 32 bit instructions
> 
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  target/avr/insn16.decode | 160 +++++++++++++++++++++++++++++++++++++++
>  target/avr/insn32.decode |  10 +++
>  2 files changed, 170 insertions(+)
>  create mode 100644 target/avr/insn16.decode
>  create mode 100644 target/avr/insn32.decode

Two things:

(1) decodetree can handle variable-width ISA now.

It's slightly ugly in that the %field numbering is little-endian and thus
varies for each insn size.  But the in-flight patch set for target/rx shows
that it works.

That said, I don't think you need that because,

(2) The four instructions that are 32-bits do not have
    any opcode bits in the second 16-bits.

E.g.

# The 22-bit immediate is partially in the opcode word,
# and partially in the next.  Use append_16 to build the
# complete 22-bit value.
%imm_call	4:5 0:1			!function=append_16
CALL		1001 010. .... 111.	imm=%imm_call
JMP		1001 010. .... 110.	imm=%imm_call

# The 16-bit immediate is completely in the next word.
# Fields cannot be defined with no bits, so we cannot play
# the same trick and append to a zero-bit value.
# Defer reading the immediate until trans_{LDS,STS}.
@ldst_s		.... ... rd:5 ....	imm=0
LDS		1001 000 ..... 0000	@ldst_s
STS		1001 001 ..... 0000	@ldst_s


static uint16_t next_word(DisasContext *ctx)
{
    return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
}

static int append_16(DisasContext *ctx, int x)
{
    return x << 16 | next_word(ctx);
}

static bool trans_LDS(DisasContext *ctx, arg_ldst_s *a)
{
    a->imm = next_word(ctx);
    // other stuff
}

I realize that next_word as written does not fit in to how you currently
process instructions in the loop, but I also think that's a mistake.  I'll
respond to that in its place in the next patch.

That said, next_word *could* be written to use ctx->inst[0].opcode.


r~

