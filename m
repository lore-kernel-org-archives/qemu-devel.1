Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C1CC48BD9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3022083B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 12:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AabZQGmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3022083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgTsF-0000tt-V2
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53723)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpT-0006ul-Vv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1hgTpS-0003gR-1C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:43 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33302)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1hgTpR-0003V3-OC
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 08:48:41 -0400
Received: by mail-oi1-x243.google.com with SMTP id u15so1343017oiv.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=PxyitUFXInVkUJpFcUgL7Sje5P9j9XglyfCCVSMSEUY=;
 b=AabZQGmzOUGIAbs3DmX3I/Yj16l/jb2StAnF76H7OQhi9h0JJWcAfDA7xPdnaDm3J2
 mnVERIBsf1rkOWx2DePn2iBUgUDszEQyCCu/ts2pVw50j0peL3c6BTIWEmncD1jPSosq
 0tpGL0J/KJ0jPnwjKUeq0i9dD+ru2i94BQtr6F8AX3gPLFbvpd5GK+5bzZglO1YJ601P
 CKyYkUY2sIOjoybcvZI9N2d0PqKD2Obf9jTrNeHC3rQFqcULOgWyMTE/kEbTCLn5lHZ6
 dVM+PRKR+D4EPrf5QbUQyQOIZXncFp0OpONPY+uTES9luPHNPhOkZUUIm4m788JlYKK5
 z0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=PxyitUFXInVkUJpFcUgL7Sje5P9j9XglyfCCVSMSEUY=;
 b=qqOeQ3Kj+bXhPAEofSulXHtbDnIhmNGkUHCBRbR3ems2QM5G+UHze6Fwo0QzJyyhKz
 N8sWsuEnlZM0szTcqlsmNxE2pfufcFvUlAmNVEsconqroTOEN9dvV5dvQsjOW6CABOZ+
 QO+dEUu0pt9N3xibPBWA+BS1eUyxlNJFAG11eRolLz0mMHOs+orIAxzCvM6Zo3Ty+Aih
 VVLmM8v4vAza8sTB97RrBbyMqbV/0MvidRNejsmh+ZaKV7agNLwd+fNsvwiVvvdOk6zm
 2H5v7Bkg5YJQPeRgJokDKnr+KJoWrh4/JsdMNMAu3KwZQqYGTD3zhG/df1hFaJ4wOVXD
 x5DA==
X-Gm-Message-State: APjAAAVMTUVttxTv3rgcsMz92001eP1AuWV47TwTYEUGA7/B84Ksogj0
 lCCuunKZUALXaWf7DFhMMdBpd6A=
X-Google-Smtp-Source: APXvYqyEoMlik65jY+bbV1nGnPXjLH8e/gsIW4uRYFUJ8qoWO9B9+LfFVnr8clEetnI/JhzVZyxOkg==
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2100933oij.98.1561639706016; 
 Thu, 27 Jun 2019 05:48:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id q20sm640724otm.32.2019.06.27.05.48.25
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 27 Jun 2019 05:48:25 -0700 (PDT)
Received: from t430.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8437:2822:278a:bbee])
 by serve.minyard.net (Postfix) with ESMTPA id 8AE791805A6;
 Thu, 27 Jun 2019 12:48:24 +0000 (UTC)
Received: by t430.minyard.net (Postfix, from userid 1000)
 id 0B8BD302322; Thu, 27 Jun 2019 07:48:23 -0500 (CDT)
From: minyard@acm.org
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jun 2019 07:48:13 -0500
Message-Id: <20190627124815.29536-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: [Qemu-devel] [PULL 0/2] Add a UUID device property to IPMI
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

I believe we are not in softfreeze yet, and this is the only real
fix I have for IPMI at the moment.

This was posted Nov 2018 with little commentary.

The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:

  Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)

are available in the Git repository at:

  git://github.com/cminyard/qemu.git tags/ipmi-for-release-20190627

for you to fetch changes up to bddef5881d0c935a5d9d8e15f822d9d700666ae6:

  ipmi: Add a UUID device property (2019-06-26 15:31:33 -0500)

----------------------------------------------------------------
Add a UUID device property to IPMI

This is fairly important for two reasons:

* It allows a BMC to be created with no UUID, returning an error, which
  is the behavior of many BMCs in the world.
* It lets the user set the UUID to a fixed value.

Some software using IPMI will get confused if it gets different UUIDs
from what should be the same device, which is what happens now if qemu
quits and restarts.

----------------------------------------------------------------
Corey Minyard (2):
      qdev: Add a no default uuid property
      ipmi: Add a UUID device property

 hw/ipmi/ipmi_bmc_sim.c       | 22 ++++++++++++++--------
 include/hw/qdev-properties.h |  7 +++++++
 qemu-options.hx              | 10 +++++++---
 3 files changed, 28 insertions(+), 11 deletions(-)



