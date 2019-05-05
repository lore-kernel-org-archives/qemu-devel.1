Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7496FC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 09:36:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307CA208C0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 09:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307CA208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNDZC-0005gI-5q
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 05:36:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDXu-0004vr-NQ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDXt-0007xA-MZ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 05:34:58 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:37066
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hNDXr-0007sp-7k; Sun, 05 May 2019 05:34:55 -0400
Received: from host109-149-60-255.range109-149.btcentralplus.com
	([109.149.60.255] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hNDXB-0002SJ-FC; Sun, 05 May 2019 10:34:13 +0100
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net,
	gkurz@kaod.org
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-3-mark.cave-ayland@ilande.co.uk>
	<55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
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
Message-ID: <7227a96f-ae59-3ed4-8b1f-9e92005b4a69@ilande.co.uk>
Date: Sun, 5 May 2019 10:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <55204805-9275-2bc4-2c38-51dc87aa836d@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 109.149.60.255
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH 02/14] target/ppc: remove getVSR()/putVSR()
 from mem_helper.c
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
Message-ID: <20190505093447.sCFtJW_fsvsrZP2msrZvTSfucvcQwL3qSb4txDPaiUE@z>

On 30/04/2019 17:29, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>>  #define VSX_LXVL(name, lj)                                              \
>>  void helper_##name(CPUPPCState *env, target_ulong addr,                 \
>> -                   target_ulong xt_num, target_ulong rb)                \
>> +                   target_ulong xt, target_ulong rb)                    \
>>  {                                                                       \
>> +    ppc_vsr_t *r = &env->vsr[xt];                                       \
>> +    int nb = GET_NB(env->gpr[rb]);                                      \
>>      int i;                                                              \
>> -    ppc_vsr_t xt;                                                       \
>> -    uint64_t nb = GET_NB(rb);                                           \
>>                                                                          \
>> -    xt.s128 = int128_zero();                                            \
>> +    r->s128 = int128_zero();                                            \
>>      if (nb) {                                                           \
>>          nb = (nb >= 16) ? 16 : nb;                                      \
>>          if (msr_le && !lj) {                                            \
>>              for (i = 16; i > 16 - nb; i--) {                            \
>> -                xt.VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
>> +                r->VsrB(i - 1) = cpu_ldub_data_ra(env, addr, GETPC());  \
>>                  addr = addr_add(env, addr, 1);                          \
>>              }                                                           \
>>          } else {                                                        \
>>              for (i = 0; i < nb; i++) {                                  \
>> -                xt.VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
>> +                r->VsrB(i) = cpu_ldub_data_ra(env, addr, GETPC());      \
>>                  addr = addr_add(env, addr, 1);                          \
>>              }                                                           \
>>          }                                                               \
>>      }                                                                   \
>> -    putVSR(xt_num, &xt, env);                                           \
>>  }
> 
> Similarly, this modifies env->vsr[xt] before all exceptions are recognized.

Okay - if you're happy with my previous suggestion with the VSR* macros and the local
variable then I can make the same change here too.

>> @@ -304,12 +304,14 @@ static void gen_##name(DisasContext *ctx)                       \
>>          }                                                       \
>>      }                                                           \
>>      EA = tcg_temp_new();                                        \
>> -    xt = tcg_const_tl(xT(ctx->opcode));                         \
>>      gen_set_access_type(ctx, ACCESS_INT);                       \
>>      gen_addr_register(ctx, EA);                                 \
>> -    gen_helper_##name(cpu_env, EA, xt, cpu_gpr[rB(ctx->opcode)]); \
>> +    xt = tcg_const_tl(xT(ctx->opcode));                         \
>> +    rb = tcg_const_tl(rB(ctx->opcode));                         \
>> +    gen_helper_##name(cpu_env, EA, xt, rb);                     \
>>      tcg_temp_free(EA);                                          \
>>      tcg_temp_free(xt);                                          \
>> +    tcg_temp_free(rb);                                          \
>>  }
> 
> Why are you adjusting the function to pass the rB register number rather than
> the contents of rB?  That seems the wrong way around...

I think what I was trying to do here was eliminate the cpu_gpr since it feels to me
that with the vector patchsets and your negative offset patches that this should be
the way to go for accessing CPUState rather than using TCG globals.

Looking at this again I realise the solution is really the same as is currently used
for gen_load_spr() so I can use something like this:

    static inline void gen_load_gpr(TCGv t, int reg)
    {
        tcg_gen_ld_tl(t, cpu_env, offsetof(CPUPPCState, gpr[reg]));
    }

Does this seem reasonable as a solution?


ATB,

Mark.

