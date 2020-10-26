Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43659C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:32:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 803E320747
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 10:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASzSpnTd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 803E320747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWzo0-0002YG-T0
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPL-0002ye-US
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWzPH-0006kp-Df
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603706834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=jta5pCSiEwBdmPKVB9/zb0GLa6GuoN2cpd51+Aozuoc=;
 b=ASzSpnTd2oKeqa8+Ggq2Q38NlujmK2suuOY8pfIVMQx9FdsyJOiAXDFaVHjIhkx4OYfBDF
 OtWzB0sshC7rs5UXks5pizcyv36lt33mEl2yY/e8JE1PCx/Ag+2zJb6CJymtp8NrrnBt51
 vlyqW3ZbIib6+ixluyTtXvsB+ZtG3qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-fb_1nQOYN86EqjRZLrpYiA-1; Mon, 26 Oct 2020 06:07:12 -0400
X-MC-Unique: fb_1nQOYN86EqjRZLrpYiA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44F8EA0C01;
 Mon, 26 Oct 2020 10:07:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31A798B842;
 Mon, 26 Oct 2020 10:07:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/31] fuzz: register predefined generic-fuzz configs
Date: Mon, 26 Oct 2020 11:06:24 +0100
Message-Id: <20201026100632.212530-24-thuth@redhat.com>
In-Reply-To: <20201026100632.212530-1-thuth@redhat.com>
References: <20201026100632.212530-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Bulekov <alxndr@bu.edu>

We call get_generic_fuzz_configs, which fills an array with
predefined {name, args, objects} triples. For each of these, we add a
new FuzzTarget, that uses a small wrapper to set
QEMU_FUZZ_{ARGS,OBJECTS} to the corresponding predefined values.

Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20201023150746.107063-16-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/fuzz/generic_fuzz.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index 592b78ffe2..a8f5864883 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -26,6 +26,7 @@
 #include "hw/qdev-core.h"
 #include "hw/pci/pci.h"
 #include "hw/boards.h"
+#include "generic_fuzz_configs.h"
 
 /*
  * SEPARATOR is used to separate "operations" in the fuzz input
@@ -907,6 +908,17 @@ static GString *generic_fuzz_cmdline(FuzzTarget *t)
     return cmd_line;
 }
 
+static GString *generic_fuzz_predefined_config_cmdline(FuzzTarget *t)
+{
+    const generic_fuzz_config *config;
+    g_assert(t->opaque);
+
+    config = t->opaque;
+    setenv("QEMU_FUZZ_ARGS", config->args, 1);
+    setenv("QEMU_FUZZ_OBJECTS", config->objects, 1);
+    return generic_fuzz_cmdline(t);
+}
+
 static void register_generic_fuzz_targets(void)
 {
     fuzz_add_target(&(FuzzTarget){
@@ -917,6 +929,26 @@ static void register_generic_fuzz_targets(void)
             .fuzz = generic_fuzz,
             .crossover = generic_fuzz_crossover
     });
+
+    GString *name;
+    const generic_fuzz_config *config;
+
+    for (int i = 0;
+         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
+         i++) {
+        config = predefined_configs + i;
+        name = g_string_new("generic-fuzz");
+        g_string_append_printf(name, "-%s", config->name);
+        fuzz_add_target(&(FuzzTarget){
+                .name = name->str,
+                .description = "Predefined generic-fuzz config.",
+                .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
+                .pre_fuzz = generic_pre_fuzz,
+                .fuzz = generic_fuzz,
+                .crossover = generic_fuzz_crossover,
+                .opaque = (void *)config
+        });
+    }
 }
 
 fuzz_target_init(register_generic_fuzz_targets);
-- 
2.18.2


