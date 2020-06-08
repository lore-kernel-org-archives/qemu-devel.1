Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF86BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:35:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91B62068D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 19:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XADa9DKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91B62068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiNYH-0004a6-Sx
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 15:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiNXF-0003vw-Ay
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:34:17 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:37326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jiNXD-0002Pf-Gq
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 15:34:16 -0400
Received: by mail-pf1-x434.google.com with SMTP id j1so8821728pfe.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AcyiuqNX/10n+HDXnwm8ZWC5XW9Ssx4G0Ai0U0oyVP4=;
 b=XADa9DKLi5UKLuCAOWIFKtavmniYGLECtCrDlm3GrMlP2QSpYAFIKr28ZtTE/9PcY1
 mn2SA4f6dZLiz2QJWaq9a0gPs8x/zhGO/Mw0CwfNMlvwK8Gi2PzXUNsnKx363FA88CPu
 dVsIksNrAAsgu6n+4Z7gStagM+6qKN3ydX6AsJO4zEQGAwRtrV4gwf661xBOu3MZ84u6
 GI201UtoGcBwBefkVpsiNh/CMgyHlPwqljEDgn2U5b2415t209r7ESW5qnns46eh4ooh
 KvI3aJU6S0nxKGh3qK/4lUOnmrMLS+odB42ZE1WwGLMP4qkPdC6kZ/O1scNh/be37tEu
 5xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AcyiuqNX/10n+HDXnwm8ZWC5XW9Ssx4G0Ai0U0oyVP4=;
 b=khqL9SH3ljvnPF4urkfF1C5hNQ3scEeyn4ZUavj+1EMxqeq0+P/gKhp3sfMW/xx8d2
 /PUpo8KVSOI9qYITjcsBv9jRIAiHgqLdsqpBxXYC4fTiWFxJzLVy9m6qGqh8aVd5upWH
 a92x5Y1et4sbDWRzYyUOEAfTpVg81eFqFkthE+qL7DO42MYSUH05N7uAtjoy6s6q2K+E
 huRQPpzPWrqCOIYypkdvtFb4Ny7XhkLjyvN4EOZH/UXnjgeYcjLu7/lDHF2CkztXtV4z
 ip0ycmcl9+esUZSFXgpTUwwpjkHb0YVH7UdM5mbf8U48xv6Snj+rkGpyl6EHlwXN+OrC
 /4Iw==
X-Gm-Message-State: AOAM531zCkH+Viy4gSVEY8KPnpdkNICFhFMNifV59CnbfQkTUE0kLZww
 Gwp4v8zn0YA+MLNnQtBNwEXL1g==
X-Google-Smtp-Source: ABdhPJwiZJVhaUq+Rsrgn0wRKgVV/1qhyV264MPHMCtw/XRs3DW5U3FWE8IqYEe4t1SSsJHnkXBURA==
X-Received: by 2002:a65:45c2:: with SMTP id m2mr20652985pgr.201.1591644853787; 
 Mon, 08 Jun 2020 12:34:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s98sm279451pjb.33.2020.06.08.12.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2020 12:34:13 -0700 (PDT)
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
To: LIU Zhiwei <zhiwei_liu@c-sky.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cbaf8623-daee-a8b1-3637-3afce26e5004@linaro.org>
Date: Mon, 8 Jun 2020 12:34:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/8/20 5:53 AM, LIU Zhiwei wrote:
> Hi Richard,
> 
> I am doing bfloat16 support on QEMU.
> 
> Once I tried to reuse float32 interface, but I couldn't properly process
> rounding in some insns like fadd.
> 
> What's your opinion about it? Should I expand the fpu/softfloat?

Yes, we need to expand fpu/softfloat.

You'll want something like

static const FloatFmt bfloat16_params = {
    FLOAT_PARAMS(8, 7)
};

(This would be the Arm and x86 definition, anyway; hopefully risc-v is the same.)

And then add all of the other interface functions that you need to use that
parameter.

FWIW, it appears that Arm only requires:

  float32_to_bfloat16
  bfloat16_mul
  bfloat16_add

and I could even get away with only float32_to_bfloat16, since technically
Arm's BFAdd and BFMul psuedo-code are implemented in terms of single-precision
arithmetic, followed by a round-to-odd into BFloat16.


r~

