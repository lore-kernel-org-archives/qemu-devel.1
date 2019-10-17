Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA07FA3735
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C5D62089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kD5wHnsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5D62089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL616-0003Wt-DG
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34881)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5iZ-0004xG-Sg
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5iY-0000Lk-M6
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5iY-0000LE-GB
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id v17so2507702wml.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7dP4GniHlhzsckLWI2mSbUrs50mZwdrxTXLkHD7zpW8=;
 b=kD5wHnsKkg0aKvZ7qp/CiHJSnlKOt4szHYDRvUIOlcOe2Y61Gw9Y+oHZGrR2fQV5FT
 CxtUaajjzHuG/shrWZBpol7nwHbbrgzGX1fR+r7XxTU1QXAtxCpInZUb3zWt9KNXKqGl
 zLVwEVpsQYrQ/7bhQJHq6Qn3aLQimTJ/JBjlNgx2tOc3FEvmw/Jzi4EI09IE8qMe/Q59
 24uXlNvVw2rtrslGL3Vt38JdmUOgAgW/Cl5kxdYcurhz5zxXqS0NL63NXag9oV2Ha8Uh
 56mktaGwIgM4io1P8F6DfQcMsZXHxaOhuTZItxmFC/z3FiYpiw8EqQRsmlnrrDQnwuNM
 WA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7dP4GniHlhzsckLWI2mSbUrs50mZwdrxTXLkHD7zpW8=;
 b=tr3F5huFGpnnag9DSC1dvcR0JYwfeJWNnRImj1GHm6u30x38lLTSlNtnqs+f2WUaSz
 D/FyXhmYKrxGwpSfilE/g8Orp/6Ex63tL9kSp8mR30uLWiaTb5hWblxZBAl2DIlmIQIS
 hx5s2wlQs0CyW/NSe6YAdL0VqbYeNq2tiiDXzg/oAcba1EvxNf1maeIQLhSMHWpGisPx
 o+A177P6DIvMwpiVRrWsNxMnl3nARg7q2lbwRAhVok9TE8mVZsksYXvOXR1OgriWe6B9
 NuWjzCzIkWsiPBoqoUk3mVkMFvStTptYVIeJ/6H1DfNNM4S3ltRxDL/LhuvUZlbPLECq
 CYTA==
X-Gm-Message-State: APjAAAWYO8zplv3/IXLwD9dRCK+1X9FGbGsWYC0tf4fuvib6jfaaZMhr
 DBIeWECH1I4IuawrOSTGEvWIpp4qyoPAiA==
X-Google-Smtp-Source: APXvYqzEapT5+wezBMFaD0kn1IqSrMd+x+CX0pWzwrxitCWGxdMGDFPPUa8q0bvRXsP9a2xIrfWzRQ==
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr3006060wmb.125.1571318485199; 
 Thu, 17 Oct 2019 06:21:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e9sm11543164wme.3.2019.10.17.06.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:21:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Convert ppc and microblaze devices to new ptimer API
Date: Thu, 17 Oct 2019 14:21:19 +0100
Message-Id: <20191017132122.4402-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset converts the devices used by ppc and microblaze
machines to the new ptimer API. (xilinx_timer is used by both,
hence putting both archs in the same patchset).

Currently the ptimer design uses a QEMU bottom-half as its mechanism
for calling back into the device model using the ptimer when the
timer has expired.  Unfortunately this design is fatally flawed,
because it means that there is a lag between the ptimer updating its
own state and the device callback function updating device state, and
guest accesses to device registers between the two can return
inconsistent device state. This was reported as a bug in a specific
timer device but it's a problem with the generic ptimer code:
https://bugs.launchpad.net/qemu/+bug/1777777

The updates to the individual ptimer devices are straightforward:
we need to add begin/commit calls around the various places that
modify the ptimer state, and use the new ptimer_init() function
to create the timer.

Testing has been 'make check' only, which obviously doesn't
exercise the devices very much, so more specific testing would
be appreciated. I'm happy for these patches to go in via the
ppc tree if you want, or I can collect them up with the other
ptimer-related changes I'm sending for other archs.

thanks
--PMM

Peter Maydell (3):
  hw/net/fsl_etsec/etsec.c: Switch to transaction-based ptimer API
  hw/timer/xilinx_timer.c: Switch to transaction-based ptimer API
  hw/dma/xilinx_axidma.c: Switch to transaction-based ptimer API

 hw/net/fsl_etsec/etsec.h |  1 -
 hw/dma/xilinx_axidma.c   |  9 +++++----
 hw/net/fsl_etsec/etsec.c |  9 +++++----
 hw/timer/xilinx_timer.c  | 13 ++++++++-----
 4 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.20.1


