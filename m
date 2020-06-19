Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DD1C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC98222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 22:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vx9Rkoyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC98222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmPdT-00073h-Um
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 18:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPcs-0006L9-Qz
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:36:46 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:53427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmPcq-0000hp-Uh
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 18:36:46 -0400
Received: by mail-pj1-x1043.google.com with SMTP id i12so4676446pju.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=hLVqqCghvfYDRZyz8EhKaK9PowVzIvkh+wHhcQzhoN4=;
 b=Vx9RkoyjkNsgy8/IldfA047BkVum74atk5KM6+rh69Ot+bbG/sKsNbGC318hcR2IVu
 VyApcSksBWyO3WkDyyehDpsOXL8FtrHXYTeNUZjzUaKSiNROMv5pDMBDI9QRJqBlkYDU
 y+MgUfpmDF2VxU08j+QliJ4dnFpoWWtnJul4HKBBh/3O3jieaNyvGFFt1nf9UaMVpvf7
 AzbMZk3HQjojbAthj41ZfwX6RzwuH7p8iwiWkJqrIsAD8PtvOq6pl/LQZ/Z/UW+yZFLF
 A+exLw544TWq2Xdj443w1j9FbpfLp4MKZY+YuAhocCPKMh2cQVBqX3TNhwr1B932x5T3
 1KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hLVqqCghvfYDRZyz8EhKaK9PowVzIvkh+wHhcQzhoN4=;
 b=mueJ/2adi0gn4wvhtFKZFpQoCtnrhoxdLhDWO4DPyIhA4T0cXIY+jFe2jkyabVDyAj
 IoaBfqy5QMV4JoQzdZQhgZMZbdZ8flZ86wPee0aAlLbizsKUf/KHWY/n/+EE0/KsMVrh
 jmyRtAJO+En2ImuSNByGcSc0mrYxa4I1rzfH/2K32qeCl2GI7tzYYFpMPO326567g2wE
 7aU4QEtqigvkb25Sf4OYFdc8OqJ8NpqYdNPlybwXclo9vsi32hGMOvPv/Yi+T5/sdKpJ
 i0A8c9hTbHdjFEuQwqirYkb7WCAIkO438bMrgwN9T/zlwpBjCiCoYa2C9SWMCVfgX05L
 avxA==
X-Gm-Message-State: AOAM532iijI84fc3X0/45hR1k9l4w63sb9hM7pTYpb3a299NOoe3M2bT
 6SQ1XTe7yrY+3ELt2kLs567cUrfrikI=
X-Google-Smtp-Source: ABdhPJxrni23f3NIBJBOn/TYlzu3RO2tp0wQr8TOLFlgSnMGDKz6WZQg7M6b/5gSYD5iM7tBbl3Cig==
X-Received: by 2002:a17:90a:d0c1:: with SMTP id
 y1mr5542811pjw.164.1592606203022; 
 Fri, 19 Jun 2020 15:36:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x20sm5953687pjr.44.2020.06.19.15.36.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 15:36:42 -0700 (PDT)
Subject: Re: [PATCH 01/21] target/arm: Convert Neon 2-reg-misc VREV64 to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <893f9cc5-b20d-04c6-a720-fdf89b72e851@linaro.org>
Date: Fri, 19 Jun 2020 15:36:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
> Convert the Neon VREV64 insn from the 2-reg-misc grouping to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 12 ++++++++
>  target/arm/translate-neon.inc.c | 50 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 24 ++--------------
>  3 files changed, 64 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

