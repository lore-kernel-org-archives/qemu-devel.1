Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9D6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75BCF207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 13:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FgxTFPU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BCF207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb2NN-0000YN-LN
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 09:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gy-0005Tp-9M
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:08 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:35952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jb2Gw-0008OH-Ny
 for qemu-devel@nongnu.org; Tue, 19 May 2020 09:27:07 -0400
Received: by mail-qt1-x835.google.com with SMTP id v4so11078187qte.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 06:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=DgaXfU5goYrCDU70XgTqwEk3vbP0ZJEhR/RUtnS+QaQ=;
 b=FgxTFPU3A5WmZronrUoRwb1AJ7ombyttj1WoU5gzU9rLxTUCu8Lo89NLOfTy2dTAN1
 giJqgeZF4gR/dyupZ8Z4PX6k0+YMyniJRkPms5LMYnz5ao+vZN86VC+eiS8Xd5qeaIBc
 VBymEvBu7J6tdIsbGV3R1DifT3Pe2FnsqZH4JU8pHp+a8t+AFJLZcsXu6Ug54X9A1l6p
 ySz/4ul7wsEevLPuiZoelm2irxE125sH6pQxED12k2ekGellZZjOlPjEiZvgl2hVXI0u
 2iiwSXPGJ/k6DcJZ4PeQADPYH0DCpa6pzvNjhc2nAqmt7MXK3iGKZEituk8+IpKBt4+9
 2umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=DgaXfU5goYrCDU70XgTqwEk3vbP0ZJEhR/RUtnS+QaQ=;
 b=PVYETXu5KpJ8aL8N96t+3aeMuQFhKc3a4vDtxdoclOB+nRZh+VfNDP1JARUi4xJ0dQ
 Sa22aBSAwK7OtqUG0YMXPTywOZh9+tMmQW1MlaRTSGKKBezM3yajEm+spc3N01/JkdRn
 jxY2ElsWC8DDAEcE/8/0sToFA0wB4CZMpYYYBdin7cYKLVaM1u87a3LenZvL21ZOxlmc
 ChfN9m+y4A0kZzP/OBLXcOgPW6tncYnoreYUf+8DE+Y4fZ2jJyJaAPWM+zj5HrOWQNQb
 XqVTCv0WdAfPUu59U8PkV8uQM0Ln/iKnTixLsRJf+JzPjqSJWRNvjx3EkFwtcgyG3n2r
 sFAg==
X-Gm-Message-State: AOAM530BY0j1fz6bF4kbOUDZnogudS433s3T6k3JiZMye/dbhlDrxt7x
 3Cytuel1mEacgGMaQVEv8Lx9XN68SVeTEw==
X-Google-Smtp-Source: ABdhPJyQuCKl7OfWG5faFDZSuVFmlH93duNt7uG64V31FpS8N+x6Alnp6n7cAdwTzLoIli9UqvH+Qw==
X-Received: by 2002:aed:257c:: with SMTP id w57mr21902322qtc.208.1589894825234; 
 Tue, 19 May 2020 06:27:05 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:dd6a:8c63:cd9d:ad15])
 by smtp.gmail.com with ESMTPSA id d74sm3482136qke.100.2020.05.19.06.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 06:27:04 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 12/12] tests/vm: Add workaround to consume console
Date: Tue, 19 May 2020 09:22:59 -0400
Message-Id: <20200519132259.405-13-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519132259.405-1-robert.foley@linaro.org>
References: <20200519132259.405-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=robert.foley@linaro.org; helo=mail-qt1-x835.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, robert.foley@linaro.org,
 peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The ConsoleSocket object provides a socket interface
which will consume all arriving characters on the
socket, but will provide those chars via recv() as
would a regular socket.
This is a workaround we found was needed since
there is a known issue where QEMU will hang waiting
for console characters to be consumed.
We also add the option of logging the console to a file.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
---
 python/qemu/console_socket.py | 162 ++++++++++++++++++++++++++++++++++
 python/qemu/machine.py        |  23 ++++-
 tests/vm/Makefile.include     |   4 +
 tests/vm/basevm.py            |  19 +++-
 4 files changed, 202 insertions(+), 6 deletions(-)
 create mode 100644 python/qemu/console_socket.py

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
new file mode 100644
index 0000000000..a1f74e60ac
--- /dev/null
+++ b/python/qemu/console_socket.py
@@ -0,0 +1,162 @@
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
+        self._thread_start()
+        self._open = True
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
+            self._buffer.append(c)
+
+    def recv(self, n=1):
+        """Return chars from in memory buffer"""
+        start_time = time.time()
+        while len(self._buffer) < n:
+            time.sleep(0.1)
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
+
+class ByteBuffer(deque):
+    """Simple in memory buffer with read/write interface"""
+    def write(self, bytes):
+        for i in bytes:
+            self.append(i)
+    def read(self, n):
+        return ''.join([self.popleft() for i in range(n)])
+
+if __name__ == '__main__':
+    # Brief test to exercise the above code.
+    # The ConsoleSocket will ship some data to the server,
+    # the server will echo it back and the client will echo what it received.
+
+    # First remove the socket.
+    address = "./test_console_socket"
+    if os.path.exists(address):
+        os.unlink(address)
+
+    # Create the server side.
+    server_socket = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
+    server_socket.bind(address)
+    server_socket.listen(1)
+
+    # Create the object we are trying to test.
+    console_socket = ConsoleSocket(address, file="./logfile.txt")
+
+    # Generate some data and ship it over the socket.
+    send_data = ""
+    for i in range(10):
+        send_data += "this is a test message {}\n".format(i)
+    console_socket.send(send_data.encode('latin1'))
+    connection, client_address = server_socket.accept()
+
+    # Process the data on the server and ship it back.
+    data = connection.recv(len(send_data))
+    print("server received: {}".format(data))
+    print("server: sending data back to the client")
+    connection.sendall(data)
+
+    # Client receives teh bytes and displays them.
+    print("client: receiving bytes")
+    bytes = console_socket.recv(len(data))
+    recv_data = bytes.decode('latin1')
+    print("client received: {}".format(recv_data))
+    assert(recv_data == send_data)
+    # Close console connection first, then close server.
+    console_socket.close()
+    connection.close()
+    server_socket.close()
+    print("test successful.")
+
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index b9a98e2c86..30e7a16b92 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -24,6 +24,7 @@ import subprocess
 import shutil
 import socket
 import tempfile
+from qemu.console_socket import ConsoleSocket
 
 from . import qmp
 
@@ -71,7 +72,8 @@ class QEMUMachine(object):
 
     def __init__(self, binary, args=None, wrapper=None, name=None,
                  test_dir="/var/tmp", monitor_address=None,
-                 socket_scm_helper=None, sock_dir=None):
+                 socket_scm_helper=None, sock_dir=None,
+                 drain_console=False, console_log=None):
         '''
         Initialize a QEMUMachine
 
@@ -82,6 +84,9 @@ class QEMUMachine(object):
         @param test_dir: where to create socket and log file
         @param monitor_address: address for QMP monitor
         @param socket_scm_helper: helper program, required for send_fd_scm()
+        @param sock_dir: where to create socket (overrides test_dir for sock)
+        @param console_log: (optional) path to console log file
+        @param drain_console: (optional) True to drain console socket to buffer
         @note: Qemu process is not started until launch() is used.
         '''
         if args is None:
@@ -118,6 +123,12 @@ class QEMUMachine(object):
         self._console_address = None
         self._console_socket = None
         self._remove_files = []
+        self._console_log_path = console_log
+        if self._console_log_path:
+            # In order to log the console, buffering needs to be enabled.
+            self._drain_console = True
+        else:
+            self._drain_console = drain_console
 
         # just in case logging wasn't configured by the main script:
         logging.basicConfig()
@@ -568,7 +579,11 @@ class QEMUMachine(object):
         Returns a socket connected to the console
         """
         if self._console_socket is None:
-            self._console_socket = socket.socket(socket.AF_UNIX,
-                                                 socket.SOCK_STREAM)
-            self._console_socket.connect(self._console_address)
+            if self._drain_console:
+                self._console_socket = ConsoleSocket(self._console_address,
+                                                     file=self._console_log_path)
+            else:
+                self._console_socket = socket.socket(socket.AF_UNIX,
+                                                     socket.SOCK_STREAM)
+                self._console_socket.connect(self._console_address)
         return self._console_socket
diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index f13f0b5495..a1aa1adf3d 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -49,6 +49,7 @@ endif
 	@echo '    EXTRA_CONFIGURE_OPTS="..."'
 	@echo "    J=[0..9]*            	 - Override the -jN parameter for make commands"
 	@echo "    DEBUG=1              	 - Enable verbose output on host and interactive debugging"
+	@echo "    LOG_CONSOLE=1        	 - Log console to file in: ~/.cache/qemu-vm "
 	@echo "    V=1				 - Enable verbose ouput on host and guest commands"
 	@echo "    QEMU_LOCAL=1                 - Use QEMU binary local to this build."
 	@echo "    QEMU=/path/to/qemu		 - Change path to QEMU binary"
@@ -74,6 +75,7 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(GENISOIMAGE),--genisoimage $(GENISOIMAGE)) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$@" \
 		--force \
@@ -90,6 +92,7 @@ vm-build-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V),--verbose) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		$(if $(BUILD_TARGET),--build-target $(BUILD_TARGET)) \
@@ -113,6 +116,7 @@ vm-boot-ssh-%: $(IMAGES_DIR)/%.img
 		$(if $(J),--jobs $(J)) \
 		$(if $(V)$(DEBUG), --debug) \
 		$(if $(EFI_AARCH64),--efi-aarch64 $(EFI_AARCH64)) \
+		$(if $(LOG_CONSOLE),--log-console) \
 		--build-path $(BUILD_DIR)\
 		--image "$<" \
 		--interactive \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3b63076e25..af7b330fdf 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -82,6 +82,8 @@ class BaseVM(object):
     poweroff = "poweroff"
     # enable IPv6 networking
     ipv6 = True
+    # This is the timeout on the wait for console bytes.
+    socket_timeout = 120
     # Scale up some timeouts under TCG.
     # 4 is arbitrary, but greater than 2,
     # since we found we need to wait more than twice as long.
@@ -115,6 +117,11 @@ class BaseVM(object):
              "w").write(self._config['ssh_pub_key'])
 
         self.debug = args.debug
+        self._console_log_path = None
+        if args.log_console:
+                self._console_log_path = \
+                         os.path.join(os.path.expanduser("~/.cache/qemu-vm"),
+                                      "{}.install.log".format(self.name))
         self._stderr = sys.stderr
         self._devnull = open(os.devnull, "w")
         if self.debug:
@@ -269,7 +276,9 @@ class BaseVM(object):
         args += self._data_args + extra_args + self._config['extra_args']
         logging.debug("QEMU args: %s", " ".join(args))
         qemu_path = get_qemu_path(self.arch, self._build_path)
-        guest = QEMUMachine(binary=qemu_path, args=args)
+        guest = QEMUMachine(binary=qemu_path, args=args,
+                            console_log=self._console_log_path,
+                            drain_console=True)
         guest.set_machine(self._config['machine'])
         guest.set_console()
         try:
@@ -283,6 +292,8 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
+        # Init console so we can start consuming the chars.
+        self.console_init()
         usernet_info = guest.qmp("human-monitor-command",
                                  command_line="info usernet")
         self.ssh_port = None
@@ -294,7 +305,9 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def console_init(self, timeout = 120):
+    def console_init(self, timeout = None):
+        if timeout == None:
+            timeout = self.socket_timeout
         vm = self._guest
         vm.console_socket.settimeout(timeout)
         self.console_raw_path = os.path.join(vm._temp_dir,
@@ -578,6 +591,8 @@ def parse_args(vmcls):
     parser.add_option("--efi-aarch64",
                       default="/usr/share/qemu-efi-aarch64/QEMU_EFI.fd",
                       help="Path to efi image for aarch64 VMs.")
+    parser.add_option("--log-console", action="store_true",
+                      help="Log console to file.")
     parser.disable_interspersed_args()
     return parser.parse_args()
 
-- 
2.17.1


