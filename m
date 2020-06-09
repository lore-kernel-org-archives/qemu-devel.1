Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2EDC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B06720835
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 12:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajL9ik/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B06720835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jideQ-0000im-Di
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 08:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSp-0000L7-A7; Tue, 09 Jun 2020 08:34:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:51358)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jidSe-00074Q-Eu; Tue, 09 Jun 2020 08:34:43 -0400
Received: by mail-wm1-x32a.google.com with SMTP id u13so2681125wml.1;
 Tue, 09 Jun 2020 05:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rU9HLs+zXLkedYHMwBLBpdL3JHM8xoCUj3TGxvPYxeY=;
 b=ajL9ik/U9YZSOAlRmrlwhxpXxQ8ivo/blxtiC5fH8rUlSHyKfOtLAoIkAMJkTYCCTW
 v+35E+Y9OKM3BI/A84acaxg15TsHxDtvg/xSOZ5Oj8A+yYsNa86KuEedqtVfDBss5myS
 o21TbkuwrmHqSQw5Vt/VY+5XLV68jiY1IAb7X5yFwOEi0alulJ+NG4KiqSIDvSvvCadF
 tEE1cf7Nc4ICXaIWGDLaVd/CvdYIHCjijgCAz8fn3SYbWlu9T34x9OMsTeaVSODqFhcI
 6r8/G9j7IDluVSrNEvKs27YaIwzq3kxOZq1NP50bmCxtJMvaeIkW9KKs1Kdsu/hR+Ju1
 IJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rU9HLs+zXLkedYHMwBLBpdL3JHM8xoCUj3TGxvPYxeY=;
 b=LXYvwS+FPqoCdOCqYKTYCDcdIZs4mHO3doYeOaIl7PQYc1eTPmxtcvAFsotNxVK8t5
 qFH8dCKpHjWEymjQQ2wQ62gjDLADd4R27NvfCmhOFooLWVAlcvegsLtWVzh+vqk0qlwo
 +uaTQuNamyQq/jkkAHpUHY7aai16uLaWRdfrYD4tmlFXQrcJZgdveaybiFST/uV4SWPs
 Cq6OUi2fstMy4Z5pgbfJdC2Kb6BMJfHIvnUrJULyVnZf5fXhQs9z3iRvcSAPzJYpXFET
 isgLzOLWBEywBnQVkKV7DceeKoKnlnrLmFq6oSUWNQFmZyHrzHGOTi3RB9g1Kap8RXaP
 Kv9A==
X-Gm-Message-State: AOAM531+sQuvWnBY+FdErKFSOGK5BOcmlO8i7eejvgU1B9OZdeCyxzC/
 pz+NdNX141npZb+/Z5th3jQDFP4t
X-Google-Smtp-Source: ABdhPJwyFNfIA1BaqLFKvyBOElxlngjJS7o89XdbSemKmaZmdyNgP5WsfUKlAEq2G6QoqGT8EgHPSQ==
X-Received: by 2002:a7b:cbce:: with SMTP id n14mr3978268wmi.66.1591706069364; 
 Tue, 09 Jun 2020 05:34:29 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id c81sm2920931wmd.42.2020.06.09.05.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 05:34:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 2/5] hw/misc/led: Add LED_STATUS_CHANGED QAPI event
Date: Tue,  9 Jun 2020 14:34:22 +0200
Message-Id: <20200609123425.6921-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200609123425.6921-1-f4bug@amsat.org>
References: <20200609123425.6921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32a.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Allow LED devices to emit STATUS_CHANGED events on a QMP chardev.

QMP event examples:

{
    "timestamp": {
        "seconds": 1591704274,
        "microseconds": 520850
    },
    "event": "LED_STATUS_CHANGED",
    "data": {
        "name": "Green LED #0",
        "status": "on"
    }
}
{
    "timestamp": {
        "seconds": 1591704275,
        "microseconds": 530912
    },
    "event": "LED_STATUS_CHANGED",
    "data": {
        "name": "Green LED #0",
        "status": "off"
    }
}

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 qapi/led.json         | 47 +++++++++++++++++++++++++++++++++++++++++++
 qapi/qapi-schema.json |  1 +
 hw/misc/led.c         |  4 ++++
 MAINTAINERS           |  1 +
 qapi/Makefile.objs    |  2 +-
 5 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 qapi/led.json

diff --git a/qapi/led.json b/qapi/led.json
new file mode 100644
index 0000000000..b6cef8a5dd
--- /dev/null
+++ b/qapi/led.json
@@ -0,0 +1,47 @@
+# -*- Mode: Python -*-
+#
+
+##
+# = LED device
+##
+
+##
+# @LedState:
+#
+# Status of a LED
+#
+# @on: device is emitting
+#
+# @off: device is off
+#
+# Since: 5.1
+##
+{ 'enum': 'LedState', 'data': [ 'on', 'off' ] }
+
+##
+# @LED_STATUS_CHANGED:
+#
+# Emitted when LED status changed
+#
+# @name: LED description
+#
+# @status: New status
+#
+# Since: 5.1
+#
+# Example:
+#
+# <- {"timestamp": {"seconds": 1541579657, "microseconds": 986760},
+#     "event": "LED_STATUS_CHANGED",
+#     "data":
+#         {"name": "Blue LED #3",
+#          "status": "on"
+#         }
+#    }
+#
+##
+{ 'event': 'LED_STATUS_CHANGED',
+  'data': { 'name'      : 'str',
+            'status'    : 'LedState'
+          }
+}
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 43b0ba0dea..6f3ffc0ae1 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -84,3 +84,4 @@
 { 'include': 'misc.json' }
 { 'include': 'misc-target.json' }
 { 'include': 'audio.json' }
+{ 'include': 'led.json' }
diff --git a/hw/misc/led.c b/hw/misc/led.c
index dc61b11017..233843f581 100644
--- a/hw/misc/led.c
+++ b/hw/misc/led.c
@@ -7,6 +7,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-led.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/led.h"
 #include "hw/irq.h"
@@ -19,6 +20,9 @@ static void led_set(void *opaque, int line, int new_state)
 
     trace_led_set(s->name, s->current_state, new_state);
 
+    /* FIXME QMP rate limite? */
+    qapi_event_send_led_status_changed(s->name, new_state
+                                                ? LED_STATE_ON : LED_STATE_OFF);
     s->current_state = new_state;
 }
 
diff --git a/MAINTAINERS b/MAINTAINERS
index f873f0b94a..9ff84498fc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1867,6 +1867,7 @@ F: hw/misc/unimp.c
 LED
 M: Philippe Mathieu-Daudé <f4bug@amsat.org>
 S: Maintained
+F: qapi/led.json
 F: include/hw/misc/led.h
 F: hw/misc/led.c
 
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 4673ab7490..e9f6570c32 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,7 +6,7 @@ util-obj-y += qmp-event.o
 util-obj-y += qapi-util.o
 
 QAPI_COMMON_MODULES = audio authz block-core block char common control crypto
-QAPI_COMMON_MODULES += dump error introspect job machine migration misc
+QAPI_COMMON_MODULES += dump error introspect job led machine migration misc
 QAPI_COMMON_MODULES += net pragma qdev qom rdma rocker run-state sockets tpm
 QAPI_COMMON_MODULES += trace transaction ui
 QAPI_TARGET_MODULES = machine-target misc-target
-- 
2.21.3


