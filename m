Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB891206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXvxeob1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB891206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjTc8-00050L-St
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9n-0000e7-2M
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42874
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjT9i-0001Iw-4S
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gaH1ZQGN53/iF7xNq/mMf5LRKAb3Vzs9AKRw7DAhI0=;
 b=EXvxeob1HA5a4MdwBJBaZLCwX7na/RjsAE9Ga92ncmRbQzUpd0dXqsoc2TVyR4HlF4VLi+
 Y2F2uzsWkpKBNLKo/LnD9pGnQLU94iRYcI3fYvaoxR7T/YiHspRSVL4pN44IsORxaYkuRX
 MhWpDg/3oRYI3hgs1LtfL7YULHipUFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-TMqlUCK0Oju2jQXx2EYUwg-1; Thu, 11 Jun 2020 15:45:21 -0400
X-MC-Unique: TMqlUCK0Oju2jQXx2EYUwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE51719057A1;
 Thu, 11 Jun 2020 19:45:20 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E8997BA1A;
 Thu, 11 Jun 2020 19:45:17 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 031/115] hw/i386/vmport: Introduce vmport.h
Date: Thu, 11 Jun 2020 15:43:25 -0400
Message-Id: <20200611194449.31468-32-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Liran Alon <liran.alon@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liran Alon <liran.alon@oracle.com>

No functional change. This is mere refactoring.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200312165431.82118-8-liran.alon@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             |  2 +-
 hw/i386/vmmouse.c        |  2 +-
 hw/i386/vmport.c         |  2 +-
 hw/i386/vmport.h         | 34 ----------------------------------
 include/hw/i386/vmport.h | 16 ++++++++++++++++
 5 files changed, 19 insertions(+), 37 deletions(-)
 delete mode 100644 hw/i386/vmport.h
 create mode 100644 include/hw/i386/vmport.h

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2128f3d6fe..b9961b1035 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -31,6 +31,7 @@
 #include "hw/i386/apic.h"
 #include "hw/i386/topology.h"
 #include "hw/i386/fw_cfg.h"
+#include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
 #include "hw/block/fdc.h"
 #include "hw/ide.h"
@@ -91,7 +92,6 @@
 #include "qapi/qmp/qerror.h"
 #include "config-devices.h"
 #include "e820_memory_layout.h"
-#include "vmport.h"
 #include "fw_cfg.h"
 #include "trace.h"
 
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index b3aef41327..b73f076753 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -25,10 +25,10 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "ui/console.h"
+#include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
-#include "vmport.h"
 #include "cpu.h"
 
 /* debug only vmmouse */
diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
index dabb443367..e6d169566d 100644
--- a/hw/i386/vmport.c
+++ b/hw/i386/vmport.c
@@ -30,10 +30,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
+#include "hw/i386/vmport.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/hw_accel.h"
 #include "qemu/log.h"
-#include "vmport.h"
 #include "cpu.h"
 #include "trace.h"
 
diff --git a/hw/i386/vmport.h b/hw/i386/vmport.h
deleted file mode 100644
index 47eda7a22b..0000000000
--- a/hw/i386/vmport.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * QEMU VMPort emulation
- *
- * Copyright (C) 2007 Hervé Poussineau
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#ifndef HW_I386_VMPORT_H
-#define HW_I386_VMPORT_H
-
-#define TYPE_VMPORT "vmport"
-
-typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
-
-void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
-
-#endif
diff --git a/include/hw/i386/vmport.h b/include/hw/i386/vmport.h
new file mode 100644
index 0000000000..efbe3e0e3f
--- /dev/null
+++ b/include/hw/i386/vmport.h
@@ -0,0 +1,16 @@
+#ifndef HW_VMPORT_H
+#define HW_VMPORT_H
+
+#include "hw/isa/isa.h"
+
+#define TYPE_VMPORT "vmport"
+typedef uint32_t (VMPortReadFunc)(void *opaque, uint32_t address);
+
+static inline void vmport_init(ISABus *bus)
+{
+    isa_create_simple(bus, TYPE_VMPORT);
+}
+
+void vmport_register(unsigned char command, VMPortReadFunc *func, void *opaque);
+
+#endif
-- 
2.26.2



