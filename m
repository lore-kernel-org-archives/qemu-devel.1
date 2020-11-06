Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BA2C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C415920691
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvNuBfqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C415920691
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayuu-0007TM-Ks
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kaytq-0006tL-JA; Fri, 06 Nov 2020 05:23:18 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45857)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kayto-0007ET-Ss; Fri, 06 Nov 2020 05:23:18 -0500
Received: by mail-lj1-x243.google.com with SMTP id t13so796312ljk.12;
 Fri, 06 Nov 2020 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TJ6UbepRXIlGmimkfzgxqHOHuQZTJcVoiiiGH01DJ5o=;
 b=BvNuBfqjf2tFz99rlNhgnCPpMfUjZ33Km8n0ajL3ALBwX4KA4AnMbLx5latmc51ZE6
 ew+hslp9yTwGnr7b3hPkr6iizd3ur4DbUre1XckERVIoNXdxWhUydPzsdDhplPuc2unT
 lYBRz2h1AqFu7nMNGvnejeJR6qP31GDOVi2/RyhPK9UHUkeKsSZS8X6uOGlB+K7lpTsx
 +AbhmndRl2DY6oxqqobsTRYkA6nh5UxPo2fKVhLM4LMcAQHdgb4DLyMaKi5MuTWf3tmO
 11oG8oE1xoWex3eD21gF3fI8g7UTl1nfIIMLh2tc5kNN+abwRVPjbEh+XWyF9PFu4f+9
 9mvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TJ6UbepRXIlGmimkfzgxqHOHuQZTJcVoiiiGH01DJ5o=;
 b=DhrCnKzmgB7ExubHB6n/zuPZgUgFnow/F0CP2pFiKTHmJsaK/NWir4cU+emCQDDxTk
 1AR2FMTFF8BfKCrmYzma+luIywOj0mdCjNQI7HYUD9bxVhKxcEL8E3MMFL433XoDMCn7
 KuTaE/lRiBQe+P8RGVd8LSfcm7TryPutGB9kmeINNuWM7AKDUGy8aVusVHegX5RGPGUF
 zgnvKKF5bnPjcUrWutcUm6oi3IyMIlXO8xlwqpeFinvLNBzbGAf3iPcQc5+N+y7s93D6
 +5E78gTu8fK/aI8Vr2RS4vygnEo8kSOXl/xpPBa09gsEUNHrtUITkKg4J1qIU7vpbWuD
 w00w==
X-Gm-Message-State: AOAM533H67VQmfO647ea20gW8fUo9CPbyWXgzXrl+VToNnQ73wFRNpI7
 uTemtnKEue/KDE8GdrpeSh4=
X-Google-Smtp-Source: ABdhPJy0oQ/KL8U0vpXVoVqvhDknvyHwbluFcXmgG9bqTRKuZT9zFO8CYzHQqw2jP3YAU4+bqOmUMg==
X-Received: by 2002:a05:651c:484:: with SMTP id
 s4mr512954ljc.272.1604658193608; 
 Fri, 06 Nov 2020 02:23:13 -0800 (PST)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id r22sm96747ljd.111.2020.11.06.02.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 02:23:12 -0800 (PST)
Date: Fri, 6 Nov 2020 11:23:12 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: AlexChen <alex.chen@huawei.com>
Subject: Re: [PATCH] target/microblaze: Fix possible array out of bounds in
 mmu_write()
Message-ID: <20201106102312.GI2954729@toto>
References: <5FA10ABA.1080109@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5FA10ABA.1080109@huawei.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 03, 2020 at 03:46:02PM +0800, AlexChen wrote:
> The size of env->mmu.regs is 3, but the range of 'rn' is [0, 5].
> To avoid data access out of bounds, only if 'rn' is less than 3, we
> can print env->mmu.regs[rn]. In other cases, we can print
> env->mmu.regs[MMU_R_TLBX].
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/microblaze/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 1dbbb271c4..917ad6d69e 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -234,7 +234,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>      unsigned int i;
> 
>      qemu_log_mask(CPU_LOG_MMU,
> -                  "%s rn=%d=%x old=%x\n", __func__, rn, v, env->mmu.regs[rn]);
> +                  "%s rn=%d=%x old=%x\n", __func__, rn, v,
> +                  rn < 3 ? env->mmu.regs[rn] : env->mmu.regs[MMU_R_TLBX]);
> 
>      if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
>          qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
> -- 
> 2.19.1

