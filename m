Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B3CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6442074B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 22:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBSPg/3k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6442074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jj8y1-00034l-9k
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 18:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uF-0005VS-52; Wed, 10 Jun 2020 18:09:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40538)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jj8uE-0008Gz-8O; Wed, 10 Jun 2020 18:09:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id h5so4050487wrc.7;
 Wed, 10 Jun 2020 15:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cQ0XmULokqQYlerien+fx8lZLjfG5XkUh0x69SNt4xM=;
 b=mBSPg/3kLHjzuQPAxyb1D3PCPLHnaPLGK0wm2XODn0uKvDqKUWBUICAbWdgDDxZFcc
 9P5JVElJpIm9/78RSbURfnecFL1Mh514K0jXRrrWrKSgFpZzNAMAI9us9qE/pII7D/6X
 NT/3y5pLtkcjFh94naYn+nWsNyDBceIXLI6VzhpkPetrSdJ7hofR0XzCcbFpWyoaAKqr
 WQ0bk7U6IF7Slo2mNlg8vKZ7F9R/CLY2fWBR9mhy0w8KXdagtIhxnaJE9QN+JYRsnFWS
 FqkWwMveFP7TKOd0LCQpn9eq+R8O/B2Z2saJLTT0v7fPez81JbVOB/Nx7/S7LN/UnIo6
 5OOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=cQ0XmULokqQYlerien+fx8lZLjfG5XkUh0x69SNt4xM=;
 b=DpBlre16VXfoM1qSY0dEsOYdzde3wJXllmBPmSZpYxmvyIJ5XpxXW5hN/PhkMWHl1x
 SPWqqzFdkWLyxzCpcCVYOcccM2Jx/OymWGOSjgEyV8HnYRiLYPIoN0ZAWCSWEO87Eh3h
 zKnIHDKawhxqBTMsVq9FWIxH3P0JMTFcAdC/vyIrCywpDO80nNHJLeWy8jJEY/I5td7v
 lEKkcovi+uJK+sOCK9NkJ1BoLFCFZb7FKgdbSQIC0kUkAdYMmAZGH0knEENhOyWxTpJp
 VCDo/2KnY5u7gt23mwCLJpXl1LFFF0bjRYbbVcuHtH5oZxjOI9neQuxV1WkPryiV7MrM
 mX3Q==
X-Gm-Message-State: AOAM531MrGe8mfsSEMbl+FAe7AuNslGgEmtvPBGv8MMj5MtTSylWOJpp
 Ubj7YL/GRj+g56uXtQFhzf138X7A
X-Google-Smtp-Source: ABdhPJyLcLWFRywgONF51gGWWKlqh3X1zAKvwORNcbYMcSa+65/tBODGJOItTnQG45NA8KQodYgIjg==
X-Received: by 2002:adf:e387:: with SMTP id e7mr5858831wrm.70.1591826935564;
 Wed, 10 Jun 2020 15:08:55 -0700 (PDT)
Received: from x1w.redhat.com (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id 40sm1819354wrc.15.2020.06.10.15.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2020 15:08:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/11] sh4: Update MAINTAINERS & trivial fixes
Date: Thu, 11 Jun 2020 00:08:42 +0200
Message-Id: <20200610220853.8558-1-f4bug@amsat.org>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series clarifies the situation of the SH4 TCG target
and peripherals.

Since v2:
- Keep Magnus as maintainer:
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg710320.html
Addressed Aleksandar review comments:
- Split the MAINTAINER patch in various atomic units
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg710947.html
- Add Yoshinori Sato as maintainer of SH4/RX peripherals
  https://www.mail-archive.com/qemu-devel@nongnu.org/msg711008.html

Aleksandar, I hope this is now fine for you and you can Ack the
changes. If this is still not perfect enough, I suggest you send
the perfect patches directly, because I can't spend more time on this.

Maybe patches 7 & 8 can go via acceptance-next queue, and
the rest via qemu-trivial@?

Regards,

Phil.

CI report:
https://travis-ci.org/github/philmd/qemu/builds/692828388

Supersedes: <20200608090142.6793-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (9):
  MAINTAINERS: Mark SH4 section orphan
  MAINTAINERS: Mark SH4 based Shix machine orphan
  MAINTAINERS: Demote SH4 based R2D machine to 'Odd Fixes'
  MAINTAINERS: Cover 'hw/sh4/sh_intc.h' with the R2D machine
  MAINTAINERS: Add an entry for common Renesas peripherals
  MAINTAINERS: Add Yoshinori Sato as maintainer of Renesas peripherals
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
 MAINTAINERS                            | 16 ++++++++++------
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 7 files changed, 49 insertions(+), 21 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

-- 
2.21.3


