Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD71C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F6A208D5
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 16:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lYGplUL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F6A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlawh-0004SW-5v
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 12:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlave-0003ZX-Ft
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:28:46 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334]:41343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlavc-0002zM-M2
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 12:28:46 -0400
Received: by mail-ot1-x334.google.com with SMTP id k15so2095610otp.8
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 09:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KlV2UXTf95H3IWTEXC9zCnquom/iLNsHl+EBgmkQTfU=;
 b=lYGplUL8vqYcAca1+pFJEGb6bF+vVc9Yroho8aHgz6/RvdnUYeT91M0W2RIwOiAlcb
 XSKA8bj+iypVEGMVG/kYdxOFLYyHOX64vdgOXpDNsnBnjaF71Uy9p2bPMubh/lzK/pDu
 1GdA8HLyyAtiSTTdm0qIgKUrRSjAEqVMHYrrUgRFLJXxdrnLFIVP2DnGROqZx5cQxW0S
 qUxg81WAiuYsblsgWXmn1zeoKQSzKhns0U1DWO4QOVq7B8Y6euac4cwhg6VDQsgdqihK
 ddCsNwLUNTMjwxMfYlqH3zBj/HiafsJIsbN7pmak43IVutM7dmfxRFbx5oPSpWkyYIfs
 Rxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KlV2UXTf95H3IWTEXC9zCnquom/iLNsHl+EBgmkQTfU=;
 b=WmUujce8za3Idtn/qfojt2QuA+Bv9kNTo9ItW8eTzIpQuL16Vb/WrUzK8emU59E+M+
 Zp+7aCuIDqEhgUKWLRuSULhz0Yrhnco6uapSgvLN5oUFZpJujwRvid3tb1uCGuuXIgy2
 DLinmgiCyGZFDJf0jZYthwi3CEoCU22mDNgpZrZX03vRT0UsdLOJ7FD7uJpjDcVD0h51
 YnBKYl8+Ew4kVKpWoJI2w363owFtRn6YJwl/CbK6XJfUxUd5htRdu3Rv2HIwd9PM69Ca
 iQw1mIZmpKCBYzdYy20EZx3S1xXqchUrs4LZEEXSRVMI6yQLRq57i+FdQlG3MQWYmV4s
 ZHzQ==
X-Gm-Message-State: AOAM532+4h1bY2JLWkJTVY+k6pQFpVwVQDavG7MqSmG7hAgG0nxL2fzX
 TlewcVx5iMrVDZi9+8aXGPajGD1zFNz9LxyUw2kktg==
X-Google-Smtp-Source: ABdhPJx+9Cn+2JJWQXGyj/Lu1ergdP5U4Kl1UakZZ90dTVIg5AjyiWBp+9ZxhiYUw4PfuV8AWNcs8DkqLSEpha9QStA=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr7732228ote.135.1592411323207; 
 Wed, 17 Jun 2020 09:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200617104750.29511-1-kraxel@redhat.com>
In-Reply-To: <20200617104750.29511-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jun 2020 17:28:32 +0100
Message-ID: <CAFEAcA8EVKxHYbYhR_GAm2RifHw=sbJZBwzZb0NvzsvLSeL9tA@mail.gmail.com>
Subject: Re: [PULL 0/2] Usb 20200617 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x334.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 17 Jun 2020 at 11:51, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200617-pull-request
>
> for you to fetch changes up to 54cdfe511219b8051046be55a6e156c4f08ff7ff:
>
>   usb-host: workaround libusb bug (2020-06-17 09:12:33 +0200)
>
> ----------------------------------------------------------------
> usb-host: add hostdevice property, workaround libusb bug
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

