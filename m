Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C62BC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169892146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 22:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169892146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCtWu-0007dM-KJ
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 18:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCtUP-0005t7-ED
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1iCtUN-0004Kx-Tf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 18:40:57 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:36562
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCtUK-0004GG-Jq; Tue, 24 Sep 2019 18:40:52 -0400
Received: from host86-138-245-63.range86-138.btcentralplus.com
 ([86.138.245.63] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1iCsbe-00013j-EG; Tue, 24 Sep 2019 22:44:23 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, pc@us.ibm.com,
 david@gibson.dropbear.id.au
References: <20190924153556.27575-1-mark.cave-ayland@ilande.co.uk>
 <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
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
Message-ID: <df4c2fa0-8a8b-07cf-c04d-cb3e804fbbd5@ilande.co.uk>
Date: Tue, 24 Sep 2019 22:44:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924153556.27575-7-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 86.138.245.63
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 6/7] target/ppc: use existing VsrD() macro to eliminate
 HI_IDX and LO_IDX from dfp_helper.c
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
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

On 24/09/2019 16:35, Mark Cave-Ayland wrote:
> Switch over all accesses to the decimal numbers held in struct PPC_DFP from
> using HI_IDX and LO_IDX to using the VsrD() macro instead. Not only does this
> allow the compiler to ensure that the various dfp_* functions are being passed
> a ppc_vsr_t rather than an arbitrary uint64_t pointer, but also allows the
> host endian-specific HI_IDX and LO_IDX to be completely removed from
> dfp_helper.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/dfp_helper.c | 70 ++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 39 deletions(-)
> 
> diff --git a/target/ppc/dfp_helper.c b/target/ppc/dfp_helper.c
> index ed437f97da..c2d335e928 100644
> --- a/target/ppc/dfp_helper.c
> +++ b/target/ppc/dfp_helper.c
> @@ -28,13 +28,6 @@
>  #include "libdecnumber/dpd/decimal64.h"
>  #include "libdecnumber/dpd/decimal128.h"
>  
> -#if defined(HOST_WORDS_BIGENDIAN)
> -#define HI_IDX 0
> -#define LO_IDX 1
> -#else
> -#define HI_IDX 1
> -#define LO_IDX 0
> -#endif
>  
>  static void get_dfp64(ppc_vsr_t *dst, ppc_fprp_t *dfp)
>  {
> @@ -1039,31 +1032,31 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b)              \
>  DFP_HELPER_CTFIX(dctfix, 64)
>  DFP_HELPER_CTFIX(dctfixq, 128)
>  
> -static inline void dfp_set_bcd_digit_64(uint64_t *t, uint8_t digit,
> -                                            unsigned n)
> +static inline void dfp_set_bcd_digit_64(ppc_vsr_t *t, uint8_t digit,
> +                                        unsigned n)
>  {
> -    *t |= ((uint64_t)(digit & 0xF) << (n << 2));
> +    t->VsrD(1) |= ((uint64_t)(digit & 0xF) << (n << 2));
>  }
>  
> -static inline void dfp_set_bcd_digit_128(uint64_t *t, uint8_t digit,
> -                                             unsigned n)
> +static inline void dfp_set_bcd_digit_128(ppc_vsr_t *t, uint8_t digit,
> +                                         unsigned n)
>  {
> -    t[(n & 0x10) ? HI_IDX : LO_IDX] |=
> +    t->VsrD((n & 0x10) ? 0 : 1) |=
>          ((uint64_t)(digit & 0xF) << ((n & 15) << 2));
>  }
>  
> -static inline void dfp_set_sign_64(uint64_t *t, uint8_t sgn)
> +static inline void dfp_set_sign_64(ppc_vsr_t *t, uint8_t sgn)
>  {
> -    *t <<= 4;
> -    *t |= (sgn & 0xF);
> +    t->VsrD(1) <<= 4;
> +    t->VsrD(1) |= (sgn & 0xF);
>  }
>  
> -static inline void dfp_set_sign_128(uint64_t *t, uint8_t sgn)
> +static inline void dfp_set_sign_128(ppc_vsr_t *t, uint8_t sgn)
>  {
> -    t[HI_IDX] <<= 4;
> -    t[HI_IDX] |= (t[LO_IDX] >> 60);
> -    t[LO_IDX] <<= 4;
> -    t[LO_IDX] |= (sgn & 0xF);
> +    t->VsrD(0) <<= 4;
> +    t->VsrD(0) |= (t->VsrD(0) >> 60)                      ^^^^^^^^^^

I've just noticed that I've made a typo here: the line above should of course read:

    t->VsrD(0) |= (t->VsrD(1) >> 60);

> +    t->VsrD(1) <<= 4;
> +    t->VsrD(1) |= (sgn & 0xF);
>  }
>  
>  #define DFP_HELPER_DEDPD(op, size)                                        \
> @@ -1081,7 +1074,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
>      N = dfp.b.digits;                                                     \
>                                                                            \
>      for (i = 0; (i < N) && (i < (size)/4); i++) {                         \
> -        dfp_set_bcd_digit_##size(&dfp.vt.u64[0], digits[N - i - 1], i);   \
> +        dfp_set_bcd_digit_##size(&dfp.vt, digits[N - i - 1], i);          \
>      }                                                                     \
>                                                                            \
>      if (sp & 2) {                                                         \
> @@ -1092,7 +1085,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
>          } else {                                                          \
>              sgn = ((sp & 1) ? 0xF : 0xC);                                 \
>          }                                                                 \
> -        dfp_set_sign_##size(&dfp.vt.u64[0], sgn);                         \
> +        dfp_set_sign_##size(&dfp.vt, sgn);                                \
>      }                                                                     \
>                                                                            \
>      if (size == 64) {                                                     \
> @@ -1105,14 +1098,14 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,          \
>  DFP_HELPER_DEDPD(ddedpd, 64)
>  DFP_HELPER_DEDPD(ddedpdq, 128)
>  
> -static inline uint8_t dfp_get_bcd_digit_64(uint64_t *t, unsigned n)
> +static inline uint8_t dfp_get_bcd_digit_64(ppc_vsr_t *t, unsigned n)
>  {
> -    return *t >> ((n << 2) & 63) & 15;
> +    return t->VsrD(1) >> ((n << 2) & 63) & 15;
>  }
>  
> -static inline uint8_t dfp_get_bcd_digit_128(uint64_t *t, unsigned n)
> +static inline uint8_t dfp_get_bcd_digit_128(ppc_vsr_t *t, unsigned n)
>  {
> -    return t[(n & 0x10) ? HI_IDX : LO_IDX] >> ((n << 2) & 63) & 15;
> +    return t->VsrD((n & 0x10) ? 0 : 1) >> ((n << 2) & 63) & 15;
>  }
>  
>  #define DFP_HELPER_ENBCD(op, size)                                           \
> @@ -1128,8 +1121,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,             \
>      decNumberZero(&dfp.t);                                                   \
>                                                                               \
>      if (s) {                                                                 \
> -        uint8_t sgnNibble = dfp_get_bcd_digit_##size(&dfp.vb.u64[0],         \
> -                                                     offset++);              \
> +        uint8_t sgnNibble = dfp_get_bcd_digit_##size(&dfp.vb, offset++);     \
>          switch (sgnNibble) {                                                 \
>          case 0xD:                                                            \
>          case 0xB:                                                            \
> @@ -1149,7 +1141,7 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b,             \
>                                                                               \
>      while (offset < (size) / 4) {                                            \
>          n++;                                                                 \
> -        digits[(size) / 4 - n] = dfp_get_bcd_digit_##size(&dfp.vb.u64[0],    \
> +        digits[(size) / 4 - n] = dfp_get_bcd_digit_##size(&dfp.vb,           \
>                                                            offset++);         \
>          if (digits[(size) / 4 - n] > 10) {                                   \
>              dfp_set_FPSCR_flag(&dfp, FP_VX | FP_VXCVI, FPSCR_VE);            \
> @@ -1212,16 +1204,16 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *b) \
>  DFP_HELPER_XEX(dxex, 64)
>  DFP_HELPER_XEX(dxexq, 128)
>  
> -static void dfp_set_raw_exp_64(uint64_t *t, uint64_t raw)
> +static void dfp_set_raw_exp_64(ppc_vsr_t *t, uint64_t raw)
>  {
> -    *t &= 0x8003ffffffffffffULL;
> -    *t |= (raw << (63 - 13));
> +    t->VsrD(1) &= 0x8003ffffffffffffULL;
> +    t->VsrD(1) |= (raw << (63 - 13));
>  }
>  
> -static void dfp_set_raw_exp_128(uint64_t *t, uint64_t raw)
> +static void dfp_set_raw_exp_128(ppc_vsr_t *t, uint64_t raw)
>  {
> -    t[HI_IDX] &= 0x80003fffffffffffULL;
> -    t[HI_IDX] |= (raw << (63 - 17));
> +    t->VsrD(0) &= 0x80003fffffffffffULL;
> +    t->VsrD(0) |= (raw << (63 - 17));
>  }
>  
>  #define DFP_HELPER_IEX(op, size)                                          \
> @@ -1258,11 +1250,11 @@ void helper_##op(CPUPPCState *env, ppc_fprp_t *t, ppc_fprp_t *a,          \
>          dfp.vt.VsrD(0) = dfp.vb.VsrD(0);                                  \
>          dfp.vt.VsrD(1) = dfp.vb.VsrD(1);                                  \
>          if (exp == -1) {                                                  \
> -            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_inf);              \
> +            dfp_set_raw_exp_##size(&dfp.vt, raw_inf);                     \
>          } else if (exp == -3) {                                           \
> -            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_snan);             \
> +            dfp_set_raw_exp_##size(&dfp.vt, raw_snan);                    \
>          } else {                                                          \
> -            dfp_set_raw_exp_##size(&dfp.vt.u64[0], raw_qnan);             \
> +            dfp_set_raw_exp_##size(&dfp.vt, raw_qnan);                    \
>          }                                                                 \
>      } else {                                                              \
>          dfp.t = dfp.b;                                                    \


ATB,

Mark.

