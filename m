Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D4EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 275892067B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 18:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zmcLk0Pe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275892067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiipf-0005kW-84
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 14:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiinj-0004bk-4n
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:16:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiini-0004ll-FH
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 14:16:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id w20so10643323pga.6
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 11:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=AXCFx8cLBVf704O9SZukjn70bmMOxaRfB9yPviZxs1Q=;
 b=zmcLk0Pe9HJtsVGImjJZ0DEX8JJcdad5aohx4pZScL8Tl5lfZUTp82pmqYkvkiB+Uz
 tkEWAvOFvbG0BFEDL3+o6as45PQK8WvwuLBtua0TWYeBlhR5lfnZA55S7S3V21dLvK9g
 uCfdw3u7KXnGIBVxdsjG2A1olIH006r/c9XXk6fqjGWaTls+2jsyWt72Az2ogRVRIXzY
 cHI/1jgsfZTw7pYaJyTUaG/UK89AxRWqTPsGswmhxu4nMz0tDbC3+bZyfrbPDScTwQVT
 Hb8EzUBkrgx98RHhtpUjkLdNFyzH0BhoxFzOmEimkDuONhdJxYsiSBz6okEqpJFOFszR
 4WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AXCFx8cLBVf704O9SZukjn70bmMOxaRfB9yPviZxs1Q=;
 b=H3qyoX69IZkztZJZihZ+dikAcAUixUd9Ml1I3U19M0S/3EKcPmx0/DQ0hpOKPlr90u
 m93QSZ71TOYLkkuGbrzBd9OABTUvUZn7ZMR+tMViBxTMZC9UYd1gkBYQ86T+DAS0u8bp
 wJJbwfWejpjt3xFwflO2qfoHZEObK67KwhdWf12BmGyPR1V9kDIVjLqqau1OE+Cy0wmC
 3swIgXUKIT/1d5QDwewltAUbKgP1jgqs2HwNQib4AxU0R9Gfw8mFDgj98Zlzr3fFzGSz
 iWpfjBy8f8rZ9GX8/g8wXqHQOdCYXS7SAPEkHxIwUeTKe+am+XipmH+HHwdJIK+OZuhz
 dU2w==
X-Gm-Message-State: AOAM530nodSKuDhUh/7k7suZOzUZVMwMtBYBEKhrHdHmvGkjI9IP7Lne
 zBlnDtxvn9BB7qprNNjIs0bSs1LVeb8=
X-Google-Smtp-Source: ABdhPJwunF+eayWXYNDJfkY3IGSfOwrJU3wK0A8rh7yf0G3Y/Bp9fkC26Q963MFFEI/SmBzHbfno3Q==
X-Received: by 2002:aa7:8298:: with SMTP id s24mr27273007pfm.122.1591726600251; 
 Tue, 09 Jun 2020 11:16:40 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id d15sm10508671pfh.175.2020.06.09.11.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 11:16:39 -0700 (PDT)
Subject: Re: [PATCH 4/7] target/arm: Convert Neon 3-reg-diff VABAL, VABDL to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200609160209.29960-1-peter.maydell@linaro.org>
 <20200609160209.29960-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <821c1992-e943-feae-0522-acd6c570bb23@linaro.org>
Date: Tue, 9 Jun 2020 11:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609160209.29960-5-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/9/20 9:02 AM, Peter Maydell wrote:
> +static bool trans_VABDL_S_3d(DisasContext *s, arg_3diff *a)
> +{
> +    NeonGenTwoOpWidenFn *opfn[] = {
> +        gen_helper_neon_abdl_s16,
> +        gen_helper_neon_abdl_s32,
> +        gen_helper_neon_abdl_s64,
> +        NULL,
> +    };

Missing static const. Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

