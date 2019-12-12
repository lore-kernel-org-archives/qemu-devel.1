Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56913C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8972A2073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 17:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ef5+Ov0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8972A2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRvq-0001yV-C2
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 12:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1ifRV7-0005C8-4e
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1ifRUv-00012p-WD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ifRUu-0000zv-SY
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:39:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GxERprBJN2oU2fcSySbGFuOW4Rkey/JFgzzIkafm3TY=;
 b=ef5+Ov0ewwudont6vhbI/5fx2YbMhAbaJvD+7mTZmpASaA3XJu8jErQbPGs8KWcodlYNjJ
 JAN53ynAoLkG8qC/W9IdPkhIPMsTiXMnieIlH0AamHfB+TQozrqB4op2eDbFYEYN5wiYDs
 Ip3D3N/gXO9mMlw068/83gL1YvaIKdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-jHQF9TLUMYKWMQDmtoxHVQ-1; Thu, 12 Dec 2019 11:39:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49001801E66
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 16:39:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4277C60BE1;
 Thu, 12 Dec 2019 16:39:19 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com,
	vgoyal@redhat.com
Subject: [PATCH 007/104] virtiofsd: Format imported files to qemu style
Date: Thu, 12 Dec 2019 16:37:27 +0000
Message-Id: <20191212163904.159893-8-dgilbert@redhat.com>
In-Reply-To: <20191212163904.159893-1-dgilbert@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: jHQF9TLUMYKWMQDmtoxHVQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Mostly using a set like:

indent -nut -i 4 -nlp -br -cs -ce --no-space-after-function-call-names file
clang-format -style=3Dfile -i -- file
clang-tidy -fix-errors -checks=3Dreadability-braces-around-statements file
clang-format -style=3Dfile -i -- file

With manual cleanups.

The .clang-format used is below.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Language:        Cpp
AlignAfterOpenBracket: Align
AlignConsecutiveAssignments: false # although we like it, it creates churn
AlignConsecutiveDeclarations: false
AlignEscapedNewlinesLeft: true
AlignOperands:   true
AlignTrailingComments: false # churn
AllowAllParametersOfDeclarationOnNextLine: true
AllowShortBlocksOnASingleLine: false
AllowShortCaseLabelsOnASingleLine: false
AllowShortFunctionsOnASingleLine: None
AllowShortIfStatementsOnASingleLine: false
AllowShortLoopsOnASingleLine: false
AlwaysBreakAfterReturnType: None # AlwaysBreakAfterDefinitionReturnType is =
taken into account
AlwaysBreakBeforeMultilineStrings: false
BinPackArguments: true
BinPackParameters: true
BraceWrapping:
  AfterControlStatement: false
  AfterEnum:       false
  AfterFunction:   true
  AfterStruct:     false
  AfterUnion:      false
  BeforeElse:      false
  IndentBraces:    false
BreakBeforeBinaryOperators: None
BreakBeforeBraces: Custom
BreakBeforeTernaryOperators: false
BreakStringLiterals: true
ColumnLimit:     80
ContinuationIndentWidth: 4
Cpp11BracedListStyle: false
DerivePointerAlignment: false
DisableFormat:   false
ForEachMacros:   [
  'CPU_FOREACH',
  'CPU_FOREACH_REVERSE',
  'CPU_FOREACH_SAFE',
  'IOMMU_NOTIFIER_FOREACH',
  'QLIST_FOREACH',
  'QLIST_FOREACH_ENTRY',
  'QLIST_FOREACH_RCU',
  'QLIST_FOREACH_SAFE',
  'QLIST_FOREACH_SAFE_RCU',
  'QSIMPLEQ_FOREACH',
  'QSIMPLEQ_FOREACH_SAFE',
  'QSLIST_FOREACH',
  'QSLIST_FOREACH_SAFE',
  'QTAILQ_FOREACH',
  'QTAILQ_FOREACH_REVERSE',
  'QTAILQ_FOREACH_SAFE',
  'QTAILQ_RAW_FOREACH',
  'RAMBLOCK_FOREACH'
]
IncludeCategories:
  - Regex:           '^"qemu/osdep.h'
    Priority:        -3
  - Regex:           '^"(block|chardev|crypto|disas|exec|fpu|hw|io|libdecnu=
mber|migration|monitor|net|qapi|qemu|qom|standard-headers|sysemu|ui)/'
    Priority:        -2
  - Regex:           '^"(elf.h|qemu-common.h|glib-compat.h|qemu-io.h|trace-=
tcg.h)'
    Priority:        -1
  - Regex:           '.*'
    Priority:        1
IncludeIsMainRegex: '$'
IndentCaseLabels: false
IndentWidth:     4
IndentWrappedFunctionNames: false
KeepEmptyLinesAtTheStartOfBlocks: false
MacroBlockBegin: '.*_BEGIN$' # only PREC_BEGIN ?
MacroBlockEnd:   '.*_END$'
MaxEmptyLinesToKeep: 2
PointerAlignment: Right
ReflowComments:  true
SortIncludes:    true
SpaceAfterCStyleCast: false
SpaceBeforeAssignmentOperators: true
SpaceBeforeParens: ControlStatements
SpaceInEmptyParentheses: false
SpacesBeforeTrailingComments: 1
SpacesInContainerLiterals: true
SpacesInParentheses: false
SpacesInSquareBrackets: false
Standard:        Auto
UseTab:          Never
...
---
 tools/virtiofsd/buffer.c              |  550 ++--
 tools/virtiofsd/fuse.h                | 1572 +++++------
 tools/virtiofsd/fuse_common.h         |  764 ++---
 tools/virtiofsd/fuse_i.h              |  127 +-
 tools/virtiofsd/fuse_log.c            |   38 +-
 tools/virtiofsd/fuse_log.h            |   32 +-
 tools/virtiofsd/fuse_loop_mt.c        |   66 +-
 tools/virtiofsd/fuse_lowlevel.c       | 3678 +++++++++++++------------
 tools/virtiofsd/fuse_lowlevel.h       | 2401 ++++++++--------
 tools/virtiofsd/fuse_misc.h           |   30 +-
 tools/virtiofsd/fuse_opt.c            |  659 ++---
 tools/virtiofsd/fuse_opt.h            |   79 +-
 tools/virtiofsd/fuse_signals.c        |  118 +-
 tools/virtiofsd/helper.c              |  517 ++--
 tools/virtiofsd/passthrough_helpers.h |   33 +-
 tools/virtiofsd/passthrough_ll.c      | 2063 +++++++-------
 16 files changed, 6530 insertions(+), 6197 deletions(-)

diff --git a/tools/virtiofsd/buffer.c b/tools/virtiofsd/buffer.c
index 5ab9b87455..38521f5889 100644
--- a/tools/virtiofsd/buffer.c
+++ b/tools/virtiofsd/buffer.c
@@ -1,321 +1,343 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2010  Miklos Szeredi <miklos@szeredi.hu>
-
-  Functions for dealing with `struct fuse_buf` and `struct
-  fuse_bufvec`.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2010  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Functions for dealing with `struct fuse_buf` and `struct
+ * fuse_bufvec`.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #define _GNU_SOURCE
=20
 #include "config.h"
 #include "fuse_i.h"
 #include "fuse_lowlevel.h"
+#include <assert.h>
+#include <errno.h>
 #include <string.h>
 #include <unistd.h>
-#include <errno.h>
-#include <assert.h>
=20
 size_t fuse_buf_size(const struct fuse_bufvec *bufv)
 {
-=09size_t i;
-=09size_t size =3D 0;
-
-=09for (i =3D 0; i < bufv->count; i++) {
-=09=09if (bufv->buf[i].size =3D=3D SIZE_MAX)
-=09=09=09size =3D SIZE_MAX;
-=09=09else
-=09=09=09size +=3D bufv->buf[i].size;
-=09}
-
-=09return size;
+    size_t i;
+    size_t size =3D 0;
+
+    for (i =3D 0; i < bufv->count; i++) {
+        if (bufv->buf[i].size =3D=3D SIZE_MAX) {
+            size =3D SIZE_MAX;
+        } else {
+            size +=3D bufv->buf[i].size;
+        }
+    }
+
+    return size;
 }
=20
 static size_t min_size(size_t s1, size_t s2)
 {
-=09return s1 < s2 ? s1 : s2;
+    return s1 < s2 ? s1 : s2;
 }
=20
 static ssize_t fuse_buf_write(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09      const struct fuse_buf *src, size_t src_off,
-=09=09=09      size_t len)
+                              const struct fuse_buf *src, size_t src_off,
+                              size_t len)
 {
-=09ssize_t res =3D 0;
-=09size_t copied =3D 0;
-
-=09while (len) {
-=09=09if (dst->flags & FUSE_BUF_FD_SEEK) {
-=09=09=09res =3D pwrite(dst->fd, (char *)src->mem + src_off, len,
-=09=09=09=09     dst->pos + dst_off);
-=09=09} else {
-=09=09=09res =3D write(dst->fd, (char *)src->mem + src_off, len);
-=09=09}
-=09=09if (res =3D=3D -1) {
-=09=09=09if (!copied)
-=09=09=09=09return -errno;
-=09=09=09break;
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09copied +=3D res;
-=09=09if (!(dst->flags & FUSE_BUF_FD_RETRY))
-=09=09=09break;
-
-=09=09src_off +=3D res;
-=09=09dst_off +=3D res;
-=09=09len -=3D res;
-=09}
-
-=09return copied;
+    ssize_t res =3D 0;
+    size_t copied =3D 0;
+
+    while (len) {
+        if (dst->flags & FUSE_BUF_FD_SEEK) {
+            res =3D pwrite(dst->fd, (char *)src->mem + src_off, len,
+                         dst->pos + dst_off);
+        } else {
+            res =3D write(dst->fd, (char *)src->mem + src_off, len);
+        }
+        if (res =3D=3D -1) {
+            if (!copied) {
+                return -errno;
+            }
+            break;
+        }
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        copied +=3D res;
+        if (!(dst->flags & FUSE_BUF_FD_RETRY)) {
+            break;
+        }
+
+        src_off +=3D res;
+        dst_off +=3D res;
+        len -=3D res;
+    }
+
+    return copied;
 }
=20
 static ssize_t fuse_buf_read(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09     const struct fuse_buf *src, size_t src_off,
-=09=09=09     size_t len)
+                             const struct fuse_buf *src, size_t src_off,
+                             size_t len)
 {
-=09ssize_t res =3D 0;
-=09size_t copied =3D 0;
-
-=09while (len) {
-=09=09if (src->flags & FUSE_BUF_FD_SEEK) {
-=09=09=09res =3D pread(src->fd, (char *)dst->mem + dst_off, len,
-=09=09=09=09     src->pos + src_off);
-=09=09} else {
-=09=09=09res =3D read(src->fd, (char *)dst->mem + dst_off, len);
-=09=09}
-=09=09if (res =3D=3D -1) {
-=09=09=09if (!copied)
-=09=09=09=09return -errno;
-=09=09=09break;
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09copied +=3D res;
-=09=09if (!(src->flags & FUSE_BUF_FD_RETRY))
-=09=09=09break;
-
-=09=09dst_off +=3D res;
-=09=09src_off +=3D res;
-=09=09len -=3D res;
-=09}
-
-=09return copied;
+    ssize_t res =3D 0;
+    size_t copied =3D 0;
+
+    while (len) {
+        if (src->flags & FUSE_BUF_FD_SEEK) {
+            res =3D pread(src->fd, (char *)dst->mem + dst_off, len,
+                        src->pos + src_off);
+        } else {
+            res =3D read(src->fd, (char *)dst->mem + dst_off, len);
+        }
+        if (res =3D=3D -1) {
+            if (!copied) {
+                return -errno;
+            }
+            break;
+        }
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        copied +=3D res;
+        if (!(src->flags & FUSE_BUF_FD_RETRY)) {
+            break;
+        }
+
+        dst_off +=3D res;
+        src_off +=3D res;
+        len -=3D res;
+    }
+
+    return copied;
 }
=20
 static ssize_t fuse_buf_fd_to_fd(const struct fuse_buf *dst, size_t dst_of=
f,
-=09=09=09=09 const struct fuse_buf *src, size_t src_off,
-=09=09=09=09 size_t len)
+                                 const struct fuse_buf *src, size_t src_of=
f,
+                                 size_t len)
 {
-=09char buf[4096];
-=09struct fuse_buf tmp =3D {
-=09=09.size =3D sizeof(buf),
-=09=09.flags =3D 0,
-=09};
-=09ssize_t res;
-=09size_t copied =3D 0;
-
-=09tmp.mem =3D buf;
-
-=09while (len) {
-=09=09size_t this_len =3D min_size(tmp.size, len);
-=09=09size_t read_len;
-
-=09=09res =3D fuse_buf_read(&tmp, 0, src, src_off, this_len);
-=09=09if (res < 0) {
-=09=09=09if (!copied)
-=09=09=09=09return res;
-=09=09=09break;
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09read_len =3D res;
-=09=09res =3D fuse_buf_write(dst, dst_off, &tmp, 0, read_len);
-=09=09if (res < 0) {
-=09=09=09if (!copied)
-=09=09=09=09return res;
-=09=09=09break;
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09copied +=3D res;
-
-=09=09if (res < this_len)
-=09=09=09break;
-
-=09=09dst_off +=3D res;
-=09=09src_off +=3D res;
-=09=09len -=3D res;
-=09}
-
-=09return copied;
+    char buf[4096];
+    struct fuse_buf tmp =3D {
+        .size =3D sizeof(buf),
+        .flags =3D 0,
+    };
+    ssize_t res;
+    size_t copied =3D 0;
+
+    tmp.mem =3D buf;
+
+    while (len) {
+        size_t this_len =3D min_size(tmp.size, len);
+        size_t read_len;
+
+        res =3D fuse_buf_read(&tmp, 0, src, src_off, this_len);
+        if (res < 0) {
+            if (!copied) {
+                return res;
+            }
+            break;
+        }
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        read_len =3D res;
+        res =3D fuse_buf_write(dst, dst_off, &tmp, 0, read_len);
+        if (res < 0) {
+            if (!copied) {
+                return res;
+            }
+            break;
+        }
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        copied +=3D res;
+
+        if (res < this_len) {
+            break;
+        }
+
+        dst_off +=3D res;
+        src_off +=3D res;
+        len -=3D res;
+    }
+
+    return copied;
 }
=20
 #ifdef HAVE_SPLICE
 static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09       const struct fuse_buf *src, size_t src_off,
-=09=09=09       size_t len, enum fuse_buf_copy_flags flags)
+                               const struct fuse_buf *src, size_t src_off,
+                               size_t len, enum fuse_buf_copy_flags flags)
 {
-=09int splice_flags =3D 0;
-=09off_t *srcpos =3D NULL;
-=09off_t *dstpos =3D NULL;
-=09off_t srcpos_val;
-=09off_t dstpos_val;
-=09ssize_t res;
-=09size_t copied =3D 0;
-
-=09if (flags & FUSE_BUF_SPLICE_MOVE)
-=09=09splice_flags |=3D SPLICE_F_MOVE;
-=09if (flags & FUSE_BUF_SPLICE_NONBLOCK)
-=09=09splice_flags |=3D SPLICE_F_NONBLOCK;
-
-=09if (src->flags & FUSE_BUF_FD_SEEK) {
-=09=09srcpos_val =3D src->pos + src_off;
-=09=09srcpos =3D &srcpos_val;
-=09}
-=09if (dst->flags & FUSE_BUF_FD_SEEK) {
-=09=09dstpos_val =3D dst->pos + dst_off;
-=09=09dstpos =3D &dstpos_val;
-=09}
-
-=09while (len) {
-=09=09res =3D splice(src->fd, srcpos, dst->fd, dstpos, len,
-=09=09=09     splice_flags);
-=09=09if (res =3D=3D -1) {
-=09=09=09if (copied)
-=09=09=09=09break;
-
-=09=09=09if (errno !=3D EINVAL || (flags & FUSE_BUF_FORCE_SPLICE))
-=09=09=09=09return -errno;
-
-=09=09=09/* Maybe splice is not supported for this combination */
-=09=09=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off,
-=09=09=09=09=09=09 len);
-=09=09}
-=09=09if (res =3D=3D 0)
-=09=09=09break;
-
-=09=09copied +=3D res;
-=09=09if (!(src->flags & FUSE_BUF_FD_RETRY) &&
-=09=09    !(dst->flags & FUSE_BUF_FD_RETRY)) {
-=09=09=09break;
-=09=09}
-
-=09=09len -=3D res;
-=09}
-
-=09return copied;
+    int splice_flags =3D 0;
+    off_t *srcpos =3D NULL;
+    off_t *dstpos =3D NULL;
+    off_t srcpos_val;
+    off_t dstpos_val;
+    ssize_t res;
+    size_t copied =3D 0;
+
+    if (flags & FUSE_BUF_SPLICE_MOVE) {
+        splice_flags |=3D SPLICE_F_MOVE;
+    }
+    if (flags & FUSE_BUF_SPLICE_NONBLOCK) {
+        splice_flags |=3D SPLICE_F_NONBLOCK;
+    }
+    if (src->flags & FUSE_BUF_FD_SEEK) {
+        srcpos_val =3D src->pos + src_off;
+        srcpos =3D &srcpos_val;
+    }
+    if (dst->flags & FUSE_BUF_FD_SEEK) {
+        dstpos_val =3D dst->pos + dst_off;
+        dstpos =3D &dstpos_val;
+    }
+
+    while (len) {
+        res =3D splice(src->fd, srcpos, dst->fd, dstpos, len, splice_flags=
);
+        if (res =3D=3D -1) {
+            if (copied) {
+                break;
+            }
+
+            if (errno !=3D EINVAL || (flags & FUSE_BUF_FORCE_SPLICE)) {
+                return -errno;
+            }
+
+            /* Maybe splice is not supported for this combination */
+            return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
+        }
+        if (res =3D=3D 0) {
+            break;
+        }
+
+        copied +=3D res;
+        if (!(src->flags & FUSE_BUF_FD_RETRY) &&
+            !(dst->flags & FUSE_BUF_FD_RETRY)) {
+            break;
+        }
+
+        len -=3D res;
+    }
+
+    return copied;
 }
 #else
 static ssize_t fuse_buf_splice(const struct fuse_buf *dst, size_t dst_off,
-=09=09=09       const struct fuse_buf *src, size_t src_off,
-=09=09=09       size_t len, enum fuse_buf_copy_flags flags)
+                               const struct fuse_buf *src, size_t src_off,
+                               size_t len, enum fuse_buf_copy_flags flags)
 {
-=09(void) flags;
+    (void)flags;
=20
-=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
+    return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
 }
 #endif
=20
=20
 static ssize_t fuse_buf_copy_one(const struct fuse_buf *dst, size_t dst_of=
f,
-=09=09=09=09 const struct fuse_buf *src, size_t src_off,
-=09=09=09=09 size_t len, enum fuse_buf_copy_flags flags)
+                                 const struct fuse_buf *src, size_t src_of=
f,
+                                 size_t len, enum fuse_buf_copy_flags flag=
s)
 {
-=09int src_is_fd =3D src->flags & FUSE_BUF_IS_FD;
-=09int dst_is_fd =3D dst->flags & FUSE_BUF_IS_FD;
-
-=09if (!src_is_fd && !dst_is_fd) {
-=09=09char *dstmem =3D (char *)dst->mem + dst_off;
-=09=09char *srcmem =3D (char *)src->mem + src_off;
-
-=09=09if (dstmem !=3D srcmem) {
-=09=09=09if (dstmem + len <=3D srcmem || srcmem + len <=3D dstmem)
-=09=09=09=09memcpy(dstmem, srcmem, len);
-=09=09=09else
-=09=09=09=09memmove(dstmem, srcmem, len);
-=09=09}
-
-=09=09return len;
-=09} else if (!src_is_fd) {
-=09=09return fuse_buf_write(dst, dst_off, src, src_off, len);
-=09} else if (!dst_is_fd) {
-=09=09return fuse_buf_read(dst, dst_off, src, src_off, len);
-=09} else if (flags & FUSE_BUF_NO_SPLICE) {
-=09=09return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
-=09} else {
-=09=09return fuse_buf_splice(dst, dst_off, src, src_off, len, flags);
-=09}
+    int src_is_fd =3D src->flags & FUSE_BUF_IS_FD;
+    int dst_is_fd =3D dst->flags & FUSE_BUF_IS_FD;
+
+    if (!src_is_fd && !dst_is_fd) {
+        char *dstmem =3D (char *)dst->mem + dst_off;
+        char *srcmem =3D (char *)src->mem + src_off;
+
+        if (dstmem !=3D srcmem) {
+            if (dstmem + len <=3D srcmem || srcmem + len <=3D dstmem) {
+                memcpy(dstmem, srcmem, len);
+            } else {
+                memmove(dstmem, srcmem, len);
+            }
+        }
+
+        return len;
+    } else if (!src_is_fd) {
+        return fuse_buf_write(dst, dst_off, src, src_off, len);
+    } else if (!dst_is_fd) {
+        return fuse_buf_read(dst, dst_off, src, src_off, len);
+    } else if (flags & FUSE_BUF_NO_SPLICE) {
+        return fuse_buf_fd_to_fd(dst, dst_off, src, src_off, len);
+    } else {
+        return fuse_buf_splice(dst, dst_off, src, src_off, len, flags);
+    }
 }
=20
 static const struct fuse_buf *fuse_bufvec_current(struct fuse_bufvec *bufv=
)
 {
-=09if (bufv->idx < bufv->count)
-=09=09return &bufv->buf[bufv->idx];
-=09else
-=09=09return NULL;
+    if (bufv->idx < bufv->count) {
+        return &bufv->buf[bufv->idx];
+    } else {
+        return NULL;
+    }
 }
=20
 static int fuse_bufvec_advance(struct fuse_bufvec *bufv, size_t len)
 {
-=09const struct fuse_buf *buf =3D fuse_bufvec_current(bufv);
-
-=09bufv->off +=3D len;
-=09assert(bufv->off <=3D buf->size);
-=09if (bufv->off =3D=3D buf->size) {
-=09=09assert(bufv->idx < bufv->count);
-=09=09bufv->idx++;
-=09=09if (bufv->idx =3D=3D bufv->count)
-=09=09=09return 0;
-=09=09bufv->off =3D 0;
-=09}
-=09return 1;
+    const struct fuse_buf *buf =3D fuse_bufvec_current(bufv);
+
+    bufv->off +=3D len;
+    assert(bufv->off <=3D buf->size);
+    if (bufv->off =3D=3D buf->size) {
+        assert(bufv->idx < bufv->count);
+        bufv->idx++;
+        if (bufv->idx =3D=3D bufv->count) {
+            return 0;
+        }
+        bufv->off =3D 0;
+    }
+    return 1;
 }
=20
 ssize_t fuse_buf_copy(struct fuse_bufvec *dstv, struct fuse_bufvec *srcv,
-=09=09      enum fuse_buf_copy_flags flags)
+                      enum fuse_buf_copy_flags flags)
 {
-=09size_t copied =3D 0;
-
-=09if (dstv =3D=3D srcv)
-=09=09return fuse_buf_size(dstv);
-
-=09for (;;) {
-=09=09const struct fuse_buf *src =3D fuse_bufvec_current(srcv);
-=09=09const struct fuse_buf *dst =3D fuse_bufvec_current(dstv);
-=09=09size_t src_len;
-=09=09size_t dst_len;
-=09=09size_t len;
-=09=09ssize_t res;
-
-=09=09if (src =3D=3D NULL || dst =3D=3D NULL)
-=09=09=09break;
-
-=09=09src_len =3D src->size - srcv->off;
-=09=09dst_len =3D dst->size - dstv->off;
-=09=09len =3D min_size(src_len, dst_len);
-
-=09=09res =3D fuse_buf_copy_one(dst, dstv->off, src, srcv->off, len, flags=
);
-=09=09if (res < 0) {
-=09=09=09if (!copied)
-=09=09=09=09return res;
-=09=09=09break;
-=09=09}
-=09=09copied +=3D res;
-
-=09=09if (!fuse_bufvec_advance(srcv, res) ||
-=09=09    !fuse_bufvec_advance(dstv, res))
-=09=09=09break;
-
-=09=09if (res < len)
-=09=09=09break;
-=09}
-
-=09return copied;
+    size_t copied =3D 0;
+
+    if (dstv =3D=3D srcv) {
+        return fuse_buf_size(dstv);
+    }
+
+    for (;;) {
+        const struct fuse_buf *src =3D fuse_bufvec_current(srcv);
+        const struct fuse_buf *dst =3D fuse_bufvec_current(dstv);
+        size_t src_len;
+        size_t dst_len;
+        size_t len;
+        ssize_t res;
+
+        if (src =3D=3D NULL || dst =3D=3D NULL) {
+            break;
+        }
+
+        src_len =3D src->size - srcv->off;
+        dst_len =3D dst->size - dstv->off;
+        len =3D min_size(src_len, dst_len);
+
+        res =3D fuse_buf_copy_one(dst, dstv->off, src, srcv->off, len, fla=
gs);
+        if (res < 0) {
+            if (!copied) {
+                return res;
+            }
+            break;
+        }
+        copied +=3D res;
+
+        if (!fuse_bufvec_advance(srcv, res) ||
+            !fuse_bufvec_advance(dstv, res)) {
+            break;
+        }
+
+        if (res < len) {
+            break;
+        }
+    }
+
+    return copied;
 }
diff --git a/tools/virtiofsd/fuse.h b/tools/virtiofsd/fuse.h
index 6c16a0041d..945ebc7a0d 100644
--- a/tools/virtiofsd/fuse.h
+++ b/tools/virtiofsd/fuse.h
@@ -1,15 +1,15 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #ifndef FUSE_H_
 #define FUSE_H_
=20
-/** @file
+/*
  *
  * This file defines the library interface of FUSE
  *
@@ -19,15 +19,15 @@
 #include "fuse_common.h"
=20
 #include <fcntl.h>
-#include <time.h>
-#include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/statvfs.h>
+#include <sys/types.h>
 #include <sys/uio.h>
+#include <time.h>
=20
-/* ----------------------------------------------------------- *
- * Basic FUSE API=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Basic FUSE API
+ */
=20
 /** Handle for a FUSE filesystem */
 struct fuse;
@@ -36,38 +36,39 @@ struct fuse;
  * Readdir flags, passed to ->readdir()
  */
 enum fuse_readdir_flags {
-=09/**
-=09 * "Plus" mode.
-=09 *
-=09 * The kernel wants to prefill the inode cache during readdir.  The
-=09 * filesystem may honour this by filling in the attributes and setting
-=09 * FUSE_FILL_DIR_FLAGS for the filler function.  The filesystem may als=
o
-=09 * just ignore this flag completely.
-=09 */
-=09FUSE_READDIR_PLUS =3D (1 << 0),
+    /**
+     * "Plus" mode.
+     *
+     * The kernel wants to prefill the inode cache during readdir.  The
+     * filesystem may honour this by filling in the attributes and setting
+     * FUSE_FILL_DIR_FLAGS for the filler function.  The filesystem may al=
so
+     * just ignore this flag completely.
+     */
+    FUSE_READDIR_PLUS =3D (1 << 0),
 };
=20
 enum fuse_fill_dir_flags {
-=09/**
-=09 * "Plus" mode: all file attributes are valid
-=09 *
-=09 * The attributes are used by the kernel to prefill the inode cache
-=09 * during a readdir.
-=09 *
-=09 * It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR_PLUS is not set
-=09 * and vice versa.
-=09 */
-=09FUSE_FILL_DIR_PLUS =3D (1 << 1),
+    /**
+     * "Plus" mode: all file attributes are valid
+     *
+     * The attributes are used by the kernel to prefill the inode cache
+     * during a readdir.
+     *
+     * It is okay to set FUSE_FILL_DIR_PLUS if FUSE_READDIR_PLUS is not se=
t
+     * and vice versa.
+     */
+    FUSE_FILL_DIR_PLUS =3D (1 << 1),
 };
=20
-/** Function to add an entry in a readdir() operation
+/**
+ * Function to add an entry in a readdir() operation
  *
  * The *off* parameter can be any non-zero value that enables the
  * filesystem to identify the current point in the directory
  * stream. It does not need to be the actual physical position. A
  * value of zero is reserved to indicate that seeking in directories
  * is not supported.
- *=20
+ *
  * @param buf the buffer passed to the readdir() operation
  * @param name the file name of the directory entry
  * @param stat file attributes, can be NULL
@@ -75,9 +76,9 @@ enum fuse_fill_dir_flags {
  * @param flags fill flags
  * @return 1 if buffer is full, zero otherwise
  */
-typedef int (*fuse_fill_dir_t) (void *buf, const char *name,
-=09=09=09=09const struct stat *stbuf, off_t off,
-=09=09=09=09enum fuse_fill_dir_flags flags);
+typedef int (*fuse_fill_dir_t)(void *buf, const char *name,
+                               const struct stat *stbuf, off_t off,
+                               enum fuse_fill_dir_flags flags);
 /**
  * Configuration of the high-level API
  *
@@ -87,186 +88,186 @@ typedef int (*fuse_fill_dir_t) (void *buf, const char=
 *name,
  * file system implementation.
  */
 struct fuse_config {
-=09/**
-=09 * If `set_gid` is non-zero, the st_gid attribute of each file
-=09 * is overwritten with the value of `gid`.
-=09 */
-=09int set_gid;
-=09unsigned int gid;
-
-=09/**
-=09 * If `set_uid` is non-zero, the st_uid attribute of each file
-=09 * is overwritten with the value of `uid`.
-=09 */
-=09int set_uid;
-=09unsigned int uid;
-
-=09/**
-=09 * If `set_mode` is non-zero, the any permissions bits set in
-=09 * `umask` are unset in the st_mode attribute of each file.
-=09 */
-=09int set_mode;
-=09unsigned int umask;
-
-=09/**
-=09 * The timeout in seconds for which name lookups will be
-=09 * cached.
-=09 */
-=09double entry_timeout;
-
-=09/**
-=09 * The timeout in seconds for which a negative lookup will be
-=09 * cached. This means, that if file did not exist (lookup
-=09 * retuned ENOENT), the lookup will only be redone after the
-=09 * timeout, and the file/directory will be assumed to not
-=09 * exist until then. A value of zero means that negative
-=09 * lookups are not cached.
-=09 */
-=09double negative_timeout;
-
-=09/**
-=09 * The timeout in seconds for which file/directory attributes
-=09 * (as returned by e.g. the `getattr` handler) are cached.
-=09 */
-=09double attr_timeout;
-
-=09/**
-=09 * Allow requests to be interrupted
-=09 */
-=09int intr;
-
-=09/**
-=09 * Specify which signal number to send to the filesystem when
-=09 * a request is interrupted.  The default is hardcoded to
-=09 * USR1.
-=09 */
-=09int intr_signal;
-
-=09/**
-=09 * Normally, FUSE assigns inodes to paths only for as long as
-=09 * the kernel is aware of them. With this option inodes are
-=09 * instead remembered for at least this many seconds.  This
-=09 * will require more memory, but may be necessary when using
-=09 * applications that make use of inode numbers.
-=09 *
-=09 * A number of -1 means that inodes will be remembered for the
-=09 * entire life-time of the file-system process.
-=09 */
-=09int remember;
-
-=09/**
-=09 * The default behavior is that if an open file is deleted,
-=09 * the file is renamed to a hidden file (.fuse_hiddenXXX), and
-=09 * only removed when the file is finally released.  This
-=09 * relieves the filesystem implementation of having to deal
-=09 * with this problem. This option disables the hiding
-=09 * behavior, and files are removed immediately in an unlink
-=09 * operation (or in a rename operation which overwrites an
-=09 * existing file).
-=09 *
-=09 * It is recommended that you not use the hard_remove
-=09 * option. When hard_remove is set, the following libc
-=09 * functions fail on unlinked files (returning errno of
-=09 * ENOENT): read(2), write(2), fsync(2), close(2), f*xattr(2),
-=09 * ftruncate(2), fstat(2), fchmod(2), fchown(2)
-=09 */
-=09int hard_remove;
-
-=09/**
-=09 * Honor the st_ino field in the functions getattr() and
-=09 * fill_dir(). This value is used to fill in the st_ino field
-=09 * in the stat(2), lstat(2), fstat(2) functions and the d_ino
-=09 * field in the readdir(2) function. The filesystem does not
-=09 * have to guarantee uniqueness, however some applications
-=09 * rely on this value being unique for the whole filesystem.
-=09 *
-=09 * Note that this does *not* affect the inode that libfuse=20
-=09 * and the kernel use internally (also called the "nodeid").
-=09 */
-=09int use_ino;
-
-=09/**
-=09 * If use_ino option is not given, still try to fill in the
-=09 * d_ino field in readdir(2). If the name was previously
-=09 * looked up, and is still in the cache, the inode number
-=09 * found there will be used.  Otherwise it will be set to -1.
-=09 * If use_ino option is given, this option is ignored.
-=09 */
-=09int readdir_ino;
-
-=09/**
-=09 * This option disables the use of page cache (file content cache)
-=09 * in the kernel for this filesystem. This has several affects:
-=09 *
-=09 * 1. Each read(2) or write(2) system call will initiate one
-=09 *    or more read or write operations, data will not be
-=09 *    cached in the kernel.
-=09 *
-=09 * 2. The return value of the read() and write() system calls
-=09 *    will correspond to the return values of the read and
-=09 *    write operations. This is useful for example if the
-=09 *    file size is not known in advance (before reading it).
-=09 *
-=09 * Internally, enabling this option causes fuse to set the
-=09 * `direct_io` field of `struct fuse_file_info` - overwriting
-=09 * any value that was put there by the file system.
-=09 */
-=09int direct_io;
-
-=09/**
-=09 * This option disables flushing the cache of the file
-=09 * contents on every open(2).  This should only be enabled on
-=09 * filesystems where the file data is never changed
-=09 * externally (not through the mounted FUSE filesystem).  Thus
-=09 * it is not suitable for network filesystems and other
-=09 * intermediate filesystems.
-=09 *
-=09 * NOTE: if this option is not specified (and neither
-=09 * direct_io) data is still cached after the open(2), so a
-=09 * read(2) system call will not always initiate a read
-=09 * operation.
-=09 *
-=09 * Internally, enabling this option causes fuse to set the
-=09 * `keep_cache` field of `struct fuse_file_info` - overwriting
-=09 * any value that was put there by the file system.
-=09 */
-=09int kernel_cache;
-
-=09/**
-=09 * This option is an alternative to `kernel_cache`. Instead of
-=09 * unconditionally keeping cached data, the cached data is
-=09 * invalidated on open(2) if if the modification time or the
-=09 * size of the file has changed since it was last opened.
-=09 */
-=09int auto_cache;
-
-=09/**
-=09 * The timeout in seconds for which file attributes are cached
-=09 * for the purpose of checking if auto_cache should flush the
-=09 * file data on open.
-=09 */
-=09int ac_attr_timeout_set;
-=09double ac_attr_timeout;
-
-=09/**
-=09 * If this option is given the file-system handlers for the
-=09 * following operations will not receive path information:
-=09 * read, write, flush, release, fsync, readdir, releasedir,
-=09 * fsyncdir, lock, ioctl and poll.
-=09 *
-=09 * For the truncate, getattr, chmod, chown and utimens
-=09 * operations the path will be provided only if the struct
-=09 * fuse_file_info argument is NULL.
-=09 */
-=09int nullpath_ok;
-
-=09/**
-=09 * The remaining options are used by libfuse internally and
-=09 * should not be touched.
-=09 */
-=09int show_help;
-=09char *modules;
-=09int debug;
+    /**
+     * If `set_gid` is non-zero, the st_gid attribute of each file
+     * is overwritten with the value of `gid`.
+     */
+    int set_gid;
+    unsigned int gid;
+
+    /**
+     * If `set_uid` is non-zero, the st_uid attribute of each file
+     * is overwritten with the value of `uid`.
+     */
+    int set_uid;
+    unsigned int uid;
+
+    /**
+     * If `set_mode` is non-zero, the any permissions bits set in
+     * `umask` are unset in the st_mode attribute of each file.
+     */
+    int set_mode;
+    unsigned int umask;
+
+    /**
+     * The timeout in seconds for which name lookups will be
+     * cached.
+     */
+    double entry_timeout;
+
+    /**
+     * The timeout in seconds for which a negative lookup will be
+     * cached. This means, that if file did not exist (lookup
+     * retuned ENOENT), the lookup will only be redone after the
+     * timeout, and the file/directory will be assumed to not
+     * exist until then. A value of zero means that negative
+     * lookups are not cached.
+     */
+    double negative_timeout;
+
+    /**
+     * The timeout in seconds for which file/directory attributes
+     * (as returned by e.g. the `getattr` handler) are cached.
+     */
+    double attr_timeout;
+
+    /**
+     * Allow requests to be interrupted
+     */
+    int intr;
+
+    /**
+     * Specify which signal number to send to the filesystem when
+     * a request is interrupted.  The default is hardcoded to
+     * USR1.
+     */
+    int intr_signal;
+
+    /**
+     * Normally, FUSE assigns inodes to paths only for as long as
+     * the kernel is aware of them. With this option inodes are
+     * instead remembered for at least this many seconds.  This
+     * will require more memory, but may be necessary when using
+     * applications that make use of inode numbers.
+     *
+     * A number of -1 means that inodes will be remembered for the
+     * entire life-time of the file-system process.
+     */
+    int remember;
+
+    /**
+     * The default behavior is that if an open file is deleted,
+     * the file is renamed to a hidden file (.fuse_hiddenXXX), and
+     * only removed when the file is finally released.  This
+     * relieves the filesystem implementation of having to deal
+     * with this problem. This option disables the hiding
+     * behavior, and files are removed immediately in an unlink
+     * operation (or in a rename operation which overwrites an
+     * existing file).
+     *
+     * It is recommended that you not use the hard_remove
+     * option. When hard_remove is set, the following libc
+     * functions fail on unlinked files (returning errno of
+     * ENOENT): read(2), write(2), fsync(2), close(2), f*xattr(2),
+     * ftruncate(2), fstat(2), fchmod(2), fchown(2)
+     */
+    int hard_remove;
+
+    /**
+     * Honor the st_ino field in the functions getattr() and
+     * fill_dir(). This value is used to fill in the st_ino field
+     * in the stat(2), lstat(2), fstat(2) functions and the d_ino
+     * field in the readdir(2) function. The filesystem does not
+     * have to guarantee uniqueness, however some applications
+     * rely on this value being unique for the whole filesystem.
+     *
+     * Note that this does *not* affect the inode that libfuse
+     * and the kernel use internally (also called the "nodeid").
+     */
+    int use_ino;
+
+    /**
+     * If use_ino option is not given, still try to fill in the
+     * d_ino field in readdir(2). If the name was previously
+     * looked up, and is still in the cache, the inode number
+     * found there will be used.  Otherwise it will be set to -1.
+     * If use_ino option is given, this option is ignored.
+     */
+    int readdir_ino;
+
+    /**
+     * This option disables the use of page cache (file content cache)
+     * in the kernel for this filesystem. This has several affects:
+     *
+     * 1. Each read(2) or write(2) system call will initiate one
+     *    or more read or write operations, data will not be
+     *    cached in the kernel.
+     *
+     * 2. The return value of the read() and write() system calls
+     *    will correspond to the return values of the read and
+     *    write operations. This is useful for example if the
+     *    file size is not known in advance (before reading it).
+     *
+     * Internally, enabling this option causes fuse to set the
+     * `direct_io` field of `struct fuse_file_info` - overwriting
+     * any value that was put there by the file system.
+     */
+    int direct_io;
+
+    /**
+     * This option disables flushing the cache of the file
+     * contents on every open(2).  This should only be enabled on
+     * filesystems where the file data is never changed
+     * externally (not through the mounted FUSE filesystem).  Thus
+     * it is not suitable for network filesystems and other
+     * intermediate filesystems.
+     *
+     * NOTE: if this option is not specified (and neither
+     * direct_io) data is still cached after the open(2), so a
+     * read(2) system call will not always initiate a read
+     * operation.
+     *
+     * Internally, enabling this option causes fuse to set the
+     * `keep_cache` field of `struct fuse_file_info` - overwriting
+     * any value that was put there by the file system.
+     */
+    int kernel_cache;
+
+    /**
+     * This option is an alternative to `kernel_cache`. Instead of
+     * unconditionally keeping cached data, the cached data is
+     * invalidated on open(2) if if the modification time or the
+     * size of the file has changed since it was last opened.
+     */
+    int auto_cache;
+
+    /**
+     * The timeout in seconds for which file attributes are cached
+     * for the purpose of checking if auto_cache should flush the
+     * file data on open.
+     */
+    int ac_attr_timeout_set;
+    double ac_attr_timeout;
+
+    /**
+     * If this option is given the file-system handlers for the
+     * following operations will not receive path information:
+     * read, write, flush, release, fsync, readdir, releasedir,
+     * fsyncdir, lock, ioctl and poll.
+     *
+     * For the truncate, getattr, chmod, chown and utimens
+     * operations the path will be provided only if the struct
+     * fuse_file_info argument is NULL.
+     */
+    int nullpath_ok;
+
+    /**
+     * The remaining options are used by libfuse internally and
+     * should not be touched.
+     */
+    int show_help;
+    char *modules;
+    int debug;
 };
=20
=20
@@ -293,515 +294,535 @@ struct fuse_config {
  * Almost all operations take a path which can be of any length.
  */
 struct fuse_operations {
-=09/** Get file attributes.
-=09 *
-=09 * Similar to stat().  The 'st_dev' and 'st_blksize' fields are
-=09 * ignored. The 'st_ino' field is ignored except if the 'use_ino'
-=09 * mount option is given. In that case it is passed to userspace,
-=09 * but libfuse and the kernel will still assign a different
-=09 * inode for internal use (called the "nodeid").
-=09 *
-=09 * `fi` will always be NULL if the file is not currently open, but
-=09 * may also be NULL if the file is open.
-=09 */
-=09int (*getattr) (const char *, struct stat *, struct fuse_file_info *fi)=
;
-
-=09/** Read the target of a symbolic link
-=09 *
-=09 * The buffer should be filled with a null terminated string.  The
-=09 * buffer size argument includes the space for the terminating
-=09 * null character.=09If the linkname is too long to fit in the
-=09 * buffer, it should be truncated.=09The return value should be 0
-=09 * for success.
-=09 */
-=09int (*readlink) (const char *, char *, size_t);
-
-=09/** Create a file node
-=09 *
-=09 * This is called for creation of all non-directory, non-symlink
-=09 * nodes.  If the filesystem defines a create() method, then for
-=09 * regular files that will be called instead.
-=09 */
-=09int (*mknod) (const char *, mode_t, dev_t);
-
-=09/** Create a directory
-=09 *
-=09 * Note that the mode argument may not have the type specification
-=09 * bits set, i.e. S_ISDIR(mode) can be false.  To obtain the
-=09 * correct directory type bits use  mode|S_IFDIR
-=09 * */
-=09int (*mkdir) (const char *, mode_t);
-
-=09/** Remove a file */
-=09int (*unlink) (const char *);
-
-=09/** Remove a directory */
-=09int (*rmdir) (const char *);
-
-=09/** Create a symbolic link */
-=09int (*symlink) (const char *, const char *);
-
-=09/** Rename a file
-=09 *
-=09 * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
-=09 * RENAME_NOREPLACE is specified, the filesystem must not
-=09 * overwrite *newname* if it exists and return an error
-=09 * instead. If `RENAME_EXCHANGE` is specified, the filesystem
-=09 * must atomically exchange the two files, i.e. both must
-=09 * exist and neither may be deleted.
-=09 */
-=09int (*rename) (const char *, const char *, unsigned int flags);
-
-=09/** Create a hard link to a file */
-=09int (*link) (const char *, const char *);
-
-=09/** Change the permission bits of a file
-=09 *
-=09 * `fi` will always be NULL if the file is not currenlty open, but
-=09 * may also be NULL if the file is open.
-=09 */
-=09int (*chmod) (const char *, mode_t, struct fuse_file_info *fi);
-
-=09/** Change the owner and group of a file
-=09 *
-=09 * `fi` will always be NULL if the file is not currenlty open, but
-=09 * may also be NULL if the file is open.
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 */
-=09int (*chown) (const char *, uid_t, gid_t, struct fuse_file_info *fi);
-
-=09/** Change the size of a file
-=09 *
-=09 * `fi` will always be NULL if the file is not currenlty open, but
-=09 * may also be NULL if the file is open.
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 */
-=09int (*truncate) (const char *, off_t, struct fuse_file_info *fi);
-
-=09/** Open a file
-=09 *
-=09 * Open flags are available in fi->flags. The following rules
-=09 * apply.
-=09 *
-=09 *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
-=09 *    filtered out / handled by the kernel.
-=09 *
-=09 *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR, O_EXEC, O_SEARCH)
-=09 *    should be used by the filesystem to check if the operation is
-=09 *    permitted.  If the ``-o default_permissions`` mount option is
-=09 *    given, this check is already done by the kernel before calling
-=09 *    open() and may thus be omitted by the filesystem.
-=09 *
-=09 *  - When writeback caching is enabled, the kernel may send
-=09 *    read requests even for files opened with O_WRONLY. The
-=09 *    filesystem should be prepared to handle this.
-=09 *
-=09 *  - When writeback caching is disabled, the filesystem is
-=09 *    expected to properly handle the O_APPEND flag and ensure
-=09 *    that each write is appending to the end of the file.
-=09 *=20
-         *  - When writeback caching is enabled, the kernel will
-=09 *    handle O_APPEND. However, unless all changes to the file
-=09 *    come through the kernel this will not work reliably. The
-=09 *    filesystem should thus either ignore the O_APPEND flag
-=09 *    (and let the kernel handle it), or return an error
-=09 *    (indicating that reliably O_APPEND is not available).
-=09 *
-=09 * Filesystem may store an arbitrary file handle (pointer,
-=09 * index, etc) in fi->fh, and use this in other all other file
-=09 * operations (read, write, flush, release, fsync).
-=09 *
-=09 * Filesystem may also implement stateless file I/O and not store
-=09 * anything in fi->fh.
-=09 *
-=09 * There are also some flags (direct_io, keep_cache) which the
-=09 * filesystem may set in fi, to change the way the file is opened.
-=09 * See fuse_file_info structure in <fuse_common.h> for more details.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS
-=09 * and FUSE_CAP_NO_OPEN_SUPPORT is set in
-=09 * `fuse_conn_info.capable`, this is treated as success and
-=09 * future calls to open will also succeed without being send
-=09 * to the filesystem process.
-=09 *
-=09 */
-=09int (*open) (const char *, struct fuse_file_info *);
-
-=09/** Read data from an open file
-=09 *
-=09 * Read should return exactly the number of bytes requested except
-=09 * on EOF or error, otherwise the rest of the data will be
-=09 * substituted with zeroes.=09 An exception to this is when the
-=09 * 'direct_io' mount option is specified, in which case the return
-=09 * value of the read system call will reflect the return value of
-=09 * this operation.
-=09 */
-=09int (*read) (const char *, char *, size_t, off_t,
-=09=09     struct fuse_file_info *);
-
-=09/** Write data to an open file
-=09 *
-=09 * Write should return exactly the number of bytes requested
-=09 * except on error.=09 An exception to this is when the 'direct_io'
-=09 * mount option is specified (see read operation).
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 */
-=09int (*write) (const char *, const char *, size_t, off_t,
-=09=09      struct fuse_file_info *);
-
-=09/** Get file system statistics
-=09 *
-=09 * The 'f_favail', 'f_fsid' and 'f_flag' fields are ignored
-=09 */
-=09int (*statfs) (const char *, struct statvfs *);
-
-=09/** Possibly flush cached data
-=09 *
-=09 * BIG NOTE: This is not equivalent to fsync().  It's not a
-=09 * request to sync dirty data.
-=09 *
-=09 * Flush is called on each close() of a file descriptor, as opposed to
-=09 * release which is called on the close of the last file descriptor for
-=09 * a file.  Under Linux, errors returned by flush() will be passed to=
=20
-=09 * userspace as errors from close(), so flush() is a good place to writ=
e
-=09 * back any cached dirty data. However, many applications ignore errors=
=20
-=09 * on close(), and on non-Linux systems, close() may succeed even if fl=
ush()
-=09 * returns an error. For these reasons, filesystems should not assume
-=09 * that errors returned by flush will ever be noticed or even
-=09 * delivered.
-=09 *
-=09 * NOTE: The flush() method may be called more than once for each
-=09 * open().  This happens if more than one file descriptor refers to an
-=09 * open file handle, e.g. due to dup(), dup2() or fork() calls.  It is
-=09 * not possible to determine if a flush is final, so each flush should
-=09 * be treated equally.  Multiple write-flush sequences are relatively
-=09 * rare, so this shouldn't be a problem.
-=09 *
-=09 * Filesystems shouldn't assume that flush will be called at any
-=09 * particular point.  It may be called more times than expected, or not
-=09 * at all.
-=09 *
-=09 * [close]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/c=
lose.html
-=09 */
-=09int (*flush) (const char *, struct fuse_file_info *);
-
-=09/** Release an open file
-=09 *
-=09 * Release is called when there are no more references to an open
-=09 * file: all file descriptors are closed and all memory mappings
-=09 * are unmapped.
-=09 *
-=09 * For every open() call there will be exactly one release() call
-=09 * with the same flags and file handle.  It is possible to
-=09 * have a file opened more than once, in which case only the last
-=09 * release will mean, that no more reads/writes will happen on the
-=09 * file.  The return value of release is ignored.
-=09 */
-=09int (*release) (const char *, struct fuse_file_info *);
-
-=09/** Synchronize file contents
-=09 *
-=09 * If the datasync parameter is non-zero, then only the user data
-=09 * should be flushed, not the meta data.
-=09 */
-=09int (*fsync) (const char *, int, struct fuse_file_info *);
-
-=09/** Set extended attributes */
-=09int (*setxattr) (const char *, const char *, const char *, size_t, int)=
;
-
-=09/** Get extended attributes */
-=09int (*getxattr) (const char *, const char *, char *, size_t);
-
-=09/** List extended attributes */
-=09int (*listxattr) (const char *, char *, size_t);
-
-=09/** Remove extended attributes */
-=09int (*removexattr) (const char *, const char *);
-
-=09/** Open directory
-=09 *
-=09 * Unless the 'default_permissions' mount option is given,
-=09 * this method should check if opendir is permitted for this
-=09 * directory. Optionally opendir may also return an arbitrary
-=09 * filehandle in the fuse_file_info structure, which will be
-=09 * passed to readdir, releasedir and fsyncdir.
-=09 */
-=09int (*opendir) (const char *, struct fuse_file_info *);
-
-=09/** Read directory
-=09 *
-=09 * The filesystem may choose between two modes of operation:
-=09 *
-=09 * 1) The readdir implementation ignores the offset parameter, and
-=09 * passes zero to the filler function's offset.  The filler
-=09 * function will not return '1' (unless an error happens), so the
-=09 * whole directory is read in a single readdir operation.
-=09 *
-=09 * 2) The readdir implementation keeps track of the offsets of the
-=09 * directory entries.  It uses the offset parameter and always
-=09 * passes non-zero offset to the filler function.  When the buffer
-=09 * is full (or an error happens) the filler function will return
-=09 * '1'.
-=09 */
-=09int (*readdir) (const char *, void *, fuse_fill_dir_t, off_t,
-=09=09=09struct fuse_file_info *, enum fuse_readdir_flags);
-
-=09/** Release directory
-=09 */
-=09int (*releasedir) (const char *, struct fuse_file_info *);
-
-=09/** Synchronize directory contents
-=09 *
-=09 * If the datasync parameter is non-zero, then only the user data
-=09 * should be flushed, not the meta data
-=09 */
-=09int (*fsyncdir) (const char *, int, struct fuse_file_info *);
-
-=09/**
-=09 * Initialize filesystem
-=09 *
-=09 * The return value will passed in the `private_data` field of
-=09 * `struct fuse_context` to all file operations, and as a
-=09 * parameter to the destroy() method. It overrides the initial
-=09 * value provided to fuse_main() / fuse_new().
-=09 */
-=09void *(*init) (struct fuse_conn_info *conn,
-=09=09       struct fuse_config *cfg);
-
-=09/**
-=09 * Clean up filesystem
-=09 *
-=09 * Called on filesystem exit.
-=09 */
-=09void (*destroy) (void *private_data);
-
-=09/**
-=09 * Check file access permissions
-=09 *
-=09 * This will be called for the access() system call.  If the
-=09 * 'default_permissions' mount option is given, this method is not
-=09 * called.
-=09 *
-=09 * This method is not called under Linux kernel versions 2.4.x
-=09 */
-=09int (*access) (const char *, int);
-
-=09/**
-=09 * Create and open a file
-=09 *
-=09 * If the file does not exist, first create it with the specified
-=09 * mode, and then open it.
-=09 *
-=09 * If this method is not implemented or under Linux kernel
-=09 * versions earlier than 2.6.15, the mknod() and open() methods
-=09 * will be called instead.
-=09 */
-=09int (*create) (const char *, mode_t, struct fuse_file_info *);
-
-=09/**
-=09 * Perform POSIX file locking operation
-=09 *
-=09 * The cmd argument will be either F_GETLK, F_SETLK or F_SETLKW.
-=09 *
-=09 * For the meaning of fields in 'struct flock' see the man page
-=09 * for fcntl(2).  The l_whence field will always be set to
-=09 * SEEK_SET.
-=09 *
-=09 * For checking lock ownership, the 'fuse_file_info->owner'
-=09 * argument must be used.
-=09 *
-=09 * For F_GETLK operation, the library will first check currently
-=09 * held locks, and if a conflicting lock is found it will return
-=09 * information without calling this method.=09 This ensures, that
-=09 * for local locks the l_pid field is correctly filled in.=09The
-=09 * results may not be accurate in case of race conditions and in
-=09 * the presence of hard links, but it's unlikely that an
-=09 * application would rely on accurate GETLK results in these
-=09 * cases.  If a conflicting lock is not found, this method will be
-=09 * called, and the filesystem may fill out l_pid by a meaningful
-=09 * value, or it may leave this field zero.
-=09 *
-=09 * For F_SETLK and F_SETLKW the l_pid field will be set to the pid
-=09 * of the process performing the locking operation.
-=09 *
-=09 * Note: if this method is not implemented, the kernel will still
-=09 * allow file locking to work locally.  Hence it is only
-=09 * interesting for network filesystems and similar.
-=09 */
-=09int (*lock) (const char *, struct fuse_file_info *, int cmd,
-=09=09     struct flock *);
-
-=09/**
-=09 * Change the access and modification times of a file with
-=09 * nanosecond resolution
-=09 *
-=09 * This supersedes the old utime() interface.  New applications
-=09 * should use this.
-=09 *
-=09 * `fi` will always be NULL if the file is not currenlty open, but
-=09 * may also be NULL if the file is open.
-=09 *
-=09 * See the utimensat(2) man page for details.
-=09 */
-=09 int (*utimens) (const char *, const struct timespec tv[2],
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Map block index within file to block index within device
-=09 *
-=09 * Note: This makes sense only for block device backed filesystems
-=09 * mounted with the 'blkdev' option
-=09 */
-=09int (*bmap) (const char *, size_t blocksize, uint64_t *idx);
-
-=09/**
-=09 * Ioctl
-=09 *
-=09 * flags will have FUSE_IOCTL_COMPAT set for 32bit ioctls in
-=09 * 64bit environment.  The size and direction of data is
-=09 * determined by _IOC_*() decoding of cmd.  For _IOC_NONE,
-=09 * data will be NULL, for _IOC_WRITE data is out area, for
-=09 * _IOC_READ in area and if both are set in/out area.  In all
-=09 * non-NULL cases, the area is of _IOC_SIZE(cmd) bytes.
-=09 *
-=09 * If flags has FUSE_IOCTL_DIR then the fuse_file_info refers to a
-=09 * directory file handle.
-=09 *
-=09 * Note : the unsigned long request submitted by the application
-=09 * is truncated to 32 bits.
-=09 */
-=09int (*ioctl) (const char *, unsigned int cmd, void *arg,
-=09=09      struct fuse_file_info *, unsigned int flags, void *data);
-
-=09/**
-=09 * Poll for IO readiness events
-=09 *
-=09 * Note: If ph is non-NULL, the client should notify
-=09 * when IO readiness events occur by calling
-=09 * fuse_notify_poll() with the specified ph.
-=09 *
-=09 * Regardless of the number of times poll with a non-NULL ph
-=09 * is received, single notification is enough to clear all.
-=09 * Notifying more times incurs overhead but doesn't harm
-=09 * correctness.
-=09 *
-=09 * The callee is responsible for destroying ph with
-=09 * fuse_pollhandle_destroy() when no longer in use.
-=09 */
-=09int (*poll) (const char *, struct fuse_file_info *,
-=09=09     struct fuse_pollhandle *ph, unsigned *reventsp);
-
-=09/** Write contents of buffer to an open file
-=09 *
-=09 * Similar to the write() method, but data is supplied in a
-=09 * generic buffer.  Use fuse_buf_copy() to transfer data to
-=09 * the destination.
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 */
-=09int (*write_buf) (const char *, struct fuse_bufvec *buf, off_t off,
-=09=09=09  struct fuse_file_info *);
-
-=09/** Store data from an open file in a buffer
-=09 *
-=09 * Similar to the read() method, but data is stored and
-=09 * returned in a generic buffer.
-=09 *
-=09 * No actual copying of data has to take place, the source
-=09 * file descriptor may simply be stored in the buffer for
-=09 * later data transfer.
-=09 *
-=09 * The buffer must be allocated dynamically and stored at the
-=09 * location pointed to by bufp.  If the buffer contains memory
-=09 * regions, they too must be allocated using malloc().  The
-=09 * allocated memory will be freed by the caller.
-=09 */
-=09int (*read_buf) (const char *, struct fuse_bufvec **bufp,
-=09=09=09 size_t size, off_t off, struct fuse_file_info *);
-=09/**
-=09 * Perform BSD file locking operation
-=09 *
-=09 * The op argument will be either LOCK_SH, LOCK_EX or LOCK_UN
-=09 *
-=09 * Nonblocking requests will be indicated by ORing LOCK_NB to
-=09 * the above operations
-=09 *
-=09 * For more information see the flock(2) manual page.
-=09 *
-=09 * Additionally fi->owner will be set to a value unique to
-=09 * this open file.  This same value will be supplied to
-=09 * ->release() when the file is released.
-=09 *
-=09 * Note: if this method is not implemented, the kernel will still
-=09 * allow file locking to work locally.  Hence it is only
-=09 * interesting for network filesystems and similar.
-=09 */
-=09int (*flock) (const char *, struct fuse_file_info *, int op);
-
-=09/**
-=09 * Allocates space for an open file
-=09 *
-=09 * This function ensures that required space is allocated for specified
-=09 * file.  If this function returns success then any subsequent write
-=09 * request to specified range is guaranteed not to fail because of lack
-=09 * of space on the file system media.
-=09 */
-=09int (*fallocate) (const char *, int, off_t, off_t,
-=09=09=09  struct fuse_file_info *);
-
-=09/**
-=09 * Copy a range of data from one file to another
-=09 *
-=09 * Performs an optimized copy between two file descriptors without the
-=09 * additional cost of transferring data through the FUSE kernel module
-=09 * to user space (glibc) and then back into the FUSE filesystem again.
-=09 *
-=09 * In case this method is not implemented, glibc falls back to reading
-=09 * data from the source and writing to the destination. Effectively
-=09 * doing an inefficient copy of the data.
-=09 */
-=09ssize_t (*copy_file_range) (const char *path_in,
-=09=09=09=09    struct fuse_file_info *fi_in,
-=09=09=09=09    off_t offset_in, const char *path_out,
-=09=09=09=09    struct fuse_file_info *fi_out,
-=09=09=09=09    off_t offset_out, size_t size, int flags);
-
-=09/**
-=09 * Find next data or hole after the specified offset
-=09 */
-=09off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_i=
nfo *);
+    /**
+     * Get file attributes.
+     *
+     * Similar to stat().  The 'st_dev' and 'st_blksize' fields are
+     * ignored. The 'st_ino' field is ignored except if the 'use_ino'
+     * mount option is given. In that case it is passed to userspace,
+     * but libfuse and the kernel will still assign a different
+     * inode for internal use (called the "nodeid").
+     *
+     * `fi` will always be NULL if the file is not currently open, but
+     * may also be NULL if the file is open.
+     */
+    int (*getattr)(const char *, struct stat *, struct fuse_file_info *fi)=
;
+
+    /**
+     * Read the target of a symbolic link
+     *
+     * The buffer should be filled with a null terminated string.  The
+     * buffer size argument includes the space for the terminating
+     * null character. If the linkname is too long to fit in the
+     * buffer, it should be truncated. The return value should be 0
+     * for success.
+     */
+    int (*readlink)(const char *, char *, size_t);
+
+    /**
+     * Create a file node
+     *
+     * This is called for creation of all non-directory, non-symlink
+     * nodes.  If the filesystem defines a create() method, then for
+     * regular files that will be called instead.
+     */
+    int (*mknod)(const char *, mode_t, dev_t);
+
+    /**
+     * Create a directory
+     *
+     * Note that the mode argument may not have the type specification
+     * bits set, i.e. S_ISDIR(mode) can be false.  To obtain the
+     * correct directory type bits use  mode|S_IFDIR
+     */
+    int (*mkdir)(const char *, mode_t);
+
+    /** Remove a file */
+    int (*unlink)(const char *);
+
+    /** Remove a directory */
+    int (*rmdir)(const char *);
+
+    /** Create a symbolic link */
+    int (*symlink)(const char *, const char *);
+
+    /**
+     * Rename a file
+     *
+     * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
+     * RENAME_NOREPLACE is specified, the filesystem must not
+     * overwrite *newname* if it exists and return an error
+     * instead. If `RENAME_EXCHANGE` is specified, the filesystem
+     * must atomically exchange the two files, i.e. both must
+     * exist and neither may be deleted.
+     */
+    int (*rename)(const char *, const char *, unsigned int flags);
+
+    /** Create a hard link to a file */
+    int (*link)(const char *, const char *);
+
+    /**
+     * Change the permission bits of a file
+     *
+     * `fi` will always be NULL if the file is not currenlty open, but
+     * may also be NULL if the file is open.
+     */
+    int (*chmod)(const char *, mode_t, struct fuse_file_info *fi);
+
+    /**
+     * Change the owner and group of a file
+     *
+     * `fi` will always be NULL if the file is not currenlty open, but
+     * may also be NULL if the file is open.
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     */
+    int (*chown)(const char *, uid_t, gid_t, struct fuse_file_info *fi);
+
+    /**
+     * Change the size of a file
+     *
+     * `fi` will always be NULL if the file is not currenlty open, but
+     * may also be NULL if the file is open.
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     */
+    int (*truncate)(const char *, off_t, struct fuse_file_info *fi);
+
+    /**
+     * Open a file
+     *
+     * Open flags are available in fi->flags. The following rules
+     * apply.
+     *
+     *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
+     *    filtered out / handled by the kernel.
+     *
+     *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR, O_EXEC, O_SEARCH)
+     *    should be used by the filesystem to check if the operation is
+     *    permitted.  If the ``-o default_permissions`` mount option is
+     *    given, this check is already done by the kernel before calling
+     *    open() and may thus be omitted by the filesystem.
+     *
+     *  - When writeback caching is enabled, the kernel may send
+     *    read requests even for files opened with O_WRONLY. The
+     *    filesystem should be prepared to handle this.
+     *
+     *  - When writeback caching is disabled, the filesystem is
+     *    expected to properly handle the O_APPEND flag and ensure
+     *    that each write is appending to the end of the file.
+     *
+     *  - When writeback caching is enabled, the kernel will
+     *    handle O_APPEND. However, unless all changes to the file
+     *    come through the kernel this will not work reliably. The
+     *    filesystem should thus either ignore the O_APPEND flag
+     *    (and let the kernel handle it), or return an error
+     *    (indicating that reliably O_APPEND is not available).
+     *
+     * Filesystem may store an arbitrary file handle (pointer,
+     * index, etc) in fi->fh, and use this in other all other file
+     * operations (read, write, flush, release, fsync).
+     *
+     * Filesystem may also implement stateless file I/O and not store
+     * anything in fi->fh.
+     *
+     * There are also some flags (direct_io, keep_cache) which the
+     * filesystem may set in fi, to change the way the file is opened.
+     * See fuse_file_info structure in <fuse_common.h> for more details.
+     *
+     * If this request is answered with an error code of ENOSYS
+     * and FUSE_CAP_NO_OPEN_SUPPORT is set in
+     * `fuse_conn_info.capable`, this is treated as success and
+     * future calls to open will also succeed without being send
+     * to the filesystem process.
+     *
+     */
+    int (*open)(const char *, struct fuse_file_info *);
+
+    /**
+     * Read data from an open file
+     *
+     * Read should return exactly the number of bytes requested except
+     * on EOF or error, otherwise the rest of the data will be
+     * substituted with zeroes.  An exception to this is when the
+     * 'direct_io' mount option is specified, in which case the return
+     * value of the read system call will reflect the return value of
+     * this operation.
+     */
+    int (*read)(const char *, char *, size_t, off_t, struct fuse_file_info=
 *);
+
+    /**
+     * Write data to an open file
+     *
+     * Write should return exactly the number of bytes requested
+     * except on error.  An exception to this is when the 'direct_io'
+     * mount option is specified (see read operation).
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     */
+    int (*write)(const char *, const char *, size_t, off_t,
+                 struct fuse_file_info *);
+
+    /**
+     * Get file system statistics
+     *
+     * The 'f_favail', 'f_fsid' and 'f_flag' fields are ignored
+     */
+    int (*statfs)(const char *, struct statvfs *);
+
+    /**
+     * Possibly flush cached data
+     *
+     * BIG NOTE: This is not equivalent to fsync().  It's not a
+     * request to sync dirty data.
+     *
+     * Flush is called on each close() of a file descriptor, as opposed to
+     * release which is called on the close of the last file descriptor fo=
r
+     * a file.  Under Linux, errors returned by flush() will be passed to
+     * userspace as errors from close(), so flush() is a good place to wri=
te
+     * back any cached dirty data. However, many applications ignore error=
s
+     * on close(), and on non-Linux systems, close() may succeed even if f=
lush()
+     * returns an error. For these reasons, filesystems should not assume
+     * that errors returned by flush will ever be noticed or even
+     * delivered.
+     *
+     * NOTE: The flush() method may be called more than once for each
+     * open().  This happens if more than one file descriptor refers to an
+     * open file handle, e.g. due to dup(), dup2() or fork() calls.  It is
+     * not possible to determine if a flush is final, so each flush should
+     * be treated equally.  Multiple write-flush sequences are relatively
+     * rare, so this shouldn't be a problem.
+     *
+     * Filesystems shouldn't assume that flush will be called at any
+     * particular point.  It may be called more times than expected, or no=
t
+     * at all.
+     *
+     * [close]:
+     * http://pubs.opengroup.org/onlinepubs/9699919799/functions/close.htm=
l
+     */
+    int (*flush)(const char *, struct fuse_file_info *);
+
+    /**
+     * Release an open file
+     *
+     * Release is called when there are no more references to an open
+     * file: all file descriptors are closed and all memory mappings
+     * are unmapped.
+     *
+     * For every open() call there will be exactly one release() call
+     * with the same flags and file handle.  It is possible to
+     * have a file opened more than once, in which case only the last
+     * release will mean, that no more reads/writes will happen on the
+     * file.  The return value of release is ignored.
+     */
+    int (*release)(const char *, struct fuse_file_info *);
+
+    /*
+     * Synchronize file contents
+     *
+     * If the datasync parameter is non-zero, then only the user data
+     * should be flushed, not the meta data.
+     */
+    int (*fsync)(const char *, int, struct fuse_file_info *);
+
+    /** Set extended attributes */
+    int (*setxattr)(const char *, const char *, const char *, size_t, int)=
;
+
+    /** Get extended attributes */
+    int (*getxattr)(const char *, const char *, char *, size_t);
+
+    /** List extended attributes */
+    int (*listxattr)(const char *, char *, size_t);
+
+    /** Remove extended attributes */
+    int (*removexattr)(const char *, const char *);
+
+    /*
+     * Open directory
+     *
+     * Unless the 'default_permissions' mount option is given,
+     * this method should check if opendir is permitted for this
+     * directory. Optionally opendir may also return an arbitrary
+     * filehandle in the fuse_file_info structure, which will be
+     * passed to readdir, releasedir and fsyncdir.
+     */
+    int (*opendir)(const char *, struct fuse_file_info *);
+
+    /*
+     * Read directory
+     *
+     * The filesystem may choose between two modes of operation:
+     *
+     * 1) The readdir implementation ignores the offset parameter, and
+     * passes zero to the filler function's offset.  The filler
+     * function will not return '1' (unless an error happens), so the
+     * whole directory is read in a single readdir operation.
+     *
+     * 2) The readdir implementation keeps track of the offsets of the
+     * directory entries.  It uses the offset parameter and always
+     * passes non-zero offset to the filler function.  When the buffer
+     * is full (or an error happens) the filler function will return
+     * '1'.
+     */
+    int (*readdir)(const char *, void *, fuse_fill_dir_t, off_t,
+                   struct fuse_file_info *, enum fuse_readdir_flags);
+
+    /**
+     *  Release directory
+     */
+    int (*releasedir)(const char *, struct fuse_file_info *);
+
+    /**
+     * Synchronize directory contents
+     *
+     * If the datasync parameter is non-zero, then only the user data
+     * should be flushed, not the meta data
+     */
+    int (*fsyncdir)(const char *, int, struct fuse_file_info *);
+
+    /**
+     * Initialize filesystem
+     *
+     * The return value will passed in the `private_data` field of
+     * `struct fuse_context` to all file operations, and as a
+     * parameter to the destroy() method. It overrides the initial
+     * value provided to fuse_main() / fuse_new().
+     */
+    void *(*init)(struct fuse_conn_info *conn, struct fuse_config *cfg);
+
+    /**
+     * Clean up filesystem
+     *
+     * Called on filesystem exit.
+     */
+    void (*destroy)(void *private_data);
+
+    /**
+     * Check file access permissions
+     *
+     * This will be called for the access() system call.  If the
+     * 'default_permissions' mount option is given, this method is not
+     * called.
+     *
+     * This method is not called under Linux kernel versions 2.4.x
+     */
+    int (*access)(const char *, int);
+
+    /**
+     * Create and open a file
+     *
+     * If the file does not exist, first create it with the specified
+     * mode, and then open it.
+     *
+     * If this method is not implemented or under Linux kernel
+     * versions earlier than 2.6.15, the mknod() and open() methods
+     * will be called instead.
+     */
+    int (*create)(const char *, mode_t, struct fuse_file_info *);
+
+    /**
+     * Perform POSIX file locking operation
+     *
+     * The cmd argument will be either F_GETLK, F_SETLK or F_SETLKW.
+     *
+     * For the meaning of fields in 'struct flock' see the man page
+     * for fcntl(2).  The l_whence field will always be set to
+     * SEEK_SET.
+     *
+     * For checking lock ownership, the 'fuse_file_info->owner'
+     * argument must be used.
+     *
+     * For F_GETLK operation, the library will first check currently
+     * held locks, and if a conflicting lock is found it will return
+     * information without calling this method.  This ensures, that
+     * for local locks the l_pid field is correctly filled in. The
+     * results may not be accurate in case of race conditions and in
+     * the presence of hard links, but it's unlikely that an
+     * application would rely on accurate GETLK results in these
+     * cases.  If a conflicting lock is not found, this method will be
+     * called, and the filesystem may fill out l_pid by a meaningful
+     * value, or it may leave this field zero.
+     *
+     * For F_SETLK and F_SETLKW the l_pid field will be set to the pid
+     * of the process performing the locking operation.
+     *
+     * Note: if this method is not implemented, the kernel will still
+     * allow file locking to work locally.  Hence it is only
+     * interesting for network filesystems and similar.
+     */
+    int (*lock)(const char *, struct fuse_file_info *, int cmd, struct flo=
ck *);
+
+    /**
+     * Change the access and modification times of a file with
+     * nanosecond resolution
+     *
+     * This supersedes the old utime() interface.  New applications
+     * should use this.
+     *
+     * `fi` will always be NULL if the file is not currenlty open, but
+     * may also be NULL if the file is open.
+     *
+     * See the utimensat(2) man page for details.
+     */
+    int (*utimens)(const char *, const struct timespec tv[2],
+                   struct fuse_file_info *fi);
+
+    /**
+     * Map block index within file to block index within device
+     *
+     * Note: This makes sense only for block device backed filesystems
+     * mounted with the 'blkdev' option
+     */
+    int (*bmap)(const char *, size_t blocksize, uint64_t *idx);
+
+    /**
+     * Ioctl
+     *
+     * flags will have FUSE_IOCTL_COMPAT set for 32bit ioctls in
+     * 64bit environment.  The size and direction of data is
+     * determined by _IOC_*() decoding of cmd.  For _IOC_NONE,
+     * data will be NULL, for _IOC_WRITE data is out area, for
+     * _IOC_READ in area and if both are set in/out area.  In all
+     * non-NULL cases, the area is of _IOC_SIZE(cmd) bytes.
+     *
+     * If flags has FUSE_IOCTL_DIR then the fuse_file_info refers to a
+     * directory file handle.
+     *
+     * Note : the unsigned long request submitted by the application
+     * is truncated to 32 bits.
+     */
+    int (*ioctl)(const char *, unsigned int cmd, void *arg,
+                 struct fuse_file_info *, unsigned int flags, void *data);
+
+    /**
+     * Poll for IO readiness events
+     *
+     * Note: If ph is non-NULL, the client should notify
+     * when IO readiness events occur by calling
+     * fuse_notify_poll() with the specified ph.
+     *
+     * Regardless of the number of times poll with a non-NULL ph
+     * is received, single notification is enough to clear all.
+     * Notifying more times incurs overhead but doesn't harm
+     * correctness.
+     *
+     * The callee is responsible for destroying ph with
+     * fuse_pollhandle_destroy() when no longer in use.
+     */
+    int (*poll)(const char *, struct fuse_file_info *,
+                struct fuse_pollhandle *ph, unsigned *reventsp);
+
+    /*
+     * Write contents of buffer to an open file
+     *
+     * Similar to the write() method, but data is supplied in a
+     * generic buffer.  Use fuse_buf_copy() to transfer data to
+     * the destination.
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     */
+    int (*write_buf)(const char *, struct fuse_bufvec *buf, off_t off,
+                     struct fuse_file_info *);
+
+    /*
+     *  Store data from an open file in a buffer
+     *
+     * Similar to the read() method, but data is stored and
+     * returned in a generic buffer.
+     *
+     * No actual copying of data has to take place, the source
+     * file descriptor may simply be stored in the buffer for
+     * later data transfer.
+     *
+     * The buffer must be allocated dynamically and stored at the
+     * location pointed to by bufp.  If the buffer contains memory
+     * regions, they too must be allocated using malloc().  The
+     * allocated memory will be freed by the caller.
+     */
+    int (*read_buf)(const char *, struct fuse_bufvec **bufp, size_t size,
+                    off_t off, struct fuse_file_info *);
+    /**
+     * Perform BSD file locking operation
+     *
+     * The op argument will be either LOCK_SH, LOCK_EX or LOCK_UN
+     *
+     * Nonblocking requests will be indicated by ORing LOCK_NB to
+     * the above operations
+     *
+     * For more information see the flock(2) manual page.
+     *
+     * Additionally fi->owner will be set to a value unique to
+     * this open file.  This same value will be supplied to
+     * ->release() when the file is released.
+     *
+     * Note: if this method is not implemented, the kernel will still
+     * allow file locking to work locally.  Hence it is only
+     * interesting for network filesystems and similar.
+     */
+    int (*flock)(const char *, struct fuse_file_info *, int op);
+
+    /**
+     * Allocates space for an open file
+     *
+     * This function ensures that required space is allocated for specifie=
d
+     * file.  If this function returns success then any subsequent write
+     * request to specified range is guaranteed not to fail because of lac=
k
+     * of space on the file system media.
+     */
+    int (*fallocate)(const char *, int, off_t, off_t, struct fuse_file_inf=
o *);
+
+    /**
+     * Copy a range of data from one file to another
+     *
+     * Performs an optimized copy between two file descriptors without the
+     * additional cost of transferring data through the FUSE kernel module
+     * to user space (glibc) and then back into the FUSE filesystem again.
+     *
+     * In case this method is not implemented, glibc falls back to reading
+     * data from the source and writing to the destination. Effectively
+     * doing an inefficient copy of the data.
+     */
+    ssize_t (*copy_file_range)(const char *path_in,
+                               struct fuse_file_info *fi_in, off_t offset_=
in,
+                               const char *path_out,
+                               struct fuse_file_info *fi_out, off_t offset=
_out,
+                               size_t size, int flags);
+
+    /**
+     * Find next data or hole after the specified offset
+     */
+    off_t (*lseek)(const char *, off_t off, int whence,
+                   struct fuse_file_info *);
 };
=20
-/** Extra context that may be needed by some filesystems
+/*
+ * Extra context that may be needed by some filesystems
  *
  * The uid, gid and pid fields are not filled in case of a writepage
  * operation.
  */
 struct fuse_context {
-=09/** Pointer to the fuse object */
-=09struct fuse *fuse;
+    /** Pointer to the fuse object */
+    struct fuse *fuse;
=20
-=09/** User ID of the calling process */
-=09uid_t uid;
+    /** User ID of the calling process */
+    uid_t uid;
=20
-=09/** Group ID of the calling process */
-=09gid_t gid;
+    /** Group ID of the calling process */
+    gid_t gid;
=20
-=09/** Process ID of the calling thread */
-=09pid_t pid;
+    /** Process ID of the calling thread */
+    pid_t pid;
=20
-=09/** Private filesystem data */
-=09void *private_data;
+    /** Private filesystem data */
+    void *private_data;
=20
-=09/** Umask of the calling process */
-=09mode_t umask;
+    /** Umask of the calling process */
+    mode_t umask;
 };
=20
 /**
@@ -859,15 +880,15 @@ struct fuse_context {
  * Example usage, see hello.c
  */
 /*
-  int fuse_main(int argc, char *argv[], const struct fuse_operations *op,
-  void *private_data);
-*/
-#define fuse_main(argc, argv, op, private_data)=09=09=09=09\
-=09fuse_main_real(argc, argv, op, sizeof(*(op)), private_data)
+ * int fuse_main(int argc, char *argv[], const struct fuse_operations *op,
+ * void *private_data);
+ */
+#define fuse_main(argc, argv, op, private_data) \
+    fuse_main_real(argc, argv, op, sizeof(*(op)), private_data)
=20
-/* ----------------------------------------------------------- *
- * More detailed API=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * More detailed API
+ */
=20
 /**
  * Print available options (high- and low-level) to stdout.  This is
@@ -910,12 +931,13 @@ void fuse_lib_help(struct fuse_args *args);
  * @return the created FUSE handle
  */
 #if FUSE_USE_VERSION =3D=3D 30
-struct fuse *fuse_new_30(struct fuse_args *args, const struct fuse_operati=
ons *op,
-=09=09=09 size_t op_size, void *private_data);
+struct fuse *fuse_new_30(struct fuse_args *args,
+                         const struct fuse_operations *op, size_t op_size,
+                         void *private_data);
 #define fuse_new(args, op, size, data) fuse_new_30(args, op, size, data)
 #else
 struct fuse *fuse_new(struct fuse_args *args, const struct fuse_operations=
 *op,
-=09=09      size_t op_size, void *private_data);
+                      size_t op_size, void *private_data);
 #endif
=20
 /**
@@ -940,7 +962,7 @@ void fuse_unmount(struct fuse *f);
 /**
  * Destroy the FUSE handle.
  *
- * NOTE: This function does not unmount the filesystem.=09 If this is
+ * NOTE: This function does not unmount the filesystem.  If this is
  * needed, call fuse_unmount() before calling this function.
  *
  * @param f the FUSE handle
@@ -1068,7 +1090,7 @@ int fuse_invalidate_path(struct fuse *f, const char *=
path);
  * Do not call this directly, use fuse_main()
  */
 int fuse_main_real(int argc, char *argv[], const struct fuse_operations *o=
p,
-=09=09   size_t op_size, void *private_data);
+                   size_t op_size, void *private_data);
=20
 /**
  * Start the cleanup thread when using option "remember".
@@ -1119,89 +1141,87 @@ struct fuse_fs;
  */
=20
 int fuse_fs_getattr(struct fuse_fs *fs, const char *path, struct stat *buf=
,
-=09=09    struct fuse_file_info *fi);
-int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath,
-=09=09   const char *newpath, unsigned int flags);
+                    struct fuse_file_info *fi);
+int fuse_fs_rename(struct fuse_fs *fs, const char *oldpath, const char *ne=
wpath,
+                   unsigned int flags);
 int fuse_fs_unlink(struct fuse_fs *fs, const char *path);
 int fuse_fs_rmdir(struct fuse_fs *fs, const char *path);
-int fuse_fs_symlink(struct fuse_fs *fs, const char *linkname,
-=09=09    const char *path);
+int fuse_fs_symlink(struct fuse_fs *fs, const char *linkname, const char *=
path);
 int fuse_fs_link(struct fuse_fs *fs, const char *oldpath, const char *newp=
ath);
-int fuse_fs_release(struct fuse_fs *fs,=09 const char *path,
-=09=09    struct fuse_file_info *fi);
+int fuse_fs_release(struct fuse_fs *fs, const char *path,
+                    struct fuse_file_info *fi);
 int fuse_fs_open(struct fuse_fs *fs, const char *path,
-=09=09 struct fuse_file_info *fi);
+                 struct fuse_file_info *fi);
 int fuse_fs_read(struct fuse_fs *fs, const char *path, char *buf, size_t s=
ize,
-=09=09 off_t off, struct fuse_file_info *fi);
+                 off_t off, struct fuse_file_info *fi);
 int fuse_fs_read_buf(struct fuse_fs *fs, const char *path,
-=09=09     struct fuse_bufvec **bufp, size_t size, off_t off,
-=09=09     struct fuse_file_info *fi);
+                     struct fuse_bufvec **bufp, size_t size, off_t off,
+                     struct fuse_file_info *fi);
 int fuse_fs_write(struct fuse_fs *fs, const char *path, const char *buf,
-=09=09  size_t size, off_t off, struct fuse_file_info *fi);
+                  size_t size, off_t off, struct fuse_file_info *fi);
 int fuse_fs_write_buf(struct fuse_fs *fs, const char *path,
-=09=09      struct fuse_bufvec *buf, off_t off,
-=09=09      struct fuse_file_info *fi);
+                      struct fuse_bufvec *buf, off_t off,
+                      struct fuse_file_info *fi);
 int fuse_fs_fsync(struct fuse_fs *fs, const char *path, int datasync,
-=09=09  struct fuse_file_info *fi);
+                  struct fuse_file_info *fi);
 int fuse_fs_flush(struct fuse_fs *fs, const char *path,
-=09=09  struct fuse_file_info *fi);
+                  struct fuse_file_info *fi);
 int fuse_fs_statfs(struct fuse_fs *fs, const char *path, struct statvfs *b=
uf);
 int fuse_fs_opendir(struct fuse_fs *fs, const char *path,
-=09=09    struct fuse_file_info *fi);
+                    struct fuse_file_info *fi);
 int fuse_fs_readdir(struct fuse_fs *fs, const char *path, void *buf,
-=09=09    fuse_fill_dir_t filler, off_t off,
-=09=09    struct fuse_file_info *fi, enum fuse_readdir_flags flags);
+                    fuse_fill_dir_t filler, off_t off,
+                    struct fuse_file_info *fi, enum fuse_readdir_flags fla=
gs);
 int fuse_fs_fsyncdir(struct fuse_fs *fs, const char *path, int datasync,
-=09=09     struct fuse_file_info *fi);
+                     struct fuse_file_info *fi);
 int fuse_fs_releasedir(struct fuse_fs *fs, const char *path,
-=09=09       struct fuse_file_info *fi);
+                       struct fuse_file_info *fi);
 int fuse_fs_create(struct fuse_fs *fs, const char *path, mode_t mode,
-=09=09   struct fuse_file_info *fi);
+                   struct fuse_file_info *fi);
 int fuse_fs_lock(struct fuse_fs *fs, const char *path,
-=09=09 struct fuse_file_info *fi, int cmd, struct flock *lock);
+                 struct fuse_file_info *fi, int cmd, struct flock *lock);
 int fuse_fs_flock(struct fuse_fs *fs, const char *path,
-=09=09  struct fuse_file_info *fi, int op);
+                  struct fuse_file_info *fi, int op);
 int fuse_fs_chmod(struct fuse_fs *fs, const char *path, mode_t mode,
-=09=09  struct fuse_file_info *fi);
+                  struct fuse_file_info *fi);
 int fuse_fs_chown(struct fuse_fs *fs, const char *path, uid_t uid, gid_t g=
id,
-=09=09  struct fuse_file_info *fi);
+                  struct fuse_file_info *fi);
 int fuse_fs_truncate(struct fuse_fs *fs, const char *path, off_t size,
-=09=09     struct fuse_file_info *fi);
+                     struct fuse_file_info *fi);
 int fuse_fs_utimens(struct fuse_fs *fs, const char *path,
-=09=09    const struct timespec tv[2], struct fuse_file_info *fi);
+                    const struct timespec tv[2], struct fuse_file_info *fi=
);
 int fuse_fs_access(struct fuse_fs *fs, const char *path, int mask);
 int fuse_fs_readlink(struct fuse_fs *fs, const char *path, char *buf,
-=09=09     size_t len);
+                     size_t len);
 int fuse_fs_mknod(struct fuse_fs *fs, const char *path, mode_t mode,
-=09=09  dev_t rdev);
+                  dev_t rdev);
 int fuse_fs_mkdir(struct fuse_fs *fs, const char *path, mode_t mode);
 int fuse_fs_setxattr(struct fuse_fs *fs, const char *path, const char *nam=
e,
-=09=09     const char *value, size_t size, int flags);
+                     const char *value, size_t size, int flags);
 int fuse_fs_getxattr(struct fuse_fs *fs, const char *path, const char *nam=
e,
-=09=09     char *value, size_t size);
+                     char *value, size_t size);
 int fuse_fs_listxattr(struct fuse_fs *fs, const char *path, char *list,
-=09=09      size_t size);
-int fuse_fs_removexattr(struct fuse_fs *fs, const char *path,
-=09=09=09const char *name);
+                      size_t size);
+int fuse_fs_removexattr(struct fuse_fs *fs, const char *path, const char *=
name);
 int fuse_fs_bmap(struct fuse_fs *fs, const char *path, size_t blocksize,
-=09=09 uint64_t *idx);
+                 uint64_t *idx);
 int fuse_fs_ioctl(struct fuse_fs *fs, const char *path, unsigned int cmd,
-=09=09  void *arg, struct fuse_file_info *fi, unsigned int flags,
-=09=09  void *data);
+                  void *arg, struct fuse_file_info *fi, unsigned int flags=
,
+                  void *data);
 int fuse_fs_poll(struct fuse_fs *fs, const char *path,
-=09=09 struct fuse_file_info *fi, struct fuse_pollhandle *ph,
-=09=09 unsigned *reventsp);
+                 struct fuse_file_info *fi, struct fuse_pollhandle *ph,
+                 unsigned *reventsp);
 int fuse_fs_fallocate(struct fuse_fs *fs, const char *path, int mode,
-=09=09 off_t offset, off_t length, struct fuse_file_info *fi);
+                      off_t offset, off_t length, struct fuse_file_info *f=
i);
 ssize_t fuse_fs_copy_file_range(struct fuse_fs *fs, const char *path_in,
-=09=09=09=09struct fuse_file_info *fi_in, off_t off_in,
-=09=09=09=09const char *path_out,
-=09=09=09=09struct fuse_file_info *fi_out, off_t off_out,
-=09=09=09=09size_t len, int flags);
+                                struct fuse_file_info *fi_in, off_t off_in=
,
+                                const char *path_out,
+                                struct fuse_file_info *fi_out, off_t off_o=
ut,
+                                size_t len, int flags);
 off_t fuse_fs_lseek(struct fuse_fs *fs, const char *path, off_t off, int w=
hence,
-=09=09    struct fuse_file_info *fi);
+                    struct fuse_file_info *fi);
 void fuse_fs_init(struct fuse_fs *fs, struct fuse_conn_info *conn,
-=09=09struct fuse_config *cfg);
+                  struct fuse_config *cfg);
 void fuse_fs_destroy(struct fuse_fs *fs);
=20
 int fuse_notify_poll(struct fuse_pollhandle *ph);
@@ -1220,7 +1240,7 @@ int fuse_notify_poll(struct fuse_pollhandle *ph);
  * @return a new filesystem object
  */
 struct fuse_fs *fuse_fs_new(const struct fuse_operations *op, size_t op_si=
ze,
-=09=09=09    void *private_data);
+                            void *private_data);
=20
 /**
  * Factory for creating filesystem objects
@@ -1237,7 +1257,7 @@ struct fuse_fs *fuse_fs_new(const struct fuse_operati=
ons *op, size_t op_size,
  * @return the new filesystem object
  */
 typedef struct fuse_fs *(*fuse_module_factory_t)(struct fuse_args *args,
-=09=09=09=09=09=09 struct fuse_fs *fs[]);
+                                                 struct fuse_fs *fs[]);
 /**
  * Register filesystem module
  *
@@ -1249,7 +1269,7 @@ typedef struct fuse_fs *(*fuse_module_factory_t)(stru=
ct fuse_args *args,
  * @param factory_ the factory function for this filesystem module
  */
 #define FUSE_REGISTER_MODULE(name_, factory_) \
-=09fuse_module_factory_t fuse_module_ ## name_ ## _factory =3D factory_
+    fuse_module_factory_t fuse_module_##name_##_factory =3D factory_
=20
 /** Get session from fuse object */
 struct fuse_session *fuse_get_session(struct fuse *f);
diff --git a/tools/virtiofsd/fuse_common.h b/tools/virtiofsd/fuse_common.h
index 18fba813da..7bed38b436 100644
--- a/tools/virtiofsd/fuse_common.h
+++ b/tools/virtiofsd/fuse_common.h
@@ -1,21 +1,23 @@
-/*  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 /** @file */
=20
 #if !defined(FUSE_H_) && !defined(FUSE_LOWLEVEL_H_)
-#error "Never include <fuse_common.h> directly; use <fuse.h> or <fuse_lowl=
evel.h> instead."
+#error \
+    "Never include <fuse_common.h> directly; use <fuse.h> or <fuse_lowleve=
l.h> instead."
 #endif
=20
 #ifndef FUSE_COMMON_H_
 #define FUSE_COMMON_H_
=20
-#include "fuse_opt.h"
 #include "fuse_log.h"
+#include "fuse_opt.h"
 #include <stdint.h>
 #include <sys/types.h>
=20
@@ -25,7 +27,7 @@
 /** Minor version of FUSE library interface */
 #define FUSE_MINOR_VERSION 2
=20
-#define FUSE_MAKE_VERSION(maj, min)  ((maj) * 10 + (min))
+#define FUSE_MAKE_VERSION(maj, min) ((maj) * 10 + (min))
 #define FUSE_VERSION FUSE_MAKE_VERSION(FUSE_MAJOR_VERSION, FUSE_MINOR_VERS=
ION)
=20
 /**
@@ -38,62 +40,78 @@
  * descriptors can share a single file handle.
  */
 struct fuse_file_info {
-=09/** Open flags.=09 Available in open() and release() */
-=09int flags;
-
-=09/** In case of a write operation indicates if this was caused
-=09    by a delayed write from the page cache. If so, then the
-=09    context's pid, uid, and gid fields will not be valid, and
-=09    the *fh* value may not match the *fh* value that would
-=09    have been sent with the corresponding individual write
-=09    requests if write caching had been disabled. */
-=09unsigned int writepage : 1;
-
-=09/** Can be filled in by open, to use direct I/O on this file. */
-=09unsigned int direct_io : 1;
-
-=09/** Can be filled in by open. It signals the kernel that any
-=09    currently cached file data (ie., data that the filesystem
-=09    provided the last time the file was open) need not be
-=09    invalidated. Has no effect when set in other contexts (in
-=09    particular it does nothing when set by opendir()). */
-=09unsigned int keep_cache : 1;
-
-=09/** Indicates a flush operation.  Set in flush operation, also
-=09    maybe set in highlevel lock operation and lowlevel release
-=09    operation. */
-=09unsigned int flush : 1;
-
-=09/** Can be filled in by open, to indicate that the file is not
-=09    seekable. */
-=09unsigned int nonseekable : 1;
-
-=09/* Indicates that flock locks for this file should be
-=09   released.  If set, lock_owner shall contain a valid value.
-=09   May only be set in ->release(). */
-=09unsigned int flock_release : 1;
-
-=09/** Can be filled in by opendir. It signals the kernel to
-=09    enable caching of entries returned by readdir().  Has no
-=09    effect when set in other contexts (in particular it does
-=09    nothing when set by open()). */
-=09unsigned int cache_readdir : 1;
-
-=09/** Padding.  Reserved for future use*/
-=09unsigned int padding : 25;
-=09unsigned int padding2 : 32;
-
-=09/** File handle id.  May be filled in by filesystem in create,
-=09 * open, and opendir().  Available in most other file operations on the
-=09 * same file handle. */
-=09uint64_t fh;
-
-=09/** Lock owner id.  Available in locking operations and flush */
-=09uint64_t lock_owner;
-
-=09/** Requested poll events.  Available in ->poll.  Only set on kernels
-=09    which support it.  If unsupported, this field is set to zero. */
-=09uint32_t poll_events;
+    /** Open flags. Available in open() and release() */
+    int flags;
+
+    /*
+     * In case of a write operation indicates if this was caused
+     * by a delayed write from the page cache. If so, then the
+     * context's pid, uid, and gid fields will not be valid, and
+     * the *fh* value may not match the *fh* value that would
+     * have been sent with the corresponding individual write
+     * requests if write caching had been disabled.
+     */
+    unsigned int writepage:1;
+
+    /** Can be filled in by open, to use direct I/O on this file. */
+    unsigned int direct_io:1;
+
+    /*
+     *  Can be filled in by open. It signals the kernel that any
+     *  currently cached file data (ie., data that the filesystem
+     *  provided the last time the file was open) need not be
+     *  invalidated. Has no effect when set in other contexts (in
+     *  particular it does nothing when set by opendir()).
+     */
+    unsigned int keep_cache:1;
+
+    /*
+     *  Indicates a flush operation.  Set in flush operation, also
+     *  maybe set in highlevel lock operation and lowlevel release
+     *  operation.
+     */
+    unsigned int flush:1;
+
+    /*
+     *  Can be filled in by open, to indicate that the file is not
+     *  seekable.
+     */
+    unsigned int nonseekable:1;
+
+    /*
+     * Indicates that flock locks for this file should be
+     * released.  If set, lock_owner shall contain a valid value.
+     * May only be set in ->release().
+     */
+    unsigned int flock_release:1;
+
+    /*
+     *  Can be filled in by opendir. It signals the kernel to
+     *  enable caching of entries returned by readdir().  Has no
+     *  effect when set in other contexts (in particular it does
+     *  nothing when set by open()).
+     */
+    unsigned int cache_readdir:1;
+
+    /** Padding.  Reserved for future use*/
+    unsigned int padding:25;
+    unsigned int padding2:32;
+
+    /*
+     *  File handle id.  May be filled in by filesystem in create,
+     * open, and opendir().  Available in most other file operations on th=
e
+     * same file handle.
+     */
+    uint64_t fh;
+
+    /** Lock owner id.  Available in locking operations and flush */
+    uint64_t lock_owner;
+
+    /*
+     * Requested poll events.  Available in ->poll.  Only set on kernels
+     * which support it.  If unsupported, this field is set to zero.
+     */
+    uint32_t poll_events;
 };
=20
 /**
@@ -101,28 +119,28 @@ struct fuse_file_info {
  * fuse_loop_mt().
  */
 struct fuse_loop_config {
-=09/**
-=09 * whether to use separate device fds for each thread
-=09 * (may increase performance)
-=09 */
-=09int clone_fd;
-
-=09/**
-=09 * The maximum number of available worker threads before they
-=09 * start to get deleted when they become idle. If not
-=09 * specified, the default is 10.
-=09 *
-=09 * Adjusting this has performance implications; a very small number
-=09 * of threads in the pool will cause a lot of thread creation and
-=09 * deletion overhead and performance may suffer. When set to 0, a new
-=09 * thread will be created to service every operation.
-=09 */
-=09unsigned int max_idle_threads;
+    /**
+     * whether to use separate device fds for each thread
+     * (may increase performance)
+     */
+    int clone_fd;
+
+    /**
+     * The maximum number of available worker threads before they
+     * start to get deleted when they become idle. If not
+     * specified, the default is 10.
+     *
+     * Adjusting this has performance implications; a very small number
+     * of threads in the pool will cause a lot of thread creation and
+     * deletion overhead and performance may suffer. When set to 0, a new
+     * thread will be created to service every operation.
+     */
+    unsigned int max_idle_threads;
 };
=20
-/*************************************************************************=
*
- * Capability bits for 'fuse_conn_info.capable' and 'fuse_conn_info.want' =
*
- *************************************************************************=
*/
+/*
+ * Capability bits for 'fuse_conn_info.capable' and 'fuse_conn_info.want'
+ */
=20
 /**
  * Indicates that the filesystem supports asynchronous read requests.
@@ -134,7 +152,7 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_ASYNC_READ=09=09(1 << 0)
+#define FUSE_CAP_ASYNC_READ (1 << 0)
=20
 /**
  * Indicates that the filesystem supports "remote" locking.
@@ -142,7 +160,7 @@ struct fuse_loop_config {
  * This feature is enabled by default when supported by the kernel,
  * and if getlk() and setlk() handlers are implemented.
  */
-#define FUSE_CAP_POSIX_LOCKS=09=09(1 << 1)
+#define FUSE_CAP_POSIX_LOCKS (1 << 1)
=20
 /**
  * Indicates that the filesystem supports the O_TRUNC open flag.  If
@@ -151,14 +169,14 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_ATOMIC_O_TRUNC=09=09(1 << 3)
+#define FUSE_CAP_ATOMIC_O_TRUNC (1 << 3)
=20
 /**
  * Indicates that the filesystem supports lookups of "." and "..".
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_EXPORT_SUPPORT=09=09(1 << 4)
+#define FUSE_CAP_EXPORT_SUPPORT (1 << 4)
=20
 /**
  * Indicates that the kernel should not apply the umask to the
@@ -166,7 +184,7 @@ struct fuse_loop_config {
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_DONT_MASK=09=09(1 << 6)
+#define FUSE_CAP_DONT_MASK (1 << 6)
=20
 /**
  * Indicates that libfuse should try to use splice() when writing to
@@ -174,7 +192,7 @@ struct fuse_loop_config {
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_SPLICE_WRITE=09=09(1 << 7)
+#define FUSE_CAP_SPLICE_WRITE (1 << 7)
=20
 /**
  * Indicates that libfuse should try to move pages instead of copying when
@@ -182,7 +200,7 @@ struct fuse_loop_config {
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_SPLICE_MOVE=09=09(1 << 8)
+#define FUSE_CAP_SPLICE_MOVE (1 << 8)
=20
 /**
  * Indicates that libfuse should try to use splice() when reading from
@@ -191,7 +209,7 @@ struct fuse_loop_config {
  * This feature is enabled by default when supported by the kernel and
  * if the filesystem implements a write_buf() handler.
  */
-#define FUSE_CAP_SPLICE_READ=09=09(1 << 9)
+#define FUSE_CAP_SPLICE_READ (1 << 9)
=20
 /**
  * If set, the calls to flock(2) will be emulated using POSIX locks and mu=
st
@@ -204,14 +222,14 @@ struct fuse_loop_config {
  * This feature is enabled by default when supported by the kernel and
  * if the filesystem implements a flock() handler.
  */
-#define FUSE_CAP_FLOCK_LOCKS=09=09(1 << 10)
+#define FUSE_CAP_FLOCK_LOCKS (1 << 10)
=20
 /**
  * Indicates that the filesystem supports ioctl's on directories.
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_IOCTL_DIR=09=09(1 << 11)
+#define FUSE_CAP_IOCTL_DIR (1 << 11)
=20
 /**
  * Traditionally, while a file is open the FUSE kernel module only
@@ -233,7 +251,7 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_AUTO_INVAL_DATA=09(1 << 12)
+#define FUSE_CAP_AUTO_INVAL_DATA (1 << 12)
=20
 /**
  * Indicates that the filesystem supports readdirplus.
@@ -241,7 +259,7 @@ struct fuse_loop_config {
  * This feature is enabled by default when supported by the kernel and if =
the
  * filesystem implements a readdirplus() handler.
  */
-#define FUSE_CAP_READDIRPLUS=09=09(1 << 13)
+#define FUSE_CAP_READDIRPLUS (1 << 13)
=20
 /**
  * Indicates that the filesystem supports adaptive readdirplus.
@@ -269,7 +287,7 @@ struct fuse_loop_config {
  * if the filesystem implements both a readdirplus() and a readdir()
  * handler.
  */
-#define FUSE_CAP_READDIRPLUS_AUTO=09(1 << 14)
+#define FUSE_CAP_READDIRPLUS_AUTO (1 << 14)
=20
 /**
  * Indicates that the filesystem supports asynchronous direct I/O submissi=
on.
@@ -280,7 +298,7 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_ASYNC_DIO=09=09(1 << 15)
+#define FUSE_CAP_ASYNC_DIO (1 << 15)
=20
 /**
  * Indicates that writeback caching should be enabled. This means that
@@ -289,7 +307,7 @@ struct fuse_loop_config {
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_WRITEBACK_CACHE=09(1 << 16)
+#define FUSE_CAP_WRITEBACK_CACHE (1 << 16)
=20
 /**
  * Indicates support for zero-message opens. If this flag is set in
@@ -302,7 +320,7 @@ struct fuse_loop_config {
  * Setting (or unsetting) this flag in the `want` field has *no
  * effect*.
  */
-#define FUSE_CAP_NO_OPEN_SUPPORT=09(1 << 17)
+#define FUSE_CAP_NO_OPEN_SUPPORT (1 << 17)
=20
 /**
  * Indicates support for parallel directory operations. If this flag
@@ -312,7 +330,7 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_PARALLEL_DIROPS        (1 << 18)
+#define FUSE_CAP_PARALLEL_DIROPS (1 << 18)
=20
 /**
  * Indicates support for POSIX ACLs.
@@ -331,7 +349,7 @@ struct fuse_loop_config {
  *
  * This feature is disabled by default.
  */
-#define FUSE_CAP_POSIX_ACL              (1 << 19)
+#define FUSE_CAP_POSIX_ACL (1 << 19)
=20
 /**
  * Indicates that the filesystem is responsible for unsetting
@@ -340,7 +358,7 @@ struct fuse_loop_config {
  *
  * This feature is enabled by default when supported by the kernel.
  */
-#define FUSE_CAP_HANDLE_KILLPRIV         (1 << 20)
+#define FUSE_CAP_HANDLE_KILLPRIV (1 << 20)
=20
 /**
  * Indicates support for zero-message opendirs. If this flag is set in
@@ -352,7 +370,7 @@ struct fuse_loop_config {
  *
  * Setting (or unsetting) this flag in the `want` field has *no effect*.
  */
-#define FUSE_CAP_NO_OPENDIR_SUPPORT    (1 << 24)
+#define FUSE_CAP_NO_OPENDIR_SUPPORT (1 << 24)
=20
 /**
  * Ioctl flags
@@ -364,12 +382,12 @@ struct fuse_loop_config {
  *
  * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
  */
-#define FUSE_IOCTL_COMPAT=09(1 << 0)
-#define FUSE_IOCTL_UNRESTRICTED=09(1 << 1)
-#define FUSE_IOCTL_RETRY=09(1 << 2)
-#define FUSE_IOCTL_DIR=09=09(1 << 4)
+#define FUSE_IOCTL_COMPAT (1 << 0)
+#define FUSE_IOCTL_UNRESTRICTED (1 << 1)
+#define FUSE_IOCTL_RETRY (1 << 2)
+#define FUSE_IOCTL_DIR (1 << 4)
=20
-#define FUSE_IOCTL_MAX_IOV=09256
+#define FUSE_IOCTL_MAX_IOV 256
=20
 /**
  * Connection information, passed to the ->init() method
@@ -379,114 +397,114 @@ struct fuse_loop_config {
  * value must usually be smaller than the indicated value.
  */
 struct fuse_conn_info {
-=09/**
-=09 * Major version of the protocol (read-only)
-=09 */
-=09unsigned proto_major;
-
-=09/**
-=09 * Minor version of the protocol (read-only)
-=09 */
-=09unsigned proto_minor;
-
-=09/**
-=09 * Maximum size of the write buffer
-=09 */
-=09unsigned max_write;
-
-=09/**
-=09 * Maximum size of read requests. A value of zero indicates no
-=09 * limit. However, even if the filesystem does not specify a
-=09 * limit, the maximum size of read requests will still be
-=09 * limited by the kernel.
-=09 *
-=09 * NOTE: For the time being, the maximum size of read requests
-=09 * must be set both here *and* passed to fuse_session_new()
-=09 * using the ``-o max_read=3D<n>`` mount option. At some point
-=09 * in the future, specifying the mount option will no longer
-=09 * be necessary.
-=09 */
-=09unsigned max_read;
-
-=09/**
-=09 * Maximum readahead
-=09 */
-=09unsigned max_readahead;
-
-=09/**
-=09 * Capability flags that the kernel supports (read-only)
-=09 */
-=09unsigned capable;
-
-=09/**
-=09 * Capability flags that the filesystem wants to enable.
-=09 *
-=09 * libfuse attempts to initialize this field with
-=09 * reasonable default values before calling the init() handler.
-=09 */
-=09unsigned want;
-
-=09/**
-=09 * Maximum number of pending "background" requests. A
-=09 * background request is any type of request for which the
-=09 * total number is not limited by other means. As of kernel
-=09 * 4.8, only two types of requests fall into this category:
-=09 *
-=09 *   1. Read-ahead requests
-=09 *   2. Asynchronous direct I/O requests
-=09 *
-=09 * Read-ahead requests are generated (if max_readahead is
-=09 * non-zero) by the kernel to preemptively fill its caches
-=09 * when it anticipates that userspace will soon read more
-=09 * data.
-=09 *
-=09 * Asynchronous direct I/O requests are generated if
-=09 * FUSE_CAP_ASYNC_DIO is enabled and userspace submits a large
-=09 * direct I/O request. In this case the kernel will internally
-=09 * split it up into multiple smaller requests and submit them
-=09 * to the filesystem concurrently.
-=09 *
-=09 * Note that the following requests are *not* background
-=09 * requests: writeback requests (limited by the kernel's
-=09 * flusher algorithm), regular (i.e., synchronous and
-=09 * buffered) userspace read/write requests (limited to one per
-=09 * thread), asynchronous read requests (Linux's io_submit(2)
-=09 * call actually blocks, so these are also limited to one per
-=09 * thread).
-=09 */
-=09unsigned max_background;
-
-=09/**
-=09 * Kernel congestion threshold parameter. If the number of pending
-=09 * background requests exceeds this number, the FUSE kernel module will
-=09 * mark the filesystem as "congested". This instructs the kernel to
-=09 * expect that queued requests will take some time to complete, and to
-=09 * adjust its algorithms accordingly (e.g. by putting a waiting thread
-=09 * to sleep instead of using a busy-loop).
-=09 */
-=09unsigned congestion_threshold;
-
-=09/**
-=09 * When FUSE_CAP_WRITEBACK_CACHE is enabled, the kernel is responsible
-=09 * for updating mtime and ctime when write requests are received. The
-=09 * updated values are passed to the filesystem with setattr() requests.
-=09 * However, if the filesystem does not support the full resolution of
-=09 * the kernel timestamps (nanoseconds), the mtime and ctime values used
-=09 * by kernel and filesystem will differ (and result in an apparent
-=09 * change of times after a cache flush).
-=09 *
-=09 * To prevent this problem, this variable can be used to inform the
-=09 * kernel about the timestamp granularity supported by the file-system.
-=09 * The value should be power of 10.  The default is 1, i.e. full
-=09 * nano-second resolution. Filesystems supporting only second resolutio=
n
-=09 * should set this to 1000000000.
-=09 */
-=09unsigned time_gran;
-
-=09/**
-=09 * For future use.
-=09 */
-=09unsigned reserved[22];
+    /**
+     * Major version of the protocol (read-only)
+     */
+    unsigned proto_major;
+
+    /**
+     * Minor version of the protocol (read-only)
+     */
+    unsigned proto_minor;
+
+    /**
+     * Maximum size of the write buffer
+     */
+    unsigned max_write;
+
+    /**
+     * Maximum size of read requests. A value of zero indicates no
+     * limit. However, even if the filesystem does not specify a
+     * limit, the maximum size of read requests will still be
+     * limited by the kernel.
+     *
+     * NOTE: For the time being, the maximum size of read requests
+     * must be set both here *and* passed to fuse_session_new()
+     * using the ``-o max_read=3D<n>`` mount option. At some point
+     * in the future, specifying the mount option will no longer
+     * be necessary.
+     */
+    unsigned max_read;
+
+    /**
+     * Maximum readahead
+     */
+    unsigned max_readahead;
+
+    /**
+     * Capability flags that the kernel supports (read-only)
+     */
+    unsigned capable;
+
+    /**
+     * Capability flags that the filesystem wants to enable.
+     *
+     * libfuse attempts to initialize this field with
+     * reasonable default values before calling the init() handler.
+     */
+    unsigned want;
+
+    /**
+     * Maximum number of pending "background" requests. A
+     * background request is any type of request for which the
+     * total number is not limited by other means. As of kernel
+     * 4.8, only two types of requests fall into this category:
+     *
+     *   1. Read-ahead requests
+     *   2. Asynchronous direct I/O requests
+     *
+     * Read-ahead requests are generated (if max_readahead is
+     * non-zero) by the kernel to preemptively fill its caches
+     * when it anticipates that userspace will soon read more
+     * data.
+     *
+     * Asynchronous direct I/O requests are generated if
+     * FUSE_CAP_ASYNC_DIO is enabled and userspace submits a large
+     * direct I/O request. In this case the kernel will internally
+     * split it up into multiple smaller requests and submit them
+     * to the filesystem concurrently.
+     *
+     * Note that the following requests are *not* background
+     * requests: writeback requests (limited by the kernel's
+     * flusher algorithm), regular (i.e., synchronous and
+     * buffered) userspace read/write requests (limited to one per
+     * thread), asynchronous read requests (Linux's io_submit(2)
+     * call actually blocks, so these are also limited to one per
+     * thread).
+     */
+    unsigned max_background;
+
+    /**
+     * Kernel congestion threshold parameter. If the number of pending
+     * background requests exceeds this number, the FUSE kernel module wil=
l
+     * mark the filesystem as "congested". This instructs the kernel to
+     * expect that queued requests will take some time to complete, and to
+     * adjust its algorithms accordingly (e.g. by putting a waiting thread
+     * to sleep instead of using a busy-loop).
+     */
+    unsigned congestion_threshold;
+
+    /**
+     * When FUSE_CAP_WRITEBACK_CACHE is enabled, the kernel is responsible
+     * for updating mtime and ctime when write requests are received. The
+     * updated values are passed to the filesystem with setattr() requests=
.
+     * However, if the filesystem does not support the full resolution of
+     * the kernel timestamps (nanoseconds), the mtime and ctime values use=
d
+     * by kernel and filesystem will differ (and result in an apparent
+     * change of times after a cache flush).
+     *
+     * To prevent this problem, this variable can be used to inform the
+     * kernel about the timestamp granularity supported by the file-system=
.
+     * The value should be power of 10.  The default is 1, i.e. full
+     * nano-second resolution. Filesystems supporting only second resoluti=
on
+     * should set this to 1000000000.
+     */
+    unsigned time_gran;
+
+    /**
+     * For future use.
+     */
+    unsigned reserved[22];
 };
=20
 struct fuse_session;
@@ -513,21 +531,20 @@ struct fuse_conn_info_opts;
  *   -o async_read          sets FUSE_CAP_ASYNC_READ in conn->want
  *   -o sync_read           unsets FUSE_CAP_ASYNC_READ in conn->want
  *   -o atomic_o_trunc      sets FUSE_CAP_ATOMIC_O_TRUNC in conn->want
- *   -o no_remote_lock      Equivalent to -o no_remote_flock,no_remote_pos=
ix_lock
- *   -o no_remote_flock     Unsets FUSE_CAP_FLOCK_LOCKS in conn->want
- *   -o no_remote_posix_lock  Unsets FUSE_CAP_POSIX_LOCKS in conn->want
- *   -o [no_]splice_write     (un-)sets FUSE_CAP_SPLICE_WRITE in conn->wan=
t
- *   -o [no_]splice_move      (un-)sets FUSE_CAP_SPLICE_MOVE in conn->want
- *   -o [no_]splice_read      (un-)sets FUSE_CAP_SPLICE_READ in conn->want
- *   -o [no_]auto_inval_data  (un-)sets FUSE_CAP_AUTO_INVAL_DATA in conn->=
want
- *   -o readdirplus=3Dno        unsets FUSE_CAP_READDIRPLUS in conn->want
- *   -o readdirplus=3Dyes       sets FUSE_CAP_READDIRPLUS and unsets
- *                            FUSE_CAP_READDIRPLUS_AUTO in conn->want
- *   -o readdirplus=3Dauto      sets FUSE_CAP_READDIRPLUS and
- *                            FUSE_CAP_READDIRPLUS_AUTO in conn->want
- *   -o [no_]async_dio        (un-)sets FUSE_CAP_ASYNC_DIO in conn->want
- *   -o [no_]writeback_cache  (un-)sets FUSE_CAP_WRITEBACK_CACHE in conn->=
want
- *   -o time_gran=3DN           sets conn->time_gran
+ *   -o no_remote_lock      Equivalent to -o
+ *no_remote_flock,no_remote_posix_lock -o no_remote_flock     Unsets
+ *FUSE_CAP_FLOCK_LOCKS in conn->want -o no_remote_posix_lock  Unsets
+ *FUSE_CAP_POSIX_LOCKS in conn->want -o [no_]splice_write     (un-)sets
+ *FUSE_CAP_SPLICE_WRITE in conn->want -o [no_]splice_move      (un-)sets
+ *FUSE_CAP_SPLICE_MOVE in conn->want -o [no_]splice_read      (un-)sets
+ *FUSE_CAP_SPLICE_READ in conn->want -o [no_]auto_inval_data  (un-)sets
+ *FUSE_CAP_AUTO_INVAL_DATA in conn->want -o readdirplus=3Dno        unsets
+ *FUSE_CAP_READDIRPLUS in conn->want -o readdirplus=3Dyes       sets
+ *FUSE_CAP_READDIRPLUS and unsets FUSE_CAP_READDIRPLUS_AUTO in conn->want =
-o
+ *readdirplus=3Dauto      sets FUSE_CAP_READDIRPLUS and FUSE_CAP_READDIRPL=
US_AUTO
+ *in conn->want -o [no_]async_dio        (un-)sets FUSE_CAP_ASYNC_DIO in
+ *conn->want -o [no_]writeback_cache  (un-)sets FUSE_CAP_WRITEBACK_CACHE i=
n
+ *conn->want -o time_gran=3DN           sets conn->time_gran
  *
  * Known options will be removed from *args*, unknown options will be
  * passed through unchanged.
@@ -535,7 +552,7 @@ struct fuse_conn_info_opts;
  * @param args argument vector (input+output)
  * @return parsed options
  **/
-struct fuse_conn_info_opts* fuse_parse_conn_info_opts(struct fuse_args *ar=
gs);
+struct fuse_conn_info_opts *fuse_parse_conn_info_opts(struct fuse_args *ar=
gs);
=20
 /**
  * This function applies the (parsed) parameters in *opts* to the
@@ -545,7 +562,7 @@ struct fuse_conn_info_opts* fuse_parse_conn_info_opts(s=
truct fuse_args *args);
  * option has been explicitly set.
  */
 void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
-=09=09=09  struct fuse_conn_info *conn);
+                               struct fuse_conn_info *conn);
=20
 /**
  * Go into the background
@@ -576,81 +593,81 @@ const char *fuse_pkgversion(void);
  */
 void fuse_pollhandle_destroy(struct fuse_pollhandle *ph);
=20
-/* ----------------------------------------------------------- *
- * Data buffer=09=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Data buffer
+ */
=20
 /**
  * Buffer flags
  */
 enum fuse_buf_flags {
-=09/**
-=09 * Buffer contains a file descriptor
-=09 *
-=09 * If this flag is set, the .fd field is valid, otherwise the
-=09 * .mem fields is valid.
-=09 */
-=09FUSE_BUF_IS_FD=09=09=3D (1 << 1),
-
-=09/**
-=09 * Seek on the file descriptor
-=09 *
-=09 * If this flag is set then the .pos field is valid and is
-=09 * used to seek to the given offset before performing
-=09 * operation on file descriptor.
-=09 */
-=09FUSE_BUF_FD_SEEK=09=3D (1 << 2),
-
-=09/**
-=09 * Retry operation on file descriptor
-=09 *
-=09 * If this flag is set then retry operation on file descriptor
-=09 * until .size bytes have been copied or an error or EOF is
-=09 * detected.
-=09 */
-=09FUSE_BUF_FD_RETRY=09=3D (1 << 3),
+    /**
+     * Buffer contains a file descriptor
+     *
+     * If this flag is set, the .fd field is valid, otherwise the
+     * .mem fields is valid.
+     */
+    FUSE_BUF_IS_FD =3D (1 << 1),
+
+    /**
+     * Seek on the file descriptor
+     *
+     * If this flag is set then the .pos field is valid and is
+     * used to seek to the given offset before performing
+     * operation on file descriptor.
+     */
+    FUSE_BUF_FD_SEEK =3D (1 << 2),
+
+    /**
+     * Retry operation on file descriptor
+     *
+     * If this flag is set then retry operation on file descriptor
+     * until .size bytes have been copied or an error or EOF is
+     * detected.
+     */
+    FUSE_BUF_FD_RETRY =3D (1 << 3),
 };
=20
 /**
  * Buffer copy flags
  */
 enum fuse_buf_copy_flags {
-=09/**
-=09 * Don't use splice(2)
-=09 *
-=09 * Always fall back to using read and write instead of
-=09 * splice(2) to copy data from one file descriptor to another.
-=09 *
-=09 * If this flag is not set, then only fall back if splice is
-=09 * unavailable.
-=09 */
-=09FUSE_BUF_NO_SPLICE=09=3D (1 << 1),
-
-=09/**
-=09 * Force splice
-=09 *
-=09 * Always use splice(2) to copy data from one file descriptor
-=09 * to another.  If splice is not available, return -EINVAL.
-=09 */
-=09FUSE_BUF_FORCE_SPLICE=09=3D (1 << 2),
-
-=09/**
-=09 * Try to move data with splice.
-=09 *
-=09 * If splice is used, try to move pages from the source to the
-=09 * destination instead of copying.  See documentation of
-=09 * SPLICE_F_MOVE in splice(2) man page.
-=09 */
-=09FUSE_BUF_SPLICE_MOVE=09=3D (1 << 3),
-
-=09/**
-=09 * Don't block on the pipe when copying data with splice
-=09 *
-=09 * Makes the operations on the pipe non-blocking (if the pipe
-=09 * is full or empty).  See SPLICE_F_NONBLOCK in the splice(2)
-=09 * man page.
-=09 */
-=09FUSE_BUF_SPLICE_NONBLOCK=3D (1 << 4),
+    /**
+     * Don't use splice(2)
+     *
+     * Always fall back to using read and write instead of
+     * splice(2) to copy data from one file descriptor to another.
+     *
+     * If this flag is not set, then only fall back if splice is
+     * unavailable.
+     */
+    FUSE_BUF_NO_SPLICE =3D (1 << 1),
+
+    /**
+     * Force splice
+     *
+     * Always use splice(2) to copy data from one file descriptor
+     * to another.  If splice is not available, return -EINVAL.
+     */
+    FUSE_BUF_FORCE_SPLICE =3D (1 << 2),
+
+    /**
+     * Try to move data with splice.
+     *
+     * If splice is used, try to move pages from the source to the
+     * destination instead of copying.  See documentation of
+     * SPLICE_F_MOVE in splice(2) man page.
+     */
+    FUSE_BUF_SPLICE_MOVE =3D (1 << 3),
+
+    /**
+     * Don't block on the pipe when copying data with splice
+     *
+     * Makes the operations on the pipe non-blocking (if the pipe
+     * is full or empty).  See SPLICE_F_NONBLOCK in the splice(2)
+     * man page.
+     */
+    FUSE_BUF_SPLICE_NONBLOCK =3D (1 << 4),
 };
=20
 /**
@@ -660,36 +677,36 @@ enum fuse_buf_copy_flags {
  * be supplied as a memory pointer or as a file descriptor
  */
 struct fuse_buf {
-=09/**
-=09 * Size of data in bytes
-=09 */
-=09size_t size;
-
-=09/**
-=09 * Buffer flags
-=09 */
-=09enum fuse_buf_flags flags;
-
-=09/**
-=09 * Memory pointer
-=09 *
-=09 * Used unless FUSE_BUF_IS_FD flag is set.
-=09 */
-=09void *mem;
-
-=09/**
-=09 * File descriptor
-=09 *
-=09 * Used if FUSE_BUF_IS_FD flag is set.
-=09 */
-=09int fd;
-
-=09/**
-=09 * File position
-=09 *
-=09 * Used if FUSE_BUF_FD_SEEK flag is set.
-=09 */
-=09off_t pos;
+    /**
+     * Size of data in bytes
+     */
+    size_t size;
+
+    /**
+     * Buffer flags
+     */
+    enum fuse_buf_flags flags;
+
+    /**
+     * Memory pointer
+     *
+     * Used unless FUSE_BUF_IS_FD flag is set.
+     */
+    void *mem;
+
+    /**
+     * File descriptor
+     *
+     * Used if FUSE_BUF_IS_FD flag is set.
+     */
+    int fd;
+
+    /**
+     * File position
+     *
+     * Used if FUSE_BUF_FD_SEEK flag is set.
+     */
+    off_t pos;
 };
=20
 /**
@@ -701,41 +718,39 @@ struct fuse_buf {
  * Allocate dynamically to add more than one buffer.
  */
 struct fuse_bufvec {
-=09/**
-=09 * Number of buffers in the array
-=09 */
-=09size_t count;
-
-=09/**
-=09 * Index of current buffer within the array
-=09 */
-=09size_t idx;
-
-=09/**
-=09 * Current offset within the current buffer
-=09 */
-=09size_t off;
-
-=09/**
-=09 * Array of buffers
-=09 */
-=09struct fuse_buf buf[1];
+    /**
+     * Number of buffers in the array
+     */
+    size_t count;
+
+    /**
+     * Index of current buffer within the array
+     */
+    size_t idx;
+
+    /**
+     * Current offset within the current buffer
+     */
+    size_t off;
+
+    /**
+     * Array of buffers
+     */
+    struct fuse_buf buf[1];
 };
=20
 /* Initialize bufvec with a single buffer of given size */
-#define FUSE_BUFVEC_INIT(size__)=09=09=09=09\
-=09((struct fuse_bufvec) {=09=09=09=09=09\
-=09=09/* .count=3D */ 1,=09=09=09=09\
-=09=09/* .idx =3D  */ 0,=09=09=09=09\
-=09=09/* .off =3D  */ 0,=09=09=09=09\
-=09=09/* .buf =3D  */ { /* [0] =3D */ {=09=09=09\
-=09=09=09/* .size =3D  */ (size__),=09=09\
-=09=09=09/* .flags =3D */ (enum fuse_buf_flags) 0,=09\
-=09=09=09/* .mem =3D   */ NULL,=09=09=09\
-=09=09=09/* .fd =3D    */ -1,=09=09=09\
-=09=09=09/* .pos =3D   */ 0,=09=09=09\
-=09=09} }=09=09=09=09=09=09\
-=09} )
+#define FUSE_BUFVEC_INIT(size__)                                      \
+    ((struct fuse_bufvec){ /* .count=3D */ 1,                           \
+                           /* .idx =3D  */ 0,                           \
+                           /* .off =3D  */ 0, /* .buf =3D  */             =
\
+                           { /* [0] =3D */ {                            \
+                               /* .size =3D  */ (size__),               \
+                               /* .flags =3D */ (enum fuse_buf_flags)0, \
+                               /* .mem =3D   */ NULL,                   \
+                               /* .fd =3D    */ -1,                     \
+                               /* .pos =3D   */ 0,                      \
+                           } } })
=20
 /**
  * Get total size of data in a fuse buffer vector
@@ -754,16 +769,16 @@ size_t fuse_buf_size(const struct fuse_bufvec *bufv);
  * @return actual number of bytes copied or -errno on error
  */
 ssize_t fuse_buf_copy(struct fuse_bufvec *dst, struct fuse_bufvec *src,
-=09=09      enum fuse_buf_copy_flags flags);
+                      enum fuse_buf_copy_flags flags);
=20
-/* ----------------------------------------------------------- *
- * Signal handling=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Signal handling
+ */
=20
 /**
  * Exit session on HUP, TERM and INT signals and ignore PIPE signal
  *
- * Stores session in a global variable.=09 May only be called once per
+ * Stores session in a global variable. May only be called once per
  * process until fuse_remove_signal_handlers() is called.
  *
  * Once either of the POSIX signals arrives, the signal handler calls
@@ -790,12 +805,12 @@ int fuse_set_signal_handlers(struct fuse_session *se)=
;
  */
 void fuse_remove_signal_handlers(struct fuse_session *se);
=20
-/* ----------------------------------------------------------- *
- * Compatibility stuff=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Compatibility stuff
+ */
=20
 #if !defined(FUSE_USE_VERSION) || FUSE_USE_VERSION < 30
-#  error only API version 30 or greater is supported
+#error only API version 30 or greater is supported
 #endif
=20
=20
@@ -805,11 +820,14 @@ void fuse_remove_signal_handlers(struct fuse_session =
*se);
  * On 32bit systems please add -D_FILE_OFFSET_BITS=3D64 to your compile fl=
ags!
  */
=20
-#if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
+#if defined(__GNUC__) &&                                      \
+    (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 6) && \
+    !defined __cplusplus
 _Static_assert(sizeof(off_t) =3D=3D 8, "fuse: off_t must be 64bit");
 #else
-struct _fuse_off_t_must_be_64bit_dummy_struct \
-=09{ unsigned _fuse_off_t_must_be_64bit:((sizeof(off_t) =3D=3D 8) ? 1 : -1=
); };
+struct _fuse_off_t_must_be_64bit_dummy_struct {
+    unsigned _fuse_off_t_must_be_64bit:((sizeof(off_t) =3D=3D 8) ? 1 : -1)=
;
+};
 #endif
=20
 #endif /* FUSE_COMMON_H_ */
diff --git a/tools/virtiofsd/fuse_i.h b/tools/virtiofsd/fuse_i.h
index bcd6a140fc..1119e85e57 100644
--- a/tools/virtiofsd/fuse_i.h
+++ b/tools/virtiofsd/fuse_i.h
@@ -1,71 +1,71 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #include "fuse.h"
 #include "fuse_lowlevel.h"
=20
 struct fuse_req {
-=09struct fuse_session *se;
-=09uint64_t unique;
-=09int ctr;
-=09pthread_mutex_t lock;
-=09struct fuse_ctx ctx;
-=09struct fuse_chan *ch;
-=09int interrupted;
-=09unsigned int ioctl_64bit : 1;
-=09union {
-=09=09struct {
-=09=09=09uint64_t unique;
-=09=09} i;
-=09=09struct {
-=09=09=09fuse_interrupt_func_t func;
-=09=09=09void *data;
-=09=09} ni;
-=09} u;
-=09struct fuse_req *next;
-=09struct fuse_req *prev;
+    struct fuse_session *se;
+    uint64_t unique;
+    int ctr;
+    pthread_mutex_t lock;
+    struct fuse_ctx ctx;
+    struct fuse_chan *ch;
+    int interrupted;
+    unsigned int ioctl_64bit:1;
+    union {
+        struct {
+            uint64_t unique;
+        } i;
+        struct {
+            fuse_interrupt_func_t func;
+            void *data;
+        } ni;
+    } u;
+    struct fuse_req *next;
+    struct fuse_req *prev;
 };
=20
 struct fuse_notify_req {
-=09uint64_t unique;
-=09void (*reply)(struct fuse_notify_req *, fuse_req_t, fuse_ino_t,
-=09=09      const void *, const struct fuse_buf *);
-=09struct fuse_notify_req *next;
-=09struct fuse_notify_req *prev;
+    uint64_t unique;
+    void (*reply)(struct fuse_notify_req *, fuse_req_t, fuse_ino_t,
+                  const void *, const struct fuse_buf *);
+    struct fuse_notify_req *next;
+    struct fuse_notify_req *prev;
 };
=20
 struct fuse_session {
-=09char *mountpoint;
-=09volatile int exited;
-=09int fd;
-=09int debug;
-=09int deny_others;
-=09struct fuse_lowlevel_ops op;
-=09int got_init;
-=09struct cuse_data *cuse_data;
-=09void *userdata;
-=09uid_t owner;
-=09struct fuse_conn_info conn;
-=09struct fuse_req list;
-=09struct fuse_req interrupts;
-=09pthread_mutex_t lock;
-=09int got_destroy;
-=09int broken_splice_nonblock;
-=09uint64_t notify_ctr;
-=09struct fuse_notify_req notify_list;
-=09size_t bufsize;
-=09int error;
+    char *mountpoint;
+    volatile int exited;
+    int fd;
+    int debug;
+    int deny_others;
+    struct fuse_lowlevel_ops op;
+    int got_init;
+    struct cuse_data *cuse_data;
+    void *userdata;
+    uid_t owner;
+    struct fuse_conn_info conn;
+    struct fuse_req list;
+    struct fuse_req interrupts;
+    pthread_mutex_t lock;
+    int got_destroy;
+    int broken_splice_nonblock;
+    uint64_t notify_ctr;
+    struct fuse_notify_req notify_list;
+    size_t bufsize;
+    int error;
 };
=20
 struct fuse_chan {
-=09pthread_mutex_t lock;
-=09int ctr;
-=09int fd;
+    pthread_mutex_t lock;
+    int ctr;
+    int fd;
 };
=20
 /**
@@ -76,16 +76,16 @@ struct fuse_chan {
  *
  */
 struct fuse_module {
-=09char *name;
-=09fuse_module_factory_t factory;
-=09struct fuse_module *next;
-=09struct fusemod_so *so;
-=09int ctr;
+    char *name;
+    fuse_module_factory_t factory;
+    struct fuse_module *next;
+    struct fusemod_so *so;
+    int ctr;
 };
=20
-/* ----------------------------------------------------------- *
- * Channel interface (when using -o clone_fd)=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Channel interface (when using -o clone_fd)
+ */
=20
 /**
  * Obtain counted reference to the channel
@@ -103,11 +103,12 @@ struct fuse_chan *fuse_chan_get(struct fuse_chan *ch)=
;
 void fuse_chan_put(struct fuse_chan *ch);
=20
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *io=
v,
-=09=09=09       int count);
+                               int count);
 void fuse_free_req(fuse_req_t req);
=20
 void fuse_session_process_buf_int(struct fuse_session *se,
-=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch);
+                                  const struct fuse_buf *buf,
+                                  struct fuse_chan *ch);
=20
=20
 #define FUSE_MAX_MAX_PAGES 256
diff --git a/tools/virtiofsd/fuse_log.c b/tools/virtiofsd/fuse_log.c
index 0d268ab014..11345f9ec8 100644
--- a/tools/virtiofsd/fuse_log.c
+++ b/tools/virtiofsd/fuse_log.c
@@ -1,40 +1,40 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2019  Red Hat, Inc.
-
-  Logging API.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2019  Red Hat, Inc.
+ *
+ * Logging API.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #include "fuse_log.h"
=20
 #include <stdarg.h>
 #include <stdio.h>
=20
-static void default_log_func(
-=09=09__attribute__(( unused )) enum fuse_log_level level,
-=09=09const char *fmt, va_list ap)
+static void default_log_func(__attribute__((unused)) enum fuse_log_level l=
evel,
+                             const char *fmt, va_list ap)
 {
-=09vfprintf(stderr, fmt, ap);
+    vfprintf(stderr, fmt, ap);
 }
=20
 static fuse_log_func_t log_func =3D default_log_func;
=20
 void fuse_set_log_func(fuse_log_func_t func)
 {
-=09if (!func)
-=09=09func =3D default_log_func;
+    if (!func) {
+        func =3D default_log_func;
+    }
=20
-=09log_func =3D func;
+    log_func =3D func;
 }
=20
 void fuse_log(enum fuse_log_level level, const char *fmt, ...)
 {
-=09va_list ap;
+    va_list ap;
=20
-=09va_start(ap, fmt);
-=09log_func(level, fmt, ap);
-=09va_end(ap);
+    va_start(ap, fmt);
+    log_func(level, fmt, ap);
+    va_end(ap);
 }
diff --git a/tools/virtiofsd/fuse_log.h b/tools/virtiofsd/fuse_log.h
index 0af700da6b..bf6c11ff11 100644
--- a/tools/virtiofsd/fuse_log.h
+++ b/tools/virtiofsd/fuse_log.h
@@ -1,10 +1,10 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2019  Red Hat, Inc.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2019  Red Hat, Inc.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #ifndef FUSE_LOG_H_
 #define FUSE_LOG_H_
@@ -22,14 +22,14 @@
  * These levels correspond to syslog(2) log levels since they are widely u=
sed.
  */
 enum fuse_log_level {
-=09FUSE_LOG_EMERG,
-=09FUSE_LOG_ALERT,
-=09FUSE_LOG_CRIT,
-=09FUSE_LOG_ERR,
-=09FUSE_LOG_WARNING,
-=09FUSE_LOG_NOTICE,
-=09FUSE_LOG_INFO,
-=09FUSE_LOG_DEBUG
+    FUSE_LOG_EMERG,
+    FUSE_LOG_ALERT,
+    FUSE_LOG_CRIT,
+    FUSE_LOG_ERR,
+    FUSE_LOG_WARNING,
+    FUSE_LOG_NOTICE,
+    FUSE_LOG_INFO,
+    FUSE_LOG_DEBUG
 };
=20
 /**
@@ -45,8 +45,8 @@ enum fuse_log_level {
  * @param fmt sprintf-style format string including newline
  * @param ap format string arguments
  */
-typedef void (*fuse_log_func_t)(enum fuse_log_level level,
-=09=09=09=09const char *fmt, va_list ap);
+typedef void (*fuse_log_func_t)(enum fuse_log_level level, const char *fmt=
,
+                                va_list ap);
=20
 /**
  * Install a custom log handler function.
diff --git a/tools/virtiofsd/fuse_loop_mt.c b/tools/virtiofsd/fuse_loop_mt.=
c
index 6fcd47e42c..39e080d9ff 100644
--- a/tools/virtiofsd/fuse_loop_mt.c
+++ b/tools/virtiofsd/fuse_loop_mt.c
@@ -1,54 +1,56 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  Implementation of the multi-threaded FUSE session loop.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Implementation of the multi-threaded FUSE session loop.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #include "config.h"
+#include "fuse_i.h"
+#include "fuse_kernel.h"
 #include "fuse_lowlevel.h"
 #include "fuse_misc.h"
-#include "fuse_kernel.h"
-#include "fuse_i.h"
=20
+#include <assert.h>
+#include <errno.h>
+#include <semaphore.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
-#include <signal.h>
-#include <semaphore.h>
-#include <errno.h>
-#include <sys/time.h>
 #include <sys/ioctl.h>
-#include <assert.h>
+#include <sys/time.h>
+#include <unistd.h>
=20
 /* Environment var controlling the thread stack size */
 #define ENVNAME_THREAD_STACK "FUSE_THREAD_STACK"
=20
 struct fuse_chan *fuse_chan_get(struct fuse_chan *ch)
 {
-=09assert(ch->ctr > 0);
-=09pthread_mutex_lock(&ch->lock);
-=09ch->ctr++;
-=09pthread_mutex_unlock(&ch->lock);
+    assert(ch->ctr > 0);
+    pthread_mutex_lock(&ch->lock);
+    ch->ctr++;
+    pthread_mutex_unlock(&ch->lock);
=20
-=09return ch;
+    return ch;
 }
=20
 void fuse_chan_put(struct fuse_chan *ch)
 {
-=09if (ch =3D=3D NULL)
-=09=09return;
-=09pthread_mutex_lock(&ch->lock);
-=09ch->ctr--;
-=09if (!ch->ctr) {
-=09=09pthread_mutex_unlock(&ch->lock);
-=09=09close(ch->fd);
-=09=09pthread_mutex_destroy(&ch->lock);
-=09=09free(ch);
-=09} else
-=09=09pthread_mutex_unlock(&ch->lock);
+    if (ch =3D=3D NULL) {
+        return;
+    }
+    pthread_mutex_lock(&ch->lock);
+    ch->ctr--;
+    if (!ch->ctr) {
+        pthread_mutex_unlock(&ch->lock);
+        close(ch->fd);
+        pthread_mutex_destroy(&ch->lock);
+        free(ch);
+    } else {
+        pthread_mutex_unlock(&ch->lock);
+    }
 }
diff --git a/tools/virtiofsd/fuse_lowlevel.c b/tools/virtiofsd/fuse_lowleve=
l.c
index 5d915666d8..42feee5c1c 100644
--- a/tools/virtiofsd/fuse_lowlevel.c
+++ b/tools/virtiofsd/fuse_lowlevel.c
@@ -1,2398 +1,2539 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  Implementation of (most of) the low-level FUSE API. The session loop
-  functions are implemented in separate files.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Implementation of (most of) the low-level FUSE API. The session loop
+ * functions are implemented in separate files.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #define _GNU_SOURCE
=20
 #include "config.h"
 #include "fuse_i.h"
 #include "fuse_kernel.h"
-#include "fuse_opt.h"
 #include "fuse_misc.h"
+#include "fuse_opt.h"
 #include "mount_util.h"
=20
+#include <assert.h>
+#include <errno.h>
+#include <limits.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stddef.h>
 #include <string.h>
-#include <unistd.h>
-#include <limits.h>
-#include <errno.h>
-#include <assert.h>
 #include <sys/file.h>
-
+#include <unistd.h>
=20
=20
 #define PARAM(inarg) (((char *)(inarg)) + sizeof(*(inarg)))
 #define OFFSET_MAX 0x7fffffffffffffffLL
=20
-#define container_of(ptr, type, member) ({=09=09=09=09\
-=09=09=09const typeof( ((type *)0)->member ) *__mptr =3D (ptr); \
-=09=09=09(type *)( (char *)__mptr - offsetof(type,member) );})
+#define container_of(ptr, type, member)                    \
+    ({                                                     \
+        const typeof(((type *)0)->member) *__mptr =3D (ptr); \
+        (type *)((char *)__mptr - offsetof(type, member)); \
+    })
=20
 struct fuse_pollhandle {
-=09uint64_t kh;
-=09struct fuse_session *se;
+    uint64_t kh;
+    struct fuse_session *se;
 };
=20
 static size_t pagesize;
=20
 static __attribute__((constructor)) void fuse_ll_init_pagesize(void)
 {
-=09pagesize =3D getpagesize();
+    pagesize =3D getpagesize();
 }
=20
 static void convert_stat(const struct stat *stbuf, struct fuse_attr *attr)
 {
-=09attr->ino=09=3D stbuf->st_ino;
-=09attr->mode=09=3D stbuf->st_mode;
-=09attr->nlink=09=3D stbuf->st_nlink;
-=09attr->uid=09=3D stbuf->st_uid;
-=09attr->gid=09=3D stbuf->st_gid;
-=09attr->rdev=09=3D stbuf->st_rdev;
-=09attr->size=09=3D stbuf->st_size;
-=09attr->blksize=09=3D stbuf->st_blksize;
-=09attr->blocks=09=3D stbuf->st_blocks;
-=09attr->atime=09=3D stbuf->st_atime;
-=09attr->mtime=09=3D stbuf->st_mtime;
-=09attr->ctime=09=3D stbuf->st_ctime;
-=09attr->atimensec =3D ST_ATIM_NSEC(stbuf);
-=09attr->mtimensec =3D ST_MTIM_NSEC(stbuf);
-=09attr->ctimensec =3D ST_CTIM_NSEC(stbuf);
+    attr->ino =3D stbuf->st_ino;
+    attr->mode =3D stbuf->st_mode;
+    attr->nlink =3D stbuf->st_nlink;
+    attr->uid =3D stbuf->st_uid;
+    attr->gid =3D stbuf->st_gid;
+    attr->rdev =3D stbuf->st_rdev;
+    attr->size =3D stbuf->st_size;
+    attr->blksize =3D stbuf->st_blksize;
+    attr->blocks =3D stbuf->st_blocks;
+    attr->atime =3D stbuf->st_atime;
+    attr->mtime =3D stbuf->st_mtime;
+    attr->ctime =3D stbuf->st_ctime;
+    attr->atimensec =3D ST_ATIM_NSEC(stbuf);
+    attr->mtimensec =3D ST_MTIM_NSEC(stbuf);
+    attr->ctimensec =3D ST_CTIM_NSEC(stbuf);
 }
=20
 static void convert_attr(const struct fuse_setattr_in *attr, struct stat *=
stbuf)
 {
-=09stbuf->st_mode=09       =3D attr->mode;
-=09stbuf->st_uid=09       =3D attr->uid;
-=09stbuf->st_gid=09       =3D attr->gid;
-=09stbuf->st_size=09       =3D attr->size;
-=09stbuf->st_atime=09       =3D attr->atime;
-=09stbuf->st_mtime=09       =3D attr->mtime;
-=09stbuf->st_ctime        =3D attr->ctime;
-=09ST_ATIM_NSEC_SET(stbuf, attr->atimensec);
-=09ST_MTIM_NSEC_SET(stbuf, attr->mtimensec);
-=09ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
+    stbuf->st_mode =3D attr->mode;
+    stbuf->st_uid =3D attr->uid;
+    stbuf->st_gid =3D attr->gid;
+    stbuf->st_size =3D attr->size;
+    stbuf->st_atime =3D attr->atime;
+    stbuf->st_mtime =3D attr->mtime;
+    stbuf->st_ctime =3D attr->ctime;
+    ST_ATIM_NSEC_SET(stbuf, attr->atimensec);
+    ST_MTIM_NSEC_SET(stbuf, attr->mtimensec);
+    ST_CTIM_NSEC_SET(stbuf, attr->ctimensec);
 }
=20
-static=09size_t iov_length(const struct iovec *iov, size_t count)
+static size_t iov_length(const struct iovec *iov, size_t count)
 {
-=09size_t seg;
-=09size_t ret =3D 0;
+    size_t seg;
+    size_t ret =3D 0;
=20
-=09for (seg =3D 0; seg < count; seg++)
-=09=09ret +=3D iov[seg].iov_len;
-=09return ret;
+    for (seg =3D 0; seg < count; seg++) {
+        ret +=3D iov[seg].iov_len;
+    }
+    return ret;
 }
=20
 static void list_init_req(struct fuse_req *req)
 {
-=09req->next =3D req;
-=09req->prev =3D req;
+    req->next =3D req;
+    req->prev =3D req;
 }
=20
 static void list_del_req(struct fuse_req *req)
 {
-=09struct fuse_req *prev =3D req->prev;
-=09struct fuse_req *next =3D req->next;
-=09prev->next =3D next;
-=09next->prev =3D prev;
+    struct fuse_req *prev =3D req->prev;
+    struct fuse_req *next =3D req->next;
+    prev->next =3D next;
+    next->prev =3D prev;
 }
=20
 static void list_add_req(struct fuse_req *req, struct fuse_req *next)
 {
-=09struct fuse_req *prev =3D next->prev;
-=09req->next =3D next;
-=09req->prev =3D prev;
-=09prev->next =3D req;
-=09next->prev =3D req;
+    struct fuse_req *prev =3D next->prev;
+    req->next =3D next;
+    req->prev =3D prev;
+    prev->next =3D req;
+    next->prev =3D req;
 }
=20
 static void destroy_req(fuse_req_t req)
 {
-=09pthread_mutex_destroy(&req->lock);
-=09free(req);
+    pthread_mutex_destroy(&req->lock);
+    free(req);
 }
=20
 void fuse_free_req(fuse_req_t req)
 {
-=09int ctr;
-=09struct fuse_session *se =3D req->se;
+    int ctr;
+    struct fuse_session *se =3D req->se;
=20
-=09pthread_mutex_lock(&se->lock);
-=09req->u.ni.func =3D NULL;
-=09req->u.ni.data =3D NULL;
-=09list_del_req(req);
-=09ctr =3D --req->ctr;
-=09fuse_chan_put(req->ch);
-=09req->ch =3D NULL;
-=09pthread_mutex_unlock(&se->lock);
-=09if (!ctr)
-=09=09destroy_req(req);
+    pthread_mutex_lock(&se->lock);
+    req->u.ni.func =3D NULL;
+    req->u.ni.data =3D NULL;
+    list_del_req(req);
+    ctr =3D --req->ctr;
+    fuse_chan_put(req->ch);
+    req->ch =3D NULL;
+    pthread_mutex_unlock(&se->lock);
+    if (!ctr) {
+        destroy_req(req);
+    }
 }
=20
 static struct fuse_req *fuse_ll_alloc_req(struct fuse_session *se)
 {
-=09struct fuse_req *req;
+    struct fuse_req *req;
=20
-=09req =3D (struct fuse_req *) calloc(1, sizeof(struct fuse_req));
-=09if (req =3D=3D NULL) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate request\n");
-=09} else {
-=09=09req->se =3D se;
-=09=09req->ctr =3D 1;
-=09=09list_init_req(req);
-=09=09fuse_mutex_init(&req->lock);
-=09}
+    req =3D (struct fuse_req *)calloc(1, sizeof(struct fuse_req));
+    if (req =3D=3D NULL) {
+        fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate request\n");
+    } else {
+        req->se =3D se;
+        req->ctr =3D 1;
+        list_init_req(req);
+        fuse_mutex_init(&req->lock);
+    }
=20
-=09return req;
+    return req;
 }
=20
 /* Send data. If *ch* is NULL, send via session master fd */
 static int fuse_send_msg(struct fuse_session *se, struct fuse_chan *ch,
-=09=09=09 struct iovec *iov, int count)
+                         struct iovec *iov, int count)
 {
-=09struct fuse_out_header *out =3D iov[0].iov_base;
+    struct fuse_out_header *out =3D iov[0].iov_base;
=20
-=09out->len =3D iov_length(iov, count);
-=09if (se->debug) {
-=09=09if (out->unique =3D=3D 0) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n",
-=09=09=09=09out->error, out->len);
-=09=09} else if (out->error) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09=09"   unique: %llu, error: %i (%s), outsize: %i\n",
-=09=09=09=09(unsigned long long) out->unique, out->error,
-=09=09=09=09strerror(-out->error), out->len);
-=09=09} else {
-=09=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09=09"   unique: %llu, success, outsize: %i\n",
-=09=09=09=09(unsigned long long) out->unique, out->len);
-=09=09}
-=09}
+    out->len =3D iov_length(iov, count);
+    if (se->debug) {
+        if (out->unique =3D=3D 0) {
+            fuse_log(FUSE_LOG_DEBUG, "NOTIFY: code=3D%d length=3D%u\n", ou=
t->error,
+                     out->len);
+        } else if (out->error) {
+            fuse_log(FUSE_LOG_DEBUG,
+                     "   unique: %llu, error: %i (%s), outsize: %i\n",
+                     (unsigned long long)out->unique, out->error,
+                     strerror(-out->error), out->len);
+        } else {
+            fuse_log(FUSE_LOG_DEBUG, "   unique: %llu, success, outsize: %=
i\n",
+                     (unsigned long long)out->unique, out->len);
+        }
+    }
=20
-=09abort(); /* virtio should have taken it before here */
-=09return 0;
+    abort(); /* virtio should have taken it before here */
+    return 0;
 }
=20
=20
 int fuse_send_reply_iov_nofree(fuse_req_t req, int error, struct iovec *io=
v,
-=09=09=09       int count)
+                               int count)
 {
-=09struct fuse_out_header out;
+    struct fuse_out_header out;
=20
-=09if (error <=3D -1000 || error > 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n",=09error);
-=09=09error =3D -ERANGE;
-=09}
+    if (error <=3D -1000 || error > 0) {
+        fuse_log(FUSE_LOG_ERR, "fuse: bad error value: %i\n", error);
+        error =3D -ERANGE;
+    }
=20
-=09out.unique =3D req->unique;
-=09out.error =3D error;
+    out.unique =3D req->unique;
+    out.error =3D error;
=20
-=09iov[0].iov_base =3D &out;
-=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
+    iov[0].iov_base =3D &out;
+    iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
-=09return fuse_send_msg(req->se, req->ch, iov, count);
+    return fuse_send_msg(req->se, req->ch, iov, count);
 }
=20
 static int send_reply_iov(fuse_req_t req, int error, struct iovec *iov,
-=09=09=09  int count)
+                          int count)
 {
-=09int res;
+    int res;
=20
-=09res =3D fuse_send_reply_iov_nofree(req, error, iov, count);
-=09fuse_free_req(req);
-=09return res;
+    res =3D fuse_send_reply_iov_nofree(req, error, iov, count);
+    fuse_free_req(req);
+    return res;
 }
=20
 static int send_reply(fuse_req_t req, int error, const void *arg,
-=09=09      size_t argsize)
+                      size_t argsize)
 {
-=09struct iovec iov[2];
-=09int count =3D 1;
-=09if (argsize) {
-=09=09iov[1].iov_base =3D (void *) arg;
-=09=09iov[1].iov_len =3D argsize;
-=09=09count++;
-=09}
-=09return send_reply_iov(req, error, iov, count);
+    struct iovec iov[2];
+    int count =3D 1;
+    if (argsize) {
+        iov[1].iov_base =3D (void *)arg;
+        iov[1].iov_len =3D argsize;
+        count++;
+    }
+    return send_reply_iov(req, error, iov, count);
 }
=20
 int fuse_reply_iov(fuse_req_t req, const struct iovec *iov, int count)
 {
-=09int res;
-=09struct iovec *padded_iov;
+    int res;
+    struct iovec *padded_iov;
=20
-=09padded_iov =3D malloc((count + 1) * sizeof(struct iovec));
-=09if (padded_iov =3D=3D NULL)
-=09=09return fuse_reply_err(req, ENOMEM);
+    padded_iov =3D malloc((count + 1) * sizeof(struct iovec));
+    if (padded_iov =3D=3D NULL) {
+        return fuse_reply_err(req, ENOMEM);
+    }
=20
-=09memcpy(padded_iov + 1, iov, count * sizeof(struct iovec));
-=09count++;
+    memcpy(padded_iov + 1, iov, count * sizeof(struct iovec));
+    count++;
=20
-=09res =3D send_reply_iov(req, 0, padded_iov, count);
-=09free(padded_iov);
+    res =3D send_reply_iov(req, 0, padded_iov, count);
+    free(padded_iov);
=20
-=09return res;
+    return res;
 }
=20
=20
-/* `buf` is allowed to be empty so that the proper size may be
-   allocated by the caller */
+/*
+ * 'buf` is allowed to be empty so that the proper size may be
+ * allocated by the caller
+ */
 size_t fuse_add_direntry(fuse_req_t req, char *buf, size_t bufsize,
-=09=09=09 const char *name, const struct stat *stbuf, off_t off)
+                         const char *name, const struct stat *stbuf, off_t=
 off)
 {
-=09(void)req;
-=09size_t namelen;
-=09size_t entlen;
-=09size_t entlen_padded;
-=09struct fuse_dirent *dirent;
+    (void)req;
+    size_t namelen;
+    size_t entlen;
+    size_t entlen_padded;
+    struct fuse_dirent *dirent;
=20
-=09namelen =3D strlen(name);
-=09entlen =3D FUSE_NAME_OFFSET + namelen;
-=09entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
+    namelen =3D strlen(name);
+    entlen =3D FUSE_NAME_OFFSET + namelen;
+    entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
=20
-=09if ((buf =3D=3D NULL) || (entlen_padded > bufsize))
-=09  return entlen_padded;
+    if ((buf =3D=3D NULL) || (entlen_padded > bufsize)) {
+        return entlen_padded;
+    }
=20
-=09dirent =3D (struct fuse_dirent*) buf;
-=09dirent->ino =3D stbuf->st_ino;
-=09dirent->off =3D off;
-=09dirent->namelen =3D namelen;
-=09dirent->type =3D (stbuf->st_mode & S_IFMT) >> 12;
-=09memcpy(dirent->name, name, namelen);
-=09memset(dirent->name + namelen, 0, entlen_padded - entlen);
+    dirent =3D (struct fuse_dirent *)buf;
+    dirent->ino =3D stbuf->st_ino;
+    dirent->off =3D off;
+    dirent->namelen =3D namelen;
+    dirent->type =3D (stbuf->st_mode & S_IFMT) >> 12;
+    memcpy(dirent->name, name, namelen);
+    memset(dirent->name + namelen, 0, entlen_padded - entlen);
=20
-=09return entlen_padded;
+    return entlen_padded;
 }
=20
 static void convert_statfs(const struct statvfs *stbuf,
-=09=09=09   struct fuse_kstatfs *kstatfs)
+                           struct fuse_kstatfs *kstatfs)
 {
-=09kstatfs->bsize=09 =3D stbuf->f_bsize;
-=09kstatfs->frsize=09 =3D stbuf->f_frsize;
-=09kstatfs->blocks=09 =3D stbuf->f_blocks;
-=09kstatfs->bfree=09 =3D stbuf->f_bfree;
-=09kstatfs->bavail=09 =3D stbuf->f_bavail;
-=09kstatfs->files=09 =3D stbuf->f_files;
-=09kstatfs->ffree=09 =3D stbuf->f_ffree;
-=09kstatfs->namelen =3D stbuf->f_namemax;
+    kstatfs->bsize =3D stbuf->f_bsize;
+    kstatfs->frsize =3D stbuf->f_frsize;
+    kstatfs->blocks =3D stbuf->f_blocks;
+    kstatfs->bfree =3D stbuf->f_bfree;
+    kstatfs->bavail =3D stbuf->f_bavail;
+    kstatfs->files =3D stbuf->f_files;
+    kstatfs->ffree =3D stbuf->f_ffree;
+    kstatfs->namelen =3D stbuf->f_namemax;
 }
=20
 static int send_reply_ok(fuse_req_t req, const void *arg, size_t argsize)
 {
-=09return send_reply(req, 0, arg, argsize);
+    return send_reply(req, 0, arg, argsize);
 }
=20
 int fuse_reply_err(fuse_req_t req, int err)
 {
-=09return send_reply(req, -err, NULL, 0);
+    return send_reply(req, -err, NULL, 0);
 }
=20
 void fuse_reply_none(fuse_req_t req)
 {
-=09fuse_free_req(req);
+    fuse_free_req(req);
 }
=20
 static unsigned long calc_timeout_sec(double t)
 {
-=09if (t > (double) ULONG_MAX)
-=09=09return ULONG_MAX;
-=09else if (t < 0.0)
-=09=09return 0;
-=09else
-=09=09return (unsigned long) t;
+    if (t > (double)ULONG_MAX) {
+        return ULONG_MAX;
+    } else if (t < 0.0) {
+        return 0;
+    } else {
+        return (unsigned long)t;
+    }
 }
=20
 static unsigned int calc_timeout_nsec(double t)
 {
-=09double f =3D t - (double) calc_timeout_sec(t);
-=09if (f < 0.0)
-=09=09return 0;
-=09else if (f >=3D 0.999999999)
-=09=09return 999999999;
-=09else
-=09=09return (unsigned int) (f * 1.0e9);
+    double f =3D t - (double)calc_timeout_sec(t);
+    if (f < 0.0) {
+        return 0;
+    } else if (f >=3D 0.999999999) {
+        return 999999999;
+    } else {
+        return (unsigned int)(f * 1.0e9);
+    }
 }
=20
 static void fill_entry(struct fuse_entry_out *arg,
-=09=09       const struct fuse_entry_param *e)
+                       const struct fuse_entry_param *e)
 {
-=09arg->nodeid =3D e->ino;
-=09arg->generation =3D e->generation;
-=09arg->entry_valid =3D calc_timeout_sec(e->entry_timeout);
-=09arg->entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout);
-=09arg->attr_valid =3D calc_timeout_sec(e->attr_timeout);
-=09arg->attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout);
-=09convert_stat(&e->attr, &arg->attr);
+    arg->nodeid =3D e->ino;
+    arg->generation =3D e->generation;
+    arg->entry_valid =3D calc_timeout_sec(e->entry_timeout);
+    arg->entry_valid_nsec =3D calc_timeout_nsec(e->entry_timeout);
+    arg->attr_valid =3D calc_timeout_sec(e->attr_timeout);
+    arg->attr_valid_nsec =3D calc_timeout_nsec(e->attr_timeout);
+    convert_stat(&e->attr, &arg->attr);
 }
=20
-/* `buf` is allowed to be empty so that the proper size may be
-   allocated by the caller */
+/*
+ * `buf` is allowed to be empty so that the proper size may be
+ * allocated by the caller
+ */
 size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
-=09=09=09      const char *name,
-=09=09=09      const struct fuse_entry_param *e, off_t off)
-{
-=09(void)req;
-=09size_t namelen;
-=09size_t entlen;
-=09size_t entlen_padded;
-
-=09namelen =3D strlen(name);
-=09entlen =3D FUSE_NAME_OFFSET_DIRENTPLUS + namelen;
-=09entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
-=09if ((buf =3D=3D NULL) || (entlen_padded > bufsize))
-=09  return entlen_padded;
-
-=09struct fuse_direntplus *dp =3D (struct fuse_direntplus *) buf;
-=09memset(&dp->entry_out, 0, sizeof(dp->entry_out));
-=09fill_entry(&dp->entry_out, e);
-
-=09struct fuse_dirent *dirent =3D &dp->dirent;
-=09dirent->ino =3D e->attr.st_ino;
-=09dirent->off =3D off;
-=09dirent->namelen =3D namelen;
-=09dirent->type =3D (e->attr.st_mode & S_IFMT) >> 12;
-=09memcpy(dirent->name, name, namelen);
-=09memset(dirent->name + namelen, 0, entlen_padded - entlen);
-
-=09return entlen_padded;
-}
-
-static void fill_open(struct fuse_open_out *arg,
-=09=09      const struct fuse_file_info *f)
-{
-=09arg->fh =3D f->fh;
-=09if (f->direct_io)
-=09=09arg->open_flags |=3D FOPEN_DIRECT_IO;
-=09if (f->keep_cache)
-=09=09arg->open_flags |=3D FOPEN_KEEP_CACHE;
-=09if (f->cache_readdir)
-=09=09arg->open_flags |=3D FOPEN_CACHE_DIR;
-=09if (f->nonseekable)
-=09=09arg->open_flags |=3D FOPEN_NONSEEKABLE;
+                              const char *name,
+                              const struct fuse_entry_param *e, off_t off)
+{
+    (void)req;
+    size_t namelen;
+    size_t entlen;
+    size_t entlen_padded;
+
+    namelen =3D strlen(name);
+    entlen =3D FUSE_NAME_OFFSET_DIRENTPLUS + namelen;
+    entlen_padded =3D FUSE_DIRENT_ALIGN(entlen);
+    if ((buf =3D=3D NULL) || (entlen_padded > bufsize)) {
+        return entlen_padded;
+    }
+
+    struct fuse_direntplus *dp =3D (struct fuse_direntplus *)buf;
+    memset(&dp->entry_out, 0, sizeof(dp->entry_out));
+    fill_entry(&dp->entry_out, e);
+
+    struct fuse_dirent *dirent =3D &dp->dirent;
+    dirent->ino =3D e->attr.st_ino;
+    dirent->off =3D off;
+    dirent->namelen =3D namelen;
+    dirent->type =3D (e->attr.st_mode & S_IFMT) >> 12;
+    memcpy(dirent->name, name, namelen);
+    memset(dirent->name + namelen, 0, entlen_padded - entlen);
+
+    return entlen_padded;
+}
+
+static void fill_open(struct fuse_open_out *arg, const struct fuse_file_in=
fo *f)
+{
+    arg->fh =3D f->fh;
+    if (f->direct_io) {
+        arg->open_flags |=3D FOPEN_DIRECT_IO;
+    }
+    if (f->keep_cache) {
+        arg->open_flags |=3D FOPEN_KEEP_CACHE;
+    }
+    if (f->cache_readdir) {
+        arg->open_flags |=3D FOPEN_CACHE_DIR;
+    }
+    if (f->nonseekable) {
+        arg->open_flags |=3D FOPEN_NONSEEKABLE;
+    }
 }
=20
 int fuse_reply_entry(fuse_req_t req, const struct fuse_entry_param *e)
 {
-=09struct fuse_entry_out arg;
-=09size_t size =3D req->se->conn.proto_minor < 9 ?
-=09=09FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(arg);
+    struct fuse_entry_out arg;
+    size_t size =3D req->se->conn.proto_minor < 9 ? FUSE_COMPAT_ENTRY_OUT_=
SIZE :
+                                                  sizeof(arg);
=20
-=09/* before ABI 7.4 e->ino =3D=3D 0 was invalid, only ENOENT meant
-=09   negative entry */
-=09if (!e->ino && req->se->conn.proto_minor < 4)
-=09=09return fuse_reply_err(req, ENOENT);
+    /*
+     * before ABI 7.4 e->ino =3D=3D 0 was invalid, only ENOENT meant
+     * negative entry
+     */
+    if (!e->ino && req->se->conn.proto_minor < 4) {
+        return fuse_reply_err(req, ENOENT);
+    }
=20
-=09memset(&arg, 0, sizeof(arg));
-=09fill_entry(&arg, e);
-=09return send_reply_ok(req, &arg, size);
+    memset(&arg, 0, sizeof(arg));
+    fill_entry(&arg, e);
+    return send_reply_ok(req, &arg, size);
 }
=20
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
-=09=09      const struct fuse_file_info *f)
+                      const struct fuse_file_info *f)
 {
-=09char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)];
-=09size_t entrysize =3D req->se->conn.proto_minor < 9 ?
-=09=09FUSE_COMPAT_ENTRY_OUT_SIZE : sizeof(struct fuse_entry_out);
-=09struct fuse_entry_out *earg =3D (struct fuse_entry_out *) buf;
-=09struct fuse_open_out *oarg =3D (struct fuse_open_out *) (buf + entrysiz=
e);
+    char buf[sizeof(struct fuse_entry_out) + sizeof(struct fuse_open_out)]=
;
+    size_t entrysize =3D req->se->conn.proto_minor < 9 ?
+                           FUSE_COMPAT_ENTRY_OUT_SIZE :
+                           sizeof(struct fuse_entry_out);
+    struct fuse_entry_out *earg =3D (struct fuse_entry_out *)buf;
+    struct fuse_open_out *oarg =3D (struct fuse_open_out *)(buf + entrysiz=
e);
=20
-=09memset(buf, 0, sizeof(buf));
-=09fill_entry(earg, e);
-=09fill_open(oarg, f);
-=09return send_reply_ok(req, buf,
-=09=09=09     entrysize + sizeof(struct fuse_open_out));
+    memset(buf, 0, sizeof(buf));
+    fill_entry(earg, e);
+    fill_open(oarg, f);
+    return send_reply_ok(req, buf, entrysize + sizeof(struct fuse_open_out=
));
 }
=20
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-=09=09    double attr_timeout)
+                    double attr_timeout)
 {
-=09struct fuse_attr_out arg;
-=09size_t size =3D req->se->conn.proto_minor < 9 ?
-=09=09FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
+    struct fuse_attr_out arg;
+    size_t size =3D
+        req->se->conn.proto_minor < 9 ? FUSE_COMPAT_ATTR_OUT_SIZE : sizeof=
(arg);
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.attr_valid =3D calc_timeout_sec(attr_timeout);
-=09arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
-=09convert_stat(attr, &arg.attr);
+    memset(&arg, 0, sizeof(arg));
+    arg.attr_valid =3D calc_timeout_sec(attr_timeout);
+    arg.attr_valid_nsec =3D calc_timeout_nsec(attr_timeout);
+    convert_stat(attr, &arg.attr);
=20
-=09return send_reply_ok(req, &arg, size);
+    return send_reply_ok(req, &arg, size);
 }
=20
 int fuse_reply_readlink(fuse_req_t req, const char *linkname)
 {
-=09return send_reply_ok(req, linkname, strlen(linkname));
+    return send_reply_ok(req, linkname, strlen(linkname));
 }
=20
 int fuse_reply_open(fuse_req_t req, const struct fuse_file_info *f)
 {
-=09struct fuse_open_out arg;
+    struct fuse_open_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09fill_open(&arg, f);
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    memset(&arg, 0, sizeof(arg));
+    fill_open(&arg, f);
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 int fuse_reply_write(fuse_req_t req, size_t count)
 {
-=09struct fuse_write_out arg;
+    struct fuse_write_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.size =3D count;
+    memset(&arg, 0, sizeof(arg));
+    arg.size =3D count;
=20
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 int fuse_reply_buf(fuse_req_t req, const char *buf, size_t size)
 {
-=09return send_reply_ok(req, buf, size);
+    return send_reply_ok(req, buf, size);
 }
=20
 static int fuse_send_data_iov_fallback(struct fuse_session *se,
-=09=09=09=09       struct fuse_chan *ch,
-=09=09=09=09       struct iovec *iov, int iov_count,
-=09=09=09=09       struct fuse_bufvec *buf,
-=09=09=09=09       size_t len)
+                                       struct fuse_chan *ch, struct iovec =
*iov,
+                                       int iov_count, struct fuse_bufvec *=
buf,
+                                       size_t len)
 {
-=09/* Optimize common case */
-=09if (buf->count =3D=3D 1 && buf->idx =3D=3D 0 && buf->off =3D=3D 0 &&
-=09    !(buf->buf[0].flags & FUSE_BUF_IS_FD)) {
-=09=09/* FIXME: also avoid memory copy if there are multiple buffers
-=09=09   but none of them contain an fd */
+    /* Optimize common case */
+    if (buf->count =3D=3D 1 && buf->idx =3D=3D 0 && buf->off =3D=3D 0 &&
+        !(buf->buf[0].flags & FUSE_BUF_IS_FD)) {
+        /*
+         * FIXME: also avoid memory copy if there are multiple buffers
+         * but none of them contain an fd
+         */
=20
-=09=09iov[iov_count].iov_base =3D buf->buf[0].mem;
-=09=09iov[iov_count].iov_len =3D len;
-=09=09iov_count++;
-=09=09return fuse_send_msg(se, ch, iov, iov_count);
-=09}
+        iov[iov_count].iov_base =3D buf->buf[0].mem;
+        iov[iov_count].iov_len =3D len;
+        iov_count++;
+        return fuse_send_msg(se, ch, iov, iov_count);
+    }
=20
-=09abort(); /* Will have taken vhost path */
-=09return 0;
+    abort(); /* Will have taken vhost path */
+    return 0;
 }
=20
 static int fuse_send_data_iov(struct fuse_session *se, struct fuse_chan *c=
h,
-=09=09=09       struct iovec *iov, int iov_count,
-=09=09=09       struct fuse_bufvec *buf, unsigned int flags)
+                              struct iovec *iov, int iov_count,
+                              struct fuse_bufvec *buf, unsigned int flags)
 {
-=09size_t len =3D fuse_buf_size(buf);
-=09(void) flags;
+    size_t len =3D fuse_buf_size(buf);
+    (void)flags;
=20
-=09return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len);
+    return fuse_send_data_iov_fallback(se, ch, iov, iov_count, buf, len);
 }
=20
 int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
-=09=09    enum fuse_buf_copy_flags flags)
+                    enum fuse_buf_copy_flags flags)
 {
-=09struct iovec iov[2];
-=09struct fuse_out_header out;
-=09int res;
+    struct iovec iov[2];
+    struct fuse_out_header out;
+    int res;
=20
-=09iov[0].iov_base =3D &out;
-=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
+    iov[0].iov_base =3D &out;
+    iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
-=09out.unique =3D req->unique;
-=09out.error =3D 0;
+    out.unique =3D req->unique;
+    out.error =3D 0;
=20
-=09res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv, flags);
-=09if (res <=3D 0) {
-=09=09fuse_free_req(req);
-=09=09return res;
-=09} else {
-=09=09return fuse_reply_err(req, res);
-=09}
+    res =3D fuse_send_data_iov(req->se, req->ch, iov, 1, bufv, flags);
+    if (res <=3D 0) {
+        fuse_free_req(req);
+        return res;
+    } else {
+        return fuse_reply_err(req, res);
+    }
 }
=20
 int fuse_reply_statfs(fuse_req_t req, const struct statvfs *stbuf)
 {
-=09struct fuse_statfs_out arg;
-=09size_t size =3D req->se->conn.proto_minor < 4 ?
-=09=09FUSE_COMPAT_STATFS_SIZE : sizeof(arg);
+    struct fuse_statfs_out arg;
+    size_t size =3D
+        req->se->conn.proto_minor < 4 ? FUSE_COMPAT_STATFS_SIZE : sizeof(a=
rg);
=20
-=09memset(&arg, 0, sizeof(arg));
-=09convert_statfs(stbuf, &arg.st);
+    memset(&arg, 0, sizeof(arg));
+    convert_statfs(stbuf, &arg.st);
=20
-=09return send_reply_ok(req, &arg, size);
+    return send_reply_ok(req, &arg, size);
 }
=20
 int fuse_reply_xattr(fuse_req_t req, size_t count)
 {
-=09struct fuse_getxattr_out arg;
+    struct fuse_getxattr_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.size =3D count;
+    memset(&arg, 0, sizeof(arg));
+    arg.size =3D count;
=20
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 int fuse_reply_lock(fuse_req_t req, const struct flock *lock)
 {
-=09struct fuse_lk_out arg;
+    struct fuse_lk_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.lk.type =3D lock->l_type;
-=09if (lock->l_type !=3D F_UNLCK) {
-=09=09arg.lk.start =3D lock->l_start;
-=09=09if (lock->l_len =3D=3D 0)
-=09=09=09arg.lk.end =3D OFFSET_MAX;
-=09=09else
-=09=09=09arg.lk.end =3D lock->l_start + lock->l_len - 1;
-=09}
-=09arg.lk.pid =3D lock->l_pid;
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    memset(&arg, 0, sizeof(arg));
+    arg.lk.type =3D lock->l_type;
+    if (lock->l_type !=3D F_UNLCK) {
+        arg.lk.start =3D lock->l_start;
+        if (lock->l_len =3D=3D 0) {
+            arg.lk.end =3D OFFSET_MAX;
+        } else {
+            arg.lk.end =3D lock->l_start + lock->l_len - 1;
+        }
+    }
+    arg.lk.pid =3D lock->l_pid;
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 int fuse_reply_bmap(fuse_req_t req, uint64_t idx)
 {
-=09struct fuse_bmap_out arg;
+    struct fuse_bmap_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.block =3D idx;
+    memset(&arg, 0, sizeof(arg));
+    arg.block =3D idx;
=20
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 static struct fuse_ioctl_iovec *fuse_ioctl_iovec_copy(const struct iovec *=
iov,
-=09=09=09=09=09=09      size_t count)
-{
-=09struct fuse_ioctl_iovec *fiov;
-=09size_t i;
-
-=09fiov =3D malloc(sizeof(fiov[0]) * count);
-=09if (!fiov)
-=09=09return NULL;
-
-=09for (i =3D 0; i < count; i++) {
-=09=09fiov[i].base =3D (uintptr_t) iov[i].iov_base;
-=09=09fiov[i].len =3D iov[i].iov_len;
-=09}
-
-=09return fiov;
-}
-
-int fuse_reply_ioctl_retry(fuse_req_t req,
-=09=09=09   const struct iovec *in_iov, size_t in_count,
-=09=09=09   const struct iovec *out_iov, size_t out_count)
-{
-=09struct fuse_ioctl_out arg;
-=09struct fuse_ioctl_iovec *in_fiov =3D NULL;
-=09struct fuse_ioctl_iovec *out_fiov =3D NULL;
-=09struct iovec iov[4];
-=09size_t count =3D 1;
-=09int res;
-
-=09memset(&arg, 0, sizeof(arg));
-=09arg.flags |=3D FUSE_IOCTL_RETRY;
-=09arg.in_iovs =3D in_count;
-=09arg.out_iovs =3D out_count;
-=09iov[count].iov_base =3D &arg;
-=09iov[count].iov_len =3D sizeof(arg);
-=09count++;
-
-=09if (req->se->conn.proto_minor < 16) {
-=09=09if (in_count) {
-=09=09=09iov[count].iov_base =3D (void *)in_iov;
-=09=09=09iov[count].iov_len =3D sizeof(in_iov[0]) * in_count;
-=09=09=09count++;
-=09=09}
-
-=09=09if (out_count) {
-=09=09=09iov[count].iov_base =3D (void *)out_iov;
-=09=09=09iov[count].iov_len =3D sizeof(out_iov[0]) * out_count;
-=09=09=09count++;
-=09=09}
-=09} else {
-=09=09/* Can't handle non-compat 64bit ioctls on 32bit */
-=09=09if (sizeof(void *) =3D=3D 4 && req->ioctl_64bit) {
-=09=09=09res =3D fuse_reply_err(req, EINVAL);
-=09=09=09goto out;
-=09=09}
-
-=09=09if (in_count) {
-=09=09=09in_fiov =3D fuse_ioctl_iovec_copy(in_iov, in_count);
-=09=09=09if (!in_fiov)
-=09=09=09=09goto enomem;
-
-=09=09=09iov[count].iov_base =3D (void *)in_fiov;
-=09=09=09iov[count].iov_len =3D sizeof(in_fiov[0]) * in_count;
-=09=09=09count++;
-=09=09}
-=09=09if (out_count) {
-=09=09=09out_fiov =3D fuse_ioctl_iovec_copy(out_iov, out_count);
-=09=09=09if (!out_fiov)
-=09=09=09=09goto enomem;
-
-=09=09=09iov[count].iov_base =3D (void *)out_fiov;
-=09=09=09iov[count].iov_len =3D sizeof(out_fiov[0]) * out_count;
-=09=09=09count++;
-=09=09}
-=09}
-
-=09res =3D send_reply_iov(req, 0, iov, count);
+                                                      size_t count)
+{
+    struct fuse_ioctl_iovec *fiov;
+    size_t i;
+
+    fiov =3D malloc(sizeof(fiov[0]) * count);
+    if (!fiov) {
+        return NULL;
+    }
+
+    for (i =3D 0; i < count; i++) {
+        fiov[i].base =3D (uintptr_t)iov[i].iov_base;
+        fiov[i].len =3D iov[i].iov_len;
+    }
+
+    return fiov;
+}
+
+int fuse_reply_ioctl_retry(fuse_req_t req, const struct iovec *in_iov,
+                           size_t in_count, const struct iovec *out_iov,
+                           size_t out_count)
+{
+    struct fuse_ioctl_out arg;
+    struct fuse_ioctl_iovec *in_fiov =3D NULL;
+    struct fuse_ioctl_iovec *out_fiov =3D NULL;
+    struct iovec iov[4];
+    size_t count =3D 1;
+    int res;
+
+    memset(&arg, 0, sizeof(arg));
+    arg.flags |=3D FUSE_IOCTL_RETRY;
+    arg.in_iovs =3D in_count;
+    arg.out_iovs =3D out_count;
+    iov[count].iov_base =3D &arg;
+    iov[count].iov_len =3D sizeof(arg);
+    count++;
+
+    if (req->se->conn.proto_minor < 16) {
+        if (in_count) {
+            iov[count].iov_base =3D (void *)in_iov;
+            iov[count].iov_len =3D sizeof(in_iov[0]) * in_count;
+            count++;
+        }
+
+        if (out_count) {
+            iov[count].iov_base =3D (void *)out_iov;
+            iov[count].iov_len =3D sizeof(out_iov[0]) * out_count;
+            count++;
+        }
+    } else {
+        /* Can't handle non-compat 64bit ioctls on 32bit */
+        if (sizeof(void *) =3D=3D 4 && req->ioctl_64bit) {
+            res =3D fuse_reply_err(req, EINVAL);
+            goto out;
+        }
+
+        if (in_count) {
+            in_fiov =3D fuse_ioctl_iovec_copy(in_iov, in_count);
+            if (!in_fiov) {
+                goto enomem;
+            }
+
+            iov[count].iov_base =3D (void *)in_fiov;
+            iov[count].iov_len =3D sizeof(in_fiov[0]) * in_count;
+            count++;
+        }
+        if (out_count) {
+            out_fiov =3D fuse_ioctl_iovec_copy(out_iov, out_count);
+            if (!out_fiov) {
+                goto enomem;
+            }
+
+            iov[count].iov_base =3D (void *)out_fiov;
+            iov[count].iov_len =3D sizeof(out_fiov[0]) * out_count;
+            count++;
+        }
+    }
+
+    res =3D send_reply_iov(req, 0, iov, count);
 out:
-=09free(in_fiov);
-=09free(out_fiov);
+    free(in_fiov);
+    free(out_fiov);
=20
-=09return res;
+    return res;
=20
 enomem:
-=09res =3D fuse_reply_err(req, ENOMEM);
-=09goto out;
+    res =3D fuse_reply_err(req, ENOMEM);
+    goto out;
 }
=20
 int fuse_reply_ioctl(fuse_req_t req, int result, const void *buf, size_t s=
ize)
 {
-=09struct fuse_ioctl_out arg;
-=09struct iovec iov[3];
-=09size_t count =3D 1;
+    struct fuse_ioctl_out arg;
+    struct iovec iov[3];
+    size_t count =3D 1;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.result =3D result;
-=09iov[count].iov_base =3D &arg;
-=09iov[count].iov_len =3D sizeof(arg);
-=09count++;
+    memset(&arg, 0, sizeof(arg));
+    arg.result =3D result;
+    iov[count].iov_base =3D &arg;
+    iov[count].iov_len =3D sizeof(arg);
+    count++;
=20
-=09if (size) {
-=09=09iov[count].iov_base =3D (char *) buf;
-=09=09iov[count].iov_len =3D size;
-=09=09count++;
-=09}
+    if (size) {
+        iov[count].iov_base =3D (char *)buf;
+        iov[count].iov_len =3D size;
+        count++;
+    }
=20
-=09return send_reply_iov(req, 0, iov, count);
+    return send_reply_iov(req, 0, iov, count);
 }
=20
 int fuse_reply_ioctl_iov(fuse_req_t req, int result, const struct iovec *i=
ov,
-=09=09=09 int count)
+                         int count)
 {
-=09struct iovec *padded_iov;
-=09struct fuse_ioctl_out arg;
-=09int res;
+    struct iovec *padded_iov;
+    struct fuse_ioctl_out arg;
+    int res;
=20
-=09padded_iov =3D malloc((count + 2) * sizeof(struct iovec));
-=09if (padded_iov =3D=3D NULL)
-=09=09return fuse_reply_err(req, ENOMEM);
+    padded_iov =3D malloc((count + 2) * sizeof(struct iovec));
+    if (padded_iov =3D=3D NULL) {
+        return fuse_reply_err(req, ENOMEM);
+    }
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.result =3D result;
-=09padded_iov[1].iov_base =3D &arg;
-=09padded_iov[1].iov_len =3D sizeof(arg);
+    memset(&arg, 0, sizeof(arg));
+    arg.result =3D result;
+    padded_iov[1].iov_base =3D &arg;
+    padded_iov[1].iov_len =3D sizeof(arg);
=20
-=09memcpy(&padded_iov[2], iov, count * sizeof(struct iovec));
+    memcpy(&padded_iov[2], iov, count * sizeof(struct iovec));
=20
-=09res =3D send_reply_iov(req, 0, padded_iov, count + 2);
-=09free(padded_iov);
+    res =3D send_reply_iov(req, 0, padded_iov, count + 2);
+    free(padded_iov);
=20
-=09return res;
+    return res;
 }
=20
 int fuse_reply_poll(fuse_req_t req, unsigned revents)
 {
-=09struct fuse_poll_out arg;
+    struct fuse_poll_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.revents =3D revents;
+    memset(&arg, 0, sizeof(arg));
+    arg.revents =3D revents;
=20
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 int fuse_reply_lseek(fuse_req_t req, off_t off)
 {
-=09struct fuse_lseek_out arg;
+    struct fuse_lseek_out arg;
=20
-=09memset(&arg, 0, sizeof(arg));
-=09arg.offset =3D off;
+    memset(&arg, 0, sizeof(arg));
+    arg.offset =3D off;
=20
-=09return send_reply_ok(req, &arg, sizeof(arg));
+    return send_reply_ok(req, &arg, sizeof(arg));
 }
=20
 static void do_lookup(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09char *name =3D (char *) inarg;
+    char *name =3D (char *)inarg;
=20
-=09if (req->se->op.lookup)
-=09=09req->se->op.lookup(req, nodeid, name);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.lookup) {
+        req->se->op.lookup(req, nodeid, name);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_forget(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09struct fuse_forget_in *arg =3D (struct fuse_forget_in *) inarg;
+    struct fuse_forget_in *arg =3D (struct fuse_forget_in *)inarg;
=20
-=09if (req->se->op.forget)
-=09=09req->se->op.forget(req, nodeid, arg->nlookup);
-=09else
-=09=09fuse_reply_none(req);
+    if (req->se->op.forget) {
+        req->se->op.forget(req, nodeid, arg->nlookup);
+    } else {
+        fuse_reply_none(req);
+    }
 }
=20
 static void do_batch_forget(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg)
+                            const void *inarg)
 {
-=09struct fuse_batch_forget_in *arg =3D (void *) inarg;
-=09struct fuse_forget_one *param =3D (void *) PARAM(arg);
-=09unsigned int i;
+    struct fuse_batch_forget_in *arg =3D (void *)inarg;
+    struct fuse_forget_one *param =3D (void *)PARAM(arg);
+    unsigned int i;
=20
-=09(void) nodeid;
+    (void)nodeid;
=20
-=09if (req->se->op.forget_multi) {
-=09=09req->se->op.forget_multi(req, arg->count,
-=09=09=09=09     (struct fuse_forget_data *) param);
-=09} else if (req->se->op.forget) {
-=09=09for (i =3D 0; i < arg->count; i++) {
-=09=09=09struct fuse_forget_one *forget =3D &param[i];
-=09=09=09struct fuse_req *dummy_req;
+    if (req->se->op.forget_multi) {
+        req->se->op.forget_multi(req, arg->count,
+                                 (struct fuse_forget_data *)param);
+    } else if (req->se->op.forget) {
+        for (i =3D 0; i < arg->count; i++) {
+            struct fuse_forget_one *forget =3D &param[i];
+            struct fuse_req *dummy_req;
=20
-=09=09=09dummy_req =3D fuse_ll_alloc_req(req->se);
-=09=09=09if (dummy_req =3D=3D NULL)
-=09=09=09=09break;
+            dummy_req =3D fuse_ll_alloc_req(req->se);
+            if (dummy_req =3D=3D NULL) {
+                break;
+            }
=20
-=09=09=09dummy_req->unique =3D req->unique;
-=09=09=09dummy_req->ctx =3D req->ctx;
-=09=09=09dummy_req->ch =3D NULL;
+            dummy_req->unique =3D req->unique;
+            dummy_req->ctx =3D req->ctx;
+            dummy_req->ch =3D NULL;
=20
-=09=09=09req->se->op.forget(dummy_req, forget->nodeid,
-=09=09=09=09=09  forget->nlookup);
-=09=09}
-=09=09fuse_reply_none(req);
-=09} else {
-=09=09fuse_reply_none(req);
-=09}
+            req->se->op.forget(dummy_req, forget->nodeid, forget->nlookup)=
;
+        }
+        fuse_reply_none(req);
+    } else {
+        fuse_reply_none(req);
+    }
 }
=20
 static void do_getattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_file_info *fip =3D NULL;
-=09struct fuse_file_info fi;
+    struct fuse_file_info *fip =3D NULL;
+    struct fuse_file_info fi;
=20
-=09if (req->se->conn.proto_minor >=3D 9) {
-=09=09struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *) inarg;
+    if (req->se->conn.proto_minor >=3D 9) {
+        struct fuse_getattr_in *arg =3D (struct fuse_getattr_in *)inarg;
=20
-=09=09if (arg->getattr_flags & FUSE_GETATTR_FH) {
-=09=09=09memset(&fi, 0, sizeof(fi));
-=09=09=09fi.fh =3D arg->fh;
-=09=09=09fip =3D &fi;
-=09=09}
-=09}
+        if (arg->getattr_flags & FUSE_GETATTR_FH) {
+            memset(&fi, 0, sizeof(fi));
+            fi.fh =3D arg->fh;
+            fip =3D &fi;
+        }
+    }
=20
-=09if (req->se->op.getattr)
-=09=09req->se->op.getattr(req, nodeid, fip);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.getattr) {
+        req->se->op.getattr(req, nodeid, fip);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_setattr(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_setattr_in *arg =3D (struct fuse_setattr_in *) inarg;
-
-=09if (req->se->op.setattr) {
-=09=09struct fuse_file_info *fi =3D NULL;
-=09=09struct fuse_file_info fi_store;
-=09=09struct stat stbuf;
-=09=09memset(&stbuf, 0, sizeof(stbuf));
-=09=09convert_attr(arg, &stbuf);
-=09=09if (arg->valid & FATTR_FH) {
-=09=09=09arg->valid &=3D ~FATTR_FH;
-=09=09=09memset(&fi_store, 0, sizeof(fi_store));
-=09=09=09fi =3D &fi_store;
-=09=09=09fi->fh =3D arg->fh;
-=09=09}
-=09=09arg->valid &=3D
-=09=09=09FUSE_SET_ATTR_MODE=09|
-=09=09=09FUSE_SET_ATTR_UID=09|
-=09=09=09FUSE_SET_ATTR_GID=09|
-=09=09=09FUSE_SET_ATTR_SIZE=09|
-=09=09=09FUSE_SET_ATTR_ATIME=09|
-=09=09=09FUSE_SET_ATTR_MTIME=09|
-=09=09=09FUSE_SET_ATTR_ATIME_NOW=09|
-=09=09=09FUSE_SET_ATTR_MTIME_NOW |
-=09=09=09FUSE_SET_ATTR_CTIME;
-
-=09=09req->se->op.setattr(req, nodeid, &stbuf, arg->valid, fi);
-=09} else
-=09=09fuse_reply_err(req, ENOSYS);
+    struct fuse_setattr_in *arg =3D (struct fuse_setattr_in *)inarg;
+
+    if (req->se->op.setattr) {
+        struct fuse_file_info *fi =3D NULL;
+        struct fuse_file_info fi_store;
+        struct stat stbuf;
+        memset(&stbuf, 0, sizeof(stbuf));
+        convert_attr(arg, &stbuf);
+        if (arg->valid & FATTR_FH) {
+            arg->valid &=3D ~FATTR_FH;
+            memset(&fi_store, 0, sizeof(fi_store));
+            fi =3D &fi_store;
+            fi->fh =3D arg->fh;
+        }
+        arg->valid &=3D FUSE_SET_ATTR_MODE | FUSE_SET_ATTR_UID |
+                      FUSE_SET_ATTR_GID | FUSE_SET_ATTR_SIZE |
+                      FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME |
+                      FUSE_SET_ATTR_ATIME_NOW | FUSE_SET_ATTR_MTIME_NOW |
+                      FUSE_SET_ATTR_CTIME;
+
+        req->se->op.setattr(req, nodeid, &stbuf, arg->valid, fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_access(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09struct fuse_access_in *arg =3D (struct fuse_access_in *) inarg;
+    struct fuse_access_in *arg =3D (struct fuse_access_in *)inarg;
=20
-=09if (req->se->op.access)
-=09=09req->se->op.access(req, nodeid, arg->mask);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.access) {
+        req->se->op.access(req, nodeid, arg->mask);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_readlink(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
 {
-=09(void) inarg;
+    (void)inarg;
=20
-=09if (req->se->op.readlink)
-=09=09req->se->op.readlink(req, nodeid);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.readlink) {
+        req->se->op.readlink(req, nodeid);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_mknod(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *) inarg;
-=09char *name =3D PARAM(arg);
+    struct fuse_mknod_in *arg =3D (struct fuse_mknod_in *)inarg;
+    char *name =3D PARAM(arg);
=20
-=09if (req->se->conn.proto_minor >=3D 12)
-=09=09req->ctx.umask =3D arg->umask;
-=09else
-=09=09name =3D (char *) inarg + FUSE_COMPAT_MKNOD_IN_SIZE;
+    if (req->se->conn.proto_minor >=3D 12) {
+        req->ctx.umask =3D arg->umask;
+    } else {
+        name =3D (char *)inarg + FUSE_COMPAT_MKNOD_IN_SIZE;
+    }
=20
-=09if (req->se->op.mknod)
-=09=09req->se->op.mknod(req, nodeid, name, arg->mode, arg->rdev);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.mknod) {
+        req->se->op.mknod(req, nodeid, name, arg->mode, arg->rdev);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_mkdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *) inarg;
+    struct fuse_mkdir_in *arg =3D (struct fuse_mkdir_in *)inarg;
=20
-=09if (req->se->conn.proto_minor >=3D 12)
-=09=09req->ctx.umask =3D arg->umask;
+    if (req->se->conn.proto_minor >=3D 12) {
+        req->ctx.umask =3D arg->umask;
+    }
=20
-=09if (req->se->op.mkdir)
-=09=09req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.mkdir) {
+        req->se->op.mkdir(req, nodeid, PARAM(arg), arg->mode);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_unlink(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09char *name =3D (char *) inarg;
+    char *name =3D (char *)inarg;
=20
-=09if (req->se->op.unlink)
-=09=09req->se->op.unlink(req, nodeid, name);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.unlink) {
+        req->se->op.unlink(req, nodeid, name);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_rmdir(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09char *name =3D (char *) inarg;
+    char *name =3D (char *)inarg;
=20
-=09if (req->se->op.rmdir)
-=09=09req->se->op.rmdir(req, nodeid, name);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.rmdir) {
+        req->se->op.rmdir(req, nodeid, name);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_symlink(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09char *name =3D (char *) inarg;
-=09char *linkname =3D ((char *) inarg) + strlen((char *) inarg) + 1;
+    char *name =3D (char *)inarg;
+    char *linkname =3D ((char *)inarg) + strlen((char *)inarg) + 1;
=20
-=09if (req->se->op.symlink)
-=09=09req->se->op.symlink(req, linkname, nodeid, name);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.symlink) {
+        req->se->op.symlink(req, linkname, nodeid, name);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_rename(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09struct fuse_rename_in *arg =3D (struct fuse_rename_in *) inarg;
-=09char *oldname =3D PARAM(arg);
-=09char *newname =3D oldname + strlen(oldname) + 1;
+    struct fuse_rename_in *arg =3D (struct fuse_rename_in *)inarg;
+    char *oldname =3D PARAM(arg);
+    char *newname =3D oldname + strlen(oldname) + 1;
=20
-=09if (req->se->op.rename)
-=09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
-=09=09=09=09  0);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.rename) {
+        req->se->op.rename(req, nodeid, oldname, arg->newdir, newname, 0);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_rename2(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_rename2_in *arg =3D (struct fuse_rename2_in *) inarg;
-=09char *oldname =3D PARAM(arg);
-=09char *newname =3D oldname + strlen(oldname) + 1;
+    struct fuse_rename2_in *arg =3D (struct fuse_rename2_in *)inarg;
+    char *oldname =3D PARAM(arg);
+    char *newname =3D oldname + strlen(oldname) + 1;
=20
-=09if (req->se->op.rename)
-=09=09req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
-=09=09=09=09  arg->flags);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.rename) {
+        req->se->op.rename(req, nodeid, oldname, arg->newdir, newname,
+                           arg->flags);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_link(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_link_in *arg =3D (struct fuse_link_in *) inarg;
+    struct fuse_link_in *arg =3D (struct fuse_link_in *)inarg;
=20
-=09if (req->se->op.link)
-=09=09req->se->op.link(req, arg->oldnodeid, nodeid, PARAM(arg));
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.link) {
+        req->se->op.link(req, arg->oldnodeid, nodeid, PARAM(arg));
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_create(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09struct fuse_create_in *arg =3D (struct fuse_create_in *) inarg;
+    struct fuse_create_in *arg =3D (struct fuse_create_in *)inarg;
=20
-=09if (req->se->op.create) {
-=09=09struct fuse_file_info fi;
-=09=09char *name =3D PARAM(arg);
+    if (req->se->op.create) {
+        struct fuse_file_info fi;
+        char *name =3D PARAM(arg);
=20
-=09=09memset(&fi, 0, sizeof(fi));
-=09=09fi.flags =3D arg->flags;
+        memset(&fi, 0, sizeof(fi));
+        fi.flags =3D arg->flags;
=20
-=09=09if (req->se->conn.proto_minor >=3D 12)
-=09=09=09req->ctx.umask =3D arg->umask;
-=09=09else
-=09=09=09name =3D (char *) inarg + sizeof(struct fuse_open_in);
+        if (req->se->conn.proto_minor >=3D 12) {
+            req->ctx.umask =3D arg->umask;
+        } else {
+            name =3D (char *)inarg + sizeof(struct fuse_open_in);
+        }
=20
-=09=09req->se->op.create(req, nodeid, name, arg->mode, &fi);
-=09} else
-=09=09fuse_reply_err(req, ENOSYS);
+        req->se->op.create(req, nodeid, name, arg->mode, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_open(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_open_in *arg =3D (struct fuse_open_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.flags =3D arg->flags;
+    memset(&fi, 0, sizeof(fi));
+    fi.flags =3D arg->flags;
=20
-=09if (req->se->op.open)
-=09=09req->se->op.open(req, nodeid, &fi);
-=09else
-=09=09fuse_reply_open(req, &fi);
+    if (req->se->op.open) {
+        req->se->op.open(req, nodeid, &fi);
+    } else {
+        fuse_reply_open(req, &fi);
+    }
 }
=20
 static void do_read(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
+    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
=20
-=09if (req->se->op.read) {
-=09=09struct fuse_file_info fi;
+    if (req->se->op.read) {
+        struct fuse_file_info fi;
=20
-=09=09memset(&fi, 0, sizeof(fi));
-=09=09fi.fh =3D arg->fh;
-=09=09if (req->se->conn.proto_minor >=3D 9) {
-=09=09=09fi.lock_owner =3D arg->lock_owner;
-=09=09=09fi.flags =3D arg->flags;
-=09=09}
-=09=09req->se->op.read(req, nodeid, arg->size, arg->offset, &fi);
-=09} else
-=09=09fuse_reply_err(req, ENOSYS);
+        memset(&fi, 0, sizeof(fi));
+        fi.fh =3D arg->fh;
+        if (req->se->conn.proto_minor >=3D 9) {
+            fi.lock_owner =3D arg->lock_owner;
+            fi.flags =3D arg->flags;
+        }
+        req->se->op.read(req, nodeid, arg->size, arg->offset, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_write(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
-=09struct fuse_file_info fi;
-=09char *param;
+    struct fuse_write_in *arg =3D (struct fuse_write_in *)inarg;
+    struct fuse_file_info fi;
+    char *param;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.writepage =3D (arg->write_flags & FUSE_WRITE_CACHE) !=3D 0;
=20
-=09if (req->se->conn.proto_minor < 9) {
-=09=09param =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-=09} else {
-=09=09fi.lock_owner =3D arg->lock_owner;
-=09=09fi.flags =3D arg->flags;
-=09=09param =3D PARAM(arg);
-=09}
+    if (req->se->conn.proto_minor < 9) {
+        param =3D ((char *)arg) + FUSE_COMPAT_WRITE_IN_SIZE;
+    } else {
+        fi.lock_owner =3D arg->lock_owner;
+        fi.flags =3D arg->flags;
+        param =3D PARAM(arg);
+    }
=20
-=09if (req->se->op.write)
-=09=09req->se->op.write(req, nodeid, param, arg->size,
-=09=09=09=09 arg->offset, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.write) {
+        req->se->op.write(req, nodeid, param, arg->size, arg->offset, &fi)=
;
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_write_buf(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg,
-=09=09=09 const struct fuse_buf *ibuf)
-{
-=09struct fuse_session *se =3D req->se;
-=09struct fuse_bufvec bufv =3D {
-=09=09.buf[0] =3D *ibuf,
-=09=09.count =3D 1,
-=09};
-=09struct fuse_write_in *arg =3D (struct fuse_write_in *) inarg;
-=09struct fuse_file_info fi;
-
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
-
-=09if (se->conn.proto_minor < 9) {
-=09=09bufv.buf[0].mem =3D ((char *) arg) + FUSE_COMPAT_WRITE_IN_SIZE;
-=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09FUSE_COMPAT_WRITE_IN_SIZE;
-=09=09assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
-=09} else {
-=09=09fi.lock_owner =3D arg->lock_owner;
-=09=09fi.flags =3D arg->flags;
-=09=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
-=09=09=09bufv.buf[0].mem =3D PARAM(arg);
-
-=09=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09=09sizeof(struct fuse_write_in);
-=09}
-=09if (bufv.buf[0].size < arg->size) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\n"=
);
-=09=09fuse_reply_err(req, EIO);
-=09=09return;
-=09}
-=09bufv.buf[0].size =3D arg->size;
-
-=09se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
+                         const struct fuse_buf *ibuf)
+{
+    struct fuse_session *se =3D req->se;
+    struct fuse_bufvec bufv =3D {
+        .buf[0] =3D *ibuf,
+        .count =3D 1,
+    };
+    struct fuse_write_in *arg =3D (struct fuse_write_in *)inarg;
+    struct fuse_file_info fi;
+
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.writepage =3D arg->write_flags & FUSE_WRITE_CACHE;
+
+    if (se->conn.proto_minor < 9) {
+        bufv.buf[0].mem =3D ((char *)arg) + FUSE_COMPAT_WRITE_IN_SIZE;
+        bufv.buf[0].size -=3D
+            sizeof(struct fuse_in_header) + FUSE_COMPAT_WRITE_IN_SIZE;
+        assert(!(bufv.buf[0].flags & FUSE_BUF_IS_FD));
+    } else {
+        fi.lock_owner =3D arg->lock_owner;
+        fi.flags =3D arg->flags;
+        if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
+            bufv.buf[0].mem =3D PARAM(arg);
+        }
+
+        bufv.buf[0].size -=3D
+            sizeof(struct fuse_in_header) + sizeof(struct fuse_write_in);
+    }
+    if (bufv.buf[0].size < arg->size) {
+        fuse_log(FUSE_LOG_ERR, "fuse: do_write_buf: buffer size too small\=
n");
+        fuse_reply_err(req, EIO);
+        return;
+    }
+    bufv.buf[0].size =3D arg->size;
+
+    se->op.write_buf(req, nodeid, &bufv, arg->offset, &fi);
 }
=20
 static void do_flush(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_flush_in *arg =3D (struct fuse_flush_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_flush_in *arg =3D (struct fuse_flush_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.flush =3D 1;
-=09if (req->se->conn.proto_minor >=3D 7)
-=09=09fi.lock_owner =3D arg->lock_owner;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.flush =3D 1;
+    if (req->se->conn.proto_minor >=3D 7) {
+        fi.lock_owner =3D arg->lock_owner;
+    }
=20
-=09if (req->se->op.flush)
-=09=09req->se->op.flush(req, nodeid, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.flush) {
+        req->se->op.flush(req, nodeid, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_release(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_release_in *arg =3D (struct fuse_release_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.flags =3D arg->flags;
-=09fi.fh =3D arg->fh;
-=09if (req->se->conn.proto_minor >=3D 8) {
-=09=09fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
-=09=09fi.lock_owner =3D arg->lock_owner;
-=09}
-=09if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
-=09=09fi.flock_release =3D 1;
-=09=09fi.lock_owner =3D arg->lock_owner;
-=09}
+    memset(&fi, 0, sizeof(fi));
+    fi.flags =3D arg->flags;
+    fi.fh =3D arg->fh;
+    if (req->se->conn.proto_minor >=3D 8) {
+        fi.flush =3D (arg->release_flags & FUSE_RELEASE_FLUSH) ? 1 : 0;
+        fi.lock_owner =3D arg->lock_owner;
+    }
+    if (arg->release_flags & FUSE_RELEASE_FLOCK_UNLOCK) {
+        fi.flock_release =3D 1;
+        fi.lock_owner =3D arg->lock_owner;
+    }
=20
-=09if (req->se->op.release)
-=09=09req->se->op.release(req, nodeid, &fi);
-=09else
-=09=09fuse_reply_err(req, 0);
+    if (req->se->op.release) {
+        req->se->op.release(req, nodeid, &fi);
+    } else {
+        fuse_reply_err(req, 0);
+    }
 }
=20
 static void do_fsync(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
-=09struct fuse_file_info fi;
-=09int datasync =3D arg->fsync_flags & 1;
+    struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *)inarg;
+    struct fuse_file_info fi;
+    int datasync =3D arg->fsync_flags & 1;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.fsync)
-=09=09req->se->op.fsync(req, nodeid, datasync, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.fsync) {
+        req->se->op.fsync(req, nodeid, datasync, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_opendir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_open_in *arg =3D (struct fuse_open_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_open_in *arg =3D (struct fuse_open_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.flags =3D arg->flags;
+    memset(&fi, 0, sizeof(fi));
+    fi.flags =3D arg->flags;
=20
-=09if (req->se->op.opendir)
-=09=09req->se->op.opendir(req, nodeid, &fi);
-=09else
-=09=09fuse_reply_open(req, &fi);
+    if (req->se->op.opendir) {
+        req->se->op.opendir(req, nodeid, &fi);
+    } else {
+        fuse_reply_open(req, &fi);
+    }
 }
=20
 static void do_readdir(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.readdir)
-=09=09req->se->op.readdir(req, nodeid, arg->size, arg->offset, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.readdir) {
+        req->se->op.readdir(req, nodeid, arg->size, arg->offset, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_readdirplus(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
 {
-=09struct fuse_read_in *arg =3D (struct fuse_read_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_read_in *arg =3D (struct fuse_read_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.readdirplus)
-=09=09req->se->op.readdirplus(req, nodeid, arg->size, arg->offset, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.readdirplus) {
+        req->se->op.readdirplus(req, nodeid, arg->size, arg->offset, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_releasedir(fuse_req_t req, fuse_ino_t nodeid, const void *i=
narg)
 {
-=09struct fuse_release_in *arg =3D (struct fuse_release_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_release_in *arg =3D (struct fuse_release_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.flags =3D arg->flags;
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.flags =3D arg->flags;
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.releasedir)
-=09=09req->se->op.releasedir(req, nodeid, &fi);
-=09else
-=09=09fuse_reply_err(req, 0);
+    if (req->se->op.releasedir) {
+        req->se->op.releasedir(req, nodeid, &fi);
+    } else {
+        fuse_reply_err(req, 0);
+    }
 }
=20
 static void do_fsyncdir(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
 {
-=09struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *) inarg;
-=09struct fuse_file_info fi;
-=09int datasync =3D arg->fsync_flags & 1;
+    struct fuse_fsync_in *arg =3D (struct fuse_fsync_in *)inarg;
+    struct fuse_file_info fi;
+    int datasync =3D arg->fsync_flags & 1;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.fsyncdir)
-=09=09req->se->op.fsyncdir(req, nodeid, datasync, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.fsyncdir) {
+        req->se->op.fsyncdir(req, nodeid, datasync, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_statfs(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09(void) nodeid;
-=09(void) inarg;
+    (void)nodeid;
+    (void)inarg;
=20
-=09if (req->se->op.statfs)
-=09=09req->se->op.statfs(req, nodeid);
-=09else {
-=09=09struct statvfs buf =3D {
-=09=09=09.f_namemax =3D 255,
-=09=09=09.f_bsize =3D 512,
-=09=09};
-=09=09fuse_reply_statfs(req, &buf);
-=09}
+    if (req->se->op.statfs) {
+        req->se->op.statfs(req, nodeid);
+    } else {
+        struct statvfs buf =3D {
+            .f_namemax =3D 255,
+            .f_bsize =3D 512,
+        };
+        fuse_reply_statfs(req, &buf);
+    }
 }
=20
 static void do_setxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
 {
-=09struct fuse_setxattr_in *arg =3D (struct fuse_setxattr_in *) inarg;
-=09char *name =3D PARAM(arg);
-=09char *value =3D name + strlen(name) + 1;
+    struct fuse_setxattr_in *arg =3D (struct fuse_setxattr_in *)inarg;
+    char *name =3D PARAM(arg);
+    char *value =3D name + strlen(name) + 1;
=20
-=09if (req->se->op.setxattr)
-=09=09req->se->op.setxattr(req, nodeid, name, value, arg->size,
-=09=09=09=09    arg->flags);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.setxattr) {
+        req->se->op.setxattr(req, nodeid, name, value, arg->size, arg->fla=
gs);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_getxattr(fuse_req_t req, fuse_ino_t nodeid, const void *ina=
rg)
 {
-=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
+    struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *)inarg;
=20
-=09if (req->se->op.getxattr)
-=09=09req->se->op.getxattr(req, nodeid, PARAM(arg), arg->size);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.getxattr) {
+        req->se->op.getxattr(req, nodeid, PARAM(arg), arg->size);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_listxattr(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
 {
-=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) inarg;
+    struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *)inarg;
=20
-=09if (req->se->op.listxattr)
-=09=09req->se->op.listxattr(req, nodeid, arg->size);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.listxattr) {
+        req->se->op.listxattr(req, nodeid, arg->size);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_removexattr(fuse_req_t req, fuse_ino_t nodeid, const void *=
inarg)
 {
-=09char *name =3D (char *) inarg;
+    char *name =3D (char *)inarg;
=20
-=09if (req->se->op.removexattr)
-=09=09req->se->op.removexattr(req, nodeid, name);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.removexattr) {
+        req->se->op.removexattr(req, nodeid, name);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void convert_fuse_file_lock(struct fuse_file_lock *fl,
-=09=09=09=09   struct flock *flock)
+                                   struct flock *flock)
 {
-=09memset(flock, 0, sizeof(struct flock));
-=09flock->l_type =3D fl->type;
-=09flock->l_whence =3D SEEK_SET;
-=09flock->l_start =3D fl->start;
-=09if (fl->end =3D=3D OFFSET_MAX)
-=09=09flock->l_len =3D 0;
-=09else
-=09=09flock->l_len =3D fl->end - fl->start + 1;
-=09flock->l_pid =3D fl->pid;
+    memset(flock, 0, sizeof(struct flock));
+    flock->l_type =3D fl->type;
+    flock->l_whence =3D SEEK_SET;
+    flock->l_start =3D fl->start;
+    if (fl->end =3D=3D OFFSET_MAX) {
+        flock->l_len =3D 0;
+    } else {
+        flock->l_len =3D fl->end - fl->start + 1;
+    }
+    flock->l_pid =3D fl->pid;
 }
=20
 static void do_getlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
-=09struct fuse_file_info fi;
-=09struct flock flock;
+    struct fuse_lk_in *arg =3D (struct fuse_lk_in *)inarg;
+    struct fuse_file_info fi;
+    struct flock flock;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.lock_owner =3D arg->owner;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.lock_owner =3D arg->owner;
=20
-=09convert_fuse_file_lock(&arg->lk, &flock);
-=09if (req->se->op.getlk)
-=09=09req->se->op.getlk(req, nodeid, &fi, &flock);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    convert_fuse_file_lock(&arg->lk, &flock);
+    if (req->se->op.getlk) {
+        req->se->op.getlk(req, nodeid, &fi, &flock);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_setlk_common(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg, int sleep)
-{
-=09struct fuse_lk_in *arg =3D (struct fuse_lk_in *) inarg;
-=09struct fuse_file_info fi;
-=09struct flock flock;
-
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.lock_owner =3D arg->owner;
-
-=09if (arg->lk_flags & FUSE_LK_FLOCK) {
-=09=09int op =3D 0;
-
-=09=09switch (arg->lk.type) {
-=09=09case F_RDLCK:
-=09=09=09op =3D LOCK_SH;
-=09=09=09break;
-=09=09case F_WRLCK:
-=09=09=09op =3D LOCK_EX;
-=09=09=09break;
-=09=09case F_UNLCK:
-=09=09=09op =3D LOCK_UN;
-=09=09=09break;
-=09=09}
-=09=09if (!sleep)
-=09=09=09op |=3D LOCK_NB;
-
-=09=09if (req->se->op.flock)
-=09=09=09req->se->op.flock(req, nodeid, &fi, op);
-=09=09else
-=09=09=09fuse_reply_err(req, ENOSYS);
-=09} else {
-=09=09convert_fuse_file_lock(&arg->lk, &flock);
-=09=09if (req->se->op.setlk)
-=09=09=09req->se->op.setlk(req, nodeid, &fi, &flock, sleep);
-=09=09else
-=09=09=09fuse_reply_err(req, ENOSYS);
-=09}
+                            const void *inarg, int sleep)
+{
+    struct fuse_lk_in *arg =3D (struct fuse_lk_in *)inarg;
+    struct fuse_file_info fi;
+    struct flock flock;
+
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.lock_owner =3D arg->owner;
+
+    if (arg->lk_flags & FUSE_LK_FLOCK) {
+        int op =3D 0;
+
+        switch (arg->lk.type) {
+        case F_RDLCK:
+            op =3D LOCK_SH;
+            break;
+        case F_WRLCK:
+            op =3D LOCK_EX;
+            break;
+        case F_UNLCK:
+            op =3D LOCK_UN;
+            break;
+        }
+        if (!sleep) {
+            op |=3D LOCK_NB;
+        }
+
+        if (req->se->op.flock) {
+            req->se->op.flock(req, nodeid, &fi, op);
+        } else {
+            fuse_reply_err(req, ENOSYS);
+        }
+    } else {
+        convert_fuse_file_lock(&arg->lk, &flock);
+        if (req->se->op.setlk) {
+            req->se->op.setlk(req, nodeid, &fi, &flock, sleep);
+        } else {
+            fuse_reply_err(req, ENOSYS);
+        }
+    }
 }
=20
 static void do_setlk(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09do_setlk_common(req, nodeid, inarg, 0);
+    do_setlk_common(req, nodeid, inarg, 0);
 }
=20
 static void do_setlkw(fuse_req_t req, fuse_ino_t nodeid, const void *inarg=
)
 {
-=09do_setlk_common(req, nodeid, inarg, 1);
+    do_setlk_common(req, nodeid, inarg, 1);
 }
=20
 static int find_interrupted(struct fuse_session *se, struct fuse_req *req)
 {
-=09struct fuse_req *curr;
-
-=09for (curr =3D se->list.next; curr !=3D &se->list; curr =3D curr->next) =
{
-=09=09if (curr->unique =3D=3D req->u.i.unique) {
-=09=09=09fuse_interrupt_func_t func;
-=09=09=09void *data;
-
-=09=09=09curr->ctr++;
-=09=09=09pthread_mutex_unlock(&se->lock);
-
-=09=09=09/* Ugh, ugly locking */
-=09=09=09pthread_mutex_lock(&curr->lock);
-=09=09=09pthread_mutex_lock(&se->lock);
-=09=09=09curr->interrupted =3D 1;
-=09=09=09func =3D curr->u.ni.func;
-=09=09=09data =3D curr->u.ni.data;
-=09=09=09pthread_mutex_unlock(&se->lock);
-=09=09=09if (func)
-=09=09=09=09func(curr, data);
-=09=09=09pthread_mutex_unlock(&curr->lock);
-
-=09=09=09pthread_mutex_lock(&se->lock);
-=09=09=09curr->ctr--;
-=09=09=09if (!curr->ctr)
-=09=09=09=09destroy_req(curr);
-
-=09=09=09return 1;
-=09=09}
-=09}
-=09for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
-=09     curr =3D curr->next) {
-=09=09if (curr->u.i.unique =3D=3D req->u.i.unique)
-=09=09=09return 1;
-=09}
-=09return 0;
+    struct fuse_req *curr;
+
+    for (curr =3D se->list.next; curr !=3D &se->list; curr =3D curr->next)=
 {
+        if (curr->unique =3D=3D req->u.i.unique) {
+            fuse_interrupt_func_t func;
+            void *data;
+
+            curr->ctr++;
+            pthread_mutex_unlock(&se->lock);
+
+            /* Ugh, ugly locking */
+            pthread_mutex_lock(&curr->lock);
+            pthread_mutex_lock(&se->lock);
+            curr->interrupted =3D 1;
+            func =3D curr->u.ni.func;
+            data =3D curr->u.ni.data;
+            pthread_mutex_unlock(&se->lock);
+            if (func) {
+                func(curr, data);
+            }
+            pthread_mutex_unlock(&curr->lock);
+
+            pthread_mutex_lock(&se->lock);
+            curr->ctr--;
+            if (!curr->ctr) {
+                destroy_req(curr);
+            }
+
+            return 1;
+        }
+    }
+    for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
+         curr =3D curr->next) {
+        if (curr->u.i.unique =3D=3D req->u.i.unique) {
+            return 1;
+        }
+    }
+    return 0;
 }
=20
 static void do_interrupt(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
 {
-=09struct fuse_interrupt_in *arg =3D (struct fuse_interrupt_in *) inarg;
-=09struct fuse_session *se =3D req->se;
+    struct fuse_interrupt_in *arg =3D (struct fuse_interrupt_in *)inarg;
+    struct fuse_session *se =3D req->se;
=20
-=09(void) nodeid;
-=09if (se->debug)
-=09=09fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
-=09=09=09(unsigned long long) arg->unique);
+    (void)nodeid;
+    if (se->debug) {
+        fuse_log(FUSE_LOG_DEBUG, "INTERRUPT: %llu\n",
+                 (unsigned long long)arg->unique);
+    }
=20
-=09req->u.i.unique =3D arg->unique;
+    req->u.i.unique =3D arg->unique;
=20
-=09pthread_mutex_lock(&se->lock);
-=09if (find_interrupted(se, req))
-=09=09destroy_req(req);
-=09else
-=09=09list_add_req(req, &se->interrupts);
-=09pthread_mutex_unlock(&se->lock);
+    pthread_mutex_lock(&se->lock);
+    if (find_interrupted(se, req)) {
+        destroy_req(req);
+    } else {
+        list_add_req(req, &se->interrupts);
+    }
+    pthread_mutex_unlock(&se->lock);
 }
=20
 static struct fuse_req *check_interrupt(struct fuse_session *se,
-=09=09=09=09=09struct fuse_req *req)
-{
-=09struct fuse_req *curr;
-
-=09for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
-=09     curr =3D curr->next) {
-=09=09if (curr->u.i.unique =3D=3D req->unique) {
-=09=09=09req->interrupted =3D 1;
-=09=09=09list_del_req(curr);
-=09=09=09free(curr);
-=09=09=09return NULL;
-=09=09}
-=09}
-=09curr =3D se->interrupts.next;
-=09if (curr !=3D &se->interrupts) {
-=09=09list_del_req(curr);
-=09=09list_init_req(curr);
-=09=09return curr;
-=09} else
-=09=09return NULL;
+                                        struct fuse_req *req)
+{
+    struct fuse_req *curr;
+
+    for (curr =3D se->interrupts.next; curr !=3D &se->interrupts;
+         curr =3D curr->next) {
+        if (curr->u.i.unique =3D=3D req->unique) {
+            req->interrupted =3D 1;
+            list_del_req(curr);
+            free(curr);
+            return NULL;
+        }
+    }
+    curr =3D se->interrupts.next;
+    if (curr !=3D &se->interrupts) {
+        list_del_req(curr);
+        list_init_req(curr);
+        return curr;
+    } else {
+        return NULL;
+    }
 }
=20
 static void do_bmap(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_bmap_in *arg =3D (struct fuse_bmap_in *) inarg;
+    struct fuse_bmap_in *arg =3D (struct fuse_bmap_in *)inarg;
=20
-=09if (req->se->op.bmap)
-=09=09req->se->op.bmap(req, nodeid, arg->blocksize, arg->block);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.bmap) {
+        req->se->op.bmap(req, nodeid, arg->blocksize, arg->block);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_ioctl(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_ioctl_in *arg =3D (struct fuse_ioctl_in *) inarg;
-=09unsigned int flags =3D arg->flags;
-=09void *in_buf =3D arg->in_size ? PARAM(arg) : NULL;
-=09struct fuse_file_info fi;
+    struct fuse_ioctl_in *arg =3D (struct fuse_ioctl_in *)inarg;
+    unsigned int flags =3D arg->flags;
+    void *in_buf =3D arg->in_size ? PARAM(arg) : NULL;
+    struct fuse_file_info fi;
=20
-=09if (flags & FUSE_IOCTL_DIR &&
-=09    !(req->se->conn.want & FUSE_CAP_IOCTL_DIR)) {
-=09=09fuse_reply_err(req, ENOTTY);
-=09=09return;
-=09}
+    if (flags & FUSE_IOCTL_DIR && !(req->se->conn.want & FUSE_CAP_IOCTL_DI=
R)) {
+        fuse_reply_err(req, ENOTTY);
+        return;
+    }
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (sizeof(void *) =3D=3D 4 && req->se->conn.proto_minor >=3D 16 &&
-=09    !(flags & FUSE_IOCTL_32BIT)) {
-=09=09req->ioctl_64bit =3D 1;
-=09}
+    if (sizeof(void *) =3D=3D 4 && req->se->conn.proto_minor >=3D 16 &&
+        !(flags & FUSE_IOCTL_32BIT)) {
+        req->ioctl_64bit =3D 1;
+    }
=20
-=09if (req->se->op.ioctl)
-=09=09req->se->op.ioctl(req, nodeid, arg->cmd,
-=09=09=09=09 (void *)(uintptr_t)arg->arg, &fi, flags,
-=09=09=09=09 in_buf, arg->in_size, arg->out_size);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.ioctl) {
+        req->se->op.ioctl(req, nodeid, arg->cmd, (void *)(uintptr_t)arg->a=
rg,
+                          &fi, flags, in_buf, arg->in_size, arg->out_size)=
;
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 void fuse_pollhandle_destroy(struct fuse_pollhandle *ph)
 {
-=09free(ph);
+    free(ph);
 }
=20
 static void do_poll(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_poll_in *arg =3D (struct fuse_poll_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_poll_in *arg =3D (struct fuse_poll_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
-=09fi.poll_events =3D arg->events;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
+    fi.poll_events =3D arg->events;
=20
-=09if (req->se->op.poll) {
-=09=09struct fuse_pollhandle *ph =3D NULL;
+    if (req->se->op.poll) {
+        struct fuse_pollhandle *ph =3D NULL;
=20
-=09=09if (arg->flags & FUSE_POLL_SCHEDULE_NOTIFY) {
-=09=09=09ph =3D malloc(sizeof(struct fuse_pollhandle));
-=09=09=09if (ph =3D=3D NULL) {
-=09=09=09=09fuse_reply_err(req, ENOMEM);
-=09=09=09=09return;
-=09=09=09}
-=09=09=09ph->kh =3D arg->kh;
-=09=09=09ph->se =3D req->se;
-=09=09}
+        if (arg->flags & FUSE_POLL_SCHEDULE_NOTIFY) {
+            ph =3D malloc(sizeof(struct fuse_pollhandle));
+            if (ph =3D=3D NULL) {
+                fuse_reply_err(req, ENOMEM);
+                return;
+            }
+            ph->kh =3D arg->kh;
+            ph->se =3D req->se;
+        }
=20
-=09=09req->se->op.poll(req, nodeid, &fi, ph);
-=09} else {
-=09=09fuse_reply_err(req, ENOSYS);
-=09}
+        req->se->op.poll(req, nodeid, &fi, ph);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_fallocate(fuse_req_t req, fuse_ino_t nodeid, const void *in=
arg)
 {
-=09struct fuse_fallocate_in *arg =3D (struct fuse_fallocate_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_fallocate_in *arg =3D (struct fuse_fallocate_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.fallocate)
-=09=09req->se->op.fallocate(req, nodeid, arg->mode, arg->offset, arg->leng=
th, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.fallocate) {
+        req->se->op.fallocate(req, nodeid, arg->mode, arg->offset, arg->le=
ngth,
+                              &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
-static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in, const=
 void *inarg)
+static void do_copy_file_range(fuse_req_t req, fuse_ino_t nodeid_in,
+                               const void *inarg)
 {
-=09struct fuse_copy_file_range_in *arg =3D (struct fuse_copy_file_range_in=
 *) inarg;
-=09struct fuse_file_info fi_in, fi_out;
+    struct fuse_copy_file_range_in *arg =3D
+        (struct fuse_copy_file_range_in *)inarg;
+    struct fuse_file_info fi_in, fi_out;
=20
-=09memset(&fi_in, 0, sizeof(fi_in));
-=09fi_in.fh =3D arg->fh_in;
+    memset(&fi_in, 0, sizeof(fi_in));
+    fi_in.fh =3D arg->fh_in;
=20
-=09memset(&fi_out, 0, sizeof(fi_out));
-=09fi_out.fh =3D arg->fh_out;
+    memset(&fi_out, 0, sizeof(fi_out));
+    fi_out.fh =3D arg->fh_out;
=20
=20
-=09if (req->se->op.copy_file_range)
-=09=09req->se->op.copy_file_range(req, nodeid_in, arg->off_in,
-=09=09=09=09=09    &fi_in, arg->nodeid_out,
-=09=09=09=09=09    arg->off_out, &fi_out, arg->len,
-=09=09=09=09=09    arg->flags);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.copy_file_range) {
+        req->se->op.copy_file_range(req, nodeid_in, arg->off_in, &fi_in,
+                                    arg->nodeid_out, arg->off_out, &fi_out=
,
+                                    arg->len, arg->flags);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_lseek(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_lseek_in *arg =3D (struct fuse_lseek_in *) inarg;
-=09struct fuse_file_info fi;
+    struct fuse_lseek_in *arg =3D (struct fuse_lseek_in *)inarg;
+    struct fuse_file_info fi;
=20
-=09memset(&fi, 0, sizeof(fi));
-=09fi.fh =3D arg->fh;
+    memset(&fi, 0, sizeof(fi));
+    fi.fh =3D arg->fh;
=20
-=09if (req->se->op.lseek)
-=09=09req->se->op.lseek(req, nodeid, arg->offset, arg->whence, &fi);
-=09else
-=09=09fuse_reply_err(req, ENOSYS);
+    if (req->se->op.lseek) {
+        req->se->op.lseek(req, nodeid, arg->offset, arg->whence, &fi);
+    } else {
+        fuse_reply_err(req, ENOSYS);
+    }
 }
=20
 static void do_init(fuse_req_t req, fuse_ino_t nodeid, const void *inarg)
 {
-=09struct fuse_init_in *arg =3D (struct fuse_init_in *) inarg;
-=09struct fuse_init_out outarg;
-=09struct fuse_session *se =3D req->se;
-=09size_t bufsize =3D se->bufsize;
-=09size_t outargsize =3D sizeof(outarg);
-
-=09(void) nodeid;
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
-=09=09if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
-=09=09=09=09arg->max_readahead);
-=09=09}
-=09}
-=09se->conn.proto_major =3D arg->major;
-=09se->conn.proto_minor =3D arg->minor;
-=09se->conn.capable =3D 0;
-=09se->conn.want =3D 0;
-
-=09memset(&outarg, 0, sizeof(outarg));
-=09outarg.major =3D FUSE_KERNEL_VERSION;
-=09outarg.minor =3D FUSE_KERNEL_MINOR_VERSION;
-
-=09if (arg->major < 7) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: unsupported protocol version: %u.%u\n"=
,
-=09=09=09arg->major, arg->minor);
-=09=09fuse_reply_err(req, EPROTO);
-=09=09return;
-=09}
-
-=09if (arg->major > 7) {
-=09=09/* Wait for a second INIT request with a 7.X version */
-=09=09send_reply_ok(req, &outarg, sizeof(outarg));
-=09=09return;
-=09}
-
-=09if (arg->minor >=3D 6) {
-=09=09if (arg->max_readahead < se->conn.max_readahead)
-=09=09=09se->conn.max_readahead =3D arg->max_readahead;
-=09=09if (arg->flags & FUSE_ASYNC_READ)
-=09=09=09se->conn.capable |=3D FUSE_CAP_ASYNC_READ;
-=09=09if (arg->flags & FUSE_POSIX_LOCKS)
-=09=09=09se->conn.capable |=3D FUSE_CAP_POSIX_LOCKS;
-=09=09if (arg->flags & FUSE_ATOMIC_O_TRUNC)
-=09=09=09se->conn.capable |=3D FUSE_CAP_ATOMIC_O_TRUNC;
-=09=09if (arg->flags & FUSE_EXPORT_SUPPORT)
-=09=09=09se->conn.capable |=3D FUSE_CAP_EXPORT_SUPPORT;
-=09=09if (arg->flags & FUSE_DONT_MASK)
-=09=09=09se->conn.capable |=3D FUSE_CAP_DONT_MASK;
-=09=09if (arg->flags & FUSE_FLOCK_LOCKS)
-=09=09=09se->conn.capable |=3D FUSE_CAP_FLOCK_LOCKS;
-=09=09if (arg->flags & FUSE_AUTO_INVAL_DATA)
-=09=09=09se->conn.capable |=3D FUSE_CAP_AUTO_INVAL_DATA;
-=09=09if (arg->flags & FUSE_DO_READDIRPLUS)
-=09=09=09se->conn.capable |=3D FUSE_CAP_READDIRPLUS;
-=09=09if (arg->flags & FUSE_READDIRPLUS_AUTO)
-=09=09=09se->conn.capable |=3D FUSE_CAP_READDIRPLUS_AUTO;
-=09=09if (arg->flags & FUSE_ASYNC_DIO)
-=09=09=09se->conn.capable |=3D FUSE_CAP_ASYNC_DIO;
-=09=09if (arg->flags & FUSE_WRITEBACK_CACHE)
-=09=09=09se->conn.capable |=3D FUSE_CAP_WRITEBACK_CACHE;
-=09=09if (arg->flags & FUSE_NO_OPEN_SUPPORT)
-=09=09=09se->conn.capable |=3D FUSE_CAP_NO_OPEN_SUPPORT;
-=09=09if (arg->flags & FUSE_PARALLEL_DIROPS)
-=09=09=09se->conn.capable |=3D FUSE_CAP_PARALLEL_DIROPS;
-=09=09if (arg->flags & FUSE_POSIX_ACL)
-=09=09=09se->conn.capable |=3D FUSE_CAP_POSIX_ACL;
-=09=09if (arg->flags & FUSE_HANDLE_KILLPRIV)
-=09=09=09se->conn.capable |=3D FUSE_CAP_HANDLE_KILLPRIV;
-=09=09if (arg->flags & FUSE_NO_OPENDIR_SUPPORT)
-=09=09=09se->conn.capable |=3D FUSE_CAP_NO_OPENDIR_SUPPORT;
-=09=09if (!(arg->flags & FUSE_MAX_PAGES)) {
-=09=09=09size_t max_bufsize =3D
-=09=09=09=09FUSE_DEFAULT_MAX_PAGES_PER_REQ * getpagesize()
-=09=09=09=09+ FUSE_BUFFER_HEADER_SIZE;
-=09=09=09if (bufsize > max_bufsize) {
-=09=09=09=09bufsize =3D max_bufsize;
-=09=09=09}
-=09=09}
-=09} else {
-=09=09se->conn.max_readahead =3D 0;
-=09}
-
-=09if (se->conn.proto_minor >=3D 14) {
+    struct fuse_init_in *arg =3D (struct fuse_init_in *)inarg;
+    struct fuse_init_out outarg;
+    struct fuse_session *se =3D req->se;
+    size_t bufsize =3D se->bufsize;
+    size_t outargsize =3D sizeof(outarg);
+
+    (void)nodeid;
+    if (se->debug) {
+        fuse_log(FUSE_LOG_DEBUG, "INIT: %u.%u\n", arg->major, arg->minor);
+        if (arg->major =3D=3D 7 && arg->minor >=3D 6) {
+            fuse_log(FUSE_LOG_DEBUG, "flags=3D0x%08x\n", arg->flags);
+            fuse_log(FUSE_LOG_DEBUG, "max_readahead=3D0x%08x\n",
+                     arg->max_readahead);
+        }
+    }
+    se->conn.proto_major =3D arg->major;
+    se->conn.proto_minor =3D arg->minor;
+    se->conn.capable =3D 0;
+    se->conn.want =3D 0;
+
+    memset(&outarg, 0, sizeof(outarg));
+    outarg.major =3D FUSE_KERNEL_VERSION;
+    outarg.minor =3D FUSE_KERNEL_MINOR_VERSION;
+
+    if (arg->major < 7) {
+        fuse_log(FUSE_LOG_ERR, "fuse: unsupported protocol version: %u.%u\=
n",
+                 arg->major, arg->minor);
+        fuse_reply_err(req, EPROTO);
+        return;
+    }
+
+    if (arg->major > 7) {
+        /* Wait for a second INIT request with a 7.X version */
+        send_reply_ok(req, &outarg, sizeof(outarg));
+        return;
+    }
+
+    if (arg->minor >=3D 6) {
+        if (arg->max_readahead < se->conn.max_readahead) {
+            se->conn.max_readahead =3D arg->max_readahead;
+        }
+        if (arg->flags & FUSE_ASYNC_READ) {
+            se->conn.capable |=3D FUSE_CAP_ASYNC_READ;
+        }
+        if (arg->flags & FUSE_POSIX_LOCKS) {
+            se->conn.capable |=3D FUSE_CAP_POSIX_LOCKS;
+        }
+        if (arg->flags & FUSE_ATOMIC_O_TRUNC) {
+            se->conn.capable |=3D FUSE_CAP_ATOMIC_O_TRUNC;
+        }
+        if (arg->flags & FUSE_EXPORT_SUPPORT) {
+            se->conn.capable |=3D FUSE_CAP_EXPORT_SUPPORT;
+        }
+        if (arg->flags & FUSE_DONT_MASK) {
+            se->conn.capable |=3D FUSE_CAP_DONT_MASK;
+        }
+        if (arg->flags & FUSE_FLOCK_LOCKS) {
+            se->conn.capable |=3D FUSE_CAP_FLOCK_LOCKS;
+        }
+        if (arg->flags & FUSE_AUTO_INVAL_DATA) {
+            se->conn.capable |=3D FUSE_CAP_AUTO_INVAL_DATA;
+        }
+        if (arg->flags & FUSE_DO_READDIRPLUS) {
+            se->conn.capable |=3D FUSE_CAP_READDIRPLUS;
+        }
+        if (arg->flags & FUSE_READDIRPLUS_AUTO) {
+            se->conn.capable |=3D FUSE_CAP_READDIRPLUS_AUTO;
+        }
+        if (arg->flags & FUSE_ASYNC_DIO) {
+            se->conn.capable |=3D FUSE_CAP_ASYNC_DIO;
+        }
+        if (arg->flags & FUSE_WRITEBACK_CACHE) {
+            se->conn.capable |=3D FUSE_CAP_WRITEBACK_CACHE;
+        }
+        if (arg->flags & FUSE_NO_OPEN_SUPPORT) {
+            se->conn.capable |=3D FUSE_CAP_NO_OPEN_SUPPORT;
+        }
+        if (arg->flags & FUSE_PARALLEL_DIROPS) {
+            se->conn.capable |=3D FUSE_CAP_PARALLEL_DIROPS;
+        }
+        if (arg->flags & FUSE_POSIX_ACL) {
+            se->conn.capable |=3D FUSE_CAP_POSIX_ACL;
+        }
+        if (arg->flags & FUSE_HANDLE_KILLPRIV) {
+            se->conn.capable |=3D FUSE_CAP_HANDLE_KILLPRIV;
+        }
+        if (arg->flags & FUSE_NO_OPENDIR_SUPPORT) {
+            se->conn.capable |=3D FUSE_CAP_NO_OPENDIR_SUPPORT;
+        }
+        if (!(arg->flags & FUSE_MAX_PAGES)) {
+            size_t max_bufsize =3D
+                FUSE_DEFAULT_MAX_PAGES_PER_REQ * getpagesize() +
+                FUSE_BUFFER_HEADER_SIZE;
+            if (bufsize > max_bufsize) {
+                bufsize =3D max_bufsize;
+            }
+        }
+    } else {
+        se->conn.max_readahead =3D 0;
+    }
+
+    if (se->conn.proto_minor >=3D 14) {
 #ifdef HAVE_SPLICE
 #ifdef HAVE_VMSPLICE
-=09=09se->conn.capable |=3D FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE;
+        se->conn.capable |=3D FUSE_CAP_SPLICE_WRITE | FUSE_CAP_SPLICE_MOVE=
;
 #endif
-=09=09se->conn.capable |=3D FUSE_CAP_SPLICE_READ;
+        se->conn.capable |=3D FUSE_CAP_SPLICE_READ;
 #endif
-=09}
-=09if (se->conn.proto_minor >=3D 18)
-=09=09se->conn.capable |=3D FUSE_CAP_IOCTL_DIR;
-
-=09/* Default settings for modern filesystems.
-=09 *
-=09 * Most of these capabilities were disabled by default in
-=09 * libfuse2 for backwards compatibility reasons. In libfuse3,
-=09 * we can finally enable them by default (as long as they're
-=09 * supported by the kernel).
-=09 */
-#define LL_SET_DEFAULT(cond, cap) \
-=09if ((cond) && (se->conn.capable & (cap))) \
-=09=09se->conn.want |=3D (cap)
-=09LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_READ);
-=09LL_SET_DEFAULT(1, FUSE_CAP_PARALLEL_DIROPS);
-=09LL_SET_DEFAULT(1, FUSE_CAP_AUTO_INVAL_DATA);
-=09LL_SET_DEFAULT(1, FUSE_CAP_HANDLE_KILLPRIV);
-=09LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_DIO);
-=09LL_SET_DEFAULT(1, FUSE_CAP_IOCTL_DIR);
-=09LL_SET_DEFAULT(1, FUSE_CAP_ATOMIC_O_TRUNC);
-=09LL_SET_DEFAULT(se->op.write_buf, FUSE_CAP_SPLICE_READ);
-=09LL_SET_DEFAULT(se->op.getlk && se->op.setlk,
-=09=09       FUSE_CAP_POSIX_LOCKS);
-=09LL_SET_DEFAULT(se->op.flock, FUSE_CAP_FLOCK_LOCKS);
-=09LL_SET_DEFAULT(se->op.readdirplus, FUSE_CAP_READDIRPLUS);
-=09LL_SET_DEFAULT(se->op.readdirplus && se->op.readdir,
-=09=09       FUSE_CAP_READDIRPLUS_AUTO);
-=09se->conn.time_gran =3D 1;
-=09
-=09if (bufsize < FUSE_MIN_READ_BUFFER) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: buffer size too small: %zu\n"=
,
-=09=09=09bufsize);
-=09=09bufsize =3D FUSE_MIN_READ_BUFFER;
-=09}
-=09se->bufsize =3D bufsize;
-
-=09if (se->conn.max_write > bufsize - FUSE_BUFFER_HEADER_SIZE)
-=09=09se->conn.max_write =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
-
-=09se->got_init =3D 1;
-=09if (se->op.init)
-=09=09se->op.init(se->userdata, &se->conn);
-
-=09if (se->conn.want & (~se->conn.capable)) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: error: filesystem requested capabiliti=
es "
-=09=09=09"0x%x that are not supported by kernel, aborting.\n",
-=09=09=09se->conn.want & (~se->conn.capable));
-=09=09fuse_reply_err(req, EPROTO);
-=09=09se->error =3D -EPROTO;
-=09=09fuse_session_exit(se);
-=09=09return;
-=09}
-
-=09if (se->conn.max_write < bufsize - FUSE_BUFFER_HEADER_SIZE) {
-=09=09se->bufsize =3D se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
-=09}
-=09if (arg->flags & FUSE_MAX_PAGES) {
-=09=09outarg.flags |=3D FUSE_MAX_PAGES;
-=09=09outarg.max_pages =3D (se->conn.max_write - 1) / getpagesize() + 1;
-=09}
-
-=09/* Always enable big writes, this is superseded
-=09   by the max_write option */
-=09outarg.flags |=3D FUSE_BIG_WRITES;
-
-=09if (se->conn.want & FUSE_CAP_ASYNC_READ)
-=09=09outarg.flags |=3D FUSE_ASYNC_READ;
-=09if (se->conn.want & FUSE_CAP_POSIX_LOCKS)
-=09=09outarg.flags |=3D FUSE_POSIX_LOCKS;
-=09if (se->conn.want & FUSE_CAP_ATOMIC_O_TRUNC)
-=09=09outarg.flags |=3D FUSE_ATOMIC_O_TRUNC;
-=09if (se->conn.want & FUSE_CAP_EXPORT_SUPPORT)
-=09=09outarg.flags |=3D FUSE_EXPORT_SUPPORT;
-=09if (se->conn.want & FUSE_CAP_DONT_MASK)
-=09=09outarg.flags |=3D FUSE_DONT_MASK;
-=09if (se->conn.want & FUSE_CAP_FLOCK_LOCKS)
-=09=09outarg.flags |=3D FUSE_FLOCK_LOCKS;
-=09if (se->conn.want & FUSE_CAP_AUTO_INVAL_DATA)
-=09=09outarg.flags |=3D FUSE_AUTO_INVAL_DATA;
-=09if (se->conn.want & FUSE_CAP_READDIRPLUS)
-=09=09outarg.flags |=3D FUSE_DO_READDIRPLUS;
-=09if (se->conn.want & FUSE_CAP_READDIRPLUS_AUTO)
-=09=09outarg.flags |=3D FUSE_READDIRPLUS_AUTO;
-=09if (se->conn.want & FUSE_CAP_ASYNC_DIO)
-=09=09outarg.flags |=3D FUSE_ASYNC_DIO;
-=09if (se->conn.want & FUSE_CAP_WRITEBACK_CACHE)
-=09=09outarg.flags |=3D FUSE_WRITEBACK_CACHE;
-=09if (se->conn.want & FUSE_CAP_POSIX_ACL)
-=09=09outarg.flags |=3D FUSE_POSIX_ACL;
-=09outarg.max_readahead =3D se->conn.max_readahead;
-=09outarg.max_write =3D se->conn.max_write;
-=09if (se->conn.proto_minor >=3D 13) {
-=09=09if (se->conn.max_background >=3D (1 << 16))
-=09=09=09se->conn.max_background =3D (1 << 16) - 1;
-=09=09if (se->conn.congestion_threshold > se->conn.max_background)
-=09=09=09se->conn.congestion_threshold =3D se->conn.max_background;
-=09=09if (!se->conn.congestion_threshold) {
-=09=09=09se->conn.congestion_threshold =3D
-=09=09=09=09se->conn.max_background * 3 / 4;
-=09=09}
-
-=09=09outarg.max_background =3D se->conn.max_background;
-=09=09outarg.congestion_threshold =3D se->conn.congestion_threshold;
-=09}
-=09if (se->conn.proto_minor >=3D 23)
-=09=09outarg.time_gran =3D se->conn.time_gran;
-
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major, outarg.mi=
nor);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
-=09=09=09outarg.max_readahead);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_write=
);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
-=09=09=09outarg.max_background);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
-=09=09=09outarg.congestion_threshold);
-=09=09fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n",
-=09=09=09outarg.time_gran);
-=09}
-=09if (arg->minor < 5)
-=09=09outargsize =3D FUSE_COMPAT_INIT_OUT_SIZE;
-=09else if (arg->minor < 23)
-=09=09outargsize =3D FUSE_COMPAT_22_INIT_OUT_SIZE;
-
-=09send_reply_ok(req, &outarg, outargsize);
+    }
+    if (se->conn.proto_minor >=3D 18) {
+        se->conn.capable |=3D FUSE_CAP_IOCTL_DIR;
+    }
+
+    /*
+     * Default settings for modern filesystems.
+     *
+     * Most of these capabilities were disabled by default in
+     * libfuse2 for backwards compatibility reasons. In libfuse3,
+     * we can finally enable them by default (as long as they're
+     * supported by the kernel).
+     */
+#define LL_SET_DEFAULT(cond, cap)             \
+    if ((cond) && (se->conn.capable & (cap))) \
+        se->conn.want |=3D (cap)
+    LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_READ);
+    LL_SET_DEFAULT(1, FUSE_CAP_PARALLEL_DIROPS);
+    LL_SET_DEFAULT(1, FUSE_CAP_AUTO_INVAL_DATA);
+    LL_SET_DEFAULT(1, FUSE_CAP_HANDLE_KILLPRIV);
+    LL_SET_DEFAULT(1, FUSE_CAP_ASYNC_DIO);
+    LL_SET_DEFAULT(1, FUSE_CAP_IOCTL_DIR);
+    LL_SET_DEFAULT(1, FUSE_CAP_ATOMIC_O_TRUNC);
+    LL_SET_DEFAULT(se->op.write_buf, FUSE_CAP_SPLICE_READ);
+    LL_SET_DEFAULT(se->op.getlk && se->op.setlk, FUSE_CAP_POSIX_LOCKS);
+    LL_SET_DEFAULT(se->op.flock, FUSE_CAP_FLOCK_LOCKS);
+    LL_SET_DEFAULT(se->op.readdirplus, FUSE_CAP_READDIRPLUS);
+    LL_SET_DEFAULT(se->op.readdirplus && se->op.readdir,
+                   FUSE_CAP_READDIRPLUS_AUTO);
+    se->conn.time_gran =3D 1;
+
+    if (bufsize < FUSE_MIN_READ_BUFFER) {
+        fuse_log(FUSE_LOG_ERR, "fuse: warning: buffer size too small: %zu\=
n",
+                 bufsize);
+        bufsize =3D FUSE_MIN_READ_BUFFER;
+    }
+    se->bufsize =3D bufsize;
+
+    if (se->conn.max_write > bufsize - FUSE_BUFFER_HEADER_SIZE) {
+        se->conn.max_write =3D bufsize - FUSE_BUFFER_HEADER_SIZE;
+    }
+
+    se->got_init =3D 1;
+    if (se->op.init) {
+        se->op.init(se->userdata, &se->conn);
+    }
+
+    if (se->conn.want & (~se->conn.capable)) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: error: filesystem requested capabilities "
+                 "0x%x that are not supported by kernel, aborting.\n",
+                 se->conn.want & (~se->conn.capable));
+        fuse_reply_err(req, EPROTO);
+        se->error =3D -EPROTO;
+        fuse_session_exit(se);
+        return;
+    }
+
+    if (se->conn.max_write < bufsize - FUSE_BUFFER_HEADER_SIZE) {
+        se->bufsize =3D se->conn.max_write + FUSE_BUFFER_HEADER_SIZE;
+    }
+    if (arg->flags & FUSE_MAX_PAGES) {
+        outarg.flags |=3D FUSE_MAX_PAGES;
+        outarg.max_pages =3D (se->conn.max_write - 1) / getpagesize() + 1;
+    }
+
+    /*
+     * Always enable big writes, this is superseded
+     * by the max_write option
+     */
+    outarg.flags |=3D FUSE_BIG_WRITES;
+
+    if (se->conn.want & FUSE_CAP_ASYNC_READ) {
+        outarg.flags |=3D FUSE_ASYNC_READ;
+    }
+    if (se->conn.want & FUSE_CAP_POSIX_LOCKS) {
+        outarg.flags |=3D FUSE_POSIX_LOCKS;
+    }
+    if (se->conn.want & FUSE_CAP_ATOMIC_O_TRUNC) {
+        outarg.flags |=3D FUSE_ATOMIC_O_TRUNC;
+    }
+    if (se->conn.want & FUSE_CAP_EXPORT_SUPPORT) {
+        outarg.flags |=3D FUSE_EXPORT_SUPPORT;
+    }
+    if (se->conn.want & FUSE_CAP_DONT_MASK) {
+        outarg.flags |=3D FUSE_DONT_MASK;
+    }
+    if (se->conn.want & FUSE_CAP_FLOCK_LOCKS) {
+        outarg.flags |=3D FUSE_FLOCK_LOCKS;
+    }
+    if (se->conn.want & FUSE_CAP_AUTO_INVAL_DATA) {
+        outarg.flags |=3D FUSE_AUTO_INVAL_DATA;
+    }
+    if (se->conn.want & FUSE_CAP_READDIRPLUS) {
+        outarg.flags |=3D FUSE_DO_READDIRPLUS;
+    }
+    if (se->conn.want & FUSE_CAP_READDIRPLUS_AUTO) {
+        outarg.flags |=3D FUSE_READDIRPLUS_AUTO;
+    }
+    if (se->conn.want & FUSE_CAP_ASYNC_DIO) {
+        outarg.flags |=3D FUSE_ASYNC_DIO;
+    }
+    if (se->conn.want & FUSE_CAP_WRITEBACK_CACHE) {
+        outarg.flags |=3D FUSE_WRITEBACK_CACHE;
+    }
+    if (se->conn.want & FUSE_CAP_POSIX_ACL) {
+        outarg.flags |=3D FUSE_POSIX_ACL;
+    }
+    outarg.max_readahead =3D se->conn.max_readahead;
+    outarg.max_write =3D se->conn.max_write;
+    if (se->conn.proto_minor >=3D 13) {
+        if (se->conn.max_background >=3D (1 << 16)) {
+            se->conn.max_background =3D (1 << 16) - 1;
+        }
+        if (se->conn.congestion_threshold > se->conn.max_background) {
+            se->conn.congestion_threshold =3D se->conn.max_background;
+        }
+        if (!se->conn.congestion_threshold) {
+            se->conn.congestion_threshold =3D se->conn.max_background * 3 =
/ 4;
+        }
+
+        outarg.max_background =3D se->conn.max_background;
+        outarg.congestion_threshold =3D se->conn.congestion_threshold;
+    }
+    if (se->conn.proto_minor >=3D 23) {
+        outarg.time_gran =3D se->conn.time_gran;
+    }
+
+    if (se->debug) {
+        fuse_log(FUSE_LOG_DEBUG, "   INIT: %u.%u\n", outarg.major,
+                 outarg.minor);
+        fuse_log(FUSE_LOG_DEBUG, "   flags=3D0x%08x\n", outarg.flags);
+        fuse_log(FUSE_LOG_DEBUG, "   max_readahead=3D0x%08x\n",
+                 outarg.max_readahead);
+        fuse_log(FUSE_LOG_DEBUG, "   max_write=3D0x%08x\n", outarg.max_wri=
te);
+        fuse_log(FUSE_LOG_DEBUG, "   max_background=3D%i\n",
+                 outarg.max_background);
+        fuse_log(FUSE_LOG_DEBUG, "   congestion_threshold=3D%i\n",
+                 outarg.congestion_threshold);
+        fuse_log(FUSE_LOG_DEBUG, "   time_gran=3D%u\n", outarg.time_gran);
+    }
+    if (arg->minor < 5) {
+        outargsize =3D FUSE_COMPAT_INIT_OUT_SIZE;
+    } else if (arg->minor < 23) {
+        outargsize =3D FUSE_COMPAT_22_INIT_OUT_SIZE;
+    }
+
+    send_reply_ok(req, &outarg, outargsize);
 }
=20
 static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const void *inar=
g)
 {
-=09struct fuse_session *se =3D req->se;
+    struct fuse_session *se =3D req->se;
=20
-=09(void) nodeid;
-=09(void) inarg;
+    (void)nodeid;
+    (void)inarg;
=20
-=09se->got_destroy =3D 1;
-=09if (se->op.destroy)
-=09=09se->op.destroy(se->userdata);
+    se->got_destroy =3D 1;
+    if (se->op.destroy) {
+        se->op.destroy(se->userdata);
+    }
=20
-=09send_reply_ok(req, NULL, 0);
+    send_reply_ok(req, NULL, 0);
 }
=20
 static void list_del_nreq(struct fuse_notify_req *nreq)
 {
-=09struct fuse_notify_req *prev =3D nreq->prev;
-=09struct fuse_notify_req *next =3D nreq->next;
-=09prev->next =3D next;
-=09next->prev =3D prev;
+    struct fuse_notify_req *prev =3D nreq->prev;
+    struct fuse_notify_req *next =3D nreq->next;
+    prev->next =3D next;
+    next->prev =3D prev;
 }
=20
 static void list_add_nreq(struct fuse_notify_req *nreq,
-=09=09=09  struct fuse_notify_req *next)
+                          struct fuse_notify_req *next)
 {
-=09struct fuse_notify_req *prev =3D next->prev;
-=09nreq->next =3D next;
-=09nreq->prev =3D prev;
-=09prev->next =3D nreq;
-=09next->prev =3D nreq;
+    struct fuse_notify_req *prev =3D next->prev;
+    nreq->next =3D next;
+    nreq->prev =3D prev;
+    prev->next =3D nreq;
+    next->prev =3D nreq;
 }
=20
 static void list_init_nreq(struct fuse_notify_req *nreq)
 {
-=09nreq->next =3D nreq;
-=09nreq->prev =3D nreq;
+    nreq->next =3D nreq;
+    nreq->prev =3D nreq;
 }
=20
 static void do_notify_reply(fuse_req_t req, fuse_ino_t nodeid,
-=09=09=09    const void *inarg, const struct fuse_buf *buf)
+                            const void *inarg, const struct fuse_buf *buf)
 {
-=09struct fuse_session *se =3D req->se;
-=09struct fuse_notify_req *nreq;
-=09struct fuse_notify_req *head;
+    struct fuse_session *se =3D req->se;
+    struct fuse_notify_req *nreq;
+    struct fuse_notify_req *head;
=20
-=09pthread_mutex_lock(&se->lock);
-=09head =3D &se->notify_list;
-=09for (nreq =3D head->next; nreq !=3D head; nreq =3D nreq->next) {
-=09=09if (nreq->unique =3D=3D req->unique) {
-=09=09=09list_del_nreq(nreq);
-=09=09=09break;
-=09=09}
-=09}
-=09pthread_mutex_unlock(&se->lock);
+    pthread_mutex_lock(&se->lock);
+    head =3D &se->notify_list;
+    for (nreq =3D head->next; nreq !=3D head; nreq =3D nreq->next) {
+        if (nreq->unique =3D=3D req->unique) {
+            list_del_nreq(nreq);
+            break;
+        }
+    }
+    pthread_mutex_unlock(&se->lock);
=20
-=09if (nreq !=3D head)
-=09=09nreq->reply(nreq, req, nodeid, inarg, buf);
+    if (nreq !=3D head) {
+        nreq->reply(nreq, req, nodeid, inarg, buf);
+    }
 }
=20
 static int send_notify_iov(struct fuse_session *se, int notify_code,
-=09=09=09   struct iovec *iov, int count)
+                           struct iovec *iov, int count)
 {
-=09struct fuse_out_header out;
+    struct fuse_out_header out;
=20
-=09if (!se->got_init)
-=09=09return -ENOTCONN;
+    if (!se->got_init) {
+        return -ENOTCONN;
+    }
=20
-=09out.unique =3D 0;
-=09out.error =3D notify_code;
-=09iov[0].iov_base =3D &out;
-=09iov[0].iov_len =3D sizeof(struct fuse_out_header);
+    out.unique =3D 0;
+    out.error =3D notify_code;
+    iov[0].iov_base =3D &out;
+    iov[0].iov_len =3D sizeof(struct fuse_out_header);
=20
-=09return fuse_send_msg(se, NULL, iov, count);
+    return fuse_send_msg(se, NULL, iov, count);
 }
=20
 int fuse_lowlevel_notify_poll(struct fuse_pollhandle *ph)
 {
-=09if (ph !=3D NULL) {
-=09=09struct fuse_notify_poll_wakeup_out outarg;
-=09=09struct iovec iov[2];
+    if (ph !=3D NULL) {
+        struct fuse_notify_poll_wakeup_out outarg;
+        struct iovec iov[2];
=20
-=09=09outarg.kh =3D ph->kh;
+        outarg.kh =3D ph->kh;
=20
-=09=09iov[1].iov_base =3D &outarg;
-=09=09iov[1].iov_len =3D sizeof(outarg);
+        iov[1].iov_base =3D &outarg;
+        iov[1].iov_len =3D sizeof(outarg);
=20
-=09=09return send_notify_iov(ph->se, FUSE_NOTIFY_POLL, iov, 2);
-=09} else {
-=09=09return 0;
-=09}
+        return send_notify_iov(ph->se, FUSE_NOTIFY_POLL, iov, 2);
+    } else {
+        return 0;
+    }
 }
=20
 int fuse_lowlevel_notify_inval_inode(struct fuse_session *se, fuse_ino_t i=
no,
-=09=09=09=09     off_t off, off_t len)
+                                     off_t off, off_t len)
 {
-=09struct fuse_notify_inval_inode_out outarg;
-=09struct iovec iov[2];
+    struct fuse_notify_inval_inode_out outarg;
+    struct iovec iov[2];
+
+    if (!se) {
+        return -EINVAL;
+    }
=20
-=09if (!se)
-=09=09return -EINVAL;
+    if (se->conn.proto_major < 6 || se->conn.proto_minor < 12) {
+        return -ENOSYS;
+    }
=20
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 12)
-=09=09return -ENOSYS;
-=09
-=09outarg.ino =3D ino;
-=09outarg.off =3D off;
-=09outarg.len =3D len;
+    outarg.ino =3D ino;
+    outarg.off =3D off;
+    outarg.len =3D len;
=20
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
+    iov[1].iov_base =3D &outarg;
+    iov[1].iov_len =3D sizeof(outarg);
=20
-=09return send_notify_iov(se, FUSE_NOTIFY_INVAL_INODE, iov, 2);
+    return send_notify_iov(se, FUSE_NOTIFY_INVAL_INODE, iov, 2);
 }
=20
 int fuse_lowlevel_notify_inval_entry(struct fuse_session *se, fuse_ino_t p=
arent,
-=09=09=09=09     const char *name, size_t namelen)
+                                     const char *name, size_t namelen)
 {
-=09struct fuse_notify_inval_entry_out outarg;
-=09struct iovec iov[3];
+    struct fuse_notify_inval_entry_out outarg;
+    struct iovec iov[3];
+
+    if (!se) {
+        return -EINVAL;
+    }
=20
-=09if (!se)
-=09=09return -EINVAL;
-=09
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 12)
-=09=09return -ENOSYS;
+    if (se->conn.proto_major < 6 || se->conn.proto_minor < 12) {
+        return -ENOSYS;
+    }
=20
-=09outarg.parent =3D parent;
-=09outarg.namelen =3D namelen;
-=09outarg.padding =3D 0;
+    outarg.parent =3D parent;
+    outarg.namelen =3D namelen;
+    outarg.padding =3D 0;
=20
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
-=09iov[2].iov_base =3D (void *)name;
-=09iov[2].iov_len =3D namelen + 1;
+    iov[1].iov_base =3D &outarg;
+    iov[1].iov_len =3D sizeof(outarg);
+    iov[2].iov_base =3D (void *)name;
+    iov[2].iov_len =3D namelen + 1;
=20
-=09return send_notify_iov(se, FUSE_NOTIFY_INVAL_ENTRY, iov, 3);
+    return send_notify_iov(se, FUSE_NOTIFY_INVAL_ENTRY, iov, 3);
 }
=20
-int fuse_lowlevel_notify_delete(struct fuse_session *se,
-=09=09=09=09fuse_ino_t parent, fuse_ino_t child,
-=09=09=09=09const char *name, size_t namelen)
+int fuse_lowlevel_notify_delete(struct fuse_session *se, fuse_ino_t parent=
,
+                                fuse_ino_t child, const char *name,
+                                size_t namelen)
 {
-=09struct fuse_notify_delete_out outarg;
-=09struct iovec iov[3];
+    struct fuse_notify_delete_out outarg;
+    struct iovec iov[3];
=20
-=09if (!se)
-=09=09return -EINVAL;
+    if (!se) {
+        return -EINVAL;
+    }
=20
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 18)
-=09=09return -ENOSYS;
+    if (se->conn.proto_major < 6 || se->conn.proto_minor < 18) {
+        return -ENOSYS;
+    }
=20
-=09outarg.parent =3D parent;
-=09outarg.child =3D child;
-=09outarg.namelen =3D namelen;
-=09outarg.padding =3D 0;
+    outarg.parent =3D parent;
+    outarg.child =3D child;
+    outarg.namelen =3D namelen;
+    outarg.padding =3D 0;
=20
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
-=09iov[2].iov_base =3D (void *)name;
-=09iov[2].iov_len =3D namelen + 1;
+    iov[1].iov_base =3D &outarg;
+    iov[1].iov_len =3D sizeof(outarg);
+    iov[2].iov_base =3D (void *)name;
+    iov[2].iov_len =3D namelen + 1;
=20
-=09return send_notify_iov(se, FUSE_NOTIFY_DELETE, iov, 3);
+    return send_notify_iov(se, FUSE_NOTIFY_DELETE, iov, 3);
 }
=20
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09       off_t offset, struct fuse_bufvec *bufv,
-=09=09=09       enum fuse_buf_copy_flags flags)
+                               off_t offset, struct fuse_bufvec *bufv,
+                               enum fuse_buf_copy_flags flags)
 {
-=09struct fuse_out_header out;
-=09struct fuse_notify_store_out outarg;
-=09struct iovec iov[3];
-=09size_t size =3D fuse_buf_size(bufv);
-=09int res;
+    struct fuse_out_header out;
+    struct fuse_notify_store_out outarg;
+    struct iovec iov[3];
+    size_t size =3D fuse_buf_size(bufv);
+    int res;
=20
-=09if (!se)
-=09=09return -EINVAL;
+    if (!se) {
+        return -EINVAL;
+    }
=20
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 15)
-=09=09return -ENOSYS;
+    if (se->conn.proto_major < 6 || se->conn.proto_minor < 15) {
+        return -ENOSYS;
+    }
=20
-=09out.unique =3D 0;
-=09out.error =3D FUSE_NOTIFY_STORE;
+    out.unique =3D 0;
+    out.error =3D FUSE_NOTIFY_STORE;
=20
-=09outarg.nodeid =3D ino;
-=09outarg.offset =3D offset;
-=09outarg.size =3D size;
-=09outarg.padding =3D 0;
+    outarg.nodeid =3D ino;
+    outarg.offset =3D offset;
+    outarg.size =3D size;
+    outarg.padding =3D 0;
=20
-=09iov[0].iov_base =3D &out;
-=09iov[0].iov_len =3D sizeof(out);
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
+    iov[0].iov_base =3D &out;
+    iov[0].iov_len =3D sizeof(out);
+    iov[1].iov_base =3D &outarg;
+    iov[1].iov_len =3D sizeof(outarg);
=20
-=09res =3D fuse_send_data_iov(se, NULL, iov, 2, bufv, flags);
-=09if (res > 0)
-=09=09res =3D -res;
+    res =3D fuse_send_data_iov(se, NULL, iov, 2, bufv, flags);
+    if (res > 0) {
+        res =3D -res;
+    }
=20
-=09return res;
+    return res;
 }
=20
 struct fuse_retrieve_req {
-=09struct fuse_notify_req nreq;
-=09void *cookie;
+    struct fuse_notify_req nreq;
+    void *cookie;
 };
=20
-static void fuse_ll_retrieve_reply(struct fuse_notify_req *nreq,
-=09=09=09=09   fuse_req_t req, fuse_ino_t ino,
-=09=09=09=09   const void *inarg,
-=09=09=09=09   const struct fuse_buf *ibuf)
-{
-=09struct fuse_session *se =3D req->se;
-=09struct fuse_retrieve_req *rreq =3D
-=09=09container_of(nreq, struct fuse_retrieve_req, nreq);
-=09const struct fuse_notify_retrieve_in *arg =3D inarg;
-=09struct fuse_bufvec bufv =3D {
-=09=09.buf[0] =3D *ibuf,
-=09=09.count =3D 1,
-=09};
-
-=09if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD))
-=09=09bufv.buf[0].mem =3D PARAM(arg);
-
-=09bufv.buf[0].size -=3D sizeof(struct fuse_in_header) +
-=09=09sizeof(struct fuse_notify_retrieve_in);
-
-=09if (bufv.buf[0].size < arg->size) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: retrieve reply: buffer size too small\=
n");
-=09=09fuse_reply_none(req);
-=09=09goto out;
-=09}
-=09bufv.buf[0].size =3D arg->size;
-
-=09if (se->op.retrieve_reply) {
-=09=09se->op.retrieve_reply(req, rreq->cookie, ino,
-=09=09=09=09=09  arg->offset, &bufv);
-=09} else {
-=09=09fuse_reply_none(req);
-=09}
+static void fuse_ll_retrieve_reply(struct fuse_notify_req *nreq, fuse_req_=
t req,
+                                   fuse_ino_t ino, const void *inarg,
+                                   const struct fuse_buf *ibuf)
+{
+    struct fuse_session *se =3D req->se;
+    struct fuse_retrieve_req *rreq =3D
+        container_of(nreq, struct fuse_retrieve_req, nreq);
+    const struct fuse_notify_retrieve_in *arg =3D inarg;
+    struct fuse_bufvec bufv =3D {
+        .buf[0] =3D *ibuf,
+        .count =3D 1,
+    };
+
+    if (!(bufv.buf[0].flags & FUSE_BUF_IS_FD)) {
+        bufv.buf[0].mem =3D PARAM(arg);
+    }
+
+    bufv.buf[0].size -=3D
+        sizeof(struct fuse_in_header) + sizeof(struct fuse_notify_retrieve=
_in);
+
+    if (bufv.buf[0].size < arg->size) {
+        fuse_log(FUSE_LOG_ERR, "fuse: retrieve reply: buffer size too smal=
l\n");
+        fuse_reply_none(req);
+        goto out;
+    }
+    bufv.buf[0].size =3D arg->size;
+
+    if (se->op.retrieve_reply) {
+        se->op.retrieve_reply(req, rreq->cookie, ino, arg->offset, &bufv);
+    } else {
+        fuse_reply_none(req);
+    }
 out:
-=09free(rreq);
+    free(rreq);
 }
=20
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09=09  size_t size, off_t offset, void *cookie)
+                                  size_t size, off_t offset, void *cookie)
 {
-=09struct fuse_notify_retrieve_out outarg;
-=09struct iovec iov[2];
-=09struct fuse_retrieve_req *rreq;
-=09int err;
+    struct fuse_notify_retrieve_out outarg;
+    struct iovec iov[2];
+    struct fuse_retrieve_req *rreq;
+    int err;
=20
-=09if (!se)
-=09=09return -EINVAL;
+    if (!se) {
+        return -EINVAL;
+    }
=20
-=09if (se->conn.proto_major < 6 || se->conn.proto_minor < 15)
-=09=09return -ENOSYS;
+    if (se->conn.proto_major < 6 || se->conn.proto_minor < 15) {
+        return -ENOSYS;
+    }
=20
-=09rreq =3D malloc(sizeof(*rreq));
-=09if (rreq =3D=3D NULL)
-=09=09return -ENOMEM;
+    rreq =3D malloc(sizeof(*rreq));
+    if (rreq =3D=3D NULL) {
+        return -ENOMEM;
+    }
=20
-=09pthread_mutex_lock(&se->lock);
-=09rreq->cookie =3D cookie;
-=09rreq->nreq.unique =3D se->notify_ctr++;
-=09rreq->nreq.reply =3D fuse_ll_retrieve_reply;
-=09list_add_nreq(&rreq->nreq, &se->notify_list);
-=09pthread_mutex_unlock(&se->lock);
+    pthread_mutex_lock(&se->lock);
+    rreq->cookie =3D cookie;
+    rreq->nreq.unique =3D se->notify_ctr++;
+    rreq->nreq.reply =3D fuse_ll_retrieve_reply;
+    list_add_nreq(&rreq->nreq, &se->notify_list);
+    pthread_mutex_unlock(&se->lock);
=20
-=09outarg.notify_unique =3D rreq->nreq.unique;
-=09outarg.nodeid =3D ino;
-=09outarg.offset =3D offset;
-=09outarg.size =3D size;
-=09outarg.padding =3D 0;
+    outarg.notify_unique =3D rreq->nreq.unique;
+    outarg.nodeid =3D ino;
+    outarg.offset =3D offset;
+    outarg.size =3D size;
+    outarg.padding =3D 0;
=20
-=09iov[1].iov_base =3D &outarg;
-=09iov[1].iov_len =3D sizeof(outarg);
+    iov[1].iov_base =3D &outarg;
+    iov[1].iov_len =3D sizeof(outarg);
=20
-=09err =3D send_notify_iov(se, FUSE_NOTIFY_RETRIEVE, iov, 2);
-=09if (err) {
-=09=09pthread_mutex_lock(&se->lock);
-=09=09list_del_nreq(&rreq->nreq);
-=09=09pthread_mutex_unlock(&se->lock);
-=09=09free(rreq);
-=09}
+    err =3D send_notify_iov(se, FUSE_NOTIFY_RETRIEVE, iov, 2);
+    if (err) {
+        pthread_mutex_lock(&se->lock);
+        list_del_nreq(&rreq->nreq);
+        pthread_mutex_unlock(&se->lock);
+        free(rreq);
+    }
=20
-=09return err;
+    return err;
 }
=20
 void *fuse_req_userdata(fuse_req_t req)
 {
-=09return req->se->userdata;
+    return req->se->userdata;
 }
=20
 const struct fuse_ctx *fuse_req_ctx(fuse_req_t req)
 {
-=09return &req->ctx;
+    return &req->ctx;
 }
=20
 void fuse_req_interrupt_func(fuse_req_t req, fuse_interrupt_func_t func,
-=09=09=09     void *data)
+                             void *data)
 {
-=09pthread_mutex_lock(&req->lock);
-=09pthread_mutex_lock(&req->se->lock);
-=09req->u.ni.func =3D func;
-=09req->u.ni.data =3D data;
-=09pthread_mutex_unlock(&req->se->lock);
-=09if (req->interrupted && func)
-=09=09func(req, data);
-=09pthread_mutex_unlock(&req->lock);
+    pthread_mutex_lock(&req->lock);
+    pthread_mutex_lock(&req->se->lock);
+    req->u.ni.func =3D func;
+    req->u.ni.data =3D data;
+    pthread_mutex_unlock(&req->se->lock);
+    if (req->interrupted && func) {
+        func(req, data);
+    }
+    pthread_mutex_unlock(&req->lock);
 }
=20
 int fuse_req_interrupted(fuse_req_t req)
 {
-=09int interrupted;
+    int interrupted;
=20
-=09pthread_mutex_lock(&req->se->lock);
-=09interrupted =3D req->interrupted;
-=09pthread_mutex_unlock(&req->se->lock);
+    pthread_mutex_lock(&req->se->lock);
+    interrupted =3D req->interrupted;
+    pthread_mutex_unlock(&req->se->lock);
=20
-=09return interrupted;
+    return interrupted;
 }
=20
 static struct {
-=09void (*func)(fuse_req_t, fuse_ino_t, const void *);
-=09const char *name;
+    void (*func)(fuse_req_t, fuse_ino_t, const void *);
+    const char *name;
 } fuse_ll_ops[] =3D {
-=09[FUSE_LOOKUP]=09   =3D { do_lookup,      "LOOKUP"=09     },
-=09[FUSE_FORGET]=09   =3D { do_forget,      "FORGET"=09     },
-=09[FUSE_GETATTR]=09   =3D { do_getattr,     "GETATTR"     },
-=09[FUSE_SETATTR]=09   =3D { do_setattr,     "SETATTR"     },
-=09[FUSE_READLINK]=09   =3D { do_readlink,    "READLINK"    },
-=09[FUSE_SYMLINK]=09   =3D { do_symlink,     "SYMLINK"     },
-=09[FUSE_MKNOD]=09   =3D { do_mknod,       "MKNOD"=09     },
-=09[FUSE_MKDIR]=09   =3D { do_mkdir,       "MKDIR"=09     },
-=09[FUSE_UNLINK]=09   =3D { do_unlink,      "UNLINK"=09     },
-=09[FUSE_RMDIR]=09   =3D { do_rmdir,       "RMDIR"=09     },
-=09[FUSE_RENAME]=09   =3D { do_rename,      "RENAME"=09     },
-=09[FUSE_LINK]=09   =3D { do_link,=09       "LINK"=09     },
-=09[FUSE_OPEN]=09   =3D { do_open,=09       "OPEN"=09     },
-=09[FUSE_READ]=09   =3D { do_read,=09       "READ"=09     },
-=09[FUSE_WRITE]=09   =3D { do_write,       "WRITE"=09     },
-=09[FUSE_STATFS]=09   =3D { do_statfs,      "STATFS"=09     },
-=09[FUSE_RELEASE]=09   =3D { do_release,     "RELEASE"     },
-=09[FUSE_FSYNC]=09   =3D { do_fsync,       "FSYNC"=09     },
-=09[FUSE_SETXATTR]=09   =3D { do_setxattr,    "SETXATTR"    },
-=09[FUSE_GETXATTR]=09   =3D { do_getxattr,    "GETXATTR"    },
-=09[FUSE_LISTXATTR]   =3D { do_listxattr,   "LISTXATTR"   },
-=09[FUSE_REMOVEXATTR] =3D { do_removexattr, "REMOVEXATTR" },
-=09[FUSE_FLUSH]=09   =3D { do_flush,       "FLUSH"=09     },
-=09[FUSE_INIT]=09   =3D { do_init,=09       "INIT"=09     },
-=09[FUSE_OPENDIR]=09   =3D { do_opendir,     "OPENDIR"     },
-=09[FUSE_READDIR]=09   =3D { do_readdir,     "READDIR"     },
-=09[FUSE_RELEASEDIR]  =3D { do_releasedir,  "RELEASEDIR"  },
-=09[FUSE_FSYNCDIR]=09   =3D { do_fsyncdir,    "FSYNCDIR"    },
-=09[FUSE_GETLK]=09   =3D { do_getlk,       "GETLK"=09     },
-=09[FUSE_SETLK]=09   =3D { do_setlk,       "SETLK"=09     },
-=09[FUSE_SETLKW]=09   =3D { do_setlkw,      "SETLKW"=09     },
-=09[FUSE_ACCESS]=09   =3D { do_access,      "ACCESS"=09     },
-=09[FUSE_CREATE]=09   =3D { do_create,      "CREATE"=09     },
-=09[FUSE_INTERRUPT]   =3D { do_interrupt,   "INTERRUPT"   },
-=09[FUSE_BMAP]=09   =3D { do_bmap,=09       "BMAP"=09     },
-=09[FUSE_IOCTL]=09   =3D { do_ioctl,       "IOCTL"=09     },
-=09[FUSE_POLL]=09   =3D { do_poll,        "POLL"=09     },
-=09[FUSE_FALLOCATE]   =3D { do_fallocate,   "FALLOCATE"   },
-=09[FUSE_DESTROY]=09   =3D { do_destroy,     "DESTROY"     },
-=09[FUSE_NOTIFY_REPLY] =3D { (void *) 1,    "NOTIFY_REPLY" },
-=09[FUSE_BATCH_FORGET] =3D { do_batch_forget, "BATCH_FORGET" },
-=09[FUSE_READDIRPLUS] =3D { do_readdirplus,=09"READDIRPLUS"},
-=09[FUSE_RENAME2]     =3D { do_rename2,      "RENAME2"    },
-=09[FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" },
-=09[FUSE_LSEEK]=09   =3D { do_lseek,       "LSEEK"=09     },
-=09[CUSE_INIT]=09   =3D { cuse_lowlevel_init, "CUSE_INIT"   },
+    [FUSE_LOOKUP] =3D { do_lookup, "LOOKUP" },
+    [FUSE_FORGET] =3D { do_forget, "FORGET" },
+    [FUSE_GETATTR] =3D { do_getattr, "GETATTR" },
+    [FUSE_SETATTR] =3D { do_setattr, "SETATTR" },
+    [FUSE_READLINK] =3D { do_readlink, "READLINK" },
+    [FUSE_SYMLINK] =3D { do_symlink, "SYMLINK" },
+    [FUSE_MKNOD] =3D { do_mknod, "MKNOD" },
+    [FUSE_MKDIR] =3D { do_mkdir, "MKDIR" },
+    [FUSE_UNLINK] =3D { do_unlink, "UNLINK" },
+    [FUSE_RMDIR] =3D { do_rmdir, "RMDIR" },
+    [FUSE_RENAME] =3D { do_rename, "RENAME" },
+    [FUSE_LINK] =3D { do_link, "LINK" },
+    [FUSE_OPEN] =3D { do_open, "OPEN" },
+    [FUSE_READ] =3D { do_read, "READ" },
+    [FUSE_WRITE] =3D { do_write, "WRITE" },
+    [FUSE_STATFS] =3D { do_statfs, "STATFS" },
+    [FUSE_RELEASE] =3D { do_release, "RELEASE" },
+    [FUSE_FSYNC] =3D { do_fsync, "FSYNC" },
+    [FUSE_SETXATTR] =3D { do_setxattr, "SETXATTR" },
+    [FUSE_GETXATTR] =3D { do_getxattr, "GETXATTR" },
+    [FUSE_LISTXATTR] =3D { do_listxattr, "LISTXATTR" },
+    [FUSE_REMOVEXATTR] =3D { do_removexattr, "REMOVEXATTR" },
+    [FUSE_FLUSH] =3D { do_flush, "FLUSH" },
+    [FUSE_INIT] =3D { do_init, "INIT" },
+    [FUSE_OPENDIR] =3D { do_opendir, "OPENDIR" },
+    [FUSE_READDIR] =3D { do_readdir, "READDIR" },
+    [FUSE_RELEASEDIR] =3D { do_releasedir, "RELEASEDIR" },
+    [FUSE_FSYNCDIR] =3D { do_fsyncdir, "FSYNCDIR" },
+    [FUSE_GETLK] =3D { do_getlk, "GETLK" },
+    [FUSE_SETLK] =3D { do_setlk, "SETLK" },
+    [FUSE_SETLKW] =3D { do_setlkw, "SETLKW" },
+    [FUSE_ACCESS] =3D { do_access, "ACCESS" },
+    [FUSE_CREATE] =3D { do_create, "CREATE" },
+    [FUSE_INTERRUPT] =3D { do_interrupt, "INTERRUPT" },
+    [FUSE_BMAP] =3D { do_bmap, "BMAP" },
+    [FUSE_IOCTL] =3D { do_ioctl, "IOCTL" },
+    [FUSE_POLL] =3D { do_poll, "POLL" },
+    [FUSE_FALLOCATE] =3D { do_fallocate, "FALLOCATE" },
+    [FUSE_DESTROY] =3D { do_destroy, "DESTROY" },
+    [FUSE_NOTIFY_REPLY] =3D { (void *)1, "NOTIFY_REPLY" },
+    [FUSE_BATCH_FORGET] =3D { do_batch_forget, "BATCH_FORGET" },
+    [FUSE_READDIRPLUS] =3D { do_readdirplus, "READDIRPLUS" },
+    [FUSE_RENAME2] =3D { do_rename2, "RENAME2" },
+    [FUSE_COPY_FILE_RANGE] =3D { do_copy_file_range, "COPY_FILE_RANGE" },
+    [FUSE_LSEEK] =3D { do_lseek, "LSEEK" },
+    [CUSE_INIT] =3D { cuse_lowlevel_init, "CUSE_INIT" },
 };
=20
 #define FUSE_MAXOP (sizeof(fuse_ll_ops) / sizeof(fuse_ll_ops[0]))
=20
 static const char *opname(enum fuse_opcode opcode)
 {
-=09if (opcode >=3D FUSE_MAXOP || !fuse_ll_ops[opcode].name)
-=09=09return "???";
-=09else
-=09=09return fuse_ll_ops[opcode].name;
+    if (opcode >=3D FUSE_MAXOP || !fuse_ll_ops[opcode].name) {
+        return "???";
+    } else {
+        return fuse_ll_ops[opcode].name;
+    }
 }
=20
 void fuse_session_process_buf(struct fuse_session *se,
-=09=09=09      const struct fuse_buf *buf)
+                              const struct fuse_buf *buf)
 {
-=09fuse_session_process_buf_int(se, buf, NULL);
+    fuse_session_process_buf_int(se, buf, NULL);
 }
=20
 void fuse_session_process_buf_int(struct fuse_session *se,
-=09=09=09=09  const struct fuse_buf *buf, struct fuse_chan *ch)
-{
-=09struct fuse_in_header *in;
-=09const void *inarg;
-=09struct fuse_req *req;
-=09int err;
-
-=09in =3D buf->mem;
-
-=09if (se->debug) {
-=09=09fuse_log(FUSE_LOG_DEBUG,
-=09=09=09"unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu, pid: %=
u\n",
-=09=09=09(unsigned long long) in->unique,
-=09=09=09opname((enum fuse_opcode) in->opcode), in->opcode,
-=09=09=09(unsigned long long) in->nodeid, buf->size, in->pid);
-=09}
-
-=09req =3D fuse_ll_alloc_req(se);
-=09if (req =3D=3D NULL) {
-=09=09struct fuse_out_header out =3D {
-=09=09=09.unique =3D in->unique,
-=09=09=09.error =3D -ENOMEM,
-=09=09};
-=09=09struct iovec iov =3D {
-=09=09=09.iov_base =3D &out,
-=09=09=09.iov_len =3D sizeof(struct fuse_out_header),
-=09=09};
-
-=09=09fuse_send_msg(se, ch, &iov, 1);
-=09=09return;
-=09}
-
-=09req->unique =3D in->unique;
-=09req->ctx.uid =3D in->uid;
-=09req->ctx.gid =3D in->gid;
-=09req->ctx.pid =3D in->pid;
-=09req->ch =3D ch ? fuse_chan_get(ch) : NULL;
-
-=09err =3D EIO;
-=09if (!se->got_init) {
-=09=09enum fuse_opcode expected;
-
-=09=09expected =3D se->cuse_data ? CUSE_INIT : FUSE_INIT;
-=09=09if (in->opcode !=3D expected)
-=09=09=09goto reply_err;
-=09} else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT)
-=09=09goto reply_err;
-
-=09err =3D EACCES;
-=09/* Implement -o allow_root */
-=09if (se->deny_others && in->uid !=3D se->owner && in->uid !=3D 0 &&
-=09=09 in->opcode !=3D FUSE_INIT && in->opcode !=3D FUSE_READ &&
-=09=09 in->opcode !=3D FUSE_WRITE && in->opcode !=3D FUSE_FSYNC &&
-=09=09 in->opcode !=3D FUSE_RELEASE && in->opcode !=3D FUSE_READDIR &&
-=09=09 in->opcode !=3D FUSE_FSYNCDIR && in->opcode !=3D FUSE_RELEASEDIR &&
-=09=09 in->opcode !=3D FUSE_NOTIFY_REPLY &&
-=09=09 in->opcode !=3D FUSE_READDIRPLUS)
-=09=09goto reply_err;
-
-=09err =3D ENOSYS;
-=09if (in->opcode >=3D FUSE_MAXOP || !fuse_ll_ops[in->opcode].func)
-=09=09goto reply_err;
-=09if (in->opcode !=3D FUSE_INTERRUPT) {
-=09=09struct fuse_req *intr;
-=09=09pthread_mutex_lock(&se->lock);
-=09=09intr =3D check_interrupt(se, req);
-=09=09list_add_req(req, &se->list);
-=09=09pthread_mutex_unlock(&se->lock);
-=09=09if (intr)
-=09=09=09fuse_reply_err(intr, EAGAIN);
-=09}
-
-=09inarg =3D (void *) &in[1];
-=09if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf)
-=09=09do_write_buf(req, in->nodeid, inarg, buf);
-=09else if (in->opcode =3D=3D FUSE_NOTIFY_REPLY)
-=09=09do_notify_reply(req, in->nodeid, inarg, buf);
-=09else
-=09=09fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
-
-=09return;
+                                  const struct fuse_buf *buf,
+                                  struct fuse_chan *ch)
+{
+    struct fuse_in_header *in;
+    const void *inarg;
+    struct fuse_req *req;
+    int err;
+
+    in =3D buf->mem;
+
+    if (se->debug) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "unique: %llu, opcode: %s (%i), nodeid: %llu, insize: %zu=
, "
+                 "pid: %u\n",
+                 (unsigned long long)in->unique,
+                 opname((enum fuse_opcode)in->opcode), in->opcode,
+                 (unsigned long long)in->nodeid, buf->size, in->pid);
+    }
+
+    req =3D fuse_ll_alloc_req(se);
+    if (req =3D=3D NULL) {
+        struct fuse_out_header out =3D {
+            .unique =3D in->unique,
+            .error =3D -ENOMEM,
+        };
+        struct iovec iov =3D {
+            .iov_base =3D &out,
+            .iov_len =3D sizeof(struct fuse_out_header),
+        };
+
+        fuse_send_msg(se, ch, &iov, 1);
+        return;
+    }
+
+    req->unique =3D in->unique;
+    req->ctx.uid =3D in->uid;
+    req->ctx.gid =3D in->gid;
+    req->ctx.pid =3D in->pid;
+    req->ch =3D ch ? fuse_chan_get(ch) : NULL;
+
+    err =3D EIO;
+    if (!se->got_init) {
+        enum fuse_opcode expected;
+
+        expected =3D se->cuse_data ? CUSE_INIT : FUSE_INIT;
+        if (in->opcode !=3D expected) {
+            goto reply_err;
+        }
+    } else if (in->opcode =3D=3D FUSE_INIT || in->opcode =3D=3D CUSE_INIT)=
 {
+        goto reply_err;
+    }
+
+    err =3D EACCES;
+    /* Implement -o allow_root */
+    if (se->deny_others && in->uid !=3D se->owner && in->uid !=3D 0 &&
+        in->opcode !=3D FUSE_INIT && in->opcode !=3D FUSE_READ &&
+        in->opcode !=3D FUSE_WRITE && in->opcode !=3D FUSE_FSYNC &&
+        in->opcode !=3D FUSE_RELEASE && in->opcode !=3D FUSE_READDIR &&
+        in->opcode !=3D FUSE_FSYNCDIR && in->opcode !=3D FUSE_RELEASEDIR &=
&
+        in->opcode !=3D FUSE_NOTIFY_REPLY && in->opcode !=3D FUSE_READDIRP=
LUS) {
+        goto reply_err;
+    }
+
+    err =3D ENOSYS;
+    if (in->opcode >=3D FUSE_MAXOP || !fuse_ll_ops[in->opcode].func) {
+        goto reply_err;
+    }
+    if (in->opcode !=3D FUSE_INTERRUPT) {
+        struct fuse_req *intr;
+        pthread_mutex_lock(&se->lock);
+        intr =3D check_interrupt(se, req);
+        list_add_req(req, &se->list);
+        pthread_mutex_unlock(&se->lock);
+        if (intr) {
+            fuse_reply_err(intr, EAGAIN);
+        }
+    }
+
+    inarg =3D (void *)&in[1];
+    if (in->opcode =3D=3D FUSE_WRITE && se->op.write_buf) {
+        do_write_buf(req, in->nodeid, inarg, buf);
+    } else if (in->opcode =3D=3D FUSE_NOTIFY_REPLY) {
+        do_notify_reply(req, in->nodeid, inarg, buf);
+    } else {
+        fuse_ll_ops[in->opcode].func(req, in->nodeid, inarg);
+    }
+
+    return;
=20
 reply_err:
-=09fuse_reply_err(req, err);
+    fuse_reply_err(req, err);
 }
=20
-#define LL_OPTION(n,o,v) \
-=09{ n, offsetof(struct fuse_session, o), v }
+#define LL_OPTION(n, o, v)                     \
+    {                                          \
+        n, offsetof(struct fuse_session, o), v \
+    }
=20
 static const struct fuse_opt fuse_ll_opts[] =3D {
-=09LL_OPTION("debug", debug, 1),
-=09LL_OPTION("-d", debug, 1),
-=09LL_OPTION("--debug", debug, 1),
-=09LL_OPTION("allow_root", deny_others, 1),
-=09FUSE_OPT_END
+    LL_OPTION("debug", debug, 1), LL_OPTION("-d", debug, 1),
+    LL_OPTION("--debug", debug, 1), LL_OPTION("allow_root", deny_others, 1=
),
+    FUSE_OPT_END
 };
=20
 void fuse_lowlevel_version(void)
 {
-=09printf("using FUSE kernel interface version %i.%i\n",
-=09       FUSE_KERNEL_VERSION, FUSE_KERNEL_MINOR_VERSION);
-=09fuse_mount_version();
+    printf("using FUSE kernel interface version %i.%i\n", FUSE_KERNEL_VERS=
ION,
+           FUSE_KERNEL_MINOR_VERSION);
+    fuse_mount_version();
 }
=20
 void fuse_lowlevel_help(void)
 {
-=09/* These are not all options, but the ones that are
-=09   potentially of interest to an end-user */
-=09printf(
-"    -o allow_other         allow access by all users\n"
-"    -o allow_root          allow access by root\n"
-"    -o auto_unmount        auto unmount on process termination\n");
+    /*
+     * These are not all options, but the ones that are
+     * potentially of interest to an end-user
+     */
+    printf("    -o allow_other         allow access by all users\n"
+           "    -o allow_root          allow access by root\n"
+           "    -o auto_unmount        auto unmount on process termination=
\n");
 }
=20
 void fuse_session_destroy(struct fuse_session *se)
 {
-=09if (se->got_init && !se->got_destroy) {
-=09=09if (se->op.destroy)
-=09=09=09se->op.destroy(se->userdata);
-=09}
-=09pthread_mutex_destroy(&se->lock);
-=09free(se->cuse_data);
-=09if (se->fd !=3D -1)
-=09=09close(se->fd);
-=09free(se);
+    if (se->got_init && !se->got_destroy) {
+        if (se->op.destroy) {
+            se->op.destroy(se->userdata);
+        }
+    }
+    pthread_mutex_destroy(&se->lock);
+    free(se->cuse_data);
+    if (se->fd !=3D -1) {
+        close(se->fd);
+    }
+    free(se);
 }
=20
=20
 struct fuse_session *fuse_session_new(struct fuse_args *args,
-=09=09=09=09      const struct fuse_lowlevel_ops *op,
-=09=09=09=09      size_t op_size, void *userdata)
-{
-=09struct fuse_session *se;
-
-=09if (sizeof(struct fuse_lowlevel_ops) < op_size) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: library too old, some operati=
ons may not work\n");
-=09=09op_size =3D sizeof(struct fuse_lowlevel_ops);
-=09}
-
-=09if (args->argc =3D=3D 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: empty argv passed to fuse_session_new(=
).\n");
-=09=09return NULL;
-=09}
-
-=09se =3D (struct fuse_session *) calloc(1, sizeof(struct fuse_session));
-=09if (se =3D=3D NULL) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate fuse object\n");
-=09=09goto out1;
-=09}
-=09se->fd =3D -1;
-=09se->conn.max_write =3D UINT_MAX;
-=09se->conn.max_readahead =3D UINT_MAX;
-
-=09/* Parse options */
-=09if(fuse_opt_parse(args, se, fuse_ll_opts, NULL) =3D=3D -1)
-=09=09goto out2;
-=09if(se->deny_others) {
-=09=09/* Allowing access only by root is done by instructing
-=09=09 * kernel to allow access by everyone, and then restricting
-=09=09 * access to root and mountpoint owner in libfuse.
-=09=09 */
-=09=09// We may be adding the option a second time, but
-=09=09// that doesn't hurt.
-=09=09if(fuse_opt_add_arg(args, "-oallow_other") =3D=3D -1)
-=09=09=09goto out2;
-=09}
-=09if(args->argc =3D=3D 1 &&
-=09   args->argv[0][0] =3D=3D '-') {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: warning: argv[0] looks like an option,=
 but "
-=09=09=09"will be ignored\n");
-=09} else if (args->argc !=3D 1) {
-=09=09int i;
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: unknown option(s): `");
-=09=09for(i =3D 1; i < args->argc-1; i++)
-=09=09=09fuse_log(FUSE_LOG_ERR, "%s ", args->argv[i]);
-=09=09fuse_log(FUSE_LOG_ERR, "%s'\n", args->argv[i]);
-=09=09goto out4;
-=09}
-
-=09if (se->debug)
-=09=09fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_VERSI=
ON);
-
-=09se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() +
-=09=09FUSE_BUFFER_HEADER_SIZE;
-
-=09list_init_req(&se->list);
-=09list_init_req(&se->interrupts);
-=09list_init_nreq(&se->notify_list);
-=09se->notify_ctr =3D 1;
-=09fuse_mutex_init(&se->lock);
-
-=09memcpy(&se->op, op, op_size);
-=09se->owner =3D getuid();
-=09se->userdata =3D userdata;
-
-=09return se;
+                                      const struct fuse_lowlevel_ops *op,
+                                      size_t op_size, void *userdata)
+{
+    struct fuse_session *se;
+
+    if (sizeof(struct fuse_lowlevel_ops) < op_size) {
+        fuse_log(
+            FUSE_LOG_ERR,
+            "fuse: warning: library too old, some operations may not work\=
n");
+        op_size =3D sizeof(struct fuse_lowlevel_ops);
+    }
+
+    if (args->argc =3D=3D 0) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: empty argv passed to fuse_session_new().\n");
+        return NULL;
+    }
+
+    se =3D (struct fuse_session *)calloc(1, sizeof(struct fuse_session));
+    if (se =3D=3D NULL) {
+        fuse_log(FUSE_LOG_ERR, "fuse: failed to allocate fuse object\n");
+        goto out1;
+    }
+    se->fd =3D -1;
+    se->conn.max_write =3D UINT_MAX;
+    se->conn.max_readahead =3D UINT_MAX;
+
+    /* Parse options */
+    if (fuse_opt_parse(args, se, fuse_ll_opts, NULL) =3D=3D -1) {
+        goto out2;
+    }
+    if (se->deny_others) {
+        /*
+         * Allowing access only by root is done by instructing
+         * kernel to allow access by everyone, and then restricting
+         * access to root and mountpoint owner in libfuse.
+         */
+        /*
+         * We may be adding the option a second time, but
+         * that doesn't hurt.
+         */
+        if (fuse_opt_add_arg(args, "-oallow_other") =3D=3D -1) {
+            goto out2;
+        }
+    }
+    if (args->argc =3D=3D 1 && args->argv[0][0] =3D=3D '-') {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: warning: argv[0] looks like an option, but "
+                 "will be ignored\n");
+    } else if (args->argc !=3D 1) {
+        int i;
+        fuse_log(FUSE_LOG_ERR, "fuse: unknown option(s): `");
+        for (i =3D 1; i < args->argc - 1; i++) {
+            fuse_log(FUSE_LOG_ERR, "%s ", args->argv[i]);
+        }
+        fuse_log(FUSE_LOG_ERR, "%s'\n", args->argv[i]);
+        goto out4;
+    }
+
+    if (se->debug) {
+        fuse_log(FUSE_LOG_DEBUG, "FUSE library version: %s\n", PACKAGE_VER=
SION);
+    }
+
+    se->bufsize =3D FUSE_MAX_MAX_PAGES * getpagesize() + FUSE_BUFFER_HEADE=
R_SIZE;
+
+    list_init_req(&se->list);
+    list_init_req(&se->interrupts);
+    list_init_nreq(&se->notify_list);
+    se->notify_ctr =3D 1;
+    fuse_mutex_init(&se->lock);
+
+    memcpy(&se->op, op, op_size);
+    se->owner =3D getuid();
+    se->userdata =3D userdata;
+
+    return se;
=20
 out4:
-=09fuse_opt_free_args(args);
+    fuse_opt_free_args(args);
 out2:
-=09free(se);
+    free(se);
 out1:
-=09return NULL;
+    return NULL;
 }
=20
 int fuse_session_mount(struct fuse_session *se, const char *mountpoint)
 {
-=09int fd;
-
-=09/*
-=09 * Make sure file descriptors 0, 1 and 2 are open, otherwise chaos
-=09 * would ensue.
-=09 */
-=09do {
-=09=09fd =3D open("/dev/null", O_RDWR);
-=09=09if (fd > 2)
-=09=09=09close(fd);
-=09} while (fd >=3D 0 && fd <=3D 2);
-
-=09/*
-=09 * To allow FUSE daemons to run without privileges, the caller may open
-=09 * /dev/fuse before launching the file system and pass on the file
-=09 * descriptor by specifying /dev/fd/N as the mount point. Note that the
-=09 * parent process takes care of performing the mount in this case.
-=09 */
-=09fd =3D fuse_mnt_parse_fuse_fd(mountpoint);
-=09if (fd !=3D -1) {
-=09=09if (fcntl(fd, F_GETFD) =3D=3D -1) {
-=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09"fuse: Invalid file descriptor /dev/fd/%u\n",
-=09=09=09=09fd);
-=09=09=09return -1;
-=09=09}
-=09=09se->fd =3D fd;
-=09=09return 0;
-=09}
-
-=09/* Open channel */
-=09fd =3D fuse_kern_mount(mountpoint, se->mo);
-=09if (fd =3D=3D -1)
-=09=09return -1;
-=09se->fd =3D fd;
-
-=09/* Save mountpoint */
-=09se->mountpoint =3D strdup(mountpoint);
-=09if (se->mountpoint =3D=3D NULL)
-=09=09goto error_out;
-
-=09return 0;
+    int fd;
+
+    /*
+     * Make sure file descriptors 0, 1 and 2 are open, otherwise chaos
+     * would ensue.
+     */
+    do {
+        fd =3D open("/dev/null", O_RDWR);
+        if (fd > 2) {
+            close(fd);
+        }
+    } while (fd >=3D 0 && fd <=3D 2);
+
+    /*
+     * To allow FUSE daemons to run without privileges, the caller may ope=
n
+     * /dev/fuse before launching the file system and pass on the file
+     * descriptor by specifying /dev/fd/N as the mount point. Note that th=
e
+     * parent process takes care of performing the mount in this case.
+     */
+    fd =3D fuse_mnt_parse_fuse_fd(mountpoint);
+    if (fd !=3D -1) {
+        if (fcntl(fd, F_GETFD) =3D=3D -1) {
+            fuse_log(FUSE_LOG_ERR, "fuse: Invalid file descriptor /dev/fd/=
%u\n",
+                     fd);
+            return -1;
+        }
+        se->fd =3D fd;
+        return 0;
+    }
+
+    /* Open channel */
+    fd =3D fuse_kern_mount(mountpoint, se->mo);
+    if (fd =3D=3D -1) {
+        return -1;
+    }
+    se->fd =3D fd;
+
+    /* Save mountpoint */
+    se->mountpoint =3D strdup(mountpoint);
+    if (se->mountpoint =3D=3D NULL) {
+        goto error_out;
+    }
+
+    return 0;
=20
 error_out:
-=09fuse_kern_unmount(mountpoint, fd);
-=09return -1;
+    fuse_kern_unmount(mountpoint, fd);
+    return -1;
 }
=20
 int fuse_session_fd(struct fuse_session *se)
 {
-=09return se->fd;
+    return se->fd;
 }
=20
 void fuse_session_unmount(struct fuse_session *se)
@@ -2402,61 +2543,66 @@ void fuse_session_unmount(struct fuse_session *se)
 #ifdef linux
 int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
 {
-=09char *buf;
-=09size_t bufsize =3D 1024;
-=09char path[128];
-=09int ret;
-=09int fd;
-=09unsigned long pid =3D req->ctx.pid;
-=09char *s;
+    char *buf;
+    size_t bufsize =3D 1024;
+    char path[128];
+    int ret;
+    int fd;
+    unsigned long pid =3D req->ctx.pid;
+    char *s;
=20
-=09sprintf(path, "/proc/%lu/task/%lu/status", pid, pid);
+    sprintf(path, "/proc/%lu/task/%lu/status", pid, pid);
=20
 retry:
-=09buf =3D malloc(bufsize);
-=09if (buf =3D=3D NULL)
-=09=09return -ENOMEM;
-
-=09ret =3D -EIO;
-=09fd =3D open(path, O_RDONLY);
-=09if (fd =3D=3D -1)
-=09=09goto out_free;
-
-=09ret =3D read(fd, buf, bufsize);
-=09close(fd);
-=09if (ret < 0) {
-=09=09ret =3D -EIO;
-=09=09goto out_free;
-=09}
-
-=09if ((size_t)ret =3D=3D bufsize) {
-=09=09free(buf);
-=09=09bufsize *=3D 4;
-=09=09goto retry;
-=09}
-
-=09ret =3D -EIO;
-=09s =3D strstr(buf, "\nGroups:");
-=09if (s =3D=3D NULL)
-=09=09goto out_free;
-
-=09s +=3D 8;
-=09ret =3D 0;
-=09while (1) {
-=09=09char *end;
-=09=09unsigned long val =3D strtoul(s, &end, 0);
-=09=09if (end =3D=3D s)
-=09=09=09break;
-
-=09=09s =3D end;
-=09=09if (ret < size)
-=09=09=09list[ret] =3D val;
-=09=09ret++;
-=09}
+    buf =3D malloc(bufsize);
+    if (buf =3D=3D NULL) {
+        return -ENOMEM;
+    }
+
+    ret =3D -EIO;
+    fd =3D open(path, O_RDONLY);
+    if (fd =3D=3D -1) {
+        goto out_free;
+    }
+
+    ret =3D read(fd, buf, bufsize);
+    close(fd);
+    if (ret < 0) {
+        ret =3D -EIO;
+        goto out_free;
+    }
+
+    if ((size_t)ret =3D=3D bufsize) {
+        free(buf);
+        bufsize *=3D 4;
+        goto retry;
+    }
+
+    ret =3D -EIO;
+    s =3D strstr(buf, "\nGroups:");
+    if (s =3D=3D NULL) {
+        goto out_free;
+    }
+
+    s +=3D 8;
+    ret =3D 0;
+    while (1) {
+        char *end;
+        unsigned long val =3D strtoul(s, &end, 0);
+        if (end =3D=3D s) {
+            break;
+        }
+
+        s =3D end;
+        if (ret < size) {
+            list[ret] =3D val;
+        }
+        ret++;
+    }
=20
 out_free:
-=09free(buf);
-=09return ret;
+    free(buf);
+    return ret;
 }
 #else /* linux */
 /*
@@ -2464,23 +2610,25 @@ out_free:
  */
 int fuse_req_getgroups(fuse_req_t req, int size, gid_t list[])
 {
-=09(void) req; (void) size; (void) list;
-=09return -ENOSYS;
+    (void)req;
+    (void)size;
+    (void)list;
+    return -ENOSYS;
 }
 #endif
=20
 void fuse_session_exit(struct fuse_session *se)
 {
-=09se->exited =3D 1;
+    se->exited =3D 1;
 }
=20
 void fuse_session_reset(struct fuse_session *se)
 {
-=09se->exited =3D 0;
-=09se->error =3D 0;
+    se->exited =3D 0;
+    se->error =3D 0;
 }
=20
 int fuse_session_exited(struct fuse_session *se)
 {
-=09return se->exited;
+    return se->exited;
 }
diff --git a/tools/virtiofsd/fuse_lowlevel.h b/tools/virtiofsd/fuse_lowleve=
l.h
index 7aa7bad5b2..85cc027382 100644
--- a/tools/virtiofsd/fuse_lowlevel.h
+++ b/tools/virtiofsd/fuse_lowlevel.h
@@ -1,15 +1,16 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #ifndef FUSE_LOWLEVEL_H_
 #define FUSE_LOWLEVEL_H_
=20
-/** @file
+/**
+ * @file
  *
  * Low level API
  *
@@ -24,16 +25,16 @@
=20
 #include "fuse_common.h"
=20
-#include <utime.h>
 #include <fcntl.h>
-#include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/statvfs.h>
+#include <sys/types.h>
 #include <sys/uio.h>
+#include <utime.h>
=20
-/* ----------------------------------------------------------- *
- * Miscellaneous definitions=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Miscellaneous definitions
+ */
=20
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -53,47 +54,54 @@ struct fuse_session;
=20
 /** Directory entry parameters supplied to fuse_reply_entry() */
 struct fuse_entry_param {
-=09/** Unique inode number
-=09 *
-=09 * In lookup, zero means negative entry (from version 2.5)
-=09 * Returning ENOENT also means negative entry, but by setting zero
-=09 * ino the kernel may cache negative entries for entry_timeout
-=09 * seconds.
-=09 */
-=09fuse_ino_t ino;
-
-=09/** Generation number for this entry.
-=09 *
-=09 * If the file system will be exported over NFS, the
-=09 * ino/generation pairs need to be unique over the file
-=09 * system's lifetime (rather than just the mount time). So if
-=09 * the file system reuses an inode after it has been deleted,
-=09 * it must assign a new, previously unused generation number
-=09 * to the inode at the same time.
-=09 *
-=09 */
-=09uint64_t generation;
-
-=09/** Inode attributes.
-=09 *
-=09 * Even if attr_timeout =3D=3D 0, attr must be correct. For example,
-=09 * for open(), FUSE uses attr.st_size from lookup() to determine
-=09 * how many bytes to request. If this value is not correct,
-=09 * incorrect data will be returned.
-=09 */
-=09struct stat attr;
-
-=09/** Validity timeout (in seconds) for inode attributes. If
-=09    attributes only change as a result of requests that come
-=09    through the kernel, this should be set to a very large
-=09    value. */
-=09double attr_timeout;
-
-=09/** Validity timeout (in seconds) for the name. If directory
-=09    entries are changed/deleted only as a result of requests
-=09    that come through the kernel, this should be set to a very
-=09    large value. */
-=09double entry_timeout;
+    /**
+     * Unique inode number
+     *
+     * In lookup, zero means negative entry (from version 2.5)
+     * Returning ENOENT also means negative entry, but by setting zero
+     * ino the kernel may cache negative entries for entry_timeout
+     * seconds.
+     */
+    fuse_ino_t ino;
+
+    /**
+     * Generation number for this entry.
+     *
+     * If the file system will be exported over NFS, the
+     * ino/generation pairs need to be unique over the file
+     * system's lifetime (rather than just the mount time). So if
+     * the file system reuses an inode after it has been deleted,
+     * it must assign a new, previously unused generation number
+     * to the inode at the same time.
+     *
+     */
+    uint64_t generation;
+
+    /**
+     * Inode attributes.
+     *
+     * Even if attr_timeout =3D=3D 0, attr must be correct. For example,
+     * for open(), FUSE uses attr.st_size from lookup() to determine
+     * how many bytes to request. If this value is not correct,
+     * incorrect data will be returned.
+     */
+    struct stat attr;
+
+    /**
+     * Validity timeout (in seconds) for inode attributes. If
+     *  attributes only change as a result of requests that come
+     *  through the kernel, this should be set to a very large
+     *  value.
+     */
+    double attr_timeout;
+
+    /**
+     * Validity timeout (in seconds) for the name. If directory
+     *  entries are changed/deleted only as a result of requests
+     *  that come through the kernel, this should be set to a very
+     *  large value.
+     */
+    double entry_timeout;
 };
=20
 /**
@@ -105,38 +113,38 @@ struct fuse_entry_param {
  * there is no valid uid/pid/gid that could be reported.
  */
 struct fuse_ctx {
-=09/** User ID of the calling process */
-=09uid_t uid;
+    /** User ID of the calling process */
+    uid_t uid;
=20
-=09/** Group ID of the calling process */
-=09gid_t gid;
+    /** Group ID of the calling process */
+    gid_t gid;
=20
-=09/** Thread ID of the calling process */
-=09pid_t pid;
+    /** Thread ID of the calling process */
+    pid_t pid;
=20
-=09/** Umask of the calling process */
-=09mode_t umask;
+    /** Umask of the calling process */
+    mode_t umask;
 };
=20
 struct fuse_forget_data {
-=09fuse_ino_t ino;
-=09uint64_t nlookup;
+    fuse_ino_t ino;
+    uint64_t nlookup;
 };
=20
 /* 'to_set' flags in setattr */
-#define FUSE_SET_ATTR_MODE=09(1 << 0)
-#define FUSE_SET_ATTR_UID=09(1 << 1)
-#define FUSE_SET_ATTR_GID=09(1 << 2)
-#define FUSE_SET_ATTR_SIZE=09(1 << 3)
-#define FUSE_SET_ATTR_ATIME=09(1 << 4)
-#define FUSE_SET_ATTR_MTIME=09(1 << 5)
-#define FUSE_SET_ATTR_ATIME_NOW=09(1 << 7)
-#define FUSE_SET_ATTR_MTIME_NOW=09(1 << 8)
-#define FUSE_SET_ATTR_CTIME=09(1 << 10)
-
-/* ----------------------------------------------------------- *
- * Request methods and replies=09=09=09=09       *
- * ----------------------------------------------------------- */
+#define FUSE_SET_ATTR_MODE (1 << 0)
+#define FUSE_SET_ATTR_UID (1 << 1)
+#define FUSE_SET_ATTR_GID (1 << 2)
+#define FUSE_SET_ATTR_SIZE (1 << 3)
+#define FUSE_SET_ATTR_ATIME (1 << 4)
+#define FUSE_SET_ATTR_MTIME (1 << 5)
+#define FUSE_SET_ATTR_ATIME_NOW (1 << 7)
+#define FUSE_SET_ATTR_MTIME_NOW (1 << 8)
+#define FUSE_SET_ATTR_CTIME (1 << 10)
+
+/*
+ * Request methods and replies
+ */
=20
 /**
  * Low level filesystem operations
@@ -166,1075 +174,1069 @@ struct fuse_forget_data {
  * this file will not be called.
  */
 struct fuse_lowlevel_ops {
-=09/**
-=09 * Initialize filesystem
-=09 *
-=09 * This function is called when libfuse establishes
-=09 * communication with the FUSE kernel module. The file system
-=09 * should use this module to inspect and/or modify the
-=09 * connection parameters provided in the `conn` structure.
-=09 *
-=09 * Note that some parameters may be overwritten by options
-=09 * passed to fuse_session_new() which take precedence over the
-=09 * values set in this handler.
-=09 *
-=09 * There's no reply to this function
-=09 *
-=09 * @param userdata the user data passed to fuse_session_new()
-=09 */
-=09void (*init) (void *userdata, struct fuse_conn_info *conn);
-
-=09/**
-=09 * Clean up filesystem.
-=09 *
-=09 * Called on filesystem exit. When this method is called, the
-=09 * connection to the kernel may be gone already, so that eg. calls
-=09 * to fuse_lowlevel_notify_* will fail.
-=09 *
-=09 * There's no reply to this function
-=09 *
-=09 * @param userdata the user data passed to fuse_session_new()
-=09 */
-=09void (*destroy) (void *userdata);
-
-=09/**
-=09 * Look up a directory entry by name and get its attributes.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_entry
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name the name to look up
-=09 */
-=09void (*lookup) (fuse_req_t req, fuse_ino_t parent, const char *name);
-
-=09/**
-=09 * Forget about an inode
-=09 *
-=09 * This function is called when the kernel removes an inode
-=09 * from its internal caches.
-=09 *
-=09 * The inode's lookup count increases by one for every call to
-=09 * fuse_reply_entry and fuse_reply_create. The nlookup parameter
-=09 * indicates by how much the lookup count should be decreased.
-=09 *
-=09 * Inodes with a non-zero lookup count may receive request from
-=09 * the kernel even after calls to unlink, rmdir or (when
-=09 * overwriting an existing file) rename. Filesystems must handle
-=09 * such requests properly and it is recommended to defer removal
-=09 * of the inode until the lookup count reaches zero. Calls to
-=09 * unlink, rmdir or rename will be followed closely by forget
-=09 * unless the file or directory is open, in which case the
-=09 * kernel issues forget only after the release or releasedir
-=09 * calls.
-=09 *
-=09 * Note that if a file system will be exported over NFS the
-=09 * inodes lifetime must extend even beyond forget. See the
-=09 * generation field in struct fuse_entry_param above.
-=09 *
-=09 * On unmount the lookup count for all inodes implicitly drops
-=09 * to zero. It is not guaranteed that the file system will
-=09 * receive corresponding forget messages for the affected
-=09 * inodes.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_none
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param nlookup the number of lookups to forget
-=09 */
-=09void (*forget) (fuse_req_t req, fuse_ino_t ino, uint64_t nlookup);
-
-=09/**
-=09 * Get file attributes.
-=09 *
-=09 * If writeback caching is enabled, the kernel may have a
-=09 * better idea of a file's length than the FUSE file system
-=09 * (eg if there has been a write that extended the file size,
-=09 * but that has not yet been passed to the filesystem.n
-=09 *
-=09 * In this case, the st_size value provided by the file system
-=09 * will be ignored.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_attr
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi for future use, currently always NULL
-=09 */
-=09void (*getattr) (fuse_req_t req, fuse_ino_t ino,
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Set file attributes
-=09 *
-=09 * In the 'attr' argument only members indicated by the 'to_set'
-=09 * bitmask contain valid values.  Other members contain undefined
-=09 * values.
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits if the file
-=09 * size or owner is being changed.
-=09 *
-=09 * If the setattr was invoked from the ftruncate() system call
-=09 * under Linux kernel versions 2.6.15 or later, the fi->fh will
-=09 * contain the value set by the open method or will be undefined
-=09 * if the open method didn't set any value.  Otherwise (not
-=09 * ftruncate call, or kernel version earlier than 2.6.15) the fi
-=09 * parameter will be NULL.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_attr
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param attr the attributes
-=09 * @param to_set bit mask of attributes which should be set
-=09 * @param fi file information, or NULL
-=09 */
-=09void (*setattr) (fuse_req_t req, fuse_ino_t ino, struct stat *attr,
-=09=09=09 int to_set, struct fuse_file_info *fi);
-
-=09/**
-=09 * Read symbolic link
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_readlink
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 */
-=09void (*readlink) (fuse_req_t req, fuse_ino_t ino);
-
-=09/**
-=09 * Create file node
-=09 *
-=09 * Create a regular file, character device, block device, fifo or
-=09 * socket node.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_entry
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name to create
-=09 * @param mode file type and mode with which to create the new file
-=09 * @param rdev the device number (only valid if created file is a devic=
e)
-=09 */
-=09void (*mknod) (fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09       mode_t mode, dev_t rdev);
-
-=09/**
-=09 * Create a directory
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_entry
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name to create
-=09 * @param mode with which to create the new file
-=09 */
-=09void (*mkdir) (fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09       mode_t mode);
-
-=09/**
-=09 * Remove a file
-=09 *
-=09 * If the file's inode's lookup count is non-zero, the file
-=09 * system is expected to postpone any removal of the inode
-=09 * until the lookup count reaches zero (see description of the
-=09 * forget function).
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name to remove
-=09 */
-=09void (*unlink) (fuse_req_t req, fuse_ino_t parent, const char *name);
-
-=09/**
-=09 * Remove a directory
-=09 *
-=09 * If the directory's inode's lookup count is non-zero, the
-=09 * file system is expected to postpone any removal of the
-=09 * inode until the lookup count reaches zero (see description
-=09 * of the forget function).
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name to remove
-=09 */
-=09void (*rmdir) (fuse_req_t req, fuse_ino_t parent, const char *name);
-
-=09/**
-=09 * Create a symbolic link
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_entry
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param link the contents of the symbolic link
-=09 * @param parent inode number of the parent directory
-=09 * @param name to create
-=09 */
-=09void (*symlink) (fuse_req_t req, const char *link, fuse_ino_t parent,
-=09=09=09 const char *name);
-
-=09/** Rename a file
-=09 *
-=09 * If the target exists it should be atomically replaced. If
-=09 * the target's inode's lookup count is non-zero, the file
-=09 * system is expected to postpone any removal of the inode
-=09 * until the lookup count reaches zero (see description of the
-=09 * forget function).
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EINVAL, i.e. all
-=09 * future bmap requests will fail with EINVAL without being
-=09 * send to the filesystem process.
-=09 *
-=09 * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
-=09 * RENAME_NOREPLACE is specified, the filesystem must not
-=09 * overwrite *newname* if it exists and return an error
-=09 * instead. If `RENAME_EXCHANGE` is specified, the filesystem
-=09 * must atomically exchange the two files, i.e. both must
-=09 * exist and neither may be deleted.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the old parent directory
-=09 * @param name old name
-=09 * @param newparent inode number of the new parent directory
-=09 * @param newname new name
-=09 */
-=09void (*rename) (fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09=09fuse_ino_t newparent, const char *newname,
-=09=09=09unsigned int flags);
-
-=09/**
-=09 * Create a hard link
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_entry
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the old inode number
-=09 * @param newparent inode number of the new parent directory
-=09 * @param newname new name to create
-=09 */
-=09void (*link) (fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
-=09=09      const char *newname);
-
-=09/**
-=09 * Open a file
-=09 *
-=09 * Open flags are available in fi->flags. The following rules
-=09 * apply.
-=09 *
-=09 *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
-=09 *    filtered out / handled by the kernel.
-=09 *
-=09 *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR) should be used
-=09 *    by the filesystem to check if the operation is
-=09 *    permitted.  If the ``-o default_permissions`` mount
-=09 *    option is given, this check is already done by the
-=09 *    kernel before calling open() and may thus be omitted by
-=09 *    the filesystem.
-=09 *
-=09 *  - When writeback caching is enabled, the kernel may send
-=09 *    read requests even for files opened with O_WRONLY. The
-=09 *    filesystem should be prepared to handle this.
-=09 *
-=09 *  - When writeback caching is disabled, the filesystem is
-=09 *    expected to properly handle the O_APPEND flag and ensure
-=09 *    that each write is appending to the end of the file.
-=09 *=20
-         *  - When writeback caching is enabled, the kernel will
-=09 *    handle O_APPEND. However, unless all changes to the file
-=09 *    come through the kernel this will not work reliably. The
-=09 *    filesystem should thus either ignore the O_APPEND flag
-=09 *    (and let the kernel handle it), or return an error
-=09 *    (indicating that reliably O_APPEND is not available).
-=09 *
-=09 * Filesystem may store an arbitrary file handle (pointer,
-=09 * index, etc) in fi->fh, and use this in other all other file
-=09 * operations (read, write, flush, release, fsync).
-=09 *
-=09 * Filesystem may also implement stateless file I/O and not store
-=09 * anything in fi->fh.
-=09 *
-=09 * There are also some flags (direct_io, keep_cache) which the
-=09 * filesystem may set in fi, to change the way the file is opened.
-=09 * See fuse_file_info structure in <fuse_common.h> for more details.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS
-=09 * and FUSE_CAP_NO_OPEN_SUPPORT is set in
-=09 * `fuse_conn_info.capable`, this is treated as success and
-=09 * future calls to open and release will also succeed without being
-=09 * sent to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_open
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 */
-=09void (*open) (fuse_req_t req, fuse_ino_t ino,
-=09=09      struct fuse_file_info *fi);
-
-=09/**
-=09 * Read data
-=09 *
-=09 * Read should send exactly the number of bytes requested except
-=09 * on EOF or error, otherwise the rest of the data will be
-=09 * substituted with zeroes.  An exception to this is when the file
-=09 * has been opened in 'direct_io' mode, in which case the return
-=09 * value of the read system call will reflect the return value of
-=09 * this operation.
-=09 *
-=09 * fi->fh will contain the value set by the open method, or will
-=09 * be undefined if the open method didn't set any value.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_buf
-=09 *   fuse_reply_iov
-=09 *   fuse_reply_data
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param size number of bytes to read
-=09 * @param off offset to read from
-=09 * @param fi file information
-=09 */
-=09void (*read) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t off,
-=09=09      struct fuse_file_info *fi);
-
-=09/**
-=09 * Write data
-=09 *
-=09 * Write should return exactly the number of bytes requested
-=09 * except on error.  An exception to this is when the file has
-=09 * been opened in 'direct_io' mode, in which case the return value
-=09 * of the write system call will reflect the return value of this
-=09 * operation.
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 *
-=09 * fi->fh will contain the value set by the open method, or will
-=09 * be undefined if the open method didn't set any value.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_write
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param buf data to write
-=09 * @param size number of bytes to write
-=09 * @param off offset to write to
-=09 * @param fi file information
-=09 */
-=09void (*write) (fuse_req_t req, fuse_ino_t ino, const char *buf,
-=09=09       size_t size, off_t off, struct fuse_file_info *fi);
-
-=09/**
-=09 * Flush method
-=09 *
-=09 * This is called on each close() of the opened file.
-=09 *
-=09 * Since file descriptors can be duplicated (dup, dup2, fork), for
-=09 * one open call there may be many flush calls.
-=09 *
-=09 * Filesystems shouldn't assume that flush will always be called
-=09 * after some writes, or that if will be called at all.
-=09 *
-=09 * fi->fh will contain the value set by the open method, or will
-=09 * be undefined if the open method didn't set any value.
-=09 *
-=09 * NOTE: the name of the method is misleading, since (unlike
-=09 * fsync) the filesystem is not forced to flush pending writes.
-=09 * One reason to flush data is if the filesystem wants to return
-=09 * write errors during close.  However, such use is non-portable
-=09 * because POSIX does not require [close] to wait for delayed I/O to
-=09 * complete.
-=09 *
-=09 * If the filesystem supports file locking operations (setlk,
-=09 * getlk) it should remove all locks belonging to 'fi->owner'.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS,
-=09 * this is treated as success and future calls to flush() will
-=09 * succeed automatically without being send to the filesystem
-=09 * process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 *
-=09 * [close]: http://pubs.opengroup.org/onlinepubs/9699919799/functions/c=
lose.html
-=09 */
-=09void (*flush) (fuse_req_t req, fuse_ino_t ino,
-=09=09       struct fuse_file_info *fi);
-
-=09/**
-=09 * Release an open file
-=09 *
-=09 * Release is called when there are no more references to an open
-=09 * file: all file descriptors are closed and all memory mappings
-=09 * are unmapped.
-=09 *
-=09 * For every open call there will be exactly one release call (unless
-=09 * the filesystem is force-unmounted).
-=09 *
-=09 * The filesystem may reply with an error, but error values are
-=09 * not returned to close() or munmap() which triggered the
-=09 * release.
-=09 *
-=09 * fi->fh will contain the value set by the open method, or will
-=09 * be undefined if the open method didn't set any value.
-=09 * fi->flags will contain the same flags as for open.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 */
-=09void (*release) (fuse_req_t req, fuse_ino_t ino,
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Synchronize file contents
-=09 *
-=09 * If the datasync parameter is non-zero, then only the user data
-=09 * should be flushed, not the meta data.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS,
-=09 * this is treated as success and future calls to fsync() will
-=09 * succeed automatically without being send to the filesystem
-=09 * process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param datasync flag indicating if only data should be flushed
-=09 * @param fi file information
-=09 */
-=09void (*fsync) (fuse_req_t req, fuse_ino_t ino, int datasync,
-=09=09       struct fuse_file_info *fi);
-
-=09/**
-=09 * Open a directory
-=09 *
-=09 * Filesystem may store an arbitrary file handle (pointer, index,
-=09 * etc) in fi->fh, and use this in other all other directory
-=09 * stream operations (readdir, releasedir, fsyncdir).
-=09 *
-=09 * If this request is answered with an error code of ENOSYS and
-=09 * FUSE_CAP_NO_OPENDIR_SUPPORT is set in `fuse_conn_info.capable`,
-=09 * this is treated as success and future calls to opendir and
-=09 * releasedir will also succeed without being sent to the filesystem
-=09 * process. In addition, the kernel will cache readdir results
-=09 * as if opendir returned FOPEN_KEEP_CACHE | FOPEN_CACHE_DIR.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_open
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 */
-=09void (*opendir) (fuse_req_t req, fuse_ino_t ino,
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Read directory
-=09 *
-=09 * Send a buffer filled using fuse_add_direntry(), with size not
-=09 * exceeding the requested size.  Send an empty buffer on end of
-=09 * stream.
-=09 *
-=09 * fi->fh will contain the value set by the opendir method, or
-=09 * will be undefined if the opendir method didn't set any value.
-=09 *
-=09 * Returning a directory entry from readdir() does not affect
-=09 * its lookup count.
-=09 *
-         * If off_t is non-zero, then it will correspond to one of the off=
_t
-=09 * values that was previously returned by readdir() for the same
-=09 * directory handle. In this case, readdir() should skip over entries
-=09 * coming before the position defined by the off_t value. If entries
-=09 * are added or removed while the directory handle is open, they filesy=
stem
-=09 * may still include the entries that have been removed, and may not
-=09 * report the entries that have been created. However, addition or
-=09 * removal of entries must never cause readdir() to skip over unrelated
-=09 * entries or to report them more than once. This means
-=09 * that off_t can not be a simple index that enumerates the entries
-=09 * that have been returned but must contain sufficient information to
-=09 * uniquely determine the next directory entry to return even when the
-=09 * set of entries is changing.
-=09 *
-=09 * The function does not have to report the '.' and '..'
-=09 * entries, but is allowed to do so. Note that, if readdir does
-=09 * not return '.' or '..', they will not be implicitly returned,
-=09 * and this behavior is observable by the caller.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_buf
-=09 *   fuse_reply_data
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param size maximum number of bytes to send
-=09 * @param off offset to continue reading the directory stream
-=09 * @param fi file information
-=09 */
-=09void (*readdir) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t off=
,
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Release an open directory
-=09 *
-=09 * For every opendir call there will be exactly one releasedir
-=09 * call (unless the filesystem is force-unmounted).
-=09 *
-=09 * fi->fh will contain the value set by the opendir method, or
-=09 * will be undefined if the opendir method didn't set any value.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 */
-=09void (*releasedir) (fuse_req_t req, fuse_ino_t ino,
-=09=09=09    struct fuse_file_info *fi);
-
-=09/**
-=09 * Synchronize directory contents
-=09 *
-=09 * If the datasync parameter is non-zero, then only the directory
-=09 * contents should be flushed, not the meta data.
-=09 *
-=09 * fi->fh will contain the value set by the opendir method, or
-=09 * will be undefined if the opendir method didn't set any value.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS,
-=09 * this is treated as success and future calls to fsyncdir() will
-=09 * succeed automatically without being send to the filesystem
-=09 * process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param datasync flag indicating if only data should be flushed
-=09 * @param fi file information
-=09 */
-=09void (*fsyncdir) (fuse_req_t req, fuse_ino_t ino, int datasync,
-=09=09=09  struct fuse_file_info *fi);
-
-=09/**
-=09 * Get file system statistics
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_statfs
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number, zero means "undefined"
-=09 */
-=09void (*statfs) (fuse_req_t req, fuse_ino_t ino);
-
-=09/**
-=09 * Set an extended attribute
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future setxattr() requests will fail with EOPNOTSUPP without being
-=09 * send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 */
-=09void (*setxattr) (fuse_req_t req, fuse_ino_t ino, const char *name,
-=09=09=09  const char *value, size_t size, int flags);
-
-=09/**
-=09 * Get an extended attribute
-=09 *
-=09 * If size is zero, the size of the value should be sent with
-=09 * fuse_reply_xattr.
-=09 *
-=09 * If the size is non-zero, and the value fits in the buffer, the
-=09 * value should be sent with fuse_reply_buf.
-=09 *
-=09 * If the size is too small for the value, the ERANGE error should
-=09 * be sent.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future getxattr() requests will fail with EOPNOTSUPP without being
-=09 * send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_buf
-=09 *   fuse_reply_data
-=09 *   fuse_reply_xattr
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param name of the extended attribute
-=09 * @param size maximum size of the value to send
-=09 */
-=09void (*getxattr) (fuse_req_t req, fuse_ino_t ino, const char *name,
-=09=09=09  size_t size);
-
-=09/**
-=09 * List extended attribute names
-=09 *
-=09 * If size is zero, the total size of the attribute list should be
-=09 * sent with fuse_reply_xattr.
-=09 *
-=09 * If the size is non-zero, and the null character separated
-=09 * attribute list fits in the buffer, the list should be sent with
-=09 * fuse_reply_buf.
-=09 *
-=09 * If the size is too small for the list, the ERANGE error should
-=09 * be sent.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future listxattr() requests will fail with EOPNOTSUPP without being
-=09 * send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_buf
-=09 *   fuse_reply_data
-=09 *   fuse_reply_xattr
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param size maximum size of the list to send
-=09 */
-=09void (*listxattr) (fuse_req_t req, fuse_ino_t ino, size_t size);
-
-=09/**
-=09 * Remove an extended attribute
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future removexattr() requests will fail with EOPNOTSUPP without bein=
g
-=09 * send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param name of the extended attribute
-=09 */
-=09void (*removexattr) (fuse_req_t req, fuse_ino_t ino, const char *name);
-
-=09/**
-=09 * Check file access permissions
-=09 *
-=09 * This will be called for the access() and chdir() system
-=09 * calls.  If the 'default_permissions' mount option is given,
-=09 * this method is not called.
-=09 *
-=09 * This method is not called under Linux kernel versions 2.4.x
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent success, i.e. this and all future access()
-=09 * requests will succeed without being send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param mask requested access mode
-=09 */
-=09void (*access) (fuse_req_t req, fuse_ino_t ino, int mask);
-
-=09/**
-=09 * Create and open a file
-=09 *
-=09 * If the file does not exist, first create it with the specified
-=09 * mode, and then open it.
-=09 *
-=09 * See the description of the open handler for more
-=09 * information.
-=09 *
-=09 * If this method is not implemented or under Linux kernel
-=09 * versions earlier than 2.6.15, the mknod() and open() methods
-=09 * will be called instead.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, the handle=
r
-=09 * is treated as not implemented (i.e., for this and future requests th=
e
-=09 * mknod() and open() handlers will be called instead).
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_create
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param parent inode number of the parent directory
-=09 * @param name to create
-=09 * @param mode file type and mode with which to create the new file
-=09 * @param fi file information
-=09 */
-=09void (*create) (fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09=09mode_t mode, struct fuse_file_info *fi);
-
-=09/**
-=09 * Test for a POSIX file lock
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_lock
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 * @param lock the region/type to test
-=09 */
-=09void (*getlk) (fuse_req_t req, fuse_ino_t ino,
-=09=09       struct fuse_file_info *fi, struct flock *lock);
-
-=09/**
-=09 * Acquire, modify or release a POSIX file lock
-=09 *
-=09 * For POSIX threads (NPTL) there's a 1-1 relation between pid and
-=09 * owner, but otherwise this is not always the case.  For checking
-=09 * lock ownership, 'fi->owner' must be used.  The l_pid field in
-=09 * 'struct flock' should only be used to fill in this field in
-=09 * getlk().
-=09 *
-=09 * Note: if the locking methods are not implemented, the kernel
-=09 * will still allow file locking to work locally.  Hence these are
-=09 * only interesting for network filesystems and similar.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 * @param lock the region/type to set
-=09 * @param sleep locking operation may sleep
-=09 */
-=09void (*setlk) (fuse_req_t req, fuse_ino_t ino,
-=09=09       struct fuse_file_info *fi,
-=09=09       struct flock *lock, int sleep);
-
-=09/**
-=09 * Map block index within file to block index within device
-=09 *
-=09 * Note: This makes sense only for block device backed filesystems
-=09 * mounted with the 'blkdev' option
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure, i.e. all future bmap() requests will
-=09 * fail with the same error code without being send to the filesystem
-=09 * process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_bmap
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param blocksize unit of block index
-=09 * @param idx block index within file
-=09 */
-=09void (*bmap) (fuse_req_t req, fuse_ino_t ino, size_t blocksize,
-=09=09      uint64_t idx);
-
-=09/**
-=09 * Ioctl
-=09 *
-=09 * Note: For unrestricted ioctls (not allowed for FUSE
-=09 * servers), data in and out areas can be discovered by giving
-=09 * iovs and setting FUSE_IOCTL_RETRY in *flags*.  For
-=09 * restricted ioctls, kernel prepares in/out data area
-=09 * according to the information encoded in cmd.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_ioctl_retry
-=09 *   fuse_reply_ioctl
-=09 *   fuse_reply_ioctl_iov
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param cmd ioctl command
-=09 * @param arg ioctl argument
-=09 * @param fi file information
-=09 * @param flags for FUSE_IOCTL_* flags
-=09 * @param in_buf data fetched from the caller
-=09 * @param in_bufsz number of fetched bytes
-=09 * @param out_bufsz maximum size of output data
-=09 *
-=09 * Note : the unsigned long request submitted by the application
-=09 * is truncated to 32 bits.
-=09 */
-=09void (*ioctl) (fuse_req_t req, fuse_ino_t ino, unsigned int cmd,
-=09=09       void *arg, struct fuse_file_info *fi, unsigned flags,
-=09=09       const void *in_buf, size_t in_bufsz, size_t out_bufsz);
-
-=09/**
-=09 * Poll for IO readiness
-=09 *
-=09 * Note: If ph is non-NULL, the client should notify
-=09 * when IO readiness events occur by calling
-=09 * fuse_lowlevel_notify_poll() with the specified ph.
-=09 *
-=09 * Regardless of the number of times poll with a non-NULL ph
-=09 * is received, single notification is enough to clear all.
-=09 * Notifying more times incurs overhead but doesn't harm
-=09 * correctness.
-=09 *
-=09 * The callee is responsible for destroying ph with
-=09 * fuse_pollhandle_destroy() when no longer in use.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as success (with a kernel-defined default poll-mask) and
-=09 * future calls to pull() will succeed the same way without being send
-=09 * to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_poll
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 * @param ph poll handle to be used for notification
-=09 */
-=09void (*poll) (fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi=
,
-=09=09      struct fuse_pollhandle *ph);
-
-=09/**
-=09 * Write data made available in a buffer
-=09 *
-=09 * This is a more generic version of the ->write() method.  If
-=09 * FUSE_CAP_SPLICE_READ is set in fuse_conn_info.want and the
-=09 * kernel supports splicing from the fuse device, then the
-=09 * data will be made available in pipe for supporting zero
-=09 * copy data transfer.
-=09 *
-=09 * buf->count is guaranteed to be one (and thus buf->idx is
-=09 * always zero). The write_buf handler must ensure that
-=09 * bufv->off is correctly updated (reflecting the number of
-=09 * bytes read from bufv->buf[0]).
-=09 *
-=09 * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
-=09 * expected to reset the setuid and setgid bits.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_write
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param bufv buffer containing the data
-=09 * @param off offset to write to
-=09 * @param fi file information
-=09 */
-=09void (*write_buf) (fuse_req_t req, fuse_ino_t ino,
-=09=09=09   struct fuse_bufvec *bufv, off_t off,
-=09=09=09   struct fuse_file_info *fi);
-
-=09/**
-=09 * Callback function for the retrieve request
-=09 *
-=09 * Valid replies:
-=09 *=09fuse_reply_none
-=09 *
-=09 * @param req request handle
-=09 * @param cookie user data supplied to fuse_lowlevel_notify_retrieve()
-=09 * @param ino the inode number supplied to fuse_lowlevel_notify_retriev=
e()
-=09 * @param offset the offset supplied to fuse_lowlevel_notify_retrieve()
-=09 * @param bufv the buffer containing the returned data
-=09 */
-=09void (*retrieve_reply) (fuse_req_t req, void *cookie, fuse_ino_t ino,
-=09=09=09=09off_t offset, struct fuse_bufvec *bufv);
-
-=09/**
-=09 * Forget about multiple inodes
-=09 *
-=09 * See description of the forget function for more
-=09 * information.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_none
-=09 *
-=09 * @param req request handle
-=09 */
-=09void (*forget_multi) (fuse_req_t req, size_t count,
-=09=09=09      struct fuse_forget_data *forgets);
-
-=09/**
-=09 * Acquire, modify or release a BSD file lock
-=09 *
-=09 * Note: if the locking methods are not implemented, the kernel
-=09 * will still allow file locking to work locally.  Hence these are
-=09 * only interesting for network filesystems and similar.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param fi file information
-=09 * @param op the locking operation, see flock(2)
-=09 */
-=09void (*flock) (fuse_req_t req, fuse_ino_t ino,
-=09=09       struct fuse_file_info *fi, int op);
-
-=09/**
-=09 * Allocate requested space. If this function returns success then
-=09 * subsequent writes to the specified range shall not fail due to the l=
ack
-=09 * of free space on the file system storage media.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future fallocate() requests will fail with EOPNOTSUPP without being
-=09 * send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param offset starting point for allocated region
-=09 * @param length size of allocated region
-=09 * @param mode determines the operation to be performed on the given ra=
nge,
-=09 *             see fallocate(2)
-=09 */
-=09void (*fallocate) (fuse_req_t req, fuse_ino_t ino, int mode,
-=09=09       off_t offset, off_t length, struct fuse_file_info *fi);
-
-=09/**
-=09 * Read directory with attributes
-=09 *
-=09 * Send a buffer filled using fuse_add_direntry_plus(), with size not
-=09 * exceeding the requested size.  Send an empty buffer on end of
-=09 * stream.
-=09 *
-=09 * fi->fh will contain the value set by the opendir method, or
-=09 * will be undefined if the opendir method didn't set any value.
-=09 *
-=09 * In contrast to readdir() (which does not affect the lookup counts),
-=09 * the lookup count of every entry returned by readdirplus(), except ".=
"
-=09 * and "..", is incremented by one.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_buf
-=09 *   fuse_reply_data
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param size maximum number of bytes to send
-=09 * @param off offset to continue reading the directory stream
-=09 * @param fi file information
-=09 */
-=09void (*readdirplus) (fuse_req_t req, fuse_ino_t ino, size_t size, off_t=
 off,
-=09=09=09 struct fuse_file_info *fi);
-
-=09/**
-=09 * Copy a range of data from one file to another
-=09 *
-=09 * Performs an optimized copy between two file descriptors without the
-=09 * additional cost of transferring data through the FUSE kernel module
-=09 * to user space (glibc) and then back into the FUSE filesystem again.
-=09 *
-=09 * In case this method is not implemented, glibc falls back to reading
-=09 * data from the source and writing to the destination. Effectively
-=09 * doing an inefficient copy of the data.
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
-=09 * future copy_file_range() requests will fail with EOPNOTSUPP without
-=09 * being send to the filesystem process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_write
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino_in the inode number or the source file
-=09 * @param off_in starting point from were the data should be read
-=09 * @param fi_in file information of the source file
-=09 * @param ino_out the inode number or the destination file
-=09 * @param off_out starting point where the data should be written
-=09 * @param fi_out file information of the destination file
-=09 * @param len maximum size of the data to copy
-=09 * @param flags passed along with the copy_file_range() syscall
-=09 */
-=09void (*copy_file_range) (fuse_req_t req, fuse_ino_t ino_in,
-=09=09=09=09 off_t off_in, struct fuse_file_info *fi_in,
-=09=09=09=09 fuse_ino_t ino_out, off_t off_out,
-=09=09=09=09 struct fuse_file_info *fi_out, size_t len,
-=09=09=09=09 int flags);
-
-=09/**
-=09 * Find next data or hole after the specified offset
-=09 *
-=09 * If this request is answered with an error code of ENOSYS, this is
-=09 * treated as a permanent failure, i.e. all future lseek() requests wil=
l
-=09 * fail with the same error code without being send to the filesystem
-=09 * process.
-=09 *
-=09 * Valid replies:
-=09 *   fuse_reply_lseek
-=09 *   fuse_reply_err
-=09 *
-=09 * @param req request handle
-=09 * @param ino the inode number
-=09 * @param off offset to start search from
-=09 * @param whence either SEEK_DATA or SEEK_HOLE
-=09 * @param fi file information
-=09 */
-=09void (*lseek) (fuse_req_t req, fuse_ino_t ino, off_t off, int whence,
-=09=09       struct fuse_file_info *fi);
+    /**
+     * Initialize filesystem
+     *
+     * This function is called when libfuse establishes
+     * communication with the FUSE kernel module. The file system
+     * should use this module to inspect and/or modify the
+     * connection parameters provided in the `conn` structure.
+     *
+     * Note that some parameters may be overwritten by options
+     * passed to fuse_session_new() which take precedence over the
+     * values set in this handler.
+     *
+     * There's no reply to this function
+     *
+     * @param userdata the user data passed to fuse_session_new()
+     */
+    void (*init)(void *userdata, struct fuse_conn_info *conn);
+
+    /**
+     * Clean up filesystem.
+     *
+     * Called on filesystem exit. When this method is called, the
+     * connection to the kernel may be gone already, so that eg. calls
+     * to fuse_lowlevel_notify_* will fail.
+     *
+     * There's no reply to this function
+     *
+     * @param userdata the user data passed to fuse_session_new()
+     */
+    void (*destroy)(void *userdata);
+
+    /**
+     * Look up a directory entry by name and get its attributes.
+     *
+     * Valid replies:
+     *   fuse_reply_entry
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name the name to look up
+     */
+    void (*lookup)(fuse_req_t req, fuse_ino_t parent, const char *name);
+
+    /**
+     * Forget about an inode
+     *
+     * This function is called when the kernel removes an inode
+     * from its internal caches.
+     *
+     * The inode's lookup count increases by one for every call to
+     * fuse_reply_entry and fuse_reply_create. The nlookup parameter
+     * indicates by how much the lookup count should be decreased.
+     *
+     * Inodes with a non-zero lookup count may receive request from
+     * the kernel even after calls to unlink, rmdir or (when
+     * overwriting an existing file) rename. Filesystems must handle
+     * such requests properly and it is recommended to defer removal
+     * of the inode until the lookup count reaches zero. Calls to
+     * unlink, rmdir or rename will be followed closely by forget
+     * unless the file or directory is open, in which case the
+     * kernel issues forget only after the release or releasedir
+     * calls.
+     *
+     * Note that if a file system will be exported over NFS the
+     * inodes lifetime must extend even beyond forget. See the
+     * generation field in struct fuse_entry_param above.
+     *
+     * On unmount the lookup count for all inodes implicitly drops
+     * to zero. It is not guaranteed that the file system will
+     * receive corresponding forget messages for the affected
+     * inodes.
+     *
+     * Valid replies:
+     *   fuse_reply_none
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param nlookup the number of lookups to forget
+     */
+    void (*forget)(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup);
+
+    /**
+     * Get file attributes.
+     *
+     * If writeback caching is enabled, the kernel may have a
+     * better idea of a file's length than the FUSE file system
+     * (eg if there has been a write that extended the file size,
+     * but that has not yet been passed to the filesystem.n
+     *
+     * In this case, the st_size value provided by the file system
+     * will be ignored.
+     *
+     * Valid replies:
+     *   fuse_reply_attr
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi for future use, currently always NULL
+     */
+    void (*getattr)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi);
+
+    /**
+     * Set file attributes
+     *
+     * In the 'attr' argument only members indicated by the 'to_set'
+     * bitmask contain valid values.  Other members contain undefined
+     * values.
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits if the file
+     * size or owner is being changed.
+     *
+     * If the setattr was invoked from the ftruncate() system call
+     * under Linux kernel versions 2.6.15 or later, the fi->fh will
+     * contain the value set by the open method or will be undefined
+     * if the open method didn't set any value.  Otherwise (not
+     * ftruncate call, or kernel version earlier than 2.6.15) the fi
+     * parameter will be NULL.
+     *
+     * Valid replies:
+     *   fuse_reply_attr
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param attr the attributes
+     * @param to_set bit mask of attributes which should be set
+     * @param fi file information, or NULL
+     */
+    void (*setattr)(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
+                    int to_set, struct fuse_file_info *fi);
+
+    /**
+     * Read symbolic link
+     *
+     * Valid replies:
+     *   fuse_reply_readlink
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     */
+    void (*readlink)(fuse_req_t req, fuse_ino_t ino);
+
+    /**
+     * Create file node
+     *
+     * Create a regular file, character device, block device, fifo or
+     * socket node.
+     *
+     * Valid replies:
+     *   fuse_reply_entry
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name to create
+     * @param mode file type and mode with which to create the new file
+     * @param rdev the device number (only valid if created file is a devi=
ce)
+     */
+    void (*mknod)(fuse_req_t req, fuse_ino_t parent, const char *name,
+                  mode_t mode, dev_t rdev);
+
+    /**
+     * Create a directory
+     *
+     * Valid replies:
+     *   fuse_reply_entry
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name to create
+     * @param mode with which to create the new file
+     */
+    void (*mkdir)(fuse_req_t req, fuse_ino_t parent, const char *name,
+                  mode_t mode);
+
+    /**
+     * Remove a file
+     *
+     * If the file's inode's lookup count is non-zero, the file
+     * system is expected to postpone any removal of the inode
+     * until the lookup count reaches zero (see description of the
+     * forget function).
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name to remove
+     */
+    void (*unlink)(fuse_req_t req, fuse_ino_t parent, const char *name);
+
+    /**
+     * Remove a directory
+     *
+     * If the directory's inode's lookup count is non-zero, the
+     * file system is expected to postpone any removal of the
+     * inode until the lookup count reaches zero (see description
+     * of the forget function).
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name to remove
+     */
+    void (*rmdir)(fuse_req_t req, fuse_ino_t parent, const char *name);
+
+    /**
+     * Create a symbolic link
+     *
+     * Valid replies:
+     *   fuse_reply_entry
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param link the contents of the symbolic link
+     * @param parent inode number of the parent directory
+     * @param name to create
+     */
+    void (*symlink)(fuse_req_t req, const char *link, fuse_ino_t parent,
+                    const char *name);
+
+    /**
+     * Rename a file
+     *
+     * If the target exists it should be atomically replaced. If
+     * the target's inode's lookup count is non-zero, the file
+     * system is expected to postpone any removal of the inode
+     * until the lookup count reaches zero (see description of the
+     * forget function).
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EINVAL, i.e. all
+     * future bmap requests will fail with EINVAL without being
+     * send to the filesystem process.
+     *
+     * *flags* may be `RENAME_EXCHANGE` or `RENAME_NOREPLACE`. If
+     * RENAME_NOREPLACE is specified, the filesystem must not
+     * overwrite *newname* if it exists and return an error
+     * instead. If `RENAME_EXCHANGE` is specified, the filesystem
+     * must atomically exchange the two files, i.e. both must
+     * exist and neither may be deleted.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the old parent directory
+     * @param name old name
+     * @param newparent inode number of the new parent directory
+     * @param newname new name
+     */
+    void (*rename)(fuse_req_t req, fuse_ino_t parent, const char *name,
+                   fuse_ino_t newparent, const char *newname,
+                   unsigned int flags);
+
+    /**
+     * Create a hard link
+     *
+     * Valid replies:
+     *   fuse_reply_entry
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the old inode number
+     * @param newparent inode number of the new parent directory
+     * @param newname new name to create
+     */
+    void (*link)(fuse_req_t req, fuse_ino_t ino, fuse_ino_t newparent,
+                 const char *newname);
+
+    /**
+     * Open a file
+     *
+     * Open flags are available in fi->flags. The following rules
+     * apply.
+     *
+     *  - Creation (O_CREAT, O_EXCL, O_NOCTTY) flags will be
+     *    filtered out / handled by the kernel.
+     *
+     *  - Access modes (O_RDONLY, O_WRONLY, O_RDWR) should be used
+     *    by the filesystem to check if the operation is
+     *    permitted.  If the ``-o default_permissions`` mount
+     *    option is given, this check is already done by the
+     *    kernel before calling open() and may thus be omitted by
+     *    the filesystem.
+     *
+     *  - When writeback caching is enabled, the kernel may send
+     *    read requests even for files opened with O_WRONLY. The
+     *    filesystem should be prepared to handle this.
+     *
+     *  - When writeback caching is disabled, the filesystem is
+     *    expected to properly handle the O_APPEND flag and ensure
+     *    that each write is appending to the end of the file.
+     *
+     *  - When writeback caching is enabled, the kernel will
+     *    handle O_APPEND. However, unless all changes to the file
+     *    come through the kernel this will not work reliably. The
+     *    filesystem should thus either ignore the O_APPEND flag
+     *    (and let the kernel handle it), or return an error
+     *    (indicating that reliably O_APPEND is not available).
+     *
+     * Filesystem may store an arbitrary file handle (pointer,
+     * index, etc) in fi->fh, and use this in other all other file
+     * operations (read, write, flush, release, fsync).
+     *
+     * Filesystem may also implement stateless file I/O and not store
+     * anything in fi->fh.
+     *
+     * There are also some flags (direct_io, keep_cache) which the
+     * filesystem may set in fi, to change the way the file is opened.
+     * See fuse_file_info structure in <fuse_common.h> for more details.
+     *
+     * If this request is answered with an error code of ENOSYS
+     * and FUSE_CAP_NO_OPEN_SUPPORT is set in
+     * `fuse_conn_info.capable`, this is treated as success and
+     * future calls to open and release will also succeed without being
+     * sent to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_open
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     */
+    void (*open)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi=
);
+
+    /**
+     * Read data
+     *
+     * Read should send exactly the number of bytes requested except
+     * on EOF or error, otherwise the rest of the data will be
+     * substituted with zeroes.  An exception to this is when the file
+     * has been opened in 'direct_io' mode, in which case the return
+     * value of the read system call will reflect the return value of
+     * this operation.
+     *
+     * fi->fh will contain the value set by the open method, or will
+     * be undefined if the open method didn't set any value.
+     *
+     * Valid replies:
+     *   fuse_reply_buf
+     *   fuse_reply_iov
+     *   fuse_reply_data
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param size number of bytes to read
+     * @param off offset to read from
+     * @param fi file information
+     */
+    void (*read)(fuse_req_t req, fuse_ino_t ino, size_t size, off_t off,
+                 struct fuse_file_info *fi);
+
+    /**
+     * Write data
+     *
+     * Write should return exactly the number of bytes requested
+     * except on error.  An exception to this is when the file has
+     * been opened in 'direct_io' mode, in which case the return value
+     * of the write system call will reflect the return value of this
+     * operation.
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     *
+     * fi->fh will contain the value set by the open method, or will
+     * be undefined if the open method didn't set any value.
+     *
+     * Valid replies:
+     *   fuse_reply_write
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param buf data to write
+     * @param size number of bytes to write
+     * @param off offset to write to
+     * @param fi file information
+     */
+    void (*write)(fuse_req_t req, fuse_ino_t ino, const char *buf, size_t =
size,
+                  off_t off, struct fuse_file_info *fi);
+
+    /**
+     * Flush method
+     *
+     * This is called on each close() of the opened file.
+     *
+     * Since file descriptors can be duplicated (dup, dup2, fork), for
+     * one open call there may be many flush calls.
+     *
+     * Filesystems shouldn't assume that flush will always be called
+     * after some writes, or that if will be called at all.
+     *
+     * fi->fh will contain the value set by the open method, or will
+     * be undefined if the open method didn't set any value.
+     *
+     * NOTE: the name of the method is misleading, since (unlike
+     * fsync) the filesystem is not forced to flush pending writes.
+     * One reason to flush data is if the filesystem wants to return
+     * write errors during close.  However, such use is non-portable
+     * because POSIX does not require [close] to wait for delayed I/O to
+     * complete.
+     *
+     * If the filesystem supports file locking operations (setlk,
+     * getlk) it should remove all locks belonging to 'fi->owner'.
+     *
+     * If this request is answered with an error code of ENOSYS,
+     * this is treated as success and future calls to flush() will
+     * succeed automatically without being send to the filesystem
+     * process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     *
+     * [close]:
+     * http://pubs.opengroup.org/onlinepubs/9699919799/functions/close.htm=
l
+     */
+    void (*flush)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *f=
i);
+
+    /**
+     * Release an open file
+     *
+     * Release is called when there are no more references to an open
+     * file: all file descriptors are closed and all memory mappings
+     * are unmapped.
+     *
+     * For every open call there will be exactly one release call (unless
+     * the filesystem is force-unmounted).
+     *
+     * The filesystem may reply with an error, but error values are
+     * not returned to close() or munmap() which triggered the
+     * release.
+     *
+     * fi->fh will contain the value set by the open method, or will
+     * be undefined if the open method didn't set any value.
+     * fi->flags will contain the same flags as for open.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     */
+    void (*release)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi);
+
+    /**
+     * Synchronize file contents
+     *
+     * If the datasync parameter is non-zero, then only the user data
+     * should be flushed, not the meta data.
+     *
+     * If this request is answered with an error code of ENOSYS,
+     * this is treated as success and future calls to fsync() will
+     * succeed automatically without being send to the filesystem
+     * process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param datasync flag indicating if only data should be flushed
+     * @param fi file information
+     */
+    void (*fsync)(fuse_req_t req, fuse_ino_t ino, int datasync,
+                  struct fuse_file_info *fi);
+
+    /**
+     * Open a directory
+     *
+     * Filesystem may store an arbitrary file handle (pointer, index,
+     * etc) in fi->fh, and use this in other all other directory
+     * stream operations (readdir, releasedir, fsyncdir).
+     *
+     * If this request is answered with an error code of ENOSYS and
+     * FUSE_CAP_NO_OPENDIR_SUPPORT is set in `fuse_conn_info.capable`,
+     * this is treated as success and future calls to opendir and
+     * releasedir will also succeed without being sent to the filesystem
+     * process. In addition, the kernel will cache readdir results
+     * as if opendir returned FOPEN_KEEP_CACHE | FOPEN_CACHE_DIR.
+     *
+     * Valid replies:
+     *   fuse_reply_open
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     */
+    void (*opendir)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi);
+
+    /**
+     * Read directory
+     *
+     * Send a buffer filled using fuse_add_direntry(), with size not
+     * exceeding the requested size.  Send an empty buffer on end of
+     * stream.
+     *
+     * fi->fh will contain the value set by the opendir method, or
+     * will be undefined if the opendir method didn't set any value.
+     *
+     * Returning a directory entry from readdir() does not affect
+     * its lookup count.
+     *
+     * If off_t is non-zero, then it will correspond to one of the off_t
+     * values that was previously returned by readdir() for the same
+     * directory handle. In this case, readdir() should skip over entries
+     * coming before the position defined by the off_t value. If entries
+     * are added or removed while the directory handle is open, they files=
ystem
+     * may still include the entries that have been removed, and may not
+     * report the entries that have been created. However, addition or
+     * removal of entries must never cause readdir() to skip over unrelate=
d
+     * entries or to report them more than once. This means
+     * that off_t can not be a simple index that enumerates the entries
+     * that have been returned but must contain sufficient information to
+     * uniquely determine the next directory entry to return even when the
+     * set of entries is changing.
+     *
+     * The function does not have to report the '.' and '..'
+     * entries, but is allowed to do so. Note that, if readdir does
+     * not return '.' or '..', they will not be implicitly returned,
+     * and this behavior is observable by the caller.
+     *
+     * Valid replies:
+     *   fuse_reply_buf
+     *   fuse_reply_data
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param size maximum number of bytes to send
+     * @param off offset to continue reading the directory stream
+     * @param fi file information
+     */
+    void (*readdir)(fuse_req_t req, fuse_ino_t ino, size_t size, off_t off=
,
+                    struct fuse_file_info *fi);
+
+    /**
+     * Release an open directory
+     *
+     * For every opendir call there will be exactly one releasedir
+     * call (unless the filesystem is force-unmounted).
+     *
+     * fi->fh will contain the value set by the opendir method, or
+     * will be undefined if the opendir method didn't set any value.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     */
+    void (*releasedir)(fuse_req_t req, fuse_ino_t ino,
+                       struct fuse_file_info *fi);
+
+    /**
+     * Synchronize directory contents
+     *
+     * If the datasync parameter is non-zero, then only the directory
+     * contents should be flushed, not the meta data.
+     *
+     * fi->fh will contain the value set by the opendir method, or
+     * will be undefined if the opendir method didn't set any value.
+     *
+     * If this request is answered with an error code of ENOSYS,
+     * this is treated as success and future calls to fsyncdir() will
+     * succeed automatically without being send to the filesystem
+     * process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param datasync flag indicating if only data should be flushed
+     * @param fi file information
+     */
+    void (*fsyncdir)(fuse_req_t req, fuse_ino_t ino, int datasync,
+                     struct fuse_file_info *fi);
+
+    /**
+     * Get file system statistics
+     *
+     * Valid replies:
+     *   fuse_reply_statfs
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number, zero means "undefined"
+     */
+    void (*statfs)(fuse_req_t req, fuse_ino_t ino);
+
+    /**
+     * Set an extended attribute
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future setxattr() requests will fail with EOPNOTSUPP without being
+     * send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     */
+    void (*setxattr)(fuse_req_t req, fuse_ino_t ino, const char *name,
+                     const char *value, size_t size, int flags);
+
+    /**
+     * Get an extended attribute
+     *
+     * If size is zero, the size of the value should be sent with
+     * fuse_reply_xattr.
+     *
+     * If the size is non-zero, and the value fits in the buffer, the
+     * value should be sent with fuse_reply_buf.
+     *
+     * If the size is too small for the value, the ERANGE error should
+     * be sent.
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future getxattr() requests will fail with EOPNOTSUPP without being
+     * send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_buf
+     *   fuse_reply_data
+     *   fuse_reply_xattr
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param name of the extended attribute
+     * @param size maximum size of the value to send
+     */
+    void (*getxattr)(fuse_req_t req, fuse_ino_t ino, const char *name,
+                     size_t size);
+
+    /**
+     * List extended attribute names
+     *
+     * If size is zero, the total size of the attribute list should be
+     * sent with fuse_reply_xattr.
+     *
+     * If the size is non-zero, and the null character separated
+     * attribute list fits in the buffer, the list should be sent with
+     * fuse_reply_buf.
+     *
+     * If the size is too small for the list, the ERANGE error should
+     * be sent.
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future listxattr() requests will fail with EOPNOTSUPP without being
+     * send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_buf
+     *   fuse_reply_data
+     *   fuse_reply_xattr
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param size maximum size of the list to send
+     */
+    void (*listxattr)(fuse_req_t req, fuse_ino_t ino, size_t size);
+
+    /**
+     * Remove an extended attribute
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future removexattr() requests will fail with EOPNOTSUPP without bei=
ng
+     * send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param name of the extended attribute
+     */
+    void (*removexattr)(fuse_req_t req, fuse_ino_t ino, const char *name);
+
+    /**
+     * Check file access permissions
+     *
+     * This will be called for the access() and chdir() system
+     * calls.  If the 'default_permissions' mount option is given,
+     * this method is not called.
+     *
+     * This method is not called under Linux kernel versions 2.4.x
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent success, i.e. this and all future access()
+     * requests will succeed without being send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param mask requested access mode
+     */
+    void (*access)(fuse_req_t req, fuse_ino_t ino, int mask);
+
+    /**
+     * Create and open a file
+     *
+     * If the file does not exist, first create it with the specified
+     * mode, and then open it.
+     *
+     * See the description of the open handler for more
+     * information.
+     *
+     * If this method is not implemented or under Linux kernel
+     * versions earlier than 2.6.15, the mknod() and open() methods
+     * will be called instead.
+     *
+     * If this request is answered with an error code of ENOSYS, the handl=
er
+     * is treated as not implemented (i.e., for this and future requests t=
he
+     * mknod() and open() handlers will be called instead).
+     *
+     * Valid replies:
+     *   fuse_reply_create
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param parent inode number of the parent directory
+     * @param name to create
+     * @param mode file type and mode with which to create the new file
+     * @param fi file information
+     */
+    void (*create)(fuse_req_t req, fuse_ino_t parent, const char *name,
+                   mode_t mode, struct fuse_file_info *fi);
+
+    /**
+     * Test for a POSIX file lock
+     *
+     * Valid replies:
+     *   fuse_reply_lock
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     * @param lock the region/type to test
+     */
+    void (*getlk)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *f=
i,
+                  struct flock *lock);
+
+    /**
+     * Acquire, modify or release a POSIX file lock
+     *
+     * For POSIX threads (NPTL) there's a 1-1 relation between pid and
+     * owner, but otherwise this is not always the case.  For checking
+     * lock ownership, 'fi->owner' must be used.  The l_pid field in
+     * 'struct flock' should only be used to fill in this field in
+     * getlk().
+     *
+     * Note: if the locking methods are not implemented, the kernel
+     * will still allow file locking to work locally.  Hence these are
+     * only interesting for network filesystems and similar.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     * @param lock the region/type to set
+     * @param sleep locking operation may sleep
+     */
+    void (*setlk)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *f=
i,
+                  struct flock *lock, int sleep);
+
+    /**
+     * Map block index within file to block index within device
+     *
+     * Note: This makes sense only for block device backed filesystems
+     * mounted with the 'blkdev' option
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure, i.e. all future bmap() requests wil=
l
+     * fail with the same error code without being send to the filesystem
+     * process.
+     *
+     * Valid replies:
+     *   fuse_reply_bmap
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param blocksize unit of block index
+     * @param idx block index within file
+     */
+    void (*bmap)(fuse_req_t req, fuse_ino_t ino, size_t blocksize,
+                 uint64_t idx);
+
+    /**
+     * Ioctl
+     *
+     * Note: For unrestricted ioctls (not allowed for FUSE
+     * servers), data in and out areas can be discovered by giving
+     * iovs and setting FUSE_IOCTL_RETRY in *flags*.  For
+     * restricted ioctls, kernel prepares in/out data area
+     * according to the information encoded in cmd.
+     *
+     * Valid replies:
+     *   fuse_reply_ioctl_retry
+     *   fuse_reply_ioctl
+     *   fuse_reply_ioctl_iov
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param cmd ioctl command
+     * @param arg ioctl argument
+     * @param fi file information
+     * @param flags for FUSE_IOCTL_* flags
+     * @param in_buf data fetched from the caller
+     * @param in_bufsz number of fetched bytes
+     * @param out_bufsz maximum size of output data
+     *
+     * Note : the unsigned long request submitted by the application
+     * is truncated to 32 bits.
+     */
+    void (*ioctl)(fuse_req_t req, fuse_ino_t ino, unsigned int cmd, void *=
arg,
+                  struct fuse_file_info *fi, unsigned flags, const void *i=
n_buf,
+                  size_t in_bufsz, size_t out_bufsz);
+
+    /**
+     * Poll for IO readiness
+     *
+     * Note: If ph is non-NULL, the client should notify
+     * when IO readiness events occur by calling
+     * fuse_lowlevel_notify_poll() with the specified ph.
+     *
+     * Regardless of the number of times poll with a non-NULL ph
+     * is received, single notification is enough to clear all.
+     * Notifying more times incurs overhead but doesn't harm
+     * correctness.
+     *
+     * The callee is responsible for destroying ph with
+     * fuse_pollhandle_destroy() when no longer in use.
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as success (with a kernel-defined default poll-mask) and
+     * future calls to pull() will succeed the same way without being send
+     * to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_poll
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     * @param ph poll handle to be used for notification
+     */
+    void (*poll)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *fi=
,
+                 struct fuse_pollhandle *ph);
+
+    /**
+     * Write data made available in a buffer
+     *
+     * This is a more generic version of the ->write() method.  If
+     * FUSE_CAP_SPLICE_READ is set in fuse_conn_info.want and the
+     * kernel supports splicing from the fuse device, then the
+     * data will be made available in pipe for supporting zero
+     * copy data transfer.
+     *
+     * buf->count is guaranteed to be one (and thus buf->idx is
+     * always zero). The write_buf handler must ensure that
+     * bufv->off is correctly updated (reflecting the number of
+     * bytes read from bufv->buf[0]).
+     *
+     * Unless FUSE_CAP_HANDLE_KILLPRIV is disabled, this method is
+     * expected to reset the setuid and setgid bits.
+     *
+     * Valid replies:
+     *   fuse_reply_write
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param bufv buffer containing the data
+     * @param off offset to write to
+     * @param fi file information
+     */
+    void (*write_buf)(fuse_req_t req, fuse_ino_t ino, struct fuse_bufvec *=
bufv,
+                      off_t off, struct fuse_file_info *fi);
+
+    /**
+     * Callback function for the retrieve request
+     *
+     * Valid replies:
+     *  fuse_reply_none
+     *
+     * @param req request handle
+     * @param cookie user data supplied to fuse_lowlevel_notify_retrieve()
+     * @param ino the inode number supplied to fuse_lowlevel_notify_retrie=
ve()
+     * @param offset the offset supplied to fuse_lowlevel_notify_retrieve(=
)
+     * @param bufv the buffer containing the returned data
+     */
+    void (*retrieve_reply)(fuse_req_t req, void *cookie, fuse_ino_t ino,
+                           off_t offset, struct fuse_bufvec *bufv);
+
+    /**
+     * Forget about multiple inodes
+     *
+     * See description of the forget function for more
+     * information.
+     *
+     * Valid replies:
+     *   fuse_reply_none
+     *
+     * @param req request handle
+     */
+    void (*forget_multi)(fuse_req_t req, size_t count,
+                         struct fuse_forget_data *forgets);
+
+    /**
+     * Acquire, modify or release a BSD file lock
+     *
+     * Note: if the locking methods are not implemented, the kernel
+     * will still allow file locking to work locally.  Hence these are
+     * only interesting for network filesystems and similar.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param fi file information
+     * @param op the locking operation, see flock(2)
+     */
+    void (*flock)(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info *f=
i,
+                  int op);
+
+    /**
+     * Allocate requested space. If this function returns success then
+     * subsequent writes to the specified range shall not fail due to the =
lack
+     * of free space on the file system storage media.
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future fallocate() requests will fail with EOPNOTSUPP without being
+     * send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param offset starting point for allocated region
+     * @param length size of allocated region
+     * @param mode determines the operation to be performed on the given r=
ange,
+     *             see fallocate(2)
+     */
+    void (*fallocate)(fuse_req_t req, fuse_ino_t ino, int mode, off_t offs=
et,
+                      off_t length, struct fuse_file_info *fi);
+
+    /**
+     * Read directory with attributes
+     *
+     * Send a buffer filled using fuse_add_direntry_plus(), with size not
+     * exceeding the requested size.  Send an empty buffer on end of
+     * stream.
+     *
+     * fi->fh will contain the value set by the opendir method, or
+     * will be undefined if the opendir method didn't set any value.
+     *
+     * In contrast to readdir() (which does not affect the lookup counts),
+     * the lookup count of every entry returned by readdirplus(), except "=
."
+     * and "..", is incremented by one.
+     *
+     * Valid replies:
+     *   fuse_reply_buf
+     *   fuse_reply_data
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param size maximum number of bytes to send
+     * @param off offset to continue reading the directory stream
+     * @param fi file information
+     */
+    void (*readdirplus)(fuse_req_t req, fuse_ino_t ino, size_t size, off_t=
 off,
+                        struct fuse_file_info *fi);
+
+    /**
+     * Copy a range of data from one file to another
+     *
+     * Performs an optimized copy between two file descriptors without the
+     * additional cost of transferring data through the FUSE kernel module
+     * to user space (glibc) and then back into the FUSE filesystem again.
+     *
+     * In case this method is not implemented, glibc falls back to reading
+     * data from the source and writing to the destination. Effectively
+     * doing an inefficient copy of the data.
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure with error code EOPNOTSUPP, i.e. all
+     * future copy_file_range() requests will fail with EOPNOTSUPP without
+     * being send to the filesystem process.
+     *
+     * Valid replies:
+     *   fuse_reply_write
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino_in the inode number or the source file
+     * @param off_in starting point from were the data should be read
+     * @param fi_in file information of the source file
+     * @param ino_out the inode number or the destination file
+     * @param off_out starting point where the data should be written
+     * @param fi_out file information of the destination file
+     * @param len maximum size of the data to copy
+     * @param flags passed along with the copy_file_range() syscall
+     */
+    void (*copy_file_range)(fuse_req_t req, fuse_ino_t ino_in, off_t off_i=
n,
+                            struct fuse_file_info *fi_in, fuse_ino_t ino_o=
ut,
+                            off_t off_out, struct fuse_file_info *fi_out,
+                            size_t len, int flags);
+
+    /**
+     * Find next data or hole after the specified offset
+     *
+     * If this request is answered with an error code of ENOSYS, this is
+     * treated as a permanent failure, i.e. all future lseek() requests wi=
ll
+     * fail with the same error code without being send to the filesystem
+     * process.
+     *
+     * Valid replies:
+     *   fuse_reply_lseek
+     *   fuse_reply_err
+     *
+     * @param req request handle
+     * @param ino the inode number
+     * @param off offset to start search from
+     * @param whence either SEEK_DATA or SEEK_HOLE
+     * @param fi file information
+     */
+    void (*lseek)(fuse_req_t req, fuse_ino_t ino, off_t off, int whence,
+                  struct fuse_file_info *fi);
 };
=20
 /**
@@ -1305,7 +1307,7 @@ int fuse_reply_entry(fuse_req_t req, const struct fus=
e_entry_param *e);
  * @return zero for success, -errno for failure to send reply
  */
 int fuse_reply_create(fuse_req_t req, const struct fuse_entry_param *e,
-=09=09      const struct fuse_file_info *fi);
+                      const struct fuse_file_info *fi);
=20
 /**
  * Reply with attributes
@@ -1315,11 +1317,11 @@ int fuse_reply_create(fuse_req_t req, const struct =
fuse_entry_param *e,
  *
  * @param req request handle
  * @param attr the attributes
- * @param attr_timeout=09validity timeout (in seconds) for the attributes
+ * @param attr_timeout validity timeout (in seconds) for the attributes
  * @return zero for success, -errno for failure to send reply
  */
 int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
-=09=09    double attr_timeout);
+                    double attr_timeout);
=20
 /**
  * Reply with the contents of a symbolic link
@@ -1417,7 +1419,7 @@ int fuse_reply_buf(fuse_req_t req, const char *buf, s=
ize_t size);
  * @return zero for success, -errno for failure to send reply
  */
 int fuse_reply_data(fuse_req_t req, struct fuse_bufvec *bufv,
-=09=09    enum fuse_buf_copy_flags flags);
+                    enum fuse_buf_copy_flags flags);
=20
 /**
  * Reply with data vector
@@ -1480,9 +1482,9 @@ int fuse_reply_lock(fuse_req_t req, const struct floc=
k *lock);
  */
 int fuse_reply_bmap(fuse_req_t req, uint64_t idx);
=20
-/* ----------------------------------------------------------- *
- * Filling a buffer in readdir=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Filling a buffer in readdir
+ */
=20
 /**
  * Add a directory entry to the buffer
@@ -1512,8 +1514,7 @@ int fuse_reply_bmap(fuse_req_t req, uint64_t idx);
  * @return the space needed for the entry
  */
 size_t fuse_add_direntry(fuse_req_t req, char *buf, size_t bufsize,
-=09=09=09 const char *name, const struct stat *stbuf,
-=09=09=09 off_t off);
+                         const char *name, const struct stat *stbuf, off_t=
 off);
=20
 /**
  * Add a directory entry to the buffer with the attributes
@@ -1529,8 +1530,8 @@ size_t fuse_add_direntry(fuse_req_t req, char *buf, s=
ize_t bufsize,
  * @return the space needed for the entry
  */
 size_t fuse_add_direntry_plus(fuse_req_t req, char *buf, size_t bufsize,
-=09=09=09      const char *name,
-=09=09=09      const struct fuse_entry_param *e, off_t off);
+                              const char *name,
+                              const struct fuse_entry_param *e, off_t off)=
;
=20
 /**
  * Reply to ask for data fetch and output buffer preparation.  ioctl
@@ -1547,9 +1548,9 @@ size_t fuse_add_direntry_plus(fuse_req_t req, char *b=
uf, size_t bufsize,
  * @param out_count number of entries in out_iov
  * @return zero for success, -errno for failure to send reply
  */
-int fuse_reply_ioctl_retry(fuse_req_t req,
-=09=09=09   const struct iovec *in_iov, size_t in_count,
-=09=09=09   const struct iovec *out_iov, size_t out_count);
+int fuse_reply_ioctl_retry(fuse_req_t req, const struct iovec *in_iov,
+                           size_t in_count, const struct iovec *out_iov,
+                           size_t out_count);
=20
 /**
  * Reply to finish ioctl
@@ -1576,7 +1577,7 @@ int fuse_reply_ioctl(fuse_req_t req, int result, cons=
t void *buf, size_t size);
  * @param count the size of vector
  */
 int fuse_reply_ioctl_iov(fuse_req_t req, int result, const struct iovec *i=
ov,
-=09=09=09 int count);
+                         int count);
=20
 /**
  * Reply with poll result event mask
@@ -1598,9 +1599,9 @@ int fuse_reply_poll(fuse_req_t req, unsigned revents)=
;
  */
 int fuse_reply_lseek(fuse_req_t req, off_t off);
=20
-/* ----------------------------------------------------------- *
- * Notification=09=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Notification
+ */
=20
 /**
  * Notify IO readiness event
@@ -1635,7 +1636,7 @@ int fuse_lowlevel_notify_poll(struct fuse_pollhandle =
*ph);
  * @return zero for success, -errno for failure
  */
 int fuse_lowlevel_notify_inval_inode(struct fuse_session *se, fuse_ino_t i=
no,
-=09=09=09=09     off_t off, off_t len);
+                                     off_t off, off_t len);
=20
 /**
  * Notify to invalidate parent attributes and the dentry matching
@@ -1663,7 +1664,7 @@ int fuse_lowlevel_notify_inval_inode(struct fuse_sess=
ion *se, fuse_ino_t ino,
  * @return zero for success, -errno for failure
  */
 int fuse_lowlevel_notify_inval_entry(struct fuse_session *se, fuse_ino_t p=
arent,
-=09=09=09=09     const char *name, size_t namelen);
+                                     const char *name, size_t namelen);
=20
 /**
  * This function behaves like fuse_lowlevel_notify_inval_entry() with
@@ -1693,9 +1694,9 @@ int fuse_lowlevel_notify_inval_entry(struct fuse_sess=
ion *se, fuse_ino_t parent,
  * @param namelen strlen() of file name
  * @return zero for success, -errno for failure
  */
-int fuse_lowlevel_notify_delete(struct fuse_session *se,
-=09=09=09=09fuse_ino_t parent, fuse_ino_t child,
-=09=09=09=09const char *name, size_t namelen);
+int fuse_lowlevel_notify_delete(struct fuse_session *se, fuse_ino_t parent=
,
+                                fuse_ino_t child, const char *name,
+                                size_t namelen);
=20
 /**
  * Store data to the kernel buffers
@@ -1723,8 +1724,8 @@ int fuse_lowlevel_notify_delete(struct fuse_session *=
se,
  * @return zero for success, -errno for failure
  */
 int fuse_lowlevel_notify_store(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09       off_t offset, struct fuse_bufvec *bufv,
-=09=09=09       enum fuse_buf_copy_flags flags);
+                               off_t offset, struct fuse_bufvec *bufv,
+                               enum fuse_buf_copy_flags flags);
 /**
  * Retrieve data from the kernel buffers
  *
@@ -1755,12 +1756,12 @@ int fuse_lowlevel_notify_store(struct fuse_session =
*se, fuse_ino_t ino,
  * @return zero for success, -errno for failure
  */
 int fuse_lowlevel_notify_retrieve(struct fuse_session *se, fuse_ino_t ino,
-=09=09=09=09  size_t size, off_t offset, void *cookie);
+                                  size_t size, off_t offset, void *cookie)=
;
=20
=20
-/* ----------------------------------------------------------- *
- * Utility functions=09=09=09=09=09       *
- * ----------------------------------------------------------- */
+/*
+ * Utility functions
+ */
=20
 /**
  * Get the userdata from the request
@@ -1822,7 +1823,7 @@ typedef void (*fuse_interrupt_func_t)(fuse_req_t req,=
 void *data);
  * @param data user data passed to the callback function
  */
 void fuse_req_interrupt_func(fuse_req_t req, fuse_interrupt_func_t func,
-=09=09=09     void *data);
+                             void *data);
=20
 /**
  * Check if a request has already been interrupted
@@ -1833,9 +1834,9 @@ void fuse_req_interrupt_func(fuse_req_t req, fuse_int=
errupt_func_t func,
 int fuse_req_interrupted(fuse_req_t req);
=20
=20
-/* ----------------------------------------------------------- *
- * Inquiry functions                                           *
- * ----------------------------------------------------------- */
+/*
+ * Inquiry functions
+ */
=20
 /**
  * Print low-level version information to stdout.
@@ -1854,20 +1855,20 @@ void fuse_lowlevel_help(void);
  */
 void fuse_cmdline_help(void);
=20
-/* ----------------------------------------------------------- *
- * Filesystem setup & teardown                                 *
- * ----------------------------------------------------------- */
+/*
+ * Filesystem setup & teardown
+ */
=20
 struct fuse_cmdline_opts {
-=09int singlethread;
-=09int foreground;
-=09int debug;
-=09int nodefault_subtype;
-=09char *mountpoint;
-=09int show_version;
-=09int show_help;
-=09int clone_fd;
-=09unsigned int max_idle_threads;
+    int singlethread;
+    int foreground;
+    int debug;
+    int nodefault_subtype;
+    char *mountpoint;
+    int show_version;
+    int show_help;
+    int clone_fd;
+    unsigned int max_idle_threads;
 };
=20
 /**
@@ -1888,8 +1889,7 @@ struct fuse_cmdline_opts {
  * @param opts output argument for parsed options
  * @return 0 on success, -1 on failure
  */
-int fuse_parse_cmdline(struct fuse_args *args,
-=09=09       struct fuse_cmdline_opts *opts);
+int fuse_parse_cmdline(struct fuse_args *args, struct fuse_cmdline_opts *o=
pts);
=20
 /**
  * Create a low level session.
@@ -1920,8 +1920,8 @@ int fuse_parse_cmdline(struct fuse_args *args,
  * @return the fuse session on success, NULL on failure
  **/
 struct fuse_session *fuse_session_new(struct fuse_args *args,
-=09=09=09=09      const struct fuse_lowlevel_ops *op,
-=09=09=09=09      size_t op_size, void *userdata);
+                                      const struct fuse_lowlevel_ops *op,
+                                      size_t op_size, void *userdata);
=20
 /**
  * Mount a FUSE file system.
@@ -1965,14 +1965,15 @@ int fuse_session_loop(struct fuse_session *se);
  * fuse_session_loop().
  *
  * @param se the session
- * @param config session loop configuration=20
+ * @param config session loop configuration
  * @return see fuse_session_loop()
  */
 #if FUSE_USE_VERSION < 32
 int fuse_session_loop_mt_31(struct fuse_session *se, int clone_fd);
 #define fuse_session_loop_mt(se, clone_fd) fuse_session_loop_mt_31(se, clo=
ne_fd)
 #else
-int fuse_session_loop_mt(struct fuse_session *se, struct fuse_loop_config =
*config);
+int fuse_session_loop_mt(struct fuse_session *se,
+                         struct fuse_loop_config *config);
 #endif
=20
 /**
@@ -2034,9 +2035,9 @@ void fuse_session_unmount(struct fuse_session *se);
  */
 void fuse_session_destroy(struct fuse_session *se);
=20
-/* ----------------------------------------------------------- *
- * Custom event loop support                                   *
- * ----------------------------------------------------------- */
+/*
+ * Custom event loop support
+ */
=20
 /**
  * Return file descriptor for communication with kernel.
@@ -2063,7 +2064,7 @@ int fuse_session_fd(struct fuse_session *se);
  * @param buf the fuse_buf containing the request
  */
 void fuse_session_process_buf(struct fuse_session *se,
-=09=09=09      const struct fuse_buf *buf);
+                              const struct fuse_buf *buf);
=20
 /**
  * Read a raw request from the kernel into the supplied buffer.
diff --git a/tools/virtiofsd/fuse_misc.h b/tools/virtiofsd/fuse_misc.h
index 2f6663ed7d..f252baa752 100644
--- a/tools/virtiofsd/fuse_misc.h
+++ b/tools/virtiofsd/fuse_misc.h
@@ -1,18 +1,18 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #include <pthread.h>
=20
 /*
-  Versioned symbols cannot be used in some cases because it
-    - confuse the dynamic linker in uClibc
-    - not supported on MacOSX (in MachO binary format)
-*/
+ * Versioned symbols cannot be used in some cases because it
+ *   - confuse the dynamic linker in uClibc
+ *   - not supported on MacOSX (in MachO binary format)
+ */
 #if (!defined(__UCLIBC__) && !defined(__APPLE__))
 #define FUSE_SYMVER(x) __asm__(x)
 #else
@@ -25,11 +25,11 @@
 /* Is this hack still needed? */
 static inline void fuse_mutex_init(pthread_mutex_t *mut)
 {
-=09pthread_mutexattr_t attr;
-=09pthread_mutexattr_init(&attr);
-=09pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ADAPTIVE_NP);
-=09pthread_mutex_init(mut, &attr);
-=09pthread_mutexattr_destroy(&attr);
+    pthread_mutexattr_t attr;
+    pthread_mutexattr_init(&attr);
+    pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ADAPTIVE_NP);
+    pthread_mutex_init(mut, &attr);
+    pthread_mutexattr_destroy(&attr);
 }
 #endif
=20
diff --git a/tools/virtiofsd/fuse_opt.c b/tools/virtiofsd/fuse_opt.c
index 93066b926e..edd36f4a3b 100644
--- a/tools/virtiofsd/fuse_opt.c
+++ b/tools/virtiofsd/fuse_opt.c
@@ -1,423 +1,450 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  Implementation of option parsing routines (dealing with `struct
-  fuse_args`).
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Implementation of option parsing routines (dealing with `struct
+ * fuse_args`).
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
+#include "fuse_opt.h"
 #include "config.h"
 #include "fuse_i.h"
-#include "fuse_opt.h"
 #include "fuse_misc.h"
=20
+#include <assert.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <assert.h>
=20
 struct fuse_opt_context {
-=09void *data;
-=09const struct fuse_opt *opt;
-=09fuse_opt_proc_t proc;
-=09int argctr;
-=09int argc;
-=09char **argv;
-=09struct fuse_args outargs;
-=09char *opts;
-=09int nonopt;
+    void *data;
+    const struct fuse_opt *opt;
+    fuse_opt_proc_t proc;
+    int argctr;
+    int argc;
+    char **argv;
+    struct fuse_args outargs;
+    char *opts;
+    int nonopt;
 };
=20
 void fuse_opt_free_args(struct fuse_args *args)
 {
-=09if (args) {
-=09=09if (args->argv && args->allocated) {
-=09=09=09int i;
-=09=09=09for (i =3D 0; i < args->argc; i++)
-=09=09=09=09free(args->argv[i]);
-=09=09=09free(args->argv);
-=09=09}
-=09=09args->argc =3D 0;
-=09=09args->argv =3D NULL;
-=09=09args->allocated =3D 0;
-=09}
+    if (args) {
+        if (args->argv && args->allocated) {
+            int i;
+            for (i =3D 0; i < args->argc; i++) {
+                free(args->argv[i]);
+            }
+            free(args->argv);
+        }
+        args->argc =3D 0;
+        args->argv =3D NULL;
+        args->allocated =3D 0;
+    }
 }
=20
 static int alloc_failed(void)
 {
-=09fuse_log(FUSE_LOG_ERR, "fuse: memory allocation failed\n");
-=09return -1;
+    fuse_log(FUSE_LOG_ERR, "fuse: memory allocation failed\n");
+    return -1;
 }
=20
 int fuse_opt_add_arg(struct fuse_args *args, const char *arg)
 {
-=09char **newargv;
-=09char *newarg;
-
-=09assert(!args->argv || args->allocated);
-
-=09newarg =3D strdup(arg);
-=09if (!newarg)
-=09=09return alloc_failed();
-
-=09newargv =3D realloc(args->argv, (args->argc + 2) * sizeof(char *));
-=09if (!newargv) {
-=09=09free(newarg);
-=09=09return alloc_failed();
-=09}
-
-=09args->argv =3D newargv;
-=09args->allocated =3D 1;
-=09args->argv[args->argc++] =3D newarg;
-=09args->argv[args->argc] =3D NULL;
-=09return 0;
+    char **newargv;
+    char *newarg;
+
+    assert(!args->argv || args->allocated);
+
+    newarg =3D strdup(arg);
+    if (!newarg) {
+        return alloc_failed();
+    }
+
+    newargv =3D realloc(args->argv, (args->argc + 2) * sizeof(char *));
+    if (!newargv) {
+        free(newarg);
+        return alloc_failed();
+    }
+
+    args->argv =3D newargv;
+    args->allocated =3D 1;
+    args->argv[args->argc++] =3D newarg;
+    args->argv[args->argc] =3D NULL;
+    return 0;
 }
=20
 static int fuse_opt_insert_arg_common(struct fuse_args *args, int pos,
-=09=09=09=09      const char *arg)
+                                      const char *arg)
 {
-=09assert(pos <=3D args->argc);
-=09if (fuse_opt_add_arg(args, arg) =3D=3D -1)
-=09=09return -1;
-
-=09if (pos !=3D args->argc - 1) {
-=09=09char *newarg =3D args->argv[args->argc - 1];
-=09=09memmove(&args->argv[pos + 1], &args->argv[pos],
-=09=09=09sizeof(char *) * (args->argc - pos - 1));
-=09=09args->argv[pos] =3D newarg;
-=09}
-=09return 0;
+    assert(pos <=3D args->argc);
+    if (fuse_opt_add_arg(args, arg) =3D=3D -1) {
+        return -1;
+    }
+
+    if (pos !=3D args->argc - 1) {
+        char *newarg =3D args->argv[args->argc - 1];
+        memmove(&args->argv[pos + 1], &args->argv[pos],
+                sizeof(char *) * (args->argc - pos - 1));
+        args->argv[pos] =3D newarg;
+    }
+    return 0;
 }
=20
 int fuse_opt_insert_arg(struct fuse_args *args, int pos, const char *arg)
 {
-=09return fuse_opt_insert_arg_common(args, pos, arg);
+    return fuse_opt_insert_arg_common(args, pos, arg);
 }
=20
 static int next_arg(struct fuse_opt_context *ctx, const char *opt)
 {
-=09if (ctx->argctr + 1 >=3D ctx->argc) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: missing argument after `%s'\n", opt);
-=09=09return -1;
-=09}
-=09ctx->argctr++;
-=09return 0;
+    if (ctx->argctr + 1 >=3D ctx->argc) {
+        fuse_log(FUSE_LOG_ERR, "fuse: missing argument after `%s'\n", opt)=
;
+        return -1;
+    }
+    ctx->argctr++;
+    return 0;
 }
=20
 static int add_arg(struct fuse_opt_context *ctx, const char *arg)
 {
-=09return fuse_opt_add_arg(&ctx->outargs, arg);
+    return fuse_opt_add_arg(&ctx->outargs, arg);
 }
=20
 static int add_opt_common(char **opts, const char *opt, int esc)
 {
-=09unsigned oldlen =3D *opts ? strlen(*opts) : 0;
-=09char *d =3D realloc(*opts, oldlen + 1 + strlen(opt) * 2 + 1);
-
-=09if (!d)
-=09=09return alloc_failed();
-
-=09*opts =3D d;
-=09if (oldlen) {
-=09=09d +=3D oldlen;
-=09=09*d++ =3D ',';
-=09}
-
-=09for (; *opt; opt++) {
-=09=09if (esc && (*opt =3D=3D ',' || *opt =3D=3D '\\'))
-=09=09=09*d++ =3D '\\';
-=09=09*d++ =3D *opt;
-=09}
-=09*d =3D '\0';
-
-=09return 0;
+    unsigned oldlen =3D *opts ? strlen(*opts) : 0;
+    char *d =3D realloc(*opts, oldlen + 1 + strlen(opt) * 2 + 1);
+
+    if (!d) {
+        return alloc_failed();
+    }
+
+    *opts =3D d;
+    if (oldlen) {
+        d +=3D oldlen;
+        *d++ =3D ',';
+    }
+
+    for (; *opt; opt++) {
+        if (esc && (*opt =3D=3D ',' || *opt =3D=3D '\\')) {
+            *d++ =3D '\\';
+        }
+        *d++ =3D *opt;
+    }
+    *d =3D '\0';
+
+    return 0;
 }
=20
 int fuse_opt_add_opt(char **opts, const char *opt)
 {
-=09return add_opt_common(opts, opt, 0);
+    return add_opt_common(opts, opt, 0);
 }
=20
 int fuse_opt_add_opt_escaped(char **opts, const char *opt)
 {
-=09return add_opt_common(opts, opt, 1);
+    return add_opt_common(opts, opt, 1);
 }
=20
 static int add_opt(struct fuse_opt_context *ctx, const char *opt)
 {
-=09return add_opt_common(&ctx->opts, opt, 1);
+    return add_opt_common(&ctx->opts, opt, 1);
 }
=20
 static int call_proc(struct fuse_opt_context *ctx, const char *arg, int ke=
y,
-=09=09     int iso)
+                     int iso)
 {
-=09if (key =3D=3D FUSE_OPT_KEY_DISCARD)
-=09=09return 0;
-
-=09if (key !=3D FUSE_OPT_KEY_KEEP && ctx->proc) {
-=09=09int res =3D ctx->proc(ctx->data, arg, key, &ctx->outargs);
-=09=09if (res =3D=3D -1 || !res)
-=09=09=09return res;
-=09}
-=09if (iso)
-=09=09return add_opt(ctx, arg);
-=09else
-=09=09return add_arg(ctx, arg);
+    if (key =3D=3D FUSE_OPT_KEY_DISCARD) {
+        return 0;
+    }
+
+    if (key !=3D FUSE_OPT_KEY_KEEP && ctx->proc) {
+        int res =3D ctx->proc(ctx->data, arg, key, &ctx->outargs);
+        if (res =3D=3D -1 || !res) {
+            return res;
+        }
+    }
+    if (iso) {
+        return add_opt(ctx, arg);
+    } else {
+        return add_arg(ctx, arg);
+    }
 }
=20
 static int match_template(const char *t, const char *arg, unsigned *sepp)
 {
-=09int arglen =3D strlen(arg);
-=09const char *sep =3D strchr(t, '=3D');
-=09sep =3D sep ? sep : strchr(t, ' ');
-=09if (sep && (!sep[1] || sep[1] =3D=3D '%')) {
-=09=09int tlen =3D sep - t;
-=09=09if (sep[0] =3D=3D '=3D')
-=09=09=09tlen ++;
-=09=09if (arglen >=3D tlen && strncmp(arg, t, tlen) =3D=3D 0) {
-=09=09=09*sepp =3D sep - t;
-=09=09=09return 1;
-=09=09}
-=09}
-=09if (strcmp(t, arg) =3D=3D 0) {
-=09=09*sepp =3D 0;
-=09=09return 1;
-=09}
-=09return 0;
+    int arglen =3D strlen(arg);
+    const char *sep =3D strchr(t, '=3D');
+    sep =3D sep ? sep : strchr(t, ' ');
+    if (sep && (!sep[1] || sep[1] =3D=3D '%')) {
+        int tlen =3D sep - t;
+        if (sep[0] =3D=3D '=3D') {
+            tlen++;
+        }
+        if (arglen >=3D tlen && strncmp(arg, t, tlen) =3D=3D 0) {
+            *sepp =3D sep - t;
+            return 1;
+        }
+    }
+    if (strcmp(t, arg) =3D=3D 0) {
+        *sepp =3D 0;
+        return 1;
+    }
+    return 0;
 }
=20
 static const struct fuse_opt *find_opt(const struct fuse_opt *opt,
-=09=09=09=09       const char *arg, unsigned *sepp)
+                                       const char *arg, unsigned *sepp)
 {
-=09for (; opt && opt->templ; opt++)
-=09=09if (match_template(opt->templ, arg, sepp))
-=09=09=09return opt;
-=09return NULL;
+    for (; opt && opt->templ; opt++) {
+        if (match_template(opt->templ, arg, sepp)) {
+            return opt;
+        }
+    }
+    return NULL;
 }
=20
 int fuse_opt_match(const struct fuse_opt *opts, const char *opt)
 {
-=09unsigned dummy;
-=09return find_opt(opts, opt, &dummy) ? 1 : 0;
+    unsigned dummy;
+    return find_opt(opts, opt, &dummy) ? 1 : 0;
 }
=20
 static int process_opt_param(void *var, const char *format, const char *pa=
ram,
-=09=09=09     const char *arg)
+                             const char *arg)
 {
-=09assert(format[0] =3D=3D '%');
-=09if (format[1] =3D=3D 's') {
-=09=09char **s =3D var;
-=09=09char *copy =3D strdup(param);
-=09=09if (!copy)
-=09=09=09return alloc_failed();
-
-=09=09free(*s);
-=09=09*s =3D copy;
-=09} else {
-=09=09if (sscanf(param, format, var) !=3D 1) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: invalid parameter in option `%s'\n"=
, arg);
-=09=09=09return -1;
-=09=09}
-=09}
-=09return 0;
+    assert(format[0] =3D=3D '%');
+    if (format[1] =3D=3D 's') {
+        char **s =3D var;
+        char *copy =3D strdup(param);
+        if (!copy) {
+            return alloc_failed();
+        }
+
+        free(*s);
+        *s =3D copy;
+    } else {
+        if (sscanf(param, format, var) !=3D 1) {
+            fuse_log(FUSE_LOG_ERR, "fuse: invalid parameter in option `%s'=
\n",
+                     arg);
+            return -1;
+        }
+    }
+    return 0;
 }
=20
-static int process_opt(struct fuse_opt_context *ctx,
-=09=09       const struct fuse_opt *opt, unsigned sep,
-=09=09       const char *arg, int iso)
+static int process_opt(struct fuse_opt_context *ctx, const struct fuse_opt=
 *opt,
+                       unsigned sep, const char *arg, int iso)
 {
-=09if (opt->offset =3D=3D -1U) {
-=09=09if (call_proc(ctx, arg, opt->value, iso) =3D=3D -1)
-=09=09=09return -1;
-=09} else {
-=09=09void *var =3D (char *)ctx->data + opt->offset;
-=09=09if (sep && opt->templ[sep + 1]) {
-=09=09=09const char *param =3D arg + sep;
-=09=09=09if (opt->templ[sep] =3D=3D '=3D')
-=09=09=09=09param ++;
-=09=09=09if (process_opt_param(var, opt->templ + sep + 1,
-=09=09=09=09=09      param, arg) =3D=3D -1)
-=09=09=09=09return -1;
-=09=09} else
-=09=09=09*(int *)var =3D opt->value;
-=09}
-=09return 0;
+    if (opt->offset =3D=3D -1U) {
+        if (call_proc(ctx, arg, opt->value, iso) =3D=3D -1) {
+            return -1;
+        }
+    } else {
+        void *var =3D (char *)ctx->data + opt->offset;
+        if (sep && opt->templ[sep + 1]) {
+            const char *param =3D arg + sep;
+            if (opt->templ[sep] =3D=3D '=3D') {
+                param++;
+            }
+            if (process_opt_param(var, opt->templ + sep + 1, param, arg) =
=3D=3D
+                -1) {
+                return -1;
+            }
+        } else {
+            *(int *)var =3D opt->value;
+        }
+    }
+    return 0;
 }
=20
 static int process_opt_sep_arg(struct fuse_opt_context *ctx,
-=09=09=09       const struct fuse_opt *opt, unsigned sep,
-=09=09=09       const char *arg, int iso)
+                               const struct fuse_opt *opt, unsigned sep,
+                               const char *arg, int iso)
 {
-=09int res;
-=09char *newarg;
-=09char *param;
-
-=09if (next_arg(ctx, arg) =3D=3D -1)
-=09=09return -1;
-
-=09param =3D ctx->argv[ctx->argctr];
-=09newarg =3D malloc(sep + strlen(param) + 1);
-=09if (!newarg)
-=09=09return alloc_failed();
-
-=09memcpy(newarg, arg, sep);
-=09strcpy(newarg + sep, param);
-=09res =3D process_opt(ctx, opt, sep, newarg, iso);
-=09free(newarg);
-
-=09return res;
+    int res;
+    char *newarg;
+    char *param;
+
+    if (next_arg(ctx, arg) =3D=3D -1) {
+        return -1;
+    }
+
+    param =3D ctx->argv[ctx->argctr];
+    newarg =3D malloc(sep + strlen(param) + 1);
+    if (!newarg) {
+        return alloc_failed();
+    }
+
+    memcpy(newarg, arg, sep);
+    strcpy(newarg + sep, param);
+    res =3D process_opt(ctx, opt, sep, newarg, iso);
+    free(newarg);
+
+    return res;
 }
=20
 static int process_gopt(struct fuse_opt_context *ctx, const char *arg, int=
 iso)
 {
-=09unsigned sep;
-=09const struct fuse_opt *opt =3D find_opt(ctx->opt, arg, &sep);
-=09if (opt) {
-=09=09for (; opt; opt =3D find_opt(opt + 1, arg, &sep)) {
-=09=09=09int res;
-=09=09=09if (sep && opt->templ[sep] =3D=3D ' ' && !arg[sep])
-=09=09=09=09res =3D process_opt_sep_arg(ctx, opt, sep, arg,
-=09=09=09=09=09=09=09  iso);
-=09=09=09else
-=09=09=09=09res =3D process_opt(ctx, opt, sep, arg, iso);
-=09=09=09if (res =3D=3D -1)
-=09=09=09=09return -1;
-=09=09}
-=09=09return 0;
-=09} else
-=09=09return call_proc(ctx, arg, FUSE_OPT_KEY_OPT, iso);
+    unsigned sep;
+    const struct fuse_opt *opt =3D find_opt(ctx->opt, arg, &sep);
+    if (opt) {
+        for (; opt; opt =3D find_opt(opt + 1, arg, &sep)) {
+            int res;
+            if (sep && opt->templ[sep] =3D=3D ' ' && !arg[sep]) {
+                res =3D process_opt_sep_arg(ctx, opt, sep, arg, iso);
+            } else {
+                res =3D process_opt(ctx, opt, sep, arg, iso);
+            }
+            if (res =3D=3D -1) {
+                return -1;
+            }
+        }
+        return 0;
+    } else {
+        return call_proc(ctx, arg, FUSE_OPT_KEY_OPT, iso);
+    }
 }
=20
 static int process_real_option_group(struct fuse_opt_context *ctx, char *o=
pts)
 {
-=09char *s =3D opts;
-=09char *d =3D s;
-=09int end =3D 0;
-
-=09while (!end) {
-=09=09if (*s =3D=3D '\0')
-=09=09=09end =3D 1;
-=09=09if (*s =3D=3D ',' || end) {
-=09=09=09int res;
-
-=09=09=09*d =3D '\0';
-=09=09=09res =3D process_gopt(ctx, opts, 1);
-=09=09=09if (res =3D=3D -1)
-=09=09=09=09return -1;
-=09=09=09d =3D opts;
-=09=09} else {
-=09=09=09if (s[0] =3D=3D '\\' && s[1] !=3D '\0') {
-=09=09=09=09s++;
-=09=09=09=09if (s[0] >=3D '0' && s[0] <=3D '3' &&
-=09=09=09=09    s[1] >=3D '0' && s[1] <=3D '7' &&
-=09=09=09=09    s[2] >=3D '0' && s[2] <=3D '7') {
-=09=09=09=09=09*d++ =3D (s[0] - '0') * 0100 +
-=09=09=09=09=09=09(s[1] - '0') * 0010 +
-=09=09=09=09=09=09(s[2] - '0');
-=09=09=09=09=09s +=3D 2;
-=09=09=09=09} else {
-=09=09=09=09=09*d++ =3D *s;
-=09=09=09=09}
-=09=09=09} else {
-=09=09=09=09*d++ =3D *s;
-=09=09=09}
-=09=09}
-=09=09s++;
-=09}
-
-=09return 0;
+    char *s =3D opts;
+    char *d =3D s;
+    int end =3D 0;
+
+    while (!end) {
+        if (*s =3D=3D '\0') {
+            end =3D 1;
+        }
+        if (*s =3D=3D ',' || end) {
+            int res;
+
+            *d =3D '\0';
+            res =3D process_gopt(ctx, opts, 1);
+            if (res =3D=3D -1) {
+                return -1;
+            }
+            d =3D opts;
+        } else {
+            if (s[0] =3D=3D '\\' && s[1] !=3D '\0') {
+                s++;
+                if (s[0] >=3D '0' && s[0] <=3D '3' && s[1] >=3D '0' && s[1=
] <=3D '7' &&
+                    s[2] >=3D '0' && s[2] <=3D '7') {
+                    *d++ =3D (s[0] - '0') * 0100 + (s[1] - '0') * 0010 +
+                           (s[2] - '0');
+                    s +=3D 2;
+                } else {
+                    *d++ =3D *s;
+                }
+            } else {
+                *d++ =3D *s;
+            }
+        }
+        s++;
+    }
+
+    return 0;
 }
=20
 static int process_option_group(struct fuse_opt_context *ctx, const char *=
opts)
 {
-=09int res;
-=09char *copy =3D strdup(opts);
-
-=09if (!copy) {
-=09=09fuse_log(FUSE_LOG_ERR, "fuse: memory allocation failed\n");
-=09=09return -1;
-=09}
-=09res =3D process_real_option_group(ctx, copy);
-=09free(copy);
-=09return res;
+    int res;
+    char *copy =3D strdup(opts);
+
+    if (!copy) {
+        fuse_log(FUSE_LOG_ERR, "fuse: memory allocation failed\n");
+        return -1;
+    }
+    res =3D process_real_option_group(ctx, copy);
+    free(copy);
+    return res;
 }
=20
 static int process_one(struct fuse_opt_context *ctx, const char *arg)
 {
-=09if (ctx->nonopt || arg[0] !=3D '-')
-=09=09return call_proc(ctx, arg, FUSE_OPT_KEY_NONOPT, 0);
-=09else if (arg[1] =3D=3D 'o') {
-=09=09if (arg[2])
-=09=09=09return process_option_group(ctx, arg + 2);
-=09=09else {
-=09=09=09if (next_arg(ctx, arg) =3D=3D -1)
-=09=09=09=09return -1;
-
-=09=09=09return process_option_group(ctx,
-=09=09=09=09=09=09    ctx->argv[ctx->argctr]);
-=09=09}
-=09} else if (arg[1] =3D=3D '-' && !arg[2]) {
-=09=09if (add_arg(ctx, arg) =3D=3D -1)
-=09=09=09return -1;
-=09=09ctx->nonopt =3D ctx->outargs.argc;
-=09=09return 0;
-=09} else
-=09=09return process_gopt(ctx, arg, 0);
+    if (ctx->nonopt || arg[0] !=3D '-') {
+        return call_proc(ctx, arg, FUSE_OPT_KEY_NONOPT, 0);
+    } else if (arg[1] =3D=3D 'o') {
+        if (arg[2]) {
+            return process_option_group(ctx, arg + 2);
+        } else {
+            if (next_arg(ctx, arg) =3D=3D -1) {
+                return -1;
+            }
+
+            return process_option_group(ctx, ctx->argv[ctx->argctr]);
+        }
+    } else if (arg[1] =3D=3D '-' && !arg[2]) {
+        if (add_arg(ctx, arg) =3D=3D -1) {
+            return -1;
+        }
+        ctx->nonopt =3D ctx->outargs.argc;
+        return 0;
+    } else {
+        return process_gopt(ctx, arg, 0);
+    }
 }
=20
 static int opt_parse(struct fuse_opt_context *ctx)
 {
-=09if (ctx->argc) {
-=09=09if (add_arg(ctx, ctx->argv[0]) =3D=3D -1)
-=09=09=09return -1;
-=09}
-
-=09for (ctx->argctr =3D 1; ctx->argctr < ctx->argc; ctx->argctr++)
-=09=09if (process_one(ctx, ctx->argv[ctx->argctr]) =3D=3D -1)
-=09=09=09return -1;
-
-=09if (ctx->opts) {
-=09=09if (fuse_opt_insert_arg(&ctx->outargs, 1, "-o") =3D=3D -1 ||
-=09=09    fuse_opt_insert_arg(&ctx->outargs, 2, ctx->opts) =3D=3D -1)
-=09=09=09return -1;
-=09}
-
-=09/* If option separator ("--") is the last argument, remove it */
-=09if (ctx->nonopt && ctx->nonopt =3D=3D ctx->outargs.argc &&
-=09    strcmp(ctx->outargs.argv[ctx->outargs.argc - 1], "--") =3D=3D 0) {
-=09=09free(ctx->outargs.argv[ctx->outargs.argc - 1]);
-=09=09ctx->outargs.argv[--ctx->outargs.argc] =3D NULL;
-=09}
-
-=09return 0;
+    if (ctx->argc) {
+        if (add_arg(ctx, ctx->argv[0]) =3D=3D -1) {
+            return -1;
+        }
+    }
+
+    for (ctx->argctr =3D 1; ctx->argctr < ctx->argc; ctx->argctr++) {
+        if (process_one(ctx, ctx->argv[ctx->argctr]) =3D=3D -1) {
+            return -1;
+        }
+    }
+
+    if (ctx->opts) {
+        if (fuse_opt_insert_arg(&ctx->outargs, 1, "-o") =3D=3D -1 ||
+            fuse_opt_insert_arg(&ctx->outargs, 2, ctx->opts) =3D=3D -1) {
+            return -1;
+        }
+    }
+
+    /* If option separator ("--") is the last argument, remove it */
+    if (ctx->nonopt && ctx->nonopt =3D=3D ctx->outargs.argc &&
+        strcmp(ctx->outargs.argv[ctx->outargs.argc - 1], "--") =3D=3D 0) {
+        free(ctx->outargs.argv[ctx->outargs.argc - 1]);
+        ctx->outargs.argv[--ctx->outargs.argc] =3D NULL;
+    }
+
+    return 0;
 }
=20
 int fuse_opt_parse(struct fuse_args *args, void *data,
-=09=09   const struct fuse_opt opts[], fuse_opt_proc_t proc)
+                   const struct fuse_opt opts[], fuse_opt_proc_t proc)
 {
-=09int res;
-=09struct fuse_opt_context ctx =3D {
-=09=09.data =3D data,
-=09=09.opt =3D opts,
-=09=09.proc =3D proc,
-=09};
-
-=09if (!args || !args->argv || !args->argc)
-=09=09return 0;
-
-=09ctx.argc =3D args->argc;
-=09ctx.argv =3D args->argv;
-
-=09res =3D opt_parse(&ctx);
-=09if (res !=3D -1) {
-=09=09struct fuse_args tmp =3D *args;
-=09=09*args =3D ctx.outargs;
-=09=09ctx.outargs =3D tmp;
-=09}
-=09free(ctx.opts);
-=09fuse_opt_free_args(&ctx.outargs);
-=09return res;
+    int res;
+    struct fuse_opt_context ctx =3D {
+        .data =3D data,
+        .opt =3D opts,
+        .proc =3D proc,
+    };
+
+    if (!args || !args->argv || !args->argc) {
+        return 0;
+    }
+
+    ctx.argc =3D args->argc;
+    ctx.argv =3D args->argv;
+
+    res =3D opt_parse(&ctx);
+    if (res !=3D -1) {
+        struct fuse_args tmp =3D *args;
+        *args =3D ctx.outargs;
+        ctx.outargs =3D tmp;
+    }
+    free(ctx.opts);
+    fuse_opt_free_args(&ctx.outargs);
+    return res;
 }
diff --git a/tools/virtiofsd/fuse_opt.h b/tools/virtiofsd/fuse_opt.h
index 69102555be..8f59b4d301 100644
--- a/tools/virtiofsd/fuse_opt.h
+++ b/tools/virtiofsd/fuse_opt.h
@@ -1,10 +1,10 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #ifndef FUSE_OPT_H_
 #define FUSE_OPT_H_
@@ -37,7 +37,7 @@
  *
  *  - 'offsetof(struct foo, member)'  actions i) and iii)
  *
- *  - -1=09=09=09      action ii)
+ *  - -1                              action ii)
  *
  * The 'offsetof()' macro is defined in the <stddef.h> header.
  *
@@ -48,7 +48,7 @@
  *
  * The types of templates are:
  *
- * 1) "-x", "-foo", "--foo", "--foo-bar", etc.=09These match only
+ * 1) "-x", "-foo", "--foo", "--foo-bar", etc. These match only
  *   themselves.  Invalid values are "--" and anything beginning
  *   with "-o"
  *
@@ -71,58 +71,67 @@
  * freed.
  */
 struct fuse_opt {
-=09/** Matching template and optional parameter formatting */
-=09const char *templ;
+    /** Matching template and optional parameter formatting */
+    const char *templ;
=20
-=09/**
-=09 * Offset of variable within 'data' parameter of fuse_opt_parse()
-=09 * or -1
-=09 */
-=09unsigned long offset;
+    /**
+     * Offset of variable within 'data' parameter of fuse_opt_parse()
+     * or -1
+     */
+    unsigned long offset;
=20
-=09/**
-=09 * Value to set the variable to, or to be passed as 'key' to the
-=09 * processing function.=09 Ignored if template has a format
-=09 */
-=09int value;
+    /**
+     * Value to set the variable to, or to be passed as 'key' to the
+     * processing function. Ignored if template has a format
+     */
+    int value;
 };
=20
 /**
- * Key option.=09In case of a match, the processing function will be
+ * Key option. In case of a match, the processing function will be
  * called with the specified key.
  */
-#define FUSE_OPT_KEY(templ, key) { templ, -1U, key }
+#define FUSE_OPT_KEY(templ, key) \
+    {                            \
+        templ, -1U, key          \
+    }
=20
 /**
- * Last option.=09 An array of 'struct fuse_opt' must end with a NULL
+ * Last option. An array of 'struct fuse_opt' must end with a NULL
  * template value
  */
-#define FUSE_OPT_END { NULL, 0, 0 }
+#define FUSE_OPT_END \
+    {                \
+        NULL, 0, 0   \
+    }
=20
 /**
  * Argument list
  */
 struct fuse_args {
-=09/** Argument count */
-=09int argc;
+    /** Argument count */
+    int argc;
=20
-=09/** Argument vector.  NULL terminated */
-=09char **argv;
+    /** Argument vector.  NULL terminated */
+    char **argv;
=20
-=09/** Is 'argv' allocated? */
-=09int allocated;
+    /** Is 'argv' allocated? */
+    int allocated;
 };
=20
 /**
  * Initializer for 'struct fuse_args'
  */
-#define FUSE_ARGS_INIT(argc, argv) { argc, argv, 0 }
+#define FUSE_ARGS_INIT(argc, argv) \
+    {                              \
+        argc, argv, 0              \
+    }
=20
 /**
  * Key value passed to the processing function if an option did not
  * match any template
  */
-#define FUSE_OPT_KEY_OPT     -1
+#define FUSE_OPT_KEY_OPT -1
=20
 /**
  * Key value passed to the processing function for all non-options
@@ -130,7 +139,7 @@ struct fuse_args {
  * Non-options are the arguments beginning with a character other than
  * '-' or all arguments after the special '--' option
  */
-#define FUSE_OPT_KEY_NONOPT  -2
+#define FUSE_OPT_KEY_NONOPT -2
=20
 /**
  * Special key value for options to keep
@@ -174,7 +183,7 @@ struct fuse_args {
  * @return -1 on error, 0 if arg is to be discarded, 1 if arg should be ke=
pt
  */
 typedef int (*fuse_opt_proc_t)(void *data, const char *arg, int key,
-=09=09=09       struct fuse_args *outargs);
+                               struct fuse_args *outargs);
=20
 /**
  * Option parsing function
@@ -197,7 +206,7 @@ typedef int (*fuse_opt_proc_t)(void *data, const char *=
arg, int key,
  * @return -1 on error, 0 on success
  */
 int fuse_opt_parse(struct fuse_args *args, void *data,
-=09=09   const struct fuse_opt opts[], fuse_opt_proc_t proc);
+                   const struct fuse_opt opts[], fuse_opt_proc_t proc);
=20
 /**
  * Add an option to a comma separated option list
diff --git a/tools/virtiofsd/fuse_signals.c b/tools/virtiofsd/fuse_signals.=
c
index 4271947bd4..19d6791cb9 100644
--- a/tools/virtiofsd/fuse_signals.c
+++ b/tools/virtiofsd/fuse_signals.c
@@ -1,91 +1,95 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  Utility functions for setting signal handlers.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Utility functions for setting signal handlers.
+ *
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB
+ */
=20
 #include "config.h"
-#include "fuse_lowlevel.h"
 #include "fuse_i.h"
+#include "fuse_lowlevel.h"
=20
-#include <stdio.h>
-#include <string.h>
 #include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
=20
 static struct fuse_session *fuse_instance;
=20
 static void exit_handler(int sig)
 {
-=09if (fuse_instance) {
-=09=09fuse_session_exit(fuse_instance);
-=09=09if(sig <=3D 0) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "assertion error: signal value <=3D 0\n");
-=09=09=09abort();
-=09=09}
-=09=09fuse_instance->error =3D sig;
-=09}
+    if (fuse_instance) {
+        fuse_session_exit(fuse_instance);
+        if (sig <=3D 0) {
+            fuse_log(FUSE_LOG_ERR, "assertion error: signal value <=3D 0\n=
");
+            abort();
+        }
+        fuse_instance->error =3D sig;
+    }
 }
=20
 static void do_nothing(int sig)
 {
-=09(void) sig;
+    (void)sig;
 }
=20
 static int set_one_signal_handler(int sig, void (*handler)(int), int remov=
e)
 {
-=09struct sigaction sa;
-=09struct sigaction old_sa;
+    struct sigaction sa;
+    struct sigaction old_sa;
=20
-=09memset(&sa, 0, sizeof(struct sigaction));
-=09sa.sa_handler =3D remove ? SIG_DFL : handler;
-=09sigemptyset(&(sa.sa_mask));
-=09sa.sa_flags =3D 0;
+    memset(&sa, 0, sizeof(struct sigaction));
+    sa.sa_handler =3D remove ? SIG_DFL : handler;
+    sigemptyset(&(sa.sa_mask));
+    sa.sa_flags =3D 0;
=20
-=09if (sigaction(sig, NULL, &old_sa) =3D=3D -1) {
-=09=09perror("fuse: cannot get old signal handler");
-=09=09return -1;
-=09}
+    if (sigaction(sig, NULL, &old_sa) =3D=3D -1) {
+        perror("fuse: cannot get old signal handler");
+        return -1;
+    }
=20
-=09if (old_sa.sa_handler =3D=3D (remove ? handler : SIG_DFL) &&
-=09    sigaction(sig, &sa, NULL) =3D=3D -1) {
-=09=09perror("fuse: cannot set signal handler");
-=09=09return -1;
-=09}
-=09return 0;
+    if (old_sa.sa_handler =3D=3D (remove ? handler : SIG_DFL) &&
+        sigaction(sig, &sa, NULL) =3D=3D -1) {
+        perror("fuse: cannot set signal handler");
+        return -1;
+    }
+    return 0;
 }
=20
 int fuse_set_signal_handlers(struct fuse_session *se)
 {
-=09/* If we used SIG_IGN instead of the do_nothing function,
-=09   then we would be unable to tell if we set SIG_IGN (and
-=09   thus should reset to SIG_DFL in fuse_remove_signal_handlers)
-=09   or if it was already set to SIG_IGN (and should be left
-=09   untouched. */
-=09if (set_one_signal_handler(SIGHUP, exit_handler, 0) =3D=3D -1 ||
-=09    set_one_signal_handler(SIGINT, exit_handler, 0) =3D=3D -1 ||
-=09    set_one_signal_handler(SIGTERM, exit_handler, 0) =3D=3D -1 ||
-=09    set_one_signal_handler(SIGPIPE, do_nothing, 0) =3D=3D -1)
-=09=09return -1;
+    /*
+     * If we used SIG_IGN instead of the do_nothing function,
+     * then we would be unable to tell if we set SIG_IGN (and
+     * thus should reset to SIG_DFL in fuse_remove_signal_handlers)
+     * or if it was already set to SIG_IGN (and should be left
+     * untouched.
+     */
+    if (set_one_signal_handler(SIGHUP, exit_handler, 0) =3D=3D -1 ||
+        set_one_signal_handler(SIGINT, exit_handler, 0) =3D=3D -1 ||
+        set_one_signal_handler(SIGTERM, exit_handler, 0) =3D=3D -1 ||
+        set_one_signal_handler(SIGPIPE, do_nothing, 0) =3D=3D -1) {
+        return -1;
+    }
=20
-=09fuse_instance =3D se;
-=09return 0;
+    fuse_instance =3D se;
+    return 0;
 }
=20
 void fuse_remove_signal_handlers(struct fuse_session *se)
 {
-=09if (fuse_instance !=3D se)
-=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09"fuse: fuse_remove_signal_handlers: unknown session\n");
-=09else
-=09=09fuse_instance =3D NULL;
+    if (fuse_instance !=3D se) {
+        fuse_log(FUSE_LOG_ERR,
+                 "fuse: fuse_remove_signal_handlers: unknown session\n");
+    } else {
+        fuse_instance =3D NULL;
+    }
=20
-=09set_one_signal_handler(SIGHUP, exit_handler, 1);
-=09set_one_signal_handler(SIGINT, exit_handler, 1);
-=09set_one_signal_handler(SIGTERM, exit_handler, 1);
-=09set_one_signal_handler(SIGPIPE, do_nothing, 1);
+    set_one_signal_handler(SIGHUP, exit_handler, 1);
+    set_one_signal_handler(SIGINT, exit_handler, 1);
+    set_one_signal_handler(SIGTERM, exit_handler, 1);
+    set_one_signal_handler(SIGPIPE, do_nothing, 1);
 }
diff --git a/tools/virtiofsd/helper.c b/tools/virtiofsd/helper.c
index 511f981ce6..e077943558 100644
--- a/tools/virtiofsd/helper.c
+++ b/tools/virtiofsd/helper.c
@@ -1,302 +1,315 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * Helper functions to create (simple) standalone programs. With the
+ * aid of these functions it should be possible to create full FUSE
+ * file system by implementing nothing but the request handlers.
=20
-  Helper functions to create (simple) standalone programs. With the
-  aid of these functions it should be possible to create full FUSE
-  file system by implementing nothing but the request handlers.
-
-  This program can be distributed under the terms of the GNU LGPLv2.
-  See the file COPYING.LIB.
-*/
+ * This program can be distributed under the terms of the GNU LGPLv2.
+ * See the file COPYING.LIB.
+ */
=20
 #include "config.h"
 #include "fuse_i.h"
+#include "fuse_lowlevel.h"
 #include "fuse_misc.h"
 #include "fuse_opt.h"
-#include "fuse_lowlevel.h"
 #include "mount_util.h"
=20
+#include <errno.h>
+#include <limits.h>
+#include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stddef.h>
-#include <unistd.h>
 #include <string.h>
-#include <limits.h>
-#include <errno.h>
 #include <sys/param.h>
+#include <unistd.h>
=20
-#define FUSE_HELPER_OPT(t, p) \
-=09{ t, offsetof(struct fuse_cmdline_opts, p), 1 }
+#define FUSE_HELPER_OPT(t, p)                       \
+    {                                               \
+        t, offsetof(struct fuse_cmdline_opts, p), 1 \
+    }
=20
 static const struct fuse_opt fuse_helper_opts[] =3D {
-=09FUSE_HELPER_OPT("-h",=09=09show_help),
-=09FUSE_HELPER_OPT("--help",=09show_help),
-=09FUSE_HELPER_OPT("-V",=09=09show_version),
-=09FUSE_HELPER_OPT("--version",=09show_version),
-=09FUSE_HELPER_OPT("-d",=09=09debug),
-=09FUSE_HELPER_OPT("debug",=09debug),
-=09FUSE_HELPER_OPT("-d",=09=09foreground),
-=09FUSE_HELPER_OPT("debug",=09foreground),
-=09FUSE_OPT_KEY("-d",=09=09FUSE_OPT_KEY_KEEP),
-=09FUSE_OPT_KEY("debug",=09=09FUSE_OPT_KEY_KEEP),
-=09FUSE_HELPER_OPT("-f",=09=09foreground),
-=09FUSE_HELPER_OPT("-s",=09=09singlethread),
-=09FUSE_HELPER_OPT("fsname=3D",=09nodefault_subtype),
-=09FUSE_OPT_KEY("fsname=3D",=09=09FUSE_OPT_KEY_KEEP),
-=09FUSE_HELPER_OPT("subtype=3D",=09nodefault_subtype),
-=09FUSE_OPT_KEY("subtype=3D",=09FUSE_OPT_KEY_KEEP),
-=09FUSE_HELPER_OPT("clone_fd",=09clone_fd),
-=09FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
-=09FUSE_OPT_END
+    FUSE_HELPER_OPT("-h", show_help),
+    FUSE_HELPER_OPT("--help", show_help),
+    FUSE_HELPER_OPT("-V", show_version),
+    FUSE_HELPER_OPT("--version", show_version),
+    FUSE_HELPER_OPT("-d", debug),
+    FUSE_HELPER_OPT("debug", debug),
+    FUSE_HELPER_OPT("-d", foreground),
+    FUSE_HELPER_OPT("debug", foreground),
+    FUSE_OPT_KEY("-d", FUSE_OPT_KEY_KEEP),
+    FUSE_OPT_KEY("debug", FUSE_OPT_KEY_KEEP),
+    FUSE_HELPER_OPT("-f", foreground),
+    FUSE_HELPER_OPT("-s", singlethread),
+    FUSE_HELPER_OPT("fsname=3D", nodefault_subtype),
+    FUSE_OPT_KEY("fsname=3D", FUSE_OPT_KEY_KEEP),
+    FUSE_HELPER_OPT("subtype=3D", nodefault_subtype),
+    FUSE_OPT_KEY("subtype=3D", FUSE_OPT_KEY_KEEP),
+    FUSE_HELPER_OPT("clone_fd", clone_fd),
+    FUSE_HELPER_OPT("max_idle_threads=3D%u", max_idle_threads),
+    FUSE_OPT_END
 };
=20
 struct fuse_conn_info_opts {
-=09int atomic_o_trunc;
-=09int no_remote_posix_lock;
-=09int no_remote_flock;
-=09int splice_write;
-=09int splice_move;
-=09int splice_read;
-=09int no_splice_write;
-=09int no_splice_move;
-=09int no_splice_read;
-=09int auto_inval_data;
-=09int no_auto_inval_data;
-=09int no_readdirplus;
-=09int no_readdirplus_auto;
-=09int async_dio;
-=09int no_async_dio;
-=09int writeback_cache;
-=09int no_writeback_cache;
-=09int async_read;
-=09int sync_read;
-=09unsigned max_write;
-=09unsigned max_readahead;
-=09unsigned max_background;
-=09unsigned congestion_threshold;
-=09unsigned time_gran;
-=09int set_max_write;
-=09int set_max_readahead;
-=09int set_max_background;
-=09int set_congestion_threshold;
-=09int set_time_gran;
+    int atomic_o_trunc;
+    int no_remote_posix_lock;
+    int no_remote_flock;
+    int splice_write;
+    int splice_move;
+    int splice_read;
+    int no_splice_write;
+    int no_splice_move;
+    int no_splice_read;
+    int auto_inval_data;
+    int no_auto_inval_data;
+    int no_readdirplus;
+    int no_readdirplus_auto;
+    int async_dio;
+    int no_async_dio;
+    int writeback_cache;
+    int no_writeback_cache;
+    int async_read;
+    int sync_read;
+    unsigned max_write;
+    unsigned max_readahead;
+    unsigned max_background;
+    unsigned congestion_threshold;
+    unsigned time_gran;
+    int set_max_write;
+    int set_max_readahead;
+    int set_max_background;
+    int set_congestion_threshold;
+    int set_time_gran;
 };
=20
-#define CONN_OPTION(t, p, v)=09=09=09=09=09\
-=09{ t, offsetof(struct fuse_conn_info_opts, p), v }
+#define CONN_OPTION(t, p, v)                          \
+    {                                                 \
+        t, offsetof(struct fuse_conn_info_opts, p), v \
+    }
 static const struct fuse_opt conn_info_opt_spec[] =3D {
-=09CONN_OPTION("max_write=3D%u", max_write, 0),
-=09CONN_OPTION("max_write=3D", set_max_write, 1),
-=09CONN_OPTION("max_readahead=3D%u", max_readahead, 0),
-=09CONN_OPTION("max_readahead=3D", set_max_readahead, 1),
-=09CONN_OPTION("max_background=3D%u", max_background, 0),
-=09CONN_OPTION("max_background=3D", set_max_background, 1),
-=09CONN_OPTION("congestion_threshold=3D%u", congestion_threshold, 0),
-=09CONN_OPTION("congestion_threshold=3D", set_congestion_threshold, 1),
-=09CONN_OPTION("sync_read", sync_read, 1),
-=09CONN_OPTION("async_read", async_read, 1),
-=09CONN_OPTION("atomic_o_trunc", atomic_o_trunc, 1),
-=09CONN_OPTION("no_remote_lock", no_remote_posix_lock, 1),
-=09CONN_OPTION("no_remote_lock", no_remote_flock, 1),
-=09CONN_OPTION("no_remote_flock", no_remote_flock, 1),
-=09CONN_OPTION("no_remote_posix_lock", no_remote_posix_lock, 1),
-=09CONN_OPTION("splice_write", splice_write, 1),
-=09CONN_OPTION("no_splice_write", no_splice_write, 1),
-=09CONN_OPTION("splice_move", splice_move, 1),
-=09CONN_OPTION("no_splice_move", no_splice_move, 1),
-=09CONN_OPTION("splice_read", splice_read, 1),
-=09CONN_OPTION("no_splice_read", no_splice_read, 1),
-=09CONN_OPTION("auto_inval_data", auto_inval_data, 1),
-=09CONN_OPTION("no_auto_inval_data", no_auto_inval_data, 1),
-=09CONN_OPTION("readdirplus=3Dno", no_readdirplus, 1),
-=09CONN_OPTION("readdirplus=3Dyes", no_readdirplus, 0),
-=09CONN_OPTION("readdirplus=3Dyes", no_readdirplus_auto, 1),
-=09CONN_OPTION("readdirplus=3Dauto", no_readdirplus, 0),
-=09CONN_OPTION("readdirplus=3Dauto", no_readdirplus_auto, 0),
-=09CONN_OPTION("async_dio", async_dio, 1),
-=09CONN_OPTION("no_async_dio", no_async_dio, 1),
-=09CONN_OPTION("writeback_cache", writeback_cache, 1),
-=09CONN_OPTION("no_writeback_cache", no_writeback_cache, 1),
-=09CONN_OPTION("time_gran=3D%u", time_gran, 0),
-=09CONN_OPTION("time_gran=3D", set_time_gran, 1),
-=09FUSE_OPT_END
+    CONN_OPTION("max_write=3D%u", max_write, 0),
+    CONN_OPTION("max_write=3D", set_max_write, 1),
+    CONN_OPTION("max_readahead=3D%u", max_readahead, 0),
+    CONN_OPTION("max_readahead=3D", set_max_readahead, 1),
+    CONN_OPTION("max_background=3D%u", max_background, 0),
+    CONN_OPTION("max_background=3D", set_max_background, 1),
+    CONN_OPTION("congestion_threshold=3D%u", congestion_threshold, 0),
+    CONN_OPTION("congestion_threshold=3D", set_congestion_threshold, 1),
+    CONN_OPTION("sync_read", sync_read, 1),
+    CONN_OPTION("async_read", async_read, 1),
+    CONN_OPTION("atomic_o_trunc", atomic_o_trunc, 1),
+    CONN_OPTION("no_remote_lock", no_remote_posix_lock, 1),
+    CONN_OPTION("no_remote_lock", no_remote_flock, 1),
+    CONN_OPTION("no_remote_flock", no_remote_flock, 1),
+    CONN_OPTION("no_remote_posix_lock", no_remote_posix_lock, 1),
+    CONN_OPTION("splice_write", splice_write, 1),
+    CONN_OPTION("no_splice_write", no_splice_write, 1),
+    CONN_OPTION("splice_move", splice_move, 1),
+    CONN_OPTION("no_splice_move", no_splice_move, 1),
+    CONN_OPTION("splice_read", splice_read, 1),
+    CONN_OPTION("no_splice_read", no_splice_read, 1),
+    CONN_OPTION("auto_inval_data", auto_inval_data, 1),
+    CONN_OPTION("no_auto_inval_data", no_auto_inval_data, 1),
+    CONN_OPTION("readdirplus=3Dno", no_readdirplus, 1),
+    CONN_OPTION("readdirplus=3Dyes", no_readdirplus, 0),
+    CONN_OPTION("readdirplus=3Dyes", no_readdirplus_auto, 1),
+    CONN_OPTION("readdirplus=3Dauto", no_readdirplus, 0),
+    CONN_OPTION("readdirplus=3Dauto", no_readdirplus_auto, 0),
+    CONN_OPTION("async_dio", async_dio, 1),
+    CONN_OPTION("no_async_dio", no_async_dio, 1),
+    CONN_OPTION("writeback_cache", writeback_cache, 1),
+    CONN_OPTION("no_writeback_cache", no_writeback_cache, 1),
+    CONN_OPTION("time_gran=3D%u", time_gran, 0),
+    CONN_OPTION("time_gran=3D", set_time_gran, 1),
+    FUSE_OPT_END
 };
=20
=20
 void fuse_cmdline_help(void)
 {
-=09printf("    -h   --help            print help\n"
-=09       "    -V   --version         print version\n"
-=09       "    -d   -o debug          enable debug output (implies -f)\n"
-=09       "    -f                     foreground operation\n"
-=09       "    -s                     disable multi-threaded operation\n"
-=09       "    -o clone_fd            use separate fuse device fd for each=
 thread\n"
-=09       "                           (may improve performance)\n"
-=09       "    -o max_idle_threads    the maximum number of idle worker th=
reads\n"
-=09       "                           allowed (default: 10)\n");
+    printf(
+        "    -h   --help            print help\n"
+        "    -V   --version         print version\n"
+        "    -d   -o debug          enable debug output (implies -f)\n"
+        "    -f                     foreground operation\n"
+        "    -s                     disable multi-threaded operation\n"
+        "    -o clone_fd            use separate fuse device fd for each "
+        "thread\n"
+        "                           (may improve performance)\n"
+        "    -o max_idle_threads    the maximum number of idle worker thre=
ads\n"
+        "                           allowed (default: 10)\n");
 }
=20
 static int fuse_helper_opt_proc(void *data, const char *arg, int key,
-=09=09=09=09struct fuse_args *outargs)
+                                struct fuse_args *outargs)
 {
-=09(void) outargs;
-=09struct fuse_cmdline_opts *opts =3D data;
-
-=09switch (key) {
-=09case FUSE_OPT_KEY_NONOPT:
-=09=09if (!opts->mountpoint) {
-=09=09=09if (fuse_mnt_parse_fuse_fd(arg) !=3D -1) {
-=09=09=09=09return fuse_opt_add_opt(&opts->mountpoint, arg);
-=09=09=09}
-
-=09=09=09char mountpoint[PATH_MAX] =3D "";
-=09=09=09if (realpath(arg, mountpoint) =3D=3D NULL) {
-=09=09=09=09fuse_log(FUSE_LOG_ERR,
-=09=09=09=09=09"fuse: bad mount point `%s': %s\n",
-=09=09=09=09=09arg, strerror(errno));
-=09=09=09=09return -1;
-=09=09=09}
-=09=09=09return fuse_opt_add_opt(&opts->mountpoint, mountpoint);
-=09=09} else {
-=09=09=09fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
-=09=09=09return -1;
-=09=09}
-
-=09default:
-=09=09/* Pass through unknown options */
-=09=09return 1;
-=09}
+    (void)outargs;
+    struct fuse_cmdline_opts *opts =3D data;
+
+    switch (key) {
+    case FUSE_OPT_KEY_NONOPT:
+        if (!opts->mountpoint) {
+            if (fuse_mnt_parse_fuse_fd(arg) !=3D -1) {
+                return fuse_opt_add_opt(&opts->mountpoint, arg);
+            }
+
+            char mountpoint[PATH_MAX] =3D "";
+            if (realpath(arg, mountpoint) =3D=3D NULL) {
+                fuse_log(FUSE_LOG_ERR, "fuse: bad mount point `%s': %s\n",=
 arg,
+                         strerror(errno));
+                return -1;
+            }
+            return fuse_opt_add_opt(&opts->mountpoint, mountpoint);
+        } else {
+            fuse_log(FUSE_LOG_ERR, "fuse: invalid argument `%s'\n", arg);
+            return -1;
+        }
+
+    default:
+        /* Pass through unknown options */
+        return 1;
+    }
 }
=20
-int fuse_parse_cmdline(struct fuse_args *args,
-=09=09       struct fuse_cmdline_opts *opts)
+int fuse_parse_cmdline(struct fuse_args *args, struct fuse_cmdline_opts *o=
pts)
 {
-=09memset(opts, 0, sizeof(struct fuse_cmdline_opts));
+    memset(opts, 0, sizeof(struct fuse_cmdline_opts));
=20
-=09opts->max_idle_threads =3D 10;
+    opts->max_idle_threads =3D 10;
=20
-=09if (fuse_opt_parse(args, opts, fuse_helper_opts,
-=09=09=09   fuse_helper_opt_proc) =3D=3D -1)
-=09=09return -1;
+    if (fuse_opt_parse(args, opts, fuse_helper_opts, fuse_helper_opt_proc)=
 =3D=3D
+        -1) {
+        return -1;
+    }
=20
-=09return 0;
+    return 0;
 }
=20
=20
 int fuse_daemonize(int foreground)
 {
-=09if (!foreground) {
-=09=09int nullfd;
-=09=09int waiter[2];
-=09=09char completed;
-
-=09=09if (pipe(waiter)) {
-=09=09=09perror("fuse_daemonize: pipe");
-=09=09=09return -1;
-=09=09}
-
-=09=09/*
-=09=09 * demonize current process by forking it and killing the
-=09=09 * parent.  This makes current process as a child of 'init'.
-=09=09 */
-=09=09switch(fork()) {
-=09=09case -1:
-=09=09=09perror("fuse_daemonize: fork");
-=09=09=09return -1;
-=09=09case 0:
-=09=09=09break;
-=09=09default:
-=09=09=09(void) read(waiter[0], &completed, sizeof(completed));
-=09=09=09_exit(0);
-=09=09}
-
-=09=09if (setsid() =3D=3D -1) {
-=09=09=09perror("fuse_daemonize: setsid");
-=09=09=09return -1;
-=09=09}
-
-=09=09(void) chdir("/");
-
-=09=09nullfd =3D open("/dev/null", O_RDWR, 0);
-=09=09if (nullfd !=3D -1) {
-=09=09=09(void) dup2(nullfd, 0);
-=09=09=09(void) dup2(nullfd, 1);
-=09=09=09(void) dup2(nullfd, 2);
-=09=09=09if (nullfd > 2)
-=09=09=09=09close(nullfd);
-=09=09}
-
-=09=09/* Propagate completion of daemon initialization */
-=09=09completed =3D 1;
-=09=09(void) write(waiter[1], &completed, sizeof(completed));
-=09=09close(waiter[0]);
-=09=09close(waiter[1]);
-=09} else {
-=09=09(void) chdir("/");
-=09}
-=09return 0;
+    if (!foreground) {
+        int nullfd;
+        int waiter[2];
+        char completed;
+
+        if (pipe(waiter)) {
+            perror("fuse_daemonize: pipe");
+            return -1;
+        }
+
+        /*
+         * demonize current process by forking it and killing the
+         * parent.  This makes current process as a child of 'init'.
+         */
+        switch (fork()) {
+        case -1:
+            perror("fuse_daemonize: fork");
+            return -1;
+        case 0:
+            break;
+        default:
+            (void)read(waiter[0], &completed, sizeof(completed));
+            _exit(0);
+        }
+
+        if (setsid() =3D=3D -1) {
+            perror("fuse_daemonize: setsid");
+            return -1;
+        }
+
+        (void)chdir("/");
+
+        nullfd =3D open("/dev/null", O_RDWR, 0);
+        if (nullfd !=3D -1) {
+            (void)dup2(nullfd, 0);
+            (void)dup2(nullfd, 1);
+            (void)dup2(nullfd, 2);
+            if (nullfd > 2) {
+                close(nullfd);
+            }
+        }
+
+        /* Propagate completion of daemon initialization */
+        completed =3D 1;
+        (void)write(waiter[1], &completed, sizeof(completed));
+        close(waiter[0]);
+        close(waiter[1]);
+    } else {
+        (void)chdir("/");
+    }
+    return 0;
 }
=20
 void fuse_apply_conn_info_opts(struct fuse_conn_info_opts *opts,
-=09=09=09       struct fuse_conn_info *conn)
+                               struct fuse_conn_info *conn)
 {
-=09if(opts->set_max_write)
-=09=09conn->max_write =3D opts->max_write;
-=09if(opts->set_max_background)
-=09=09conn->max_background =3D opts->max_background;
-=09if(opts->set_congestion_threshold)
-=09=09conn->congestion_threshold =3D opts->congestion_threshold;
-=09if(opts->set_time_gran)
-=09=09conn->time_gran =3D opts->time_gran;
-=09if(opts->set_max_readahead)
-=09=09conn->max_readahead =3D opts->max_readahead;
-
-#define LL_ENABLE(cond,cap) \
-=09if (cond) conn->want |=3D (cap)
-#define LL_DISABLE(cond,cap) \
-=09if (cond) conn->want &=3D ~(cap)
-
-=09LL_ENABLE(opts->splice_read, FUSE_CAP_SPLICE_READ);
-=09LL_DISABLE(opts->no_splice_read, FUSE_CAP_SPLICE_READ);
-
-=09LL_ENABLE(opts->splice_write, FUSE_CAP_SPLICE_WRITE);
-=09LL_DISABLE(opts->no_splice_write, FUSE_CAP_SPLICE_WRITE);
-
-=09LL_ENABLE(opts->splice_move, FUSE_CAP_SPLICE_MOVE);
-=09LL_DISABLE(opts->no_splice_move, FUSE_CAP_SPLICE_MOVE);
-
-=09LL_ENABLE(opts->auto_inval_data, FUSE_CAP_AUTO_INVAL_DATA);
-=09LL_DISABLE(opts->no_auto_inval_data, FUSE_CAP_AUTO_INVAL_DATA);
-
-=09LL_DISABLE(opts->no_readdirplus, FUSE_CAP_READDIRPLUS);
-=09LL_DISABLE(opts->no_readdirplus_auto, FUSE_CAP_READDIRPLUS_AUTO);
-
-=09LL_ENABLE(opts->async_dio, FUSE_CAP_ASYNC_DIO);
-=09LL_DISABLE(opts->no_async_dio, FUSE_CAP_ASYNC_DIO);
-
-=09LL_ENABLE(opts->writeback_cache, FUSE_CAP_WRITEBACK_CACHE);
-=09LL_DISABLE(opts->no_writeback_cache, FUSE_CAP_WRITEBACK_CACHE);
-
-=09LL_ENABLE(opts->async_read, FUSE_CAP_ASYNC_READ);
-=09LL_DISABLE(opts->sync_read, FUSE_CAP_ASYNC_READ);
-
-=09LL_DISABLE(opts->no_remote_posix_lock, FUSE_CAP_POSIX_LOCKS);
-=09LL_DISABLE(opts->no_remote_flock, FUSE_CAP_FLOCK_LOCKS);
+    if (opts->set_max_write) {
+        conn->max_write =3D opts->max_write;
+    }
+    if (opts->set_max_background) {
+        conn->max_background =3D opts->max_background;
+    }
+    if (opts->set_congestion_threshold) {
+        conn->congestion_threshold =3D opts->congestion_threshold;
+    }
+    if (opts->set_time_gran) {
+        conn->time_gran =3D opts->time_gran;
+    }
+    if (opts->set_max_readahead) {
+        conn->max_readahead =3D opts->max_readahead;
+    }
+
+#define LL_ENABLE(cond, cap) \
+    if (cond)                \
+        conn->want |=3D (cap)
+#define LL_DISABLE(cond, cap) \
+    if (cond)                 \
+        conn->want &=3D ~(cap)
+
+    LL_ENABLE(opts->splice_read, FUSE_CAP_SPLICE_READ);
+    LL_DISABLE(opts->no_splice_read, FUSE_CAP_SPLICE_READ);
+
+    LL_ENABLE(opts->splice_write, FUSE_CAP_SPLICE_WRITE);
+    LL_DISABLE(opts->no_splice_write, FUSE_CAP_SPLICE_WRITE);
+
+    LL_ENABLE(opts->splice_move, FUSE_CAP_SPLICE_MOVE);
+    LL_DISABLE(opts->no_splice_move, FUSE_CAP_SPLICE_MOVE);
+
+    LL_ENABLE(opts->auto_inval_data, FUSE_CAP_AUTO_INVAL_DATA);
+    LL_DISABLE(opts->no_auto_inval_data, FUSE_CAP_AUTO_INVAL_DATA);
+
+    LL_DISABLE(opts->no_readdirplus, FUSE_CAP_READDIRPLUS);
+    LL_DISABLE(opts->no_readdirplus_auto, FUSE_CAP_READDIRPLUS_AUTO);
+
+    LL_ENABLE(opts->async_dio, FUSE_CAP_ASYNC_DIO);
+    LL_DISABLE(opts->no_async_dio, FUSE_CAP_ASYNC_DIO);
+
+    LL_ENABLE(opts->writeback_cache, FUSE_CAP_WRITEBACK_CACHE);
+    LL_DISABLE(opts->no_writeback_cache, FUSE_CAP_WRITEBACK_CACHE);
+
+    LL_ENABLE(opts->async_read, FUSE_CAP_ASYNC_READ);
+    LL_DISABLE(opts->sync_read, FUSE_CAP_ASYNC_READ);
+
+    LL_DISABLE(opts->no_remote_posix_lock, FUSE_CAP_POSIX_LOCKS);
+    LL_DISABLE(opts->no_remote_flock, FUSE_CAP_FLOCK_LOCKS);
 }
=20
-struct fuse_conn_info_opts* fuse_parse_conn_info_opts(struct fuse_args *ar=
gs)
+struct fuse_conn_info_opts *fuse_parse_conn_info_opts(struct fuse_args *ar=
gs)
 {
-=09struct fuse_conn_info_opts *opts;
-
-=09opts =3D calloc(1, sizeof(struct fuse_conn_info_opts));
-=09if(opts =3D=3D NULL) {
-=09=09fuse_log(FUSE_LOG_ERR, "calloc failed\n");
-=09=09return NULL;
-=09}
-=09if(fuse_opt_parse(args, opts, conn_info_opt_spec, NULL) =3D=3D -1) {
-=09=09free(opts);
-=09=09return NULL;
-=09}
-=09return opts;
+    struct fuse_conn_info_opts *opts;
+
+    opts =3D calloc(1, sizeof(struct fuse_conn_info_opts));
+    if (opts =3D=3D NULL) {
+        fuse_log(FUSE_LOG_ERR, "calloc failed\n");
+        return NULL;
+    }
+    if (fuse_opt_parse(args, opts, conn_info_opt_spec, NULL) =3D=3D -1) {
+        free(opts);
+        return NULL;
+    }
+    return opts;
 }
diff --git a/tools/virtiofsd/passthrough_helpers.h b/tools/virtiofsd/passth=
rough_helpers.h
index 7c5f561fbc..0b98275ed5 100644
--- a/tools/virtiofsd/passthrough_helpers.h
+++ b/tools/virtiofsd/passthrough_helpers.h
@@ -28,23 +28,24 @@
  * operation
  */
 static int mknod_wrapper(int dirfd, const char *path, const char *link,
-=09int mode, dev_t rdev)
+                         int mode, dev_t rdev)
 {
-=09int res;
+    int res;
=20
-=09if (S_ISREG(mode)) {
-=09=09res =3D openat(dirfd, path, O_CREAT | O_EXCL | O_WRONLY, mode);
-=09=09if (res >=3D 0)
-=09=09=09res =3D close(res);
-=09} else if (S_ISDIR(mode)) {
-=09=09res =3D mkdirat(dirfd, path, mode);
-=09} else if (S_ISLNK(mode) && link !=3D NULL) {
-=09=09res =3D symlinkat(link, dirfd, path);
-=09} else if (S_ISFIFO(mode)) {
-=09=09res =3D mkfifoat(dirfd, path, mode);
-=09} else {
-=09=09res =3D mknodat(dirfd, path, mode, rdev);
-=09}
+    if (S_ISREG(mode)) {
+        res =3D openat(dirfd, path, O_CREAT | O_EXCL | O_WRONLY, mode);
+        if (res >=3D 0) {
+            res =3D close(res);
+        }
+    } else if (S_ISDIR(mode)) {
+        res =3D mkdirat(dirfd, path, mode);
+    } else if (S_ISLNK(mode) && link !=3D NULL) {
+        res =3D symlinkat(link, dirfd, path);
+    } else if (S_ISFIFO(mode)) {
+        res =3D mkfifoat(dirfd, path, mode);
+    } else {
+        res =3D mknodat(dirfd, path, mode, rdev);
+    }
=20
-=09return res;
+    return res;
 }
diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrough=
_ll.c
index 5372d02934..cd399d5c4b 100644
--- a/tools/virtiofsd/passthrough_ll.c
+++ b/tools/virtiofsd/passthrough_ll.c
@@ -1,12 +1,12 @@
 /*
-  FUSE: Filesystem in Userspace
-  Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
-
-  This program can be distributed under the terms of the GNU GPL.
-  See the file COPYING.
-*/
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2007  Miklos Szeredi <miklos@szeredi.hu>
+ *
+ * This program can be distributed under the terms of the GNU GPL.
+ * See the file COPYING.
+ */
=20
-/** @file
+/*
  *
  * This file system mirrors the existing file system hierarchy of the
  * system, starting at the root file system. This is implemented by
@@ -28,7 +28,8 @@
  *
  * Compile with:
  *
- *     gcc -Wall passthrough_ll.c `pkg-config fuse3 --cflags --libs` -o pa=
ssthrough_ll
+ *     gcc -Wall passthrough_ll.c `pkg-config fuse3 --cflags --libs` -o
+ * passthrough_ll
  *
  * ## Source code ##
  * \include passthrough_ll.c
@@ -39,1300 +40,1366 @@
=20
 #include "config.h"
=20
-#include <fuse_lowlevel.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <stddef.h>
-#include <stdbool.h>
-#include <string.h>
-#include <limits.h>
-#include <dirent.h>
 #include <assert.h>
+#include <dirent.h>
 #include <errno.h>
+#include <fuse_lowlevel.h>
 #include <inttypes.h>
+#include <limits.h>
 #include <pthread.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <sys/file.h>
 #include <sys/xattr.h>
+#include <unistd.h>
=20
 #include "passthrough_helpers.h"
=20
-/* We are re-using pointers to our `struct lo_inode` and `struct
-   lo_dirp` elements as inodes. This means that we must be able to
-   store uintptr_t values in a fuse_ino_t variable. The following
-   incantation checks this condition at compile time. */
-#if defined(__GNUC__) && (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINO=
R__ >=3D 6) && !defined __cplusplus
+/*
+ * We are re-using pointers to our `struct lo_inode` and `struct
+ * lo_dirp` elements as inodes. This means that we must be able to
+ * store uintptr_t values in a fuse_ino_t variable. The following
+ * incantation checks this condition at compile time.
+ */
+#if defined(__GNUC__) &&                                      \
+    (__GNUC__ > 4 || __GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=3D 6) && \
+    !defined __cplusplus
 _Static_assert(sizeof(fuse_ino_t) >=3D sizeof(uintptr_t),
-=09       "fuse_ino_t too small to hold uintptr_t values!");
+               "fuse_ino_t too small to hold uintptr_t values!");
 #else
-struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct \
-=09{ unsigned _uintptr_to_must_hold_fuse_ino_t:
-=09=09=09((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1); };
+struct _uintptr_to_must_hold_fuse_ino_t_dummy_struct {
+    unsigned _uintptr_to_must_hold_fuse_ino_t
+        : ((sizeof(fuse_ino_t) >=3D sizeof(uintptr_t)) ? 1 : -1);
+};
 #endif
=20
 struct lo_inode {
-=09struct lo_inode *next; /* protected by lo->mutex */
-=09struct lo_inode *prev; /* protected by lo->mutex */
-=09int fd;
-=09bool is_symlink;
-=09ino_t ino;
-=09dev_t dev;
-=09uint64_t refcount; /* protected by lo->mutex */
+    struct lo_inode *next; /* protected by lo->mutex */
+    struct lo_inode *prev; /* protected by lo->mutex */
+    int fd;
+    bool is_symlink;
+    ino_t ino;
+    dev_t dev;
+    uint64_t refcount; /* protected by lo->mutex */
 };
=20
 enum {
-=09CACHE_NEVER,
-=09CACHE_NORMAL,
-=09CACHE_ALWAYS,
+    CACHE_NEVER,
+    CACHE_NORMAL,
+    CACHE_ALWAYS,
 };
=20
 struct lo_data {
-=09pthread_mutex_t mutex;
-=09int debug;
-=09int writeback;
-=09int flock;
-=09int xattr;
-=09const char *source;
-=09double timeout;
-=09int cache;
-=09int timeout_set;
-=09struct lo_inode root; /* protected by lo->mutex */
+    pthread_mutex_t mutex;
+    int debug;
+    int writeback;
+    int flock;
+    int xattr;
+    const char *source;
+    double timeout;
+    int cache;
+    int timeout_set;
+    struct lo_inode root; /* protected by lo->mutex */
 };
=20
 static const struct fuse_opt lo_opts[] =3D {
-=09{ "writeback",
-=09  offsetof(struct lo_data, writeback), 1 },
-=09{ "no_writeback",
-=09  offsetof(struct lo_data, writeback), 0 },
-=09{ "source=3D%s",
-=09  offsetof(struct lo_data, source), 0 },
-=09{ "flock",
-=09  offsetof(struct lo_data, flock), 1 },
-=09{ "no_flock",
-=09  offsetof(struct lo_data, flock), 0 },
-=09{ "xattr",
-=09  offsetof(struct lo_data, xattr), 1 },
-=09{ "no_xattr",
-=09  offsetof(struct lo_data, xattr), 0 },
-=09{ "timeout=3D%lf",
-=09  offsetof(struct lo_data, timeout), 0 },
-=09{ "timeout=3D",
-=09  offsetof(struct lo_data, timeout_set), 1 },
-=09{ "cache=3Dnever",
-=09  offsetof(struct lo_data, cache), CACHE_NEVER },
-=09{ "cache=3Dauto",
-=09  offsetof(struct lo_data, cache), CACHE_NORMAL },
-=09{ "cache=3Dalways",
-=09  offsetof(struct lo_data, cache), CACHE_ALWAYS },
-
-=09FUSE_OPT_END
+    { "writeback", offsetof(struct lo_data, writeback), 1 },
+    { "no_writeback", offsetof(struct lo_data, writeback), 0 },
+    { "source=3D%s", offsetof(struct lo_data, source), 0 },
+    { "flock", offsetof(struct lo_data, flock), 1 },
+    { "no_flock", offsetof(struct lo_data, flock), 0 },
+    { "xattr", offsetof(struct lo_data, xattr), 1 },
+    { "no_xattr", offsetof(struct lo_data, xattr), 0 },
+    { "timeout=3D%lf", offsetof(struct lo_data, timeout), 0 },
+    { "timeout=3D", offsetof(struct lo_data, timeout_set), 1 },
+    { "cache=3Dnever", offsetof(struct lo_data, cache), CACHE_NEVER },
+    { "cache=3Dauto", offsetof(struct lo_data, cache), CACHE_NORMAL },
+    { "cache=3Dalways", offsetof(struct lo_data, cache), CACHE_ALWAYS },
+
+    FUSE_OPT_END
 };
=20
 static struct lo_data *lo_data(fuse_req_t req)
 {
-=09return (struct lo_data *) fuse_req_userdata(req);
+    return (struct lo_data *)fuse_req_userdata(req);
 }
=20
 static struct lo_inode *lo_inode(fuse_req_t req, fuse_ino_t ino)
 {
-=09if (ino =3D=3D FUSE_ROOT_ID)
-=09=09return &lo_data(req)->root;
-=09else
-=09=09return (struct lo_inode *) (uintptr_t) ino;
+    if (ino =3D=3D FUSE_ROOT_ID) {
+        return &lo_data(req)->root;
+    } else {
+        return (struct lo_inode *)(uintptr_t)ino;
+    }
 }
=20
 static int lo_fd(fuse_req_t req, fuse_ino_t ino)
 {
-=09return lo_inode(req, ino)->fd;
+    return lo_inode(req, ino)->fd;
 }
=20
 static bool lo_debug(fuse_req_t req)
 {
-=09return lo_data(req)->debug !=3D 0;
+    return lo_data(req)->debug !=3D 0;
 }
=20
-static void lo_init(void *userdata,
-=09=09    struct fuse_conn_info *conn)
+static void lo_init(void *userdata, struct fuse_conn_info *conn)
 {
-=09struct lo_data *lo =3D (struct lo_data*) userdata;
-
-=09if(conn->capable & FUSE_CAP_EXPORT_SUPPORT)
-=09=09conn->want |=3D FUSE_CAP_EXPORT_SUPPORT;
-
-=09if (lo->writeback &&
-=09    conn->capable & FUSE_CAP_WRITEBACK_CACHE) {
-=09=09if (lo->debug)
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
-=09=09conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
-=09}
-=09if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
-=09=09if (lo->debug)
-=09=09=09fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
-=09=09conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
-=09}
+    struct lo_data *lo =3D (struct lo_data *)userdata;
+
+    if (conn->capable & FUSE_CAP_EXPORT_SUPPORT) {
+        conn->want |=3D FUSE_CAP_EXPORT_SUPPORT;
+    }
+
+    if (lo->writeback && conn->capable & FUSE_CAP_WRITEBACK_CACHE) {
+        if (lo->debug) {
+            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating writeback\n");
+        }
+        conn->want |=3D FUSE_CAP_WRITEBACK_CACHE;
+    }
+    if (lo->flock && conn->capable & FUSE_CAP_FLOCK_LOCKS) {
+        if (lo->debug) {
+            fuse_log(FUSE_LOG_DEBUG, "lo_init: activating flock locks\n");
+        }
+        conn->want |=3D FUSE_CAP_FLOCK_LOCKS;
+    }
 }
=20
 static void lo_getattr(fuse_req_t req, fuse_ino_t ino,
-=09=09=09     struct fuse_file_info *fi)
+                       struct fuse_file_info *fi)
 {
-=09int res;
-=09struct stat buf;
-=09struct lo_data *lo =3D lo_data(req);
+    int res;
+    struct stat buf;
+    struct lo_data *lo =3D lo_data(req);
=20
-=09(void) fi;
+    (void)fi;
=20
-=09res =3D fstatat(lo_fd(req, ino), "", &buf, AT_EMPTY_PATH | AT_SYMLINK_N=
OFOLLOW);
-=09if (res =3D=3D -1)
-=09=09return (void) fuse_reply_err(req, errno);
+    res =3D
+        fstatat(lo_fd(req, ino), "", &buf, AT_EMPTY_PATH | AT_SYMLINK_NOFO=
LLOW);
+    if (res =3D=3D -1) {
+        return (void)fuse_reply_err(req, errno);
+    }
=20
-=09fuse_reply_attr(req, &buf, lo->timeout);
+    fuse_reply_attr(req, &buf, lo->timeout);
 }
=20
 static int utimensat_empty_nofollow(struct lo_inode *inode,
-=09=09=09=09    const struct timespec *tv)
+                                    const struct timespec *tv)
 {
-=09int res;
-=09char procname[64];
-
-=09if (inode->is_symlink) {
-=09=09res =3D utimensat(inode->fd, "", tv,
-=09=09=09=09AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
-=09=09if (res =3D=3D -1 && errno =3D=3D EINVAL) {
-=09=09=09/* Sorry, no race free way to set times on symlink. */
-=09=09=09errno =3D EPERM;
-=09=09}
-=09=09return res;
-=09}
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
-
-=09return utimensat(AT_FDCWD, procname, tv, 0);
+    int res;
+    char procname[64];
+
+    if (inode->is_symlink) {
+        res =3D utimensat(inode->fd, "", tv, AT_EMPTY_PATH | AT_SYMLINK_NO=
FOLLOW);
+        if (res =3D=3D -1 && errno =3D=3D EINVAL) {
+            /* Sorry, no race free way to set times on symlink. */
+            errno =3D EPERM;
+        }
+        return res;
+    }
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+    return utimensat(AT_FDCWD, procname, tv, 0);
 }
=20
 static void lo_setattr(fuse_req_t req, fuse_ino_t ino, struct stat *attr,
-=09=09       int valid, struct fuse_file_info *fi)
+                       int valid, struct fuse_file_info *fi)
 {
-=09int saverr;
-=09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09int ifd =3D inode->fd;
-=09int res;
-
-=09if (valid & FUSE_SET_ATTR_MODE) {
-=09=09if (fi) {
-=09=09=09res =3D fchmod(fi->fh, attr->st_mode);
-=09=09} else {
-=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
-=09=09=09res =3D chmod(procname, attr->st_mode);
-=09=09}
-=09=09if (res =3D=3D -1)
-=09=09=09goto out_err;
-=09}
-=09if (valid & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID)) {
-=09=09uid_t uid =3D (valid & FUSE_SET_ATTR_UID) ?
-=09=09=09attr->st_uid : (uid_t) -1;
-=09=09gid_t gid =3D (valid & FUSE_SET_ATTR_GID) ?
-=09=09=09attr->st_gid : (gid_t) -1;
-
-=09=09res =3D fchownat(ifd, "", uid, gid,
-=09=09=09       AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW);
-=09=09if (res =3D=3D -1)
-=09=09=09goto out_err;
-=09}
-=09if (valid & FUSE_SET_ATTR_SIZE) {
-=09=09if (fi) {
-=09=09=09res =3D ftruncate(fi->fh, attr->st_size);
-=09=09} else {
-=09=09=09sprintf(procname, "/proc/self/fd/%i", ifd);
-=09=09=09res =3D truncate(procname, attr->st_size);
-=09=09}
-=09=09if (res =3D=3D -1)
-=09=09=09goto out_err;
-=09}
-=09if (valid & (FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME)) {
-=09=09struct timespec tv[2];
-
-=09=09tv[0].tv_sec =3D 0;
-=09=09tv[1].tv_sec =3D 0;
-=09=09tv[0].tv_nsec =3D UTIME_OMIT;
-=09=09tv[1].tv_nsec =3D UTIME_OMIT;
-
-=09=09if (valid & FUSE_SET_ATTR_ATIME_NOW)
-=09=09=09tv[0].tv_nsec =3D UTIME_NOW;
-=09=09else if (valid & FUSE_SET_ATTR_ATIME)
-=09=09=09tv[0] =3D attr->st_atim;
-
-=09=09if (valid & FUSE_SET_ATTR_MTIME_NOW)
-=09=09=09tv[1].tv_nsec =3D UTIME_NOW;
-=09=09else if (valid & FUSE_SET_ATTR_MTIME)
-=09=09=09tv[1] =3D attr->st_mtim;
-
-=09=09if (fi)
-=09=09=09res =3D futimens(fi->fh, tv);
-=09=09else
-=09=09=09res =3D utimensat_empty_nofollow(inode, tv);
-=09=09if (res =3D=3D -1)
-=09=09=09goto out_err;
-=09}
-
-=09return lo_getattr(req, ino, fi);
+    int saverr;
+    char procname[64];
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    int ifd =3D inode->fd;
+    int res;
+
+    if (valid & FUSE_SET_ATTR_MODE) {
+        if (fi) {
+            res =3D fchmod(fi->fh, attr->st_mode);
+        } else {
+            sprintf(procname, "/proc/self/fd/%i", ifd);
+            res =3D chmod(procname, attr->st_mode);
+        }
+        if (res =3D=3D -1) {
+            goto out_err;
+        }
+    }
+    if (valid & (FUSE_SET_ATTR_UID | FUSE_SET_ATTR_GID)) {
+        uid_t uid =3D (valid & FUSE_SET_ATTR_UID) ? attr->st_uid : (uid_t)=
-1;
+        gid_t gid =3D (valid & FUSE_SET_ATTR_GID) ? attr->st_gid : (gid_t)=
-1;
+
+        res =3D fchownat(ifd, "", uid, gid, AT_EMPTY_PATH | AT_SYMLINK_NOF=
OLLOW);
+        if (res =3D=3D -1) {
+            goto out_err;
+        }
+    }
+    if (valid & FUSE_SET_ATTR_SIZE) {
+        if (fi) {
+            res =3D ftruncate(fi->fh, attr->st_size);
+        } else {
+            sprintf(procname, "/proc/self/fd/%i", ifd);
+            res =3D truncate(procname, attr->st_size);
+        }
+        if (res =3D=3D -1) {
+            goto out_err;
+        }
+    }
+    if (valid & (FUSE_SET_ATTR_ATIME | FUSE_SET_ATTR_MTIME)) {
+        struct timespec tv[2];
+
+        tv[0].tv_sec =3D 0;
+        tv[1].tv_sec =3D 0;
+        tv[0].tv_nsec =3D UTIME_OMIT;
+        tv[1].tv_nsec =3D UTIME_OMIT;
+
+        if (valid & FUSE_SET_ATTR_ATIME_NOW) {
+            tv[0].tv_nsec =3D UTIME_NOW;
+        } else if (valid & FUSE_SET_ATTR_ATIME) {
+            tv[0] =3D attr->st_atim;
+        }
+
+        if (valid & FUSE_SET_ATTR_MTIME_NOW) {
+            tv[1].tv_nsec =3D UTIME_NOW;
+        } else if (valid & FUSE_SET_ATTR_MTIME) {
+            tv[1] =3D attr->st_mtim;
+        }
+
+        if (fi) {
+            res =3D futimens(fi->fh, tv);
+        } else {
+            res =3D utimensat_empty_nofollow(inode, tv);
+        }
+        if (res =3D=3D -1) {
+            goto out_err;
+        }
+    }
+
+    return lo_getattr(req, ino, fi);
=20
 out_err:
-=09saverr =3D errno;
-=09fuse_reply_err(req, saverr);
+    saverr =3D errno;
+    fuse_reply_err(req, saverr);
 }
=20
 static struct lo_inode *lo_find(struct lo_data *lo, struct stat *st)
 {
-=09struct lo_inode *p;
-=09struct lo_inode *ret =3D NULL;
-
-=09pthread_mutex_lock(&lo->mutex);
-=09for (p =3D lo->root.next; p !=3D &lo->root; p =3D p->next) {
-=09=09if (p->ino =3D=3D st->st_ino && p->dev =3D=3D st->st_dev) {
-=09=09=09assert(p->refcount > 0);
-=09=09=09ret =3D p;
-=09=09=09ret->refcount++;
-=09=09=09break;
-=09=09}
-=09}
-=09pthread_mutex_unlock(&lo->mutex);
-=09return ret;
+    struct lo_inode *p;
+    struct lo_inode *ret =3D NULL;
+
+    pthread_mutex_lock(&lo->mutex);
+    for (p =3D lo->root.next; p !=3D &lo->root; p =3D p->next) {
+        if (p->ino =3D=3D st->st_ino && p->dev =3D=3D st->st_dev) {
+            assert(p->refcount > 0);
+            ret =3D p;
+            ret->refcount++;
+            break;
+        }
+    }
+    pthread_mutex_unlock(&lo->mutex);
+    return ret;
 }
=20
 static int lo_do_lookup(fuse_req_t req, fuse_ino_t parent, const char *nam=
e,
-=09=09=09 struct fuse_entry_param *e)
+                        struct fuse_entry_param *e)
 {
-=09int newfd;
-=09int res;
-=09int saverr;
-=09struct lo_data *lo =3D lo_data(req);
-=09struct lo_inode *inode;
-
-=09memset(e, 0, sizeof(*e));
-=09e->attr_timeout =3D lo->timeout;
-=09e->entry_timeout =3D lo->timeout;
-
-=09newfd =3D openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
-=09if (newfd =3D=3D -1)
-=09=09goto out_err;
-
-=09res =3D fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLO=
W);
-=09if (res =3D=3D -1)
-=09=09goto out_err;
-
-=09inode =3D lo_find(lo_data(req), &e->attr);
-=09if (inode) {
-=09=09close(newfd);
-=09=09newfd =3D -1;
-=09} else {
-=09=09struct lo_inode *prev, *next;
-
-=09=09saverr =3D ENOMEM;
-=09=09inode =3D calloc(1, sizeof(struct lo_inode));
-=09=09if (!inode)
-=09=09=09goto out_err;
-
-=09=09inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
-=09=09inode->refcount =3D 1;
-=09=09inode->fd =3D newfd;
-=09=09inode->ino =3D e->attr.st_ino;
-=09=09inode->dev =3D e->attr.st_dev;
-
-=09=09pthread_mutex_lock(&lo->mutex);
-=09=09prev =3D &lo->root;
-=09=09next =3D prev->next;
-=09=09next->prev =3D inode;
-=09=09inode->next =3D next;
-=09=09inode->prev =3D prev;
-=09=09prev->next =3D inode;
-=09=09pthread_mutex_unlock(&lo->mutex);
-=09}
-=09e->ino =3D (uintptr_t) inode;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name, (unsigned long long) e->ino);
-
-=09return 0;
+    int newfd;
+    int res;
+    int saverr;
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *inode;
+
+    memset(e, 0, sizeof(*e));
+    e->attr_timeout =3D lo->timeout;
+    e->entry_timeout =3D lo->timeout;
+
+    newfd =3D openat(lo_fd(req, parent), name, O_PATH | O_NOFOLLOW);
+    if (newfd =3D=3D -1) {
+        goto out_err;
+    }
+
+    res =3D fstatat(newfd, "", &e->attr, AT_EMPTY_PATH | AT_SYMLINK_NOFOLL=
OW);
+    if (res =3D=3D -1) {
+        goto out_err;
+    }
+
+    inode =3D lo_find(lo_data(req), &e->attr);
+    if (inode) {
+        close(newfd);
+        newfd =3D -1;
+    } else {
+        struct lo_inode *prev, *next;
+
+        saverr =3D ENOMEM;
+        inode =3D calloc(1, sizeof(struct lo_inode));
+        if (!inode) {
+            goto out_err;
+        }
+
+        inode->is_symlink =3D S_ISLNK(e->attr.st_mode);
+        inode->refcount =3D 1;
+        inode->fd =3D newfd;
+        inode->ino =3D e->attr.st_ino;
+        inode->dev =3D e->attr.st_dev;
+
+        pthread_mutex_lock(&lo->mutex);
+        prev =3D &lo->root;
+        next =3D prev->next;
+        next->prev =3D inode;
+        inode->next =3D next;
+        inode->prev =3D prev;
+        prev->next =3D inode;
+        pthread_mutex_unlock(&lo->mutex);
+    }
+    e->ino =3D (uintptr_t)inode;
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+                 (unsigned long long)parent, name, (unsigned long long)e->=
ino);
+    }
+
+    return 0;
=20
 out_err:
-=09saverr =3D errno;
-=09if (newfd !=3D -1)
-=09=09close(newfd);
-=09return saverr;
+    saverr =3D errno;
+    if (newfd !=3D -1) {
+        close(newfd);
+    }
+    return saverr;
 }
=20
 static void lo_lookup(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
-=09struct fuse_entry_param e;
-=09int err;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%s)=
\n",
-=09=09=09parent, name);
-
-=09err =3D lo_do_lookup(req, parent, name, &e);
-=09if (err)
-=09=09fuse_reply_err(req, err);
-=09else
-=09=09fuse_reply_entry(req, &e);
+    struct fuse_entry_param e;
+    int err;
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_lookup(parent=3D%" PRIu64 ", name=3D%=
s)\n",
+                 parent, name);
+    }
+
+    err =3D lo_do_lookup(req, parent, name, &e);
+    if (err) {
+        fuse_reply_err(req, err);
+    } else {
+        fuse_reply_entry(req, &e);
+    }
 }
=20
 static void lo_mknod_symlink(fuse_req_t req, fuse_ino_t parent,
-=09=09=09     const char *name, mode_t mode, dev_t rdev,
-=09=09=09     const char *link)
+                             const char *name, mode_t mode, dev_t rdev,
+                             const char *link)
 {
-=09int res;
-=09int saverr;
-=09struct lo_inode *dir =3D lo_inode(req, parent);
-=09struct fuse_entry_param e;
+    int res;
+    int saverr;
+    struct lo_inode *dir =3D lo_inode(req, parent);
+    struct fuse_entry_param e;
=20
-=09saverr =3D ENOMEM;
+    saverr =3D ENOMEM;
=20
-=09res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
+    res =3D mknod_wrapper(dir->fd, name, link, mode, rdev);
=20
-=09saverr =3D errno;
-=09if (res =3D=3D -1)
-=09=09goto out;
+    saverr =3D errno;
+    if (res =3D=3D -1) {
+        goto out;
+    }
=20
-=09saverr =3D lo_do_lookup(req, parent, name, &e);
-=09if (saverr)
-=09=09goto out;
+    saverr =3D lo_do_lookup(req, parent, name, &e);
+    if (saverr) {
+        goto out;
+    }
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name, (unsigned long long) e.ino);
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+                 (unsigned long long)parent, name, (unsigned long long)e.i=
no);
+    }
=20
-=09fuse_reply_entry(req, &e);
-=09return;
+    fuse_reply_entry(req, &e);
+    return;
=20
 out:
-=09fuse_reply_err(req, saverr);
+    fuse_reply_err(req, saverr);
 }
=20
-static void lo_mknod(fuse_req_t req, fuse_ino_t parent,
-=09=09     const char *name, mode_t mode, dev_t rdev)
+static void lo_mknod(fuse_req_t req, fuse_ino_t parent, const char *name,
+                     mode_t mode, dev_t rdev)
 {
-=09lo_mknod_symlink(req, parent, name, mode, rdev, NULL);
+    lo_mknod_symlink(req, parent, name, mode, rdev, NULL);
 }
=20
 static void lo_mkdir(fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09     mode_t mode)
+                     mode_t mode)
 {
-=09lo_mknod_symlink(req, parent, name, S_IFDIR | mode, 0, NULL);
+    lo_mknod_symlink(req, parent, name, S_IFDIR | mode, 0, NULL);
 }
=20
-static void lo_symlink(fuse_req_t req, const char *link,
-=09=09       fuse_ino_t parent, const char *name)
+static void lo_symlink(fuse_req_t req, const char *link, fuse_ino_t parent=
,
+                       const char *name)
 {
-=09lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
+    lo_mknod_symlink(req, parent, name, S_IFLNK, 0, link);
 }
=20
 static int linkat_empty_nofollow(struct lo_inode *inode, int dfd,
-=09=09=09=09 const char *name)
+                                 const char *name)
 {
-=09int res;
-=09char procname[64];
+    int res;
+    char procname[64];
=20
-=09if (inode->is_symlink) {
-=09=09res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
-=09=09if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL)) {
-=09=09=09/* Sorry, no race free way to hard-link a symlink. */
-=09=09=09errno =3D EPERM;
-=09=09}
-=09=09return res;
-=09}
+    if (inode->is_symlink) {
+        res =3D linkat(inode->fd, "", dfd, name, AT_EMPTY_PATH);
+        if (res =3D=3D -1 && (errno =3D=3D ENOENT || errno =3D=3D EINVAL))=
 {
+            /* Sorry, no race free way to hard-link a symlink. */
+            errno =3D EPERM;
+        }
+        return res;
+    }
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
=20
-=09return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
+    return linkat(AT_FDCWD, procname, dfd, name, AT_SYMLINK_FOLLOW);
 }
=20
 static void lo_link(fuse_req_t req, fuse_ino_t ino, fuse_ino_t parent,
-=09=09    const char *name)
+                    const char *name)
 {
-=09int res;
-=09struct lo_data *lo =3D lo_data(req);
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09struct fuse_entry_param e;
-=09int saverr;
-
-=09memset(&e, 0, sizeof(struct fuse_entry_param));
-=09e.attr_timeout =3D lo->timeout;
-=09e.entry_timeout =3D lo->timeout;
-
-=09res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
-=09if (res =3D=3D -1)
-=09=09goto out_err;
-
-=09res =3D fstatat(inode->fd, "", &e.attr, AT_EMPTY_PATH | AT_SYMLINK_NOFO=
LLOW);
-=09if (res =3D=3D -1)
-=09=09goto out_err;
-
-=09pthread_mutex_lock(&lo->mutex);
-=09inode->refcount++;
-=09pthread_mutex_unlock(&lo->mutex);
-=09e.ino =3D (uintptr_t) inode;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
-=09=09=09(unsigned long long) parent, name,
-=09=09=09(unsigned long long) e.ino);
-
-=09fuse_reply_entry(req, &e);
-=09return;
+    int res;
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    struct fuse_entry_param e;
+    int saverr;
+
+    memset(&e, 0, sizeof(struct fuse_entry_param));
+    e.attr_timeout =3D lo->timeout;
+    e.entry_timeout =3D lo->timeout;
+
+    res =3D linkat_empty_nofollow(inode, lo_fd(req, parent), name);
+    if (res =3D=3D -1) {
+        goto out_err;
+    }
+
+    res =3D fstatat(inode->fd, "", &e.attr, AT_EMPTY_PATH | AT_SYMLINK_NOF=
OLLOW);
+    if (res =3D=3D -1) {
+        goto out_err;
+    }
+
+    pthread_mutex_lock(&lo->mutex);
+    inode->refcount++;
+    pthread_mutex_unlock(&lo->mutex);
+    e.ino =3D (uintptr_t)inode;
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "  %lli/%s -> %lli\n",
+                 (unsigned long long)parent, name, (unsigned long long)e.i=
no);
+    }
+
+    fuse_reply_entry(req, &e);
+    return;
=20
 out_err:
-=09saverr =3D errno;
-=09fuse_reply_err(req, saverr);
+    saverr =3D errno;
+    fuse_reply_err(req, saverr);
 }
=20
 static void lo_rmdir(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
-=09int res;
+    int res;
=20
-=09res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
+    res =3D unlinkat(lo_fd(req, parent), name, AT_REMOVEDIR);
=20
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void lo_rename(fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09      fuse_ino_t newparent, const char *newname,
-=09=09      unsigned int flags)
+                      fuse_ino_t newparent, const char *newname,
+                      unsigned int flags)
 {
-=09int res;
+    int res;
=20
-=09if (flags) {
-=09=09fuse_reply_err(req, EINVAL);
-=09=09return;
-=09}
+    if (flags) {
+        fuse_reply_err(req, EINVAL);
+        return;
+    }
=20
-=09res =3D renameat(lo_fd(req, parent), name,
-=09=09=09lo_fd(req, newparent), newname);
+    res =3D renameat(lo_fd(req, parent), name, lo_fd(req, newparent), newn=
ame);
=20
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void lo_unlink(fuse_req_t req, fuse_ino_t parent, const char *name)
 {
-=09int res;
+    int res;
=20
-=09res =3D unlinkat(lo_fd(req, parent), name, 0);
+    res =3D unlinkat(lo_fd(req, parent), name, 0);
=20
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void unref_inode(struct lo_data *lo, struct lo_inode *inode, uint64=
_t n)
 {
-=09if (!inode)
-=09=09return;
-
-=09pthread_mutex_lock(&lo->mutex);
-=09assert(inode->refcount >=3D n);
-=09inode->refcount -=3D n;
-=09if (!inode->refcount) {
-=09=09struct lo_inode *prev, *next;
-
-=09=09prev =3D inode->prev;
-=09=09next =3D inode->next;
-=09=09next->prev =3D prev;
-=09=09prev->next =3D next;
-
-=09=09pthread_mutex_unlock(&lo->mutex);
-=09=09close(inode->fd);
-=09=09free(inode);
-
-=09} else {
-=09=09pthread_mutex_unlock(&lo->mutex);
-=09}
+    if (!inode) {
+        return;
+    }
+
+    pthread_mutex_lock(&lo->mutex);
+    assert(inode->refcount >=3D n);
+    inode->refcount -=3D n;
+    if (!inode->refcount) {
+        struct lo_inode *prev, *next;
+
+        prev =3D inode->prev;
+        next =3D inode->next;
+        next->prev =3D prev;
+        prev->next =3D next;
+
+        pthread_mutex_unlock(&lo->mutex);
+        close(inode->fd);
+        free(inode);
+
+    } else {
+        pthread_mutex_unlock(&lo->mutex);
+    }
 }
=20
 static void lo_forget_one(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup=
)
 {
-=09struct lo_data *lo =3D lo_data(req);
-=09struct lo_inode *inode =3D lo_inode(req, ino);
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_inode *inode =3D lo_inode(req, ino);
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
-=09=09=09(unsigned long long) ino,
-=09=09=09(unsigned long long) inode->refcount,
-=09=09=09(unsigned long long) nlookup);
-=09}
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "  forget %lli %lli -%lli\n",
+                 (unsigned long long)ino, (unsigned long long)inode->refco=
unt,
+                 (unsigned long long)nlookup);
+    }
=20
-=09unref_inode(lo, inode, nlookup);
+    unref_inode(lo, inode, nlookup);
 }
=20
 static void lo_forget(fuse_req_t req, fuse_ino_t ino, uint64_t nlookup)
 {
-=09lo_forget_one(req, ino, nlookup);
-=09fuse_reply_none(req);
+    lo_forget_one(req, ino, nlookup);
+    fuse_reply_none(req);
 }
=20
 static void lo_forget_multi(fuse_req_t req, size_t count,
-=09=09=09=09struct fuse_forget_data *forgets)
+                            struct fuse_forget_data *forgets)
 {
-=09int i;
+    int i;
=20
-=09for (i =3D 0; i < count; i++)
-=09=09lo_forget_one(req, forgets[i].ino, forgets[i].nlookup);
-=09fuse_reply_none(req);
+    for (i =3D 0; i < count; i++) {
+        lo_forget_one(req, forgets[i].ino, forgets[i].nlookup);
+    }
+    fuse_reply_none(req);
 }
=20
 static void lo_readlink(fuse_req_t req, fuse_ino_t ino)
 {
-=09char buf[PATH_MAX + 1];
-=09int res;
+    char buf[PATH_MAX + 1];
+    int res;
=20
-=09res =3D readlinkat(lo_fd(req, ino), "", buf, sizeof(buf));
-=09if (res =3D=3D -1)
-=09=09return (void) fuse_reply_err(req, errno);
+    res =3D readlinkat(lo_fd(req, ino), "", buf, sizeof(buf));
+    if (res =3D=3D -1) {
+        return (void)fuse_reply_err(req, errno);
+    }
=20
-=09if (res =3D=3D sizeof(buf))
-=09=09return (void) fuse_reply_err(req, ENAMETOOLONG);
+    if (res =3D=3D sizeof(buf)) {
+        return (void)fuse_reply_err(req, ENAMETOOLONG);
+    }
=20
-=09buf[res] =3D '\0';
+    buf[res] =3D '\0';
=20
-=09fuse_reply_readlink(req, buf);
+    fuse_reply_readlink(req, buf);
 }
=20
 struct lo_dirp {
-=09DIR *dp;
-=09struct dirent *entry;
-=09off_t offset;
+    DIR *dp;
+    struct dirent *entry;
+    off_t offset;
 };
=20
 static struct lo_dirp *lo_dirp(struct fuse_file_info *fi)
 {
-=09return (struct lo_dirp *) (uintptr_t) fi->fh;
+    return (struct lo_dirp *)(uintptr_t)fi->fh;
 }
=20
-static void lo_opendir(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
+static void lo_opendir(fuse_req_t req, fuse_ino_t ino,
+                       struct fuse_file_info *fi)
 {
-=09int error =3D ENOMEM;
-=09struct lo_data *lo =3D lo_data(req);
-=09struct lo_dirp *d;
-=09int fd;
-
-=09d =3D calloc(1, sizeof(struct lo_dirp));
-=09if (d =3D=3D NULL)
-=09=09goto out_err;
-
-=09fd =3D openat(lo_fd(req, ino), ".", O_RDONLY);
-=09if (fd =3D=3D -1)
-=09=09goto out_errno;
-
-=09d->dp =3D fdopendir(fd);
-=09if (d->dp =3D=3D NULL)
-=09=09goto out_errno;
-
-=09d->offset =3D 0;
-=09d->entry =3D NULL;
-
-=09fi->fh =3D (uintptr_t) d;
-=09if (lo->cache =3D=3D CACHE_ALWAYS)
-=09=09fi->keep_cache =3D 1;
-=09fuse_reply_open(req, fi);
-=09return;
+    int error =3D ENOMEM;
+    struct lo_data *lo =3D lo_data(req);
+    struct lo_dirp *d;
+    int fd;
+
+    d =3D calloc(1, sizeof(struct lo_dirp));
+    if (d =3D=3D NULL) {
+        goto out_err;
+    }
+
+    fd =3D openat(lo_fd(req, ino), ".", O_RDONLY);
+    if (fd =3D=3D -1) {
+        goto out_errno;
+    }
+
+    d->dp =3D fdopendir(fd);
+    if (d->dp =3D=3D NULL) {
+        goto out_errno;
+    }
+
+    d->offset =3D 0;
+    d->entry =3D NULL;
+
+    fi->fh =3D (uintptr_t)d;
+    if (lo->cache =3D=3D CACHE_ALWAYS) {
+        fi->keep_cache =3D 1;
+    }
+    fuse_reply_open(req, fi);
+    return;
=20
 out_errno:
-=09error =3D errno;
+    error =3D errno;
 out_err:
-=09if (d) {
-=09=09if (fd !=3D -1)
-=09=09=09close(fd);
-=09=09free(d);
-=09}
-=09fuse_reply_err(req, error);
+    if (d) {
+        if (fd !=3D -1) {
+            close(fd);
+        }
+        free(d);
+    }
+    fuse_reply_err(req, error);
 }
=20
 static int is_dot_or_dotdot(const char *name)
 {
-=09return name[0] =3D=3D '.' && (name[1] =3D=3D '\0' ||
-=09=09=09=09  (name[1] =3D=3D '.' && name[2] =3D=3D '\0'));
+    return name[0] =3D=3D '.' &&
+           (name[1] =3D=3D '\0' || (name[1] =3D=3D '.' && name[2] =3D=3D '=
\0'));
 }
=20
 static void lo_do_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
-=09=09=09  off_t offset, struct fuse_file_info *fi, int plus)
+                          off_t offset, struct fuse_file_info *fi, int plu=
s)
 {
-=09struct lo_dirp *d =3D lo_dirp(fi);
-=09char *buf;
-=09char *p;
-=09size_t rem =3D size;
-=09int err;
-
-=09(void) ino;
-
-=09buf =3D calloc(1, size);
-=09if (!buf) {
-=09=09err =3D ENOMEM;
-=09=09goto error;
-=09}
-=09p =3D buf;
-
-=09if (offset !=3D d->offset) {
-=09=09seekdir(d->dp, offset);
-=09=09d->entry =3D NULL;
-=09=09d->offset =3D offset;
-=09}
-=09while (1) {
-=09=09size_t entsize;
-=09=09off_t nextoff;
-=09=09const char *name;
-
-=09=09if (!d->entry) {
-=09=09=09errno =3D 0;
-=09=09=09d->entry =3D readdir(d->dp);
-=09=09=09if (!d->entry) {
-=09=09=09=09if (errno) {  // Error
-=09=09=09=09=09err =3D errno;
-=09=09=09=09=09goto error;
-=09=09=09=09} else {  // End of stream
-=09=09=09=09=09break;=20
-=09=09=09=09}
-=09=09=09}
-=09=09}
-=09=09nextoff =3D d->entry->d_off;
-=09=09name =3D d->entry->d_name;
-=09=09fuse_ino_t entry_ino =3D 0;
-=09=09if (plus) {
-=09=09=09struct fuse_entry_param e;
-=09=09=09if (is_dot_or_dotdot(name)) {
-=09=09=09=09e =3D (struct fuse_entry_param) {
-=09=09=09=09=09.attr.st_ino =3D d->entry->d_ino,
-=09=09=09=09=09.attr.st_mode =3D d->entry->d_type << 12,
-=09=09=09=09};
-=09=09=09} else {
-=09=09=09=09err =3D lo_do_lookup(req, ino, name, &e);
-=09=09=09=09if (err)
-=09=09=09=09=09goto error;
-=09=09=09=09entry_ino =3D e.ino;
-=09=09=09}
-
-=09=09=09entsize =3D fuse_add_direntry_plus(req, p, rem, name,
-=09=09=09=09=09=09=09 &e, nextoff);
-=09=09} else {
-=09=09=09struct stat st =3D {
-=09=09=09=09.st_ino =3D d->entry->d_ino,
-=09=09=09=09.st_mode =3D d->entry->d_type << 12,
-=09=09=09};
-=09=09=09entsize =3D fuse_add_direntry(req, p, rem, name,
-=09=09=09=09=09=09    &st, nextoff);
-=09=09}
-=09=09if (entsize > rem) {
-=09=09=09if (entry_ino !=3D 0)=20
-=09=09=09=09lo_forget_one(req, entry_ino, 1);
-=09=09=09break;
-=09=09}
-=09=09
-=09=09p +=3D entsize;
-=09=09rem -=3D entsize;
-
-=09=09d->entry =3D NULL;
-=09=09d->offset =3D nextoff;
-=09}
+    struct lo_dirp *d =3D lo_dirp(fi);
+    char *buf;
+    char *p;
+    size_t rem =3D size;
+    int err;
+
+    (void)ino;
+
+    buf =3D calloc(1, size);
+    if (!buf) {
+        err =3D ENOMEM;
+        goto error;
+    }
+    p =3D buf;
+
+    if (offset !=3D d->offset) {
+        seekdir(d->dp, offset);
+        d->entry =3D NULL;
+        d->offset =3D offset;
+    }
+    while (1) {
+        size_t entsize;
+        off_t nextoff;
+        const char *name;
+
+        if (!d->entry) {
+            errno =3D 0;
+            d->entry =3D readdir(d->dp);
+            if (!d->entry) {
+                if (errno) { /* Error */
+                    err =3D errno;
+                    goto error;
+                } else { /* End of stream */
+                    break;
+                }
+            }
+        }
+        nextoff =3D d->entry->d_off;
+        name =3D d->entry->d_name;
+        fuse_ino_t entry_ino =3D 0;
+        if (plus) {
+            struct fuse_entry_param e;
+            if (is_dot_or_dotdot(name)) {
+                e =3D (struct fuse_entry_param){
+                    .attr.st_ino =3D d->entry->d_ino,
+                    .attr.st_mode =3D d->entry->d_type << 12,
+                };
+            } else {
+                err =3D lo_do_lookup(req, ino, name, &e);
+                if (err) {
+                    goto error;
+                }
+                entry_ino =3D e.ino;
+            }
+
+            entsize =3D fuse_add_direntry_plus(req, p, rem, name, &e, next=
off);
+        } else {
+            struct stat st =3D {
+                .st_ino =3D d->entry->d_ino,
+                .st_mode =3D d->entry->d_type << 12,
+            };
+            entsize =3D fuse_add_direntry(req, p, rem, name, &st, nextoff)=
;
+        }
+        if (entsize > rem) {
+            if (entry_ino !=3D 0) {
+                lo_forget_one(req, entry_ino, 1);
+            }
+            break;
+        }
+
+        p +=3D entsize;
+        rem -=3D entsize;
+
+        d->entry =3D NULL;
+        d->offset =3D nextoff;
+    }
=20
     err =3D 0;
 error:
-    // If there's an error, we can only signal it if we haven't stored
-    // any entries yet - otherwise we'd end up with wrong lookup
-    // counts for the entries that are already in the buffer. So we
-    // return what we've collected until that point.
-    if (err && rem =3D=3D size)
-=09    fuse_reply_err(req, err);
-    else
-=09    fuse_reply_buf(req, buf, size - rem);
+    /*
+     * If there's an error, we can only signal it if we haven't stored
+     * any entries yet - otherwise we'd end up with wrong lookup
+     * counts for the entries that are already in the buffer. So we
+     * return what we've collected until that point.
+     */
+    if (err && rem =3D=3D size) {
+        fuse_reply_err(req, err);
+    } else {
+        fuse_reply_buf(req, buf, size - rem);
+    }
     free(buf);
 }
=20
 static void lo_readdir(fuse_req_t req, fuse_ino_t ino, size_t size,
-=09=09       off_t offset, struct fuse_file_info *fi)
+                       off_t offset, struct fuse_file_info *fi)
 {
-=09lo_do_readdir(req, ino, size, offset, fi, 0);
+    lo_do_readdir(req, ino, size, offset, fi, 0);
 }
=20
 static void lo_readdirplus(fuse_req_t req, fuse_ino_t ino, size_t size,
-=09=09=09   off_t offset, struct fuse_file_info *fi)
+                           off_t offset, struct fuse_file_info *fi)
 {
-=09lo_do_readdir(req, ino, size, offset, fi, 1);
+    lo_do_readdir(req, ino, size, offset, fi, 1);
 }
=20
-static void lo_releasedir(fuse_req_t req, fuse_ino_t ino, struct fuse_file=
_info *fi)
+static void lo_releasedir(fuse_req_t req, fuse_ino_t ino,
+                          struct fuse_file_info *fi)
 {
-=09struct lo_dirp *d =3D lo_dirp(fi);
-=09(void) ino;
-=09closedir(d->dp);
-=09free(d);
-=09fuse_reply_err(req, 0);
+    struct lo_dirp *d =3D lo_dirp(fi);
+    (void)ino;
+    closedir(d->dp);
+    free(d);
+    fuse_reply_err(req, 0);
 }
=20
 static void lo_create(fuse_req_t req, fuse_ino_t parent, const char *name,
-=09=09      mode_t mode, struct fuse_file_info *fi)
+                      mode_t mode, struct fuse_file_info *fi)
 {
-=09int fd;
-=09struct lo_data *lo =3D lo_data(req);
-=09struct fuse_entry_param e;
-=09int err;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%s)=
\n",
-=09=09=09parent, name);
-
-=09fd =3D openat(lo_fd(req, parent), name,
-=09=09    (fi->flags | O_CREAT) & ~O_NOFOLLOW, mode);
-=09if (fd =3D=3D -1)
-=09=09return (void) fuse_reply_err(req, errno);
-
-=09fi->fh =3D fd;
-=09if (lo->cache =3D=3D CACHE_NEVER)
-=09=09fi->direct_io =3D 1;
-=09else if (lo->cache =3D=3D CACHE_ALWAYS)
-=09=09fi->keep_cache =3D 1;
-
-=09err =3D lo_do_lookup(req, parent, name, &e);
-=09if (err)
-=09=09fuse_reply_err(req, err);
-=09else
-=09=09fuse_reply_create(req, &e, fi);
+    int fd;
+    struct lo_data *lo =3D lo_data(req);
+    struct fuse_entry_param e;
+    int err;
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_create(parent=3D%" PRIu64 ", name=3D%=
s)\n",
+                 parent, name);
+    }
+
+    fd =3D openat(lo_fd(req, parent), name, (fi->flags | O_CREAT) & ~O_NOF=
OLLOW,
+                mode);
+    if (fd =3D=3D -1) {
+        return (void)fuse_reply_err(req, errno);
+    }
+
+    fi->fh =3D fd;
+    if (lo->cache =3D=3D CACHE_NEVER) {
+        fi->direct_io =3D 1;
+    } else if (lo->cache =3D=3D CACHE_ALWAYS) {
+        fi->keep_cache =3D 1;
+    }
+
+    err =3D lo_do_lookup(req, parent, name, &e);
+    if (err) {
+        fuse_reply_err(req, err);
+    } else {
+        fuse_reply_create(req, &e, fi);
+    }
 }
=20
 static void lo_fsyncdir(fuse_req_t req, fuse_ino_t ino, int datasync,
-=09=09=09struct fuse_file_info *fi)
+                        struct fuse_file_info *fi)
 {
-=09int res;
-=09int fd =3D dirfd(lo_dirp(fi)->dp);
-=09(void) ino;
-=09if (datasync)
-=09=09res =3D fdatasync(fd);
-=09else
-=09=09res =3D fsync(fd);
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    int res;
+    int fd =3D dirfd(lo_dirp(fi)->dp);
+    (void)ino;
+    if (datasync) {
+        res =3D fdatasync(fd);
+    } else {
+        res =3D fsync(fd);
+    }
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void lo_open(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info =
*fi)
 {
-=09int fd;
-=09char buf[64];
-=09struct lo_data *lo =3D lo_data(req);
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n",
-=09=09=09ino, fi->flags);
-
-=09/* With writeback cache, kernel may send read requests even
-=09   when userspace opened write-only */
-=09if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
-=09=09fi->flags &=3D ~O_ACCMODE;
-=09=09fi->flags |=3D O_RDWR;
-=09}
-
-=09/* With writeback cache, O_APPEND is handled by the kernel.
-=09   This breaks atomicity (since the file may change in the
-=09   underlying filesystem, so that the kernel's idea of the
-=09   end of the file isn't accurate anymore). In this example,
-=09   we just accept that. A more rigorous filesystem may want
-=09   to return an error here */
-=09if (lo->writeback && (fi->flags & O_APPEND))
-=09=09fi->flags &=3D ~O_APPEND;
-
-=09sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
-=09fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
-=09if (fd =3D=3D -1)
-=09=09return (void) fuse_reply_err(req, errno);
-
-=09fi->fh =3D fd;
-=09if (lo->cache =3D=3D CACHE_NEVER)
-=09=09fi->direct_io =3D 1;
-=09else if (lo->cache =3D=3D CACHE_ALWAYS)
-=09=09fi->keep_cache =3D 1;
-=09fuse_reply_open(req, fi);
+    int fd;
+    char buf[64];
+    struct lo_data *lo =3D lo_data(req);
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_open(ino=3D%" PRIu64 ", flags=3D%d)\n=
", ino,
+                 fi->flags);
+    }
+
+    /*
+     * With writeback cache, kernel may send read requests even
+     * when userspace opened write-only
+     */
+    if (lo->writeback && (fi->flags & O_ACCMODE) =3D=3D O_WRONLY) {
+        fi->flags &=3D ~O_ACCMODE;
+        fi->flags |=3D O_RDWR;
+    }
+
+    /*
+     * With writeback cache, O_APPEND is handled by the kernel.
+     * This breaks atomicity (since the file may change in the
+     * underlying filesystem, so that the kernel's idea of the
+     * end of the file isn't accurate anymore). In this example,
+     * we just accept that. A more rigorous filesystem may want
+     * to return an error here
+     */
+    if (lo->writeback && (fi->flags & O_APPEND)) {
+        fi->flags &=3D ~O_APPEND;
+    }
+
+    sprintf(buf, "/proc/self/fd/%i", lo_fd(req, ino));
+    fd =3D open(buf, fi->flags & ~O_NOFOLLOW);
+    if (fd =3D=3D -1) {
+        return (void)fuse_reply_err(req, errno);
+    }
+
+    fi->fh =3D fd;
+    if (lo->cache =3D=3D CACHE_NEVER) {
+        fi->direct_io =3D 1;
+    } else if (lo->cache =3D=3D CACHE_ALWAYS) {
+        fi->keep_cache =3D 1;
+    }
+    fuse_reply_open(req, fi);
 }
=20
-static void lo_release(fuse_req_t req, fuse_ino_t ino, struct fuse_file_in=
fo *fi)
+static void lo_release(fuse_req_t req, fuse_ino_t ino,
+                       struct fuse_file_info *fi)
 {
-=09(void) ino;
+    (void)ino;
=20
-=09close(fi->fh);
-=09fuse_reply_err(req, 0);
+    close(fi->fh);
+    fuse_reply_err(req, 0);
 }
=20
 static void lo_flush(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info=
 *fi)
 {
-=09int res;
-=09(void) ino;
-=09res =3D close(dup(fi->fh));
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    int res;
+    (void)ino;
+    res =3D close(dup(fi->fh));
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void lo_fsync(fuse_req_t req, fuse_ino_t ino, int datasync,
-=09=09     struct fuse_file_info *fi)
+                     struct fuse_file_info *fi)
 {
-=09int res;
-=09(void) ino;
-=09if (datasync)
-=09=09res =3D fdatasync(fi->fh);
-=09else
-=09=09res =3D fsync(fi->fh);
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    int res;
+    (void)ino;
+    if (datasync) {
+        res =3D fdatasync(fi->fh);
+    } else {
+        res =3D fsync(fi->fh);
+    }
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
-static void lo_read(fuse_req_t req, fuse_ino_t ino, size_t size,
-=09=09    off_t offset, struct fuse_file_info *fi)
+static void lo_read(fuse_req_t req, fuse_ino_t ino, size_t size, off_t off=
set,
+                    struct fuse_file_info *fi)
 {
-=09struct fuse_bufvec buf =3D FUSE_BUFVEC_INIT(size);
+    struct fuse_bufvec buf =3D FUSE_BUFVEC_INIT(size);
=20
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
-=09=09=09"off=3D%lu)\n", ino, size, (unsigned long) offset);
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "lo_read(ino=3D%" PRIu64 ", size=3D%zd, "
+                 "off=3D%lu)\n",
+                 ino, size, (unsigned long)offset);
+    }
=20
-=09buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
-=09buf.buf[0].fd =3D fi->fh;
-=09buf.buf[0].pos =3D offset;
+    buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
+    buf.buf[0].fd =3D fi->fh;
+    buf.buf[0].pos =3D offset;
=20
-=09fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
+    fuse_reply_data(req, &buf, FUSE_BUF_SPLICE_MOVE);
 }
=20
 static void lo_write_buf(fuse_req_t req, fuse_ino_t ino,
-=09=09=09 struct fuse_bufvec *in_buf, off_t off,
-=09=09=09 struct fuse_file_info *fi)
+                         struct fuse_bufvec *in_buf, off_t off,
+                         struct fuse_file_info *fi)
 {
-=09(void) ino;
-=09ssize_t res;
-=09struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf));
-
-=09out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
-=09out_buf.buf[0].fd =3D fi->fh;
-=09out_buf.buf[0].pos =3D off;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_write(ino=3D%" PRIu64 ", size=3D%zd, of=
f=3D%lu)\n",
-=09=09=09ino, out_buf.buf[0].size, (unsigned long) off);
-
-=09res =3D fuse_buf_copy(&out_buf, in_buf, 0);
-=09if(res < 0)
-=09=09fuse_reply_err(req, -res);
-=09else
-=09=09fuse_reply_write(req, (size_t) res);
+    (void)ino;
+    ssize_t res;
+    struct fuse_bufvec out_buf =3D FUSE_BUFVEC_INIT(fuse_buf_size(in_buf))=
;
+
+    out_buf.buf[0].flags =3D FUSE_BUF_IS_FD | FUSE_BUF_FD_SEEK;
+    out_buf.buf[0].fd =3D fi->fh;
+    out_buf.buf[0].pos =3D off;
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "lo_write(ino=3D%" PRIu64 ", size=3D%zd, off=3D%lu)\n", i=
no,
+                 out_buf.buf[0].size, (unsigned long)off);
+    }
+
+    res =3D fuse_buf_copy(&out_buf, in_buf, 0);
+    if (res < 0) {
+        fuse_reply_err(req, -res);
+    } else {
+        fuse_reply_write(req, (size_t)res);
+    }
 }
=20
 static void lo_statfs(fuse_req_t req, fuse_ino_t ino)
 {
-=09int res;
-=09struct statvfs stbuf;
-
-=09res =3D fstatvfs(lo_fd(req, ino), &stbuf);
-=09if (res =3D=3D -1)
-=09=09fuse_reply_err(req, errno);
-=09else
-=09=09fuse_reply_statfs(req, &stbuf);
+    int res;
+    struct statvfs stbuf;
+
+    res =3D fstatvfs(lo_fd(req, ino), &stbuf);
+    if (res =3D=3D -1) {
+        fuse_reply_err(req, errno);
+    } else {
+        fuse_reply_statfs(req, &stbuf);
+    }
 }
=20
-static void lo_fallocate(fuse_req_t req, fuse_ino_t ino, int mode,
-=09=09=09 off_t offset, off_t length, struct fuse_file_info *fi)
+static void lo_fallocate(fuse_req_t req, fuse_ino_t ino, int mode, off_t o=
ffset,
+                         off_t length, struct fuse_file_info *fi)
 {
-=09int err =3D EOPNOTSUPP;
-=09(void) ino;
+    int err =3D EOPNOTSUPP;
+    (void)ino;
=20
 #ifdef HAVE_FALLOCATE
-=09err =3D fallocate(fi->fh, mode, offset, length);
-=09if (err < 0)
-=09=09err =3D errno;
+    err =3D fallocate(fi->fh, mode, offset, length);
+    if (err < 0) {
+        err =3D errno;
+    }
=20
 #elif defined(HAVE_POSIX_FALLOCATE)
-=09if (mode) {
-=09=09fuse_reply_err(req, EOPNOTSUPP);
-=09=09return;
-=09}
+    if (mode) {
+        fuse_reply_err(req, EOPNOTSUPP);
+        return;
+    }
=20
-=09err =3D posix_fallocate(fi->fh, offset, length);
+    err =3D posix_fallocate(fi->fh, offset, length);
 #endif
=20
-=09fuse_reply_err(req, err);
+    fuse_reply_err(req, err);
 }
=20
 static void lo_flock(fuse_req_t req, fuse_ino_t ino, struct fuse_file_info=
 *fi,
-=09=09     int op)
+                     int op)
 {
-=09int res;
-=09(void) ino;
+    int res;
+    (void)ino;
=20
-=09res =3D flock(fi->fh, op);
+    res =3D flock(fi->fh, op);
=20
-=09fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
+    fuse_reply_err(req, res =3D=3D -1 ? errno : 0);
 }
=20
 static void lo_getxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
-=09=09=09size_t size)
+                        size_t size)
 {
-=09char *value =3D NULL;
-=09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09ssize_t ret;
-=09int saverr;
-
-=09saverr =3D ENOSYS;
-=09if (!lo_data(req)->xattr)
-=09=09goto out;
-
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s s=
ize=3D%zd)\n",
-=09=09=09ino, name, size);
-=09}
-
-=09if (inode->is_symlink) {
-=09=09/* Sorry, no race free way to getxattr on symlink. */
-=09=09saverr =3D EPERM;
-=09=09goto out;
-=09}
-
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
-
-=09if (size) {
-=09=09value =3D malloc(size);
-=09=09if (!value)
-=09=09=09goto out_err;
-
-=09=09ret =3D getxattr(procname, name, value, size);
-=09=09if (ret =3D=3D -1)
-=09=09=09goto out_err;
-=09=09saverr =3D 0;
-=09=09if (ret =3D=3D 0)
-=09=09=09goto out;
-
-=09=09fuse_reply_buf(req, value, ret);
-=09} else {
-=09=09ret =3D getxattr(procname, name, NULL, 0);
-=09=09if (ret =3D=3D -1)
-=09=09=09goto out_err;
-
-=09=09fuse_reply_xattr(req, ret);
-=09}
+    char *value =3D NULL;
+    char procname[64];
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    ssize_t ret;
+    int saverr;
+
+    saverr =3D ENOSYS;
+    if (!lo_data(req)->xattr) {
+        goto out;
+    }
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "lo_getxattr(ino=3D%" PRIu64 ", name=3D%s size=3D%zd)\n",=
 ino, name,
+                 size);
+    }
+
+    if (inode->is_symlink) {
+        /* Sorry, no race free way to getxattr on symlink. */
+        saverr =3D EPERM;
+        goto out;
+    }
+
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+    if (size) {
+        value =3D malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+
+        ret =3D getxattr(procname, name, value, size);
+        if (ret =3D=3D -1) {
+            goto out_err;
+        }
+        saverr =3D 0;
+        if (ret =3D=3D 0) {
+            goto out;
+        }
+
+        fuse_reply_buf(req, value, ret);
+    } else {
+        ret =3D getxattr(procname, name, NULL, 0);
+        if (ret =3D=3D -1) {
+            goto out_err;
+        }
+
+        fuse_reply_xattr(req, ret);
+    }
 out_free:
-=09free(value);
-=09return;
+    free(value);
+    return;
=20
 out_err:
-=09saverr =3D errno;
+    saverr =3D errno;
 out:
-=09fuse_reply_err(req, saverr);
-=09goto out_free;
+    fuse_reply_err(req, saverr);
+    goto out_free;
 }
=20
 static void lo_listxattr(fuse_req_t req, fuse_ino_t ino, size_t size)
 {
-=09char *value =3D NULL;
-=09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09ssize_t ret;
-=09int saverr;
-
-=09saverr =3D ENOSYS;
-=09if (!lo_data(req)->xattr)
-=09=09goto out;
-
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%zd=
)\n",
-=09=09=09ino, size);
-=09}
-
-=09if (inode->is_symlink) {
-=09=09/* Sorry, no race free way to listxattr on symlink. */
-=09=09saverr =3D EPERM;
-=09=09goto out;
-=09}
-
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
-
-=09if (size) {
-=09=09value =3D malloc(size);
-=09=09if (!value)
-=09=09=09goto out_err;
-
-=09=09ret =3D listxattr(procname, value, size);
-=09=09if (ret =3D=3D -1)
-=09=09=09goto out_err;
-=09=09saverr =3D 0;
-=09=09if (ret =3D=3D 0)
-=09=09=09goto out;
-
-=09=09fuse_reply_buf(req, value, ret);
-=09} else {
-=09=09ret =3D listxattr(procname, NULL, 0);
-=09=09if (ret =3D=3D -1)
-=09=09=09goto out_err;
-
-=09=09fuse_reply_xattr(req, ret);
-=09}
+    char *value =3D NULL;
+    char procname[64];
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    ssize_t ret;
+    int saverr;
+
+    saverr =3D ENOSYS;
+    if (!lo_data(req)->xattr) {
+        goto out;
+    }
+
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_listxattr(ino=3D%" PRIu64 ", size=3D%=
zd)\n",
+                 ino, size);
+    }
+
+    if (inode->is_symlink) {
+        /* Sorry, no race free way to listxattr on symlink. */
+        saverr =3D EPERM;
+        goto out;
+    }
+
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
+
+    if (size) {
+        value =3D malloc(size);
+        if (!value) {
+            goto out_err;
+        }
+
+        ret =3D listxattr(procname, value, size);
+        if (ret =3D=3D -1) {
+            goto out_err;
+        }
+        saverr =3D 0;
+        if (ret =3D=3D 0) {
+            goto out;
+        }
+
+        fuse_reply_buf(req, value, ret);
+    } else {
+        ret =3D listxattr(procname, NULL, 0);
+        if (ret =3D=3D -1) {
+            goto out_err;
+        }
+
+        fuse_reply_xattr(req, ret);
+    }
 out_free:
-=09free(value);
-=09return;
+    free(value);
+    return;
=20
 out_err:
-=09saverr =3D errno;
+    saverr =3D errno;
 out:
-=09fuse_reply_err(req, saverr);
-=09goto out_free;
+    fuse_reply_err(req, saverr);
+    goto out_free;
 }
=20
 static void lo_setxattr(fuse_req_t req, fuse_ino_t ino, const char *name,
-=09=09=09const char *value, size_t size, int flags)
+                        const char *value, size_t size, int flags)
 {
-=09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09ssize_t ret;
-=09int saverr;
+    char procname[64];
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    ssize_t ret;
+    int saverr;
=20
-=09saverr =3D ENOSYS;
-=09if (!lo_data(req)->xattr)
-=09=09goto out;
+    saverr =3D ENOSYS;
+    if (!lo_data(req)->xattr) {
+        goto out;
+    }
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_setxattr(ino=3D%" PRIu64 ", name=3D%s v=
alue=3D%s size=3D%zd)\n",
-=09=09=09ino, name, value, size);
-=09}
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG,
+                 "lo_setxattr(ino=3D%" PRIu64 ", name=3D%s value=3D%s size=
=3D%zd)\n",
+                 ino, name, value, size);
+    }
=20
-=09if (inode->is_symlink) {
-=09=09/* Sorry, no race free way to setxattr on symlink. */
-=09=09saverr =3D EPERM;
-=09=09goto out;
-=09}
+    if (inode->is_symlink) {
+        /* Sorry, no race free way to setxattr on symlink. */
+        saverr =3D EPERM;
+        goto out;
+    }
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
=20
-=09ret =3D setxattr(procname, name, value, size, flags);
-=09saverr =3D ret =3D=3D -1 ? errno : 0;
+    ret =3D setxattr(procname, name, value, size, flags);
+    saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
-=09fuse_reply_err(req, saverr);
+    fuse_reply_err(req, saverr);
 }
=20
 static void lo_removexattr(fuse_req_t req, fuse_ino_t ino, const char *nam=
e)
 {
-=09char procname[64];
-=09struct lo_inode *inode =3D lo_inode(req, ino);
-=09ssize_t ret;
-=09int saverr;
+    char procname[64];
+    struct lo_inode *inode =3D lo_inode(req, ino);
+    ssize_t ret;
+    int saverr;
=20
-=09saverr =3D ENOSYS;
-=09if (!lo_data(req)->xattr)
-=09=09goto out;
+    saverr =3D ENOSYS;
+    if (!lo_data(req)->xattr) {
+        goto out;
+    }
=20
-=09if (lo_debug(req)) {
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=3D%=
s)\n",
-=09=09=09ino, name);
-=09}
+    if (lo_debug(req)) {
+        fuse_log(FUSE_LOG_DEBUG, "lo_removexattr(ino=3D%" PRIu64 ", name=
=3D%s)\n",
+                 ino, name);
+    }
=20
-=09if (inode->is_symlink) {
-=09=09/* Sorry, no race free way to setxattr on symlink. */
-=09=09saverr =3D EPERM;
-=09=09goto out;
-=09}
+    if (inode->is_symlink) {
+        /* Sorry, no race free way to setxattr on symlink. */
+        saverr =3D EPERM;
+        goto out;
+    }
=20
-=09sprintf(procname, "/proc/self/fd/%i", inode->fd);
+    sprintf(procname, "/proc/self/fd/%i", inode->fd);
=20
-=09ret =3D removexattr(procname, name);
-=09saverr =3D ret =3D=3D -1 ? errno : 0;
+    ret =3D removexattr(procname, name);
+    saverr =3D ret =3D=3D -1 ? errno : 0;
=20
 out:
-=09fuse_reply_err(req, saverr);
+    fuse_reply_err(req, saverr);
 }
=20
 #ifdef HAVE_COPY_FILE_RANGE
 static void lo_copy_file_range(fuse_req_t req, fuse_ino_t ino_in, off_t of=
f_in,
-=09=09=09       struct fuse_file_info *fi_in,
-=09=09=09       fuse_ino_t ino_out, off_t off_out,
-=09=09=09       struct fuse_file_info *fi_out, size_t len,
-=09=09=09       int flags)
+                               struct fuse_file_info *fi_in, fuse_ino_t in=
o_out,
+                               off_t off_out, struct fuse_file_info *fi_ou=
t,
+                               size_t len, int flags)
 {
-=09ssize_t res;
-
-=09if (lo_debug(req))
-=09=09fuse_log(FUSE_LOG_DEBUG, "lo_copy_file_range(ino=3D%" PRIu64 "/fd=3D=
%lu, "
-=09=09=09=09"off=3D%lu, ino=3D%" PRIu64 "/fd=3D%lu, "
-=09=09=09=09"off=3D%lu, size=3D%zd, flags=3D0x%x)\n",
-=09=09=09ino_in, fi_in->fh, off_in, ino_out, fi_out->fh, off_out,
-=09=09=09len, flags);
-
-=09res =3D copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len,
-=09=09=09      flags);
-=09if (res < 0)
-=09=09fuse_reply_err(req, -errno);
-=09else
-=09=09fuse_reply_write(req, res);
+    ssize_t res;
+
+    if (lo_debug(req))
+        fuse_log(FUSE_LOG_DEBUG,
+                 "lo_copy_file_range(ino=3D%" PRIu64 "/fd=3D%lu, "
+                 "off=3D%lu, ino=3D%" PRIu64 "/fd=3D%lu, "
+                 "off=3D%lu, size=3D%zd, flags=3D0x%x)\n",
+                 ino_in, fi_in->fh, off_in, ino_out, fi_out->fh, off_out, =
len,
+                 flags);
+
+    res =3D copy_file_range(fi_in->fh, &off_in, fi_out->fh, &off_out, len,=
 flags);
+    if (res < 0) {
+        fuse_reply_err(req, -errno);
+    } else {
+        fuse_reply_write(req, res);
+    }
 }
 #endif
=20
 static void lo_lseek(fuse_req_t req, fuse_ino_t ino, off_t off, int whence=
,
-=09=09     struct fuse_file_info *fi)
+                     struct fuse_file_info *fi)
 {
-=09off_t res;
-
-=09(void)ino;
-=09res =3D lseek(fi->fh, off, whence);
-=09if (res !=3D -1)
-=09=09fuse_reply_lseek(req, res);
-=09else
-=09=09fuse_reply_err(req, errno);
+    off_t res;
+
+    (void)ino;
+    res =3D lseek(fi->fh, off, whence);
+    if (res !=3D -1) {
+        fuse_reply_lseek(req, res);
+    } else {
+        fuse_reply_err(req, errno);
+    }
 }
=20
 static struct fuse_lowlevel_ops lo_oper =3D {
-=09.init=09=09=3D lo_init,
-=09.lookup=09=09=3D lo_lookup,
-=09.mkdir=09=09=3D lo_mkdir,
-=09.mknod=09=09=3D lo_mknod,
-=09.symlink=09=3D lo_symlink,
-=09.link=09=09=3D lo_link,
-=09.unlink=09=09=3D lo_unlink,
-=09.rmdir=09=09=3D lo_rmdir,
-=09.rename=09=09=3D lo_rename,
-=09.forget=09=09=3D lo_forget,
-=09.forget_multi=09=3D lo_forget_multi,
-=09.getattr=09=3D lo_getattr,
-=09.setattr=09=3D lo_setattr,
-=09.readlink=09=3D lo_readlink,
-=09.opendir=09=3D lo_opendir,
-=09.readdir=09=3D lo_readdir,
-=09.readdirplus=09=3D lo_readdirplus,
-=09.releasedir=09=3D lo_releasedir,
-=09.fsyncdir=09=3D lo_fsyncdir,
-=09.create=09=09=3D lo_create,
-=09.open=09=09=3D lo_open,
-=09.release=09=3D lo_release,
-=09.flush=09=09=3D lo_flush,
-=09.fsync=09=09=3D lo_fsync,
-=09.read=09=09=3D lo_read,
-=09.write_buf      =3D lo_write_buf,
-=09.statfs=09=09=3D lo_statfs,
-=09.fallocate=09=3D lo_fallocate,
-=09.flock=09=09=3D lo_flock,
-=09.getxattr=09=3D lo_getxattr,
-=09.listxattr=09=3D lo_listxattr,
-=09.setxattr=09=3D lo_setxattr,
-=09.removexattr=09=3D lo_removexattr,
+    .init =3D lo_init,
+    .lookup =3D lo_lookup,
+    .mkdir =3D lo_mkdir,
+    .mknod =3D lo_mknod,
+    .symlink =3D lo_symlink,
+    .link =3D lo_link,
+    .unlink =3D lo_unlink,
+    .rmdir =3D lo_rmdir,
+    .rename =3D lo_rename,
+    .forget =3D lo_forget,
+    .forget_multi =3D lo_forget_multi,
+    .getattr =3D lo_getattr,
+    .setattr =3D lo_setattr,
+    .readlink =3D lo_readlink,
+    .opendir =3D lo_opendir,
+    .readdir =3D lo_readdir,
+    .readdirplus =3D lo_readdirplus,
+    .releasedir =3D lo_releasedir,
+    .fsyncdir =3D lo_fsyncdir,
+    .create =3D lo_create,
+    .open =3D lo_open,
+    .release =3D lo_release,
+    .flush =3D lo_flush,
+    .fsync =3D lo_fsync,
+    .read =3D lo_read,
+    .write_buf =3D lo_write_buf,
+    .statfs =3D lo_statfs,
+    .fallocate =3D lo_fallocate,
+    .flock =3D lo_flock,
+    .getxattr =3D lo_getxattr,
+    .listxattr =3D lo_listxattr,
+    .setxattr =3D lo_setxattr,
+    .removexattr =3D lo_removexattr,
 #ifdef HAVE_COPY_FILE_RANGE
-=09.copy_file_range =3D lo_copy_file_range,
+    .copy_file_range =3D lo_copy_file_range,
 #endif
-=09.lseek=09=09=3D lo_lseek,
+    .lseek =3D lo_lseek,
 };
=20
 int main(int argc, char *argv[])
 {
-=09struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
-=09struct fuse_session *se;
-=09struct fuse_cmdline_opts opts;
-=09struct lo_data lo =3D { .debug =3D 0,
-=09                      .writeback =3D 0 };
-=09int ret =3D -1;
-
-=09/* Don't mask creation mode, kernel already did that */
-=09umask(0);
-
-=09pthread_mutex_init(&lo.mutex, NULL);
-=09lo.root.next =3D lo.root.prev =3D &lo.root;
-=09lo.root.fd =3D -1;
-=09lo.cache =3D CACHE_NORMAL;
-
-=09if (fuse_parse_cmdline(&args, &opts) !=3D 0)
-=09=09return 1;
-=09if (opts.show_help) {
-=09=09printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
-=09=09fuse_cmdline_help();
-=09=09fuse_lowlevel_help();
-=09=09ret =3D 0;
-=09=09goto err_out1;
-=09} else if (opts.show_version) {
-=09=09printf("FUSE library version %s\n", fuse_pkgversion());
-=09=09fuse_lowlevel_version();
-=09=09ret =3D 0;
-=09=09goto err_out1;
-=09}
-
-=09if(opts.mountpoint =3D=3D NULL) {
-=09=09printf("usage: %s [options] <mountpoint>\n", argv[0]);
-=09=09printf("       %s --help\n", argv[0]);
-=09=09ret =3D 1;
-=09=09goto err_out1;
-=09}
-
-=09if (fuse_opt_parse(&args, &lo, lo_opts, NULL)=3D=3D -1)
-=09=09return 1;
-
-=09lo.debug =3D opts.debug;
-=09lo.root.refcount =3D 2;
-=09if (lo.source) {
-=09=09struct stat stat;
-=09=09int res;
-
-=09=09res =3D lstat(lo.source, &stat);
-=09=09if (res =3D=3D -1) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "failed to stat source (\"%s\"): %m\n",
-=09=09=09=09 lo.source);
-=09=09=09exit(1);
-=09=09}
-=09=09if (!S_ISDIR(stat.st_mode)) {
-=09=09=09fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
-=09=09=09exit(1);
-=09=09}
-
-=09} else {
-=09=09lo.source =3D "/";
-=09}
-=09lo.root.is_symlink =3D false;
-=09if (!lo.timeout_set) {
-=09=09switch (lo.cache) {
-=09=09case CACHE_NEVER:
-=09=09=09lo.timeout =3D 0.0;
-=09=09=09break;
-
-=09=09case CACHE_NORMAL:
-=09=09=09lo.timeout =3D 1.0;
-=09=09=09break;
-
-=09=09case CACHE_ALWAYS:
-=09=09=09lo.timeout =3D 86400.0;
-=09=09=09break;
-=09=09}
-=09} else if (lo.timeout < 0) {
-=09=09fuse_log(FUSE_LOG_ERR, "timeout is negative (%lf)\n",
-=09=09=09 lo.timeout);
-=09=09exit(1);
-=09}
-
-=09lo.root.fd =3D open(lo.source, O_PATH);
-=09if (lo.root.fd =3D=3D -1) {
-=09=09fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n",
-=09=09=09 lo.source);
-=09=09exit(1);
-=09}
-
-=09se =3D fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
-=09if (se =3D=3D NULL)
-=09    goto err_out1;
-
-=09if (fuse_set_signal_handlers(se) !=3D 0)
-=09    goto err_out2;
-
-=09if (fuse_session_mount(se, opts.mountpoint) !=3D 0)
-=09    goto err_out3;
-
-=09fuse_daemonize(opts.foreground);
-
-=09/* Block until ctrl+c or fusermount -u */
-=09if (opts.singlethread)
-=09=09ret =3D fuse_session_loop(se);
-=09else
-=09=09ret =3D fuse_session_loop_mt(se, opts.clone_fd);
-
-=09fuse_session_unmount(se);
+    struct fuse_args args =3D FUSE_ARGS_INIT(argc, argv);
+    struct fuse_session *se;
+    struct fuse_cmdline_opts opts;
+    struct lo_data lo =3D { .debug =3D 0, .writeback =3D 0 };
+    int ret =3D -1;
+
+    /* Don't mask creation mode, kernel already did that */
+    umask(0);
+
+    pthread_mutex_init(&lo.mutex, NULL);
+    lo.root.next =3D lo.root.prev =3D &lo.root;
+    lo.root.fd =3D -1;
+    lo.cache =3D CACHE_NORMAL;
+
+    if (fuse_parse_cmdline(&args, &opts) !=3D 0) {
+        return 1;
+    }
+    if (opts.show_help) {
+        printf("usage: %s [options] <mountpoint>\n\n", argv[0]);
+        fuse_cmdline_help();
+        fuse_lowlevel_help();
+        ret =3D 0;
+        goto err_out1;
+    } else if (opts.show_version) {
+        printf("FUSE library version %s\n", fuse_pkgversion());
+        fuse_lowlevel_version();
+        ret =3D 0;
+        goto err_out1;
+    }
+
+    if (opts.mountpoint =3D=3D NULL) {
+        printf("usage: %s [options] <mountpoint>\n", argv[0]);
+        printf("       %s --help\n", argv[0]);
+        ret =3D 1;
+        goto err_out1;
+    }
+
+    if (fuse_opt_parse(&args, &lo, lo_opts, NULL) =3D=3D -1) {
+        return 1;
+    }
+
+    lo.debug =3D opts.debug;
+    lo.root.refcount =3D 2;
+    if (lo.source) {
+        struct stat stat;
+        int res;
+
+        res =3D lstat(lo.source, &stat);
+        if (res =3D=3D -1) {
+            fuse_log(FUSE_LOG_ERR, "failed to stat source (\"%s\"): %m\n",
+                     lo.source);
+            exit(1);
+        }
+        if (!S_ISDIR(stat.st_mode)) {
+            fuse_log(FUSE_LOG_ERR, "source is not a directory\n");
+            exit(1);
+        }
+
+    } else {
+        lo.source =3D "/";
+    }
+    lo.root.is_symlink =3D false;
+    if (!lo.timeout_set) {
+        switch (lo.cache) {
+        case CACHE_NEVER:
+            lo.timeout =3D 0.0;
+            break;
+
+        case CACHE_NORMAL:
+            lo.timeout =3D 1.0;
+            break;
+
+        case CACHE_ALWAYS:
+            lo.timeout =3D 86400.0;
+            break;
+        }
+    } else if (lo.timeout < 0) {
+        fuse_log(FUSE_LOG_ERR, "timeout is negative (%lf)\n", lo.timeout);
+        exit(1);
+    }
+
+    lo.root.fd =3D open(lo.source, O_PATH);
+    if (lo.root.fd =3D=3D -1) {
+        fuse_log(FUSE_LOG_ERR, "open(\"%s\", O_PATH): %m\n", lo.source);
+        exit(1);
+    }
+
+    se =3D fuse_session_new(&args, &lo_oper, sizeof(lo_oper), &lo);
+    if (se =3D=3D NULL) {
+        goto err_out1;
+    }
+
+    if (fuse_set_signal_handlers(se) !=3D 0) {
+        goto err_out2;
+    }
+
+    if (fuse_session_mount(se, opts.mountpoint) !=3D 0) {
+        goto err_out3;
+    }
+
+    fuse_daemonize(opts.foreground);
+
+    /* Block until ctrl+c or fusermount -u */
+    if (opts.singlethread) {
+        ret =3D fuse_session_loop(se);
+    } else {
+        ret =3D fuse_session_loop_mt(se, opts.clone_fd);
+    }
+
+    fuse_session_unmount(se);
 err_out3:
-=09fuse_remove_signal_handlers(se);
+    fuse_remove_signal_handlers(se);
 err_out2:
-=09fuse_session_destroy(se);
+    fuse_session_destroy(se);
 err_out1:
-=09free(opts.mountpoint);
-=09fuse_opt_free_args(&args);
+    free(opts.mountpoint);
+    fuse_opt_free_args(&args);
=20
-=09if (lo.root.fd >=3D 0)
-=09=09close(lo.root.fd);
+    if (lo.root.fd >=3D 0) {
+        close(lo.root.fd);
+    }
=20
-=09return ret ? 1 : 0;
+    return ret ? 1 : 0;
 }
--=20
2.23.0


