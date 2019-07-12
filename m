Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD099C742B3
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE33620863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 11:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnGaOLcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE33620863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hltaK-00024Z-HA
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 07:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47094)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZn-0000Gq-9M
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hltZl-0000K8-RP
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hltZl-0000HM-HI
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 07:18:53 -0400
Received: by mail-wr1-x441.google.com with SMTP id j8so5486463wrj.9
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 04:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uqYOHTYUI4sI7KyUoiaghNOTaeGhqGgpEsscEGMCnkM=;
 b=UnGaOLcQ5V3xHUWVrOzeSAuJu6sMmXxXimYGrIE9tKqYmMsHveB31HlHUQNWpfAMO/
 b/2LLMof09bvCVSCYvqJfIYTRq6dXPX+6Tlw9ApeHCY2Qa4siJu7NF6B28NVCeuMScwE
 pkySlv4PEP3JP1dvQinAljdKH7Zl0j8rj22wwND9qmqe2xANcWdJZU/qd+nqhxseNifa
 TUhfgkKdAP+cVa9O3r5QAjQSDt3l1LnzyH9lndHPoNUpk8bLx9oWC7y50nnb+CpbkQiP
 Oxnvbr63cjHCoXyY8U7tkfUT0E7EOHXKxgy98l2Gt62F62Zko+Cne71AyTIhA7QRVWgc
 8ZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uqYOHTYUI4sI7KyUoiaghNOTaeGhqGgpEsscEGMCnkM=;
 b=S5gzTHLOluKtrFsz6m2hXEVzBeLvzuogvW6PZ0x1sdd/RykVB8S0+ND8GsawBKhnNm
 AzlESOtIh4NGHchW6DX+XUoUpW8IOOcxcCQzcZMqf7GSF7/4HG60BGR0Ee3Iw0nHZkgp
 D7PiirbikdoWbnAFnVmetFbmkzPRJJY5X5UMd4TGrRH1CbtTqMP7oFFVE6INbf0aHnph
 UI1ikIm2ny8QnvFYCrmBuXtK+iHFOBsLI0aUUK5dr1jKR5UDFAXGS8KPvlOLgD6R7F8J
 sb1iHu9PKoMuOlydSJEyApVufvBuTS+YlimH5NK4jTrxt6z4AUSnxZrH2g4tf7KjMAIi
 4fbg==
X-Gm-Message-State: APjAAAWVz7cXobpeW1pLeAbd3ey/1Z1Ai3Ij45LAzRg/1BtTFkqnbvPo
 bQp+oIalmXLS5FK3IFB7EcUJzQ==
X-Google-Smtp-Source: APXvYqxC8765TIfv96ALzmN3jeO0Vclnshc33aNljG/yVWu4gZIKRzDAQ9sNGnDwlfa38STv/Yt24g==
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr11866916wrj.283.1562930331282; 
 Fri, 12 Jul 2019 04:18:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id v15sm7084872wru.61.2019.07.12.04.18.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 04:18:50 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 031ED1FF8C;
 Fri, 12 Jul 2019 12:18:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 12:18:43 +0100
Message-Id: <20190712111849.9006-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190712111849.9006-1-alex.bennee@linaro.org>
References: <20190712111849.9006-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH v1 1/7] tests/docker: add test-misc for
 building tools & docs
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
 qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add yet another test type so we cna quickly exercise the miscellaneous
build products of the build system under various docer configurations.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/test-misc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100755 tests/docker/test-misc

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


