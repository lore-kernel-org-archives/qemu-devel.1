Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FDCC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559442071A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kdr6jbnC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559442071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2ny-0002Ag-C0
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:21:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2nC-0001Lr-Jx
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:20:36 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2nA-0004xF-H0
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 15:20:34 -0500
Received: by mail-pg1-x544.google.com with SMTP id o3so14554222pgr.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ke3lctFHdN1c5swx2n6i37eMkPk0/YRz6LTlj2i+b78=;
 b=Kdr6jbnCHh5K6ip4ntUwUQ7yEzjp1sY8qKwqyr+1OGoBXQedqoDaIKoTk0CXMyKtDb
 pW26pnjPruv3YmgTaeWjLDVzlNijmtI5VzoOpXaqgDHA/6G4eWcgxarsb18s1KEl7ANL
 xr4kr7tWM2TgSctdVGlI47VBRK8OPdrnjTB19k9oCV+sEVz2WFKN33E7QpTlsU+MFpmQ
 OjdJf9o5Dr+8nVwB/paKbNYffgn+8bkBc1hl0YORnvzbRyAnXoiBqrg4L4I3muRvBf60
 SaMmpFOYMQ7RL8IC+FwgMEy+aLVM16/qafBXGVXh2wPlrjZAd/LfVF8qcgToPDWU3/oA
 Kfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ke3lctFHdN1c5swx2n6i37eMkPk0/YRz6LTlj2i+b78=;
 b=R9rfF0f88WSxzpWLFBnUGKZGYpWjuhr7hBjl6CJjM+/7r7WJ9rt1/c2MUWulL5iTe5
 o56xWxSzkfjOhIUajeFs3L4xKhaFy+NqEDWIQLdf9g4BiFQcHykVX0EXwvaKnbnJlqQQ
 Z3uce7zNzZaWhoFrZy7OAq55PemSCPo532RsQOhoRweVnwdlhUmf7mFxP0GH36yPtTJC
 KiAaTPe2PkdW57n1Y/9CNe4XafN0seg/hgSt1LUuMH8PTsHbK9SkW7ct+nVecc45c+Ub
 AYs5gO9oeu+2PJaAigPG5KGaz2Em4rthYvRa+K57FKvNMNnTIwyhy8jpzm/nXPBGTL3a
 ijvQ==
X-Gm-Message-State: AOAM530acbeUBlbTUPs+9l6Tj3P5OG6VTAMtRBU5anK4A8Mp1CMVjLVm
 ChGxDxDmBz/Yi4oU7P6LRTHNJg==
X-Google-Smtp-Source: ABdhPJzI1JjEn95qgLD15C+eOrLEPMVWjuiZRom7/vRABcCNJQNua7tsx7TbRm+58C3r15QOPuxGFg==
X-Received: by 2002:a63:5154:: with SMTP id r20mr18862228pgl.340.1604434830117; 
 Tue, 03 Nov 2020 12:20:30 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id h184sm17735745pfe.161.2020.11.03.12.20.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 12:20:29 -0800 (PST)
Subject: Re: [PATCH v3 2/7] target/riscv: Add a virtualised MMU Mode
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1604432950.git.alistair.francis@wdc.com>
 <5f25069661040bb96f945358bd7fa047f5b462ce.1604432950.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29320e1d-6abf-a6bb-fc6e-43a3b17fca36@linaro.org>
Date: Tue, 3 Nov 2020 12:20:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5f25069661040bb96f945358bd7fa047f5b462ce.1604432950.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: alistair23@gmail.com, bmeng.cn@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 11:50 AM, Alistair Francis wrote:
> @@ -30,6 +30,10 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>  #ifdef CONFIG_USER_ONLY
>      return 0;
>  #else
> +    if (riscv_cpu_virt_enabled(env)) {
> +        return env->priv | TB_FLAGS_PRIV_HYP_ACCESS_MASK;
> +    }

Still setting this bit here, incorrectly.


r~

