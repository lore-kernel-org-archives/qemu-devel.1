Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A2DC388F7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B95C20728
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 21:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rcYsv42B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B95C20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kamw7-0001R0-4R
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 16:36:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kamv5-0000y1-JF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:35:47 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43644)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kamv3-00074c-Fh
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 16:35:47 -0500
Received: by mail-pg1-x542.google.com with SMTP id r10so2248819pgb.10
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 13:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=SIgKkYHZg4XIKAyBseWN99Uu7ZGCUOnYVwl7w9I+bmI=;
 b=rcYsv42BVfjlUZ72R1T48CWasSI2rWY+FInDfM9JIe6z41Uf7thWugQrHia2by9xsV
 flw+Q73Xx+5nmqwqV1hI3Kdx1Upzhg2ninro1VciS1JgOJFGiujOaQpP4PE29el+ugBG
 luR3Eg0TY7TKpshwTPih4hMwCRAg+SRDex8FT5y82yWaanmkPwhBfTixtH3NxGNs800q
 c8pkh9+xciuBa0hfAV5z5QjO2JWSPfub/GQ+ED4Itj80mDhlEw+iSsedwW6VlFEzqkX6
 88valk1glYI6yV1/g/bBbG4kWp7zHufD8o0BdQgrd0C+Jv4FB51CYQ6BhX63t94CmMC8
 TtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SIgKkYHZg4XIKAyBseWN99Uu7ZGCUOnYVwl7w9I+bmI=;
 b=V45MbATtQW5bwdnCVU2u4TcIbLyzF5G0jKCLPvkStMdoYPKbA0+qbZLGzmRXsMoC/x
 ogmyVqCR8z281lhcF9nOwYFWO0VFc3fBc/lwRgzu9/mYFSkUULlD3rk7YIzmffeqTtKe
 siixg0gcmJIjonSh/RKL+h3gq2sVj+tnaTkUeiG8BmHQgPIqFz5Y5DshP7+5S7/AKkN6
 sC6mI4jw47kWs3UJ3mAHwK0bQ7qhyr5+7Z8q32lluBqwL9UBmrau/vt8TetBHdNFY8dd
 ukzUeMA+tqeFV3SIHq3zjvrLSqNpSrHzWsDkQ43Mi7Cdobu5I4M5w8WzYEMbzTIWZ40s
 QQZg==
X-Gm-Message-State: AOAM532kajKJElOqzaETDj6CAKcSwkPWQ4w3dUZXPG1I8hCzEQPxlCDj
 siGlrfl451Tpk6ri/wW6Ns4o37CfVtGC4Q==
X-Google-Smtp-Source: ABdhPJzSEz8JSei/YjB01K660aljA/6/xO4S34XNLs5mreRivaYkqAyb+BFsl9i9mj+gUQ1MDBa16A==
X-Received: by 2002:aa7:842d:0:b029:164:51c0:b81f with SMTP id
 q13-20020aa7842d0000b029016451c0b81fmr4587650pfn.21.1604612142684; 
 Thu, 05 Nov 2020 13:35:42 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id u7sm3479562pfn.37.2020.11.05.13.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 13:35:41 -0800 (PST)
Subject: Re: [PATCH] target/alpha: fix icount handling for timer instructions
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160456704692.16573.15665952713514406897.stgit@pasha-ThinkPad-X280>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2ff42a9-0bbc-1338-9ae2-bfc2c6136109@linaro.org>
Date: Thu, 5 Nov 2020 13:35:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <160456704692.16573.15665952713514406897.stgit@pasha-ThinkPad-X280>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 11/5/20 1:04 AM, Pavel Dovgalyuk wrote:
> This patch handles icount mode for timer read/write instructions,
> because it is required to call gen_io_start in such cases.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> ---
>  target/alpha/translate.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

