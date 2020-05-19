Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4458DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3D12075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBmZC8WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3D12075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb49d-0005Rq-8K
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3lA-0006kZ-5a
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:02:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb3l9-0004dG-83
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:02:23 -0400
Received: by mail-pl1-x641.google.com with SMTP id q16so5746080plr.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tqNPJ2qlbgindtQDqmEZgtsuos9sPlbkNEiIAspxVTs=;
 b=aBmZC8WOl7MQPVNZmpvpHxAHZWxL6pODQeAzSFx0gcnbBOVnUF0JEYJF9xlnjLviyS
 uUPH8uLh6n8JFF5Q12EKAG5pV/uqiZztUEtlrIAnysVWq339C4Ilf0yj6BOSD4yuweSr
 fSDig6P67GGdh6krl/DgUKkJCSF0QU2VgrqmiTulSF07hPojFWbIcAR1IJlVX7jFV9NO
 SCWLI9925izfLDwAilcTp7vAYpEjfjbYvYgX3Z0uvV7S0OG/MqGKHwwEjuZC3G28ube4
 GmC5BzatlsxoZkY30rELB3+qjt4bbl54vB4WNtrfCDoFRqFt/nJ8JN6FLSFevfjioj23
 KxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tqNPJ2qlbgindtQDqmEZgtsuos9sPlbkNEiIAspxVTs=;
 b=hJKm97Vmc8Qw3/9VPzm6czvlMzd6TTYaW+Ig/fZndbLgwFg6GnOKMZiDDKKLaugzE5
 BGEvh5enOXFISGjQT+bmHp0DQ3105SptAAXpPObN9tIBZ5HCfKq4SWVVMHO4v9Z3VV4f
 FWbatx2R+Ez3SCxBlJ5CjhDigbO7sJfWyRGXrjKZWSIZZR2aRlofW7PsqJG1IgrqB3yv
 3L1p8p4lCL58iTQ3RubXUPCYTkJYEh5XZiWWlhYEHVu5fXfNImx9gBZq4LqlQDNbN6zD
 CAdijxGgfHfKjNuigVL9cvdDWXrDSVPrDNW4YmImeCJIHCHKLsGuUhik6MYAsSTfmQuc
 srqg==
X-Gm-Message-State: AOAM530QQ+O8Huru7Xk1pDm5RZV5B0K/nYrNhKUjUtFPkj1D1eEZLuzc
 K0WDnmQEU/NqajkCN+rltH6GAg==
X-Google-Smtp-Source: ABdhPJwwOhOJdHUcvvYiIY+FeC8FnWdXS20wy20pem3J9USp+a3FF904eqBkbCNrWKNJ/Gor3bv3PQ==
X-Received: by 2002:a17:90a:7ace:: with SMTP id
 b14mr4973656pjl.116.1589900541523; 
 Tue, 19 May 2020 08:02:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 127sm11902367pfw.72.2020.05.19.08.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:02:20 -0700 (PDT)
Subject: Re: [PATCH] linux-user/arm/signal.c: Drop TARGET_CONFIG_CPU_32
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200518143014.20689-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <21f42bb8-074e-3e63-989d-fa0c94c55e2a@linaro.org>
Date: Tue, 19 May 2020 08:02:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518143014.20689-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 7:30 AM, Peter Maydell wrote:
> The Arm signal-handling code has some parts ifdeffed with a
> TARGET_CONFIG_CPU_32, which is always defined. This is a leftover
> from when this code's structure was based on the Linux kernel
> signal handling code, where it was intended to support 26-bit
> Arm CPUs. The kernel dropped its CONFIG_CPU_32 in kernel commit
> 4da8b8208eded0ba21e3 in 2009.
> 
> QEMU has never had 26-bit CPU support and is unlikely to ever
> add it; we certainly aren't going to support 26-bit Linux
> binaries via linux-user mode. The ifdef is just unhelpful
> noise, so remove it entirely.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Based-on: <20200518142801.20503-1-peter.maydell@linaro.org>
> ("[PATCH v2] target/arm: Allow user-mode code to write CPSR.E via MSR")
> to avoid a textual conflict.
> 
>  linux-user/arm/signal.c | 6 ------
>  1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

