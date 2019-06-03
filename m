Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE5C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9892826CEB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1ovkduS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9892826CEB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=twiddle.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXuqZ-0001hq-Sq
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 17:50:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hXupA-0000qh-Gx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1hXup2-0006rf-Dg
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:48:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38981)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1hXuov-0006OL-V6
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 17:48:50 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so5107083otq.6
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 14:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=O2yNi+ITHG4LHCZzv2r03ObVcyiw2dRZFrO6h3MPc7U=;
	b=Q1ovkduSdY0hrRSo+Rp2ZAazCFqeIlM2WHhhEyC2dv6mHJhvJ6mctl4oRfIAVToFUr
	xUiyXY15S0nhaTVc0BXAGan38R2m1+erB873JqJlALfp0+sz1ciohL17Ov8phUq5o4gI
	Zn5sLZzLWjP5c9NbIlIcEi1HryBEYJrQ2AkbaFxYNK+rzjGLNoT3Sin553SruPusDunO
	czgleUm3SesFVKH/ZopGFNE9hhd7OPFP9ASd1TuMjwBzhhbQzOCx10ueW/qT9SEuygAW
	tnmj5Zb9WK92a9Jhy2q/d2IZW0oD+txf1Hk9foX5PUTu65XP7+jTFWu3E1Lx9YiJfp31
	EC7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
	:autocrypt:message-id:date:user-agent:mime-version:in-reply-to
	:content-language:content-transfer-encoding;
	bh=O2yNi+ITHG4LHCZzv2r03ObVcyiw2dRZFrO6h3MPc7U=;
	b=taMdRL0Br3Edl0r/ignVf8uJ4TFUx/5Jdx0bfJDuKVrmPmFrYlTXZVU5L7sHz6bSzb
	gcEaDvakJtaAczG5LLT85QqGj+TD3q+lSZ7F5CQlPQonqjnLGt6FM92gHcw6qXvleDmM
	B4mIdl63kJNyaOzUrNLxwnVfv96BzZbPKMzvm0SkueYyq3kLFsuhtz+UrFsnYB3kSz6a
	BQZ9KviNqPNuYm40P3jdYIOJ5Kn7OFmC38xTp/ssoQSBnZF4ZUibYcnYHb0CjFJtbet6
	MEWrUGcbfdkuJTMxYNjLQZUWlGEZtd/bCpge/DNciP5EbXnx3PUcR6ACEtGSAdvjWnzF
	rqqQ==
X-Gm-Message-State: APjAAAUWMpCpsrykJKbs1vzn5AJjRzvd+9wOKbRIJAemakLcjB6ICNtq
	9sFWUTX8p9aGF6HB4iTrx5ZxuFIvMYs=
X-Google-Smtp-Source: APXvYqynEbkrp92mw4RP4ecTpLHDqQVOL0JK74SkXAjYLcQt2J5d+GwcBl6bX3Wyaoe0Br9u/mS2NQ==
X-Received: by 2002:a9d:6494:: with SMTP id g20mr2802776otl.195.1559598519248; 
	Mon, 03 Jun 2019 14:48:39 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.googlemail.com with ESMTPSA id
	j189sm5570945oia.2.2019.06.03.14.48.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 14:48:37 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-5-mrolnik@gmail.com>
	<17b55a6e-af48-861d-6c2c-20bab1e45155@linaro.org>
	<CAK4993i6gM4v_dmOUbhHZOpDxXxKTueqRd-6COVk+z5U7VXK6w@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Openpgp: preference=signencrypt
Autocrypt: addr=rth@twiddle.net; prefer-encrypt=mutual; keydata=
	mQENBFGuLC8BCADcAoWcnW9lTsDMzbO3MBU+KbiGaj5JPatEUscRDkQYM2fyNjJp2tIWDK5a
	n4yngeXB3eX61WbYR3QraRK8mlYLGxyAdHMEQfPipbqf3TmN043fssT2bc82ApJcs1zvLYgI
	rhMht7Dck7A0wNC1jo+ZjVVFig5gDTN7gOzaAdBtV8tVNUddwkLzzaGpfihhSD6U46NdqKOG
	Wlnn6TrkMy0QGdQ5NaXHkRlUjnnUTSW/nKfoxD+EI+A9V4sYOd8mc/TL4aJh/i/AiU57eLbo
	n17uQI6/VTWDUWl8USiz4x9c8vmqlywLx00tAFxxoRWqk4KVJlj+Sh0up/D/sJ+vPpgBABEB
	AAG0I1JpY2hhcmQgSGVuZGVyc29uIDxydGhAdHdpZGRsZS5uZXQ+iQFBBBMBAgArAhsDBgsJ
	CAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUJC7UHogUCWaDNVgIZAQAKCRCtEnDMTdAnm9N5CADO
	cB8F/SudJ72IupxQf40hbJdBK176+gb3sHMsixyLtrU59lee+lIM1OZmlNjsnCYmiSnbA5ks
	Q7p0HfO7DgdmfLzcK6xsHZukqSZy5LByw348Y913ZyjOrJZFdPP7kDg1MnqRqH4+3ZdzxV4y
	eYBWFU9GYMIF06JbUubossOOO4ArNVZbnIPu8Vn2tDZVVqsCBqkoCSBMj519xrvyOu5z4mHS
	LkCglXmVDOXMbqLuNAC3rfNXSnyM4hYkLUyfALJlAAy1Ro+jUqYhu7XUFV/MiwRuFMh5GbtY
	Urkx7tqsWQXLT3GeDk/LqvpWJQwk4cHHckYjRih+70CHIenm81PVuQENBFGuLC8BCACyEx3x
	94HIkTX0CHu2sA0w75+h9wuoA8ggJ7+S4ri0y2YsijWad5TTt6z6MMiqxk9kSA5bppaj4HXh
	86hBF/dWCtMpNr3Rb8FNOKyeA/qkYHVD6HiAiw9c6D8Dr9hWmOk3/HSmGrNURxeUFOckDXsv
	I+yGGKBNshj59j7QZr7ZiuIi2rWlBL8dFN/OWa/o3x7HKsE4k6K8ngwvCKP/QbDLwLLBOWH+
	VEUtpyeyxTr3OJ47ECTxdYvXoAV2iJaKr+6doVQiiR5eVFiMYrUPUECJeolOCwqc/JlWE18L
	+PCAFaW1H+/mpPVfSpN4wnkJ5cQiQVB41IaCM4p20iRzx7ZJABEBAAGJASUEGAECAA8CGwwF
	AlmgzYEFCQu1CEoACgkQrRJwzE3QJ5s7rggAwABzDAGrZ6uWsMxg5PeiiAYPy6LBnCBJSpB5
	Tfy5jH8QTmLfXW+u4Ib4sWXG7PYNR7sIrtqUHjRqXLVXrSnBX9ASGcYw/Xil45khW6LsRpO1
	prHv9gkwQfa6fTiWXVfSfm2Nant6u02q+MaYtQpCVTiz/9ki4FfftUwUHFLU0MhIQogjd11y
	/E08RJsqBwaHQdt14PwU1HphDOzSkhOXRXQLSd3ysyeGUXvL+gqQoXl5XYdvk8IId4PoJRo4
	jcyJ4VbnldvXh5gdGhFA/f9JgkLk9tPW+C3wNtNWyRUq8azR9hF2fg2HJUf4IXQlIu8OOgh1
	VcROBqvtH3ecaIL9iw==
Message-ID: <0034b373-5c4d-ddf8-f4ae-33fab6a695f6@twiddle.net>
Date: Mon, 3 Jun 2019 16:48:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993i6gM4v_dmOUbhHZOpDxXxKTueqRd-6COVk+z5U7VXK6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 3:13 PM, Michael Rolnik wrote:
> Richard,
> I don't understand what I should do. Do you want me to merge decode files?

Yes, using the mechanisms previously described.


r~

> 
> On Fri, May 31, 2019 at 5:45 PM Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     On 5/30/19 2:07 PM, Michael Rolnik wrote:
>     > This includes:
>     > - encoding of all 16 bit instructions
>     > - encoding of all 32 bit instructions
>     >
>     > Signed-off-by: Michael Rolnik <mrolnik@gmail.com <mailto:mrolnik@gmail.com>>
>     > ---
>     >  target/avr/insn16.decode | 160 +++++++++++++++++++++++++++++++++++++++
>     >  target/avr/insn32.decode |  10 +++
>     >  2 files changed, 170 insertions(+)
>     >  create mode 100644 target/avr/insn16.decode
>     >  create mode 100644 target/avr/insn32.decode
> 
>     Two things:
> 
>     (1) decodetree can handle variable-width ISA now.
> 
>     It's slightly ugly in that the %field numbering is little-endian and thus
>     varies for each insn size.  But the in-flight patch set for target/rx shows
>     that it works.
> 
>     That said, I don't think you need that because,
> 
>     (2) The four instructions that are 32-bits do not have
>         any opcode bits in the second 16-bits.
> 
>     E.g.
> 
>     # The 22-bit immediate is partially in the opcode word,
>     # and partially in the next.  Use append_16 to build the
>     # complete 22-bit value.
>     %imm_call       4:5 0:1                 !function=append_16
>     CALL            1001 010. .... 111.     imm=%imm_call
>     JMP             1001 010. .... 110.     imm=%imm_call
> 
>     # The 16-bit immediate is completely in the next word.
>     # Fields cannot be defined with no bits, so we cannot play
>     # the same trick and append to a zero-bit value.
>     # Defer reading the immediate until trans_{LDS,STS}.
>     @ldst_s         .... ... rd:5 ....      imm=0
>     LDS             1001 000 ..... 0000     @ldst_s
>     STS             1001 001 ..... 0000     @ldst_s
> 
> 
>     static uint16_t next_word(DisasContext *ctx)
>     {
>         return cpu_lduw_code(ctx->env, ctx->npc++ * 2);
>     }
> 
>     static int append_16(DisasContext *ctx, int x)
>     {
>         return x << 16 | next_word(ctx);
>     }
> 
>     static bool trans_LDS(DisasContext *ctx, arg_ldst_s *a)
>     {
>         a->imm = next_word(ctx);
>         // other stuff
>     }
> 
>     I realize that next_word as written does not fit in to how you currently
>     process instructions in the loop, but I also think that's a mistake.  I'll
>     respond to that in its place in the next patch.
> 
>     That said, next_word *could* be written to use ctx->inst[0].opcode.
> 
> 
>     r~
> 
> 
> 
> -- 
> Best Regards,
> Michael Rolnik


