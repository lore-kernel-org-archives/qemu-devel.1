Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CFC282DD
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474A620721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 15:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pv68MjPm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A620721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipwV1-0001I3-PB
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 10:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwQZ-0004Jy-7t
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ipwQX-0004X9-Vc
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:22 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:36926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ipwQX-0004TB-Nt
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 10:42:21 -0500
Received: by mail-ot1-x330.google.com with SMTP id k14so2357694otn.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=DS5jOzktvvDYaxzme9mKbiZMM8VPHyPW82dXGwHiW9c=;
 b=Pv68MjPm7wg+68pwItyNAwrgIXiDpU8lcsGjHwQBJ6zY5YKgbRuZX/UdAdoCPk1uAY
 f/OxVVRPaUPGzJ7LNiXpFVT+VMOM2tWBnTKnYqrZqiCXI4JgFf+M5XH76P8IbSjhFqJb
 woOVxgFiND83LUPYVg8FCCETxdHaat/c5Y8sDP1n9EB5htJfCyGKF4pa5HiJG7IfR5mn
 F3HJ9wzR3OSBpQ6euuyc0HuBGGm+8945aCBYBuAT18fK6Ozpy9cftea5zfW3haI6Y9W5
 DTpHUxYUrUQu1G8u7fRyk4szg15Gsx18qpn4f1WmFALGifeKB3F/2/+pJ5qhDLl72vnz
 2sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=DS5jOzktvvDYaxzme9mKbiZMM8VPHyPW82dXGwHiW9c=;
 b=jsHepaI2JV1FHtuPtNPENimr4WOS/2S4F7aAegvqVy2wBgdhs/mVp/skbXg+LX2T0C
 4Td9XyDsgBkCBhDsTnFgSzVWbLtIOM+BwOlVu4efcDCIY3wG+kwHgX2vz5q/zxLQLRed
 pHtt0AZJqRB3R1RS3nuv2anA4XYq9XzFdOD4NmGDoV0A14FUhRB4gKyPmzJoYzj7o8sN
 mYRd+WGp9+zYeblaLmQ5j1OWxZ6eucXKnf+MrDdyJqqCgR4dZl1Zl1CvNGU3eM4rxy1R
 b0x6+1JlCARPgZiqwSGRgzj+47yDVQ//MnMaq1jCwx84fzxuntDpt62DMLaNQdyH5/O4
 uwFg==
X-Gm-Message-State: APjAAAVMpuUxRZrNXNOSgE7LYDM9M+xD03Ajw0uQ5sayDTOTMcmNjmRq
 islaiJ7ck2RR/TPQfiS7noy0Vka3zO9W3G3UGYqtc3SJc8o=
X-Google-Smtp-Source: APXvYqx3VAYFxkU7SjN39b5kGgwahobOFeHt8n11FhJBmUbbaOEoEkJTdcUiqLeYvhKKZWNsYtTGsZ9mN4oqPdCVPRI=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr3152781otd.91.1578670940562; 
 Fri, 10 Jan 2020 07:42:20 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2020 15:42:09 +0000
Message-ID: <CAFEAcA-dz7f_12QU1_YSkfuKKEk9YYcq8jwLRu90Z85UZ+YKRQ@mail.gmail.com>
Subject: xlnx-zynqmp doesn't set psci-conduit on the R-cores
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi; somebody pointed out to me that hw/arm/xlnx-zynqmp.c only
sets the psci-conduit on the A-profile cores, not the R. This
means you can't set the boot-cpu to an R-profile core and
use PSCI to wake up the other one. Is the omission deliberate?

thanks
-- PMM

