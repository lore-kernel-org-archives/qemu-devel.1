Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D825C46466
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C112520739
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dH6sPgjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C112520739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPx2R-0002Mo-0y
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 20:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwr4-0008Bu-KM
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36925)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kPwr0-0002MH-9X
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 19:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602028725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Cwbwc7sP8pU6H/+Lj4YUGFbHooK8u9zFZX1zMrpByE=;
 b=dH6sPgjxTEiqaCx5oEn2v78tx2pXvq4NiNfsDhJ0qOpSXc7U8caIeYrPOoQ4gshMRC++Vg
 bnuFj2VNA6HCVYekbj25c3oNqYzShZrXEfdTA04c8+Q5rYx8tAPFQ147MLwkvirBTj3xxZ
 huwhnIbifEKZauEUB7AYKzsf1F/iKn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-l2rkfKGZPIa_JaHopregog-1; Tue, 06 Oct 2020 19:58:43 -0400
X-MC-Unique: l2rkfKGZPIa_JaHopregog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 701B464144;
 Tue,  6 Oct 2020 23:58:42 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A302460BFA;
 Tue,  6 Oct 2020 23:58:41 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/20] python/qemu: Add mypy type annotations
Date: Tue,  6 Oct 2020 19:58:08 -0400
Message-Id: <20201006235817.3280413-12-jsnow@redhat.com>
In-Reply-To: <20201006235817.3280413-1-jsnow@redhat.com>
References: <20201006235817.3280413-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These should all be purely annotations with no changes in behavior at
all. You need to be in the python folder, but you should be able to
confirm that these annotations are correct (or at least self-consistent)
by running `mypy --strict qemu`.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/accel.py   |  8 ++--
 python/qemu/machine.py | 98 ++++++++++++++++++++++++------------------
 python/qemu/qmp.py     | 44 +++++++++++--------
 python/qemu/qtest.py   | 26 ++++++-----
 4 files changed, 101 insertions(+), 75 deletions(-)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 3ec6bdcfdb5..297933df2a3 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -17,6 +17,7 @@
 import logging
 import os
 import subprocess
+from typing import List, Optional
 
 
 LOG = logging.getLogger(__name__)
@@ -30,7 +31,7 @@
 }
 
 
-def list_accel(qemu_bin):
+def list_accel(qemu_bin: str) -> List[str]:
     """
     List accelerators enabled in the QEMU binary.
 
@@ -50,7 +51,8 @@ def list_accel(qemu_bin):
     return [acc.strip() for acc in out.splitlines()[1:]]
 
 
-def kvm_available(target_arch=None, qemu_bin=None):
+def kvm_available(target_arch: Optional[str] = None,
+                  qemu_bin: Optional[str] = None) -> bool:
     """
     Check if KVM is available using the following heuristic:
       - Kernel module is present in the host;
@@ -73,7 +75,7 @@ def kvm_available(target_arch=None, qemu_bin=None):
     return True
 
 
-def tcg_available(qemu_bin):
+def tcg_available(qemu_bin: str) -> bool:
     """
     Check if TCG is available.
 
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index e599cb7439b..6420f01bed4 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -23,11 +23,13 @@
 import os
 import shutil
 import signal
+import socket
 import subprocess
 import tempfile
 from types import TracebackType
 from typing import (
     Any,
+    BinaryIO,
     Dict,
     List,
     Optional,
@@ -37,7 +39,7 @@
 )
 
 from . import console_socket, qmp
-from .qmp import QMPMessage, SocketAddrT
+from .qmp import QMPMessage, QMPReturnValue, SocketAddrT
 
 
 LOG = logging.getLogger(__name__)
@@ -67,7 +69,7 @@ class AbnormalShutdown(QEMUMachineError):
 
 class QEMUMachine:
     """
-    A QEMU VM
+    A QEMU VM.
 
     Use this object as a context manager to ensure
     the QEMU process terminates::
@@ -84,8 +86,10 @@ def __init__(self,
                  name: Optional[str] = None,
                  test_dir: str = "/var/tmp",
                  monitor_address: Optional[SocketAddrT] = None,
-                 socket_scm_helper=None, sock_dir=None,
-                 drain_console=False, console_log=None):
+                 socket_scm_helper: Optional[str] = None,
+                 sock_dir: Optional[str] = None,
+                 drain_console: bool = False,
+                 console_log: Optional[str] = None):
         '''
         Initialize a QEMUMachine
 
@@ -129,28 +133,28 @@ def __init__(self,
             self._drain_console = drain_console
 
         # Runstate
-        self._qemu_log_path = None
-        self._qemu_log_file = None
+        self._qemu_log_path: Optional[str] = None
+        self._qemu_log_file: Optional[BinaryIO] = None
         self._popen: Optional['subprocess.Popen[bytes]'] = None
-        self._events = []
-        self._iolog = None
+        self._events: List[QMPMessage] = []
+        self._iolog: Optional[str] = None
         self._qmp_set = True   # Enable QMP monitor by default.
         self._qmp_connection: Optional[qmp.QEMUMonitorProtocol] = None
         self._qemu_full_args: Tuple[str, ...] = ()
-        self._temp_dir = None
+        self._temp_dir: Optional[str] = None
         self._launched = False
-        self._machine = None
+        self._machine: Optional[str] = None
         self._console_index = 0
         self._console_set = False
-        self._console_device_type = None
+        self._console_device_type: Optional[str] = None
         self._console_address = os.path.join(
             self._sock_dir, f"{self._name}-console.sock"
         )
-        self._console_socket = None
-        self._remove_files = []
+        self._console_socket: Optional[socket.socket] = None
+        self._remove_files: List[str] = []
         self._user_killed = False
 
-    def __enter__(self):
+    def __enter__(self) -> 'QEMUMachine':
         return self
 
     def __exit__(self,
@@ -159,14 +163,15 @@ def __exit__(self,
                  exc_tb: Optional[TracebackType]) -> None:
         self.shutdown()
 
-    def add_monitor_null(self):
+    def add_monitor_null(self) -> None:
         """
         This can be used to add an unused monitor instance.
         """
         self._args.append('-monitor')
         self._args.append('null')
 
-    def add_fd(self, fd, fdset, opaque, opts=''):
+    def add_fd(self, fd: int, fdset: int,
+               opaque: str, opts: str = '') -> 'QEMUMachine':
         """
         Pass a file descriptor to the VM
         """
@@ -185,7 +190,8 @@ def add_fd(self, fd, fdset, opaque, opts=''):
         self._args.append(','.join(options))
         return self
 
-    def send_fd_scm(self, fd=None, file_path=None):
+    def send_fd_scm(self, fd: Optional[int] = None,
+                    file_path: Optional[str] = None) -> int:
         """
         Send an fd or file_path to socket_scm_helper.
 
@@ -229,7 +235,7 @@ def send_fd_scm(self, fd=None, file_path=None):
         return proc.returncode
 
     @staticmethod
-    def _remove_if_exists(path):
+    def _remove_if_exists(path: str) -> None:
         """
         Remove file object at path if it exists
         """
@@ -240,7 +246,7 @@ def _remove_if_exists(path):
                 return
             raise
 
-    def is_running(self):
+    def is_running(self) -> bool:
         """Returns true if the VM is running."""
         return self._popen is not None and self._popen.poll() is None
 
@@ -250,19 +256,19 @@ def _subp(self) -> 'subprocess.Popen[bytes]':
             raise QEMUMachineError('Subprocess pipe not present')
         return self._popen
 
-    def exitcode(self):
+    def exitcode(self) -> Optional[int]:
         """Returns the exit code if possible, or None."""
         if self._popen is None:
             return None
         return self._popen.poll()
 
-    def get_pid(self):
+    def get_pid(self) -> Optional[int]:
         """Returns the PID of the running process, or None."""
         if not self.is_running():
             return None
         return self._subp.pid
 
-    def _load_io_log(self):
+    def _load_io_log(self) -> None:
         if self._qemu_log_path is not None:
             with open(self._qemu_log_path, "r") as iolog:
                 self._iolog = iolog.read()
@@ -296,7 +302,7 @@ def _base_args(self) -> List[str]:
                 args.extend(['-device', device])
         return args
 
-    def _pre_launch(self):
+    def _pre_launch(self) -> None:
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
@@ -314,11 +320,11 @@ def _pre_launch(self):
                 nickname=self._name
             )
 
-    def _post_launch(self):
+    def _post_launch(self) -> None:
         if self._qmp_connection:
             self._qmp.accept()
 
-    def _post_shutdown(self):
+    def _post_shutdown(self) -> None:
         """
         Called to cleanup the VM instance after the process has exited.
         May also be called after a failed launch.
@@ -358,7 +364,7 @@ def _post_shutdown(self):
         self._user_killed = False
         self._launched = False
 
-    def launch(self):
+    def launch(self) -> None:
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
@@ -382,7 +388,7 @@ def launch(self):
                 LOG.debug('Output: %r', self._iolog)
             raise
 
-    def _launch(self):
+    def _launch(self) -> None:
         """
         Launch the VM and establish a QMP connection
         """
@@ -501,7 +507,7 @@ def shutdown(self, has_quit: bool = False,
         finally:
             self._post_shutdown()
 
-    def kill(self):
+    def kill(self) -> None:
         """
         Terminate the VM forcefully, wait for it to exit, and perform cleanup.
         """
@@ -516,7 +522,7 @@ def wait(self, timeout: Optional[int] = 30) -> None:
         """
         self.shutdown(has_quit=True, timeout=timeout)
 
-    def set_qmp_monitor(self, enabled=True):
+    def set_qmp_monitor(self, enabled: bool = True) -> None:
         """
         Set the QMP monitor.
 
@@ -552,7 +558,9 @@ def qmp(self, cmd: str,
         qmp_args = self._qmp_args(conv_keys, **args)
         return self._qmp.cmd(cmd, args=qmp_args)
 
-    def command(self, cmd, conv_keys=True, **args):
+    def command(self, cmd: str,
+                conv_keys: bool = True,
+                **args: Any) -> QMPReturnValue:
         """
         Invoke a QMP command.
         On success return the response dict.
@@ -561,7 +569,7 @@ def command(self, cmd, conv_keys=True, **args):
         qmp_args = self._qmp_args(conv_keys, **args)
         return self._qmp.command(cmd, **qmp_args)
 
-    def get_qmp_event(self, wait=False):
+    def get_qmp_event(self, wait: bool = False) -> Optional[QMPMessage]:
         """
         Poll for one queued QMP events and return it
         """
@@ -569,7 +577,7 @@ def get_qmp_event(self, wait=False):
             return self._events.pop(0)
         return self._qmp.pull_event(wait=wait)
 
-    def get_qmp_events(self, wait=False):
+    def get_qmp_events(self, wait: bool = False) -> List[QMPMessage]:
         """
         Poll for queued QMP events and return a list of dicts
         """
@@ -580,7 +588,7 @@ def get_qmp_events(self, wait=False):
         return events
 
     @staticmethod
-    def event_match(event, match=None):
+    def event_match(event: Any, match: Optional[Any]) -> bool:
         """
         Check if an event matches optional match criteria.
 
@@ -610,9 +618,11 @@ def event_match(event, match=None):
             return True
         except TypeError:
             # either match or event wasn't iterable (not a dict)
-            return match == event
+            return bool(match == event)
 
-    def event_wait(self, name, timeout=60.0, match=None):
+    def event_wait(self, name: str,
+                   timeout: float = 60.0,
+                   match: Optional[QMPMessage] = None) -> Optional[QMPMessage]:
         """
         event_wait waits for and returns a named event from QMP with a timeout.
 
@@ -622,7 +632,9 @@ def event_wait(self, name, timeout=60.0, match=None):
         """
         return self.events_wait([(name, match)], timeout)
 
-    def events_wait(self, events, timeout=60.0):
+    def events_wait(self,
+                    events: Sequence[Tuple[str, Any]],
+                    timeout: float = 60.0) -> Optional[QMPMessage]:
         """
         events_wait waits for and returns a single named event from QMP.
         In the case of multiple qualifying events, this function returns the
@@ -639,7 +651,7 @@ def events_wait(self, events, timeout=60.0):
         :return: A QMP event matching the filter criteria.
                  If timeout was 0 and no event matched, None.
         """
-        def _match(event):
+        def _match(event: QMPMessage) -> bool:
             for name, match in events:
                 if event['event'] == name and self.event_match(event, match):
                     return True
@@ -666,20 +678,20 @@ def _match(event):
 
         return None
 
-    def get_log(self):
+    def get_log(self) -> Optional[str]:
         """
         After self.shutdown or failed qemu execution, this returns the output
         of the qemu process.
         """
         return self._iolog
 
-    def add_args(self, *args):
+    def add_args(self, *args: str) -> None:
         """
         Adds to the list of extra arguments to be given to the QEMU binary
         """
         self._args.extend(args)
 
-    def set_machine(self, machine_type):
+    def set_machine(self, machine_type: str) -> None:
         """
         Sets the machine type
 
@@ -688,7 +700,9 @@ def set_machine(self, machine_type):
         """
         self._machine = machine_type
 
-    def set_console(self, device_type=None, console_index=0):
+    def set_console(self,
+                    device_type: Optional[str] = None,
+                    console_index: int = 0) -> None:
         """
         Sets the device type for a console device
 
@@ -719,7 +733,7 @@ def set_console(self, device_type=None, console_index=0):
         self._console_index = console_index
 
     @property
-    def console_socket(self):
+    def console_socket(self) -> socket.socket:
         """
         Returns a socket connected to the console
         """
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index ddf8347ac12..9223307ed81 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -15,6 +15,7 @@
 from typing import (
     Any,
     Dict,
+    List,
     Optional,
     TextIO,
     Tuple,
@@ -90,7 +91,9 @@ class QEMUMonitorProtocol:
     #: Logger object for debugging messages
     logger = logging.getLogger('QMP')
 
-    def __init__(self, address, server=False, nickname=None):
+    def __init__(self, address: SocketAddrT,
+                 server: bool = False,
+                 nickname: Optional[str] = None):
         """
         Create a QEMUMonitorProtocol class.
 
@@ -102,7 +105,7 @@ def __init__(self, address, server=False, nickname=None):
         @note No connection is established, this is done by the connect() or
               accept() methods
         """
-        self.__events = []
+        self.__events: List[QMPMessage] = []
         self.__address = address
         self.__sock = self.__get_sock()
         self.__sockfile: Optional[TextIO] = None
@@ -114,14 +117,14 @@ def __init__(self, address, server=False, nickname=None):
             self.__sock.bind(self.__address)
             self.__sock.listen(1)
 
-    def __get_sock(self):
+    def __get_sock(self) -> socket.socket:
         if isinstance(self.__address, tuple):
             family = socket.AF_INET
         else:
             family = socket.AF_UNIX
         return socket.socket(family, socket.SOCK_STREAM)
 
-    def __negotiate_capabilities(self):
+    def __negotiate_capabilities(self) -> QMPMessage:
         greeting = self.__json_read()
         if greeting is None or "QMP" not in greeting:
             raise QMPConnectError
@@ -131,7 +134,7 @@ def __negotiate_capabilities(self):
             return greeting
         raise QMPCapabilitiesError
 
-    def __json_read(self, only_event=False):
+    def __json_read(self, only_event: bool = False) -> Optional[QMPMessage]:
         assert self.__sockfile is not None
         while True:
             data = self.__sockfile.readline()
@@ -148,7 +151,7 @@ def __json_read(self, only_event=False):
                     continue
             return resp
 
-    def __get_events(self, wait=False):
+    def __get_events(self, wait: Union[bool, float] = False) -> None:
         """
         Check for new events in the stream and cache them in __events.
 
@@ -186,7 +189,7 @@ def __get_events(self, wait=False):
                 raise QMPConnectError("Error while reading from socket")
             self.__sock.settimeout(None)
 
-    def __enter__(self):
+    def __enter__(self) -> 'QEMUMonitorProtocol':
         # Implement context manager enter function.
         return self
 
@@ -199,7 +202,7 @@ def __exit__(self,
         # Implement context manager exit function.
         self.close()
 
-    def connect(self, negotiate=True):
+    def connect(self, negotiate: bool = True) -> Optional[QMPMessage]:
         """
         Connect to the QMP Monitor and perform capabilities negotiation.
 
@@ -214,7 +217,7 @@ def connect(self, negotiate=True):
             return self.__negotiate_capabilities()
         return None
 
-    def accept(self, timeout=15.0):
+    def accept(self, timeout: float = 15.0) -> QMPMessage:
         """
         Await connection from QMP Monitor and perform capabilities negotiation.
 
@@ -250,7 +253,9 @@ def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
         self.logger.debug("<<< %s", resp)
         return resp
 
-    def cmd(self, name, args=None, cmd_id=None):
+    def cmd(self, name: str,
+            args: Optional[Dict[str, Any]] = None,
+            cmd_id: Optional[Any] = None) -> QMPMessage:
         """
         Build a QMP command and send it to the QMP Monitor.
 
@@ -258,14 +263,14 @@ def cmd(self, name, args=None, cmd_id=None):
         @param args: command arguments (dict)
         @param cmd_id: command id (dict, list, string or int)
         """
-        qmp_cmd = {'execute': name}
+        qmp_cmd: QMPMessage = {'execute': name}
         if args:
             qmp_cmd['arguments'] = args
         if cmd_id:
             qmp_cmd['id'] = cmd_id
         return self.cmd_obj(qmp_cmd)
 
-    def command(self, cmd, **kwds):
+    def command(self, cmd: str, **kwds: Any) -> QMPReturnValue:
         """
         Build and send a QMP command to the monitor, report errors if any
         """
@@ -278,7 +283,8 @@ def command(self, cmd, **kwds):
             )
         return cast(QMPReturnValue, ret['return'])
 
-    def pull_event(self, wait=False):
+    def pull_event(self,
+                   wait: Union[bool, float] = False) -> Optional[QMPMessage]:
         """
         Pulls a single event.
 
@@ -298,7 +304,7 @@ def pull_event(self, wait=False):
             return self.__events.pop(0)
         return None
 
-    def get_events(self, wait=False):
+    def get_events(self, wait: bool = False) -> List[QMPMessage]:
         """
         Get a list of available QMP events.
 
@@ -315,13 +321,13 @@ def get_events(self, wait=False):
         self.__get_events(wait)
         return self.__events
 
-    def clear_events(self):
+    def clear_events(self) -> None:
         """
         Clear current list of pending events.
         """
         self.__events = []
 
-    def close(self):
+    def close(self) -> None:
         """
         Close the socket and socket file.
         """
@@ -330,7 +336,7 @@ def close(self):
         if self.__sockfile:
             self.__sockfile.close()
 
-    def settimeout(self, timeout):
+    def settimeout(self, timeout: float) -> None:
         """
         Set the socket timeout.
 
@@ -339,7 +345,7 @@ def settimeout(self, timeout):
         """
         self.__sock.settimeout(timeout)
 
-    def get_sock_fd(self):
+    def get_sock_fd(self) -> int:
         """
         Get the socket file descriptor.
 
@@ -347,7 +353,7 @@ def get_sock_fd(self):
         """
         return self.__sock.fileno()
 
-    def is_scm_available(self):
+    def is_scm_available(self) -> bool:
         """
         Check if the socket allows for SCM_RIGHTS.
 
diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
index 675310d8dfe..39a0cf62fe9 100644
--- a/python/qemu/qtest.py
+++ b/python/qemu/qtest.py
@@ -27,6 +27,7 @@
 )
 
 from .machine import QEMUMachine
+from .qmp import SocketAddrT
 
 
 class QEMUQtestProtocol:
@@ -43,7 +44,8 @@ class QEMUQtestProtocol:
        No conection is estabalished by __init__(), this is done
        by the connect() or accept() methods.
     """
-    def __init__(self, address, server=False):
+    def __init__(self, address: SocketAddrT,
+                 server: bool = False):
         self._address = address
         self._sock = self._get_sock()
         self._sockfile: Optional[TextIO] = None
@@ -51,14 +53,14 @@ def __init__(self, address, server=False):
             self._sock.bind(self._address)
             self._sock.listen(1)
 
-    def _get_sock(self):
+    def _get_sock(self) -> socket.socket:
         if isinstance(self._address, tuple):
             family = socket.AF_INET
         else:
             family = socket.AF_UNIX
         return socket.socket(family, socket.SOCK_STREAM)
 
-    def connect(self):
+    def connect(self) -> None:
         """
         Connect to the qtest socket.
 
@@ -67,7 +69,7 @@ def connect(self):
         self._sock.connect(self._address)
         self._sockfile = self._sock.makefile(mode='r')
 
-    def accept(self):
+    def accept(self) -> None:
         """
         Await connection from QEMU.
 
@@ -76,7 +78,7 @@ def accept(self):
         self._sock, _ = self._sock.accept()
         self._sockfile = self._sock.makefile(mode='r')
 
-    def cmd(self, qtest_cmd):
+    def cmd(self, qtest_cmd: str) -> str:
         """
         Send a qtest command on the wire.
 
@@ -87,14 +89,16 @@ def cmd(self, qtest_cmd):
         resp = self._sockfile.readline()
         return resp
 
-    def close(self):
-        """Close this socket."""
+    def close(self) -> None:
+        """
+        Close this socket.
+        """
         self._sock.close()
         if self._sockfile:
             self._sockfile.close()
             self._sockfile = None
 
-    def settimeout(self, timeout):
+    def settimeout(self, timeout: Optional[float]) -> None:
         """Set a timeout, in seconds."""
         self._sock.settimeout(timeout)
 
@@ -118,7 +122,7 @@ def __init__(self,
         super().__init__(binary, args, name=name, test_dir=test_dir,
                          socket_scm_helper=socket_scm_helper,
                          sock_dir=sock_dir)
-        self._qtest = None
+        self._qtest: Optional[QEMUQtestProtocol] = None
         self._qtest_path = os.path.join(sock_dir, name + "-qtest.sock")
 
     @property
@@ -130,7 +134,7 @@ def _base_args(self) -> List[str]:
         ])
         return args
 
-    def _pre_launch(self):
+    def _pre_launch(self) -> None:
         super()._pre_launch()
         self._qtest = QEMUQtestProtocol(self._qtest_path, server=True)
 
@@ -139,7 +143,7 @@ def _post_launch(self) -> None:
         super()._post_launch()
         self._qtest.accept()
 
-    def _post_shutdown(self):
+    def _post_shutdown(self) -> None:
         super()._post_shutdown()
         self._remove_if_exists(self._qtest_path)
 
-- 
2.26.2


