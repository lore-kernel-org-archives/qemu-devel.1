Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4215DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0161B20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFufRsgQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0161B20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbon8-0001NO-3V
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKY-0007tE-2Q
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:02 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKW-0007Io-TB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:01 -0400
Received: by mail-lf1-x141.google.com with SMTP id z206so1196327lfc.6
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=WeeQZiWZensuLGIJP+sCIaOhHMBDyTIWiHKs2HQj3/0=;
 b=hFufRsgQ+lvNzwsZMeBj83GZRLxc9qmgHcgtKo9lzJufM8MejGQ68pmqy36x9TWiZK
 DlAWpF39ifee18Y5TE9sm30kVRACyx4JqsPTNQShiKM2XUOJxIO8ZopcyfhZsKITEsxt
 HV6GQjmA/0gcZtCxd53+7xLPbKcK06vjGgeP/r1/WXy8pCiS1GqAwvV2kNWTH8wFKI3P
 4dKepCPCy3pPSA0+Cm3mVUaSsuDscmnrIgSBFVT6spJx0RuUBGRn/6FV2n3uEzOF95IM
 ij/cW5kR7txWqdtUfZZJxKhVqvNs2p0/jSIDn8+aTsLVFfFw7qqq9X4gNMOX25HiXHJY
 V7QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=WeeQZiWZensuLGIJP+sCIaOhHMBDyTIWiHKs2HQj3/0=;
 b=pUYZ5LucO3rdfx4VKf/6sAA/FBMy5Y4Vf8qstlve2yFhW16QxTn25rKoxXaDG0ZH6K
 VmKZ8tbYk4JwW0RkhVHJKfTJAGR5XeF5oyGKQvZ/g051gvCUPYzvMzPDfR9TNHyV50Yp
 OZvMj8A6eD+Rlnl3VlXKEPaB+CtpGTr8MVGeUBkpIUBz1cEgyiTh4/f3VTp+itar9IeL
 lJDPx4zQzQvyNLfVgmrJDdcg9uodZ8KPBe7L8vxU0tmW9+KVt9Vub23pScqXmkLa3IXr
 voOqIuZHXPcb3rRPOtdKv5OCEOpxCLYgYCUwDuzGynmdrtuMzEuuBSclaZt7kqOSA5kv
 nvPg==
X-Gm-Message-State: AOAM531yyR+zRvyzve7LzF3DZrx1zoP0nEdNcax1y2TXFcdSMsUFg6R+
 DIo6PMiBXsFyYc7UTpExs18=
X-Google-Smtp-Source: ABdhPJwlxle1FsYfSpzZOiNR0Rri950uc6GauaDOLSfc1zDJWEt4UvJxekMuyca2KKj+LAxUkz++uQ==
X-Received: by 2002:a19:c114:: with SMTP id r20mr5487080lff.210.1590079557243; 
 Thu, 21 May 2020 09:45:57 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id j10sm1824924ljc.21.2020.05.21.09.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:45:56 -0700 (PDT)
Date: Thu, 21 May 2020 18:45:39 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v9 10/74] cris: convert to helper_cpu_halted_set
Message-ID: <20200521164539.GF5519@toto>
References: <20200521164011.638-1-robert.foley@linaro.org>
 <20200521164011.638-11-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521164011.638-11-robert.foley@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: richard.henderson@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 12:39:07PM -0400, Robert Foley wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> And fix the temp leak along the way.
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/cris/translate.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/cris/translate.c b/target/cris/translate.c
> index aaa46b5bca..6c4f091b7a 100644
> --- a/target/cris/translate.c
> +++ b/target/cris/translate.c
> @@ -2823,8 +2823,9 @@ static int dec_rfe_etc(CPUCRISState *env, DisasContext *dc)
>      cris_cc_mask(dc, 0);
>  
>      if (dc->op2 == 15) {
> -        tcg_gen_st_i32(tcg_const_i32(1), cpu_env,
> -                       -offsetof(CRISCPU, env) + offsetof(CPUState, halted));
> +        TCGv_i32 tmp = tcg_const_i32(1);
> +        gen_helper_cpu_halted_set(cpu_env, tmp);
> +        tcg_temp_free_i32(tmp);
>          tcg_gen_movi_tl(env_pc, dc->pc + 2);
>          t_gen_raise_exception(EXCP_HLT);
>          return 2;
> -- 
> 2.17.1
> 

