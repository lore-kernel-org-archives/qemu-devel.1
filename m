Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC78C04AA8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A679120644
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3u+WEDs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A679120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49829 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLVdi-0004Bx-0Z
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 12:29:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVZC-0000mx-Eq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLVZB-0002Qg-B3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:25:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLVZB-0002Ns-2N
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 12:25:13 -0400
Received: by mail-pf1-x442.google.com with SMTP id g3so7316822pfi.4
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=4wD4FScKy8+CMsWaPgBvplbhp5Qa5UnNRQDB5DLVOBk=;
	b=E3u+WEDsoYHQJeuOPAzQH0CCQ3K20Gz5h90IYyR5lalzoD53Iz56MQ1J6SGFBz/v0d
	NSavov/EY/LxltHlFwjDdHFEejNYJizKeBadvil/+9wvQdIUFcAvak6n2G9NzRE8vlyX
	mS6dHD9YiSAVgLvlc/8FiNTagWh5PAM3kaY1vBDFZKtVZ6MOZ+Qxvh+prvtfh2urhPcm
	o9t5dn1gUMu4QTDzvYKfX0fsyG0GEXCFLDjMsSOK6b2iB7t8ltcKsijKpFjb/1FcFB20
	CQy3QXkTjJxH35THJ45nBg5t1HXNAfgMOFYrwfBw+8ZA5AU/pvg5X/RKOLjqlgU0RSEp
	fO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=4wD4FScKy8+CMsWaPgBvplbhp5Qa5UnNRQDB5DLVOBk=;
	b=k3JbvCW0x2mBEF9Tyf8JrBywcGkk8OrF3zrznOJ6v2NeI46hYWa7CtMR8gC26SRVoZ
	XCYo4cfkLCJhVxQmCsajlzyLUoflb/UiJuypw4Q0JiFxhi2qQsAnmREeusv5euhQoJF1
	G0xtaK0S81C6Pxz5PkESuuTn3G12l8asENS1k+gHdSLzRdADZ84Qztt6IF0I6d/VmFeL
	nAI8BDQLIVrT0l0XAtwL61GVH13NmKifs3VFNnAdVWO72ylS6zDguLyzL3j0XCIb9IIP
	AryCNJ45zlsMpY1JfhuEQcCS5oHXlEMu+neIYS1qZwtxrfsazw216oCdsBXb1DGD7pgp
	7hqg==
X-Gm-Message-State: APjAAAVW3Q+5ZCdRGJeRiSY83NllBWCYjroqdXfsX5+Srm3bu/roxrPb
	NkQs0NigpTU64MqvvJ4rCFgtNw==
X-Google-Smtp-Source: APXvYqzp2Ldjs/V13tJTrA3edohlepoivcjNvDGM83NVOUzSHIw5gEkbRMS1JK6oOYs5Up6zhMjQcw==
X-Received: by 2002:a65:6212:: with SMTP id d18mr67650927pgv.162.1556641510952;
	Tue, 30 Apr 2019 09:25:10 -0700 (PDT)
Received: from [192.168.1.11] (97-113-18-231.tukw.qwest.net. [97.113.18.231])
	by smtp.gmail.com with ESMTPSA id
	b5sm3006868pfo.153.2019.04.30.09.25.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 09:25:09 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
Date: Tue, 30 Apr 2019 09:25:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 01/14] target/ppc: remove getVSR()/putVSR()
 from fpu_helper.c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430162503.2lqJineOpY9Hg_U_nFgpXpW6L7u5oPG4eqwbL5KgpDA@z>

On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>  void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>  {
> -    ppc_vsr_t xt, xa, xb;
> +    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
> +    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
> +    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
>      float_status tstat;
>  
> -    getVSR(rA(opcode) + 32, &xa, env);
> -    getVSR(rB(opcode) + 32, &xb, env);
> -    getVSR(rD(opcode) + 32, &xt, env);
>      helper_reset_fpstatus(env);
>  
>      tstat = env->fp_status;
> @@ -1860,18 +1857,17 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>      }
>  
>      set_float_exception_flags(0, &tstat);
> -    xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
> +    xt->f128 = float128_add(xa->f128, xb->f128, &tstat);
>      env->fp_status.float_exception_flags |= tstat.float_exception_flags;
>  
>      if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
>          float_invalid_op_addsub(env, 1, GETPC(),
> -                                float128_classify(xa.f128) |
> -                                float128_classify(xb.f128));
> +                                float128_classify(xa->f128) |
> +                                float128_classify(xb->f128));

These values are no longer valid, because you may have written over them with
the store to xt->f128.  You need to keep the result in a local variable until
the location of the putVSR in order to keep the current semantics.

(Although the current semantics probably need to be reviewed with respect to
how the exception is signaled vs the result is stored to the register file.  I
know there are current bugs in this area with respect to regular floating-point
operations, never mind the vector floating-point ones.)

>  #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
>  void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
>  {                                                                            \
> -    ppc_vsr_t xt, xa, xb;                                                    \
> +    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
> +    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
> +    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
>      int i;                                                                   \
>                                                                               \
> -    getVSR(xA(opcode), &xa, env);                                            \
> -    getVSR(xB(opcode), &xb, env);                                            \
> -    getVSR(xT(opcode), &xt, env);                                            \
>      helper_reset_fpstatus(env);                                              \
>                                                                               \
>      for (i = 0; i < nels; i++) {                                             \
>          float_status tstat = env->fp_status;                                 \
>          set_float_exception_flags(0, &tstat);                                \
> -        xt.fld = tp##_##op(xa.fld, xb.fld, &tstat);                          \
> +        xt->fld = tp##_##op(xa->fld, xb->fld, &tstat);                       \
>          env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
>                                                                               \
>          if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
>              float_invalid_op_addsub(env, sfprf, GETPC(),                     \
> -                                    tp##_classify(xa.fld) |                  \
> -                                    tp##_classify(xb.fld));                  \
> +                                    tp##_classify(xa->fld) |                 \
> +                                    tp##_classify(xb->fld));                 \
>          }                                                                    \

Similarly.  Only here it's more interesting in that element 0 is modified when
element 3 raises an exception.  To keep current semantics you need to keep xt
as a ppc_vsr_t local variable and write back at the end.

It looks like the same is true for every other function.


r~

