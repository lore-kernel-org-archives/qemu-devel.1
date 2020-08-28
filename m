Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C243C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D23420838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yh9fczxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D23420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBncX-00071l-Is
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnbv-0006T0-PL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:16:43 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:39412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnbu-0005lA-21
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:16:43 -0400
Received: by mail-pg1-x543.google.com with SMTP id v15so1134077pgh.6
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=VtckSC4J5ESSKhX8mNtlXCkaS1T6N5QWZi8gz5Gvo0Q=;
 b=yh9fczxLex/rwo5yGF8VYNAbgplxbLSzmp8HutI1ih5ZispRh6DBG6d1VHuEkJAWgp
 djAnE9NVid2Sj++zOvP+uuwMmhr5SYZfrc6sU69YoYKMFmDBZFqv9RxuyXcsMDfRILAl
 YbTV2NCf660rZr1qDulv93dcUNEuA7ySr8yop/SMv0kICffqblx7uMVK+jr+dXdvcP8l
 1Ei9D/KM1oGU5oh0XoBA+U4diFNJzYlBI57EfvxHxauecoLzQrsixQOdXJy0axSatm6e
 XPPiCOjXPh1a0f2f06djWKpfGqrIGhsZmitDAGlroz1K9L2lDJkfeeWe/ozZ+g2OaQCH
 83Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VtckSC4J5ESSKhX8mNtlXCkaS1T6N5QWZi8gz5Gvo0Q=;
 b=nYAaD6Sy1HHB1siGho7GJA9lhrbNurpOaGohrlOA3py+WdlqoY/RyhS4deFG2OeAwA
 Vq6rFmvj4fdwUR/1eSXOYoOAWcoXUMiEB+MNUa9glSdebf0LNO2U16sF0YpLvD93Gt1X
 X5V75KOLWl1mZfUzJdkUHhMbZP0TsmHAXbrwws2UAGoO30iedlhM+/DwxKcauyA/Pcou
 mn/qwSxEdJFXYyIE9LQsFWhTo0LA8kQ2kFRCh4VgiZYkqbvbXLr06hT+pEjRiC7wxPqj
 Y2RhaxsOL/whBM6IouUpxtL+e6+Ue9fEFIqqxqJSNf0SMinN8KdShXHJXPrOBugtJjQh
 SovQ==
X-Gm-Message-State: AOAM5306eLTa3DhKm/a0wCQEwHMaDwZp1Mca5Ydc0vkBRg6/bC1GKUJy
 HVUAUBfOl8FBTpbrvIYEGbM38Ed7rtiPiw==
X-Google-Smtp-Source: ABdhPJx9xeNDOT+owZ5rnAnvy029FCSYpdwWfIDdTTHdY4qb/frww3QPmU90Xjuvl3g3R0TCb82CUg==
X-Received: by 2002:a62:4e09:: with SMTP id c9mr1054905pfb.223.1598656600431; 
 Fri, 28 Aug 2020 16:16:40 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w6sm483204pgr.82.2020.08.28.16.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:16:39 -0700 (PDT)
Subject: Re: [PATCH v2 41/45] target/arm: Implement fp16 for Neon VRINTX
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-42-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88a92ccd-57bd-c456-bea7-c4f995c635fa@linaro.org>
Date: Fri, 28 Aug 2020 16:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-42-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon VRINTX insn to use gvec, and use this to implement
> fp16 support for it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  3 +++
>  target/arm/vec_helper.c         |  3 +++
>  target/arm/translate-neon.c.inc | 45 +++------------------------------
>  3 files changed, 9 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


