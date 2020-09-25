Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04CC4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491AE2371F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 00:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBhV4POQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491AE2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLbqT-0006FK-3A
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 20:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbby-0000r7-VK
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbbv-00009e-S4
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:29:18 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600993755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMogz3UY4+2VVe3Yqivuz7WZ5WTRsaKaTdJjGZ64c68=;
 b=VBhV4POQVc3+x1DEKZ6gVTWpb92jpYOZzyHOg3w1rV+dZgbuNdWt8mDMGKAlhyET84vHIW
 FeMwtgcZhoDJIJIG28lsuh3CXAYQvin9nxVtH8GKRnHmN77xzgnRDMI8CHHvOZsosHEorB
 48NKg/PElTCzCnG/KZUsMxwhLNWBo7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-iqmv2GUgMDKoPLpI48PMgA-1; Thu, 24 Sep 2020 20:29:13 -0400
X-MC-Unique: iqmv2GUgMDKoPLpI48PMgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E15781F03E
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 00:29:12 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EBC85D9DD;
 Fri, 25 Sep 2020 00:29:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 12/47] qapi: enforce import order/styling with isort
Date: Thu, 24 Sep 2020 20:28:25 -0400
Message-Id: <20200925002900.465855-13-jsnow@redhat.com>
In-Reply-To: <20200925002900.465855-1-jsnow@redhat.com>
References: <20200925002900.465855-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While we're mucking around with imports, we might as well formalize the
style we use. Let's use isort to do it for us.

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

Suggested-by: Cleber Rosa <crosa@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/.isort.cfg    | 5 +++++
 scripts/qapi/commands.py   | 6 +-----
 scripts/qapi/doc.py        | 2 +-
 scripts/qapi/expr.py       | 4 ++--
 scripts/qapi/introspect.py | 3 +--
 scripts/qapi/main.py       | 1 -
 scripts/qapi/parser.py     | 2 +-
 scripts/qapi/schema.py     | 2 +-
 scripts/qapi/types.py      | 1 -
 9 files changed, 12 insertions(+), 14 deletions(-)
 create mode 100644 scripts/qapi/.isort.cfg

diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
new file mode 100644
index 0000000000..b0aeffec26
--- /dev/null
+++ b/scripts/qapi/.isort.cfg
@@ -0,0 +1,5 @@
+[settings]
+force_sort_within_sections=True
+force_grid_wrap=4
+multi_line_output=3
+include_trailing_comma=True
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index e1df0e341f..64ed5278f9 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,11 +13,7 @@
 See the COPYING file in the top-level directory.
 """
 
-from .common import (
-    build_params,
-    c_name,
-    mcgen,
-)
+from .common import build_params, c_name, mcgen
 from .gen import QAPIGenCCode, QAPISchemaModularCVisitor, ifcontext
 
 
diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
index b764a8ccc0..1acb773e0a 100644
--- a/scripts/qapi/doc.py
+++ b/scripts/qapi/doc.py
@@ -5,9 +5,9 @@
 """This script produces the documentation of a qapi schema in texinfo format"""
 
 import re
+
 from .gen import QAPIGenDoc, QAPISchemaVisitor
 
-
 _MSG = '''
 @deftypefn {type} {{}} {name}
 
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index 03b31ecfc1..3e952a1462 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -14,12 +14,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-import re
 from collections import OrderedDict
+import re
+
 from .common import c_name
 from .error import QAPISemError
 
-
 # Names must be letters, numbers, -, and _.  They must start with letter,
 # except for downstream extensions which must start with __RFQDN_.
 # Dots are only valid in the downstream extension prefix.
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b036fcf9ce..2850121cbd 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -17,8 +17,7 @@
     mcgen,
 )
 from .gen import QAPISchemaMonolithicCVisitor
-from .schema import (QAPISchemaArrayType, QAPISchemaBuiltinType,
-                     QAPISchemaType)
+from .schema import QAPISchemaArrayType, QAPISchemaBuiltinType, QAPISchemaType
 
 
 def _make_tree(obj, ifcond, features, extra=None):
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 3f8338ade8..b2f20581fd 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -20,7 +20,6 @@
 from .types import gen_types
 from .visit import gen_visit
 
-
 DEFAULT_OUTPUT_DIR = ''
 DEFAULT_PREFIX = ''
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 76d28c1ce9..fd89e2188b 100644
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
index a835ee6fde..093f7a38d8 100644
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
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 53b47f9e58..cc6dad4c89 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -23,7 +23,6 @@
 from .gen import QAPISchemaModularCVisitor, ifcontext
 from .schema import QAPISchemaEnumMember, QAPISchemaObjectType
 
-
 # variants must be emitted before their container; track what has already
 # been output
 objects_seen = set()
-- 
2.26.2


