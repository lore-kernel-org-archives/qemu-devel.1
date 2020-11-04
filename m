Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB72C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C16223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEmsIo21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C16223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka6yH-0005S0-8s
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nO-0006Wq-NF
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nG-0004qp-9Y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J1bOwRUYZLBKMVaPFoMxnDf94dgyrlB8ksOfGc+OLXM=;
 b=TEmsIo212ogLMoxj7tVzi9IF8nK531fNe2JtXgMHJ44qa6RjycSq0Vnc9nhr53Qd/WcQtr
 W0lIvcanoHiIHO8uQj3i+zW37gIcYL1/3fp4TTWuQ0tIBqmc63sGik3SMXwveU3KP2o9ZO
 WbadpGYJZkhDW5pqEptuFubcpAGqB34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-jtcbjiIzNfShYGtSizN8zA-1; Tue, 03 Nov 2020 19:36:50 -0500
X-MC-Unique: jtcbjiIzNfShYGtSizN8zA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA2B1018F7D
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:41 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 51E2955766;
 Wed,  4 Nov 2020 00:36:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 24/72] scripts/qmp/qemu-ga-client: add mypy type hints
Date: Tue,  3 Nov 2020 19:35:14 -0500
Message-Id: <20201104003602.1293560-25-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script is in slightly rough shape, but it still works. A lot of
care went into its initial development. In good faith, I'm updating it
to the latest Python coding standards. If there is in interest in this
script, though, I'll be asking for a contributor to take care of it
further.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qemu-ga-client | 89 +++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 59b91c78d884..3e617e7e7abe 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -44,10 +44,18 @@ import errno
 import os
 import random
 import sys
+from typing import (
+    Any,
+    Callable,
+    Dict,
+    Optional,
+    Sequence,
+)
 
 
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qmp
+from qemu.qmp import SocketAddrT
 
 
 # This script has not seen many patches or careful attention in quite
@@ -58,18 +66,18 @@ from qemu import qmp
 
 
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
-    def __getattr__(self, name):
-        def wrapper(**kwds):
+    def __getattr__(self, name: str) -> Callable[..., Any]:
+        def wrapper(**kwds: object) -> object:
             return self.command('guest-' + name.replace('_', '-'), **kwds)
         return wrapper
 
 
 class QemuGuestAgentClient:
-    def __init__(self, address):
+    def __init__(self, address: SocketAddrT):
         self.qga = QemuGuestAgent(address)
         self.qga.connect(negotiate=False)
 
-    def sync(self, timeout=3):
+    def sync(self, timeout: Optional[float] = 3) -> None:
         # Avoid being blocked forever
         if not self.ping(timeout):
             raise EnvironmentError('Agent seems not alive')
@@ -79,9 +87,9 @@ class QemuGuestAgentClient:
             if isinstance(ret, int) and int(ret) == uid:
                 break
 
-    def __file_read_all(self, handle):
+    def __file_read_all(self, handle: int) -> bytes:
         eof = False
-        data = ''
+        data = b''
         while not eof:
             ret = self.qga.file_read(handle=handle, count=1024)
             _data = base64.b64decode(ret['buf-b64'])
@@ -89,7 +97,7 @@ class QemuGuestAgentClient:
             eof = ret['eof']
         return data
 
-    def read(self, path):
+    def read(self, path: str) -> bytes:
         handle = self.qga.file_open(path=path)
         try:
             data = self.__file_read_all(handle)
@@ -97,7 +105,7 @@ class QemuGuestAgentClient:
             self.qga.file_close(handle=handle)
         return data
 
-    def info(self):
+    def info(self) -> str:
         info = self.qga.info()
 
         msgs = []
@@ -113,14 +121,14 @@ class QemuGuestAgentClient:
         return '\n'.join(msgs)
 
     @classmethod
-    def __gen_ipv4_netmask(cls, prefixlen):
+    def __gen_ipv4_netmask(cls, prefixlen: int) -> str:
         mask = int('1' * prefixlen + '0' * (32 - prefixlen), 2)
         return '.'.join([str(mask >> 24),
                          str((mask >> 16) & 0xff),
                          str((mask >> 8) & 0xff),
                          str(mask & 0xff)])
 
-    def ifconfig(self):
+    def ifconfig(self) -> str:
         nifs = self.qga.network_get_interfaces()
 
         msgs = []
@@ -141,7 +149,7 @@ class QemuGuestAgentClient:
 
         return '\n'.join(msgs)
 
-    def ping(self, timeout):
+    def ping(self, timeout: Optional[float]) -> bool:
         self.qga.settimeout(timeout)
         try:
             self.qga.ping()
@@ -149,37 +157,40 @@ class QemuGuestAgentClient:
             return False
         return True
 
-    def fsfreeze(self, cmd):
+    def fsfreeze(self, cmd: str) -> object:
         if cmd not in ['status', 'freeze', 'thaw']:
             raise Exception('Invalid command: ' + cmd)
-
+        # Can be int (freeze, thaw) or GuestFsfreezeStatus (status)
         return getattr(self.qga, 'fsfreeze' + '_' + cmd)()
 
-    def fstrim(self, minimum=0):
-        return getattr(self.qga, 'fstrim')(minimum=minimum)
+    def fstrim(self, minimum: int) -> Dict[str, object]:
+        # returns GuestFilesystemTrimResponse
+        ret = getattr(self.qga, 'fstrim')(minimum=minimum)
+        assert isinstance(ret, dict)
+        return ret
 
-    def suspend(self, mode):
+    def suspend(self, mode: str) -> None:
         if mode not in ['disk', 'ram', 'hybrid']:
             raise Exception('Invalid mode: ' + mode)
 
         try:
             getattr(self.qga, 'suspend' + '_' + mode)()
             # On error exception will raise
-        except self.qga.timeout:
+        except TimeoutError:
             # On success command will timed out
             return
 
-    def shutdown(self, mode='powerdown'):
+    def shutdown(self, mode: str = 'powerdown') -> None:
         if mode not in ['powerdown', 'halt', 'reboot']:
             raise Exception('Invalid mode: ' + mode)
 
         try:
             self.qga.shutdown(mode=mode)
-        except self.qga.timeout:
-            return
+        except TimeoutError:
+            pass
 
 
-def _cmd_cat(client, args):
+def _cmd_cat(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     if len(args) != 1:
         print('Invalid argument')
         print('Usage: cat <file>')
@@ -187,7 +198,7 @@ def _cmd_cat(client, args):
     print(client.read(args[0]))
 
 
-def _cmd_fsfreeze(client, args):
+def _cmd_fsfreeze(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     usage = 'Usage: fsfreeze status|freeze|thaw'
     if len(args) != 1:
         print('Invalid argument')
@@ -201,13 +212,14 @@ def _cmd_fsfreeze(client, args):
     ret = client.fsfreeze(cmd)
     if cmd == 'status':
         print(ret)
-    elif cmd == 'freeze':
-        print("%d filesystems frozen" % ret)
-    else:
-        print("%d filesystems thawed" % ret)
+        return
 
+    assert isinstance(ret, int)
+    verb = 'frozen' if cmd == 'freeze' else 'thawed'
+    print(f"{ret:d} filesystems {verb}")
 
-def _cmd_fstrim(client, args):
+
+def _cmd_fstrim(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     if len(args) == 0:
         minimum = 0
     else:
@@ -215,28 +227,25 @@ def _cmd_fstrim(client, args):
     print(client.fstrim(minimum))
 
 
-def _cmd_ifconfig(client, args):
+def _cmd_ifconfig(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     assert not args
     print(client.ifconfig())
 
 
-def _cmd_info(client, args):
+def _cmd_info(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     assert not args
     print(client.info())
 
 
-def _cmd_ping(client, args):
-    if len(args) == 0:
-        timeout = 3
-    else:
-        timeout = float(args[0])
+def _cmd_ping(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
+    timeout = 3.0 if len(args) == 0 else float(args[0])
     alive = client.ping(timeout)
     if not alive:
         print("Not responded in %s sec" % args[0])
         sys.exit(1)
 
 
-def _cmd_suspend(client, args):
+def _cmd_suspend(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     usage = 'Usage: suspend disk|ram|hybrid'
     if len(args) != 1:
         print('Less argument')
@@ -249,7 +258,7 @@ def _cmd_suspend(client, args):
     client.suspend(args[0])
 
 
-def _cmd_shutdown(client, args):
+def _cmd_shutdown(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     assert not args
     client.shutdown()
 
@@ -257,12 +266,12 @@ def _cmd_shutdown(client, args):
 _cmd_powerdown = _cmd_shutdown
 
 
-def _cmd_halt(client, args):
+def _cmd_halt(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     assert not args
     client.shutdown('halt')
 
 
-def _cmd_reboot(client, args):
+def _cmd_reboot(client: QemuGuestAgentClient, args: Sequence[str]) -> None:
     assert not args
     client.shutdown('reboot')
 
@@ -270,7 +279,7 @@ def _cmd_reboot(client, args):
 commands = [m.replace('_cmd_', '') for m in dir() if '_cmd_' in m]
 
 
-def send_command(address, cmd, args):
+def send_command(address: str, cmd: str, args: Sequence[str]) -> None:
     if not os.path.exists(address):
         print('%s not found' % address)
         sys.exit(1)
@@ -296,7 +305,7 @@ def send_command(address, cmd, args):
     globals()['_cmd_' + cmd](client, args)
 
 
-def main():
+def main() -> None:
     address = os.environ.get('QGA_CLIENT_ADDRESS')
 
     parser = argparse.ArgumentParser()
-- 
2.26.2


