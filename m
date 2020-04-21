Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDB5C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA985206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6Dm2Yqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA985206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpRW-0007WI-KU
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ7-0005hq-Pe
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ7-0004au-7H
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:23 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:38484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ6-0004Y7-RT; Tue, 21 Apr 2020 05:42:22 -0400
Received: by mail-wr1-x42a.google.com with SMTP id k11so15711331wrp.5;
 Tue, 21 Apr 2020 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=o7iRMBDTE63C8dAXeaFq6vizBKPMbrYiwVf3GYE2Y2Y=;
 b=q6Dm2Yqpe/1yM04+F8OMPLKQbiScidcnIAohx68k27g972levFkwcOLILTuNEgQX9V
 F2rb6Uapn4RMrCHcCyfozcsebL0e0heTNyDbFk9D9CKEEVV53fqluL2Foqo6qiVerqzA
 m/cg65Afm4oq3/q6XvBOusoJSUDpBmcc6kDOIYCQ4tGpv8OSnhBceq8QcIK/A/d/0miP
 8rc+RTgWaVAeixw0yuAsVy5CW7jM5apq8cjaRv87ppu7e9EAA5ZLQUCf+fMi/3RRzLYv
 AlV4jPnI05TcRPXTlVm4wYloSsXuLl4hRGsQtpmXZZQiXK01qzA8YRIDb+1GlOboPjvI
 l0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=o7iRMBDTE63C8dAXeaFq6vizBKPMbrYiwVf3GYE2Y2Y=;
 b=D7HJEC8PMarHgCj2w9TS/M3KJt2fh4HutWCrT8qq4MwSdSjRgzOCZ1TbxkdmpiPF0Q
 MBWFN8XCya4Un6Xe+Xe1+RwYO8o66+6Qb5GnYpT9ga6MXR9WYpzgdo8Jol2sW3hsaZ/l
 QBEka5Xg1nfcnog7p0Kf/IaQTBVgKpEToamxikXNYSNGnmntQH35lHAnw106lXSwsQX0
 ZrT/NLvOsB5cJx4EDyZVmyJwB4HXVoVT6Vhh3DB8RML8UswEbqIJ7QCxTUbRkkqO6psj
 SHzzERKRfoLFeKVkIdZeKnyz1UZxNPSjyOgiWb2HWCq/8m4boT6e3fHnuqlIJAvcZ/DF
 tKPg==
X-Gm-Message-State: AGi0PuaP/2ftWQ52nDlIDkdwSKrCH+1UBrvFeh6PjuFBUHVm6/uwdOow
 FiDfBPQB/331x6054M23n8ogBgkOkl8=
X-Google-Smtp-Source: APiQypLMEPUEcteMZAnPk9gU/9FMqgmhYnRPJBmIwAwCQghlo01thDNSZaaMET/j6yBjSreJppYwEw==
X-Received: by 2002:a05:6000:11cb:: with SMTP id
 i11mr12791854wrx.339.1587462140582; 
 Tue, 21 Apr 2020 02:42:20 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b22sm3082814wmj.1.2020.04.21.02.42.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:42:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] scripts/qemugdb: Remove shebang header
Date: Tue, 21 Apr 2020 11:42:14 +0200
Message-Id: <20200421094216.24927-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421094216.24927-1-f4bug@amsat.org>
References: <20200421094216.24927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42a
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
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These scripts are loaded as plugin by GDB (and they don't
have any __main__ entry point). Remove the shebang header.

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


