Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C54C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:08:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FBF3206A2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QbHDfXsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FBF3206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3kJv-0004c6-DG
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 14:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kJF-0003jA-JM
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:08:09 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:39996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k3kJD-0006vX-4R
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 14:08:09 -0400
Received: by mail-pl1-x636.google.com with SMTP id u10so18700445plr.7
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dP7ycjRiFYJ7d9fHEhodUS8alWwM4fJSFXCzkLPTv6U=;
 b=QbHDfXsLFkYp7AkUojvddmdjG3xtwFBLfoGKaLfQVOlTu31MX7ltpDMdlx7lh/NpV8
 QNVJjaBBTNHViNkaD1aYsKIZuimbYaSNgNljvPNZOaAL8MPRWpQjbXyY5VNwVFjxyK5V
 N+RauBeMERkSz958Co0boKgmyhxPxVseuxZyfHPnGPx0DKvxvTzzDR5t/bLqMswvq+v2
 cXhTChde9XhXKk12u9Gwh3VIpI2Yk/ZOBLBdaKKJe0vnq4fXtzDM4mc+/+B/Mmy1hXRR
 PD6+8FVdDYZFw9c6YBe3NSNB0mvaB5/5yOBE2pKEcBUhXKicgJpqIaTdX50WsPBiOQp4
 ldeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dP7ycjRiFYJ7d9fHEhodUS8alWwM4fJSFXCzkLPTv6U=;
 b=PZP49J1dRD/hElTrbsTxkDLeZl6mR3jMibeywa3lWX47n2JDvV20ZyLXCIc65HnoaA
 Ha1ZMlpAIU9zlHqTSmguU43DHF6sVRH61rGc+/n68L50o9GqrAEtZP4zcE89b+lIBswU
 o2Pq9Kn5xBCdsnSfZw0ImMhdbfxb9SY8Jl2rQ15kcJjIvwa09R+6mxuPRe29OWW961U1
 dljqJHoH7Mrrvonz9wGnNp6bbETUX0UJiV0RpPFC9lXT3hXXKjs13Ck0g/wHHjjHXd1O
 KRrurHm9toDk3F2nuXEyiFqRd2d41LpA8OwpUgA872mLDQCYXFTsk85tdlnu7wHGpGn1
 QWkQ==
X-Gm-Message-State: AOAM530RY93aCp2Bnvg2ZpqQ5vcty3I2fg9frQkBDRsGykMUXGub5pan
 wfrTcXTEVxuNyI2OV65xs9XJdg==
X-Google-Smtp-Source: ABdhPJzJimeSft5taEX1qacoNTyfcc3gM+R7ROElUy5aA5/Fby3xHbdp3n6k1BGt7/Dq8sioGqHu9g==
X-Received: by 2002:a17:90a:fc98:: with SMTP id
 ci24mr9880225pjb.101.1596737285094; 
 Thu, 06 Aug 2020 11:08:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j4sm7942672pgk.4.2020.08.06.11.08.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2020 11:08:04 -0700 (PDT)
Subject: Re: [RFC v3 07/71] target/riscv: rvv-1.0: remove vxrm and vxsat
 fields from fcsr register
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200806104709.13235-1-frank.chang@sifive.com>
 <20200806104709.13235-8-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6fd8e17e-3a36-8a9e-c427-bfd1449c52ae@linaro.org>
Date: Thu, 6 Aug 2020 11:08:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806104709.13235-8-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:46 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> Remove VXRM and VXSAT fields from FCSR register as they are only
> presented in VCSR register.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/csr.c | 9 ---------
>  1 file changed, 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

