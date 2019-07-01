Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC55C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:48:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC71B2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uotv01UF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC71B2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvj3-0003xU-4y
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvgs-0002WR-DO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhvgq-0005ug-Eg
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:45:50 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:41784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhvgn-0005sp-CH
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:45:46 -0400
Received: by mail-ot1-x332.google.com with SMTP id o101so13012593ota.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vNULVTyS8QRU64W9OGAFoDYvPCYVmncs1V+CJp7tdcw=;
 b=Uotv01UFxZwsigr8zAIOacfXoSywqeMPMwKq8Hc1pXfK69TAuLy2slC7JQ68etIlD6
 FygOO45ZHSw6KRAR841Gi7Hcg43n8kCXmWCqXXc7+unB5Tr0xdOPYhncJzkF4Py8+APe
 4TSrzcW76SQWctY3Rzs2mrtwFpswcYHSjlB54xZIYEKhrz2BsYwsD+fMsGyx6MsrgZRP
 kxpYsdFXpRcNGTArSqB/Xiq+5TA9nElXdWPkMK00WeuE2N7mRuybxZ4gDAfP9wTtBg/Q
 HxATjjpFNMBRWFOrwYa4CvDqe3nuS57IOuG4TvpxqAqY/5rn4lMhBc+oHt7GxYrPx6Qs
 jLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vNULVTyS8QRU64W9OGAFoDYvPCYVmncs1V+CJp7tdcw=;
 b=fdzWHLUIGiatdLtqxZyfQXb/VQUQkUYyx81kbzwMwifOhz9wTGwu1xuw1QKnEoDpEz
 AN1v37Mxhs8WrLVJ9mM96mCvbywg4hu1txfOhmaeHYf4UGHNjSei5N/KplQZvDYTFXqe
 Qv5nQ6/iAhlWNOh5Kzl4PVD8O1/NYqYLnJvyuQjmTn+1DjyDrVjFD1WnA8QTs8KwZ+/U
 qwjpInno7L2p8SZ2Yo+y5BUNgAYpuDwSXb7mPjHD+IT8AfOPIwS3faTMMr2sZZul32ns
 2Ggmwq9ESzAsl/mJGyx3oJYl3XGrO2Ho/MgavCZSo/ufsEblXlQHPaQ16jIvaE6siX2d
 wOVA==
X-Gm-Message-State: APjAAAVPVYfN0JYg7jK32PO5l/MA8zEjuvAHI/UDyeoj/ao4sINUZWHC
 76Dt1Sve+P5OxQHc8rXTC2TpEFepx0umEUiJ38rldg==
X-Google-Smtp-Source: APXvYqxDKwEIQMQv8w42wMlw9v1FhRMAGB7u7Fm9vBkmNyr1pF9j9r1YRRLra+Ck2cwd1WO/CGKxfgVbvSiW+0TwFr0=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20392190otk.232.1561985144341; 
 Mon, 01 Jul 2019 05:45:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190624153257.20163-1-anthony.perard@citrix.com>
In-Reply-To: <20190624153257.20163-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 13:45:33 +0100
Message-ID: <CAFEAcA9xH4DU45bRSbA267a3rvH96RLQ+jrjH9QeemXL-7bosA@mail.gmail.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
Subject: Re: [Qemu-devel] [PULL 0/8] xen queue 2019-06-24
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 24 Jun 2019 at 16:33, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20190624
>
> for you to fetch changes up to a3434a2d56aee3018f4a0f55c7e0f0cda11f3d9e:
>
>   xen: Import other xen/io/*.h (2019-06-24 10:42:30 +0100)
>
> ----------------------------------------------------------------
> Xen queue
>
> * Fix build
> * xen-block: support feature-large-sector-size
> * xen-block: Support IOThread polling for PV shared rings
> * Avoid usage of a VLA
> * Cleanup Xen headers usage
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

