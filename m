Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E75C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD0312078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rhO3aO/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0312078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZBt-0006Qy-2I
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtZB3-0005sv-Li
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:13:37 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39960)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jtZB1-0002Bw-U4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 12:13:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id u5so1216203pfn.7
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4NJXxUlKii+vxrQ6oZHz5sOoMFRNxDPI8rm2z+fpA3g=;
 b=rhO3aO/Wi7Z5Azf4N41HQLGSbMTRwG98iKeWWJ7iIJWlFNcJg7GVASC2xAt2KSoJvX
 hoixXl2oyIzsgSFLXaeAqTo4AVIFVibw+CHBPy/1/JlpJt6LBxr/XcBCQdx83nLSjrcG
 W3fgWl+FuP84xOlDBH3I8vKRdAwNcMqRKkUTrfk23qKs6dz0BMc3A8Ym8NjBCwbWwSFN
 zTHDr4T+YGNNe4KX9AWEiBAZpr9Idtbqlj+Cinff8Iza5pG2Vnr6AymYFmI61rcbEb7X
 3dOXDCc7dqQbbVc96qSeTq0fI8+GPdqC82n7PoMYeJchb6gPUpFfwUdRmNA/WHOSf+xM
 IYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4NJXxUlKii+vxrQ6oZHz5sOoMFRNxDPI8rm2z+fpA3g=;
 b=FejGcoIv8z00qHJuwyyyzrsNJu1kXLNzxYoBnoikbRDHSGla+hEEPlnrVjdLrwXLL5
 Yg+1q9+pD0d2VjAueImgjploZrNKIicpmKV7CCVGXFt5Mi642Y/i5KNlxRiCchuNBfdB
 u1DpMzOKqdocTIBWMO8ijA3waWqjBYldPvfYkJ9xXqWU6bMfPitN5kqmY0Vc1V2VWcdo
 9XE4kUWAwlKaOmemQ/ZHT+9msmawx38mqEaGNOFH2VkxOJAido236BLoV3japsfPOoRj
 0u0zWzCWBzyLI64g3m1fH+aMwBnUWGX4kVhewF1swtN3dRfsMuGSXCwQ3o4u8RUvUoS9
 7FJQ==
X-Gm-Message-State: AOAM5310ujx75AiUC/zhA/07NKRVHve5BZ5Y0twqe+dEkejoQ11aIAAA
 Z6H6G61TnFIQxGSsNoHKTou0qg==
X-Google-Smtp-Source: ABdhPJw95tLGVBLc9Dfd8Mi00GzCklLXbSM2rPiiI13qsHUW5rdds7VY9skuQAPG71d1Toedz/uDqA==
X-Received: by 2002:a65:60d4:: with SMTP id r20mr50602078pgv.436.1594311213810; 
 Thu, 09 Jul 2020 09:13:33 -0700 (PDT)
Received: from [192.168.7.121] (24-113-145-216.wavecable.com. [24.113.145.216])
 by smtp.gmail.com with ESMTPSA id j26sm3009409pfe.200.2020.07.09.09.13.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2020 09:13:33 -0700 (PDT)
Subject: Re: [PATCH] disas/sh4: Add missing fallthrough annotations
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200630055953.9309-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8267e832-ef6d-6ed2-cc70-5a17d5577ee3@linaro.org>
Date: Thu, 9 Jul 2020 09:13:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630055953.9309-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 10:59 PM, Thomas Huth wrote:
> Add fallthrough annotations to be able to compile the code without
> warnings with -Wimplicit-fallthrough. Looking at the code, it seems
> like the fallthrough is indeed intended here, so the comments should
> be appropriate.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: The new lines use TABs since all the surounding code uses TABs, too.
>  Please ignore the checkpatch warnings.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

