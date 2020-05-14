Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C2C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:59:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DC8205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 05:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS+Ymwwh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DC8205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ6tX-0007V3-6F
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 01:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pQ-0005QZ-Mf
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24155
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jZ6pM-0001f4-3C
 for qemu-devel@nongnu.org; Thu, 14 May 2020 01:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589435679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+ohm4XYXFRwTcdD2vs9B3hxYnBxrDcx8T9ob43s9gU=;
 b=DS+YmwwhjGXY3+j5dRdtObQxYY9uifSYf1240jdZBPnnSUabwga9sTdSfGZdx7jjr4aHhy
 e4HpE/V0KO7ggFhMnRV1vKH62e+0+TsXqEESGgVfMtnyiEjMBXW//hehQmZjE4LTLVzDHh
 tjKresxVECwceKvwmSOp8Z8WzAJDSMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-tOe9s-0ZNleE0_prcAC5XA-1; Thu, 14 May 2020 01:54:35 -0400
X-MC-Unique: tOe9s-0ZNleE0_prcAC5XA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7293C1054F8B;
 Thu, 14 May 2020 05:54:34 +0000 (UTC)
Received: from probe.redhat.com (ovpn-113-9.rdu2.redhat.com [10.10.113.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 140986A977;
 Thu, 14 May 2020 05:54:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 13/32] python/qemu/lib: Adjust traceback typing
Date: Thu, 14 May 2020 01:53:44 -0400
Message-Id: <20200514055403.18902-14-jsnow@redhat.com>
In-Reply-To: <20200514055403.18902-1-jsnow@redhat.com>
References: <20200514055403.18902-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

mypy considers it incorrect to use `bool` to statically return false,
because it will assume that it could conceivably return True, and gives
different analysis in that case. Use a None return to achieve the same
effect, but make mypy happy.

Note: Pylint considers function signatures as code that might trip the
duplicate-code checker. I'd rather not disable this as it does not
trigger often in practice, so I'm disabling it as a one-off and filed a
change request; see https://github.com/PyCQA/pylint/issues/3619

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/lib/machine.py |  8 ++++++--
 python/qemu/lib/qmp.py     | 10 ++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/python/qemu/lib/machine.py b/python/qemu/lib/machine.py
index b2f0412197..2f94c851ed 100644
--- a/python/qemu/lib/machine.py
+++ b/python/qemu/lib/machine.py
@@ -24,6 +24,8 @@
 import shutil
 import socket
 import tempfile
+from typing import Optional, Type
+from types import TracebackType
 
 from . import qmp
 
@@ -127,9 +129,11 @@ def __init__(self, binary, args=None, wrapper=None, name=None,
     def __enter__(self):
         return self
 
-    def __exit__(self, exc_type, exc_val, exc_tb):
+    def __exit__(self,
+                 exc_type: Optional[Type[BaseException]],
+                 exc_val: Optional[BaseException],
+                 exc_tb: Optional[TracebackType]) -> None:
         self.shutdown()
-        return False
 
     def add_monitor_null(self):
         """
diff --git a/python/qemu/lib/qmp.py b/python/qemu/lib/qmp.py
index 73d49050ed..b91c9d5c1c 100644
--- a/python/qemu/lib/qmp.py
+++ b/python/qemu/lib/qmp.py
@@ -14,7 +14,9 @@
 from typing import (
     Optional,
     TextIO,
+    Type,
 )
+from types import TracebackType
 
 
 class QMPError(Exception):
@@ -146,10 +148,14 @@ def __enter__(self):
         # Implement context manager enter function.
         return self
 
-    def __exit__(self, exc_type, exc_value, exc_traceback):
+    def __exit__(self,
+                 # pylint: disable=duplicate-code
+                 # see https://github.com/PyCQA/pylint/issues/3619
+                 exc_type: Optional[Type[BaseException]],
+                 exc_val: Optional[BaseException],
+                 exc_tb: Optional[TracebackType]) -> None:
         # Implement context manager exit function.
         self.close()
-        return False
 
     def connect(self, negotiate=True):
         """
-- 
2.21.1


