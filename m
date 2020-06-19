Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FECC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47209214D8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAFoJzo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47209214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmM3e-0005WX-JP
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 14:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmM2q-00050g-4t; Fri, 19 Jun 2020 14:47:20 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmM2o-0004cU-KY; Fri, 19 Jun 2020 14:47:19 -0400
Received: by mail-wr1-x441.google.com with SMTP id q11so10682610wrp.3;
 Fri, 19 Jun 2020 11:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cfFZTJh7SWZaZSP+mXD+NHvfl/ZASrDnfLHQUefSvXM=;
 b=eAFoJzo+GfNwohAp8B66mzA8cXiChGcnVUfa5qwNcUOk09TuJKJ7ex43Zpj21OrvQV
 DpZxDt/QdXI2vLrNg/CvO/WIseZNWZhLrVWJqvURdUlbOEOo43u5NMGxCAtGb4DiBMm5
 mXll9101go6D84mQxmlXJNaaKZrEOu9TG6x1Y9F0HSVvEMW45GYCQbZHOE/eY8vdAIQI
 STS5IpZKWXxXLG/aT76MajfWkiyoLBRSSr+4GaTxAM90zx0csWHEwkwsz59YjPX4qVHt
 moE5ci90ovOZnK+f7vCRKIrXEB9IhVjbp38h/DVN6/gRE+ARY9NuxLADGGNB5RgqUxK5
 gD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cfFZTJh7SWZaZSP+mXD+NHvfl/ZASrDnfLHQUefSvXM=;
 b=RztEgVfHf4a0s3BM86E+TO5tW1BhSXj0WhtT1sIID7+3OLBwR4vxplvujHj0HntQoj
 1xeoeYS4sToXaCtVFIGce9SZnfMJaC9U4GT4giX57sZyCUiaqg0CYBTvvu7NIcXGBuiI
 Opc3ADpaqsgxS7vsBmYJhDdyning1NadFXNOiRXQDYUnsQqSwfcQNs1s1s4c6jCjvZdo
 oA/NnQCoaJ9rkQgxTcd27EnibQer6abAPrMllZi49DA57vkpp4K4kfeSthfqffCdd9oF
 753mX+FiOybPIcU04RmDdr6Pccu7gpOFsPxPDMJhPMr0DSEbCorQoMFf3VXKWlSqEw0z
 tWdA==
X-Gm-Message-State: AOAM530r2PvH5xadARPiQJc0USLls3BNdXOgePfHcfjHkbdoLgmwUyAZ
 xuRtRynx71dpkaHNFIr0dMc=
X-Google-Smtp-Source: ABdhPJw16GciJtRqgUUJBGCDrLEPBReAlLTesuwRYlyQJEbwAk9F+ebVgHl46VIc2aafNwByT6rHMw==
X-Received: by 2002:adf:a111:: with SMTP id o17mr5416791wro.257.1592592435337; 
 Fri, 19 Jun 2020 11:47:15 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id g19sm7413287wmh.29.2020.06.19.11.47.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 11:47:14 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Remove dead code relating to SABA and UABA
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200619171547.29780-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d08f0a0c-a819-18f6-bdd4-bacfc34c5797@amsat.org>
Date: Fri, 19 Jun 2020 20:47:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200619171547.29780-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 7:15 PM, Peter Maydell wrote:
> In commit cfdb2c0c95ae9205b0 ("target/arm: Vectorize SABA/UABA") we
> replaced the old handling of SABA/UABA with a vectorized implementation
> which returns early rather than falling into the loop-ever-elements
> code. We forgot to delete the part of the old looping code that
> did the accumulate step, and Coverity correctly warns (CID 1428955)
> that this code is now dead. Delete it.
> 
> Fixes: cfdb2c0c95ae9205b0
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-a64.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index a0e72ad6942..01d59164d68 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -11370,18 +11370,6 @@ static void disas_simd_3same_int(DisasContext *s, uint32_t insn)
>                  genfn(tcg_res, tcg_op1, tcg_op2);
>              }
>  
> -            if (opcode == 0xf) {
> -                /* SABA, UABA: accumulating ops */
> -                static NeonGenTwoOpFn * const fns[3] = {
> -                    gen_helper_neon_add_u8,
> -                    gen_helper_neon_add_u16,
> -                    tcg_gen_add_i32,
> -                };
> -
> -                read_vec_element_i32(s, tcg_op1, rd, pass, MO_32);
> -                fns[size](tcg_res, tcg_op1, tcg_res);
> -            }
> -
>              write_vec_element_i32(s, tcg_res, rd, pass, MO_32);
>  
>              tcg_temp_free_i32(tcg_res);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


