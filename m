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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBD0C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:28:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE862083E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF7s+q6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE862083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbozY-0005S2-8Y
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50472)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKv-00009K-Np
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:38122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKu-0007Lw-Py
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id m18so9097782ljo.5
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=nsk3zfmNeJFaP9bVvAvlmccGh1DkjRNJNp+MaeM9Uzs=;
 b=dF7s+q6tmFlM/8+WoVZRP+VwbaIaruJJeCLUL6RXCnSLUAz1KKQYN4Z1sgXSJhpC+B
 iUWMNXq7fRMRW+ovR0kAd88WF0giJDT8jaDJG+zS3oNkHshsbGFxNbaiXuZ6MAqbXqgC
 GASokyMveHI42ysiCjLMxl87b+hlqRcTZ7AnwjhO5HFSCbd51Z4fOqob8bJpGLkpW5e1
 KHeA0i3uuoyWt2o3f5Kmt4F6cOqRqAeBpwEDttJ6CWO+SdawxBciw5pRsKaueh6Cf6iQ
 nDtY7EovI9+XXPy82721t44kUbQLw+5Qb17ZjfGNdXop7hJSlIlGp2qnsBkAsWp7yrF6
 Lf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=nsk3zfmNeJFaP9bVvAvlmccGh1DkjRNJNp+MaeM9Uzs=;
 b=maWWS10HkW8lYZw/uN8cKCDaGPDVvbiAJRVEu3G5epAC8C7Oa6cuwiwBgKQuyZs3ac
 o/d0IZns6wjOwK89MyC6uqUXtIi/e4sE2FHWiDqN3AlQLAttAQeMEjA/G68MJCuIr8mi
 wwMZbAjaRJ+C7AIztASdKM0evAtmZxlplPEB2u4zAfLkglVfIMo26wd6sBzlx0pG4adh
 59uGUIzRDQXpxkngwdwBxBZMcNuS8ltQcocw2rAs2OWwncm4nocJI2b5HQN9meMz0Uex
 pnUzbSizO6D8TSOrtI6FplyLchXUI78L8kV06fhsl/MS3MFAPfLNem98oXOrJArwwLZF
 mlyw==
X-Gm-Message-State: AOAM5339sKDlR74G7ThcHdArdTHAhjmbY0e1YggGmwUAD69yrpY8Stal
 64W2IX15UgYfZRlkzxJZ6/U=
X-Google-Smtp-Source: ABdhPJwRW+9cnuzxjgyjMP8Afh3XELZPYLhy1HBh/hz4IZih64C2hCzrIWcE+KVclFQdKR1z4b40xA==
X-Received: by 2002:a2e:9641:: with SMTP id z1mr5548123ljh.201.1590079583170; 
 Thu, 21 May 2020 09:46:23 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id d22sm1645958lfc.27.2020.05.21.09.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:46:22 -0700 (PDT)
Date: Thu, 21 May 2020 18:46:05 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v9 59/74] microblaze: convert to cpu_interrupt_request
Message-ID: <20200521164605.GH5519@toto>
References: <20200521164011.638-1-robert.foley@linaro.org>
 <20200521164011.638-60-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521164011.638-60-robert.foley@linaro.org>
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

On Thu, May 21, 2020 at 12:39:56PM -0400, Robert Foley wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/microblaze/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 51e5c85b10..ce70f7d281 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -84,7 +84,7 @@ static void mb_cpu_set_pc(CPUState *cs, vaddr value)
>  
>  static bool mb_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
>  }
>  
>  #ifndef CONFIG_USER_ONLY
> -- 
> 2.17.1
> 

