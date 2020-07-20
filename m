Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2615C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4C5020709
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 17:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLgjxohk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4C5020709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxZw8-0006pv-RR
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 13:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxZv6-0005gd-VX
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:49:44 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:39250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jxZv5-0007ER-5k
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 13:49:44 -0400
Received: by mail-pj1-x1043.google.com with SMTP id b92so192177pjc.4
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YeqKjD2nkX9uBBHsjAUOrp8SEqXLOGNsSEl0aSq5UtQ=;
 b=BLgjxohkv3Wwkmf5yyB+Olvoc6Z/rWbqwJgzRt9vxjqxcT1MfGV4WFlpiSAggzLZqg
 ViV5ROS78M5uNr4gGWP7XYOjVDETLv5k+c4pztI+1sM9Qm6cYZKVyb1tp0WpoO+ZdOVx
 tWwPELwggPq9P2ltIY6zVJG+jjQ3yrl4El7Fg2WdQ1GjVXi95iPJk676H4Dp/ktP2FS4
 9gqhv5Nn512S5mu8MKvIR2ipUqiZ3hwr5EhqjJ1xBLgPtvjBtdreI1SUNE/3UUwnJMJ5
 H7Sb1u1dwmw4jcxJlzKhpAumkeCKMAu+W5lK3I3NqP0AFWPsjeblNcxbBc4Y4l3YXUwI
 Eycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YeqKjD2nkX9uBBHsjAUOrp8SEqXLOGNsSEl0aSq5UtQ=;
 b=LI2kkJHgbDV4r0mhg/QRQEimcLOdzPmJEtlYAOfyHtQd8UwYKzclVm+uL9NBghwDqC
 YIgLpjvsFvInXLfbsanpfqmtIBn0Oty2w/uBTsgjyDZAD0Sd2zanfhxnxo2wB3pDDo07
 9PZHoDwMaV7hyQRN7uwq3O+BaelI5oaYBVko18dtKmSNjje0jB3Kmgiss1/A5uDP5HzZ
 fuu47BNKnuZHAHEczf/LUgdin4ib3kmOzrBRCTcC0Hy6qwLhijuX5s7FSNP3e2qs7dfR
 Om1ME4MVP73l43KdI1v2d+Vv2NpT0C+lZNYDhepdORNkXPKAPaQhoRrCQdPCDbLYMWbj
 8EiQ==
X-Gm-Message-State: AOAM533p7FyJ3Gm8+U5fm1KNH391WL4vG0g7VdUp+B1lpo+3atqCz+wr
 sKgpVG9Xh/JbMGQLnvZZ3FLpZg==
X-Google-Smtp-Source: ABdhPJz1jFw6ubTLGcVo7zXdMH/ndmtseOTWFqliFP33GWJO7RoS3pTbvEs0TNjQgLVpwfKw+r9p1Q==
X-Received: by 2002:a17:90a:26c6:: with SMTP id
 m64mr506838pje.215.1595267381432; 
 Mon, 20 Jul 2020 10:49:41 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 y24sm18425895pfp.217.2020.07.20.10.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 10:49:40 -0700 (PDT)
Subject: Re: [PATCH] tcg: update comments for save_iotlb_data in cputlb
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200720122358.26881-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1e820b68-a0a3-42ee-95a1-93a9045d4ad7@linaro.org>
Date: Mon, 20 Jul 2020 10:49:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720122358.26881-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G . Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 5:23 AM, Alex Bennée wrote:
> I missed Emilio's review comments:
> 
>   Message-ID: <20200718205107.GA994221@sff>
> 
> and the patch got merged. Correcting the comments now.
> 
> Reviewed-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/cputlb.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Thanks, queued.  I'll see if anything else comes up this week before sending a PR.


r~

