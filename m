Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EBCC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:04:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDE242177B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 19:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yj6bES4K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE242177B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVJPK-0003Vu-P2
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 15:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJE0-0006Aq-TG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kVJDu-0008Ao-R2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 14:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603306336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSFK5YVxuw88iCvicYvxpihP3Np7r5+wo0sUBRYqgMg=;
 b=Yj6bES4Kx6FpyWmOdVaiqjHTijzHCboNG+VETRdm7PDMMAbp52XAZ0Q+ScgT6GSbvtVaQF
 pEpk7w+yGT3Pu7jT4MXrdyhSHVnbQJSicjAm+YaL6Yyh2477E9j/CI1V115eZbQy2Xuf32
 hLigSyVSfQ9PbERXh76o2h9wZk8z2x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-PSYy8VU9OLeuqx9v2Kz2Dw-1; Wed, 21 Oct 2020 14:52:14 -0400
X-MC-Unique: PSYy8VU9OLeuqx9v2Kz2Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76A07804B60
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 18:52:13 +0000 (UTC)
Received: from scv.redhat.com (ovpn-116-160.rdu2.redhat.com [10.10.116.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE65610027A5;
 Wed, 21 Oct 2020 18:52:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/15] scripts/qom-fuse: apply flake8 rules
Date: Wed, 21 Oct 2020 14:51:58 -0400
Message-Id: <20201021185208.1611145-6-jsnow@redhat.com>
In-Reply-To: <20201021185208.1611145-1-jsnow@redhat.com>
References: <20201021185208.1611145-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
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
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

flake8 still has one warning because of the sys.path hack, but that will
be going away by the end of this patch series.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qom-fuse | 81 +++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 38 deletions(-)

diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index 62deb9adb1..ca30e92867 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -9,13 +9,12 @@
 #  Anthony Liguori   <aliguori@us.ibm.com>
 #  Markus Armbruster <armbru@redhat.com>
 #
-# This work is licensed under the terms of the GNU GPL, version 2 or later.  See
-# the COPYING file in the top-level directory.
+# This work is licensed under the terms of the GNU GPL, version 2 or later.
+# See the COPYING file in the top-level directory.
 ##
 
-from errno import *
+from errno import ENOENT, EPERM
 import os
-import posix
 import stat
 import sys
 
@@ -29,6 +28,7 @@ from qemu.qmp import QEMUMonitorProtocol
 
 fuse.fuse_python_api = (0, 2)
 
+
 class QOMFS(Operations):
     def __init__(self, qmp):
         self.qmp = qmp
@@ -45,7 +45,7 @@ class QOMFS(Operations):
 
     def is_object(self, path):
         try:
-            items = self.qmp.command('qom-list', path=path)
+            self.qmp.command('qom-list', path=path)
             return True
         except:
             return False
@@ -85,7 +85,7 @@ class QOMFS(Operations):
             path = '/'
         try:
             data = self.qmp.command('qom-get', path=path, property=prop)
-            data += '\n' # make values shell friendly
+            data += '\n'  # make values shell friendly
         except:
             raise FuseOSError(EPERM)
 
@@ -104,38 +104,44 @@ class QOMFS(Operations):
 
     def getattr(self, path, fh=None):
         if self.is_link(path):
-            value = { 'st_mode': 0o755 | stat.S_IFLNK,
-                      'st_ino': self.get_ino(path),
-                      'st_dev': 0,
-                      'st_nlink': 2,
-                      'st_uid': 1000,
-                      'st_gid': 1000,
-                      'st_size': 4096,
-                      'st_atime': 0,
-                      'st_mtime': 0,
-                      'st_ctime': 0 }
+            value = {
+                'st_mode': 0o755 | stat.S_IFLNK,
+                'st_ino': self.get_ino(path),
+                'st_dev': 0,
+                'st_nlink': 2,
+                'st_uid': 1000,
+                'st_gid': 1000,
+                'st_size': 4096,
+                'st_atime': 0,
+                'st_mtime': 0,
+                'st_ctime': 0
+            }
         elif self.is_object(path):
-            value = { 'st_mode': 0o755 | stat.S_IFDIR,
-                      'st_ino': self.get_ino(path),
-                      'st_dev': 0,
-                      'st_nlink': 2,
-                      'st_uid': 1000,
-                      'st_gid': 1000,
-                      'st_size': 4096,
-                      'st_atime': 0,
-                      'st_mtime': 0,
-                      'st_ctime': 0 }
+            value = {
+                'st_mode': 0o755 | stat.S_IFDIR,
+                'st_ino': self.get_ino(path),
+                'st_dev': 0,
+                'st_nlink': 2,
+                'st_uid': 1000,
+                'st_gid': 1000,
+                'st_size': 4096,
+                'st_atime': 0,
+                'st_mtime': 0,
+                'st_ctime': 0
+            }
         elif self.is_property(path):
-            value = { 'st_mode': 0o644 | stat.S_IFREG,
-                      'st_ino': self.get_ino(path),
-                      'st_dev': 0,
-                      'st_nlink': 1,
-                      'st_uid': 1000,
-                      'st_gid': 1000,
-                      'st_size': 4096,
-                      'st_atime': 0,
-                      'st_mtime': 0,
-                      'st_ctime': 0 }
+            value = {
+                'st_mode': 0o644 | stat.S_IFREG,
+                'st_ino': self.get_ino(path),
+                'st_dev': 0,
+                'st_nlink': 1,
+                'st_uid': 1000,
+                'st_gid': 1000,
+                'st_size': 4096,
+                'st_atime': 0,
+                'st_mtime': 0,
+                'st_ctime': 0
+            }
         else:
             raise FuseOSError(ENOENT)
         return value
@@ -146,8 +152,7 @@ class QOMFS(Operations):
         for item in self.qmp.command('qom-list', path=path):
             yield str(item['name'])
 
+
 if __name__ == '__main__':
-    import os
-
     fuse = FUSE(QOMFS(QEMUMonitorProtocol(os.environ['QMP_SOCKET'])),
                 sys.argv[1], foreground=True)
-- 
2.26.2


