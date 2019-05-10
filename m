Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541BC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF7F1216C4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 15:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF7F1216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44881 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP7Eq-0003wC-LU
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 11:15:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hP7Du-0003Y8-KC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hP7Dt-0003a6-HC
	for qemu-devel@nongnu.org; Fri, 10 May 2019 11:14:10 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:45812
	helo=mail.default.ilande.uk0.bigv.io)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hP7Dt-0003ZE-AT; Fri, 10 May 2019 11:14:09 -0400
Received: from host109-147-184-225.range109-147.btcentralplus.com
	([109.147.184.225] helo=[192.168.1.65])
	by mail.default.ilande.uk0.bigv.io with esmtpsa
	(TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
	(envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1hP7B5-0000mV-Uf; Fri, 10 May 2019 16:11:16 +0100
To: Anton Blanchard <anton@ozlabs.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
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
Message-ID: <c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
Date: Fri, 10 May 2019 16:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507004811.29968-4-anton@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 109.147.184.225
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
	richard.henderson@linaro.org, f4bug@amsat.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/05/2019 01:48, Anton Blanchard wrote:

> During the conversion these instructions were incorrectly treated as
> stores. We need to use set_cpu_vsr* and not get_cpu_vsr*.
> 
> Fixes: 8b3b2d75c7c0 ("introduce get_cpu_vsr{l,h}() and set_cpu_vsr{l,h}() helpers for VSR register access")
> Signed-off-by: Anton Blanchard <anton@ozlabs.org>
> ---
>  target/ppc/translate/vsx-impl.inc.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/vsx-impl.inc.c
> index 05b75105be..c13f84e745 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -102,8 +102,7 @@ static void gen_lxvw4x(DisasContext *ctx)
>      }
>      xth = tcg_temp_new_i64();
>      xtl = tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
> +
>      gen_set_access_type(ctx, ACCESS_INT);
>      EA = tcg_temp_new();
>  
> @@ -126,6 +125,8 @@ static void gen_lxvw4x(DisasContext *ctx)
>          tcg_gen_addi_tl(EA, EA, 8);
>          tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -185,8 +186,6 @@ static void gen_lxvh8x(DisasContext *ctx)
>      }
>      xth = tcg_temp_new_i64();
>      xtl = tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
>  
>      EA = tcg_temp_new();
> @@ -197,6 +196,8 @@ static void gen_lxvh8x(DisasContext *ctx)
>      if (ctx->le_mode) {
>          gen_bswap16x8(xth, xtl, xth, xtl);
>      }
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);
> @@ -214,14 +215,14 @@ static void gen_lxvb16x(DisasContext *ctx)
>      }
>      xth = tcg_temp_new_i64();
>      xtl = tcg_temp_new_i64();
> -    get_cpu_vsrh(xth, xT(ctx->opcode));
> -    get_cpu_vsrl(xtl, xT(ctx->opcode));
>      gen_set_access_type(ctx, ACCESS_INT);
>      EA = tcg_temp_new();
>      gen_addr_reg_index(ctx, EA);
>      tcg_gen_qemu_ld_i64(xth, EA, ctx->mem_idx, MO_BEQ);
>      tcg_gen_addi_tl(EA, EA, 8);
>      tcg_gen_qemu_ld_i64(xtl, EA, ctx->mem_idx, MO_BEQ);
> +    set_cpu_vsrh(xT(ctx->opcode), xth);
> +    set_cpu_vsrl(xT(ctx->opcode), xtl);
>      tcg_temp_free(EA);
>      tcg_temp_free_i64(xth);
>      tcg_temp_free_i64(xtl);

I've now had a bit of time to look through this and I believe it is correct, so:

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.

