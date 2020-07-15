Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297D5C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB45920672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TPkxPsWf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB45920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvoPS-0000VR-5g
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 16:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50214)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNW-0006oQ-2h
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:46 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:36992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNU-0007cT-6i
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:45 -0400
Received: by mail-pg1-x52d.google.com with SMTP id d4so3683610pgk.4
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 13:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0tmOibHW1cTYy3j90QIcmaNdGmLO5nvsVb0UqPEV400=;
 b=TPkxPsWfvZGgwJ7KzATi/OOZAYbHU/FSkWY053Bq62aGqU8S4a/YqzO+pQKXceYMyw
 /rcIG1Oav3dL2JR+MTH+f0D7fM9m5N8VeWd51T5E92kW939fBjzlcQTKU1arcld4kVS2
 VXYfid0Yg5tXrIXNFcEam9COLeFPOY84EUA0/V0rkawoei39Zqo7SOKKt7IX2epH1I1I
 kJKTKOElvEnCLvPIGxPOK/Yp91xKBuiXpLxkbtF23vMrERrVfjraJkfLhiyXJhYhMb57
 JpbgmJpodxqZh/dzAtxnp9N2F1Ko82s6zIOx3OAHSaf0R0q25ux5B4GtAo3ihYdNNMxL
 Ap0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0tmOibHW1cTYy3j90QIcmaNdGmLO5nvsVb0UqPEV400=;
 b=gGgUmqPQ+UwcxEMWzzVQ+eqKi/spqfoyMxAQWEveo6vpe5HKC1VOe/QYvVqT0i1aTZ
 veGSWhe23XkKzREnsS/Ira43uqS9Vnmg3VtbtWI/2YCm4Ueo9yvMaZP8B+WWeGEsjqQL
 b2XxYPLDL0FBgMQ6r3i1CYKJr8xxPqGZ2i9y0h1DnbOUB0Ue0S7m5g9aS/Vw6jtTywwf
 QbhV+H43tIRZ8Sh+vLTtQc65PjkvDC92el0ZA84SEUM7LqDtZVZFZXyVhULU6m4/D5gH
 AuwnH8KsR3K0vfLeuGZdWGMV/q8ZS4w60DwlP5EJ+X3EPgfe4jrtgyU6rMODD1KTo2/q
 mFcg==
X-Gm-Message-State: AOAM531GAxKeWvFjJeUWS7rjir2UO8VKOykJOshFbm2QtuPWyBBU6lLa
 9cmtHR7Ue/xYERvfk0J8VcrWR42HA1yMgQ==
X-Google-Smtp-Source: ABdhPJyrJF7qL6djQazs0nDzk9xEtqsYGVVLqCQv90dDySM5P3A3f1uAoVsVtoAjjDXOfgLlQvAzmg==
X-Received: by 2002:a63:e556:: with SMTP id z22mr1359680pgj.130.1594846302164; 
 Wed, 15 Jul 2020 13:51:42 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id 66sm2687690pfg.63.2020.07.15.13.51.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 13:51:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] python/qemu: Change ConsoleSocket to optionally drain
 socket.
Date: Wed, 15 Jul 2020 16:48:14 -0400
Message-Id: <20200715204814.2630-3-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715204814.2630-1-robert.foley@linaro.org>
References: <20200715204814.2630-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: robert.foley@linaro.org, jsnow@redhat.com, Cleber Rosa <crosa@redhat.com>,
 peter.puhov@linaro.org, alex.bennee@linaro.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The primary purpose of this change is to clean up
machine.py's console_socket property to return a single type,
a ConsoleSocket.

ConsoleSocket now derives from a socket, which means that
in the default case (of not draining), machine.py
will see the same behavior as it did prior to ConsoleSocket.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 81 +++++++++++++++++++++--------------
 python/qemu/machine.py        | 13 ++----
 2 files changed, 54 insertions(+), 40 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 6a746c1dbf..475de5b101 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -13,68 +13,76 @@ which can drain a socket and optionally dump the bytes to file.
 # the COPYING file in the top-level directory.
 #
 
-import asyncore
 import socket
 import threading
 from collections import deque
 import time
 
 
-class ConsoleSocket(asyncore.dispatcher):
+class ConsoleSocket(socket.socket):
     """
     ConsoleSocket represents a socket attached to a char device.
 
-    Drains the socket and places the bytes into an in memory buffer
-    for later processing.
+    Optionally (if drain==True), drains the socket and places the bytes
+    into an in memory buffer for later processing.
 
     Optionally a file path can be passed in and we will also
     dump the characters to this file for debugging purposes.
     """
-    def __init__(self, address, file=None):
+    def __init__(self, address, file=None, drain=False):
         self._recv_timeout_sec = 300
         self._sleep_time = 0.5
         self._buffer = deque()
-        self._asyncore_thread = None
-        self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
-        self._sock.connect(address)
+        self._drain_thread = None
+        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
+        self.connect(address)
+        self._drain = drain
         self._logfile = None
         if file:
             self._logfile = open(file, "w")
-        asyncore.dispatcher.__init__(self, sock=self._sock)
         self._open = True
-        self._thread_start()
+        if drain:
+            self._thread_start()
+
+    def _drain_fn(self):
+        """Drains the socket and runs while the socket is open."""
+        while self._open:
+            try:
+                self._drain_socket()
+            except socket.timeout:
+                # The socket is expected to timeout since we set a
+                # short timeout to allow the thread to exit when
+                # self._open is set to False.
+                time.sleep(self._sleep_time)
 
     def _thread_start(self):
-        """Kick off a thread to wait on the asyncore.loop"""
-        if self._asyncore_thread is not None:
+        """Kick off a thread to drain the socket."""
+        if self._drain_thread is not None:
             return
-        self._asyncore_thread = threading.Thread(target=asyncore.loop,
-                                                 kwargs={'timeout':1})
-        self._asyncore_thread.daemon = True
-        self._asyncore_thread.start()
-
-    def handle_close(self):
-        """redirect close to base class"""
-        # Call the base class close, but not self.close() since
-        # handle_close() occurs in the context of the thread which
-        # self.close() attempts to join.
-        asyncore.dispatcher.close(self)
+        # Configure socket to not block and timeout.
+        # This allows our drain thread to not block
+        # on recieve and exit smoothly.
+        socket.socket.setblocking(self, 0)
+        socket.socket.settimeout(self, 1)
+        self._drain_thread = threading.Thread(target=self._drain_fn)
+        self._drain_thread.daemon = True
+        self._drain_thread.start()
 
     def close(self):
         """Close the base object and wait for the thread to terminate"""
         if self._open:
             self._open = False
-            asyncore.dispatcher.close(self)
-            if self._asyncore_thread is not None:
-                thread, self._asyncore_thread = self._asyncore_thread, None
+            if self._drain and self._drain_thread is not None:
+                thread, self._drain_thread = self._drain_thread, None
                 thread.join()
+            socket.socket.close(self)
             if self._logfile:
                 self._logfile.close()
                 self._logfile = None
 
-    def handle_read(self):
+    def _drain_socket(self):
         """process arriving characters into in memory _buffer"""
-        data = asyncore.dispatcher.recv(self, 1)
+        data = socket.socket.recv(self, 1)
         # latin1 is needed since there are some chars
         # we are receiving that cannot be encoded to utf-8
         # such as 0xe2, 0x80, 0xA6.
@@ -89,6 +97,9 @@ class ConsoleSocket(asyncore.dispatcher):
         """Return chars from in memory buffer.
            Maintains the same API as socket.socket.recv.
         """
+        if not self._drain:
+            # Not buffering the socket, pass thru to socket.
+            return socket.socket.recv(self, buffer_size)
         start_time = time.time()
         while len(self._buffer) < buffer_size:
             time.sleep(self._sleep_time)
@@ -102,9 +113,17 @@ class ConsoleSocket(asyncore.dispatcher):
         # socket w/o our intervention.
         return chars.encode("latin1")
 
-    def set_blocking(self):
-        """Maintain compatibility with socket API"""
+    def setblocking(self, value):
+        """When not draining we pass thru to the socket,
+           since when draining we control socket blocking.
+        """
+        if not self._drain:
+            socket.socket.setblocking(self, value)
 
     def settimeout(self, seconds):
-        """Set current timeout on recv"""
+        """When not draining we pass thru to the socket,
+           since when draining we control the timeout.
+        """
         self._recv_timeout_sec = seconds
+        if not self._drain:
+            socket.socket.settimeout(self, seconds)
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 6769359766..62709d86e4 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -22,7 +22,6 @@ import logging
 import os
 import subprocess
 import shutil
-import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
@@ -591,12 +590,8 @@ class QEMUMachine:
         Returns a socket connected to the console
         """
         if self._console_socket is None:
-            if self._drain_console:
-                self._console_socket = console_socket.ConsoleSocket(
-                    self._console_address,
-                    file=self._console_log_path)
-            else:
-                self._console_socket = socket.socket(socket.AF_UNIX,
-                                                     socket.SOCK_STREAM)
-                self._console_socket.connect(self._console_address)
+            self._console_socket = console_socket.ConsoleSocket(
+                self._console_address,
+                file=self._console_log_path,
+                drain=self._drain_console)
         return self._console_socket
-- 
2.17.1


