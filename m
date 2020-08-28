Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BFC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09F62208CA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 06:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB7S+V0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09F62208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBXyH-00086v-BH
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 02:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBXxT-0007N4-6O
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 02:33:55 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42740)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kBXxR-00011Q-Hu
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 02:33:54 -0400
Received: by mail-lj1-x244.google.com with SMTP id t6so58120ljk.9
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 23:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=aFtz4GETe8ZD6CzirFdsgsvtNGNIcou9r54pNE2f/TQ=;
 b=fB7S+V0Lei6HTucS0Txa5Umgx/2nFxeWOA0H8iae4oD+8cshW3n+QE3qKRWMLTDBOM
 BQFUZArAG9E2FSyPufKRap99GAyCnAGMiKRgjqr5KMjRKTK/VajFiXzRJpfmYDFYbKpX
 v4OiLOV9zuFrgES4e7g+2O6IiodwyGcuiGEof8gHpWprER1lL9LUcXhd8T7PPDubn6Zt
 NtMDqCE4Dy1Smofc2q18ZinAGUGpO632O+3G3CpNEy2yTz/WQKwfQsp1x86Q2dePc26Q
 vSLX1mtJpaU29Lsx3O+WIkYL7g+8lrbhBV8idHFauFymnWV9KPPGGPAd5AGBpOyP6O7b
 9z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aFtz4GETe8ZD6CzirFdsgsvtNGNIcou9r54pNE2f/TQ=;
 b=uI4HKS/3nLe+FlsXRaw08vnLaMlN7u8RvnupsUR1x7KC3TRL1iMhjijxUY5VWX2jnX
 zL5pQkNySF4Ud+uWYu5AD9OaKDrtxcX7A7IYlvGXUYfx3oflkek4na8leGGd4swiFocW
 /f1yuOvoMdOVTz93qX8ESjm4q29QRgbKtz+e6MHKgNxl+KtjsfiJJydvaSn/kTRHezzo
 WvTWRywuB8jTL6/n1aDaMoVNlh0V/A6foLn4U8qKcIX1CRL+FNwZzSak1zPDfuACxVwN
 fHIfQAKuriMCNnqhwcNJIGz9kKBZsILooGCEafjnSCqy7jCle9IA4a3GL4pES5nor+zp
 Omog==
X-Gm-Message-State: AOAM531t4DjcKKtIEWVOHTA40fNX0GdBeeGmdbAvjGe4K5O2AxpyYUMh
 oPQr0kYCYS8ovPQxhfGBvTY=
X-Google-Smtp-Source: ABdhPJzth3jMSQL6sdFnT0vkkdXKOqkRVilxTL3Xi5lokYJMkTJJ1ufn8ukGHJ/L3oM1qkN+YYKrqw==
X-Received: by 2002:a2e:a489:: with SMTP id h9mr170222lji.121.1598596431517;
 Thu, 27 Aug 2020 23:33:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 187sm70642lff.35.2020.08.27.23.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2020 23:33:50 -0700 (PDT)
Date: Fri, 28 Aug 2020 08:33:50 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 66/77] target/microblaze: Use tcg_gen_lookup_and_goto_ptr
Message-ID: <20200828063350.GR2954729@toto>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
 <20200825205950.730499-67-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825205950.730499-67-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.899, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 25, 2020 at 01:59:39PM -0700, Richard Henderson wrote:
> When goto_tb cannot be used due to branch page crossing,
> or due to indirect jumping, tcg_gen_lookup_and_goto_ptr
> can be used instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Hi Richard,

This patch is for some reason causing some of our tests to fail.
The PMU Firmware on the ZynqMP gets stuck.
Looking at logs nothing obvious shows up, it just gets stuck.
Bisected it to this patch, any ideas?

Cheers,
Edgar

> ---
>  target/microblaze/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 6f9b20d391..5bd771671b 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -152,7 +152,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
>          tcg_gen_exit_tb(dc->base.tb, n);
>      } else {
>          tcg_gen_movi_i32(cpu_pc, dest);
> -        tcg_gen_exit_tb(NULL, 0);
> +        tcg_gen_lookup_and_goto_ptr();
>      }
>      dc->base.is_jmp = DISAS_NORETURN;
>  }
> @@ -1811,7 +1811,7 @@ static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
>          if (unlikely(cs->singlestep_enabled)) {
>              gen_raise_exception(dc, EXCP_DEBUG);
>          } else {
> -            tcg_gen_exit_tb(NULL, 0);
> +            tcg_gen_lookup_and_goto_ptr();
>          }
>          return;
>  
> -- 
> 2.25.1
> 

