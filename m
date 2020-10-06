Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C0FC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2566D206F4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 08:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc2WRC44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2566D206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPhyj-0008Om-Vt
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 04:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQN-00039e-CG
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:15 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:34809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1kPhQL-0001Th-FO
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 03:30:14 -0400
Received: by mail-wr1-x432.google.com with SMTP id t10so12239321wrv.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 00:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UP58U+DMNC1fmxFaM1xVgFDxaCmHGWc/Wt+u50L0cig=;
 b=Gc2WRC44EZpMIZtxxWauVYEb+zC0gm147KpFzkH3ikNdjnxYm1W9zMlvgHfiCE2uLn
 pkBfQ8zj7LqxPZ5DENL5T9iflR4KLTju/fASka0IK1k4Vf/w3NK0BNRk0SF4n0KTgw4E
 cvyzBakrpNUTmE9s69k31ye01nzT8PWp+wFqW2hsNyzotURnBrfP1EYDulZF21AvEoY0
 zOOAf8CJDFLaO6dSePyYICo9bCHSzo3zGj/AeadVvoXAL7dDmW9ql1EqrEfLCxRV/8ul
 1mJNIJ93MOL888btCh7NIQxRzI395nFytQdtJ9dbz0BYEXw9aLEiJVz4BwOly2kz9MQz
 ajUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=UP58U+DMNC1fmxFaM1xVgFDxaCmHGWc/Wt+u50L0cig=;
 b=Io7Au5ZLNuzh6wzKlb2w55kuCFbluMDSS3Y8HgsswjDZdSXUkvtNHyLcxIhAEdRZ3E
 5GoUt5r53sOX1vJMRiNF58gydMyaEfyb63Bey8YrgI2X02bp0EedNoCI4B77XxJpMUhT
 E5gTLm9wElRx7MMFBCIcdfWSDp6JxzVGQx/TQRpE/hEVDj3uqvuiayaBIEos7Wg7avVd
 xiqnmkd7RALExP2oORa4MM5oxdK4F1Q9dBKvjzJxmFx6tA+ogtfEtPBIi0U2k3V5gqDO
 LLCTFj+YxE+s2o7Kjr7lV3MRQzgeT3f7gtE5EBzZCqmPWX1GRp4czGqf4u7hkyhgme1n
 nYiw==
X-Gm-Message-State: AOAM531bV/aUa3x2XJPfSU/2xkI7GcGuEh+cjHgUp5Dcx4p74OYEHY3x
 LF0MQAI2AfufQU8lxx5ng8BHseEr4G0=
X-Google-Smtp-Source: ABdhPJzxGONVgEE0bDeMRhLmO7kjwc31xnqJymwptUSY07HAQlBZK8TjGLvz5vlX9j6vH6cVxvLYGg==
X-Received: by 2002:a5d:50cd:: with SMTP id f13mr3253730wrt.211.1601969411623; 
 Tue, 06 Oct 2020 00:30:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:5aca:cd0b:c4a1:9c2e])
 by smtp.gmail.com with ESMTPSA id i9sm2576329wma.47.2020.10.06.00.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 00:30:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/37] qapi: introduce replay.json for record/replay-related
 stuff
Date: Tue,  6 Oct 2020 09:29:38 +0200
Message-Id: <20201006072947.487729-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201006072947.487729-1-pbonzini@redhat.com>
References: <20201006072947.487729-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch adds replay.json file. It will be
used for adding record/replay-related data structures and commands.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <160174519444.12451.3472949430004845434.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS             |  1 +
 include/sysemu/replay.h |  1 +
 qapi/meson.build        |  1 +
 qapi/misc.json          | 18 ------------------
 qapi/qapi-schema.json   |  1 +
 qapi/replay.json        | 26 ++++++++++++++++++++++++++
 6 files changed, 30 insertions(+), 18 deletions(-)
 create mode 100644 qapi/replay.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 231f854437..417fca5f57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2696,6 +2696,7 @@ F: include/sysemu/replay.h
 F: docs/replay.txt
 F: stubs/replay.c
 F: tests/acceptance/replay_kernel.py
+F: qapi/replay.json
 
 IOVA Tree
 M: Peter Xu <peterx@redhat.com>
diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
index 7d963139e5..d6026ed8e5 100644
--- a/include/sysemu/replay.h
+++ b/include/sysemu/replay.h
@@ -14,6 +14,7 @@
 
 #include "qapi/qapi-types-misc.h"
 #include "qapi/qapi-types-run-state.h"
+#include "qapi/qapi-types-replay.h"
 #include "qapi/qapi-types-ui.h"
 #include "block/aio.h"
 
diff --git a/qapi/meson.build b/qapi/meson.build
index ea359a0148..0e98146f1f 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -39,6 +39,7 @@ qapi_all_modules = [
   'pci',
   'qom',
   'rdma',
+  'replay',
   'rocker',
   'run-state',
   'sockets',
diff --git a/qapi/misc.json b/qapi/misc.json
index 694d2142f3..7d1e2e9aae 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -757,24 +757,6 @@
  'returns': ['CommandLineOptionInfo'],
  'allow-preconfig': true }
 
-##
-# @ReplayMode:
-#
-# Mode of the replay subsystem.
-#
-# @none: normal execution mode. Replay or record are not enabled.
-#
-# @record: record mode. All non-deterministic data is written into the
-#          replay log.
-#
-# @play: replay mode. Non-deterministic data required for system execution
-#        is read from the log.
-#
-# Since: 2.5
-##
-{ 'enum': 'ReplayMode',
-  'data': [ 'none', 'record', 'play' ] }
-
 ##
 # @xen-load-devices-state:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 8d567e1386..0b444b76d2 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -85,6 +85,7 @@
 { 'include': 'qdev.json' }
 { 'include': 'machine.json' }
 { 'include': 'machine-target.json' }
+{ 'include': 'replay.json' }
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
diff --git a/qapi/replay.json b/qapi/replay.json
new file mode 100644
index 0000000000..9e13551d20
--- /dev/null
+++ b/qapi/replay.json
@@ -0,0 +1,26 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = Record/replay
+##
+
+{ 'include': 'common.json' }
+
+##
+# @ReplayMode:
+#
+# Mode of the replay subsystem.
+#
+# @none: normal execution mode. Replay or record are not enabled.
+#
+# @record: record mode. All non-deterministic data is written into the
+#          replay log.
+#
+# @play: replay mode. Non-deterministic data required for system execution
+#        is read from the log.
+#
+# Since: 2.5
+##
+{ 'enum': 'ReplayMode',
+  'data': [ 'none', 'record', 'play' ] }
-- 
2.26.2



