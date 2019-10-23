Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E6FCA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:46:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797782064A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 16:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klp90sh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797782064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNJlv-0007Bx-S7
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 12:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIoz-0004bu-9Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNIox-0005Nf-3t
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:12 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831]:34105)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNIov-0005Ie-5U
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:45:10 -0400
Received: by mail-qt1-x831.google.com with SMTP id e14so13183956qto.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2019 08:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=arQzfT2uCXGahW1X98UJ8FBF2p5Ol8/LlVoSzE8ixjU=;
 b=klp90sh8LYUwoVCPUMwBlKI+H+Afh3RjJb1RGhqI+LjlZQ7AglVFEklrUfy2TlqjTF
 wVbX+eArDADv0ICyZcx2giCc1uOf83zkmTikeTy/I7f3dBu296Zxrq896ueojRnBlsAC
 RKx8iH0dD/LPnE6TnAD6o6jJz37ckknQpVaOw6zwcb2tfW+SLGYA5fhb6oyCov4JbDw+
 lh5GUsvSuhQmwsmbrOBbhH/IKGqH2qZ3hwtiSeN4jwCDluf5hE49Lmw4ogMzNuPtGZ46
 TPosF/3iwBBZEv9scAOz4u6LAxxMy3oYfUwld9WIvRnt5hHSMvUIVde2gx0arBtzKj5V
 DARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=arQzfT2uCXGahW1X98UJ8FBF2p5Ol8/LlVoSzE8ixjU=;
 b=S3ORpSOe7arRp3jH6cepG4q92SM2f2DFr1OsV/dN52y5rxZifRKnMkygUp9kQF3GsX
 46inGxFI7GLtxuF+pdi9KJ5ebtaEzmcwIEwsFf+VhHFG1nyHUC7T2iqsEmPyCXD0pBLF
 YfLtIoQ6pRgCMl0pSXxHEFHhiVOe43gU2Hqbu/6Owp9G1ZXUtgxoN7y59BM+HiJCYUoF
 4vB+S0vjYtxuO77z5iCcqHtsXo4gPNSgzE3W+xQ0DxumRUW1JrA6akFkwiS+5tgPSd+I
 FGmBNoGGCuCIEbZwq8hSEfr94rLS31oPs3SznT3ATJpXRIWMYWG5gksu71W4asSuZbS5
 sFiQ==
X-Gm-Message-State: APjAAAWhHSrDGofGzljCqM9ej0P1nWfQIlRCQQZZnfDiUXMIAZxQtTts
 CrZa6b3brXghKt0gIkHEE7Mx7FTDC9w=
X-Google-Smtp-Source: APXvYqzxbN6aZDZlEJMLq0+Hlytp2SLZw2cDsLx/iDL9oQLo6n0fVXF/M2YW7cyZHEaT4gvCA3mv5A==
X-Received: by 2002:ad4:4789:: with SMTP id z9mr1667209qvy.109.1571845507393; 
 Wed, 23 Oct 2019 08:45:07 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id o1sm2456272qtb.82.2019.10.23.08.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2019 08:45:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] exec: Improve code for TARGET_PAGE_BITS_VARY
Date: Wed, 23 Oct 2019 11:44:58 -0400
Message-Id: <20191023154505.30521-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::831
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Changes since v1:
  * Replace my patch for TARGET_PAGE_ALIGN with Wei Yang's.
  * Detect __attribute__((alias)) support in configure.
    If unsupported, as for Apple Xcode9, use preprocessor trickery.
    Passes travis build tests for xcode9.

Link for v1:
  https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg04519.html


r~


Richard Henderson (6):
  exec: Split out variable page size support to exec-vary.c
  configure: Detect compiler support for __attribute__((alias))
  exec: Use const alias for TARGET_PAGE_BITS_VARY
  exec: Restrict TARGET_PAGE_BITS_VARY assert to CONFIG_DEBUG_TCG
  exec: Promote TARGET_PAGE_MASK to target_long
  exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY

Wei Yang (1):
  cpu: use ROUND_UP() to define xxx_PAGE_ALIGN

 Makefile.target        |   2 +-
 include/exec/cpu-all.h |  33 +++++++++----
 include/qemu-common.h  |   6 +++
 exec-vary.c            | 102 +++++++++++++++++++++++++++++++++++++++++
 exec.c                 |  34 --------------
 configure              |  19 ++++++++
 6 files changed, 151 insertions(+), 45 deletions(-)
 create mode 100644 exec-vary.c

-- 
2.17.1


