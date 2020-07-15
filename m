Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B26C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32A02065D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 20:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u+gJ9ZkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32A02065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvoON-0007d7-1B
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 16:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNT-0006lb-Mm
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:43 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:37941)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jvoNR-0007cD-Qq
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 16:51:43 -0400
Received: by mail-pg1-x530.google.com with SMTP id e8so3687455pgc.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=d0DQZ4XAnceFkT+jYOSc41CpJ7JreWYbu8IXKbrkQ78=;
 b=u+gJ9ZkMvoqR6H98pxjsXx+4BPh+bHJdT92Q3E35bT8ovLMcKUiUuhWbNl502NJTaf
 rewGruZIyzfyc43e62JEQRcW6xE6dPuiPku7DR26pC2bhBKfygJUUzrlFIQ7KMB1OGKI
 TkBGC116xkoy7JuTt2PDcxNQYoNOv2/IuBKJw7F+uxVJzRLB7pyJLMSjyj4K3ktV7j+p
 ZfGscd9fTggjy7uJt0Tri0sJbcY/FUJOnaIUgd2tEUE4rMwQmmvPLfEGs9Kn+dB2fMO+
 rO1d84y0wlzpqg3sLxFlG+k27l4DDft93DUvkMvLFwYsYV1vsti7bPvfBcI2eLrY8wTz
 wMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=d0DQZ4XAnceFkT+jYOSc41CpJ7JreWYbu8IXKbrkQ78=;
 b=D3IBoAzvPu9NeAOTh9S13O7Dt8o3JABdSP/ceMNYhTp3RExl5MQGSNcUJKvTKs8zxj
 ZJWygJ4MNXTr5jJvTPHXnQlWUndrRWqXiPaY6MbZHXBRfpJJLSd8R66twKgtH0Z32uIZ
 IEWoXxwYE3nIRdx+ZqB7HatGuwsQMKHKyIIabnzVeHcneN7T4QmTTINzBRtaCFD6TVnt
 2cVl7TOsgUvLgAIsqEZTT/r2vh2Nfl49kycLAPTk653PNhC2v7ELQjaTw4V4xvU6c2Vg
 T8b4OQqi1n7KO0IRnDMM0ay7zgJZRfX945C9Fl5h1EdnmWp5fMNqZlUG/ScVX5XhSQdo
 WkJQ==
X-Gm-Message-State: AOAM532fyBqBTCLVxeHGvqLsRgajNeAFdiGWtFa0XSB7Ahu5RZkvshdw
 n0ZNOsa/+OjSmsb0swxe5kmRFKod75mZ8w==
X-Google-Smtp-Source: ABdhPJzq8XhBdwWdGOfCK16XMHO5tUYpi4sYptFwCuXBHybfj1DEOKQm2Lm1Wt/nvs5q0oK/0sJo2w==
X-Received: by 2002:a63:545e:: with SMTP id e30mr1405973pgm.62.1594846300028; 
 Wed, 15 Jul 2020 13:51:40 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 (c-73-47-162-176.hsd1.ma.comcast.net. [73.47.162.176])
 by smtp.gmail.com with ESMTPSA id 66sm2687690pfg.63.2020.07.15.13.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 13:51:39 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] python/qemu: Cleanup changes to ConsoleSocket
Date: Wed, 15 Jul 2020 16:48:13 -0400
Message-Id: <20200715204814.2630-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715204814.2630-1-robert.foley@linaro.org>
References: <20200715204814.2630-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x530.google.com
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

The changes to console_socket.py and machine.py are to
cleanup for pylint and flake8.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 58 +++++++++++++++++------------------
 python/qemu/machine.py        |  7 +++--
 python/qemu/pylintrc          |  2 +-
 3 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 830cb7c628..6a746c1dbf 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -1,12 +1,9 @@
-#!/usr/bin/env python3
-#
-# This python module implements a ConsoleSocket object which is
-# designed always drain the socket itself, and place
-# the bytes into a in memory buffer for later processing.
-#
-# Optionally a file path can be passed in and we will also
-# dump the characters to this file for debug.
-#
+"""
+QEMU Console Socket Module:
+
+This python module implements a ConsoleSocket object,
+which can drain a socket and optionally dump the bytes to file.
+"""
 # Copyright 2020 Linaro
 #
 # Authors:
@@ -15,20 +12,27 @@
 # This code is licensed under the GPL version 2 or later.  See
 # the COPYING file in the top-level directory.
 #
+
 import asyncore
 import socket
 import threading
-import io
-import os
-import sys
 from collections import deque
 import time
-import traceback
+
 
 class ConsoleSocket(asyncore.dispatcher):
+    """
+    ConsoleSocket represents a socket attached to a char device.
 
+    Drains the socket and places the bytes into an in memory buffer
+    for later processing.
+
+    Optionally a file path can be passed in and we will also
+    dump the characters to this file for debugging purposes.
+    """
     def __init__(self, address, file=None):
         self._recv_timeout_sec = 300
+        self._sleep_time = 0.5
         self._buffer = deque()
         self._asyncore_thread = None
         self._sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
@@ -70,31 +74,28 @@ class ConsoleSocket(asyncore.dispatcher):
 
     def handle_read(self):
         """process arriving characters into in memory _buffer"""
-        try:
-            data = asyncore.dispatcher.recv(self, 1)
-            # latin1 is needed since there are some chars
-            # we are receiving that cannot be encoded to utf-8
-            # such as 0xe2, 0x80, 0xA6.
-            string = data.decode("latin1")
-        except:
-            print("Exception seen.")
-            traceback.print_exc()
-            return
+        data = asyncore.dispatcher.recv(self, 1)
+        # latin1 is needed since there are some chars
+        # we are receiving that cannot be encoded to utf-8
+        # such as 0xe2, 0x80, 0xA6.
+        string = data.decode("latin1")
         if self._logfile:
             self._logfile.write("{}".format(string))
             self._logfile.flush()
         for c in string:
             self._buffer.extend(c)
 
-    def recv(self, n=1, sleep_delay_s=0.1):
-        """Return chars from in memory buffer"""
+    def recv(self, buffer_size=1):
+        """Return chars from in memory buffer.
+           Maintains the same API as socket.socket.recv.
+        """
         start_time = time.time()
-        while len(self._buffer) < n:
-            time.sleep(sleep_delay_s)
+        while len(self._buffer) < buffer_size:
+            time.sleep(self._sleep_time)
             elapsed_sec = time.time() - start_time
             if elapsed_sec > self._recv_timeout_sec:
                 raise socket.timeout
-        chars = ''.join([self._buffer.popleft() for i in range(n)])
+        chars = ''.join([self._buffer.popleft() for i in range(buffer_size)])
         # We choose to use latin1 to remain consistent with
         # handle_read() and give back the same data as the user would
         # receive if they were reading directly from the
@@ -103,7 +104,6 @@ class ConsoleSocket(asyncore.dispatcher):
 
     def set_blocking(self):
         """Maintain compatibility with socket API"""
-        pass
 
     def settimeout(self, seconds):
         """Set current timeout on recv"""
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index c25f0b42cf..6769359766 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -26,7 +26,7 @@ import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
-from qemu.console_socket import ConsoleSocket
+from . import console_socket
 
 from . import qmp
 
@@ -592,8 +592,9 @@ class QEMUMachine:
         """
         if self._console_socket is None:
             if self._drain_console:
-                self._console_socket = ConsoleSocket(self._console_address,
-                                                    file=self._console_log_path)
+                self._console_socket = console_socket.ConsoleSocket(
+                    self._console_address,
+                    file=self._console_log_path)
             else:
                 self._console_socket = socket.socket(socket.AF_UNIX,
                                                      socket.SOCK_STREAM)
diff --git a/python/qemu/pylintrc b/python/qemu/pylintrc
index 5d6ae7367d..3f69205000 100644
--- a/python/qemu/pylintrc
+++ b/python/qemu/pylintrc
@@ -33,7 +33,7 @@ good-names=i,
            Run,
            _,
            fd,
-
+           c,
 [VARIABLES]
 
 [STRING]
-- 
2.17.1


