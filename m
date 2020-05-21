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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7555C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9614F20759
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 17:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jR3zHEjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9614F20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jboor-0005Nj-NN
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 13:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKk-0008CH-E1
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:16 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45769)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1jboKj-0007Jt-53
 for qemu-devel@nongnu.org; Thu, 21 May 2020 12:46:14 -0400
Received: by mail-lf1-x142.google.com with SMTP id a4so4806805lfh.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Jvo/LxIXkOSLdWD9j0aBQLPNatwvdHY+fHy3y+oQ0ac=;
 b=jR3zHEjnC3beB692ekSGNKP3OhLg7f+kXHzvy1dSaNAvnbFYwM6hbI5UfoGip5UB2K
 5WDG7vKUT2nKX3WcCjYbaJ7/y+oDNHRXRdv9I5XhYZM3B1+zLBO+xXuVVgnzlP5G8jZD
 zjG3jcilHP5FFEKZdlXItn23F2XxjeysEr8I7Ij7YUvhR6EcVUiYK6koiK+n/f12WvF2
 v2VzWVWea8ZO8EOGg/hc7UQ/ilpSupmwTgyeFIAq+2SitO+doewczPdPUdqBDuD6p3Gh
 qxJgr++AU45x62vhdjEEapiULwVATd6HPAAlMWAUHD49FnoLL+8tQBsP0ROH12VZfiHM
 1qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Jvo/LxIXkOSLdWD9j0aBQLPNatwvdHY+fHy3y+oQ0ac=;
 b=fb8ImXkv/Jh8cm54WhbY9eo9s2cKrQiCtFvajFn3YIks4dSxuBrIHyWfET/aDJT+5u
 RLwahf4DGx6l87Ubr+xh8cb45FZYWW/1IXC0HXwfbeTrnGm/jBM6FM5IkE0qZl/Us/+/
 +hmRkv76di0SYLU7To7KROpZyTNEYR9uWBNMQCEY1gP3+yNvKYQI+EQyk7axZJ6TRzux
 eqtNHsbpfdZ4WmEgNqOMfdi786H01dbCUmW97Mj/0czixANX/m5fpXo//nQL/7fQ6cJy
 s5qZUTEXmoCJFl+ECnuaqltNrN6Qc8XTVeL1n9z+/jM3CwUakAg44SYcupropjFQ5pA6
 GNXQ==
X-Gm-Message-State: AOAM530elJOITwUbzb41WoQScza2edGWQMoYGDx4B2wu4uaur87hST6n
 07tGIhGuBFNQ6jW8y5PL4Fo=
X-Google-Smtp-Source: ABdhPJzje3Jv8tQaq8GrwaMWJmc+/r8zqEoLf7/ZCYkIBs0gZh/VZ+a33I5An0TCLPJWr2yH0MmMSg==
X-Received: by 2002:a19:70d:: with SMTP id 13mr5518699lfh.60.1590079571404;
 Thu, 21 May 2020 09:46:11 -0700 (PDT)
Received: from localhost (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id x10sm1827235ljd.25.2020.05.21.09.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 09:46:10 -0700 (PDT)
Date: Thu, 21 May 2020 18:45:53 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v9 47/74] cris: convert to cpu_interrupt_request
Message-ID: <20200521164553.GG5519@toto>
References: <20200521164011.638-1-robert.foley@linaro.org>
 <20200521164011.638-48-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521164011.638-48-robert.foley@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x142.google.com
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

On Thu, May 21, 2020 at 12:39:44PM -0400, Robert Foley wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/cris/cpu.c    | 2 +-
>  target/cris/helper.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index cff6b9eabf..6d7e266042 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -37,7 +37,7 @@ static void cris_cpu_set_pc(CPUState *cs, vaddr value)
>  
>  static bool cris_cpu_has_work(CPUState *cs)
>  {
> -    return cs->interrupt_request & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
> +    return cpu_interrupt_request(cs) & (CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
>  }
>  
>  static void cris_cpu_reset(DeviceState *dev)
> diff --git a/target/cris/helper.c b/target/cris/helper.c
> index b5159b8357..67946d9246 100644
> --- a/target/cris/helper.c
> +++ b/target/cris/helper.c
> @@ -131,7 +131,7 @@ void crisv10_cpu_do_interrupt(CPUState *cs)
>  
>      D_LOG("exception index=%d interrupt_req=%d\n",
>            cs->exception_index,
> -          cs->interrupt_request);
> +          cpu_interrupt_request(cs));
>  
>      if (env->dslot) {
>          /* CRISv10 never takes interrupts while in a delay-slot.  */
> @@ -193,7 +193,7 @@ void cris_cpu_do_interrupt(CPUState *cs)
>  
>      D_LOG("exception index=%d interrupt_req=%d\n",
>            cs->exception_index,
> -          cs->interrupt_request);
> +          cpu_interrupt_request(cs));
>  
>      switch (cs->exception_index) {
>      case EXCP_BREAK:
> -- 
> 2.17.1
> 

