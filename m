Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA3FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:37:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DAD20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DM3WCwv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DAD20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02NJ-0007X4-11
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02JB-0002no-K8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:32:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:34506)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k02J7-0007Sw-Qt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:32:45 -0400
Received: by mail-wr1-x42f.google.com with SMTP id f7so14724188wrw.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8y6ixeIPgJW86fjgIL3Yvs/KvQizsaV1ZAK37O5WFus=;
 b=DM3WCwv71sJo7LObRORAeYVh+LMSx0nkIQA5OEYmXGC9KE6aVC9HbDFNb1OkVgXIgg
 kdhLMxacNe8u2Z6TedyPuT41tl5NWo2bnbUX06Esw3p2VRFHcJlUp1oXQjTHdMHd3Yla
 JoekFOsble9nEyLd96S9hyCTiQpXzlwa5JhihoBynbFeZXE7H8zJrhIsEqt3e8PAeGaF
 vZCgnygMP47IwcahfewsafNVuNypJaU6btd0s+Fm3pbh3NHoZbRwwmn/vrH8MIKHeKkG
 qZbGZI1PV8r7hJTP3BaMn7W2bgyTXWJx/S21QsFIN7A2q0B7oUd6tXO7X1kdWUxtTgeA
 P6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8y6ixeIPgJW86fjgIL3Yvs/KvQizsaV1ZAK37O5WFus=;
 b=mLygHTE6Y7YkMJw2rSxbmMzP59F7GUw+/6rXGqhuL9CfuxSlX4+0yQmxLLgO6YtjCu
 T/PkaxmuLX6mZcyhpIuBY7iriDKKGKLfzjiKKj9Kr8SzhURHeU1UUvxyN5GpcCTpDwJe
 FO+xgB9M7QxdXN2wmc3TXFSMgwtIItVdFql+DLpWOM+JK4oBZcn/p1ZQFYYqeNKMEnVg
 5kYjE2583zl36uTxavG9WgXblJaTrthxlOWp5NDCVk4eZ9ZBeFly3YCqKQViAuxytdEo
 A3laDpRGbw9J7Cxp04dok9zUW1n5VGB0yZpj71cHCGZuLnLyd4V3T8tcMPiPuvG+gAxr
 HJRQ==
X-Gm-Message-State: AOAM531oqF+lREaTCqowIrxLb1VxSxQYNO7fDVyWKxgKqxrOk67CAxB9
 6rcDrkRnRhWvGKYnQ+lzsWqWaA==
X-Google-Smtp-Source: ABdhPJx9zwS3YB8uXuH+1JOW4PrFuz0cAYPhC6/CSA6tKzEvgqeqwCNI+5FM/t0xkYmq9/hdEusezA==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr19041904wrq.243.1595853157251; 
 Mon, 27 Jul 2020 05:32:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z6sm12993226wrs.36.2020.07.27.05.32.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 05:32:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C3E121FF9E;
 Mon, 27 Jul 2020 13:23:58 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/16] python/qemu: Change ConsoleSocket to optionally drain
 socket.
Date: Mon, 27 Jul 2020 13:23:56 +0100
Message-Id: <20200727122357.31263-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200727122357.31263-1-alex.bennee@linaro.org>
References: <20200727122357.31263-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Robert Foley <robert.foley@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

The primary purpose of this change is to clean up
machine.py's console_socket property to return a single type,
a ConsoleSocket.

ConsoleSocket now derives from a socket, which means that
in the default case (of not draining), machine.py
will see the same behavior as it did prior to ConsoleSocket.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200717203041.9867-3-robert.foley@linaro.org>
Message-Id: <20200724064509.331-16-alex.bennee@linaro.org>

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 09986bc2152..70869fbbdc4 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -13,68 +13,75 @@ which can drain a socket and optionally dump the bytes to file.
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
+        socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
+        self.connect(address)
         self._logfile = None
         if file:
             self._logfile = open(file, "w")
-        asyncore.dispatcher.__init__(self, sock=self._sock)
         self._open = True
-        self._thread_start()
+        if drain:
+            self._drain_thread = self._thread_start()
+        else:
+            self._drain_thread = None
 
-    def _thread_start(self):
-        """Kick off a thread to wait on the asyncore.loop"""
-        if self._asyncore_thread is not None:
-            return
-        self._asyncore_thread = threading.Thread(target=asyncore.loop,
-                                                 kwargs={'timeout':1})
-        self._asyncore_thread.daemon = True
-        self._asyncore_thread.start()
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
 
-    def handle_close(self):
-        """redirect close to base class"""
-        # Call the base class close, but not self.close() since
-        # handle_close() occurs in the context of the thread which
-        # self.close() attempts to join.
-        asyncore.dispatcher.close(self)
+    def _thread_start(self):
+        """Kick off a thread to drain the socket."""
+        # Configure socket to not block and timeout.
+        # This allows our drain thread to not block
+        # on recieve and exit smoothly.
+        socket.socket.setblocking(self, False)
+        socket.socket.settimeout(self, 1)
+        drain_thread = threading.Thread(target=self._drain_fn)
+        drain_thread.daemon = True
+        drain_thread.start()
+        return drain_thread
 
     def close(self):
         """Close the base object and wait for the thread to terminate"""
         if self._open:
             self._open = False
-            asyncore.dispatcher.close(self)
-            if self._asyncore_thread is not None:
-                thread, self._asyncore_thread = self._asyncore_thread, None
+            if self._drain_thread is not None:
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
@@ -85,27 +92,38 @@ class ConsoleSocket(asyncore.dispatcher):
         for c in string:
             self._buffer.extend(c)
 
-    def recv(self, buffer_size=1):
+    def recv(self, bufsize=1):
         """Return chars from in memory buffer.
            Maintains the same API as socket.socket.recv.
         """
+        if self._drain_thread is None:
+            # Not buffering the socket, pass thru to socket.
+            return socket.socket.recv(self, bufsize)
         start_time = time.time()
-        while len(self._buffer) < buffer_size:
+        while len(self._buffer) < bufsize:
             time.sleep(self._sleep_time)
             elapsed_sec = time.time() - start_time
             if elapsed_sec > self._recv_timeout_sec:
                 raise socket.timeout
-        chars = ''.join([self._buffer.popleft() for i in range(buffer_size)])
+        chars = ''.join([self._buffer.popleft() for i in range(bufsize)])
         # We choose to use latin1 to remain consistent with
         # handle_read() and give back the same data as the user would
         # receive if they were reading directly from the
         # socket w/o our intervention.
         return chars.encode("latin1")
 
-    def set_blocking(self):
-        """Maintain compatibility with socket API"""
-        pass
+    def setblocking(self, value):
+        """When not draining we pass thru to the socket,
+           since when draining we control socket blocking.
+        """
+        if self._drain_thread is None:
+            socket.socket.setblocking(self, value)
 
     def settimeout(self, seconds):
-        """Set current timeout on recv"""
-        self._recv_timeout_sec = seconds
+        """When not draining we pass thru to the socket,
+           since when draining we control the timeout.
+        """
+        if seconds is not None:
+            self._recv_timeout_sec = seconds
+        if self._drain_thread is None:
+            socket.socket.settimeout(self, seconds)
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index a09768e9f92..82f3731fc3f 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -23,7 +23,6 @@ import os
 import subprocess
 import shutil
 import signal
-import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
@@ -673,12 +672,8 @@ class QEMUMachine:
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
2.20.1


