Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9DDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6BFF206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 15:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MA+LsCmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BFF206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAE0G-0008Mc-1h
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 11:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADzM-00071l-97
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:02:24 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b]:33594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADzK-0008Kn-FV
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 11:02:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id w14so7857801eds.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9t7GtwhJLZ1cQK6x7kDcPVNoaIrdfiWDtbK0fVwkdN0=;
 b=MA+LsCmN/gKXJVFtoNOS4ExA1194VZTcSeYcCAARJBjCyPgKsba68athXK6WLhagRy
 ZnhGti2GV4GldmMWolwkscXLnIsZEVIoGNtlFG7NJHNUGZiUKwXNA2Gnaqj3IV1LxTV+
 ln/rlv+m4VZLyIFebcfuTssNvPbmtbblmxRwkWyWQB9a10FvcNbCfgf6UgD7EhgByPub
 uelZVzkRGC1PpwCrZBVJLxlE7oU4dqcgesYfu8lu8wLDrGQnqVrdiryoO2RYV5Eb2lmu
 /sc4BdGXk0aW+1GQAt9L9arQgLTu/fZjDpE1LAN+F1WYOm8lKJRYJdrcHbyVqAxDmn5Z
 s+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9t7GtwhJLZ1cQK6x7kDcPVNoaIrdfiWDtbK0fVwkdN0=;
 b=TeCjNi3TO1EFA30fX9cewqrBOo1ULK96MYcyHxLLwx+9W9OBnKGkXtSFybtNfXdX8x
 ZJCyiMyACmX/4Kjn4T9n2YGNRsmQtcDNYN8l8ilJrCDemfUcPpqsslyYBCPMIlFEdrMi
 tXp+CX7GTDSpdMZfuGV113yz+6np4fe3rPrDDayNC0TcaHq5k3yd2z1iGt706CMF6l5N
 pT8G8XY1JUY8XCIZpLpGysXqlmYPiirouO119yp+RQ6+qJEYduzJDr/cgPYNHUmuScAO
 SJQBPm4S1DFEY7jRDwyRwI1eVYuriUWLozmuIBIPDmxzDrPz89vnzyAypRYWL4EA5UJn
 aWYQ==
X-Gm-Message-State: AOAM533sBFbU3QjFm6Rv7BPEjLrDVWTrYqGhfZgmyDr0QyR+mk08ahGP
 /Sq76M2jz0MrckF9cQ8Yq+IYLcBxt5RG0GSZPoToAPhqmgf1NA==
X-Google-Smtp-Source: ABdhPJyZAX0G7eRJPhg2zaMS7IiSRZJrqyMPBqEV/vXhOmPCPluEyq5I1hwsBxLCbm/Lx4cia+jHLojkXwWnVlM2udw=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr5957941edy.52.1598281341076;
 Mon, 24 Aug 2020 08:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200806123858.30058-1-f4bug@amsat.org>
In-Reply-To: <20200806123858.30058-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 16:02:10 +0100
Message-ID: <CAFEAcA975DsoqsPk+83B=ztf=73LaRYCR3nfVww51r=-0RcSBA@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/3] hw/clock: Only propagate clock changes if the
 clock is changed
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 6 Aug 2020 at 13:39, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Trivial patches for the clock API:
> - remove unused code
> - only propagate clock update when a clock change
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   hw/clock: Remove unused clock_init*() functions
>   hw/clock: Let clock_set() return boolean value
>   hw/clock: Only propagate clock changes if the clock is changed
>
>  include/hw/clock.h | 30 ++++++++++--------------------
>  hw/core/clock.c    |  7 ++++++-
>  2 files changed, 16 insertions(+), 21 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

