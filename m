Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981D4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61513207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZjSu6Vn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61513207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQGJ-00054q-8p
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQ2k-0001lf-Rx
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:27:06 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53365)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQ2j-0006gs-65
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:27:06 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i12so2415971pju.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=Hs7JSY0jzpcwRG5ER1FnBTpvSXdBInSdAVUJLhsMIx4=;
 b=oZjSu6Vny9PxZR4klZjc8y/l/IxD14IRTVki5n53EtwVfD8b61gdfRNhnJ/3cTM0Q3
 YPjhbH6HaV/W3MqMwFYCdyLLROs0+ooN34qF9YkPQiiiYP8pT5nd8/0RDj9FgJ1Mypny
 4tlFyj3OZHfOtiGMv9LZ1Hd5S40gDKqqp+kWar8lcIKvWxBAkJpNwRxk05ijE0LNwjIw
 jQA1tv1dHLaIruJRLe1D0xUJkIZmK9jbQ3Lkno63NWYM1RUwMFZ/V9sjssc8jUL1wyvC
 JzL4DMwId6JVAeb9LsHT0xL/Di6gTRFKZY9B90Go3h/bljjvLvwhbTf/RL0rttudsgno
 AdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hs7JSY0jzpcwRG5ER1FnBTpvSXdBInSdAVUJLhsMIx4=;
 b=jFlkP9r1cAwyIPW47yBXa0fcCteiCHbShsZW/ycyZ1NBZbccL2v1Fb66ZNZFXVOU3E
 GcKOc9ztpUkKq8mYqwG6b2suJ5TMHheDc5TQ8bk9Jq/dORylTX4qh3ZR51tR7B/a1NOo
 ntpoYcI4qLthmuQ8PfIDvlaAa9II+tgnIe9Tie7K98idTqmMvh4EML32thprw+4zBMbT
 /mihUTwlb3FuYFC5Yi0UahD6udV3rpRJevcDWGvEN/2tBy4vmyX+KpDIffHLyo+bWWFF
 dDXTJHKFJj/fOn0OH869Z+DYYhvX7C5m9X6nbKApypRurUnysjvMygNwlBPDtJNcfScc
 VfKg==
X-Gm-Message-State: AOAM530lSsglrT3DRvG1fhxCGTgv+CAfH7JAwdDnXnaN8la0gyzBT4L8
 kM9ojnLfASAG1evnrPTSAjy9OzES3VY=
X-Google-Smtp-Source: ABdhPJxW0YiwgsNjbe4wORFQ1XmypySzUJoOV+CVHsP19+yIxMOYf6ObImuQ4zh9Qw+5qZypq1eBWg==
X-Received: by 2002:a17:902:bd0a:: with SMTP id
 p10mr7778219pls.102.1591892815783; 
 Thu, 11 Jun 2020 09:26:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b5sm3670041pfg.191.2020.06.11.09.26.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:26:54 -0700 (PDT)
Subject: Re: [PATCH 08/10] target/arm: Convert Neon VEXT to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22ecaf5a-b770-b7c5-7945-dfa5d8fd91cc@linaro.org>
Date: Thu, 11 Jun 2020 09:26:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
> Convert the Neon VEXT insn to decodetree. Rather than keeping the
> old implementation which used fixed temporaries cpu_V0 and cpu_V1
> and did the extraction with by-hand shift and logic ops, we use
> the TCG extract2 insn.
> 
> We don't need to special case 0 or 8 immediates any more as the
> optimizer is smart enough to throw away the dead code.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  8 +++-
>  target/arm/translate-neon.inc.c | 76 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 58 +------------------------
>  3 files changed, 85 insertions(+), 57 deletions(-)

Nice cleanup.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


