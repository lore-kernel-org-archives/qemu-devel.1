Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A93C388F7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8C52223AB
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 01:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSvGL3iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8C52223AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka7EP-0005eR-Ii
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 20:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nT-0006jt-9A
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42949)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nQ-0004tu-GC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQxAzjyzGbRxcwuIegrUQx22TWF+Hk/vmjJukeB95vU=;
 b=RSvGL3iE1UcJ0LZU2N2TtluoE7+pl66VEnn3zgBJ2gHiBMN9VBFle4tXEN8h8Ov4AkgM5E
 EFUxdz5b7ZxvPUUaP0Ema52Be9xw480DO4aEfsxA0DFfS7fGfAoiBpblPKvUMEo3SzA5da
 FxLxsT+wNDbwQGUn8lz1jDphQGSzfZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-D3sh1EGePzSfRzFv5gpJnQ-1; Tue, 03 Nov 2020 19:37:01 -0500
X-MC-Unique: D3sh1EGePzSfRzFv5gpJnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89F7C1891E96
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:59 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B4A455766;
 Wed,  4 Nov 2020 00:36:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 40/72] scripts/qmp-shell: rename one and two-letter
 variables
Date: Tue,  3 Nov 2020 19:35:30 -0500
Message-Id: <20201104003602.1293560-41-jsnow@redhat.com>
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
 scripts/qmp/qmp-shell | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index e4163daf438d..2fd677e3dabd 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -196,8 +196,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
                 pass
             # Try once again as FuzzyJSON:
             try:
-                st = ast.parse(val, mode='eval')
-                return ast.literal_eval(FuzzyJSON().visit(st))
+                tree = ast.parse(val, mode='eval')
+                return ast.literal_eval(FuzzyJSON().visit(tree))
             except SyntaxError:
                 pass
             except ValueError:
@@ -215,14 +215,14 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             value = self.__parse_value(val)
             optpath = key.split('.')
             curpath = []
-            for p in optpath[:-1]:
-                curpath.append(p)
-                d = parent.get(p, {})
-                if type(d) is not dict:
+            for path in optpath[:-1]:
+                curpath.append(path)
+                obj = parent.get(path, {})
+                if type(obj) is not dict:
                     msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
                     raise QMPShellError(msg.format('.'.join(curpath)))
-                parent[p] = d
-                parent = d
+                parent[path] = obj
+                parent = obj
             if optpath[-1] in parent:
                 if type(parent[optpath[-1]]) is dict:
                     msg = 'Cannot use "{:s}" as both leaf and non-leaf key'
@@ -287,8 +287,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
     def _execute_cmd(self, cmdline):
         try:
             qmpcmd = self.__build_cmd(cmdline)
-        except Exception as e:
-            print('Error while parsing command line: %s' % e)
+        except Exception as err:
+            print('Error while parsing command line: %s' % err)
             print('command format: <command-name> ', end=' ')
             print('[arg-name1=arg1] ... [arg-nameN=argN]')
             return True
@@ -333,8 +333,8 @@ class QMPShell(qmp.QEMUMonitorProtocol):
             print()
             return False
         if cmdline == '':
-            for ev in self.get_events():
-                print(ev)
+            for event in self.get_events():
+                print(event)
             self.clear_events()
             return True
         else:
-- 
2.26.2


