Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4380CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D17020656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuB2go+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D17020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jshng-0004nx-7s
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshjB-0004oq-PC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:17 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44809)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshj8-00045T-4p
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:09:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id b6so43950843wrs.11
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gDtGcpZv1Rvonc6KqJMOc0i8D0gnp8nnG/k6JUeeZcs=;
 b=DuB2go+SQJv57EfL3j3/236c9S28H6/YCp5R3Q0HGig60gbZTyddROdVRVbQhLX9QG
 QdiIT+tEcXC5vZvjWQabR8vkEj5EvTPCos3waRQseTrB55ZUEiTPszAKCc6Ep3NY86fc
 1mDL5fImXKzP99QclIWy8qFjmPFvB607Sj1gkY935crM4SHE8+dGTRhs6SaQAt3s+XxO
 sqYFY8U8Qer4b7YiF/Q2ZHM9ehN3wBxpxeH+Y8Lvzz571whzbBXnuk07weOsQg0JSW/d
 /uPcUZUt99kyKqebqTRQ9Y7b6LThqdcYvKEVUIllAmt/fa5yThQmwrFbTURhQPzTqfxc
 tSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gDtGcpZv1Rvonc6KqJMOc0i8D0gnp8nnG/k6JUeeZcs=;
 b=IRZg5Aax2Amvhw1KD8cpt6X/Zke50W0sb0DEYvpvMR6RthUKhM/V6JOMTnzMJOcjcc
 W9HO6Xg6vY2MsYvwrqRdou6b8MTtc15nxTTVc9CQA6EQLruwE0eannevDhU+KW74mzSF
 TJJPfcOX8c0tylkc1gL/yzTeGHb5H3GMJLE+tzae54Md8c19BPZ5ezn3TqXZu+v+Mz4c
 N+x/rSx7NaxvLmKUkuzJOucqiNWC5pBv3+JDJnFSjwNvITwd3cyWkfemV+sQTZ0sp1DQ
 v2vdvD2IOo1gnQFFqNh4z16AZtvoUZtllR7bmXYchChZPYjungCTUVsFXxDUtmNVWAQL
 1c2w==
X-Gm-Message-State: AOAM532/rBiNDr3GeH3NOz4IYn9TtjqoovpvE6y94ZV0l1cz9AeCymLg
 M0h4nWxzJQaqzfnMttDgm0XpS1dbeug=
X-Google-Smtp-Source: ABdhPJwll1isfZGvFonfS67QXy4OBBvwMLxCZQU/80fHATmIem7u2Oimr+YDtZskKoL73Ew/bKzIjw==
X-Received: by 2002:adf:8024:: with SMTP id 33mr56289077wrk.117.1594105752686; 
 Tue, 07 Jul 2020 00:09:12 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u2sm2137834wml.16.2020.07.07.00.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:09:05 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7A15A1FF99;
 Tue,  7 Jul 2020 08:08:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/41] python/qemu: Add ConsoleSocket for optional use in
 QEMUMachine
Date: Tue,  7 Jul 2020 08:08:27 +0100
Message-Id: <20200707070858.6622-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

We add the ConsoleSocket object, which has a socket interface
and which will consume all arriving characters on the
socket, placing them into an in memory buffer.
This will also provide those chars via recv() as
would a regular socket.
ConsoleSocket also has the option of dumping
the console bytes to a log file.

We also give QEMUMachine the option of using ConsoleSocket
to drain and to use for logging console to a file.
By default QEMUMachine does not use ConsoleSocket.

This is added in preparation for use by basevm.py in a later commit.
This is a workaround we found was needed for basevm.py since
there is a known issue where QEMU will hang waiting
for console characters to be consumed.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200601211421.1277-9-robert.foley@linaro.org>
Message-Id: <20200701135652.1366-13-alex.bennee@linaro.org>

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
new file mode 100644
index 000000000000..830cb7c62825
--- /dev/null
+++ b/python/qemu/console_socket.py
@@ -0,0 +1,110 @@
+#!/usr/bin/env python3
+#
+# This python module implements a ConsoleSocket object which is
+# designed always drain the socket itself, and place
+# the bytes into a in memory buffer for later processing.
+#
+# Optionally a file path can be passed in and we will also
+# dump the characters to this file for debug.
+#
+# Copyright 2020 Linaro
+#
+# Authors:
+#  Robert Foley <robert.foley@linaro.org>
+#
+# This code is licensed under the GPL version 2 or later.  See
+# the COPYING file in the top-level directory.
+#
+import asyncore
+import socket
+import threading
+import io
+import os
+import sys
+from collections import deque
+import time
+import traceback
+
+class ConsoleSocket(asyncore.dispatcher):
+
+    def __init__(self, address, file=None):
+        self._recv_timeout_sec = 300
+        self._buffer = deque()
+        self._asyncore_thread = None
+        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+        self._sock.connect(address)
+        self._logfile = None
+        if file:
+            self._logfile = open(file, "w")
+        asyncore.dispatcher.__init__(self, sock=self._sock)
+        self._open = True
+        self._thread_start()
+
+    def _thread_start(self):
+        """Kick off a thread to wait on the asyncore.loop"""
+        if self._asyncore_thread is not None:
+            return
+        self._asyncore_thread = threading.Thread(target=asyncore.loop,
+                                                 kwargs={'timeout':1})
+        self._asyncore_thread.daemon = True
+        self._asyncore_thread.start()
+
+    def handle_close(self):
+        """redirect close to base class"""
+        # Call the base class close, but not self.close() since
+        # handle_close() occurs in the context of the thread which
+        # self.close() attempts to join.
+        asyncore.dispatcher.close(self)
+
+    def close(self):
+        """Close the base object and wait for the thread to terminate"""
+        if self._open:
+            self._open = False
+            asyncore.dispatcher.close(self)
+            if self._asyncore_thread is not None:
+                thread, self._asyncore_thread = self._asyncore_thread, None
+                thread.join()
+            if self._logfile:
+                self._logfile.close()
+                self._logfile = None
+
+    def handle_read(self):
+        """process arriving characters into in memory _buffer"""
+        try:
+            data = asyncore.dispatcher.recv(self, 1)
+            # latin1 is needed since there are some chars
+            # we are receiving that cannot be encoded to utf-8
+            # such as 0xe2, 0x80, 0xA6.
+            string = data.decode("latin1")
+        except:
+            print("Exception seen.")
+            traceback.print_exc()
+            return
+        if self._logfile:
+            self._logfile.write("{}".format(string))
+            self._logfile.flush()
+        for c in string:
+            self._buffer.extend(c)
+
+    def recv(self, n=1, sleep_delay_s=0.1):
+        """Return chars from in memory buffer"""
+        start_time = time.time()
+        while len(self._buffer) < n:
+            time.sleep(sleep_delay_s)
+            elapsed_sec = time.time() - start_time
+            if elapsed_sec > self._recv_timeout_sec:
+                raise socket.timeout
+        chars = ''.join([self._buffer.popleft() for i in range(n)])
+        # We choose to use latin1 to remain consistent with
+        # handle_read() and give back the same data as the user would
+        # receive if they were reading directly from the
+        # socket w/o our intervention.
+        return chars.encode("latin1")
+
+    def set_blocking(self):
+        """Maintain compatibility with socket API"""
+        pass
+
+    def settimeout(self, seconds):
+        """Set current timeout on recv"""
+        self._recv_timeout_sec = seconds
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 041c615052e4..c25f0b42cf60 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -26,6 +26,7 @@ import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
+from qemu.console_socket import ConsoleSocket
 
 from . import qmp
 
@@ -75,7 +76,8 @@ class QEMUMachine:
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None, sock_dir=None):
+                 socket_scm_helper=None, sock_dir=None,
+                 drain_console=False, console_log=None):
         '''
         Initialize a QEMUMachine
 
@@ -86,6 +88,9 @@ class QEMUMachine:
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()
+        @param sock_dir: where to create socket (overrides test_dir for sock)
+        @param console_log: (optional) path to console log file
+        @param drain_console: (optional) True to drain console socket to buffer
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -122,6 +127,12 @@ class QEMUMachine:
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._console_log_path = console_log
+        if self._console_log_path:
+            # In order to log the console, buffering needs to be enabled.
+            self._drain_console = True
+        else:
+            self._drain_console = drain_console
 
     def __enter__(self):
         return self
@@ -580,7 +591,11 @@ class QEMUMachine:
         Returns a socket connected to the console
         """
         if self._console_socket is None:
-            self._console_socket = socket.socket(socket.AF_UNIX,
-                                                 socket.SOCK_STREAM)
-            self._console_socket.connect(self._console_address)
+            if self._drain_console:
+                self._console_socket = ConsoleSocket(self._console_address,
+                                                    file=self._console_log_path)
+            else:
+                self._console_socket = socket.socket(socket.AF_UNIX,
+                                                     socket.SOCK_STREAM)
+                self._console_socket.connect(self._console_address)
         return self._console_socket
-- 
2.20.1


