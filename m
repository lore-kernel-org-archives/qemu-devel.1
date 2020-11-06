Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847FBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DA020719
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5QmVlU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DA020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb2YN-0004ml-Kj
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 09:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb2XW-0003u5-Aq; Fri, 06 Nov 2020 09:16:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kb2XU-0000lo-LZ; Fri, 06 Nov 2020 09:16:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id p8so683269wrx.5;
 Fri, 06 Nov 2020 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=khhpMcg80bqP8+yl3iNtHkJH6P2VXNAKBUeksn67P6E=;
 b=l5QmVlU+STluUoGUBkMZExxyqhcliOHMZ4T/wcl6BCR8eRQDO1u1AR6VxRWMN+pEoQ
 s+neZ8YrkKNM8slsxgG+ElOXlFCVPsC34+2rLKbmqyHThFx1/8W5txWk1Of1+aacaoxS
 HyL3DTWr1G88M9Tn/VExuhuzmyMyht0LJU9l99+rXPjFQ8oExBrz1ZKoFLB2SYOTBbz0
 hMh/THxbU1OADSfrK9MEHEnL87xP6SJ6/oaspnt7IzTtaQFxWFi75Dsi/Wvf+qWz3w4H
 oFwx+XEOO7J3LMfT0sD1Za9ecGdgqwPp/0H1pC/uercc8YfIp7ikxGOYbtzhfZsPouEj
 RfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=khhpMcg80bqP8+yl3iNtHkJH6P2VXNAKBUeksn67P6E=;
 b=IKckDqxF0SSLAU4/6SfYwXxA5TkXnbnWCJXmjeLrc9KQvR5BViQ4iDvyrRYpAMumpo
 ZMycOuFXLk5xUD4L0jncfqCcRW+4O6cx88ZtIpWIrRDj7ndglBZOK0wsUjflfunYzRF3
 cS9OvfNJJM2oRYMluWGQ9zhT8ECnSdeBYiuLEj13EIbDdUGIljtDG1FkuG8ZJxbXfK3a
 QJFg0I4VyUZURpgc0KiM2SJ3vZ/lsm0CaCjCiaGY0VPattbfuiU6CjiAaz7bodSZXEzN
 3Jj4YbS442Hb/eVoemi9g30L+y3lqc+rWAwdeUeveCp9bnV6zQAlDCIxGxjVyxrWQxLb
 XFHA==
X-Gm-Message-State: AOAM533u9go2iKbTDg8e9sSIdOofhUxr9bCmql9Ixr6QQco9yyb6PBH1
 0qVygOpYj3eE7p4ilFzdFFg=
X-Google-Smtp-Source: ABdhPJwhctWZZ9iv0PCRBH1BFhTQVU+DMREKhjDV6igp/vF80+X0iHyV3qz0UeZ3qGCpdSbJ4ijfVQ==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr1715642wrm.380.1604672186476; 
 Fri, 06 Nov 2020 06:16:26 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id i6sm2512057wma.42.2020.11.06.06.16.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 06:16:25 -0800 (PST)
Subject: Re: [PATCH] target/microblaze: Fix possible array out of bounds in
 mmu_write()
To: AlexChen <alex.chen@huawei.com>, edgar.iglesias@gmail.com
References: <5FA10ABA.1080109@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <72d0a4aa-f875-80c0-eae3-6af843c217c2@amsat.org>
Date: Fri, 6 Nov 2020 15:16:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5FA10ABA.1080109@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 8:46 AM, AlexChen wrote:
> The size of env->mmu.regs is 3, but the range of 'rn' is [0, 5].
> To avoid data access out of bounds, only if 'rn' is less than 3, we
> can print env->mmu.regs[rn]. In other cases, we can print
> env->mmu.regs[MMU_R_TLBX].
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
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

Nack. If rn >= ARRAY_SIZE(env->mmu.regs), then don't displays it.
Else it is confuse to see a value unrelated to the MMU index used...

> 
>      if (cpu->cfg.mmu < 2 || !cpu->cfg.mmu_tlb_access) {
>          qemu_log_mask(LOG_GUEST_ERROR, "MMU access on MMU-less system\n");
> 


