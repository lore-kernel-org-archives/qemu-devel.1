Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E7FC433EA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4754422D05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 12:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXdRcA5Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4754422D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3IRs-0004PQ-J3
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 08:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3IRH-0003tq-Ru; Wed, 05 Aug 2020 08:22:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k3IRG-0003KA-AL; Wed, 05 Aug 2020 08:22:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id k20so6110995wmi.5;
 Wed, 05 Aug 2020 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0txhT8ZGIBN9huhbO+h6pHwiKOp5Nh4JSK8IhwB4GP0=;
 b=KXdRcA5Z1tScW/SbiueOGsWVKNS4QGFFgrKvWIxKsn2zlZub5kop3YHkjui82uD7P+
 D0Wt5f7Sn+gCAcVVUgxHp5N7Fk8/7nkUdYK2wK1f6ql9eNnsPURMCPWjgBZnHuRkMUW2
 HZ9CqNFUxerzbmORVVLEzVenfeavxxmiSWRrWVfT6LNu8fnknsm1TI/+Au+//zOFJt94
 OOXieF1fdifjs4I0G5LtnRF2iZg0b/NS7+HK9vSQYOfA0RIVFj8n5TPhXtnOoF42T3sG
 6WsVzUSPdMOXuqNnppulBJaP6tfIfMDxbkSMvi9MgKw8+elICimuJaHbQP1NYnWmOUjx
 8rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0txhT8ZGIBN9huhbO+h6pHwiKOp5Nh4JSK8IhwB4GP0=;
 b=hVHqbVhsyI4KWHmdEsaPTgxg99LadjCvOPMFongg4U9N5bMspRXZRueSFJfhnRG/cE
 UOnnSJXeDAVLmlczWfjWA0yFPWd9jm8F22eMJ4fYY4V6V7kANflA+ouC+Vf8bzPCNG0G
 02MTwNvnqN0wSj3shjkGKRVK9P0vy30nItPZRhGKgv5qeAJm1ChHxyDaRvNeKN2wQGsX
 VRWbwCiD8cYKovYPRlpqhnocUSLlgGDPlguEw2SE5YRCQ6HgYkYYVP8BP2TYn+L21aT/
 5kTB4TkIyAkQ/YZP0qeu7fn7SLqXxr/6WWVxEC9riS2fnB3khXTiHP3hkW5w9u7spI+H
 pBMw==
X-Gm-Message-State: AOAM531CD6c21f7TB5a+vNJmSqTVIs05KpzzYEVpxZ73d7+NznQS9BeD
 /Vu6C7/PoioOQi0P7K9qF70=
X-Google-Smtp-Source: ABdhPJx605f9wtjSqQWt3r35rigzQfYmeSC/DdW2LyjvP5GHIIJNhfVIeCw3msKijwOpxD+uYDw8JQ==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr3021448wma.121.1596630152110; 
 Wed, 05 Aug 2020 05:22:32 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id o2sm2832799wrh.70.2020.08.05.05.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2020 05:22:31 -0700 (PDT)
Subject: Re: v8.1M cpu emulation and target-arm feature-identification strategy
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <afeb7479-48b2-3665-2bc5-0f5dae23ea4f@amsat.org>
Date: Wed, 5 Aug 2020 14:22:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_6zbOfdVi+Tp18seaEy4don1GurVya+E+QXRGrZ_WVLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/5/20 1:08 PM, Peter Maydell wrote:
> Mostly recently we've been aiming for QEMU emulation code in
> target/arm to use ID register fields to determine whether a
> feature is present or not (the isar_feature_* functions) rather
> than the old style of defining ARM_FEATURE_* flags. This seems to
> be working out well for A-profile. However, for v8.1M there are
> a small handful of minor behaviour differences which don't have an
> associated ID register field, but which are instead in the spec
> and pseudocode just called out as "if this is a v8.1M CPU".
> (The major v8.1M new features do have ID register fields.)
> 
> I can think of two ways to handle this:
>  (1) define an ARM_FEATURE_V81M flag
>  (2) define an isar_feature_aa32_v81m() function which under the
>      hood is actually testing for a specific feature which happens
>      to be known to be always present in v8.1M, like low-overhead-branches
>      (ie ID_ISAR0.CmpBranch >=3)

FWIW finding myself sometime git-grepping 'isar_feature' I'd rather
choose (2), even if there is no such v8.1M ID register field.
That said, my end-user preference isn't very important compared to
the developer/maintainer one.

> 
> Any preferences ?
> 
> thanks
> -- PMM
> 


