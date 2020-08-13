Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD04C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:26:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44CE20658
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLZGz8aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44CE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6G3n-0008Un-Tx
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6G39-0007xy-1Z
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:25:55 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6G36-0000vf-JE
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:25:54 -0400
Received: by mail-pl1-x643.google.com with SMTP id k13so2830726plk.13
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wpLEhhn6asYfceAp1ueDPW1rk3OOpjE++dg79EKig+s=;
 b=XLZGz8aJH/xOQHLfh7H3a8ItiWRdTMvrJcNavBzPiVoce8JGYLc0O05ZEFLnqBzk/y
 /DJ43zHsL/MVTuZ2kInFgk+ULqYkf23PuGZ9pyC+pdD8lzYugO0/6pvA2WCRgQyX8JAd
 3RbZxYHPDyJgiTHQKt6qEC/19sXH8cL4AklzZsC5iTLZ51np+PngDo6Y0VuxSmBtesUS
 5ce0IH/wuJzSx2As0LEYF44K4BGvkoXXKVgkmUvVe8KSzOuDS67MHBIoxP0bE/H1Avid
 JEXdM1jPg56RTZGPaF+ItkXDhPPQNQn5jtkUHlpR3TxJmmBoF9CiFuO/HO+01b41y+ju
 M4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wpLEhhn6asYfceAp1ueDPW1rk3OOpjE++dg79EKig+s=;
 b=B/jtB53S2yqIuooedsgWEd6VjfO5ufCwJxaSnh5rhEPKBsdCx+6k5F90/NfSHSo7VB
 jgUxAjM1YgXu3lgoO4pbrdcjXnzF9RCW5yy0ArfTbQFn2qEFOIuVC1X1BIjshY2LQ8bu
 Of+DyGbHYxjZCty+PTMT/Aj1Bs3b/cNVi/FHk2pqeeMVZyoakqtcoR4z0ZXPqHcVb/k8
 X15pg+NxM3HzeFO5KWAB/V8S5v/3L6Z4CXmD6qP8d6QDUxQcRaQg9sPSsSelyAQB9unQ
 GXBPFzdCP/3gpnlR9oLCWikzOWDgj3rGxNyUNBqKiBQboRdR4t5eXF7ZZwLd7gNig0zK
 tbeA==
X-Gm-Message-State: AOAM531YM64S8kjxfW+vfCCuUR1poTxpKk2HQGpe6mvZkxx1sdYBWd5U
 tF/MnrTfp5r8+djlw5j8NZWlChDSAFA=
X-Google-Smtp-Source: ABdhPJytnBx0bZv9zoaUUlbUJhfwXYnXyy720GS0Ajz6tnNekkYcdyZV0b73XShRj6XQ8VNoGBag5w==
X-Received: by 2002:a17:90a:e687:: with SMTP id
 s7mr5957481pjy.48.1597335950952; 
 Thu, 13 Aug 2020 09:25:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o16sm6856048pfu.188.2020.08.13.09.25.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 09:25:50 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Clarify HCR_EL2 ARMCPRegInfo type
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200812111223.7787-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <472d2740-7193-c4fd-c403-fe48094ce1af@linaro.org>
Date: Thu, 13 Aug 2020 09:25:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812111223.7787-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 4:12 AM, Philippe Mathieu-Daudé wrote:
> In commit ce4afed839 ("target/arm: Implement AArch32 HCR and HCR2")
> the HCR_EL2 register has been changed from type NO_RAW (no underlying
> state and does not support raw access for state saving/loading) to
> type CONST (TCG can assume the value to be constant), removing the
> read/write accessors.
> We forgot to remove the previous type ARM_CP_NO_RAW. This is not
> really a problem since the field is overwritten. However it makes
> code review confuse, so remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/arm/helper.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

