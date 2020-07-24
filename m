Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:54:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F01920714
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 06:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czH50u3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F01920714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyrax-0002LR-C8
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 02:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSZ-0004Qc-OD
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:35 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:38570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jyrSV-0000M8-Dp
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 02:45:34 -0400
Received: by mail-wr1-x42d.google.com with SMTP id a14so7260674wra.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 23:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tbuf3a7z9rzul3Y2V8EPpXFJXL5dyVGH3TuBWvwpmx8=;
 b=czH50u3rdbRKcqYW6O5nHGT5vMnGOw9i0OwjLR9SQG4rOaIMI9u9Jv18+prPTSZikr
 qqeoY1yHgC/uiPjNtO/w+JlF3gLsXoZp+YJoMfsNjoPpuXCIwYvqZgBbnLuagimF90+q
 7wXvzW2NktKCzk7QeleUf3bjBpSckUgzuySjJwzPGosKsQAqi0/MJSdrF9bK5dVytEOF
 cyUvKNdSswW+EROQEIqPf9TT/QBCAbAGgITpF1mzqB6vIDZc7P8aFWZSd2sWnbT8xCf1
 7xdED4O5dDCDK19NxIGSALZdbeKVXjHIlTSaHQQiEoZKh4hMKs3AuQJHmk9YtgNqYksk
 5sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tbuf3a7z9rzul3Y2V8EPpXFJXL5dyVGH3TuBWvwpmx8=;
 b=tn6+9hptF+TCff8rn9itLIC1TtYZoRPKUQ/81v3//dp5PoiLUCkLxWUnwMdhpdwTbs
 /HSxUhmQ9vxU0WCQweWRsS2Qpgc7V23XaxHP/L3DQvVuIQ5YEJiefiq52c7VuNB51O6G
 5se3Dz+bHxL0knoJRTajE1beXnmZFjFqRxl6fvcGQYdX2ZxkDY2LlSI7JkwUFBTCvJAe
 AiRiYMdvoCiePKRq6h3bHj109BlmmJuGKe5X6OYiuGH18XcCy/u7oyEofnX8n9RGJFDG
 lpiDtu512Wer6PFMfWUZLhHbvR9LCRgswGVlrUtwzkhtS27Ss7i0nBsfFEwMqfxT+hG0
 8nNQ==
X-Gm-Message-State: AOAM533iUtdjeRUF0X1QNnovR0kUo5faiz2QMzydFLTH1DTXqAHh/Lif
 qPwa3cXraCyuOAfNVzpDqZUi1w==
X-Google-Smtp-Source: ABdhPJx8d5WF7+hLXNs1tf9nKP8IP8/Mc+lLtfLjrJsAmqqc0+2oq0IRMUXWq4rnlGDQxjzPHwwDrw==
X-Received: by 2002:a5d:69c8:: with SMTP id s8mr7001947wrw.405.1595573128712; 
 Thu, 23 Jul 2020 23:45:28 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 1sm5940977wmf.21.2020.07.23.23.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 23:45:23 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 79DD81FF9D;
 Fri, 24 Jul 2020 07:45:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 14/16] python/qemu: Cleanup changes to ConsoleSocket
Date: Fri, 24 Jul 2020 07:45:07 +0100
Message-Id: <20200724064509.331-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724064509.331-1-alex.bennee@linaro.org>
References: <20200724064509.331-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, Robert Foley <robert.foley@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 Cleber Rosa <crosa@redhat.com>, aurelien@aurel32.net,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Robert Foley <robert.foley@linaro.org>

The changes to console_socket.py and machine.py are to
cleanup for pylint and flake8.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200717203041.9867-2-robert.foley@linaro.org>
---
 python/qemu/console_socket.py | 57 ++++++++++++++++++-----------------
 python/qemu/machine.py        |  7 +++--
 python/qemu/pylintrc          |  2 +-
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index 830cb7c6282..09986bc2152 100644
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
index 80c4d4a8b6e..9956360a792 100644
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
index 5d6ae7367d8..3f69205000d 100644
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
2.20.1


