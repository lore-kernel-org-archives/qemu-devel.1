Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7551FC83001
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBA42082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3t+tEUu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBA42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU3BI-0007V1-8y
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 03:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38i-0004EU-8z
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38V-0001m6-34
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 02:57:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:34106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jU38U-0001k9-Lg; Thu, 30 Apr 2020 02:57:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id v4so6653953wme.1;
 Wed, 29 Apr 2020 23:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=82vLU5evSF7NmXT+3naoFvGA6BX+2PhVNg2wfXOfVEM=;
 b=g3t+tEUuqcdVJcpICZSQaD6BQgDacXI6kWCYC22atk3Dbq9pf9aqfc6zDN8+/7JJ/Q
 +oY7/XLSIO9L3TAHr5kaq/NFChKjrf4IEkefdk7l02DLOi+GB/DK79qq21S+Iw1IDZVZ
 IcW6BkY9QvydcSTYBBrA2bSewDQmHaBE6zvxe7+HvExbqjHqQ2nAoDCEQObwGKi3yozD
 xsg1EKgDxcx0vRg7bN+0yADdMb3ShQEVkpCKQ/M5f6GLIbcQrPoz/a4YBUDiFEeosOm9
 U7fusOSIcvOIeSazrr0+jhlixneNYPVcifupEsQos3+k2oUvjsKzf64OuM5Cyb62ti4y
 g1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=82vLU5evSF7NmXT+3naoFvGA6BX+2PhVNg2wfXOfVEM=;
 b=MsIs4QLFLW2D1CLD9YCeMtcUcI2ys3WEwZ9+AvVK1lnlbYILiHI+1P+iozerh/0Srb
 aG7wwloSZAD30asAGgJLsMEMLsWEJsVJ96K99f1GhKrMulYH2plLffPLQf9rQPjeEhVj
 Jr2zbgt71V3U9QQZoa42wMXbU+290tFjaIZloia90fl8wsUU72VvNX2n/Q+YdWJnWV5J
 PFggVsiuNZ8u+9yDcYhFpgD2QgLf+e5UAvralX3UQYiGKA5DNWNkcN0uftbm/5EuUVwp
 5dZvIhepuDnpxt9gHsW9bQVaol4lAcndZZan0aOJw3MhULv3D6uh0cJH3C97gysqOt2P
 Dk8w==
X-Gm-Message-State: AGi0PuZaDgYI1KG+yODSeJyoaBhiyax0fDlNurcS3eddnqN7fILDzfp+
 P9lBzO5NEocuWnPFasGC307rI628drQ=
X-Google-Smtp-Source: APiQypLbjodV1D6V7zHN6/TeHW7m2JzSuGSoYc9hBOpI2s4I4rxQGff+Erp6BXTonrML/BZAuGI4fQ==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr1224612wmk.97.1588229848801;
 Wed, 29 Apr 2020 23:57:28 -0700 (PDT)
Received: from localhost.localdomain (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id k184sm11139730wmf.9.2020.04.29.23.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2020 23:57:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] scripts/qmp: Use Python 3 interpreter
Date: Thu, 30 Apr 2020 08:57:20 +0200
Message-Id: <20200430065720.10763-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200430065720.10763-1-f4bug@amsat.org>
References: <20200430065720.10763-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x332.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::332
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

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: Use /usr/bin/env (jsnow)
---
 scripts/qmp/qom-get  | 2 +-
 scripts/qmp/qom-list | 2 +-
 scripts/qmp/qom-set  | 2 +-
 scripts/qmp/qom-tree | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 007b4cd442..7c5ede91bb 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 03bda3446b..bb68fd65d4 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index c37fe78b00..19881d85e9 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 1c8acf61e7..fa91147a03 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,4 +1,4 @@
-#!/usr/bin/python
+#!/usr/bin/env python3
 ##
 # QEMU Object Model test tools
 #
-- 
2.21.1


