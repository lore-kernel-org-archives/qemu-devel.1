Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C9AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B824B20771
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 14:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDPEwQKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B824B20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmHft-0005tQ-0I
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHf7-0004xq-CQ
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:06:33 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmHf5-0003PY-Qx
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 10:06:33 -0400
Received: by mail-ot1-x342.google.com with SMTP id g7so7318427oti.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 07:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2SzBrzToShRpvHBIvFFlJnjD3x916pBIuMBxO4NPHu8=;
 b=xDPEwQKoYnuv1LB1z/iyvmCp7zgIlY+ETb+vUjzNfe9TDQmr9Y8cmLUqKORTi66CWo
 D5QakHKoqiA5PHmAhdKfiBpjrruMh8EVFLvX3verS53vqXVX6tA39ZEHW5G/8ph1HQqE
 v8byCPSd24KyVnu3T2fMzffmEZvVITn2aSdEnD7yQq0Su99I/QyBP3P0tD4gq/z/59+M
 Gh09DcUMzs8NLwVIndee9ozGSVyzynwjR8xPKkj+trCKGJwWLuTILHjdHr95VsPbXIVE
 D2Jx7G1NIjXBBlIpvZPEMnB/PeDaIqD3p+Wj6L/di1hYZE8SJ+mZ1yD56TpfMiwlSs2o
 lXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2SzBrzToShRpvHBIvFFlJnjD3x916pBIuMBxO4NPHu8=;
 b=SH0RGVXDh91/AGWZ52rTpqxtKfGKJIL8SaPtNs6vHrBEuHwr8LBd7/STo62ibDHkMK
 HjH/jMyMRJ6c8Mx/Eaul8XxhmHEB4G0f5GMFMBJO+i1dJvEbkP4UMB0H/K6R+HjSuuSy
 a8Z8T9j0b76ipckMEyNw8SBJp26wW8+SRTqGpf5e5t/LpQHlH6x7+/X2TpaTZZm4H8uM
 ZGmzSC7n4SdyBDNZEuTlVJxxUHQYy4ZZiId49mGH0ve7XNRyqUtsGGoxphdPMb86JgJR
 BVCw2r+cuY4sI/iz2Z9gBuV1dEPy/ZrVD9LwzpA36NfuPvnUB/5u1bibCsOE1qqGibTE
 EwHw==
X-Gm-Message-State: AOAM531mw/bDAmtxvObBSh9XN4F4OZPMBxqAVe3CyxMgVY1tvEFeswm3
 1jG+GrfIgQQw8ugRldRVO7XiK991vAQDv4S0M/DHHg==
X-Google-Smtp-Source: ABdhPJyBvcrxNc08zqeW1XVV+zUP47sU3KmVFMAgIW5etV1EXQa/rKJq0MwFa9Qlbn/SuZUEEA1/hpFKBHaeptBUr+g=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr3101855oto.91.1592575590525; 
 Fri, 19 Jun 2020 07:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-32-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-32-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 15:06:19 +0100
Message-ID: <CAFEAcA8870uLGsGW+A5_QC4PPFnwMfywyvF5KV4yCkqbT6==Qw@mail.gmail.com>
Subject: Re: [PATCH v7 31/42] target/arm: Add mte helpers for sve scalar + int
 loads
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Because the elements are sequential, we can eliminate many tests all
> at once when the tag hits TCMA, or if the page(s) are not Tagged.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

> +static inline QEMU_ALWAYS_INLINE
> +void sve_cont_ldst_mte_check_int(SVEContLdSt *info, CPUARMState *env,
> +                                 uint64_t *vg, target_ulong addr, int esize,
> +                                 int msize, uint32_t mtedesc, uintptr_t ra,
> +                                 mte_check_fn *check)
> +{
> +    intptr_t mem_off, reg_off, reg_last;
> +
> +    /* Process the page only if MemAttr == Tagged. */
> +    if (info->page[0].attrs.target_tlb_bit1) {

It's a bit odd to use this bit here when you don't define what
it is until patch 40. (Similarly for the next few patches.)

thanks
-- PMM

