Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2DCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:42:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6CD8206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 15:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a6ywLGvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6CD8206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjPLd-0006tX-00
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 11:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35550)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPKt-00068b-NU
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:41:49 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:39468)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPKr-00025W-KI
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 11:41:47 -0400
Received: by mail-pl1-x644.google.com with SMTP id v24so2461946plo.6
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=taWCnuUGc3aBjWxN8/zwY/zGugn1tYn2OOhu/tU0z0M=;
 b=a6ywLGvFJR36HkUvHnxlGz6GiKxo03UcolEy3izkAdH8/Eob2aE9Mq77D55Sq2QxqO
 NOIDuiAvOLv+2MldKGoyIVhhu4o0fcy24ZNhxGbCk6R8b68Vmx7jTB66vDmq/M61Eel7
 inePlf5zJXumvB8jL3ASuCVK9X4eWVqz1ARKPV0HUVagoVMowd3Cf6WLqliF7pvST/Yb
 sI+XveP1EfEGuqeAyE4Ll+cElCK/yZVH/ErqjiN1IRUu+1PUydjsyfaSIErV+4hgAsN7
 oqkirSB3swx2VsswroIKSgJK0UZt/XJG0jA4Vp1qVzIU2u9DDdEuLqlTZGTJ1Ok3lhRO
 tq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=taWCnuUGc3aBjWxN8/zwY/zGugn1tYn2OOhu/tU0z0M=;
 b=tZ3iOGlgvv24Y4kGPCRkZIFEdWc4mN5xjdpNt00EBiNOw0+xxW/I3VDHvay+mXENUH
 aqAv8fyr0pNPHftBc+B6ZruuDaCKokiAUr/gWIjtLeRll0EgAjXNndaOOuL3DBIqCCol
 XH/LSZCikeSvVfppNN2Bvne5zAnWlnzY6/Iu++sHeuO1Slv7QSg1ohY9DKOQjHhzoMqk
 L8sKkwVvvVCYGZMp+AFNGMYKSps2/Uz/FZDqZXdzTkkiXBZxI+8Ncd3wRTpMEA/B6uiS
 5WQnytdzMYKX365WelQtPHLaYmQwLjpZOmKewkApRYPErrCR8tv2d9jJYziJDTEzOKSV
 d4gg==
X-Gm-Message-State: AOAM5301Ymkzk1kpt+lS75juTBrCU21A9BOn9QnboRUMSvBluhkQ9VU9
 odq20ZmqFFIcoVuK2fWv66IbUjuXBK4=
X-Google-Smtp-Source: ABdhPJwTdQI9BYok9VvHTgNuupRwWe+ESoS08BB4HRWqJ1Nwqt/PW/65FNxmS3LKvrKfAFa8MpVTxQ==
X-Received: by 2002:a17:90a:e007:: with SMTP id
 u7mr8760344pjy.208.1591890096198; 
 Thu, 11 Jun 2020 08:41:36 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id c2sm3537979pfi.71.2020.06.11.08.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 08:41:35 -0700 (PDT)
Subject: Re: [PATCH 01/10] target/arm: Add 'static' and 'const' annotations to
 VSHLL function arrays
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4f4808c3-c33d-55a3-6f80-6168c64979ae@linaro.org>
Date: Thu, 11 Jun 2020 08:41:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
> Mark the arrays of function pointers in trans_VSHLL_S_2sh() and
> trans_VSHLL_U_2sh() as both 'static' and 'const'.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-neon.inc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

