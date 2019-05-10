Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006DBC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:09:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8546216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:09:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8546216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP78u-0001h9-1Z
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:09:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hP77W-00012l-Dh
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:07:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hP77V-0008Mj-AF
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:07:34 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:45770
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hP77S-0008Kx-D1; Fri, 10 May 2019 11:07:30 -0400
Received: from host109-147-184-225.range109-147.btcentralplus.com
	([109.147.184.225] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hP76o-0000kF-M4; Fri, 10 May 2019 16:06:51 +0100
To: Anton Blanchard <anton@ozlabs.org>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<20190507052815.GK7073@umbus.fritz.box>
	<c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
	<20190509103545.4a7fa71a@kryten>
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
Message-ID: <960497f1-299c-131c-21a7-b62b9fe59868@ilande.co.uk>
Date: Fri, 10 May 2019 16:07:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509103545.4a7fa71a@kryten>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 109.147.184.225
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Optimise VSX_LOAD_SCALAR_DS
 and VSX_VECTOR_LOAD_STORE
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/2019 01:35, Anton Blanchard wrote:

> A few small optimisations:
> 
> In VSX_LOAD_SCALAR_DS() we can don't need to read the VSR via
> get_cpu_vsrh().
> 
> Split VSX_VECTOR_LOAD_STORE() into two functions. Loads only need to
> write the VSRs (set_cpu_vsr*()) and stores only need to read the VSRs
> (get_cpu_vsr*())
> 
> Thanks to Mark Cave-Ayland for the suggestions.
> 
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 68 ++++++++++++++++++++++++-----
>  1 file changed, 58 insertions(+), 10 deletions(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
> index 4b7627f53b..cdb44b8b70 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -228,7 +228,7 @@ static void gen_lxvb16x(DisasContext *ctx)
>      tcg_temp_free_i64(xtl);
>  }
>  
> -#define VSX_VECTOR_LOAD_STORE(name, op, indexed)            \
> +#define VSX_VECTOR_LOAD(name, op, indexed)                  \
>  static void gen_##name(DisasContext *ctx)                   \
>  {                                                           \
>      int xt;                                                 \
> @@ -255,8 +255,6 @@ static void gen_##name(DisasContext *ctx)                   \
>      }                                                       \
>      xth = tcg_temp_new_i64();                               \
>      xtl = tcg_temp_new_i64();                               \
> -    get_cpu_vsrh(xth, xt);                                  \
> -    get_cpu_vsrl(xtl, xt);                                  \
>      gen_set_access_type(ctx, ACCESS_INT);                   \
>      EA = tcg_temp_new();                                    \
>      if (indexed) {                                          \
> @@ -282,10 +280,61 @@ static void gen_##name(DisasContext *ctx)                   \
>      tcg_temp_free_i64(xtl);                                 \
>  }
>  
> -VSX_VECTOR_LOAD_STORE(lxv, ld_i64, 0)
> -VSX_VECTOR_LOAD_STORE(stxv, st_i64, 0)
> -VSX_VECTOR_LOAD_STORE(lxvx, ld_i64, 1)
> -VSX_VECTOR_LOAD_STORE(stxvx, st_i64, 1)
> +VSX_VECTOR_LOAD(lxv, ld_i64, 0)
> +VSX_VECTOR_LOAD(lxvx, ld_i64, 1)
> +
> +#define VSX_VECTOR_STORE(name, op, indexed)                 \
> +static void gen_##name(DisasContext *ctx)                   \
> +{                                                           \
> +    int xt;                                                 \
> +    TCGv EA;                                                \
> +    TCGv_i64 xth;                                           \
> +    TCGv_i64 xtl;                                           \
> +                                                            \
> +    if (indexed) {                                          \
> +        xt = xT(ctx->opcode);                               \
> +    } else {                                                \
> +        xt = DQxT(ctx->opcode);                             \
> +    }                                                       \
> +                                                            \
> +    if (xt < 32) {                                          \
> +        if (unlikely(!ctx->vsx_enabled)) {                  \
> +            gen_exception(ctx, POWERPC_EXCP_VSXU);          \
> +            return;                                         \
> +        }                                                   \
> +    } else {                                                \
> +        if (unlikely(!ctx->altivec_enabled)) {              \
> +            gen_exception(ctx, POWERPC_EXCP_VPU);           \
> +            return;                                         \
> +        }                                                   \
> +    }                                                       \
> +    xth = tcg_temp_new_i64();                               \
> +    xtl = tcg_temp_new_i64();                               \
> +    get_cpu_vsrh(xth, xt);                                  \
> +    get_cpu_vsrl(xtl, xt);                                  \
> +    gen_set_access_type(ctx, ACCESS_INT);                   \
> +    EA = tcg_temp_new();                                    \
> +    if (indexed) {                                          \
> +        gen_addr_reg_index(ctx, EA);                        \
> +    } else {                                                \
> +        gen_addr_imm_index(ctx, EA, 0x0F);                  \
> +    }                                                       \
> +    if (ctx->le_mode) {                                     \
> +        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_LEQ);   \
> +        tcg_gen_addi_tl(EA, EA, 8);                         \
> +        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_LEQ);   \
> +    } else {                                                \
> +        tcg_gen_qemu_##op(xth, EA, ctx->mem_idx, MO_BEQ);   \
> +        tcg_gen_addi_tl(EA, EA, 8);                         \
> +        tcg_gen_qemu_##op(xtl, EA, ctx->mem_idx, MO_BEQ);   \
> +    }                                                       \
> +    tcg_temp_free(EA);                                      \
> +    tcg_temp_free_i64(xth);                                 \
> +    tcg_temp_free_i64(xtl);                                 \
> +}
> +
> +VSX_VECTOR_STORE(stxv, st_i64, 0)
> +VSX_VECTOR_STORE(stxvx, st_i64, 1)
>  
>  #ifdef TARGET_PPC64
>  #define VSX_VECTOR_LOAD_STORE_LENGTH(name)                      \
> @@ -330,7 +379,6 @@ static void gen_##name(DisasContext *ctx)                         \
>          return;                                                   \
>      }                                                             \
>      xth = tcg_temp_new_i64();                                     \
> -    get_cpu_vsrh(xth, rD(ctx->opcode) + 32);                      \
>      gen_set_access_type(ctx, ACCESS_INT);                         \
>      EA = tcg_temp_new();                                          \
>      gen_addr_imm_index(ctx, EA, 0x03);                            \
> @@ -514,8 +562,8 @@ static void gen_##name(DisasContext *ctx)                         \
>      tcg_temp_free_i64(xth);                                       \
>  }
>  
> -VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
> -VSX_LOAD_SCALAR_DS(stxssp, st32fs)
> +VSX_STORE_SCALAR_DS(stxsd, st64_i64)
> +VSX_STORE_SCALAR_DS(stxssp, st32fs)
>  
>  static void gen_mfvsrwz(DisasContext *ctx)
>  {

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

