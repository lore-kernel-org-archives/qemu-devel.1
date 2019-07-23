Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AC9C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A6322400
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MEZZm5RD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A6322400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsAW-0000zB-9t
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37761)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9a-0005gc-QR
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9Y-0007LG-Ng
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:18 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:35932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9Y-0007KG-Ef
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id g67so33921453wme.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=B9rJQfX4dfIeOXpLw4etOZ1Y3ebTwSMBV28SJO0g0Qs=;
 b=MEZZm5RDAZYwHHIwchdgk/m8qQZeNYT2vZrG2TE+cizCLVHLZQqih6dKNXdhKaGTae
 pkG1naK6ALClWdNon2zW80yjMFjxbcIxJezPdSAK324E8ePNGzXyt1ffTrizNRFzU2q4
 gmVPUiBEHoEYoNdkizI+wGgb3SIcSs5tuW1lZUHSDQTU82FzkUzXkusw0gHlv+H4vuNL
 DPSgU9YkoaoonU79YirIAvpgWQawVHOmgKGGgCLStRx6RW9wsiBkANhAldoWv6smMZS+
 H1hG+xUlaeuLSlVkNBt204494uVflljEwJhMuoMathf0HhXgpWwwZKnPDc6n9yfChn+t
 h5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=B9rJQfX4dfIeOXpLw4etOZ1Y3ebTwSMBV28SJO0g0Qs=;
 b=tfd/AXXmFpAb2i3dd44vUnvaieaTrmrW5MzQ8UwAakGRK9S2RbbJXCLQD8chyEYn5N
 JeJA9vIhaCnNyTXFBBfRWobNqu2Phw9nwDHoQjNek7iDIuRDwGwIhIiJMzxWJigMUOHR
 ZCzwluhMt84sCQXi+ypd8nOGTOjT1fpgRYNoyIE6CdpaxAhymQPkIPJRP1ETym01BIUL
 JTB/qCZ5Y5vZeIlz+iesIEtR7ixwM6jFGN8T6yXH2mD1XZF1Y5/VPXWVYsD0m+c40wpV
 4NYlHSqW2FhEY2gsFrJ3XrVHhU0tsT4qj5nhIgH2D0XyimK9YAMTB7Lx+AEZSX/ujAIu
 aYDg==
X-Gm-Message-State: APjAAAVME5iqOYlTjqpLZQFqGrBqf0h7fYHSbV6beIHpXvHJ0OPCwKH2
 UaWIIpHsmoHclAEsHtRB+chDDw==
X-Google-Smtp-Source: APXvYqzfkJOPu9J/GFCihxyu6sn2+kSNWlW6QhkXibgDCbfTQBH/RmlgVMDKfxf3Gf6piLpLN5rZXQ==
X-Received: by 2002:a1c:b155:: with SMTP id a82mr18652324wmf.35.1563878175256; 
 Tue, 23 Jul 2019 03:36:15 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u13sm50534835wrq.62.2019.07.23.03.36.12
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:14 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8657C1FF8F;
 Tue, 23 Jul 2019 11:36:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:35:51 +0100
Message-Id: <20190723103612.5600-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
Subject: [Qemu-devel] [PULL 02/23] tests/docker: add test-misc for building
 tools & docs
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add yet another test type so we cna quickly exercise the miscellaneous
build products of the build system under various docer configurations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/docker/test-misc b/tests/docker/test-misc
new file mode 100755
index 00000000000..d480afedca7
--- /dev/null
+++ b/tests/docker/test-misc
@@ -0,0 +1,22 @@
+#!/bin/bash -e
+#
+# Build the miscellaneous components
+#
+# Copyright (c) 2019 Linaro Ltd.
+#
+# Authors:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+. common.rc
+
+cd "$BUILD_DIR"
+
+# build everything else but QEMU
+configure_qemu --disable-user --disable-system --enable-docs --enable-tools
+build_qemu
+install_qemu
-- 
2.20.1


