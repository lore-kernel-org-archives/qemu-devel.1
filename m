Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358DFC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04DBF206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K2jbUJP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DBF206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz1xs-00070H-8a
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1xF-0006UF-0j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:57:57 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46282)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jz1xD-00063D-Gi
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:57:56 -0400
Received: by mail-pf1-x441.google.com with SMTP id a23so5605152pfk.13
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2020 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=2JlPnLoqJuxaGVZtFcCbRYlanUK7ezuVrCd2li093Bo=;
 b=K2jbUJP2KUNjb5QJgCXS6SkSksp5Ai4+LH+G3I40UD33ZhDZXAyUSyD+ltPPgihdbH
 eHOtwOVlJqCyRW8I0ciwG3k9J2MS/bgpMzKjxFD6W1aTZhBKJNKKRARRsjocoDNpJXbV
 50lfhZcCTorkMRr9+C6FOCtVaKoAQIJcc9ZtGULjQIeGLc0Xz6KlZkRmgtJGMP0TuQeq
 HRnd/bhzXDSPKBHf2sVm5M7s1Er6tTTAddYbe0pv0g5WqeBEQssVsQ6LrTIqStcwgW3e
 q38gAexkTBHekXgtppOFAP4ZBIIDS3RfM13iHhXk2kXzTKH3fN+rDVwRdbtKrqQKsGpr
 U4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2JlPnLoqJuxaGVZtFcCbRYlanUK7ezuVrCd2li093Bo=;
 b=XNJdYHdd2LxGq4/bInzCebhDAk+hgmyst4OmoXnkdGTwvWTc8mTNJxk87f4Vx4GFb3
 i1YUJEyK7JQjtbfkBFWrHUbpi/7r9BGHAamDvdzWsGXyJwQQHJ3YPeI+Bf12JezQIL6w
 Yru4qto7iLrI5jWYZ3Tae9KIZ1f1zQQ02p7D1rfIkW0xaFrQ9fy3qaWFsnDZKakZNQpG
 oPSzx08/UTpXLzYHNOJ7du2Ni8lITE3xLp4/NFHBTVvid9ZJRFBgQ88oVGr48OhNnlye
 VevmFGc8Ez2LTAI3ZEx2TQXJXbBYn6RvuvHnJm8bqmIqE0Z2nZtYM2kzT/tCWVHilUce
 iSoA==
X-Gm-Message-State: AOAM530aZq8SLy7Wu6yfz7HjfZxPzbg1mVTGaH83iPm2AMw0UVVUWn/o
 wN4YST+WuAPId0/s8MgVZHc3hQ==
X-Google-Smtp-Source: ABdhPJxHVy47eHMsqgxeYLFRBYBytjzjru+Iz3AzAmmd0VQGQKM+SFgKnvF54uCos5JNe53jG/VF4A==
X-Received: by 2002:a05:6a00:4c:: with SMTP id
 i12mr9719353pfk.71.1595613474165; 
 Fri, 24 Jul 2020 10:57:54 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 c1sm6885236pje.9.2020.07.24.10.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2020 10:57:53 -0700 (PDT)
Subject: Re: [PATCH v5 3/6] target/ppc: add vmulh{su}w instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, david@gibson.dropbear.id.au
References: <20200724045845.89976-1-ljp@linux.ibm.com>
 <20200724045845.89976-4-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fb84b5a-b32f-4c2a-7359-2aaabf34814d@linaro.org>
Date: Fri, 24 Jul 2020 10:57:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724045845.89976-4-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

On 7/23/20 9:58 PM, Lijun Pan wrote:
> vmulhsw: Vector Multiply High Signed Word
> vmulhuw: Vector Multiply High Unsigned Word
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v4/v5: no change
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> v3: inline the helper_vmulh{su}w multiply directly instead of using macro
> v2: fix coding style
>     use Power ISA 3.1 flag

The Reviewed-by tag goes above the "---" marker so that it is included when the
patch is applied.


r~

