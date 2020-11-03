Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C92C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECFB320732
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 19:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJyiUcei"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECFB320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka2CC-0008Rg-0X
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 14:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2BM-0007ry-G6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:41:28 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:40628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ka2BK-0008MM-BF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 14:41:28 -0500
Received: by mail-pl1-x62d.google.com with SMTP id j5so9057534plk.7
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9ZcnE0/uMsOY+4a+OUMWobkCPuUgWa58ZPgCxjXvr8g=;
 b=HJyiUceiQBfReKmskgWjFsiKqlV+3+KsetjpSLDl9sOM4pDk51ff6Yx9Z7rgJhRb2t
 f/daZDamx+1+4/sr5xCo79ktgGQHc3a36axv6RBzQGnPsIJ/O0igdPSC4Lz7KgxckAG6
 KrZG6VXJvpeJilWUXfpUMo/oJYvvlINwNxpRquvqshh/iUkKOOS41BC9SEj4QuM0jfCk
 iTl4h6f4WtkaUSBERZcWXnuDZBHw84KtcynXIkTKtShrVXgIo8gRZ0SZDRUt/lJqUYuK
 JtpcE3Ke4lKRb5NCSRtX86nqDkYkPZ80ScC6xp4Y+GESyGoOpm7IwjjpsT52JF/rJ5ef
 +LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9ZcnE0/uMsOY+4a+OUMWobkCPuUgWa58ZPgCxjXvr8g=;
 b=o9Dxh9mYAv1lj5IE4F77Aoxu/XIsyorFaLg5LUcJZWij1X60dAsP8EkI1pj0Bf5O9X
 sAQeLP54Plmf53VlD/kf32qPiUc3kGH40BfkzE4m7GXFfAbKTtcovaZXcXUDn2QzH9VH
 YDbbX7ih2Gz40YUzMSivuzs9/b0v/6n4Ex4GAgSd5mYzmW2vysxn6qq+sDJ6tRK2Dig3
 kR5fulNgeDLeCJo3GJK0EBG/oa9JCH3HRvqRl2yA9uKW2NP+2G+BUxgDm9VhZAL2Lfsb
 CPaw0XGD6xbjSzaABK2LGraCf4sTrDICnNmpzEl6geh5sg0m147aPJ/oEftW0ahcJEfh
 45tA==
X-Gm-Message-State: AOAM533fzQ2usBtMgUfqLt83yC/cPYeAc1C6kwHFqo72zSaTmNZorAZ8
 j0PGqty3OS569J/Vfbd/abcaGkjeKcGeFw==
X-Google-Smtp-Source: ABdhPJwRF6A8fy0rkVQnZ3En2G7FmWjz83MAyNhCgP9y1cxdOnBKxGAbifZ8YaGKoIJ5uKo2rsIH5A==
X-Received: by 2002:a17:902:7b94:b029:d6:4fea:ad36 with SMTP id
 w20-20020a1709027b94b02900d64feaad36mr25796831pll.59.1604432484737; 
 Tue, 03 Nov 2020 11:41:24 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id p17sm15917809pgn.28.2020.11.03.11.41.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 11:41:23 -0800 (PST)
Subject: Re: [PATCH 08/14] target/arm: add MMU stage 1 for Secure EL2
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi.denis.courmont@huawei.com>,
 qemu-arm@nongnu.org
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-8-remi.denis.courmont@huawei.com>
 <e1bca2e0-d926-02cb-c462-5e9d64a51999@linaro.org>
 <1674144.VLH7GnMWUR@basile.remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d91134ea-891f-8ef6-5b17-909508984c1b@linaro.org>
Date: Tue, 3 Nov 2020 11:41:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1674144.VLH7GnMWUR@basile.remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 10:49 AM, Rémi Denis-Courmont wrote:
> It could also be argued that E2 and E20_2 should be one and the same. The 
> regimes are distinct but they cannot coexist. The mode's TLB mode could be 
> flushed when HCR.E2H is flipped, I guess.

I don't think so, as there are other implications.  E.g. regime_has_2_ranges.
If we merged these two, then we would have to differentiate them in some other way.


r~

