Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A07C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:17:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B79922085B
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 17:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mk7yrgYK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79922085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2D1-0004CJ-QD
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO29o-0001Ve-Ed
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:14:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kO29j-0002Zk-4i
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:14:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id y5so6195758otg.5
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 10:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=RQlFEpLKBh5i/mlvWh+6qpQClVJ+XtthGnl3HhZREwI=;
 b=mk7yrgYKlci+8rw4b9qKiuX45vqgi5zGvpkCeiLoUkn/NUyIZ2tgIuQX9Udx5n1NYV
 3p95n1S9DDfPq5iz7851DbLv+AXJ7JQky5w/VlHZp4H1dCqGpOAZUexI/R0xu2ocC13u
 5c+gGecDs5j4zkYTxB5iBpu+iB1oScaRejPilJHD2hJB50XV1vEFO4wiS/3bREpy9JKI
 BdGRRPracnRQ+IwRYV3Z+s1KY8TbBuOY9KXmSer6sKJImA5ezWeUm2XkF7dYKc13Opm6
 fJtL9DpjKsbZ7dM1pKMcoi2OQF1GtPqIejS1dekQ1931ywn8KO7svA0pJQvKG2CmBk+J
 Xwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RQlFEpLKBh5i/mlvWh+6qpQClVJ+XtthGnl3HhZREwI=;
 b=hAA9rRMVIf752b2BGWqWaWKRElx4/ujY8xzXGcOxWGbC4QtlCQvHh116xUazHC9AMO
 T+jYjLZ57oYqLvpvqkAs1TIDEyWVmPb+QzJtYlz7oteV+9s5bbRq5UePMw/SG4QvFq/i
 LIQude54KuJRkek8e4afWgwRY+quj5nNaoHgudgBNuKtu/i9c+0xRzZxge0uTuT5Wg1Q
 Uf+ok6U2FZl1jzYVJR+so4UWGkEDqURaNBtSDwCWz0NoicvAr6fstdlL6uzDUXRZhruz
 DG3sU++jHpNAbAn/1GunKW1JYNilr7JFu85pmDoj5viJNtW2U5rxpnr7W3NqAYmuZ76s
 nXXA==
X-Gm-Message-State: AOAM531WtBii34mCEQCp+8lVPyccCNfUeV2iTH5civOnPu/SX9DeBYD5
 1iQw9MQ6ciPncUbaJC37QW68F+LOWtkFGL5w
X-Google-Smtp-Source: ABdhPJw/OwjiZOhHUxtAB21EGsVMt2Pstqf9//4nKub/E8Adab2Moikw/bJaFB+dm8ZejmNqwrgnGg==
X-Received: by 2002:a05:6830:48:: with SMTP id
 d8mr5360433otp.272.1601572449524; 
 Thu, 01 Oct 2020 10:14:09 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id h204sm234009oib.52.2020.10.01.10.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2020 10:14:08 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Make '-cpu max' have a 48-bit PA
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201001160116.18095-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f8f3a88e-2c8d-74c7-4f38-c21629d86cef@linaro.org>
Date: Thu, 1 Oct 2020 12:14:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001160116.18095-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.26,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/20 11:01 AM, Peter Maydell wrote:
> QEMU supports a 48-bit physical address range, but we don't currently
> expose it in the '-cpu max' ID registers (you get the same range as
> Cortex-A57, which is 44 bits).
> 
> Set the ID_AA64MMFR0.PARange field to indicate 48 bits.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I forget why I wanted this patch originally, it's been so long
> since I wrote it, but it seems like a useful thing to allow -cpu max
> to have a big PA range...
> ---
>  target/arm/cpu64.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Were you by chance looking at some of the optional v8.2 extensions, one of
which is a 52-bit VA, and noticed this nit?


r~

