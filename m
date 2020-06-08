Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C30C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:03:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 820DA206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M12w5rsD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820DA206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDgx-0006SK-Lg
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfA-0004kr-Rj; Mon, 08 Jun 2020 05:01:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33555)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfA-0004Hk-0d; Mon, 08 Jun 2020 05:01:48 -0400
Received: by mail-wr1-x442.google.com with SMTP id l11so16512839wru.0;
 Mon, 08 Jun 2020 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p4fj+vZlsEne7bVXCC/b05m9A2rDYGSKfEhInSqyp8s=;
 b=M12w5rsDCEDQxUlsm21y/wDFfNaqL4eEokSUam4FNfAKvg7wMAZYF9xSCpX0aqWo7/
 GdrI15KYJ3OuKgKLZ0g+KutFs5UARbWMdhrAifzA3vvRr3Wo8lYUOI6H3GgygHlL0JBg
 9+EnpKNOCS6f40ogsZjvpQh9VzbXU/wBsXCJ5Aj5QU8+MX1wGuH8l9Y04arFXInc2cSS
 JceWiqqFFAz0bthDxzpdbdeeh4Y7lxXIquQTK7K4z03FDgQoy4sSX9bWgvjz91qxBa2o
 Oohvy3+feYbmM6DZGwDj++7gBKhg5vejh5RfG3wAb97XF3M6T/hef67mA4etJiZI9D52
 bFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=p4fj+vZlsEne7bVXCC/b05m9A2rDYGSKfEhInSqyp8s=;
 b=AcQIVTafzcunUlR4WOI56JmfjBQ4LiiyYbpWZmtjD4keGldyiZxHshQ1DMvCzZxOC+
 xfLfRmPMRKHffO0SWlTf/TM8l84rkBf8cxZ0nkeHaLDD8ZUwe72i5RW7bkH/hr9UsI9R
 A2xmJrz0dn1jc4TvGHrV0EX0XUGtMm96/ZTlL6Ckk+p0oD6LfYWjA2W0RpfMJEcxgrF8
 0g7wzq/wvmtvoJg4mjP/jiKKni5TWbrXSlav4IyVhLgucNWnAHdEGOMwoVvmKVt1gC0c
 rICGLyav+QCQY6k+qLDwRz2080GZlp9aRMf8PVtTpm7Sza8BAKms3vOV1gNhNg7Fb3KJ
 qI5A==
X-Gm-Message-State: AOAM530aGOt4kCOVG7WGjq6/7x1z4EUiuadLznuzU5Ok2vAC2UiE701d
 JPnktcbDuRZ/garXUYgV2aB7YJTT
X-Google-Smtp-Source: ABdhPJziVOVbkkaSfFvvm2I4Lzp2+5sugmAgbrD+EvvTElZbb1QzZW/PfnmSmmjaO/APzHscyzU/1g==
X-Received: by 2002:a5d:538e:: with SMTP id d14mr22115929wrv.174.1591606905595; 
 Mon, 08 Jun 2020 02:01:45 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/8] sh4: Mark it orphan in MAINTAINERS & trivial fixes
Date: Mon,  8 Jun 2020 11:01:34 +0200
Message-Id: <20200608090142.6793-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This series clarifies the situation of the SH4 TCG target
and hardware (there are no active maintainers). From here
it should be easier for volunteers to step it.

Maybe patches 7 & 8 can go via acceptance-next queue, and
the rest via qemu-trivial@?

Regards,

Phil.

CI report:
https://travis-ci.org/github/philmd/qemu/builds/692828388

Supersedes: <20200530092306.26628-1-f4bug@amsat.org>
Supersedes: <20200601092057.10555-1-f4bug@amsat.org>

Philippe Mathieu-Daudé (6):
  MAINTAINERS: Mark SH4 hardware orphan
  MAINTAINERS: Mark SH4 based R2D & Shix machines orphan
  MAINTAINERS: Mark SH4 TCG target orphan
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
 MAINTAINERS                            | 18 ++++++++++++------
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 7 files changed, 51 insertions(+), 21 deletions(-)
 create mode 100644 include/hw/timer/tmu012.h

-- 
2.21.3


