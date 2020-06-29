Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:50:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F30522241
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 08:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oT9bGc1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F30522241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jppUg-0004Oo-Hc
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 04:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppTj-0003qo-Bn; Mon, 29 Jun 2020 04:49:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jppTi-00086y-1y; Mon, 29 Jun 2020 04:49:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id h5so15659181wrc.7;
 Mon, 29 Jun 2020 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WCSzq2VykjhePinNV6eYWl2enEGW52iXVRVhf0PKJ8E=;
 b=oT9bGc1pDcKEQx85pR6AYO2VhKVuk9bl7zqG9GkpP4lTjqHkKsoRvW9rA9xbfwTPaH
 ikd2GEmjc4Is8+imtle8rgwRc25VQ+ggjY6W4vvjjki9cUCVwyhfZRupr7D6d/umkbSy
 MpJ4F0g8MZ5cVe7iPMZqd/L0LlKSUwPiWZfB89ZU2tn87kkjHG5lk2PPaw9Ezg2793fG
 96U0/7nJo9rfQn5+JMtdtlSaqBtFIdBF8eBx7yO6abKZ4fthCTyvnlE5J7NA5Z/CT6kJ
 7TgPa3UI4MxGgIx1cXOyPyu/8WXYEdnc5hqwJdYQlb1KuYPg+yQgm5s1lzQU6X9CnJbE
 U07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WCSzq2VykjhePinNV6eYWl2enEGW52iXVRVhf0PKJ8E=;
 b=CbyDJdpqY+kMPFd6qcLuKO7nPNFazAX4Bxhv5hTZRKwb7zTq8kpcZL89X4W9oDt2Ks
 XDp39eayjcH17DkrVrOZl7JsuzqSyH/zVdX1DQ8EjH+iMzvj27MA1lYOemvpd/yDxPkd
 FyzEW9IMjFpOarQ37V00b2gFyL/o3Np8bMzn8Ynije6grOzuEpRt7O54YTudNvVojRR8
 2CHnYZjyrUrtzdjoGgW5KObbAcW1CmQ7EMjLsRFNPJhu2rqNC4jws91wmiEDbqRZN5Rp
 xpugvluUi9ivMVFcSR6RtrmzTW9oCrFuBy96Gfa3kNn5G5kZDnQxNQE81b4ShBt309YJ
 1yng==
X-Gm-Message-State: AOAM531jtABUtIfwuSF8RFJfwuIKukJ4yyfu5hZfwEtRulOwhiWK5c23
 1Yc0sEUc9nnHSf2G6Ikuf5A=
X-Google-Smtp-Source: ABdhPJzHJi7rIjep4fvB6+SzyESENE4rxBFde0Dq29JT9Pw/McdRHDiOF5ucRmdgssbqFr7d+6c6cA==
X-Received: by 2002:a5d:658a:: with SMTP id q10mr11170185wru.220.1593420564164; 
 Mon, 29 Jun 2020 01:49:24 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id r3sm16181629wmh.36.2020.06.29.01.49.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 01:49:23 -0700 (PDT)
Subject: Re: [PATCH 01/17] hw/arm/spitz: Detabify
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d9c6869e-6df4-c1cc-8078-bcfe2d5442cf@amsat.org>
Date: Mon, 29 Jun 2020 10:49:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200628142429.17111-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 4:24 PM, Peter Maydell wrote:
> The spitz board has been around a long time, and still has a fair number
> of hard-coded tab characters in it. We're about to do some work on
> this source file, so start out by expanding out the tabs.
> 
> This commit is a pure whitespace only change.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Couple of checkpatch errors due to the QUEUE_KEY macro which can
> be ignored as this is just a detabify.
> ---
>  hw/arm/spitz.c | 156 ++++++++++++++++++++++++-------------------------
>  1 file changed, 78 insertions(+), 78 deletions(-)

'git-diff -w' -> no change.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

