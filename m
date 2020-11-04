Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F343C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19536223C7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Biv9/nHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19536223C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka718-0001cA-2y
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nN-0006Tu-B9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nK-0004rb-LI
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/Nw+zSVTMnnTd7dr9G0E/CT8iXWfy8uhfEhmW0+YZw=;
 b=Biv9/nHmk3CJjk9CiU7DM09SOPcYpehRWaKyQwqmcswVzUoTIQokAQfeUQ8F4bkoC7CdM5
 aLuokxRH8ocLi9SFNuiSiV5xacm4LA9eFlb9P66DRjj3lR0hdz+sg1Uk1MgtZ1agREGFaO
 FnoW0e6QOd9MTvOylCMIobboSbbS4ac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-bkok5OkSNBmLC9vk0OYFVw-1; Tue, 03 Nov 2020 19:36:54 -0500
X-MC-Unique: bkok5OkSNBmLC9vk0OYFVw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6EB2195D58D
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:46 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F327E75128;
 Wed,  4 Nov 2020 00:36:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 29/72] scripts/qmp-shell: Apply flake8 rules
Date: Tue,  3 Nov 2020 19:35:19 -0500
Message-Id: <20201104003602.1293560-30-jsnow@redhat.com>
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

A lot of fiddling around to get us below 80 columns.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 68 +++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 22 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 7ed45b8195b1..20c420ba4251 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -88,12 +88,15 @@ class QMPCompleter(list):
                 else:
                     state -= 1
 
+
 class QMPShellError(Exception):
     pass
 
+
 class QMPShellBadPort(QMPShellError):
     pass
 
+
 class FuzzyJSON(ast.NodeTransformer):
     '''This extension of ast.NodeTransformer filters literal "true/false/null"
     values in an AST and replaces them by proper "True/False/None" values that
@@ -107,6 +110,7 @@ class FuzzyJSON(ast.NodeTransformer):
             node.id = 'None'
         return node
 
+
 # TODO: QMPShell's interface is a bit ugly (eg. _fill_completion() and
 #       _execute_cmd()). Let's design a better one.
 class QMPShell(qmp.QEMUMonitorProtocol):
@@ -131,7 +135,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 port = int(addr[1])
             except ValueError:
                 raise QMPShellBadPort
-            return ( addr[0], port )
+            return addr[0], port
         # socket path
         return arg
 
@@ -148,8 +152,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         readline.set_history_length(1024)
         readline.set_completer(self._completer.complete)
         readline.parse_and_bind("tab: complete")
-        # XXX: default delimiters conflict with some command names (eg. query-),
-        # clearing everything as it doesn't seem to matter
+        # NB: default delimiters conflict with some command names
+        # (eg. query-), clearing everything as it doesn't seem to matter
         readline.set_completer_delims('')
         try:
             readline.read_history_file(self._histfile)
@@ -197,7 +201,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         for arg in tokens:
             (key, sep, val) = arg.partition('=')
             if sep != '=':
-                raise QMPShellError("Expected a key=value pair, got '%s'" % arg)
+                raise QMPShellError(
+                    f"Expected a key=value pair, got '{arg!s}'"
+                )
 
             value = self.__parse_value(val)
             optpath = key.split('.')
@@ -206,14 +212,16 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 curpath.append(p)
                 d = parent.get(p, {})
                 if type(d) is not dict:
-                    raise QMPShellError('Cannot use "%s" as both leaf and non-leaf key' % '.'.join(curpath))
+                    msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
+                    raise QMPShellError(msg.format('.'.join(curpath)))
                 parent[p] = d
                 parent = d
             if optpath[-1] in parent:
                 if type(parent[optpath[-1]]) is dict:
-                    raise QMPShellError('Cannot use "%s" as both leaf and non-leaf key' % '.'.join(curpath))
+                    msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
+                    raise QMPShellError(msg.format('.'.join(curpath)))
                 else:
-                    raise QMPShellError('Cannot set "%s" multiple times' % key)
+                    raise QMPShellError(f'Cannot set "{key}" multiple times')
             parent[optpath[-1]] = value
 
     def __build_cmd(self, cmdline):
@@ -223,7 +231,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
             < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
         """
-        cmdargs = re.findall(r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+''', cmdline)
+        argument_regex = r'''(?:[^\s"']|"(?:\\.|[^"])*"|'(?:\\.|[^'])*')+'''
+        cmdargs = re.findall(argument_regex, cmdline)
 
         # Transactional CLI entry/exit:
         if cmdargs[0] == 'transaction(':
@@ -232,9 +241,12 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         elif cmdargs[0] == ')' and self._transmode:
             self._transmode = False
             if len(cmdargs) > 1:
-                raise QMPShellError("Unexpected input after close of Transaction sub-shell")
-            qmpcmd = { 'execute': 'transaction',
-                       'arguments': { 'actions': self._actions } }
+                msg = 'Unexpected input after close of Transaction sub-shell'
+                raise QMPShellError(msg)
+            qmpcmd = {
+                'execute': 'transaction',
+                'arguments': {'actions': self._actions}
+            }
             self._actions = list()
             return qmpcmd
 
@@ -245,7 +257,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         # Parse and then cache this Transactional Action
         if self._transmode:
             finalize = False
-            action = { 'type': cmdargs[0], 'data': {} }
+            action = {'type': cmdargs[0], 'data': {}}
             if cmdargs[-1] == ')':
                 cmdargs.pop(-1)
                 finalize = True
@@ -254,7 +266,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             return self.__build_cmd(')') if finalize else None
 
         # Standard command: parse and return it to be executed.
-        qmpcmd = { 'execute': cmdargs[0], 'arguments': {} }
+        qmpcmd = {'execute': cmdargs[0], 'arguments': {}}
         self.__cli_expr(cmdargs[1:], qmpcmd['arguments'])
         return qmpcmd
 
@@ -295,7 +307,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             print('Connected')
             return
         version = self._greeting['QMP']['version']['qemu']
-        print('Connected to QEMU %d.%d.%d\n' % (version['major'],version['minor'],version['micro']))
+        print("Connected to QEMU {major}.{minor}.{micro}\n".format(**version))
 
     def get_prompt(self):
         if self._transmode:
@@ -324,6 +336,7 @@ class QMPShell(qmp.QEMUMonitorProtocol):
     def set_verbosity(self, verbose):
         self._verbose = verbose
 
+
 class HMPShell(QMPShell):
     def __init__(self, address):
         QMPShell.__init__(self, address)
@@ -332,7 +345,7 @@ class HMPShell(QMPShell):
     def __cmd_completion(self):
         for cmd in self.__cmd_passthrough('help')['return'].split('\r\n'):
             if cmd and cmd[0] != '[' and cmd[0] != '\t':
-                name = cmd.split()[0] # drop help text
+                name = cmd.split()[0]  # drop help text
                 if name == 'info':
                     continue
                 if name.find('|') != -1:
@@ -344,7 +357,7 @@ class HMPShell(QMPShell):
                     else:
                         name = opt[0]
                 self._completer.append(name)
-                self._completer.append('help ' + name) # help completion
+                self._completer.append('help ' + name)  # help completion
 
     def __info_completion(self):
         for cmd in self.__cmd_passthrough('info')['return'].split('\r\n'):
@@ -360,17 +373,21 @@ class HMPShell(QMPShell):
         self.__info_completion()
         self.__other_completion()
 
-    def __cmd_passthrough(self, cmdline, cpu_index = 0):
-        return self.cmd_obj({ 'execute': 'human-monitor-command', 'arguments':
-                              { 'command-line': cmdline,
-                                'cpu-index': cpu_index } })
+    def __cmd_passthrough(self, cmdline, cpu_index=0):
+        return self.cmd_obj({
+            'execute': 'human-monitor-command',
+            'arguments': {
+                'command-line': cmdline,
+                'cpu-index': cpu_index
+            }
+        })
 
     def _execute_cmd(self, cmdline):
         if cmdline.split()[0] == "cpu":
             # trap the cpu command, it requires special setting
             try:
                 idx = int(cmdline.split()[1])
-                if not 'return' in self.__cmd_passthrough('info version', idx):
+                if 'return' not in self.__cmd_passthrough('info version', idx):
                     print('bad CPU index')
                     return True
                 self.__cpu_index = idx
@@ -394,20 +411,26 @@ class HMPShell(QMPShell):
     def show_banner(self):
         QMPShell.show_banner(self, msg='Welcome to the HMP shell!')
 
+
 def die(msg):
     sys.stderr.write('ERROR: %s\n' % msg)
     sys.exit(1)
 
+
 def fail_cmdline(option=None):
     if option:
         sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % option)
-    sys.stderr.write('qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX socket path> | < TCP address:port >\n')
+    sys.stderr.write(
+        'qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] '
+        '< UNIX socket path> | < TCP address:port >\n'
+    )
     sys.stderr.write('    -v     Verbose (echo command sent and received)\n')
     sys.stderr.write('    -p     Pretty-print JSON\n')
     sys.stderr.write('    -H     Use HMP interface\n')
     sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
     sys.exit(1)
 
+
 def main():
     addr = ''
     qemu = None
@@ -457,5 +480,6 @@ def main():
         pass
     qemu.close()
 
+
 if __name__ == '__main__':
     main()
-- 
2.26.2


