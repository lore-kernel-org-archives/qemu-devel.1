Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493BFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFB49223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgOGhdar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB49223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7IV-0003I0-PY
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:09:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6o0-0007Zs-Bi
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6ny-0004yh-97
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=78jL6/OaCghfIdn9yhVtvUgPfPribGKLhjg9bPI806Y=;
 b=SgOGhdarFhb2LK3WrGu7V0JL1X+dabRwx/VVtG68tHATFcCrThYk56/BtFlkSDM4Mgsn+O
 QB0IaY1pjQa2Ld2nnQD93qK0TD4kmvJSwI9NETtRSTMqudMBkpnhLpdb5wdXJvY877N0Dt
 DXBxkpKbHakWBM98htvZXhIrCr4ugKw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-FbBq82JjMISjrOc-V7aaEA-1; Tue, 03 Nov 2020 19:37:36 -0500
X-MC-Unique: FbBq82JjMISjrOc-V7aaEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32E5C6D242
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:35 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74E296266E;
 Wed,  4 Nov 2020 00:37:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 67/72] scripts/qmp-shell: remove double-underscores
Date: Tue,  3 Nov 2020 19:35:57 -0500
Message-Id: <20201104003602.1293560-68-jsnow@redhat.com>
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

They're not needed; single underscore is enough to express intent that
these methods are "internal". double underscore is used as a weak name
mangling, but that isn't beneficial for us here.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 82fe16cff820..40ff9e0a82bd 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -171,7 +171,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         for cmd in cmds['return']:
             self._completer.append(cmd['name'])
 
-    def __completer_setup(self) -> None:
+    def _completer_setup(self) -> None:
         self._completer = QMPCompleter()
         self._fill_completion()
         readline.set_history_length(1024)
@@ -196,7 +196,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             LOG.warning(msg)
 
     @classmethod
-    def __parse_value(cls, val: str) -> object:
+    def _parse_value(cls, val: str) -> object:
         try:
             return int(val)
         except ValueError:
@@ -221,9 +221,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 pass
         return val
 
-    def __cli_expr(self,
-                   tokens: Sequence[str],
-                   parent: qmp.QMPObject) -> None:
+    def _cli_expr(self,
+                  tokens: Sequence[str],
+                  parent: qmp.QMPObject) -> None:
         for arg in tokens:
             (key, sep, val) = arg.partition('=')
             if sep != '=':
@@ -231,7 +231,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                     f"Expected a key=value pair, got '{arg!s}'"
                 )
 
-            value = self.__parse_value(val)
+            value = self._parse_value(val)
             optpath = key.split('.')
             curpath = []
             for path in optpath[:-1]:
@@ -249,7 +249,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 raise QMPShellError(f'Cannot set "{key}" multiple times')
             parent[optpath[-1]] = value
 
-    def __build_cmd(self, cmdline: str) -> Optional[QMPMessage]:
+    def _build_cmd(self, cmdline: str) -> Optional[QMPMessage]:
         """
         Build a QMP input object from a user provided command-line in the
         following format:
@@ -289,13 +289,13 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             if cmdargs[-1] == ')':
                 cmdargs.pop(-1)
                 finalize = True
-            self.__cli_expr(cmdargs[1:], action['data'])
+            self._cli_expr(cmdargs[1:], action['data'])
             self._actions.append(action)
-            return self.__build_cmd(')') if finalize else None
+            return self._build_cmd(')') if finalize else None
 
         # Standard command: parse and return it to be executed.
         qmpcmd = {'execute': cmdargs[0], 'arguments': {}}
-        self.__cli_expr(cmdargs[1:], qmpcmd['arguments'])
+        self._cli_expr(cmdargs[1:], qmpcmd['arguments'])
         return qmpcmd
 
     def _print(self, qmp_message: object) -> None:
@@ -306,7 +306,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     def _execute_cmd(self, cmdline: str) -> bool:
         try:
-            qmpcmd = self.__build_cmd(cmdline)
+            qmpcmd = self._build_cmd(cmdline)
         except QMPShellError as err:
             print(
                 f"Error while parsing command line: {err!s}\n"
@@ -329,7 +329,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     def connect(self, negotiate: bool = True) -> None:
         self._greeting = super().connect(negotiate)
-        self.__completer_setup()
+        self._completer_setup()
 
     def show_banner(self,
                     msg: str = 'Welcome to the QMP low-level shell!') -> None:
@@ -377,10 +377,10 @@ class HMPShell(QMPShell):
     def __init__(self, address: qmp.SocketAddrT,
                  pretty: bool = False, verbose: bool = False):
         super().__init__(address, pretty, verbose)
-        self.__cpu_index = 0
+        self._cpu_index = 0
 
-    def __cmd_completion(self) -> None:
-        for cmd in self.__cmd_passthrough('help')['return'].split('\r\n'):
+    def _cmd_completion(self) -> None:
+        for cmd in self._cmd_passthrough('help')['return'].split('\r\n'):
             if cmd and cmd[0] != '[' and cmd[0] != '\t':
                 name = cmd.split()[0]  # drop help text
                 if name == 'info':
@@ -396,22 +396,22 @@ class HMPShell(QMPShell):
                 self._completer.append(name)
                 self._completer.append('help ' + name)  # help completion
 
-    def __info_completion(self) -> None:
-        for cmd in self.__cmd_passthrough('info')['return'].split('\r\n'):
+    def _info_completion(self) -> None:
+        for cmd in self._cmd_passthrough('info')['return'].split('\r\n'):
             if cmd:
                 self._completer.append('info ' + cmd.split()[1])
 
-    def __other_completion(self) -> None:
+    def _other_completion(self) -> None:
         # special cases
         self._completer.append('help info')
 
     def _fill_completion(self) -> None:
-        self.__cmd_completion()
-        self.__info_completion()
-        self.__other_completion()
+        self._cmd_completion()
+        self._info_completion()
+        self._other_completion()
 
-    def __cmd_passthrough(self, cmdline: str,
-                          cpu_index: int = 0) -> QMPMessage:
+    def _cmd_passthrough(self, cmdline: str,
+                         cpu_index: int = 0) -> QMPMessage:
         return self.cmd_obj({
             'execute': 'human-monitor-command',
             'arguments': {
@@ -425,14 +425,14 @@ class HMPShell(QMPShell):
             # trap the cpu command, it requires special setting
             try:
                 idx = int(cmdline.split()[1])
-                if 'return' not in self.__cmd_passthrough('info version', idx):
+                if 'return' not in self._cmd_passthrough('info version', idx):
                     print('bad CPU index')
                     return True
-                self.__cpu_index = idx
+                self._cpu_index = idx
             except ValueError:
                 print('cpu command takes an integer argument')
                 return True
-        resp = self.__cmd_passthrough(cmdline, self.__cpu_index)
+        resp = self._cmd_passthrough(cmdline, self._cpu_index)
         if resp is None:
             print('Disconnected')
             return False
-- 
2.26.2


