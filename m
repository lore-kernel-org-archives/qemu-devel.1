Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C76C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:30:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 734152063A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 05:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBgdpibh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734152063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtlcJ-0006Yg-NS
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 01:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUm-00080O-8O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60308
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1jtlUj-0008Gg-04
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 01:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594358564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1jl5lTHg0WxX2qj39Z2IQcVuSWcvw32aB6MG4lf3ToQ=;
 b=YBgdpibhexlUgUSXQJTFpUut4SlNz0a4wvwH41qkE5wekbTp/BywpJhVUUtSTRTN6P3D7b
 vpU6rr6J8kcffUy0pE2Q8UJeMwhiuniB3Y8goNqp1vYE4pmCFFXUfglwwXEJgHONb7zkTQ
 fAkgBMD0M7SpEm8zmQx92hS8sLkiLk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-7hQRj5NbNMqR1crxS9Gy_g-1; Fri, 10 Jul 2020 01:22:42 -0400
X-MC-Unique: 7hQRj5NbNMqR1crxS9Gy_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B0BC1080;
 Fri, 10 Jul 2020 05:22:41 +0000 (UTC)
Received: from probe.redhat.com (ovpn-118-196.rdu2.redhat.com [10.10.118.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B27E920CA;
 Fri, 10 Jul 2020 05:22:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 16/16] python/qemu: Add mypy type annotations
Date: Fri, 10 Jul 2020 01:22:20 -0400
Message-Id: <20200710052220.3306-17-jsnow@redhat.com>
In-Reply-To: <20200710052220.3306-1-jsnow@redhat.com>
References: <20200710052220.3306-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:55:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@redhat.com
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
 python/qemu/machine.py | 94 ++++++++++++++++++++++++------------------
 python/qemu/qmp.py     | 44 +++++++++++---------
 python/qemu/qtest.py   | 26 +++++++-----
 4 files changed, 98 insertions(+), 74 deletions(-)

diff --git a/python/qemu/accel.py b/python/qemu/accel.py
index 7fabe62920..4325114e51 100644
--- a/python/qemu/accel.py
+++ b/python/qemu/accel.py
@@ -17,6 +17,7 @@
 import logging
 import os
 import subprocess
+from typing import List, Optional
 
 LOG = logging.getLogger(__name__)
 
@@ -29,7 +30,7 @@
 }
 
 
-def list_accel(qemu_bin):
+def list_accel(qemu_bin: str) -> List[str]:
     """
     List accelerators enabled in the QEMU binary.
 
@@ -49,7 +50,8 @@ def list_accel(qemu_bin):
     return [acc.strip() for acc in out.splitlines()[1:]]
 
 
-def kvm_available(target_arch=None, qemu_bin=None):
+def kvm_available(target_arch: Optional[str] = None,
+                  qemu_bin: Optional[str] = None) -> bool:
     """
     Check if KVM is available using the following heuristic:
       - Kernel module is present in the host;
@@ -72,7 +74,7 @@ def kvm_available(target_arch=None, qemu_bin=None):
     return True
 
 
-def tcg_available(qemu_bin):
+def tcg_available(qemu_bin: str) -> bool:
     """
     Check if TCG is available.
 
diff --git a/python/qemu/machine.py b/python/qemu/machine.py
index f7239a249b..3f0c98987f 100644
--- a/python/qemu/machine.py
+++ b/python/qemu/machine.py
@@ -28,6 +28,7 @@
 import tempfile
 from typing import (
     Any,
+    BinaryIO,
     Dict,
     List,
     Optional,
@@ -38,7 +39,7 @@
 from types import TracebackType
 
 from . import qmp
-from .qmp import SocketAddrT, QMPMessage
+from .qmp import QMPMessage, QMPReturnValue, SocketAddrT
 
 LOG = logging.getLogger(__name__)
 
@@ -67,7 +68,7 @@ class AbnormalShutdown(QEMUMachineError):
 
 class QEMUMachine:
     """
-    A QEMU VM
+    A QEMU VM.
 
     Use this object as a context manager to ensure
     the QEMU process terminates::
@@ -84,7 +85,8 @@ def __init__(self,
                  name: Optional[str] = None,
                  test_dir: str = "/var/tmp",
                  monitor_address: Optional[SocketAddrT] = None,
-                 socket_scm_helper=None, sock_dir=None):
+                 socket_scm_helper: Optional[str] = None,
+                 sock_dir: Optional[str] = None):
         '''
         Initialize a QEMUMachine
 
@@ -118,28 +120,28 @@ def __init__(self,
             self._remove_monitor_sockfile = True
 
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
@@ -148,14 +150,15 @@ def __exit__(self,
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
@@ -174,7 +177,8 @@ def add_fd(self, fd, fdset, opaque, opts=''):
         self._args.append(','.join(options))
         return self
 
-    def send_fd_scm(self, fd=None, file_path=None):
+    def send_fd_scm(self, fd: Optional[int] = None,
+                    file_path: Optional[str] = None) -> int:
         """
         Send an fd or file_path to socket_scm_helper.
 
@@ -218,7 +222,7 @@ def send_fd_scm(self, fd=None, file_path=None):
         return proc.returncode
 
     @staticmethod
-    def _remove_if_exists(path):
+    def _remove_if_exists(path: str) -> None:
         """
         Remove file object at path if it exists
         """
@@ -229,7 +233,7 @@ def _remove_if_exists(path):
                 return
             raise
 
-    def is_running(self):
+    def is_running(self) -> bool:
         """Returns true if the VM is running."""
         return self._popen is not None and self._popen.poll() is None
 
@@ -239,19 +243,19 @@ def _subp(self) -> 'subprocess.Popen[bytes]':
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
@@ -285,7 +289,7 @@ def _base_args(self) -> List[str]:
                 args.extend(['-device', device])
         return args
 
-    def _pre_launch(self):
+    def _pre_launch(self) -> None:
         self._temp_dir = tempfile.mkdtemp(dir=self._test_dir)
         self._qemu_log_path = os.path.join(self._temp_dir, self._name + ".log")
         self._qemu_log_file = open(self._qemu_log_path, 'wb')
@@ -303,11 +307,11 @@ def _pre_launch(self):
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
@@ -347,7 +351,7 @@ def _post_shutdown(self):
         self._user_killed = False
         self._launched = False
 
-    def launch(self):
+    def launch(self) -> None:
         """
         Launch the VM and make sure we cleanup and expose the
         command line/output in case of exception
@@ -371,7 +375,7 @@ def launch(self):
                 LOG.debug('Output: %r', self._iolog)
             raise
 
-    def _launch(self):
+    def _launch(self) -> None:
         """
         Launch the VM and establish a QMP connection
         """
@@ -487,7 +491,7 @@ def shutdown(self, has_quit: bool = False,
         finally:
             self._post_shutdown()
 
-    def kill(self):
+    def kill(self) -> None:
         """
         Terminate the VM forcefully, wait for it to exit, and perform cleanup.
         """
@@ -502,7 +506,7 @@ def wait(self, timeout: Optional[int] = 3) -> None:
         """
         self.shutdown(has_quit=True, timeout=timeout)
 
-    def set_qmp_monitor(self, enabled=True):
+    def set_qmp_monitor(self, enabled: bool = True) -> None:
         """
         Set the QMP monitor.
 
@@ -538,7 +542,9 @@ def qmp(self, cmd: str,
         qmp_args = self._qmp_args(conv_keys, **args)
         return self._qmp.cmd(cmd, args=qmp_args)
 
-    def command(self, cmd, conv_keys=True, **args):
+    def command(self, cmd: str,
+                conv_keys: bool = True,
+                **args: Any) -> QMPReturnValue:
         """
         Invoke a QMP command.
         On success return the response dict.
@@ -547,7 +553,7 @@ def command(self, cmd, conv_keys=True, **args):
         qmp_args = self._qmp_args(conv_keys, **args)
         return self._qmp.command(cmd, **qmp_args)
 
-    def get_qmp_event(self, wait=False):
+    def get_qmp_event(self, wait: bool = False) -> Optional[QMPMessage]:
         """
         Poll for one queued QMP events and return it
         """
@@ -555,7 +561,7 @@ def get_qmp_event(self, wait=False):
             return self._events.pop(0)
         return self._qmp.pull_event(wait=wait)
 
-    def get_qmp_events(self, wait=False):
+    def get_qmp_events(self, wait: bool = False) -> List[QMPMessage]:
         """
         Poll for queued QMP events and return a list of dicts
         """
@@ -566,7 +572,7 @@ def get_qmp_events(self, wait=False):
         return events
 
     @staticmethod
-    def event_match(event, match=None):
+    def event_match(event: Any, match: Optional[Any]) -> bool:
         """
         Check if an event matches optional match criteria.
 
@@ -596,9 +602,11 @@ def event_match(event, match=None):
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
 
@@ -608,7 +616,9 @@ def event_wait(self, name, timeout=60.0, match=None):
         """
         return self.events_wait([(name, match)], timeout)
 
-    def events_wait(self, events, timeout=60.0):
+    def events_wait(self,
+                    events: Sequence[Tuple[str, Any]],
+                    timeout: float = 60.0) -> Optional[QMPMessage]:
         """
         events_wait waits for and returns a single named event from QMP.
         In the case of multiple qualifying events, this function returns the
@@ -625,7 +635,7 @@ def events_wait(self, events, timeout=60.0):
         :return: A QMP event matching the filter criteria.
                  If timeout was 0 and no event matched, None.
         """
-        def _match(event):
+        def _match(event: QMPMessage) -> bool:
             for name, match in events:
                 if event['event'] == name and self.event_match(event, match):
                     return True
@@ -652,20 +662,20 @@ def _match(event):
 
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
 
@@ -674,7 +684,9 @@ def set_machine(self, machine_type):
         """
         self._machine = machine_type
 
-    def set_console(self, device_type=None, console_index=0):
+    def set_console(self,
+                    device_type: Optional[str] = None,
+                    console_index: int = 0) -> None:
         """
         Sets the device type for a console device
 
@@ -705,7 +717,7 @@ def set_console(self, device_type=None, console_index=0):
         self._console_index = console_index
 
     @property
-    def console_socket(self):
+    def console_socket(self) -> socket.socket:
         """
         Returns a socket connected to the console
         """
diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index 7935dababb..303e82ee6b 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -15,6 +15,7 @@
     Any,
     cast,
     Dict,
+    List,
     Optional,
     TextIO,
     Type,
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
index ae4661d4d3..49c04bc98d 100644
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
2.21.3


