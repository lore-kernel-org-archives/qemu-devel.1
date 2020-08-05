Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BB3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:06:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C052070A
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 03:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTTkXEBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C052070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39lO-0006vj-Mk
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 23:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39kh-0006Nm-Gp
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:06:03 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:42118)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39ke-0005OW-At
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 23:06:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id q17so24446020pls.9
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 20:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=BZUaSnUHLF8B/CkOLpByqJ1k6FT4aJ7iz41Ji1YYkYo=;
 b=LTTkXEBjmVnyHf3IkrNVCLizAu4Vs+LuJajUwWKpHheMdnLLoLNcNtSfuLl9VJbEjd
 3PRIiz19KTiOOO73arvqMgy72YE+XmZKTi7SjyjBO1f9X5Iv3VK+mBOxtArI3gvYTGRx
 oHJS/IGhsAINX0vGDeQlTHP4I409bxNzK9PoKfsQus+qTArvleKpGvVFdkIKnpyv6T/o
 VvBmXxaJ4nB1bncfZK6yU/SNyj8GNqZWnpaGMd3LeiWQOBBjfitzK30gIubVGK6pmTg9
 03srcwZNZKggx7AF7CGJWAT5UbSvCtNHWeSVXtn7Gmmcq89xtGy2WhU33bITDiMGCh20
 ItDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BZUaSnUHLF8B/CkOLpByqJ1k6FT4aJ7iz41Ji1YYkYo=;
 b=Owkg1TgUNAKCYbKFNEMKKzsgQgy4Nw6GqadTeSoMyg/XhM0DFx7AOb/7V5f2YZm7El
 S65Kex+7Fc/yCJqyZuxHzdCajWNaHu9YXnkWsqYlbGZNmSNtAnOk8yh5Z5qi4V3CXckv
 TO43kUCeKEH+aNk7oI93pNULG3gevsUiG8QwVqkArmKQ1mSw/f1PHmJNWGn+wh135Hjw
 HDco6jWVSGkeriDg2ihl2hG0dr4nzWy1WsrqnIYjWUUf78wti6n24cgamO/XaJJEvCZN
 GEpKdHGuHu3z3V/cKQisY5vhiPGNLeZpBnXQmN9lankZdqKa2LVBs7rmuYAj6RZ66LSY
 f6ag==
X-Gm-Message-State: AOAM533g1/TcixYzZVWBMRFW5sFyQuAWfqLkh3FqmPHtWGUeuHmgsGj0
 g2YXeRy9JZqMkPWkmo6iPpvK5TdGQ4E=
X-Google-Smtp-Source: ABdhPJxJ16u2YQLYDYdyt1E93kEN1yj9qX+FiC+Meqg7i2omwAG8k1qRIcdRI+jtPvGs6wuBU+5VVw==
X-Received: by 2002:a17:902:b089:: with SMTP id
 p9mr1175316plr.52.1596596757924; 
 Tue, 04 Aug 2020 20:05:57 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id h14sm785378pfk.195.2020.08.04.20.05.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 20:05:57 -0700 (PDT)
Subject: Re: [PATCH 6/7] target/arm: Convert T32 coprocessor insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-7-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ade5c2a2-d730-b455-496c-055da6101a0f@linaro.org>
Date: Tue, 4 Aug 2020 20:05:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-7-peter.maydell@linaro.org>
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

On 8/3/20 4:18 AM, Peter Maydell wrote:
> Convert the T32 coprocessor instructions to decodetree.
> As with the A32 conversion, this corrects an underdecoding
> where we did not check that MRRC/MCRR [24:21] were 0b0010
> and so treated some kinds of LDC/STC and MRRC/MCRR rather
> than UNDEFing them.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/t32.decode  | 19 +++++++++++++
>  target/arm/translate.c | 64 ++----------------------------------------
>  2 files changed, 21 insertions(+), 62 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

