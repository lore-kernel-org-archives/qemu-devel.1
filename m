Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB14321D46
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 17:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLHXrkc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB14321D46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4DF-0005aJ-0e
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 13:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4CD-0004Wk-9p
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:47:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4CB-00089l-PT
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 13:47:49 -0400
Received: by mail-wm1-x344.google.com with SMTP id z9so3262674wmk.1
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 10:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=25OlRgF3QdKtcvCa7fMoUyXfmwae0FGDp6b+mSvW3yc=;
 b=GLHXrkc+wjLX5x49gItxZsQ3hNe3FWICKDxU950MoGyI1JMeFBRLGVh46yih/M+we0
 muAjEL05ku56hIa4xcX/X3mhQhANHvDaEDQWbwy+dCaD0yogUyRDD51Te4o4Y2wsUNgQ
 HtWjRcwbAeUcy9w4wO9llhQoceQQh2x1tJn4RLZmtmXuzHIVOhQMnsgLYRsUbGuR4K3o
 54HuMtZft8LsvoKS1z7uItjxtq4kUtlnQEu7/k4viUxwvQ1Cf7tOkyxAOQ0qR0bvcATD
 bIJETjw6UjUVk2bQ1otZ55yHUwH6LhGl5ldhIrQ5dns+jLPeE6jhsWDv8+kY0Y5VMMcq
 sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=25OlRgF3QdKtcvCa7fMoUyXfmwae0FGDp6b+mSvW3yc=;
 b=hKYLJshkOCRt20prxhkxScHOG4TWIpa972rfSanThOXDg0o+rvb+BhNd7BI1UdDREA
 fL5IFRSa18F88Tk+mVN5RfEIULDU0VZugy45bwm+XuNQBgY4+zSvy7rWEO8LqvC2GtCq
 Jmxy/UaBDky4WBN0Re4OEQ3neGt885PyVczzEi8ohz1xWGSkQ6XoK2XMWGFFtSl9cMUh
 xaB/kRUF15JVjSv/+EpV4QQ38fiNnVXV27w0fviDZiVp6AlIDYF1jW7QhZqhPcpUUZwv
 nDhpHkolW4eBpwPrb5qHNBBr8LlBP8nP7jJnle3snM3zEobBjm9LFqBvOUNs8kvRqzRv
 Lvvw==
X-Gm-Message-State: AOAM531IZgXNjcZmWVFG8PjXLS5uvvVAY24hl/tR5JTRHPrYM9KwRnhW
 +tTFs3j+oYDlE5/7xNAmKTxrBRoEASo=
X-Google-Smtp-Source: ABdhPJw7o7Z+UVvSb2Ij2Ew75RguzXiU/aPfVT5BKJDwL1SpqgowOAPrdfWLdzlHj41DzUjiJcvO9Q==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr4817635wmp.170.1599673666138; 
 Wed, 09 Sep 2020 10:47:46 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a15sm5846829wrn.3.2020.09.09.10.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Sep 2020 10:47:45 -0700 (PDT)
Subject: Re: [PATCH 10/43] tcg: Remove TCG_TARGET_HAS_cmp_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200909001647.532249-1-richard.henderson@linaro.org>
 <20200909001647.532249-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49d294d5-e2ea-4673-d382-c30502047b35@amsat.org>
Date: Wed, 9 Sep 2020 19:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909001647.532249-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.576,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/9/20 2:16 AM, Richard Henderson wrote:
> The cmp_vec opcode is mandatory; this symbol is unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/aarch64/tcg-target.h | 1 -
>  tcg/i386/tcg-target.h    | 1 -
>  tcg/ppc/tcg-target.h     | 1 -
>  3 files changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

