Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3BDC54E4B
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:08:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641CF2082E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 07:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIRZyz3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641CF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYP1N-0006AX-Jk
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 03:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP06-0004MC-Ui; Tue, 12 May 2020 03:06:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:46299)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jYP05-00084h-9A; Tue, 12 May 2020 03:06:50 -0400
Received: by mail-ej1-x629.google.com with SMTP id e2so10096108eje.13;
 Tue, 12 May 2020 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1gSc7LFPYOnREZ6sq9YNoDIjd0HkNcI53RD4ReDPMo8=;
 b=TIRZyz3tTxVFXmISR7RCMUHxDLoa7+Ow0cBZFioDIexcDxsFhsE9A+XAyJ2cDDyfmX
 Z4ZBVzdVZGVqqBa4UGHTqCozVdIh68PfyyK1mwP+F5nV6zsPQpIDT8CAUEWLLrkPvqFV
 fXsWfIfjH0S6cvgp9vZ1eBZ3ADW3+zdZhi3IqKrEHqTYbxT82ZPi863PdHJunZZuZXXe
 E/iY/xghLYD8yYO3b1UxxK2qAmQ/20L6/PaBOLJ3KM6aDouv96cOo00T19fNxPz42/D8
 PpGWjRbS/711R5N7l1dcoCZQlFGk7MSewaCiubDjj1KGtoS0tocGJhw/Xyw1KOFue0/q
 aqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=1gSc7LFPYOnREZ6sq9YNoDIjd0HkNcI53RD4ReDPMo8=;
 b=p9ejQ/Mc4oTV283F+aNPULTbDZ1Uj5iaUViuVQ+Z6ZU5ODSS+U8+PNi4llcf7kGXKd
 8j7ivuZS+pPTl7NuPm5E9uJG3z+tK9Nmusn1TKvKbg+C6LE0paesSezrqyC60WFzQTno
 DIWJNuW+9LtDUS3oICATzOX+mKJMpG39oNFwcu4nPJu0iIWNEt08PYyEorPXXU0fX16J
 GusO8Aq14Ex4RDz8O8XTfB1Ctn6cU3T8/g4Huwsgg7GHMEnLQfKLj7+MjsOmfQJByoZi
 4Ftv34jzbiCwuus4bOTlRF/V3kZuasidN+InV9IcduBDT0LRgRxIdnKnz5x2btG7cWZ+
 jt+w==
X-Gm-Message-State: AGi0PuaOkeBHZMshlpzQc4NI38xRlWmD9FNzJvmJK/rW8iTm47MylViG
 gaOO6i3Qa8tbChXpWoBdeidvCUBTcyo=
X-Google-Smtp-Source: APiQypI+dAkxkeAi0TLFotqw8z/vyi/JFS99rY/RWpKbh2xQ7G3w4IZ8lIbLC3LY+cvGAaVcwqDGxw==
X-Received: by 2002:a17:906:3607:: with SMTP id
 q7mr15846126ejb.313.1589267206729; 
 Tue, 12 May 2020 00:06:46 -0700 (PDT)
Received: from localhost.localdomain (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id ch8sm247345ejb.53.2020.05.12.00.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 00:06:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] scripts/qemugdb: Remove shebang header
Date: Tue, 12 May 2020 09:06:41 +0200
Message-Id: <20200512070642.23986-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200512070642.23986-1-f4bug@amsat.org>
References: <20200512070642.23986-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x629.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These scripts are loaded as plugin by GDB (and they don't
have any __main__ entry point). Remove the shebang header.

Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemugdb/__init__.py  | 3 +--
 scripts/qemugdb/aio.py       | 3 +--
 scripts/qemugdb/coroutine.py | 3 +--
 scripts/qemugdb/mtree.py     | 4 +---
 scripts/qemugdb/tcg.py       | 1 -
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/scripts/qemugdb/__init__.py b/scripts/qemugdb/__init__.py
index 969f552b26..da8ff612e5 100644
--- a/scripts/qemugdb/__init__.py
+++ b/scripts/qemugdb/__init__.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright (c) 2015 Linaro Ltd
diff --git a/scripts/qemugdb/aio.py b/scripts/qemugdb/aio.py
index 2ba00c4444..d7c1ba0c28 100644
--- a/scripts/qemugdb/aio.py
+++ b/scripts/qemugdb/aio.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support: aio/iohandler debug
 #
 # Copyright (c) 2015 Red Hat, Inc.
diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 41e079d0e2..db61389022 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
diff --git a/scripts/qemugdb/mtree.py b/scripts/qemugdb/mtree.py
index 3030a60d3f..8fe42c3c12 100644
--- a/scripts/qemugdb/mtree.py
+++ b/scripts/qemugdb/mtree.py
@@ -1,5 +1,4 @@
-#!/usr/bin/python
-
+#
 # GDB debugging support
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
@@ -84,4 +83,3 @@ def print_item(self, ptr, offset = gdb.Value(0), level = 0):
         while not isnull(subregion):
             self.print_item(subregion, addr, level)
             subregion = subregion['subregions_link']['tqe_next']
-
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 18880fc9a7..16c03c06a9 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -1,4 +1,3 @@
-#!/usr/bin/python
 # -*- coding: utf-8 -*-
 #
 # GDB debugging support, TCG status
-- 
2.21.3


