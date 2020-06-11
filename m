Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2A3C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0C3207ED
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 11:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMrB6O22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0C3207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLf4-0005fs-GZ
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 07:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjLcM-0001rQ-9s; Thu, 11 Jun 2020 07:43:34 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35293)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jjLcL-0001ox-9W; Thu, 11 Jun 2020 07:43:33 -0400
Received: by mail-wr1-x441.google.com with SMTP id x14so5823956wrp.2;
 Thu, 11 Jun 2020 04:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cLk4hbroATYyQTs52uLWncPcCLvLtPOqAZ/aivyCI4k=;
 b=GMrB6O22/EHOOgasKeSfMqmBSzYjq3xvmnv34PUcZbTdwjRXWEjDRh1zaWfC8G3kHC
 +YG4v1BYYwuvJ2yGm0CFJYlPFHLhxE6YxVaJzwwPoFWtBFrA8d6cdmQVUoDHpqlH5Snt
 Dyf+j1QkMqoGAbvw4qfbOoE2pMdlcesKu9WqclawZnmlpOwvmrTKBKv/12SazODRvfIu
 4dAU5M/XUKG06jaaqtmbGuhehCdVmPNYO1ohI0T5Ij06/+D8L0sO3KyZE0GAnBUTsLmc
 Cs+UQYQSatwzHRzDiDEUZ4hxfOU8dWwTShq4Uu/qJZTAOJuQKN9esM5QATGTLOgEKN1s
 LFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=cLk4hbroATYyQTs52uLWncPcCLvLtPOqAZ/aivyCI4k=;
 b=lOm6OStVBZM1XrtSJ5YrArZmSYl+IN6YX8A+Sj3zVf0GfFwbLPF7QPCHIO9mPL3DJC
 Si7xDMC94VZ/r0WkWeKAODY8INsRVgIqTWL0i7RN2hc7tV5GchTtW1xXCHBe7rPZintA
 gNotgAVNbVWRWkjaF31/xCDGaXuns90rRA3cC+4jRgx/jZoqfoWk/9JGTzDjnKyS3mLl
 8o46ynFoqMonbwF2+HWJQL1cz1A99J0SjVRQV5euiTJdLhc4SXPfbs1eyYFBqQfuE2um
 SzZgNvoB02tOM70c4kZsL5Yei/fbuvH/+3ilq29iun9cyG9Bx3NQKRYp+D89QONlqOQH
 Pg8A==
X-Gm-Message-State: AOAM533Fy2exNHrgzsqsN5R1XYcESjY+qpooz73QzgoxIW3fOw2A4XfB
 UOsJKE9rUPRb5zF+fqLDRWL846WQ
X-Google-Smtp-Source: ABdhPJyx5dmroxKiV///7TeGTUb4PUvwNxuyzuU4KTZDjjrtwlwztNnHbQm9l1m7NQ+OHulYS4FOEA==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr9042917wrq.310.1591875800375; 
 Thu, 11 Jun 2020 04:43:20 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h29sm4832863wrc.78.2020.06.11.04.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2020 04:43:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 0/7] sh4: Add 'Renesas peripherals' entry in MAINTAINERS +
 trivial fixes
Date: Thu, 11 Jun 2020 13:43:10 +0200
Message-Id: <20200611114317.13044-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series include trivial fixes, and add a new 'Renesas
peripherals' section in MAINTAINERS.

Since v3:
- Rebased on Aleksandar's "Resolution of sh4 maintainership"
  https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg03183.html

Since v2:
- Keep Magnus as maintainer:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg710320.html
Addressed Aleksandar review comments:
- Split the MAINTAINER patch in various atomic units
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg710947.html
- Add Yoshinori Sato as maintainer of SH4/RX peripherals
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg711008.html

Maybe patches 6 & 7 can go via acceptance-next queue, and
the rest via qemu-trivial@?

Regards,

Phil.

CI report:
https://travis-ci.org/github/philmd/qemu/builds/692828388

Supersedes: <20200610220853.8558-1-f4bug@amsat.org>
Based-on: <20200611095316.10133-1-aleksandar.qemu.devel@gmail.com>

Philippe Mathieu-Daudé (5):
  MAINTAINERS: Cover 'hw/sh4/sh_intc.h' with the R2D machine
  MAINTAINERS: Add an entry for common Renesas peripherals
  hw/sh4: Use MemoryRegion typedef
  hw/sh4: Extract timer definitions to 'hw/timer/tmu012.h'
  hw/timer/sh_timer: Remove unused 'qemu/timer.h' include

Thomas Huth (2):
  tests/acceptance: Add boot tests for sh4 QEMU advent calendar image
  .travis.yml: Test SH4 QEMU advent calendar image

 include/hw/sh4/sh.h                    | 12 +-----------
 include/hw/timer/tmu012.h              | 23 +++++++++++++++++++++++
 hw/sh4/sh7750.c                        |  1 +
 hw/timer/sh_timer.c                    |  3 ++-
 .travis.yml                            |  2 +-
 MAINTAINERS                            | 10 +++++++++-
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 7 files changed, 48 insertions(+), 16 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

-- 
2.21.3


