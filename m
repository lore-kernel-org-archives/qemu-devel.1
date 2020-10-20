Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15242C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7D92223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="goZOoqhl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7D92223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvqZ-0005Be-7h
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvR8-0003RK-BO
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUvR2-0000FJ-6P
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxFopKxnTJAVh++2OF2V5+nmlIMCR45qC4kU3PhTEfQ=;
 b=goZOoqhl80V17OPE0LtVQ7TYynkvynnawFd3w0CyTqTDbetFgCHfSF24jtloV9cpgtlhZg
 8Z9MCx68UMxs5KHPC97esccp1L+zkcbfVUDW6ekIWjrExXn3+WezEc++dCeKsIOHAOI59N
 Fp6n91SyFqSMAzuYBcSMBucuybxl7l4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-FVUz8wAVMLet7kN81vAAuQ-1; Tue, 20 Oct 2020 13:28:09 -0400
X-MC-Unique: FVUz8wAVMLet7kN81vAAuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CD001006C93;
 Tue, 20 Oct 2020 17:28:08 +0000 (UTC)
Received: from scv.redhat.com (ovpn-115-172.rdu2.redhat.com [10.10.115.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4BCC91992D;
 Tue, 20 Oct 2020 17:28:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] python/qemu/console_socket.py: Add type hint annotations
Date: Tue, 20 Oct 2020 13:27:37 -0400
Message-Id: <20201020172742.1483258-17-jsnow@redhat.com>
In-Reply-To: <20201020172742.1483258-1-jsnow@redhat.com>
References: <20201020172742.1483258-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finish the typing of console_socket.py with annotations and no code
changes.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-id: 20201006235817.3280413-16-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/console_socket.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/python/qemu/console_socket.py b/python/qemu/console_socket.py
index d4669c441d..57e6eee017 100644
--- a/python/qemu/console_socket.py
+++ b/python/qemu/console_socket.py
@@ -17,7 +17,7 @@
 import socket
 import threading
 import time
-from typing import Optional
+from typing import Deque, Optional
 
 
 class ConsoleSocket(socket.socket):
@@ -30,11 +30,11 @@ class ConsoleSocket(socket.socket):
     Optionally a file path can be passed in and we will also
     dump the characters to this file for debugging purposes.
     """
-    def __init__(self, address, file=None, drain=False):
-        self._recv_timeout_sec = 300
+    def __init__(self, address: str, file: Optional[str] = None,
+                 drain: bool = False):
         self._recv_timeout_sec = 300.0
         self._sleep_time = 0.5
-        self._buffer = deque()
+        self._buffer: Deque[str] = deque()
         socket.socket.__init__(self, socket.AF_UNIX, socket.SOCK_STREAM)
         self.connect(address)
         self._logfile = None
@@ -45,7 +45,7 @@ def __init__(self, address, file=None, drain=False):
         if drain:
             self._drain_thread = self._thread_start()
 
-    def _drain_fn(self):
+    def _drain_fn(self) -> None:
         """Drains the socket and runs while the socket is open."""
         while self._open:
             try:
@@ -56,7 +56,7 @@ def _drain_fn(self):
                 # self._open is set to False.
                 time.sleep(self._sleep_time)
 
-    def _thread_start(self):
+    def _thread_start(self) -> threading.Thread:
         """Kick off a thread to drain the socket."""
         # Configure socket to not block and timeout.
         # This allows our drain thread to not block
@@ -68,7 +68,7 @@ def _thread_start(self):
         drain_thread.start()
         return drain_thread
 
-    def close(self):
+    def close(self) -> None:
         """Close the base object and wait for the thread to terminate"""
         if self._open:
             self._open = False
@@ -80,7 +80,7 @@ def close(self):
                 self._logfile.close()
                 self._logfile = None
 
-    def _drain_socket(self):
+    def _drain_socket(self) -> None:
         """process arriving characters into in memory _buffer"""
         data = socket.socket.recv(self, 1)
         # latin1 is needed since there are some chars
@@ -114,7 +114,7 @@ def recv(self, bufsize: int = 1, flags: int = 0) -> bytes:
         # socket w/o our intervention.
         return chars.encode("latin1")
 
-    def setblocking(self, value):
+    def setblocking(self, value: bool) -> None:
         """When not draining we pass thru to the socket,
            since when draining we control socket blocking.
         """
-- 
2.26.2


