Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7B4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 971F6206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 13:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wx+tRuQq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 971F6206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kACv5-00072z-TB
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 09:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kACuY-0006c6-VX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:53:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:39056)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kACuV-0005qa-OT
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 09:53:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id md23so11265196ejb.6
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 06:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hZe0yt7PzmjVTRdQBwox2TxEEvvKlVzDPp9SvUf1IvA=;
 b=Wx+tRuQqrcjyp9n/LqVt/mql48BJIsQOSHz7aTP6EGmWin4EDLZmtQSZh8yLYeybAN
 q/4c5Rj3hO5sfDJkmoVyiudT/hs7Y4BE8aLmNGMGIlvCe39QpKiH7/1aOhDZjLmOvJZC
 bsnD5S9b2iPM8cdcpejQ4MefwCsFpzkhZleWU/UrEIgU9mPUkQYB9YE6b32e5xA/yHKo
 1E3mMlqZC0iIkohPkRTrRJ/B6xnlBE8uOnSNmoAL/OrnOatnvDiOIpa97d71XEeLy8fa
 Ez8XjhpqugpXcwKkhCOR/i4s4/7LIs7kNjF9wMQXj+jhxh2reiB1IlGfccJLjT4vzARd
 pVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hZe0yt7PzmjVTRdQBwox2TxEEvvKlVzDPp9SvUf1IvA=;
 b=Il32VnOi2sRihN3BcoOpquy68XlqJdG71FOqxBhAkGXgypUGoU3LXBYF3IswLbFZG+
 pwY8QE92+VesX+ylP82/RFdmY7RZo3Jn/vlOvCZfZ6C265wUNhLwJ2tdGHVL5uxhn8iA
 PWLXxu4u4gmkSxcWY6vw4RXJhJBzzPC4mctIEEtpxfPIEiGb7DCvZ0P1wdEtVXxLTDmL
 pN8w8RpOOqMl+Yz/acCggSH+vy1JQ54O+fIlxhU8Z8OYjhkAv4l4Ksa+RvLYgP5gY9KG
 Sk9l5fSbKc8ZzcI9pK/i8x3Dn2Vs62xJt2bmNyQrKkPtmMrMTpKn75fBTjHxdVRa5yDw
 NQTw==
X-Gm-Message-State: AOAM530octGirt+Dgl5emz66s6U2cncfD6jLZcglx9dhUaii5Z4QrCJj
 EWnxslnbXx6M4j7eS78A5/DRdKFHRtUySFTrc66UOxgPm7/9qw==
X-Google-Smtp-Source: ABdhPJyNYbubsb0YmbkmI8kSY5nkh7bHrhc5J/VMwq6mpOWDEa2v1qThDuvg4FLtMDoZOFRU9vO0BqicfIj1mz1MORE=
X-Received: by 2002:a17:906:b814:: with SMTP id
 dv20mr5681443ejb.4.1598277197486; 
 Mon, 24 Aug 2020 06:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200824094811.15439-1-peter.maydell@linaro.org>
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 14:53:06 +0100
Message-ID: <CAFEAcA_eCEJVF99S+Zjc8e7ZkqBuE8v=QzuOEL7FfFnEZfY+Dw@mail.gmail.com>
Subject: Re: [PULL 00/27] target-arm queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Aug 2020 at 10:48, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> First arm pullreq for 5.2: Eric's SMMU stuff, and a bunch of
> cleanup/refactoring from me.
>
> thanks
> -- PMM
>
> The following changes since commit 8367a77c4d3f6e1e60890f5510304feb2c621611:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.2-pull-request' into staging (2020-08-23 16:34:43 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200824
>
> for you to fetch changes up to b34aa5129e9c3aff890b4f4bcc84962e94185629:
>
>   target/arm: Use correct FPST for VCMLA, VCADD on fp16 (2020-08-24 10:15:12 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
>  * hw/arm/smmuv3: Implement SMMUv3.2 range-invalidation
>  * docs/system/arm: Document the Xilinx Versal Virt board
>  * target/arm: Make M-profile NOCP take precedence over UNDEF
>  * target/arm: Use correct FPST for VCMLA, VCADD on fp16
>  * target/arm: Various cleanups preparing for fp16 support


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

