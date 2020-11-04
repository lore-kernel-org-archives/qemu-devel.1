Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91AC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E1120870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EAjmUQNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E1120870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7dh-0000ul-Hd
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6o5-0007ef-LM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6o0-0004z6-Kd
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Q7qh9uMxQEd1ERc+PLZ2ut7YmMhXW1F3j7R0pQeAnU=;
 b=EAjmUQNbN4iZ+D347YGge2iZPvu0jS3bgKaJ5cegY4+8XyXmKQeOG06a0qUAPiHSvASJjh
 +0xOZGBwZWCApxpYgCm0GD1+XMGerIzr33nSKipToJGdY3AMHxUU6FehVDKzZjHeiP2RyJ
 IZ2+USjcpWUmTMFIK+xNFYe1dpx6EVc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-0rnVFqecMruZCXMFDwzIrA-1; Tue, 03 Nov 2020 19:37:38 -0500
X-MC-Unique: 0rnVFqecMruZCXMFDwzIrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1468F835B8C
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:37:37 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B35575127;
 Wed,  4 Nov 2020 00:37:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 69/72] scripts/qmp-shell: add docstrings
Date: Tue,  3 Nov 2020 19:35:59 -0500
Message-Id: <20201104003602.1293560-70-jsnow@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp-shell | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 1a8a4ba18ab4..15aedb80c2af 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -106,15 +106,20 @@ LOG = logging.getLogger(__name__)
 
 
 class QMPCompleter:
+    """
+    QMPCompleter provides a readline library tab-complete behavior.
+    """
     # NB: Python 3.9+ will probably allow us to subclass list[str] directly,
     # but pylint as of today does not know that List[str] is simply 'list'.
     def __init__(self) -> None:
         self._matches: List[str] = []
 
     def append(self, value: str) -> None:
+        """Append a new valid completion to the list of possibilities."""
         return self._matches.append(value)
 
     def complete(self, text: str, state: int) -> Optional[str]:
+        """readline.set_completer() callback implementation."""
         for cmd in self._matches:
             if cmd.startswith(text):
                 if state == 0:
@@ -124,7 +129,9 @@ class QMPCompleter:
 
 
 class QMPShellError(qmp.QMPError):
-    pass
+    """
+    QMP Shell Base error class.
+    """
 
 
 class FuzzyJSON(ast.NodeTransformer):
@@ -137,6 +144,9 @@ class FuzzyJSON(ast.NodeTransformer):
     @classmethod
     def visit_Name(cls,  # pylint: disable=invalid-name
                    node: ast.Name) -> ast.AST:
+        """
+        Transform Name nodes with certain values into Constant (keyword) nodes.
+        """
         if node.id == 'true':
             return ast.Constant(value=True)
         if node.id == 'false':
@@ -147,6 +157,13 @@ class FuzzyJSON(ast.NodeTransformer):
 
 
 class QMPShell(qmp.QEMUMonitorProtocol):
+    """
+    QMPShell provides a basic readline-based QMP shell.
+
+    :param address: Address of the QMP server.
+    :param pretty: Pretty-print QMP messages.
+    :param verbose: Echo outgoing QMP messages to console.
+    """
     def __init__(self, address: qmp.SocketAddrT,
                  pretty: bool = False, verbose: bool = False):
         super().__init__(address)
@@ -333,6 +350,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     def show_banner(self,
                     msg: str = 'Welcome to the QMP low-level shell!') -> None:
+        """
+        Print to stdio a greeting, and the QEMU version if available.
+        """
         print(msg)
         if not self._greeting:
             print('Connected')
@@ -342,6 +362,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
     @property
     def prompt(self) -> str:
+        """
+        Return the current shell prompt, including a trailing space.
+        """
         if self._transmode:
             return 'TRANS> '
         return '(QEMU) '
@@ -367,6 +390,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
         return self._execute_cmd(cmdline)
 
     def repl(self) -> Iterator[None]:
+        """
+        Return an iterator that implements the REPL.
+        """
         self.show_banner()
         while self.read_exec_command():
             yield
@@ -374,6 +400,13 @@ class QMPShell(qmp.QEMUMonitorProtocol):
 
 
 class HMPShell(QMPShell):
+    """
+    HMPShell provides a basic readline-based HMP shell, tunnelled via QMP.
+
+    :param address: Address of the QMP server.
+    :param pretty: Pretty-print QMP messages.
+    :param verbose: Echo outgoing QMP messages to console.
+    """
     def __init__(self, address: qmp.SocketAddrT,
                  pretty: bool = False, verbose: bool = False):
         super().__init__(address, pretty, verbose)
@@ -451,11 +484,15 @@ class HMPShell(QMPShell):
 
 
 def die(msg: str) -> NoReturn:
+    """Write an error to stderr, then exit with a return code of 1."""
     sys.stderr.write('ERROR: %s\n' % msg)
     sys.exit(1)
 
 
 def main() -> None:
+    """
+    qmp-shell entry point: parse command line arguments and start the REPL.
+    """
     parser = argparse.ArgumentParser()
     parser.add_argument('-H', '--hmp', action='store_true',
                         help='Use HMP interface')
-- 
2.26.2


