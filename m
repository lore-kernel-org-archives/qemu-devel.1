Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D18FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:41:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B1021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2YlrlEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B1021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSoWl-0006Pz-9p
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:41:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSoVv-0005xN-Kc
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:40:52 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36263)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSoVs-0002UX-S8
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:40:51 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a1so538189pjd.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 14:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xc7szxBy5ZGgtgzFVb2BR8F4+hwuFjbKp2vEFubV2oI=;
 b=y2YlrlElRUpA3cj5E6iAskhHw1YTAfWpkgk3UF/iknn+/+jRQo2iWY6eQWyDG08vvi
 SW8kCXWtvxEGYBwzWYDud0t2/A6muVA0nKeTSdp52wrs4CdPAwoFc8pwm2o9n2aEHsC3
 l29bO3IZ4+DVmRtdRoY3678a3QIxzwH/SUrvWklCZtILnVD2F584rxIjncsA+6m0ZkcJ
 TwFsYbQ3D4+IwnAEKMnO/5cVcQ1/pGtpn1VqzEudmbOQIGiW69rijHN+HLmKnc5/mIGy
 Fj84nh5I9xbdWI0hPJkjK+WDH09BYJoQ+rzW38/JpvcrwAuQhfloEK2IH5SIAgyrvpoe
 ntBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xc7szxBy5ZGgtgzFVb2BR8F4+hwuFjbKp2vEFubV2oI=;
 b=BHSU1yLCXupUDL9uhP3nP3nXhSQjL56JP3vExdCZ6U1+KqjmhQndFQrtIhdNLNuO53
 mPsJxIfk4LrOLyLS2rjZU6v5iquFPzxJzpqDRsp5bdgi8B4ZNWwi5cKAO2e+baiiruSW
 q+gHjqAHnLXo5oIB/yJhNwAruAC278QDQWc4ky7JVfB2AD9zGmV9h3N5H1PjBMvJpJk9
 vuh1YkEIBZn/ZfIUd0rZzz00CkPdTT/XHgbZ46/B5mZXFBlwpEJSevvObftOoG4YiX/a
 TVzYj2eZi0cjSnJPeqtOa63ELIcOKdTZirs5EXUZexg/2L1Hyu5iW9kqTzUjgK+/w+iJ
 EKDw==
X-Gm-Message-State: AOAM53170674f4NinfzSjBJU8VJmfqQYqcvDTCaB92MOh9RFipjiv/ph
 ZuaJReQMsjeRGjL1CXCB47Ww2HZ5YmGkIg==
X-Google-Smtp-Source: ABdhPJy2Cd8/A4WXTLGCxkFyB7v/411mhdCZVP7aU7mlNL3Qsm+Kmb3DJeUVWTgokI2dgorBmxIQmw==
X-Received: by 2002:a17:902:9a98:b029:d2:6232:e26c with SMTP id
 w24-20020a1709029a98b02900d26232e26cmr893085plp.1.1602711646605; 
 Wed, 14 Oct 2020 14:40:46 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q14sm519672pgl.38.2020.10.14.14.40.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 14:40:45 -0700 (PDT)
Subject: Re: [PATCH 07/10] tcg: implement bulletproof JIT
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-8-j@getutm.app>
 <19c387d2-fc9-d1d0-849c-f8e8e270a97c@eik.bme.hu>
 <CADmqK1sTLy8O58rVR116VJnAK2qYMLQvX2wYxpcix_1YkFvLug@mail.gmail.com>
 <2ab5b15f-2372-9531-4ade-50dc12592d6c@linaro.org>
 <7372bc50-a0d4-4c4-fb6-c18f3ab327df@eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <90970f49-c36e-b218-7ed5-9fae3cce5c25@linaro.org>
Date: Wed, 14 Oct 2020 14:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7372bc50-a0d4-4c4-fb6-c18f3ab327df@eik.bme.hu>
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Joelle van Dyne <j@getutm.app>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 1:54 PM, BALATON Zoltan wrote:
>> static inline void *tcg_code_ptr_rw(TCGContext *s, void *rx)
>> {
>> #ifdef CONFIG_IOS_JIT
>>    return rx + s->code_rw_mirror_diff;
> 
> This looks better but can you add to void *? I think some compilers may
> complain about that so may need to cast here to uint8_t * then back to void *

We already rely on void* arithmetic all over the code base.


r~

