Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4E7C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 09:32:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 861B62053B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 09:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 861B62053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38611 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNDVh-00042j-K6
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 05:32:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDTi-0002hG-W7
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:30:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDTh-0002Mu-2L
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:30:38 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:37046
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hNDTd-0000x8-6j; Sun, 05 May 2019 05:30:33 -0400
Received: from host109-149-60-255.range109-149.btcentralplus.com
	([109.149.60.255] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hNDPj-0002Pu-2v; Sun, 05 May 2019 10:26:31 +0100
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-2-mark.cave-ayland@ilande.co.uk>
	<fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
	mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
	3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
	E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
	PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
	PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
	AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
	OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
	NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
	mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
	z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
	T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
	DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
	y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
	2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
	14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
	YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
	Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
	BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
	opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
	NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
	Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
	KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
	imgcU9TTGC5qd9g=
Message-ID: <98ba8d01-dbab-ecde-ffbd-bb46efb29215@ilande.co.uk>
Date: Sun, 5 May 2019 10:27:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <fc4d6169-12d4-3fd8-f85a-262135a62b93@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.149.60.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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
Message-ID: <20190505092702.7NyxDznYhsfGa0tywpXkWs0htBfOjqgwzzwh86peOkA@z>

On 30/04/2019 17:25, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>>  void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>>  {
>> -    ppc_vsr_t xt, xa, xb;
>> +    ppc_vsr_t *xt = &env->vsr[rD(opcode) + 32];
>> +    ppc_vsr_t *xa = &env->vsr[rA(opcode) + 32];
>> +    ppc_vsr_t *xb = &env->vsr[rB(opcode) + 32];
>>      float_status tstat;
>>  
>> -    getVSR(rA(opcode) + 32, &xa, env);
>> -    getVSR(rB(opcode) + 32, &xb, env);
>> -    getVSR(rD(opcode) + 32, &xt, env);
>>      helper_reset_fpstatus(env);
>>  
>>      tstat = env->fp_status;
>> @@ -1860,18 +1857,17 @@ void helper_xsaddqp(CPUPPCState *env, uint32_t opcode)
>>      }
>>  
>>      set_float_exception_flags(0, &tstat);
>> -    xt.f128 = float128_add(xa.f128, xb.f128, &tstat);
>> +    xt->f128 = float128_add(xa->f128, xb->f128, &tstat);
>>      env->fp_status.float_exception_flags |= tstat.float_exception_flags;
>>  
>>      if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {
>>          float_invalid_op_addsub(env, 1, GETPC(),
>> -                                float128_classify(xa.f128) |
>> -                                float128_classify(xb.f128));
>> +                                float128_classify(xa->f128) |
>> +                                float128_classify(xb->f128));
> 
> These values are no longer valid, because you may have written over them with
> the store to xt->f128.  You need to keep the result in a local variable until
> the location of the putVSR in order to keep the current semantics.
> 
> (Although the current semantics probably need to be reviewed with respect to
> how the exception is signaled vs the result is stored to the register file.  I
> know there are current bugs in this area with respect to regular floating-point
> operations, never mind the vector floating-point ones.)
> 
>>  #define VSX_ADD_SUB(name, op, nels, tp, fld, sfprf, r2sp)                    \
>>  void helper_##name(CPUPPCState *env, uint32_t opcode)                        \
>>  {                                                                            \
>> -    ppc_vsr_t xt, xa, xb;                                                    \
>> +    ppc_vsr_t *xt = &env->vsr[xT(opcode)];                                   \
>> +    ppc_vsr_t *xa = &env->vsr[xA(opcode)];                                   \
>> +    ppc_vsr_t *xb = &env->vsr[xB(opcode)];                                   \
>>      int i;                                                                   \
>>                                                                               \
>> -    getVSR(xA(opcode), &xa, env);                                            \
>> -    getVSR(xB(opcode), &xb, env);                                            \
>> -    getVSR(xT(opcode), &xt, env);                                            \
>>      helper_reset_fpstatus(env);                                              \
>>                                                                               \
>>      for (i = 0; i < nels; i++) {                                             \
>>          float_status tstat = env->fp_status;                                 \
>>          set_float_exception_flags(0, &tstat);                                \
>> -        xt.fld = tp##_##op(xa.fld, xb.fld, &tstat);                          \
>> +        xt->fld = tp##_##op(xa->fld, xb->fld, &tstat);                       \
>>          env->fp_status.float_exception_flags |= tstat.float_exception_flags; \
>>                                                                               \
>>          if (unlikely(tstat.float_exception_flags & float_flag_invalid)) {    \
>>              float_invalid_op_addsub(env, sfprf, GETPC(),                     \
>> -                                    tp##_classify(xa.fld) |                  \
>> -                                    tp##_classify(xb.fld));                  \
>> +                                    tp##_classify(xa->fld) |                 \
>> +                                    tp##_classify(xb->fld));                 \
>>          }                                                                    \
> 
> Similarly.  Only here it's more interesting in that element 0 is modified when
> element 3 raises an exception.  To keep current semantics you need to keep xt
> as a ppc_vsr_t local variable and write back at the end.
> 
> It looks like the same is true for every other function.

Meh, so I forgot about the case where src == dest and obviously it's not something
that gets tickled by my test images :(

I've spent a bit of time today going through the functions and it seems that all
functions which have an xt parameter, minus a couple of the TEST macros, require the
result to be calculated in a local variable first.

I think the best solution is still to remove getVSR()/putVSR() but replace them with
macros for copying and zeroing like this:

    #define VSRCPY(d, s) (memcpy(d, s, sizeof(ppc_vsr_t)))
    #define VSRZERO(d)   (memset(d, 0, sizeof(ppc_vsr_t)))

Even though we're still doing a copy of the result register I hope that not having to
copy the 2 source registers, plus replacing the copies with a straight memcpy() will
still be an advantage. Does that seem sensible to you?

FWIW I agree that the exception handling seems inconsistent around the functions: for
example it looks strange that the VSX_FMADD code blindly copies the result back even
when an exception occurred.


ATB,

Mark.

