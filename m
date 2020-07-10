Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F3C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:46:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EC32076A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 17:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTN+kOuQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EC32076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtx6G-0002G6-IS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 13:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtx5c-0001hE-D9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:45:36 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:38901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtx5a-0000YD-O3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 13:45:36 -0400
Received: by mail-pj1-x102b.google.com with SMTP id k5so2921926pjg.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GSamje9+j3xshv2eABaYdnW8SBQFYC8RNnPL2NHuyRo=;
 b=KTN+kOuQua+whkKtSfhl3jXmEGHdrvhzq9CVf6Z7tb8wflK2GU/XGhsz1+8TeCtZuf
 O/WtKHbPACZlzX6LOOjgDDDAcBiJ4fi7/9EdwRvLBx8mcC9930zHCY1OZrSOWrcwrG49
 boJCNuSsSu5ylRf7oWl/Iy5dqc3uleVxwNg3ZkM1Qje0Vqk8AOqNDb71JgHpeHDYmXr2
 lRtCabK2etRqLP6OTxz53B+f6WCONyeZsVhZi6uw91Fui4DG8d2lrvcTDfb1S7L8PkLz
 v9UOi17jHu09Db8CwAy3OZpYP36O0t6TgHv0YWRC7v5dJExRORjFkoy07Z+iaMfe17Wc
 kH7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GSamje9+j3xshv2eABaYdnW8SBQFYC8RNnPL2NHuyRo=;
 b=gkmTnTTQ/4eYvGTQHb85Eyft00TkFqMuTWQ50PpLvDcfgyLo6m+mP7hJkSFS48Oj9x
 Vw2Cf7yfbfdoE+EDkQ6rrRCP1jMKurKaHEGXa5Ns5P0rlOPZQlElugHfhjIFAQq+QZh5
 ZoTDdBnyJWMe/IB9oEtbSt32hCwHtaLAubhAM0OOhUbm3sjJkxq4p+Lxr8gX8WYLcQ/Y
 3/XHFxB+ykcMQDVyeOIqT6I/P74XbjXiX9O6YgIdf88V5xwi0z2/UPB3jr6pYiqp+9U0
 Bhw7Z5RGL6dCoaSvv6z55R1l/2MqixZqFwXjMmaXSK2bKD50EZ1N0vmhpWHxO9HYnDgV
 4NRg==
X-Gm-Message-State: AOAM5324W+vvPx0m/emFR8POW9OH4ro+3lNw/RaF6zcalAButC4E2yFg
 IsrLi/1CxrIf3dZHI5Wbz//o3g==
X-Google-Smtp-Source: ABdhPJzm9jWNopkgbhWDop6XVMtsjln6Dg5sUYlp7rMoaQfoZIliJ7EwDUKu8az6I2pp8MIE05d7Gw==
X-Received: by 2002:a17:90b:46d0:: with SMTP id
 jx16mr6503111pjb.222.1594403132790; 
 Fri, 10 Jul 2020 10:45:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o26sm6706364pfp.219.2020.07.10.10.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 10:45:32 -0700 (PDT)
Subject: Re: [RFC 11/65] target/riscv: rvv-0.9: add fractional LMUL, VTA and
 VMA
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-12-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3f5582c2-928e-39b2-3566-e4f3ee9f6ade@linaro.org>
Date: Fri, 10 Jul 2020 10:45:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710104920.13550-12-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 3:48 AM, frank.chang@sifive.com wrote:
> -static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
> +static void vext_clear(void *tail, uint32_t vta, uint32_t cnt, uint32_t tot)
>  {
> +    /* tail element undisturbed */
> +    if (vta == 0) {
> +        return;
> +    }
> +
>      memset(tail, 0, tot - cnt);
>  }

First, this patch is doing too much.  LMUL should definitely be split from
VTA/VMA; they are not functionally related.

Second, it would be in-spec to simply do nothing for VTA/VMA, except validate
their setting within VTYPE.

Third, the spec talks about setting "agnostic" values to 1s, not 0s as you are
doing here.  So there's definitely something wrong.


r~

