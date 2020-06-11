Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C51C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931E22053B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaELaWbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931E22053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQKP-0000BO-Jp
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQJA-00087U-Kr
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:44:04 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39603)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQJ8-0002ma-75
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:44:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id w20so2760626pga.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=7RGETQFFqiRExSXHfIvoBrn16zXr+ZignNPkElAQ+T0=;
 b=QaELaWbAH8pkZ+NRA6u9PBZjcJQRPYPCIqU7jShoGqr14Izl2joi228tvjEBulsdIJ
 5hQv+mp4Jmrvh7icJa194EusRUAnHknCmb87KU6h9cwPwqwlGyCs0ZTxCo0V7um9g8ZA
 u5sravetK4/XYibecCXB+82BGA2fnN3q9svgsOnTAVf0Saki5p7cFwTrDzeJHF7FLVUi
 EUyND1tg5CdJoTNCDMkztvgCvkCJVj0/xF6Ksu15lQWUyc4j6A/uAAGUxTvz/kk9mLDD
 Zk5tczEvamVZuSq+5+I1+6O9qqRELK+jVf2Ez00V9VyCx58RJ1OIgU3PGpeCsHQ0xbua
 /X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7RGETQFFqiRExSXHfIvoBrn16zXr+ZignNPkElAQ+T0=;
 b=FEBCiH/W579KvJg21w9EilZ4vvbAF/tz8OPYJF4qbonpQbu5Yg4dLajWjVVbZrWJut
 nnudYjLNJpZtad94jITTbh0Lb58ogz3pk/OI0B3DokqUz0Fc02FPrNCXyH+DLMWbWMR8
 MmCasuMkaVlEovfofDWBEty3pjyd5n9+p00ETNa+p36lq2TGR9MIhS3WJBlw544e4lvX
 9Q9TifqXRvEkMvFnBXzGW5ALZQB4NWNqzNyhtIkZD016QdPhG6f+4WjCz5/Z/HUk3Nb4
 5LpyE2hVmsoboLgDvnEz82CAPIXHd4H4kRgllpdk0d+mCJC1+0FNGVGnqgSwEgoleS/+
 htsA==
X-Gm-Message-State: AOAM531BEytbX2vpYz1lHeC6e+HU3Uo6UyVmTj5rCrLlXlle7oBUwtIU
 zpmNaoMfzbQ7LT7nQZVeUm8NW2h4AqY=
X-Google-Smtp-Source: ABdhPJydvbuT9l1pQ3xrversPTkWW4SwsvIMKYPoSZ1uTctQIO2141gqMyee5CoTLiRJIw31X35IJg==
X-Received: by 2002:a65:56ca:: with SMTP id w10mr7463309pgs.69.1591893834186; 
 Thu, 11 Jun 2020 09:43:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g18sm3185806pgn.47.2020.06.11.09.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:43:53 -0700 (PDT)
Subject: Re: [PATCH 09/10] target/arm: Convert Neon VTBL, VTBX to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1f5c6a3d-2f61-a21e-9664-afd3476b97fa@linaro.org>
Date: Thu, 11 Jun 2020 09:43:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

On 6/11/20 7:45 AM, Peter Maydell wrote:
> Convert the Neon VTBL, VTBX instructions to decodetree.  The actual
> implementation of the insn is copied across to the new trans function
> unchanged except for renaming 'tmp5' to 'tmp4'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  3 ++
>  target/arm/translate-neon.inc.c | 56 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 41 +++---------------------
>  3 files changed, 63 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


