Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0425DC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:43:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23842252BA
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BcXyZJlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23842252BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNOO-0007t6-7A
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNMq-0006aH-EL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:41:40 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:33398)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSNMo-0004lX-Rr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:41:40 -0400
Received: by mail-pj1-x1041.google.com with SMTP id p3so196484pjd.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 09:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=jDfIaSldDNEugJPiv3YlRDD4AxZSw6/adFGWU8vPZtY=;
 b=BcXyZJlx4EO+PnWwhM2aG4TlSgo9e1eUa0t9RsXlxjIreSNPwEWmfHs0RcGSpJN6om
 0hfLv+YOVjPXBDlH2ex5wMC5dYRgb38xqs84rTp/UD1jVFyPx9/1S5yN7rvOXFRaZ0Y7
 v0WTa8oHyJG/QyWuBM/T6EkUPxrgYoRsDGZI6po/o6vGqp+l3ITIuGEi7Jd7rp5/jIsl
 lBjBbCWvepWkwb+dt1h9Za2orwujvP8tZp9+90YqviN7Dh0oS9WZRj5Fe2xrwZZNiUun
 rBnHa8KulgiLMaSzcwyE48hqICBRo3b2KivcIgYLamXRHOb2FeG1Xv1crRPKre/WV3eW
 OKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jDfIaSldDNEugJPiv3YlRDD4AxZSw6/adFGWU8vPZtY=;
 b=hJmVF81sgQfkTvX1HwXwnFlIJPG9lMC7FCGmBLKOKjsr0+0lQWuf2Vzunl9xDdZpTb
 XG2MXe2sL6giPL732yfRLJ1eUPZ60KnlSCiKzAq9fiPPagYXNvQuTJs0zL7VX3+Y876P
 DAz9Uwd/UuT6z9Jk8V6GmqcKciyqRKtEPUwfis0/14nh7HVLHpE//XC6Rd3a6A5ftlSj
 NbGrOiGrHVtCG5ADNIcwC4kCGhH48pD8QE9HR6vxRdjnUgqtIdz+3w60gQLj89o0OKGD
 mqVQZhny7VUkL/CsTriFt/m0otiGEAERERIPPRghW9mzoYwBgwNCKOpbMSeNcGxKsYlq
 qRAQ==
X-Gm-Message-State: AOAM5326Npp/ckWDKYIshVOmtimrUEa9NOpYNJcB21XP4CQzmH+054Sb
 /cdQ6wXhsfIGt/X5g+vxnYtTnlObaRw1mq3m
X-Google-Smtp-Source: ABdhPJx1EmUFcLByiqlfe0bfC8TRGOUdIrSxEwNZ27BGbDlSTPwoVBmuUSh60Oeux25+h4sibYwRtw==
X-Received: by 2002:a17:90a:aa90:: with SMTP id l16mr617389pjq.0.1602607295391; 
 Tue, 13 Oct 2020 09:41:35 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w10sm403079pjy.13.2020.10.13.09.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 09:41:34 -0700 (PDT)
Subject: Re: [PATCH 05/10] target/arm: Don't allow BLX imm for M-profile
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201012153746.9996-1-peter.maydell@linaro.org>
 <20201012153746.9996-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <737282d8-3ae0-516a-d685-600b8324b0d4@linaro.org>
Date: Tue, 13 Oct 2020 09:41:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012153746.9996-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 10/12/20 8:37 AM, Peter Maydell wrote:
> The BLX immediate insn in the Thumb encoding always performs
> a switch from Thumb to Arm state. This would be totally useless
> in M-profile which has no Arm decoder, and so the instruction
> does not exist at all there. Make the encoding UNDEF for M-profile.
> 
> (This part of the encoding space is used for the branch-future
> and low-overhead-loop insns in v8.1M.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

