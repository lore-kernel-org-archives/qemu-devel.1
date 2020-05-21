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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D47C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:13:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC9920759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcKaYluU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC9920759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbolF-0006E7-PF
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboK7-0006nx-7h
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:45:35 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboK5-0007BQ-Ur
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:45:34 -0400
Received: by mail-lj1-x241.google.com with SMTP id v16so9105581ljc.8
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=P8/ZRYeOG5B+jSgE1NVudAwxcAC9WImDYte2116gw7s=;
 b=gcKaYluUiLW+iAouc4NoZ1VdeYd6HEryprONPJaBxjn/akCcTOKL7ZC2HpnyhZLYao
 NnCrtd3RWmFleEypMRAt28GrGkVPzEKCPUb1Q2mzxJfgPhz++n9h/fKN8isYjXX/8UwI
 WcKDwAYqEEGhGvl1I8culcdqeIBJMhBMvxWKaBQ0Vjxy6cGvm0X5d6llgIz68huTUt75
 GlGlz2qozaqHKP13HClGtxsOoargJ0DisNB79cFffB2xfj3OV5jVHG80J34g4qi0M5Lg
 rcx2weSfO1msVLM87zXZ+kFze28wSBe+co2EIQSfuYTsEoDkm/hHYJ0iN2CJKfXUoVdh
 LvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=P8/ZRYeOG5B+jSgE1NVudAwxcAC9WImDYte2116gw7s=;
 b=LXTTUT1UTz6o69LN6AiWnjDFue2z6uUm5YlmI6wuROdBetxbnxz/ZWP2fFfdH5n+MY
 pvAN45oab7SDZXXwNCB81cibwAvEWPJrr8THlBlhT7h0jbqYk5zrbOzDE3iAkWNdfwEj
 YHatwuGbFb8eaopNj1RYkTSd/o5vOe6PvuZdIPSVYAGACLOz9vy8E+0XSeWahBqHP/zM
 1CpXnnsfxHvQYdlHaVSHFDIEYYzijeSWifODlixll5ssJ9lelNBlvmFaqV630VtSypBK
 zX2zCRowaPVRPWFd3k73j2aFFORCe762y3ysmkWaWmMQ8Gcu3nvqSuelAzXOwOwLIi1H
 uTQw==
X-Gm-Message-State: AOAM532YyVP7vfJpD6+koSjfHyha6cU/jnhKrNOLbScBvMAKw4E8pXj+
 IlhbE0c+0cAAaGj5muA2U8g=
X-Google-Smtp-Source: ABdhPJzzwHUfZPa7mi/Pxpko7fk5CSneHB0ygTQTWkoQ2GVAX23V83munLa4xUA0cFcZNInxTNdZ8Q==
X-Received: by 2002:a2e:1f02:: with SMTP id f2mr5380237ljf.156.1590079531338; 
 Thu, 21 May 2020 09:45:31 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id a6sm957410ljj.125.2020.05.21.09.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:45:30 -0700 (PDT)
Date: Thu, 21 May 2020 18:45:13 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v9 14/74] microblaze: convert to helper_cpu_halted_set
Message-ID: <20200521164513.GE5519@toto>
References: <20200521164011.638-1-robert.foley@linaro.org>
 <20200521164011.638-15-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521164011.638-15-robert.foley@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
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

On Thu, May 21, 2020 at 12:39:11PM -0400, Robert Foley wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/microblaze/translate.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index f6ff2591c3..c08a7f1d39 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -1237,9 +1237,7 @@ static void dec_br(DisasContext *dc)
>              LOG_DIS("sleep\n");
>  
>              t_sync_flags(dc);
> -            tcg_gen_st_i32(tmp_1, cpu_env,
> -                           -offsetof(MicroBlazeCPU, env)
> -                           +offsetof(CPUState, halted));
> +            gen_helper_cpu_halted_set(cpu_env, tmp_1);
>              tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc + 4);
>              gen_helper_raise_exception(cpu_env, tmp_hlt);
>              tcg_temp_free_i32(tmp_hlt);
> -- 
> 2.17.1
> 

