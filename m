Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25301C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:07:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF2F720723
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N+DczPm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2F720723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhe9w-0002R9-6W
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhe95-0001az-LL
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:06:19 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhe94-0002HF-Ej
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:06:19 -0400
Received: by mail-pf1-x442.google.com with SMTP id s23so5261818pfh.7
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=0MI4C700VNP2JkZ+QJBwtStXiCUYTyMRWxB+i1kB+0w=;
 b=N+DczPm02TJD0ayAiIv7h1UB20Sbknz+6fZUVLblK5j7flKx/tfC1Skj5zi6OreE6J
 UZuqiUmT2Cn9dEXwk4MyiZ8S3yJxCwBGILjNC2wl7pJv4UDEH5QbH1C4nZqO1/Fhet69
 7LDOL73CTR6LBVjAWybUWSCHfZB9+8RDVajOiPrJjdrESYzn+pBiDVMm3+K7wrhw82rP
 3axNi+utxNuRRwbSThOPyuzYnfeFWVe3I7C3/Gg+HlyPOBoDufYUOkXukUg7hlrfDbCg
 OPn9gJTl7Hb8JKnyA4aRzxh1sGHG1xsNgcQOWKDswqr4myoH6NpPcmjClHim1l47bzGn
 Lrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0MI4C700VNP2JkZ+QJBwtStXiCUYTyMRWxB+i1kB+0w=;
 b=SLHqqg7ciZzqMCfJIIgOv5YhHe4JMgvhzzwubG9JJVfWgNG6R42uU9CmyYZMV/Qls3
 HsAIB1HZLr7IR16aw7Qufqkgv9BGz8F57X8hExouZ9K271bi8xwDF7R3i4nudTV49ZLS
 b+1oZ9wayADTsgxzo56KA5O1lb2rK3OJ8c8bHA3k3rc9ZbufKhKjYR2aIGnKYnVCnYjb
 Qym0myY3nusXZDfPX02CrmwXJk/9i7fj5iPdHw4lihfWm7IZIw67fc0FVX5Lp/fjm4cO
 safjLoz80dAx2Km8R+MV1Vm2Xnd8gchIren9V9Y0JBZgqiuQWAj6DlnwqUwcnc9mRkiO
 SsPA==
X-Gm-Message-State: AOAM531FLY2HFUPreELXVLmwg8lwyftgOOrnR/tjhGC8voTUbp+BnEPA
 zudkmJtKhaWYhlRPac93U69VIQ==
X-Google-Smtp-Source: ABdhPJxPDYXRmoCYaORt/Vyo5XHmb5dHf5VXI8skQuKLGzhQ+ycAWALnXVTv9oPP/PWTcmFL943Hbw==
X-Received: by 2002:a63:3814:: with SMTP id f20mr14145908pga.266.1591470376422; 
 Sat, 06 Jun 2020 12:06:16 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t25sm2457328pgo.7.2020.06.06.12.06.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jun 2020 12:06:15 -0700 (PDT)
Subject: Re: [PATCH 1/7] softfloat: merge floatx80_mod and floatx80_rem
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 aurelien@aurel32.net, peter.maydell@linaro.org, alex.bennee@linaro.org,
 laurent@vivier.eu, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2006051857110.13777@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2006051859040.13777@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6847fb03-8e39-0b3b-aec6-da227a5bdef3@linaro.org>
Date: Sat, 6 Jun 2020 12:06:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006051859040.13777@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/5/20 11:59 AM, Joseph Myers wrote:
> The m68k-specific softfloat code includes a function floatx80_mod that
> is extremely similar to floatx80_rem, but computing the remainder
> based on truncating the quotient toward zero rather than rounding it
> to nearest integer.  This is also useful for emulating the x87 fprem
> and fprem1 instructions.  Change the floatx80_rem implementation into
> floatx80_modrem that can perform either operation, with both
> floatx80_rem and floatx80_mod as thin wrappers available for all
> targets.
> 
> There does not appear to be any use for the _mod operation for other
> floating-point formats in QEMU (the only other architectures using
> _rem at all are linux-user/arm/nwfpe, for FPA emulation, and openrisc,
> for instructions that have been removed in the latest version of the
> architecture), so no change is made to the code for other formats.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c         | 49 ++++++++++++++++++------
>  include/fpu/softfloat.h |  2 +
>  target/m68k/softfloat.c | 83 -----------------------------------------
>  target/m68k/softfloat.h |  1 -
>  4 files changed, 40 insertions(+), 95 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

