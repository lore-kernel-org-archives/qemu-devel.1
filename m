Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28269C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C908320773
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tb/quDBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C908320773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joqB8-0005XQ-1H
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 11:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq46-0002N3-7o
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joq44-0006P8-GT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 11:14:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id 64so8932490oti.5
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cSgVM8TP2AkWOMhCy3XOt6RDHPMwGUiOhqGBtWFDduo=;
 b=tb/quDBjmyplrm8VtUA3w28h4Pf8cwHFR2BabTAZ0xRetjv1IIXUC0JgLfDvpTgKM6
 hRFEHrTr5tz8+/wt9WlPxXdFF5p1ibd14B3LUybubY7xyRIn3uecGcA4GGo1Rj7AdiuY
 DhErE8UKoGdLW+1amlqY22yX1MXXUwMM/BPas+7DqTZe5lkRhXgo2mchumV1UMyVd1Hw
 hllIkA713bpRxyWKLYSxCT8yoFzvu3GzjlXfI1G2VQrDq2BRiYjuqZ16Z7haKtwcMDEG
 O7O1calHQFax2OUiO3G2iRtzWcJEPvP1/Mvgf+Z06zVHnBKr1qwEsogB+BbNqV5Tl9LS
 xIqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cSgVM8TP2AkWOMhCy3XOt6RDHPMwGUiOhqGBtWFDduo=;
 b=au+pPbVzukF3slvYEtvP5sZnu96JvBSCXii0KM6xKzDyjrNJSTOsalX3ABH+hkNzp0
 iwI7XSJx6/KpCQFTqSDjqUhjQyQyRMxGW4/gDHIOSwkN0KQ/3wi/wAVCnXW1P1cY39CG
 Cgp/nvIjjV3Xl6qdhmbNOaRSUjZvFM6KFLUJZSwU2wnaVzFZatWA/cCr9w54oZHuHTyj
 YOUEdjAIV2GSBpTllzecwhfv2425O0sVtpVjIp8ehoJTGTJdpQlJoNi+iYm4t6lVx6a7
 GW7ZdKSUZBmUpgxORDvs3my+Qh/hJD+xGL7zm2PzafWKCxN8WYQDBorXIY83C/0UwW1X
 x31A==
X-Gm-Message-State: AOAM531pdOUHfGHO9R4Qww0HlNzvj8TOchZX4USeQ0k5RQKRUXXsll6N
 rRitRG3RKrT3Uq7CjAbgp1XsgkOVDVy/zwhK4STWKQ==
X-Google-Smtp-Source: ABdhPJy6FbFBZM8w86/jc9bSgrKGCIu1IBQE8YTHnxi4fWqgzdZcTNCKypJ8NYocx5lUsQ72CJbTz5yBpjCM6s6jllc=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr204752ota.91.1593184491287; 
 Fri, 26 Jun 2020 08:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200626033144.790098-1-richard.henderson@linaro.org>
In-Reply-To: <20200626033144.790098-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 16:14:40 +0100
Message-ID: <CAFEAcA9shF7VK60zZxfYUzsDwdWyiaou=8Go+KExG4mXyk-Deg@mail.gmail.com>
Subject: Re: [PATCH v9 00/46] target/arm: Implement ARMv8.5-MemTag, system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: David Spickett <david.spickett@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 04:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Version 9 incorporates some review:
>
>   * Adjust some commentary.
>   * Added an assert for tbi in aarch64_tr_init_disas_context
>   * Split arm,armv8.5-memtag to a new, final, patch.  We might
>     just leave this one out of qemu mainline until the kernel
>     patch set that requires it gets merged.
>

Thanks, applied all but patch 46 to target-arm.next.

-- PMM

