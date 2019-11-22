Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7D7C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF13520708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCkuuBWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF13520708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY723-0001vq-0O
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:23:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71J-00015e-5d
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iY71H-0003fD-Vo
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:36 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39978)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iY71H-0003eb-ON
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:22:35 -0500
Received: by mail-wm1-x342.google.com with SMTP id y5so7151384wmi.5
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CzWNO7K/ljW1elM86JRcqw4y3nvCOZvcvB5LDCL29RY=;
 b=RCkuuBWzBYlhCbhrirUermDjbg+Ro4pyL3s5H137Z9Mfvd7qpR79OqaQ/O8yHjr5UA
 2cThZwSc/jZ66yxA29VgJRLzYhnPmPuHX/Ed42n7rifEmYt8X7F4EH4+zfja5yCpvlHG
 Gs34lJ/9WD3L+jxHhRIK25GmkbU14jyvgd8zEgNzD6DixVCZb/ImUM0Gzl0WrN6/xBc0
 pCWGPIvPTMQeKf7MXWUe3+bkhpynPR+6bLXDC0NHxpih7XbA7KiTpxkoTL3USTRQIHIH
 O4HYOKoF5NITs9XyZS53JTIu10qA2m90Hyx2U8lc0pp4Y6bcVHQE1Zq5aWZnDZZwWkqz
 4S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CzWNO7K/ljW1elM86JRcqw4y3nvCOZvcvB5LDCL29RY=;
 b=Me73SO+Q1PsbrXRU8KYfFiV6RwIO4bGzdMJryIlO8k09Pz4rLLSz0wX5nBwAhG/jxs
 yHEDAk+nt4qzfZdSUWsac5Kp3RaiFfNPdRBtLZMbi6bdJuqQZnyTkMsADEg+CzBgBIPS
 7TmlectmHy4YAAYrwpKK+retrD7UD5tcIrxjr0khdSovLLrUwEIklYTPmXxAQ5Dx4XDG
 72DuAS/uHlPHRXYETptXQyHfjn2rkqpjcifeRvOzstl45fbH6gNBSJr0dTr+SILH+o2G
 zIMeMF+t3aO3RSn1cJ0rGtitZ1SknNn3HaIXer++9rWIbkcjumZ8gC3yOju5fBq+7I3A
 GWYg==
X-Gm-Message-State: APjAAAWTLxbx7QaqJt9zgPlFCHm6Utz+LgtWa4M/56kTu1wlayPDmRDr
 4iFFGjG8FUp7Xv6EBz8dE2A3PA==
X-Google-Smtp-Source: APXvYqyTfaPloWSqMbrX85yr8ZCzAAnaWZFDCcaRERMUJJbw0gzzJTVUjQD9f0OZ6k5OlMYd/3CSHQ==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr8885894wmh.157.1574421753929; 
 Fri, 22 Nov 2019 03:22:33 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t12sm6897595wrx.93.2019.11.22.03.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 03:22:32 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 080891FF87;
 Fri, 22 Nov 2019 11:22:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for 4.2 v1 0/3] some tests/vm fixes
Date: Fri, 22 Nov 2019 11:22:28 +0000
Message-Id: <20191122112231.18431-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

These fixes are aimed at improving the "vm-build-all" make target. The
first two are fairly non contriversal tweaks to the base
configuration. The final one just elides over the fact that the tests
are broken on 32bit 16.04 - but I think it may be a distro problem as
I've failed to replicate on my other 32 bit OSes. If anyone else wants
to figure out whats going on then be my guest ;-)

Alex Bennée (3):
  tests/vm/centos: fix centos build target
  tests/vm/ubuntu: include language pack to silence locale warnings
  tests/vm/ubuntu: update i386 image to 18.04

 tests/vm/centos      | 2 +-
 tests/vm/ubuntu.i386 | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.20.1


