Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB632C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E3C208E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E3C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgc4U-0001ay-UN
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60021)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hgbwl-00058X-7T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:28:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hgbwk-0007nV-2x
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 17:28:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47894)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hgbwh-0007kb-Dd; Thu, 27 Jun 2019 17:28:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5D2603082A8F;
 Thu, 27 Jun 2019 21:28:28 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-47.bos.redhat.com [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 558DE5D9E2;
 Thu, 27 Jun 2019 21:28:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 17:28:15 -0400
Message-Id: <20190627212816.27298-3-jsnow@redhat.com>
In-Reply-To: <20190627212816.27298-1-jsnow@redhat.com>
References: <20190627212816.27298-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 27 Jun 2019 21:28:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH v2 2/3] machine.py: minor delinting
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we're out in a new module, do a quick cursory pass of some of the
more obvious style issues.

Signed-off-by: John Snow <jsnow@redhat.com>
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
=20
-    # This can be used to add an unused monitor instance.
     def add_monitor_null(self):
+        """
+        This can be used to add an unused monitor instance.
+        """
         self._args.append('-monitor')
         self._args.append('null')
=20
@@ -143,10 +149,13 @@ class QEMUMachine(object):
         self._args.append(','.join(options))
         return self
=20
-    # Exactly one of fd and file_path must be given.
-    # (If it is file_path, the helper will open that file and pass its
-    # own fd)
     def send_fd_scm(self, fd=3DNone, file_path=3DNone):
+        """
+        Send an fd or file_path to socket_scm_helper.
+
+        Exactly one of fd and file_path must be given.
+        If it is file_path, the helper will open that file and pass its =
own fd.
+        """
         # In iotest.py, the qmp should always use unix socket.
         assert self._qmp.is_scm_available()
         if self._socket_scm_helper is None:
@@ -194,14 +203,17 @@ class QEMUMachine(object):
             raise
=20
     def is_running(self):
+        """Returns true if the VM is running."""
         return self._popen is not None and self._popen.poll() is None
=20
     def exitcode(self):
+        """Returns the exit code if possible, or None."""
         if self._popen is None:
             return None
         return self._popen.poll()
=20
     def get_pid(self):
+        """Returns the PID of the running process, or None."""
         if not self.is_running():
             return None
         return self._popen.pid
@@ -339,7 +351,7 @@ class QEMUMachine(object):
                 command =3D ' '.join(self._qemu_full_args)
             else:
                 command =3D ''
-            LOG.warn(msg, -exitcode, command)
+            LOG.warning(msg, -exitcode, command)
=20
         self._launched =3D False
=20
@@ -373,7 +385,7 @@ class QEMUMachine(object):
         """
         Poll for one queued QMP events and return it
         """
-        if len(self._events) > 0:
+        if self._events:
             return self._events.pop(0)
         return self._qmp.pull_event(wait=3Dwait)
=20
@@ -441,8 +453,7 @@ class QEMUMachine(object):
         """
         def _match(event):
             for name, match in events:
-                if (event['event'] =3D=3D name and
-                    self.event_match(event, match)):
+                if event['event'] =3D=3D name and self.event_match(event=
, match):
                     return True
             return False
=20
--=20
2.21.0


