Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AC9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D952075D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nNdlj9JI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D952075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k39ZH-0002pr-Fw
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39Yh-0002KN-1z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:53:39 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39993)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k39Yd-00012G-Eq
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:53:38 -0400
Received: by mail-pj1-x1042.google.com with SMTP id d4so3494909pjx.5
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 19:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=LpoOxU+4i3v1XNfXCzBor7huV1kvbwWuPUtmczVqqeY=;
 b=nNdlj9JIPy4tQ5YaqpqjSIJqJClLHXIyOB7p9iuhOuaQqXHxn/9jC+jmFfjLZI9G/j
 amRt5c0w/76Rlo8Yk+5wB3pxusGRvRSvHu9DoFZVvz9v9lgPMGHWNoG4e9fX8pnvnGd8
 v4kc0EYCkhl32WrlN3Bm/2yY5v/RyChWUgwTH/kWGR/b6mkeVPFLtsTwOAuvnIcQ2T5h
 /H7fVg/xXUEPR2IlpTvLFRUzyL6nURtK7IXjPL0oVsKa5WtJUpDks6+mfv5h7WITloOA
 0vQF5Gf8/HnwKfVii2ezOgaO1i+DxEjKfKIYoBHEuVeC9oDBVikcAGyLbmRoHw8BqpiN
 bL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LpoOxU+4i3v1XNfXCzBor7huV1kvbwWuPUtmczVqqeY=;
 b=MtII22Fy9Xh+G8r487i1dnNkAqqcvJUekbq2XGqKfwEnnC677v1PdFILdH8SBtIlvK
 ITjO+1AXV/988Y04YKrxvt9vXFusC0zNoE7FFflYNNO0DRIAPsWkuVr1LrdQmfiLE9Sw
 gagb38pYER3PhHJDDt7xuNWhTaUL3IWtv0rpqmiB11FTv3+TwM2wNd9YP42eKYjZXBb+
 j6W4CgPMgsi7u384QIKmKk10tIZZbtF8ikDzGS/hqH635ORR9mc1Ox3bsArrpPXFfRBQ
 JT41LfPL4v1mqzroRk5jEz8BsPHpDs/Eoa6VPtoFgabaU9GVQzR/JqR6NgG2HoJj6yCa
 Y0Gg==
X-Gm-Message-State: AOAM530VpMiw0R7eVnJQGQoMuIII4Zh7Iap11cdNI4kTO7RmqL1f8RJc
 fgvebtq57XaKUnn6R3TUgz+BW+MPAdc=
X-Google-Smtp-Source: ABdhPJzGnAqNEqC11HFNKC3tviuYtzr3HeRsWA5i+cZ7Emn50Hf4niKS4qvA0URBwLnLKcbZlBehGQ==
X-Received: by 2002:a17:902:cd10:: with SMTP id
 g16mr1113514ply.338.1596596013121; 
 Tue, 04 Aug 2020 19:53:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id fv21sm688913pjb.16.2020.08.04.19.53.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 19:53:32 -0700 (PDT)
Subject: Re: [PATCH 3/7] target/arm: Convert A32 coprocessor insns to
 decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200803111849.13368-1-peter.maydell@linaro.org>
 <20200803111849.13368-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <04a0dcf7-37e1-b8be-6ec3-45820c583686@linaro.org>
Date: Tue, 4 Aug 2020 19:53:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803111849.13368-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
> Convert the A32 coprocessor instructions to decodetree.
> 
> Note that this corrects an underdecoding: for the 64-bit access case
> (MRRC/MCRR) we did not check that bits [24:21] were 0b0010, so we
> would incorrectly treat LDC/STC as MRRC/MCRR rather than UNDEFing
> them.
> 
> The decodetree versions of these insns assume the coprocessor
> is in the range 0..7 or 14..15. This is architecturally sensible
> (as per the comments) and OK in practice for QEMU because the only
> uses of the ARMCPRegInfo infrastructure we have that aren't
> for coprocessors 14 or 15 are the pxa2xx use of coprocessor 6.
> We add an assertion to the define_one_arm_cp_reg_with_opaque()
> function to catch any accidental future attempts to use it to
> define coprocessor registers for invalid coprocessors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/a32.decode  | 19 +++++++++++
>  target/arm/helper.c    | 29 +++++++++++++++++
>  target/arm/translate.c | 74 +++++++++++++++++++++++++++++++++++-------
>  3 files changed, 111 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

