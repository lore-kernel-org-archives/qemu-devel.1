Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32560C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0CD020738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdI+6nDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0CD020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAYZP-0000t0-1w
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYYJ-0000D6-B4
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:59:51 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:35354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAYYH-0001HD-7P
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 08:59:50 -0400
Received: by mail-ej1-x633.google.com with SMTP id a26so16423556ejc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7Bk80A2gjYhW1OTUY3kazTZKsuhaegwUs/Fce+B+WeI=;
 b=gdI+6nDwSWSrcF0pkHII1w7yHOFUXLLQ1cK61MPmIo78EpFhnF2kJwviAfw/OzHAv5
 Ae6ZV3I/QMkc0JebluNrtW4wEQcob6LVP6gMfQAw2W5virmvAZM0iNMrJtlhjaryu5od
 DIlhm106IX3QnkLTPAxkWoBC++uYHnfO1JtNFTXyz3FkOB8O8QXpl1V5Vk8XmZsnWOB2
 W9TGhFJc0gaJSDWpXm1/TfnhreJ4I9USk9ZGZrgbUHx5tqavK8xA4yZFwJ3n11UrUFBp
 hemb4T8Rtnjh2daB1GBeaONWPq2chZ9FQ4c3twBAyj91vqnHLf/vZnZ86bOkOdFaDfIl
 75wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7Bk80A2gjYhW1OTUY3kazTZKsuhaegwUs/Fce+B+WeI=;
 b=nAU0V6VtiFzA9cC4qyG6PDIrEYzioFQqltT9+oa8P+PAiTrL5CDc+adgvYtnW6z0yg
 GkyDGSMTF6ml89kHHMF+Sxte7ppznoUvmGgtbDWSKzXsCQZoI5xJFOHksX5eUOK1fwwO
 xg0sjMaZJEEOBW/0s+1dNzkeCpTd8OwT54Z9xma1wBCryuoXDWG2kDTz7wpTlGwid6My
 U4pTEPdqBzJPBD1XCTzoOyVuDnpMfeVyTQO5em3G0J6V3P4iMTRNWt21glizGL6ol1/f
 COBAX3DQRWfHC+p+hfPfpHteFFK7mnbvy6PPFP/nwI5ZASI5MKY3hdWzkWGtHraUdX1a
 VQyQ==
X-Gm-Message-State: AOAM532vVApuHt1c+Sgjzxum+gHcocWzwLxQKOnYAHFOt52aG7t/DbJA
 grQRR559FJLg4JGNkpHHyDC/mLNQlJx4OP/tEZT0Xg==
X-Google-Smtp-Source: ABdhPJz64/e2Ffwyand31j+qVegkd/i3Q1AHZ1pBwrv/srr5qaOXw5xXv6ViGOwJpvI1R0SwEHuI0c2uWGS21qjh9aE=
X-Received: by 2002:a17:907:2066:: with SMTP id
 qp6mr1327528ejb.85.1598360387342; 
 Tue, 25 Aug 2020 05:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200825062008.6502-1-kraxel@redhat.com>
In-Reply-To: <20200825062008.6502-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Aug 2020 13:59:35 +0100
Message-ID: <CAFEAcA_GwypdmJyRcyLyhcPdF0fqo2p8BhMfN-zmnsUCpV=XSw@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20200825 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 07:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 30aa19446d82358a30eac3b556b4d6641e00b7c1:
>
>   Merge remote-tracking branch 'remotes/cschoenebeck/tags/pull-9p-20200812' into staging (2020-08-24 16:39:53 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200825-pull-request
>
> for you to fetch changes up to 9755c94a50c8b845ad133a6e660f55ca131b9c7a:
>
>   meson: avoid compiling qemu-keymap by default (2020-08-25 08:12:19 +0200)
>
> ----------------------------------------------------------------
> meson: keymap fixes
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

