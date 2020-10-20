Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE7CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6DB22244
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwwA/JtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6DB22244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvY8-00055i-51
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQS-0002gR-Iu
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41402)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvQQ-000060-JB
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wom93IYXu56sh9v+F21UrkApWdYLc+jQLroUxYfQY6A=;
 b=JwwA/JtY3ZdnsapTBRp/oSQyJlBZtuQcMeGPc9iLQjN3s2sArFLR452A0YyerOet7zWaat
 bYHiWJR5z3hme4hv36Ah9xuCfCVDfzi2Uc/df/Czk6u6GbW7Lpv4u2h2fvxkq0CFQptBAO
 2dtWafc5oFh25A+OYVoMUZHRfzmpSAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-DUUxgZavOJCuckEoeBv9kA-1; Tue, 20 Oct 2020 13:27:50 -0400
X-MC-Unique: DUUxgZavOJCuckEoeBv9kA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80691803F42;
 Tue, 20 Oct 2020 17:27:49 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F37C71992D;
 Tue, 20 Oct 2020 17:27:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] python/qemu: use isort to lay out imports
Date: Tue, 20 Oct 2020 13:27:23 -0400
Message-Id: <20201020172742.1483258-3-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Borrowed from the QAPI cleanup series, use the same configuration to
standardize the way we write and sort imports.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-2-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/.isort.cfg        |  7 +++++++
 python/qemu/accel.py          |  1 +
 python/qemu/console_socket.py |  2 +-
 python/qemu/machine.py        |  8 ++++----
 python/qemu/qmp.py            | 10 +++++-----
 python/qemu/qtest.py          |  2 +-
 6 files changed, 19 insertions(+), 11 deletions(-)
 create mode 100644 python/qemu/.isort.cfg

diff --git a/python/qemu/.isort.cfg b/python/qemu/.isort.cfg
new file mode 100644
index 0000000000..6d0fd6cc0d
--- /dev/null
+++ b/python/qemu/.isort.cfg
@@ -0,0 +1,7 @@
+[settings]
+force_grid_wrap=4
+force_sort_within_sections=True
+include_trailing_comma=True
+line_length=72
+lines_after_imports=2
+multi_line_output=3
\ No newline at end of file
diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 7fabe62920..3ec6bdcfdb 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -18,6 +18,7 @@
 import os
 import subprocess
 
+
 LOG = logging.getLogger(__name__)
 
 # Mapping host architecture to any additional architectures it can
diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 70869fbbdc..69f604c77f 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -13,9 +13,9 @@
 # the COPYING file in the top-level directory.
 #
 
+from collections import deque
 import socket
 import threading
-from collections import deque
 import time
 
 
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 82f3731fc3..bc83f399c1 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -20,15 +20,15 @@
 import errno
 import logging
 import os
-import subprocess
 import shutil
 import signal
+import subprocess
 import tempfile
-from typing import Optional, Type
 from types import TracebackType
-from . import console_socket
+from typing import Optional, Type
+
+from . import console_socket, qmp
 
-from . import qmp
 
 LOG = logging.getLogger(__name__)
 
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 7935dababb..ddf8347ac1 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -7,21 +7,21 @@
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
 
-import json
 import errno
-import socket
+import json
 import logging
+import socket
+from types import TracebackType
 from typing import (
     Any,
-    cast,
     Dict,
     Optional,
     TextIO,
-    Type,
     Tuple,
+    Type,
     Union,
+    cast,
 )
-from types import TracebackType
 
 
 # QMPMessage is a QMP Message of any kind.
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 888c8bd2f6..7700c0b09b 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -17,8 +17,8 @@
 # Based on qmp.py.
 #
 
-import socket
 import os
+import socket
 from typing import Optional, TextIO
 
 from .machine import QEMUMachine
-- 
2.26.2


