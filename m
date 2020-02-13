Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA519C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A95C024671
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 23:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvBAGkpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95C024671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2O7w-0000dn-JB
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 18:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57309)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7F-00085H-7x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7E-0002qU-6d
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:53 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:32942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1j2O7E-0002oW-0u
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 18:41:52 -0500
Received: by mail-wm1-x344.google.com with SMTP id m10so816527wmc.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=l6BF2bpHuuwQpv2HXYm8cC+VmNIAPCQqoq0SYRLgUIM=;
 b=lvBAGkpNcPmA/9xR61ra9ZRVBEyUJvBhwgMFh20NuNGXOo3TC4Jzn+V0iBwH00caTW
 FM4HAR2rkU6UsFKFXr9vaZbcv4ZbjHNVILlzgdrUXqYp0IwHjNIQZzxKKNIKr+rS+qQ0
 f/7cExoimTe+idU+GLbk9Ay82rpvPwmcF7W5FsUCQchxZSHKCEAEDZBeX23POgblLtnc
 i4hGQyVctA2To3JGyA9X7y31CLSz/3ylnGZo8wgpjoLm7JEgegzumXNzTpbec/WJedsL
 lKfB2lkPkqeb+yNu02Kj/Q7mLE3Ei5HC0yk6+U7xeGaRFj0m+lals80YAp8OSur9aoH8
 iCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=l6BF2bpHuuwQpv2HXYm8cC+VmNIAPCQqoq0SYRLgUIM=;
 b=IsYIWRiCSum3pTete9V5PXmOYM4DxFjVpWEWcMqLWdGbTp29W2XL9ni83/h4nJCHLq
 1BlIKPKixgjfanuEHLiR3W+/9cNVU56WgEXOyTOK1NL1Qu/p5neXH/md9tE3TtVCeiA9
 NV3nuIQSYQwaxcTSoyE+er4A6oUQbPYe4gVV62+HWFs1A7GQ2XTq6whxlm3KxlKFI9OD
 Ek3WLuvx6S7D4Pr2RHVwCwqJoGrsKSxycyDz/fkcNL/F72VK/4jm/K9n8F4ON/caIoQe
 V0KVdkH+hFgQv2o6f9MNa0vwlCJcajEc15iiiKd6/1dKbEoaTiRHJx696Hp5XuBj+xIS
 xqQQ==
X-Gm-Message-State: APjAAAUR5FBQ3lunKZ5AQGWNkCi8npQgIFvyKQRFweLMJBa+SoMIohxL
 CDqqSlMJTMceqUcuI8ocvcA=
X-Google-Smtp-Source: APXvYqyL630ri/RkhSDebg/jKJ2JsHqadRxgMIR55qH948V8NVKsDl84lbxkDMF8zyaOSHxdcUq1qA==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr484483wmc.65.1581637310924;
 Thu, 13 Feb 2020 15:41:50 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id d4sm1521065wra.14.2020.02.13.15.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 15:41:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/4] hw/hppa/dino: Fix Coverity 1419393 & 1419394
Date: Fri, 14 Feb 2020 00:41:44 +0100
Message-Id: <20200213234148.8434-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Easy fix for the overrun reported by Coverity.

Last 2 patches are RFC because I haven't tested them,
I simply took note while reviewing the datasheet (I
also checked the errata).

Philippe Mathieu-Daudé (4):
  hw/hppa/dino: Add comments with register name
  hw/hppa/dino: Fix reg800_keep_bits[] overrun (CID 1419393 & 1419394)
  hw/hppa/dino: Fix bitmask for the PCIROR register
  hw/hppa/dino: Do not accept accesses to registers 0x818 and 0x82c

 hw/hppa/dino.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

-- 
2.21.1


