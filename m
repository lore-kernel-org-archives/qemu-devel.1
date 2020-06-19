Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D235BC433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E312242E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbI103WT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E312242E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQfX-0008AO-VM
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQee-000700-9L
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:42:40 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41023)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQeb-00022r-Kc
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:42:39 -0400
Received: by mail-pg1-x542.google.com with SMTP id b5so5171672pgm.8
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=XOI2kwt29wClvWAuk3lMsH7YdUKqoH+8D28hALbRyJ8=;
 b=tbI103WTz4wy2HBK5Oh4U8uWcc38C5YsX2XPE37rxZH2M0SXOjEMrqJ89M8O+Ef5rT
 WRFiWCqszMCUG2GzbC0AFHoXZoy9TDXYDUBQMba9t9Y95mEs/1Mv+tVGrouYn2b1vBTV
 MVJCeztokZZZrd8zIjPXC3eVIo4WpCn91zwdIZWzfxSKRKK3//3bwCS42YlkR6C8asEq
 N+vBGJ9fjdLDllSoATZTDnRPvLwTRp3vWmZGnnqfgHIKWu8ynqfGb0364piiIgUDxW5v
 BDMMPrSPpO6Vz4HFOmtqCh0SAPUydOSivQ0bmmvEFQufLvD6KpKpcAYqHXEo6MMQvlQy
 i68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XOI2kwt29wClvWAuk3lMsH7YdUKqoH+8D28hALbRyJ8=;
 b=BJfrDjhdLYo//BbFj34ZHvTBTV5lF03NgE2kSA767dGlWWdpMHLZ6CajTB5e9NQYaQ
 383zK58ZSZXbjJ/tNIM5vtpSwOyRvsvQSabdpM9sqK/34og++m4ZbG22zhEisVmTrQ1H
 UMlfpDA0cPpCp8/fmbRpDPUmwEA5llNfv6/CwJi8jsxYxyAj1qDSwb5/sKKaz4PWbOFQ
 0xfuBGUrURl5rayKP+BjaT7bTsL5s+cOduqAyp7XUnxBRQ7hyNqzMpsNVgG6y78cNgwB
 nwVuBXA6/YuW8aZRvy/w/T+Lbe/jde6a6ezGy7zAvqXX5PzCZzwQIHuRPMfzM/DCX8nm
 bmZw==
X-Gm-Message-State: AOAM530/LwfeF09Wp4HljSoolbf77t2+AHbska5K9k3RP+76SS4iHIiv
 JMfzb6Tr8N8P4jG6w9KyXJwU6c3ADKI=
X-Google-Smtp-Source: ABdhPJzbpA+Y5w+HUXEHRp7jDQcfJLpOFNaj9KTeHch3azURLI6fjQfnkTQkclZpgXzLlHnjSP44MQ==
X-Received: by 2002:aa7:82c8:: with SMTP id f8mr10778001pfn.165.1592610156076; 
 Fri, 19 Jun 2020 16:42:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p11sm7008657pfq.10.2020.06.19.16.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:42:35 -0700 (PDT)
Subject: Re: [PATCH 14/21] target/arm: Convert Neon VQABS, VQNEG to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50a94495-17cc-f56a-351f-4c0a9e58be42@linaro.org>
Date: Fri, 19 Jun 2020 16:42:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 10:08 AM, Peter Maydell wrote:
> Convert the Neon VQABS and VQNEG insns to decodetree.
> Since these are the only ones which need cpu_env passing to
> the helper, we wrap the helper rather than creating a whole
> new do_2misc_env() function.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  3 +++
>  target/arm/translate-neon.inc.c | 35 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 30 ++--------------------------
>  3 files changed, 40 insertions(+), 28 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


