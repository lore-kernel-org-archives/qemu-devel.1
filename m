Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F57C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6197720684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 20:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oRZaLHdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6197720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwX6H-0007il-LM
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 16:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX5J-0006Dz-Mx
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:35:57 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535]:44943)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jwX5H-0000U7-Nh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 16:35:57 -0400
Received: by mail-pg1-x535.google.com with SMTP id j19so7190751pgm.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 13:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YZOBwBBn9Q8zZljvmjtMM12SRKnwyEyG67balOtqryk=;
 b=oRZaLHdGz/gywpAQP7qTgsGbf1z1BVX493v3sfLJM7OrkHG/5Zty0pdSz0jfUtYqAm
 Bvl/YZeBTnlFQtJLu5gViOVbKDQGApxY4sy6PJyFO3d+0zsGgW3ebHJwjgSrwRw0pWID
 by20Kh39yq1QmjwwzBgpQFKxu/ujGqUIfIS4CXERqOduF0M+89O6LUDiSkREQPn7ajgd
 OScXC0nBdlI9+tqZEtvIFUDjMJxGy55MrUn/hPN884fE6cvS99+4nUc5D3NRv/IrOhxe
 zVh4FO9fTWtiTGv3GchygZFSCrMvP6aw9UU6VNrFez2bQTALeewQ34Y7Tc4nIC2VSqQK
 nTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YZOBwBBn9Q8zZljvmjtMM12SRKnwyEyG67balOtqryk=;
 b=aoojO37XrqocY0I4bqSG5ve4I3rvS1txnJSrUFaQy6mpnVolxXLfXHps+cfPFYpPPG
 8vtLc8EJf5MLfcS9z43zveEFrz0gx5rXfjg0hg3pF0UqixZGPSbd8ddRNO+7cBc9p2kM
 ApD7YG8XckpDrASNkud7xI2pWWkPBTnKDKKXvJlDaVEr3aGPghq9Yh2EQo6rlyjUMi05
 59a6ulSkuZhXOjnVCf44YSL6sbiLbyGTpGk8E+Gn83klh+nyUu6aAvBAyXknt2sWgVJK
 GsWPAxtEgj2qYviHX2577nIXg5gvUIxWxe8fDrJo0o8vCDL5EnRpvbr9iJjGDZN1vM/s
 wwzw==
X-Gm-Message-State: AOAM530UQl0gkkrOdI2inGgavNtjbTS/Du06ofaDdgLPS0/upTrqhkrF
 sGoX6+/oFspGKuw59396ZGE9OKNEjno=
X-Google-Smtp-Source: ABdhPJxtCtyP3TAlIRTARH3WeYjqQ2+Q5eFYRNsGdCuYUMF0kdnvDrXb0+eQqhI5tzTE1JJ9QeJNSQ==
X-Received: by 2002:a63:cd4d:: with SMTP id a13mr10216595pgj.49.1595018153631; 
 Fri, 17 Jul 2020 13:35:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:b0d0:3aae:620c:a8c5])
 by smtp.gmail.com with ESMTPSA id x7sm8212848pfq.197.2020.07.17.13.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2020 13:35:52 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] python/qemu: Cleanup changes to ConsoleSocket
Date: Fri, 17 Jul 2020 16:30:39 -0400
Message-Id: <20200717203041.9867-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717203041.9867-1-robert.foley@linaro.org>
References: <20200717203041.9867-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=robert.foley@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 57 ++++++++++++++++++-----------------
 python/qemu/machine.py        |  7 +++--
 python/qemu/pylintrc          |  2 +-
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 830cb7c628..09986bc215 100644
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
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index 80c4d4a8b6..9956360a79 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -27,7 +27,7 @@ import socket
 import tempfile
 from typing import Optional, Type
 from types import TracebackType
-from qemu.console_socket import ConsoleSocket
+from . import console_socket
 
 from . import qmp
 
@@ -674,8 +674,9 @@ class QEMUMachine:
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


