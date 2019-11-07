Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6ADC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1579A21882
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 14:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wWXsEolQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1579A21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjBO-0007OQ-6S
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 09:54:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iSj2U-0007jl-0l
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:45:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iSj2R-0005WZ-HP
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:45:33 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44332)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iSj2R-0005Vn-9C
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 09:45:31 -0500
Received: by mail-ot1-x343.google.com with SMTP id c19so2179446otr.11
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 06:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CStpoHHKe0+UQ/H5qfcj7cFooIQs2EAxJDKO3qojGtU=;
 b=wWXsEolQiu/XMCAt0OnluEgyIDK4bqOXrlPbz0bs4bKAQqTlEtyef3SI+jE9F4OgEH
 87LcswxTYVZHagAvxWv0VwkP6CJZ9vu3nMWGM2aTFseo+Emz5c77wLYRkrW0LPAhJHkS
 GkbMJjxx1y3ThKvTg0gt746tQRGfWSNs2Qg/+T2mHcS/1s7wEtYLmyOOB9Guc52E2Q/j
 KzhWdQTiLYYCW9hK0Gd8TndvWcgk5tiWlMrPaKnkOCKBBvlY1VPSI+cXYVYZ4U+3zfea
 fvdcn4CPX5Buj2O5x9hkQh7Sa9IWUxypkyDokoM9y00D+2tjKiqL/cEs0Wl/GLWuIUKn
 nEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CStpoHHKe0+UQ/H5qfcj7cFooIQs2EAxJDKO3qojGtU=;
 b=PaLaXtfBBI+gcof6LHq8ioWNU19hUSWPIuZrQGrBQn6Mas4qOr9tltbbqvu3GICEoA
 MGWvMN5sxu3Zv5T6bmbJXFrDot5511FzkaYI0JPgJr2DVhgX7BNGWqbwXsjmjyWWSrjs
 TYjuacvmPfOWbsE3YLseR6ceVxgVGe1gPm8TM5DHT8+aSjwPTIwYVqQXi6cd8N4G0JUL
 Jmxem7N164r5KuT1baih2eQHxcBe66dEKFNuiHZsnmmA7oUYDnt4kWxZE4uHE/oTmcif
 JMfRXuaLgaj9q0wFuCpYYnwj2urBH0vcHMAuMEwRJOMA6dc9t+cE/NY8aSimXNlcmKoW
 VQzw==
X-Gm-Message-State: APjAAAUWGUFSnwHlPOPmKcb6hDCABnTsQTyevqhLN8MXPGRE+SPilqf+
 cqMJyCzPPZp8hrIbgfV7HpnLFTCjy82YMGK90AGwxQo2T88=
X-Google-Smtp-Source: APXvYqx6Y+mKkvN9yzsi8gPidZRX1YF6GfLfdmnm5T2Jn+CTk+sr2hWpQNMWWXGmZTXjEXxXM/nFCf/UxViuqKlqrrg=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr3136768otq.221.1573137929357; 
 Thu, 07 Nov 2019 06:45:29 -0800 (PST)
MIME-Version: 1.0
References: <20191106123407.20997-1-mst@redhat.com>
In-Reply-To: <20191106123407.20997-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2019 14:45:18 +0000
Message-ID: <CAFEAcA_4sgguVSvp-fFi8FAcGF80X63J2KOQo6VxM-Ca8nAefw@mail.gmail.com>
Subject: Re: [PULL 0/3] virtio, pci: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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

On Wed, 6 Nov 2019 at 12:35, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:
>
>   Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to fcccb271e0894bc04078ababb29d3d5e06b79892:
>
>   virtio: notify virtqueue via host notifier when available (2019-11-06 06:35:00 -0500)
>
> ----------------------------------------------------------------
> virtio, pci: fixes
>
> A couple of bugfixes.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

