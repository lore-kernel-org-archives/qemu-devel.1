Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BCFC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38E752084F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tWzyLXlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E752084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibnlt-0000KA-Co
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 10:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibnjW-0006Uc-Er
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:35:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibnjV-0006G9-Aj
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:35:30 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibnjV-0006FK-4Z
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 10:35:29 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so5918772pfc.5
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 07:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kqhVzHLOp8uUueSk+iEINBMiBVWjaFwdSC0is+ty9ss=;
 b=tWzyLXlIuz0FlRLDIupY27VZevVsm+ECM0JreLi/dRvyNX9glFv4ugLfLLzs0Yl1vq
 fgjN9QPPQCz1l4iyI7aB7j0CELyCYr4RQUuykC5NF+cA0grdeMt1oymToBjht2ANwfFX
 kE1hyyZcOBb/AUSAdGbIbjw7Kd44JfNb90mhnZhKh8PPOTnVx3rQ7IErtY8VSB2vc87A
 fu63kjkgEtXRebdr9PfYnx+SxcfKrhTPF14LwGKnfBXjJz0bKh3w/Vr9I7InOpwNiaih
 88gGxbc9j+4lAbgQzx9GrJXQQBMyRtp/WkMOJfqDPL8csunw/v8LH/xn1ri8FQxwXjN1
 nyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kqhVzHLOp8uUueSk+iEINBMiBVWjaFwdSC0is+ty9ss=;
 b=risla9dl5PFZSVlw2pi9EZRWUi2wnLxUEbakiLuxLnyX8Dir/XSYy0E6brFSN0+JYq
 xEc10ghk0BMxi854y8hs9TbzB+cydGsgXs9Qard/t6zT7jBI9HyOtB4LTJZLVpkiG8id
 BssYVS5vJ/opnX7QarAOgyteRwpLDvVavim9kk5XvGwxS4WiEH9ZqDpMqyBtLM4CFmAo
 Hkss29hShM4il1WcCseEUzjD50GJEcL49Wz9B3vM+igMRyhKfyu9mdT/UEYFmqePNOut
 lJ/BjhFnPkSqu07l85xgGVDQdxJPY5qzi76YqphXcsnGTk+Pb8nTAKhc3QO4BIABci6k
 pR8w==
X-Gm-Message-State: APjAAAUa1BzesdTr0LNM5IEYXx0fRuTZz0bPpZE6yGrb1IXti/NZQPx0
 Pqm8md/pfPJuyCmYAYtm+7GLPw==
X-Google-Smtp-Source: APXvYqzifVy1jGZVxzLL8obYrVnTLFD9lEud7qbUPBAXed3Kk/4v8rqoySOR/DH1PY3yDyD/wVZYLQ==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr17301378pgk.399.1575300927972; 
 Mon, 02 Dec 2019 07:35:27 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id w3sm24606337pfd.161.2019.12.02.07.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 07:35:27 -0800 (PST)
Subject: Re: [PATCH v2 3/5] target/arm: Handle trapping to EL2 of AArch32 VMRS
 instructions
To: Marc Zyngier <maz@kernel.org>, qemu-devel@nongnu.org
References: <20191201122018.25808-1-maz@kernel.org>
 <20191201122018.25808-4-maz@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0bc7c461-6b92-2782-4aec-2f649f5bc8cf@linaro.org>
Date: Mon, 2 Dec 2019 07:35:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191201122018.25808-4-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/1/19 12:20 PM, Marc Zyngier wrote:
> HCR_EL2.TID3 requires that AArch32 reads of MVFR[012] are trapped to
> EL2, and HCR_EL2.TID0 does the same for reads of FPSID.
> In order to handle this, introduce a new TCG helper function that
> checks for these control bits before executing the VMRC instruction.
> 
> Tested with a hacked-up version of KVM/arm64 that sets the control
> bits for 32bit guests.
> 
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  target/arm/helper-a64.h        |  2 ++
>  target/arm/translate-vfp.inc.c | 18 +++++++++++++++---
>  target/arm/vfp_helper.c        | 29 +++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Annoying that there's a bug in the manual -- FPSID is listed as group 0 in
plenty of places, except in the pseudo-code for Accessing the FPSID which uses
TID3.


r~

