Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD9C5B578
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:51:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A7D21479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 02:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A7D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi8tZ-0005ly-Rq
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 22:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34000)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hi4p4-0005Mg-Um
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:30:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hi4or-0000FW-KZ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 18:30:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>)
 id 1hi4of-0008Hi-Vx; Mon, 01 Jul 2019 18:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0444308621E;
 Mon,  1 Jul 2019 22:29:46 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B650100033F;
 Mon,  1 Jul 2019 22:29:39 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>
Date: Mon,  1 Jul 2019 19:29:11 -0300
Message-Id: <20190701222912.4703-4-ehabkost@redhat.com>
In-Reply-To: <20190701222912.4703-1-ehabkost@redhat.com>
References: <20190701222912.4703-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 01 Jul 2019 22:29:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] machine.py: minor delinting
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 libvir-list@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

Since we're out in a new module, do a quick cursory pass of some of the
more obvious style issues.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20190627212816.27298-3-jsnow@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 python/qemu/machine.py | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a8a311b035..49445e675b 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -1,5 +1,10 @@
-# QEMU library
-#
+"""
+QEMU machine module:
+
+The machine module primarily provides the QEMUMachine class,
+which provides facilities for managing the lifetime of a QEMU VM.
+"""
+
 # Copyright (C) 2015-2016 Red Hat Inc.
 # Copyright (C) 2012 IBM Corp.
 #
@@ -16,7 +21,6 @@ import errno
 import logging
 import os
 import subprocess
-import re
 import shutil
 import socket
 import tempfile
@@ -119,8 +123,10 @@ class QEMUMachine(object):
         self.shutdown()
         return False
 
-    # This can be used to add an unused monitor instance.
     def add_monitor_null(self):
+        """
+        This can be used to add an unused monitor instance.
+        """
         self._args.append('-monitor')
         self._args.append('null')
 
@@ -143,10 +149,13 @@ class QEMUMachine(object):
         self._args.append(','.join(options))
         return self
 
-    # Exactly one of fd and file_path must be given.
-    # (If it is file_path, the helper will open that file and pass its
-    # own fd)
     def send_fd_scm(self, fd=None, file_path=None):
+        """
+        Send an fd or file_path to socket_scm_helper.
+
+        Exactly one of fd and file_path must be given.
+        If it is file_path, the helper will open that file and pass its own fd.
+        """
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
         if self._socket_scm_helper is None:
@@ -194,14 +203,17 @@ class QEMUMachine(object):
             raise
 
     def is_running(self):
+        """Returns true if the VM is running."""
         return self._popen is not None and self._popen.poll() is None
 
     def exitcode(self):
+        """Returns the exit code if possible, or None."""
         if self._popen is None:
             return None
         return self._popen.poll()
 
     def get_pid(self):
+        """Returns the PID of the running process, or None."""
         if not self.is_running():
             return None
         return self._popen.pid
@@ -339,7 +351,7 @@ class QEMUMachine(object):
                 command = ' '.join(self._qemu_full_args)
             else:
                 command = ''
-            LOG.warn(msg, -exitcode, command)
+            LOG.warning(msg, -exitcode, command)
 
         self._launched = False
 
@@ -373,7 +385,7 @@ class QEMUMachine(object):
         """
         Poll for one queued QMP events and return it
         """
-        if len(self._events) > 0:
+        if self._events:
             return self._events.pop(0)
         return self._qmp.pull_event(wait=wait)
 
@@ -441,8 +453,7 @@ class QEMUMachine(object):
         """
         def _match(event):
             for name, match in events:
-                if (event['event'] == name and
-                    self.event_match(event, match)):
+                if event['event'] == name and self.event_match(event, match):
                     return True
             return False
 
-- 
2.18.0.rc1.1.g3f1ff2140


