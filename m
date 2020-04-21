Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF01C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0D22076C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc7b2PyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0D22076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQpRf-0007kg-BW
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQC-0005jQ-7B
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQB-0004iP-OX
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:42:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38567)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jQpQ9-0004ch-Mm; Tue, 21 Apr 2020 05:42:25 -0400
Received: by mail-wm1-x343.google.com with SMTP id g12so2897316wmh.3;
 Tue, 21 Apr 2020 02:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QMzOijh8unN2JXd6IzCqKunT7wI91R5lL1fMI9L6xjM=;
 b=hc7b2PyV0e7acRjt0cLEIaIEJqVuKDYHHIojepJgqpEN4THKAZEb+QWr3vjLcYUN3t
 PB3a6MbYiHF4gorq5sogB5gid3woci6a3f9DCiXftabBWj4mpOMiZnvFan7wl3EYh61b
 WIH9DOOerVjuUbfxFLS5RlHywmx3qkp+OEup3viM74yMSPbeTi9H6PURRrxWN9OVJyqZ
 8kM3OLhx4MOTmtjmpWli3xioRohyspA/h+4LQTBljU9wHBrTH5H5Ap2ZZcpETkmdzuyM
 QamxYHYh23qDy4spyFSDMOFcODiAs0TuMYUrJGF7uNy1fwjGTsHS+DPMkZaPsKgEmOHJ
 t0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=QMzOijh8unN2JXd6IzCqKunT7wI91R5lL1fMI9L6xjM=;
 b=fyT732SyP9p5ZCYG8a229RbmhuZ9AyG0/mo0cFmGYMxLXcwMi3pZOzVgeq+EEMX+do
 TB7uMcawQHTn0N+DDdsMoQLul3uj0hWh767CC5gm3LF1G+A/Mg2Zyxr1xNZIfpLe+F2n
 NwNXlNNzaOcmgwep5CpTAKdXFGj4cRSl+g6BKstbQ98QKcfnCW7GMxZmeQLw+8xgyHYI
 SVm5FtP96/+WAD2e7GI1Om56FKFAlASxMhHRoKNBRlE+Euoa3YSWwYTQ5CL3xZsPAnsi
 1kDl+7dTqTyRSM9J6n+gCbReVTxgaXfZVTw11Bo8lgBYt89mM5TUjGyicuKcuIWJKOmB
 /s1A==
X-Gm-Message-State: AGi0PuayEw3DSJkRY2JsGdbUEe03m+QN80GKFS6ek7PY1Hqcw/Jx6gOm
 +mXb5GpLfxCi20BhuFtCW8UMx+bD/Bs=
X-Google-Smtp-Source: APiQypKdDNJdDaUcRArzHf5icPAQsTD3WR5sADtf3cFCaeLzhHoRYpb4IyhYJC48Pjb9KWVMAwR8iQ==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr4233872wma.78.1587462143456; 
 Tue, 21 Apr 2020 02:42:23 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id b22sm3082814wmj.1.2020.04.21.02.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 02:42:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/4] scripts/qmp: Fix QEMU Python scripts path
Date: Tue, 21 Apr 2020 11:42:16 +0200
Message-Id: <20200421094216.24927-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200421094216.24927-1-f4bug@amsat.org>
References: <20200421094216.24927-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::343
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

QEMU Python scripts have been moved in commit 8f8fd9edba4 ("Introduce
Python module structure"). Use the same sys.path modification used
in the referenced commit to be able to use these scripts again.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qmp/qmp      | 4 +++-
 scripts/qmp/qom-fuse | 4 +++-
 scripts/qmp/qom-get  | 4 +++-
 scripts/qmp/qom-list | 4 +++-
 scripts/qmp/qom-set  | 4 +++-
 scripts/qmp/qom-tree | 4 +++-
 6 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 0625fc2aba..8e52e4a54d 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -11,7 +11,9 @@
 # See the COPYING file in the top-level directory.
 
 import sys, os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 def print_response(rsp, prefix=[]):
     if type(rsp) == list:
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 6bada2c33d..5fa6b3bf64 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -15,7 +15,9 @@ import fuse, stat
 from fuse import Fuse
 import os, posix
 from errno import *
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 72ccd79330..59090069dc 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 5b8f9fd855..c5d0c8127d 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index b475e397fc..e9d7e0b054 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -13,7 +13,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 86233fa211..d96b17256e 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -15,7 +15,9 @@
 
 import sys
 import os
-from qmp import QEMUMonitorProtocol
+
+sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
+from qemu.qmp import QEMUMonitorProtocol
 
 cmd, args = sys.argv[0], sys.argv[1:]
 socket_path = None
-- 
2.21.1


