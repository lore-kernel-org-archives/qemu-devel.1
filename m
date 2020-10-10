Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C58C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:02:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825CC20679
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiyrlhU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825CC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRBiD-00084q-L9
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaw-0007f0-Ee
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32963)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kRBaq-0002i2-Ku
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 05:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602323711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8b9UXz27QB5FPuWDMYfNpwMEpVmifzznckyRNiZ0+PY=;
 b=iiyrlhU80mqkI9OaUb8CWM79NFRLmjPBEVbCDa4Tj9WFxw0MnceT49ThQsTKqorYuhlYM0
 k+S6ySzJ0m6AWFEZKyRrt7aD/s7Bk4roUYTAeIETrQ7RtR8e1jAMm0JjgHPK/LjPmfM2yQ
 tTku3FOZRI9SycP7ERv3tp5B7MV/j68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-cp-fEyI5MnyuOzK1vJXNdA-1; Sat, 10 Oct 2020 05:55:09 -0400
X-MC-Unique: cp-fEyI5MnyuOzK1vJXNdA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5202951B6;
 Sat, 10 Oct 2020 09:55:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2076B75126;
 Sat, 10 Oct 2020 09:55:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AF412112CE18; Sat, 10 Oct 2020 11:55:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/34] qapi: enforce import order/styling with isort
Date: Sat, 10 Oct 2020 11:54:37 +0200
Message-Id: <20201010095504.796182-8-armbru@redhat.com>
In-Reply-To: <20201010095504.796182-1-armbru@redhat.com>
References: <20201010095504.796182-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 02:57:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: peter.maydell@linaro.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

While we're mucking around with imports, we might as well formalize the
style we use. Let's use isort to do it for us.

lines_after_imports=2: Use two lines after imports, to match PEP8's
desire to have "two lines before and after" class definitions, which are
likely to start immediately after imports.

force_sort_within_sections: Intermingles "from x" and "import x" style
statements, such that sorting is always performed strictly on the module
name itself.

force_grid_wrap=4: Four or more imports from a single module will force
the one-per-line style that's more git-friendly. This will generally
happen for 'typing' imports.

multi_line_output=3: Uses the one-per-line indented style for long
imports.

include_trailing_comma: Adds a comma to the last import in a group,
which makes git conflicts nicer to deal with, generally.

line_length: 72 is chosen to match PEP8's "docstrings and comments" line
length limit. If you have a single line import that exceeds 72
characters, your names are too long!

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201009161558.107041-8-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/.isort.cfg    | 7 +++++++
 scripts/qapi/expr.py       | 3 ++-
 scripts/qapi/introspect.py | 7 +++++--
 scripts/qapi/parser.py     | 2 +-
 scripts/qapi/schema.py     | 2 +-
 5 files changed, 16 insertions(+), 5 deletions(-)
 create mode 100644 scripts/qapi/.isort.cfg

diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
new file mode 100644
index 0000000000..643caa1fbd
--- /dev/null
+++ b/scripts/qapi/.isort.cfg
@@ -0,0 +1,7 @@
+[settings]
+force_grid_wrap=4
+force_sort_within_sections=True
+include_trailing_comma=True
+line_length=72
+lines_after_imports=2
+multi_line_output=3
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index bb4dc55f56..2fcaaa2497 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -14,8 +14,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-import re
 from collections import OrderedDict
+import re
+
 from .common import c_name
 from .error import QAPISemError
 
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 42016a7e66..fafec94e02 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -17,8 +17,11 @@ from .common import (
     mcgen,
 )
 from .gen import QAPISchemaMonolithicCVisitor
-from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
-                     QAPISchemaType)
+from .schema import (
+    QAPISchemaArrayType,
+    QAPISchemaBuiltinType,
+    QAPISchemaType,
+)
 
 
 def _make_tree(obj, ifcond, features, extra=None):
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7298f5dbd1..e7b9d670ad 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,9 +14,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+from collections import OrderedDict
 import os
 import re
-from collections import OrderedDict
 
 from .error import QAPIParseError, QAPISemError
 from .source import QAPISourceInfo
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 676185d1a7..71ebb1e396 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -14,9 +14,9 @@
 
 # TODO catching name collisions in generated code would be nice
 
+from collections import OrderedDict
 import os
 import re
-from collections import OrderedDict
 
 from .common import c_name, pointer_suffix
 from .error import QAPIError, QAPISemError
-- 
2.26.2


