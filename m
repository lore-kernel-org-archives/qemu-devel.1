Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0561DC83002
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:00:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38382082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhsMrOZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38382082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3BJ-0007aW-Sp
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38h-0004DW-FO
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38T-0001k3-7M
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:43 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:33569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38S-0001jZ-Oe; Thu, 30 Apr 2020 02:57:28 -0400
Received: by mail-wr1-x435.google.com with SMTP id c12so304939wrp.0;
 Wed, 29 Apr 2020 23:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cV+J3v4N+dhvAeB8wrTrTrwCO4mCVCMXktdc15geTl4=;
 b=NhsMrOZGHeCYtuMvWVEbl4CVSXPlISpZjRDthpCRZCxQ6XyEROqIendqZhs6w+iamy
 iqkTaEs5O6Uij19dYrsC8J3fECCSm4zgApvPQm93lZfsEAgDBYU+XjYPtL9nyxNgtGav
 rDFPNU/u16LzQY7y85FpTtE38FgFmjvM5OEZhdMyZvsHtNwZ90ick2lIz1U/YQqojDjY
 wlklCM9R90ZvgycXWgO8iyq3I173/AXE4izTnloC8DZ7xoVrODbjTTWi/XJA1XkJgTox
 ScHPJR2aOtr1DbVWOwYORmdno+quuYMeD5vwZhmb5ZeWq8KGibFNUnG8pAG4fBj2Qe52
 5gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=cV+J3v4N+dhvAeB8wrTrTrwCO4mCVCMXktdc15geTl4=;
 b=Nj4q9OZlMKBJa2iS2h/6PEqFG7aevedDY77ud678JONkU3zZ/zE4EKm31Gxe2lKxpg
 pg0Tdi/A3N/kl2OJv9YnAL1UQG793Wl8SU4ne4B0IOC6ZGRAe+QqG1feQprmeP23oNcN
 G1lhVR0+3/em1McAJHLAsXtiTVI7Ht2i3nZjaUqRgXDV00Ixd2JXG1kaMnHw2uIZCPC5
 5dSWknWpO8WoQ2T2+W0xPqCRGKsB7c8Kzp2o2wmaeGc4xQDpbjpf9Km870UImSOqdrlz
 wjxwQYESSTR1zus6NDxQanTFsKu+rScZTs4GdqdK1P3PAvHUUW8AekAhyy49faseJ7E7
 DPVw==
X-Gm-Message-State: AGi0PubgMuwaok9+Fp+tU1HLhiq8SsfvDilgK9woJyZkrB8FTnuaUwbm
 TkPpCItDA1pKqNNla1y7QsgcRiqqsI8=
X-Google-Smtp-Source: APiQypLdq276MTYnqvn0Yequ0L7XMDgwiBy6NoygaAGbUgvurzL7mKWj/9RGwrLlTtcGbQlhKzMOxQ==
X-Received: by 2002:a5d:4404:: with SMTP id z4mr2057382wrq.316.1588229846784; 
 Wed, 29 Apr 2020 23:57:26 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id k184sm11139730wmf.9.2020.04.29.23.57.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 23:57:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] scripts/qemugdb: Remove shebang header
Date: Thu, 30 Apr 2020 08:57:19 +0200
Message-Id: <20200430065720.10763-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200430065720.10763-1-f4bug@amsat.org>
References: <20200430065720.10763-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::435
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
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
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
2.21.1


