Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32338C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80D1F22226
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 12:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZK9Fiouc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D1F22226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZYY2-0007Cz-Df
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 07:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYXT-0006f7-Hq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:02:19 -0500
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35266)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZYWz-0004lv-A3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 07:02:19 -0500
Received: by mail-ej1-x641.google.com with SMTP id p5so18563744ejj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 04:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jkzWocvmBlBIpVDb4D3N24qjnp3Vi1uGUcZoWRXSxs4=;
 b=ZK9FioucVXTl4UPNHfBBC49O0Hgr5TKHThBOqPo027j2Hx/NYZNNXItMghYpuvPnc7
 P2c89fCjOUEsoJU5s6Hs6bPXtp+M/27ZF5qtYJgrri4e5SWl4u6LYG02Kq95DYjQplQs
 i8IAKOi3RusKCnzchQFHqPuMFSIN0JVYtNW3BVrfjC02D5Gsc865dvaR1HBfIgbZy/QQ
 EsFmAy4EWVoPtUbebpStGAQuOedCx7r6u5YrkFf5nf12GQmpJOFPJfsdN03iJFe/Ieu5
 JrysVb7D48wpxV1ZNAcVoYsQ4Upt2QOY6A3yr716J7Ozx/QkYW+13zj1DGKH21f/HiQG
 jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jkzWocvmBlBIpVDb4D3N24qjnp3Vi1uGUcZoWRXSxs4=;
 b=bQOEO/1O0rRiNQQTUOIYm0ZVVQnbMjy+e6fhRMsg3r8lDKrJFy/6aawK36yPGqKfpe
 ot0ZmVYwCzb8B++nK4imzMMQRHq0wx+3sVO32JF6aP9jjdVHddy7fdeAYGyS2tTw/xph
 SlnQPb5KQ3t5vKep4JEN2J5tnv+ZAV7kHtJcnLJKq9ntKVVZU5lDg9B7P9qecmh7Myyd
 HrvGv7XUrmp1zP+EbQ2v8Nj6nfdSgR1V+h5notVo2sbQ06OiWjkz4k+sBMDKmCX+5j2A
 3P3erW+Lir0BYRUuBu3DVPBx3SIFYkn9hEK9e7yqAYiOLTCB2I7jc8jo4pcz2ttYUorl
 Wkag==
X-Gm-Message-State: AOAM530Mt23ToQxrstL8/2iq1zdTdmjUAo7ULW72nPWbQRH3c9/teEam
 cUHMh2SYpPUIlxHIV81CVm2ck6V46uY0UkkzydauoQ==
X-Google-Smtp-Source: ABdhPJw3VjzSNEm+6kJblf31CAiwb2jTaNS7CZpEhd4Ii/E1cefArjTcnyH2zvHHj6RogXxbPKK+8m22QLA/qVnPNm0=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr15773660ejf.56.1604318507431; 
 Mon, 02 Nov 2020 04:01:47 -0800 (PST)
MIME-Version: 1.0
References: <5F9CDB8A.9000001@huawei.com>
In-Reply-To: <5F9CDB8A.9000001@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 12:01:36 +0000
Message-ID: <CAFEAcA9jBfGS-hG1SxurS3k98XOGpLzka2siw+BZTCHx6fg1Cw@mail.gmail.com>
Subject: Re: [PATCH V2] hw/display/omap_lcdc: Fix potential NULL pointer
 dereference
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, zhengchuan@huawei.com,
 qemu-arm <qemu-arm@nongnu.org>, QEMU <qemu-devel@nongnu.org>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 31 Oct 2020 at 03:35, AlexChen <alex.chen@huawei.com> wrote:
>
> In omap_lcd_interrupts(), the pointer omap_lcd is dereferinced before
> being check if it is valid, which may lead to NULL pointer dereference.
> So move the assignment to surface after checking that the omap_lcd is valid
> and move surface_bits_per_pixel(surface) to after the surface assignment.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>  hw/display/omap_lcdc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

