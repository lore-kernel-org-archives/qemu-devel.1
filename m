Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE97C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A4D2068E
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYOy4xDS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A4D2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVexa-0003pS-GF
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVewR-0002iW-Ql
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:31:43 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:45523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVewQ-0000Qd-U1
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:31:43 -0400
Received: by mail-pf1-x441.google.com with SMTP id w65so5861428pfc.12
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qbwvw77ZiG8x+kHfzEvk6KH6Bh3Tzut6Z38R8dGDqBs=;
 b=HYOy4xDSjYOXeDEyHR0BnKMaHola/ANbMRlOFdlrzzywgg612DjvQ5MomlWBVcOwsY
 1hxddZmqevwSDG4oHaIUDORlXzETkZjDa+ZhZrQbd95hivPG8kLJxlzv63Mp2doNpVPd
 XT4VTFP41St5z1Dps0wjMa79q+UcSnupHDg5yg/uqitWuFobbFuM8snd1+He2u02C9a4
 vKz7WmS499jKVjsSI1EFdDq4tAZuEBNFYvnJu29SnOxxYDBqXwh6ghfCbdqHoazpDrNS
 fhxX74BPNLE61SspKvfcfgM2sepVOVuAzkFmV9spDAewWAmicTGuYVJ3F82FyVWqxT2E
 iyww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qbwvw77ZiG8x+kHfzEvk6KH6Bh3Tzut6Z38R8dGDqBs=;
 b=KjDDQssgcdaFgLTjn55MEitE+6ex1wwRBSOF2MPE3YCi22KiBWlZOZhGckCvD27wqq
 0S6MoyM9RQQGQcsYEEwk1gS2yQB2J46/ngUZD3+Skb0MlyFRwxusWbOmPocZaaRLk5Bf
 Q17HwefFbbdA2ZbFEmFsenbZ/+xxteT0gi6xn2hCEvcipQTEdt6MfC0M/K3ec505J0fc
 C9ZwvAx9UcAIyOh7UcaGvJ52UKyzBX3w7uM1hMPQzbegqKauroze4vc8hKWXbNuRZ5Zy
 GEh15y0PwKOXUth3m1NwZHy4jeyvef3bwUVv/n+0vEiosdM+e3ec85m5pJcHVoIXJFx0
 XaDw==
X-Gm-Message-State: AGi0PuYx2e4sJ+aFzgzMvj93c58kuqE6QFjI/iWyId7PcTwgRiCx5qKJ
 8940zjwDaaLEF4mOQUjWgpwNQg==
X-Google-Smtp-Source: APiQypKuV0uzg2mDfzBI5c1oN8929/B47g6koT9pL6UsRab65CtBLIKuyFA2yzJ+72jVhUelrBs4lg==
X-Received: by 2002:a62:7e0f:: with SMTP id z15mr18318181pfc.149.1588613501372; 
 Mon, 04 May 2020 10:31:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id i13sm61515pja.40.2020.05.04.10.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:31:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] hw/display: Include local 'framebuffer.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504082003.16298-1-f4bug@amsat.org>
 <20200504082003.16298-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d24ff35e-9ce3-6b95-9c3c-e5f849ac16c3@linaro.org>
Date: Mon, 4 May 2020 10:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504082003.16298-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Thomas Huth <huth@tuxfamily.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 1:20 AM, Philippe Mathieu-Daudé wrote:
> The "framebuffer.h" header is not an exported include.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/display/artist.c  | 2 +-
>  hw/display/next-fb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


