Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6195CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:14:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2076B2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 09:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsAcUDKe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2076B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2WXu-0001qV-1m
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 05:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUd-0005fi-RS
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k2WUb-0003rq-Ei
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 05:10:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596445848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0GpL3ogciI/n4T7k92fQm4SYVHYnZDZtL3oxTvwDlDE=;
 b=MsAcUDKe3V7iPZDS9swn28or97cjibUHqrOnjohLEclf5uJHZ+8K3r6/m7j/z9kKReSNQS
 io1qbK/djOCHwNhKyaZoCthmZ8ZlKARBQeYZJhK53dZ/b/7LIsdkSX9wLOrJYufa5NxLTv
 pbt7Nd00rFhQvly0MZwZq7hLxpQKElY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-xK2DZI-xMyeHe8nIVyyrGg-1; Mon, 03 Aug 2020 05:10:45 -0400
X-MC-Unique: xK2DZI-xMyeHe8nIVyyrGg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7651819057A2;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB438AD1C;
 Mon,  3 Aug 2020 09:10:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A673E11328A3; Mon,  3 Aug 2020 11:10:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/3] schemas: Add vim modeline
Date: Mon,  3 Aug 2020 11:10:42 +0200
Message-Id: <20200803091042.2920218-4-armbru@redhat.com>
In-Reply-To: <20200803091042.2920218-1-armbru@redhat.com>
References: <20200803091042.2920218-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:09:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrea Bolognani <abologna@redhat.com>

The various schemas included in QEMU use a JSON-based format which
is, however, strictly speaking not valid JSON.

As a consequence, when vim tries to apply syntax highlight rules
for JSON (as guessed from the file name), the result is an unreadable
mess which mostly consist of red markers pointing out supposed errors
in, well, pretty much everything.

Using Python syntax highlighting produces much better results, and
in fact these files already start with specially-formatted comments
that instruct Emacs to process them as if they were Python files.

This commit adds the equivalent special comments for vim.

Signed-off-by: Andrea Bolognani <abologna@redhat.com>
Message-Id: <20200729185024.121766-1-abologna@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/interop/firmware.json                | 1 +
 docs/interop/vhost-user.json              | 1 +
 qapi/authz.json                           | 1 +
 qapi/block-core.json                      | 1 +
 qapi/block.json                           | 1 +
 qapi/char.json                            | 1 +
 qapi/common.json                          | 1 +
 qapi/control.json                         | 1 +
 qapi/crypto.json                          | 1 +
 qapi/dump.json                            | 1 +
 qapi/error.json                           | 1 +
 qapi/introspect.json                      | 1 +
 qapi/job.json                             | 1 +
 qapi/machine-target.json                  | 1 +
 qapi/machine.json                         | 1 +
 qapi/migration.json                       | 1 +
 qapi/misc-target.json                     | 1 +
 qapi/misc.json                            | 1 +
 qapi/net.json                             | 1 +
 qapi/qapi-schema.json                     | 1 +
 qapi/qdev.json                            | 1 +
 qapi/qom.json                             | 1 +
 qapi/rdma.json                            | 1 +
 qapi/rocker.json                          | 1 +
 qapi/run-state.json                       | 1 +
 qapi/sockets.json                         | 1 +
 qapi/tpm.json                             | 1 +
 qapi/transaction.json                     | 1 +
 qapi/ui.json                              | 1 +
 qga/qapi-schema.json                      | 1 +
 storage-daemon/qapi/qapi-schema.json      | 1 +
 tests/qapi-schema/doc-good.json           | 2 ++
 tests/qapi-schema/include/sub-module.json | 1 +
 tests/qapi-schema/qapi-schema-test.json   | 1 +
 tests/qapi-schema/sub-sub-module.json     | 1 +
 35 files changed, 36 insertions(+)

diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
index 240f565397..989f10b626 100644
--- a/docs/interop/firmware.json
+++ b/docs/interop/firmware.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
diff --git a/docs/interop/vhost-user.json b/docs/interop/vhost-user.json
index ef8ac5941f..feb5fe58ca 100644
--- a/docs/interop/vhost-user.json
+++ b/docs/interop/vhost-user.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # Copyright (C) 2018 Red Hat, Inc.
 #
diff --git a/qapi/authz.json b/qapi/authz.json
index 1c836a3abd..f3e9745426 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # QAPI authz definitions
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 49edb4fdae..197bdc1c36 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # == Block core (VM unrelated)
diff --git a/qapi/block.json b/qapi/block.json
index 2ddbfa8306..c54a393cf3 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # = Block devices
diff --git a/qapi/char.json b/qapi/char.json
index daceb20f84..8aeedf96b2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/common.json b/qapi/common.json
index 7b9cbcd97b..716712d4b3 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # = Common data types
diff --git a/qapi/control.json b/qapi/control.json
index 6b816bb61f..de51e9916c 100644
--- a/qapi/control.json
+++ b/qapi/control.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/crypto.json b/qapi/crypto.json
index 5a68e0db25..bb7930d332 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/dump.json b/qapi/dump.json
index a1eed7b15c..f7c4267e3f 100644
--- a/qapi/dump.json
+++ b/qapi/dump.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/qapi/error.json b/qapi/error.json
index 3fad08f506..94a6502de9 100644
--- a/qapi/error.json
+++ b/qapi/error.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # = QMP errors
diff --git a/qapi/introspect.json b/qapi/introspect.json
index b1aabd4cfd..944bb87a20 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # Copyright (C) 2015 Red Hat, Inc.
 #
diff --git a/qapi/job.json b/qapi/job.json
index c48a0c3e34..280c2f76f1 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # == Background jobs
diff --git a/qapi/machine-target.json b/qapi/machine-target.json
index f2c82949d8..698850cc78 100644
--- a/qapi/machine-target.json
+++ b/qapi/machine-target.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/qapi/machine.json b/qapi/machine.json
index daede5ab14..481b1f07ec 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/qapi/migration.json b/qapi/migration.json
index d5000558c6..ea53b23dca 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index dee3b45930..1e561fa97b 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/misc.json b/qapi/misc.json
index 149c925246..9d32820dc1 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/net.json b/qapi/net.json
index 558d520a2f..ddb113e5e5 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 43b0ba0dea..f03ff91ceb 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 ##
 # = Introduction
 #
diff --git a/qapi/qdev.json b/qapi/qdev.json
index f4ed9735c4..13254529bf 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/qapi/qom.json b/qapi/qom.json
index 8abe998962..0b0b92944b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or later.
 # See the COPYING file in the top-level directory.
diff --git a/qapi/rdma.json b/qapi/rdma.json
index b58105b1b6..a1d2175a8b 100644
--- a/qapi/rdma.json
+++ b/qapi/rdma.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/rocker.json b/qapi/rocker.json
index 52597db491..b48e49a89b 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # = Rocker switch device
diff --git a/qapi/run-state.json b/qapi/run-state.json
index 2e22907740..7cc9f96a5b 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/sockets.json b/qapi/sockets.json
index cbd6ef35d0..c0c640a5b0 100644
--- a/qapi/sockets.json
+++ b/qapi/sockets.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 ##
 # = Socket data types
diff --git a/qapi/tpm.json b/qapi/tpm.json
index dc1f081739..6a10c9ed8d 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/transaction.json b/qapi/transaction.json
index b6c11158f0..15ddebdbc3 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qapi/ui.json b/qapi/ui.json
index 1568cfeaad..9d6721037f 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 #
 
 ##
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 408a662ea5..b1e9ed836d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,4 +1,5 @@
 # *-*- Mode: Python -*-*
+# vim: filetype=python
 
 ##
 #
diff --git a/storage-daemon/qapi/qapi-schema.json b/storage-daemon/qapi/qapi-schema.json
index 14f4f8fe61..6100d1f0c9 100644
--- a/storage-daemon/qapi/qapi-schema.json
+++ b/storage-daemon/qapi/qapi-schema.json
@@ -1,4 +1,5 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
 
 # Note that modules are shared with the QEMU main schema under the assumption
 # that the storage daemon schema is a subset of the main schema. For the shared
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index ddd89d1233..9da72a1f55 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -1,4 +1,6 @@
 # -*- Mode: Python -*-
+# vim: filetype=python
+#
 # Positive QAPI doc comment tests
 
 { 'pragma': { 'doc-required': true } }
diff --git a/tests/qapi-schema/include/sub-module.json b/tests/qapi-schema/include/sub-module.json
index afdb267228..b9f7b9bb56 100644
--- a/tests/qapi-schema/include/sub-module.json
+++ b/tests/qapi-schema/include/sub-module.json
@@ -1,4 +1,5 @@
 # *-*- Mode: Python -*-*
+# vim: filetype=python
 
 # Sub-module of ../qapi-schema-test.json
 
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 6b1f05afa7..3a9f2cbb33 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -1,4 +1,5 @@
 # *-*- Mode: Python -*-*
+# vim: filetype=python
 
 # This file is a stress test of supported qapi constructs that must
 # parse and compile correctly.
diff --git a/tests/qapi-schema/sub-sub-module.json b/tests/qapi-schema/sub-sub-module.json
index 524ef9b83f..94f36ec0b1 100644
--- a/tests/qapi-schema/sub-sub-module.json
+++ b/tests/qapi-schema/sub-sub-module.json
@@ -1,4 +1,5 @@
 # *-*- Mode: Python -*-*
+# vim: filetype=python
 
 # Sub-module of sub-module include/sub-module.json of qapi-schema-test.json
 
-- 
2.26.2


