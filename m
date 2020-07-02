Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176EFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAE2520702
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LOB5MNPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAE2520702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3LP-0007T0-4e
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3Ae-00045E-4J
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:38:48 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35700)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jr3AZ-0007Q8-W8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:38:47 -0400
Received: by mail-pj1-x1043.google.com with SMTP id f16so2435186pjt.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZTc72DhtseFTiRpOsQCQpjEwjywGIZnMY5O8TZHL83Q=;
 b=LOB5MNPmUYi8BBwXJxbsg1I+TKr+o+01qQA4GyrD8xda9G1fNcXo2uW2MCB71ksTl1
 VePVtuuZpdqIVJnQ46afTad7VUw/qp/1loywz4aUVLpHwiuQE5oTpYTeQi2O1turMw2I
 xDzCyt8Bpu7CzSzz9pDj7AhvcwDxenBLW97AK4GkJ5fE3gXp/rRksBrpx1ydvHbmYqoM
 E12xsYDBzIS6Y8ijfvBkS4/ua7vrTPoxM5243cy8z3vdvT1qATxWwu4/3oz9RnFMeVVy
 tpw8sPlabP9sGuHZ1e7GnA2VFsUCa354d2M4dlSCqFxL8/LPOYQwLTAQlEq1xLtANQbj
 Q8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZTc72DhtseFTiRpOsQCQpjEwjywGIZnMY5O8TZHL83Q=;
 b=oBriz7WS92QnY+IXlEqIoqeEOs5uKTC3GfNmr7FT1jwB84IFZHEWFmeVsv1wUbxs7P
 rF5053OTrE7ENEgRigj2CYUGYZUAFtyPHtjBuSzImm2Ys1kaGBoLFUjSLCXMHY9NzNzv
 G/B+y3EDxwhfUjUyy4DT+kQC6QZ4UxB9Q/UGCRC5BW10/RMr815O3VPbmM/94FtHF5Kc
 0a4l9ZUjXek/+/8NtB2dzwEi87IwhvsxRD98CkEQ2JZtpNSzAb115d2Ur0R2Z5gP0gXB
 BwSz1K8ISdRInj2uKDCYaxu2doyjDUy7i/8ftdrRIG+6fwamcjSIZDK6JunluJo95jo6
 W9Xw==
X-Gm-Message-State: AOAM532sN/pxqKm4ns02ZcETI7S/xCxDF6uIlgxYmRAjnREzyHmdPtmC
 4+wWEiDe4ATC3kDnhS1d8YHzqw==
X-Google-Smtp-Source: ABdhPJyuznEQWI9vns6vRPJqFvH6+czvMg2AW1yGYWejoqfNJhtl4AYd1lh5HYvf4/rvLgrwznF2hw==
X-Received: by 2002:a17:90b:b15:: with SMTP id
 bf21mr29960892pjb.53.1593711521203; 
 Thu, 02 Jul 2020 10:38:41 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l22sm8202373pjq.20.2020.07.02.10.38.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2020 10:38:40 -0700 (PDT)
Subject: Re: [PATCH 6/6] target/riscv: clean up fmv.w.x
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <20200626205917.4545-1-zhiwei_liu@c-sky.com>
 <20200626205917.4545-7-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bea50a30-e8ed-dc96-8b87-d70e655c8524@linaro.org>
Date: Thu, 2 Jul 2020 10:38:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626205917.4545-7-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: palmer@dabbelt.com, wenmeng_zhang@c-sky.com, Alistair.Francis@wdc.com,
 ianjiang.ict@gmail.com, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 1:59 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/insn_trans/trans_rvf.inc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

