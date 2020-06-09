Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82EDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82B7C20734
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eDhckG5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82B7C20734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jilHz-0006sE-O4
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 16:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEw-0001ip-ST
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jilEu-0005bR-09
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 16:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591735975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bLALEe20suyTXRiWgricSQvXLZdaHyPd0f+EDscknEY=;
 b=eDhckG5jfzi3F+fpiJ8s57ADW5iuxf6eFPjkTGCw9dzh/bjkYX68mX7ius6PYgWIEWMHce
 ROURyucXV3NVvDcLoLC460i7XIkoyxlQQTH3BsrwzaJDBVqJ6fPoJmPEhOlFrJIK/URUvA
 bT35eUyu2NLqFji1kf2IHXxdRFhtpxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-ymBcn-lKOniPRaLqbrJSKQ-1; Tue, 09 Jun 2020 16:52:49 -0400
X-MC-Unique: ymBcn-lKOniPRaLqbrJSKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93C44107ACF9;
 Tue,  9 Jun 2020 20:52:48 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 257A160C80;
 Tue,  9 Jun 2020 20:52:48 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/15] qcow2.py: python style fixes
Date: Tue,  9 Jun 2020 15:52:32 -0500
Message-Id: <20200609205245.3548257-3-eblake@redhat.com>
In-Reply-To: <20200609205245.3548257-1-eblake@redhat.com>
References: <20200609205245.3548257-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 16:46:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Fix flake8 complaints.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200606081806.23897-2-vsementsov@virtuozzo.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: commit message improved]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/qcow2.py | 95 ++++++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/qcow2.py b/tests/qemu-iotests/qcow2.py
index 94a07b2f6fa2..d99f4ee3e848 100755
--- a/tests/qemu-iotests/qcow2.py
+++ b/tests/qemu-iotests/qcow2.py
@@ -4,6 +4,7 @@ import sys
 import struct
 import string

+
 class QcowHeaderExtension:

     def __init__(self, magic, length, data):
@@ -11,14 +12,15 @@ class QcowHeaderExtension:
             padding = 8 - (length % 8)
             data += b"\0" * padding

-        self.magic  = magic
+        self.magic = magic
         self.length = length
-        self.data   = data
+        self.data = data

     @classmethod
     def create(cls, magic, data):
         return QcowHeaderExtension(magic, len(data), data)

+
 class QcowHeader:

     uint32_t = 'I'
@@ -26,27 +28,27 @@ class QcowHeader:

     fields = [
         # Version 2 header fields
-        [ uint32_t, '%#x',  'magic' ],
-        [ uint32_t, '%d',   'version' ],
-        [ uint64_t, '%#x',  'backing_file_offset' ],
-        [ uint32_t, '%#x',  'backing_file_size' ],
-        [ uint32_t, '%d',   'cluster_bits' ],
-        [ uint64_t, '%d',   'size' ],
-        [ uint32_t, '%d',   'crypt_method' ],
-        [ uint32_t, '%d',   'l1_size' ],
-        [ uint64_t, '%#x',  'l1_table_offset' ],
-        [ uint64_t, '%#x',  'refcount_table_offset' ],
-        [ uint32_t, '%d',   'refcount_table_clusters' ],
-        [ uint32_t, '%d',   'nb_snapshots' ],
-        [ uint64_t, '%#x',  'snapshot_offset' ],
+        [uint32_t, '%#x',  'magic'],
+        [uint32_t, '%d',   'version'],
+        [uint64_t, '%#x',  'backing_file_offset'],
+        [uint32_t, '%#x',  'backing_file_size'],
+        [uint32_t, '%d',   'cluster_bits'],
+        [uint64_t, '%d',   'size'],
+        [uint32_t, '%d',   'crypt_method'],
+        [uint32_t, '%d',   'l1_size'],
+        [uint64_t, '%#x',  'l1_table_offset'],
+        [uint64_t, '%#x',  'refcount_table_offset'],
+        [uint32_t, '%d',   'refcount_table_clusters'],
+        [uint32_t, '%d',   'nb_snapshots'],
+        [uint64_t, '%#x',  'snapshot_offset'],

         # Version 3 header fields
-        [ uint64_t, 'mask', 'incompatible_features' ],
-        [ uint64_t, 'mask', 'compatible_features' ],
-        [ uint64_t, 'mask', 'autoclear_features' ],
-        [ uint32_t, '%d',   'refcount_order' ],
-        [ uint32_t, '%d',   'header_length' ],
-    ];
+        [uint64_t, 'mask', 'incompatible_features'],
+        [uint64_t, 'mask', 'compatible_features'],
+        [uint64_t, 'mask', 'autoclear_features'],
+        [uint32_t, '%d',   'refcount_order'],
+        [uint32_t, '%d',   'header_length'],
+    ]

     fmt = '>' + ''.join(field[0] for field in fields)

@@ -59,7 +61,7 @@ class QcowHeader:

         header = struct.unpack(QcowHeader.fmt, buf)
         self.__dict__ = dict((field[2], header[i])
-            for i, field in enumerate(QcowHeader.fields))
+                             for i, field in enumerate(QcowHeader.fields))

         self.set_defaults()
         self.cluster_size = 1 << self.cluster_bits
@@ -96,7 +98,8 @@ class QcowHeader:
             else:
                 padded = (length + 7) & ~7
                 data = fd.read(padded)
-                self.extensions.append(QcowHeaderExtension(magic, length, data))
+                self.extensions.append(QcowHeaderExtension(magic, length,
+                                                           data))

     def update_extensions(self, fd):

@@ -108,14 +111,13 @@ class QcowHeader:
             fd.write(buf)
             fd.write(ex.data)

-        if self.backing_file != None:
+        if self.backing_file is not None:
             self.backing_file_offset = fd.tell()
             fd.write(self.backing_file)

         if fd.tell() > self.cluster_size:
             raise Exception("I think I just broke the image...")

-
     def update(self, fd):
         header_bytes = self.header_length

@@ -163,19 +165,21 @@ def cmd_dump_header(fd):
     h.dump()
     h.dump_extensions()

+
 def cmd_dump_header_exts(fd):
     h = QcowHeader(fd)
     h.dump_extensions()

+
 def cmd_set_header(fd, name, value):
     try:
         value = int(value, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid number" % value)
         sys.exit(1)

     fields = (field[2] for field in QcowHeader.fields)
-    if not name in fields:
+    if name not in fields:
         print("'%s' is not a known header field" % name)
         sys.exit(1)

@@ -183,25 +187,29 @@ def cmd_set_header(fd, name, value):
     h.__dict__[name] = value
     h.update(fd)

+
 def cmd_add_header_ext(fd, magic, data):
     try:
         magic = int(magic, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid magic number" % magic)
         sys.exit(1)

     h = QcowHeader(fd)
-    h.extensions.append(QcowHeaderExtension.create(magic, data.encode('ascii')))
+    h.extensions.append(QcowHeaderExtension.create(magic,
+                                                   data.encode('ascii')))
     h.update(fd)

+
 def cmd_add_header_ext_stdio(fd, magic):
     data = sys.stdin.read()
     cmd_add_header_ext(fd, magic, data)

+
 def cmd_del_header_ext(fd, magic):
     try:
         magic = int(magic, 0)
-    except:
+    except ValueError:
         print("'%s' is not a valid magic number" % magic)
         sys.exit(1)

@@ -219,12 +227,13 @@ def cmd_del_header_ext(fd, magic):

     h.update(fd)

+
 def cmd_set_feature_bit(fd, group, bit):
     try:
         bit = int(bit, 0)
         if bit < 0 or bit >= 64:
             raise ValueError
-    except:
+    except ValueError:
         print("'%s' is not a valid bit number in range [0, 64)" % bit)
         sys.exit(1)

@@ -236,21 +245,27 @@ def cmd_set_feature_bit(fd, group, bit):
     elif group == 'autoclear':
         h.autoclear_features |= 1 << bit
     else:
-        print("'%s' is not a valid group, try 'incompatible', 'compatible', or 'autoclear'" % group)
+        print("'%s' is not a valid group, try "
+              "'incompatible', 'compatible', or 'autoclear'" % group)
         sys.exit(1)

     h.update(fd)

+
 cmds = [
-    [ 'dump-header',          cmd_dump_header,          0, 'Dump image header and header extensions' ],
-    [ 'dump-header-exts',     cmd_dump_header_exts,     0, 'Dump image header extensions' ],
-    [ 'set-header',           cmd_set_header,           2, 'Set a field in the header'],
-    [ 'add-header-ext',       cmd_add_header_ext,       2, 'Add a header extension' ],
-    [ 'add-header-ext-stdio', cmd_add_header_ext_stdio, 1, 'Add a header extension, data from stdin' ],
-    [ 'del-header-ext',       cmd_del_header_ext,       1, 'Delete a header extension' ],
-    [ 'set-feature-bit',      cmd_set_feature_bit,      2, 'Set a feature bit'],
+    ['dump-header', cmd_dump_header, 0,
+     'Dump image header and header extensions'],
+    ['dump-header-exts', cmd_dump_header_exts, 0,
+     'Dump image header extensions'],
+    ['set-header', cmd_set_header, 2, 'Set a field in the header'],
+    ['add-header-ext', cmd_add_header_ext, 2, 'Add a header extension'],
+    ['add-header-ext-stdio', cmd_add_header_ext_stdio, 1,
+     'Add a header extension, data from stdin'],
+    ['del-header-ext', cmd_del_header_ext, 1, 'Delete a header extension'],
+    ['set-feature-bit', cmd_set_feature_bit, 2, 'Set a feature bit'],
 ]

+
 def main(filename, cmd, args):
     fd = open(filename, "r+b")
     try:
@@ -267,6 +282,7 @@ def main(filename, cmd, args):
     finally:
         fd.close()

+
 def usage():
     print("Usage: %s <file> <cmd> [<arg>, ...]" % sys.argv[0])
     print("")
@@ -274,6 +290,7 @@ def usage():
     for name, handler, num_args, desc in cmds:
         print("    %-20s - %s" % (name, desc))

+
 if __name__ == '__main__':
     if len(sys.argv) < 3:
         usage()
-- 
2.27.0


