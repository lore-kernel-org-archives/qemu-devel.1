Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8DCC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:45:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5725E215A5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 06:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NN9+ABRv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5725E215A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaDYH-0000zo-Gp
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 01:45:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDXK-0000Z9-Dn
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron.zakhrov@gmail.com>) id 1iaDXJ-0001ox-3c
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:44:22 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:44886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aaron.zakhrov@gmail.com>)
 id 1iaDXC-0001kG-Ch
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 01:44:17 -0500
Received: by mail-pl1-x643.google.com with SMTP id az9so11153699plb.11
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 22:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=enD17KNqKFqdGR/HbKfm813rRuaLLnUpfCwauvTeL1c=;
 b=NN9+ABRvfHyUl5S2xa9aWZxGSwXBlHLq+QyE0K92yb/huolzx6jdAvFRI2uvcW6VSZ
 rjjn6qtvuHos00/cM4dCBySYDMBe50HfATbXhcn+DsDwsUfHdQEdyiQIRLVq7unIXgK3
 hek+tiGkYX2nGpnaUCk0d3fXhXcPXLFilA96OrbwSdLszOefZXhjgvuPcYEHqfpMvp+9
 gqslHqirmjbWhh+K4rP53eK1gu7vX86ohj6vK73wOLikL/XUTZhVXItFuGx7k3c7Ytlf
 VCkBB6Q8D3Bg1TrHI5661yXEYkzzVQOhYtvqBFTKAIyQz8Ul7Ri3jogMknix34PR7ScQ
 WAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=enD17KNqKFqdGR/HbKfm813rRuaLLnUpfCwauvTeL1c=;
 b=TEi4BC+4dHyjoIRSBWimmwnErJdGRERv1/YXUBHM7J6SBvN/RYgpO7p8HLj21o0AL6
 D48b85xtFdQ7QzPbJci4avKQPr1Ab1Bgb3byD9aTUF0FeTJ4b0f0qiV8LUpE4EOwoUIW
 GenYnSqFkmfUX5XXXn9KJIAw0VIkgVma6oUKX8wAXc/JU1kUmr1eVj8u1fnS2EF9tHj/
 Ea+nvOwBVJIq29MEz4wQaC7dSDreN9Km9lMF5ZpEEIY477D1oKVzLMG29JZJ21rIi8v/
 PrVosnQIInUmTLzsZhDw0Cx8G55JDm2MDNQYF39K8posqdO6Nxu8QPqO66p96ijgunlt
 jp/A==
X-Gm-Message-State: APjAAAX/jCmLy9W2YyAJsYs+78iS2mU91D3CpLONg0QcOvx3Up5BfGLX
 oVGnMjvbCQuqqNWMvOqfZcjXE4Trtu1hwg==
X-Google-Smtp-Source: APXvYqx7dXeVlMAXxpjhdEaGo3hsFvwJGJvYlda6bsdQ0XWW1A3nsmBHAeG22hGhFQwet51qGOlB4w==
X-Received: by 2002:a17:902:a707:: with SMTP id
 w7mr5868606plq.242.1574923451597; 
 Wed, 27 Nov 2019 22:44:11 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:73:186d:af79:94fc:29ef:77e6])
 by smtp.gmail.com with ESMTPSA id
 u7sm18366891pfh.84.2019.11.27.22.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2019 22:44:10 -0800 (PST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 0/1] ATI R300 emulated grpahics card V2
Date: Thu, 28 Nov 2019 12:13:49 +0530
Message-Id: <20191128064350.20727-1-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

This is the cleaned up patchset to my previous RFC patch set.
I could not reliably clean up my previous commits so I deleted my fork and started from scratch.
The patch looks like a lot of changes but most of it is just register definitions copied from the kernel radeon DRM tree.
What I have implemented so far seems to get a Linux guest to load the DRM and KMS drivers but it cannot find any CRTCs.
dmesg also says that while the GART is allocated, it cannot bind any pages to it.


Aaron Dominick (1):
  Cleaned up Work tree. The radeon_reg.h r300_reg.h and r500_reg.h files
    are from the kernel drm tree. They contain the register definitions
    for the R300 GPU

 hw/display/Kconfig       |    9 +-
 hw/display/Makefile.objs |    2 +
 hw/display/r100d.h       |  869 +++++++++
 hw/display/r300.c        | 1087 +++++++++++
 hw/display/r300.h        |  269 +++
 hw/display/r300_2d.c     |  190 ++
 hw/display/r300_debug.c  |  272 +++
 hw/display/r300_reg.h    | 1789 ++++++++++++++++++
 hw/display/r300d.h       |  343 ++++
 hw/display/r500_reg.h    |  801 ++++++++
 hw/display/radeon_reg.h  | 3725 ++++++++++++++++++++++++++++++++++++++
 11 files changed, 9355 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/r100d.h
 create mode 100644 hw/display/r300.c
 create mode 100644 hw/display/r300.h
 create mode 100644 hw/display/r300_2d.c
 create mode 100644 hw/display/r300_debug.c
 create mode 100644 hw/display/r300_reg.h
 create mode 100644 hw/display/r300d.h
 create mode 100644 hw/display/r500_reg.h
 create mode 100644 hw/display/radeon_reg.h

--
2.24.0

