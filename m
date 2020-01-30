Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE85C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557D320674
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQKVSYPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557D320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixC6o-0006P3-9a
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixC60-0005J3-7r
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixC5y-0006bQ-AE
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:51:07 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35479)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixC5y-0006aB-2e
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:51:06 -0500
Received: by mail-ot1-x344.google.com with SMTP id r16so3591438otd.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZLJcHv/BfFy15ulq3w2U1nPIF1uinxbVoFNeR+cJoxk=;
 b=aQKVSYPmcwA0UD2+KLl5uKEyWABwMOiZA2oyQBydt0iZcb7c1XAuD5JjvFyiVCyIGC
 kQcodKJHvgIZCfA5xV3fcZMwg8SdDGm/O2SdtMSuA7JSPTvH24cfTPsIlMSZNEq5tD+y
 XYGbukCzkoe4BmUAF2HtEIhQO8wNoTsZcNZpkTudorpR/HOEl0ICf1hwsfSzMhcsy5RL
 pbiXQhJfLl5A/hLCZf92JcU4RfPxyCAiY3/X7mqqBbSkySBpQl3rFDVm9T7nutpbmguW
 IMKZcc53rlCrQAfb8YlATgk9rjmfxvd1bGGdF6BjOUdJ5fxyEwflLEoNLakjnYnCfRXu
 yQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZLJcHv/BfFy15ulq3w2U1nPIF1uinxbVoFNeR+cJoxk=;
 b=fHF+3RkyoXuyV7asUKefX56HbDeimympZJPhhwhiHKR8OemCap9BT2TAOSuQhnB3bD
 u9aI+/urN14ZArtPf5IAaqIzaOX71BlXRmoglSsdu1t3O5/LFgSTzrhnbictBsPkzQmk
 aE7mpzW53K4WcQ95rU7xjRqvfwV3+EHet47qkJoUIHs8fpIDg7nnLHKlQC90KZvKX3B0
 FlXfDNx2RQTn1yayN8oNPUUEjI3bZdR4RSVnNZQq77OvochSqs9OxN6i/3+GnPy1tUXj
 SFNt31WqkB8oDhhjhI6uwvozG0dt3jYBzmAYOIMFNF8aTx+8tIsjUs58douKL1IjeQ8H
 x7Uw==
X-Gm-Message-State: APjAAAXQYanCniAYumEh4Dl9yi54u2xcCBsvCuPHPCKC91s63tRESthe
 LRsODMXPsrKER6G8+yrV8mv/xJeIsPwk2jZEWB7nqA==
X-Google-Smtp-Source: APXvYqw9/KBh85qLpw/IvwJG5SW/wtORfMgEUA89U1F6RV/w1xfKiMN5/xmC4XcYX4l00QuATKd8C+ULRgCJ/0TxG2A=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3996488otd.91.1580399465309; 
 Thu, 30 Jan 2020 07:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20200120101023.16030-1-drjones@redhat.com>
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 15:50:54 +0000
Message-ID: <CAFEAcA8jD_i=tu1QCQY9yB_2+chTk3b54AyHNGG5hC5YR41zgg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/6] target/arm/kvm: Adjust virtual time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: bijan.mottahedeh@oracle.com, Marc Zyngier <maz@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@huawei.com>, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 at 10:10, Andrew Jones <drjones@redhat.com> wrote:
>
> v3:
>  - Added a target/arm/kvm_arm.h comment cleanup patch (1/6)
>  - Minor refactoring of assert_has_feature_enabled/disabled in 4/6,
>    kept Richard's r-b.
>  - Rewrote kvm-no-adjvtime documentation in 6/6.
>  - Reworked approach in 5/6 to properly deal with migration and to
>    track running vs. !running, rather than running vs. paused states.



Applied to target-arm.next, thanks.

-- PMM

