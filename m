Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1334C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC802076A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 15:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX06IJQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC802076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOjuW-0007NF-O2
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 11:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <flukshun@gmail.com>) id 1jOjs1-0002rT-Nu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1jOjs0-00027w-Lu
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:33 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36463)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1jOjs0-00027Y-HT
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 11:22:32 -0400
Received: by mail-oi1-x241.google.com with SMTP id s202so10559102oih.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fhbbqO70eYReDnemV03U2WqJFqhr9unuoXv8ipfHzp0=;
 b=AX06IJQEKORp7aGrXSGKiWy40OXVGXaMk4bJo1xIsP58znfKxFjcqDZl2J8Ihr9U67
 ywPEtl4eYDnW7nZl+uepZEIbP5Bm8NymXcSygoTtrx3qXSkvT7annRASvfwIiNWhyT+M
 Xrjjlg9z0EympAQz5gVAOoCpqekXoGGiVS4K0rwnZ7lcYZxed1lLBZHZRZf+Ag9Idts5
 SN8kYE1OUASbJM2Q9CB3lycQLaHK7qS2bN5SbehcmVrtuyow3kH8dW6qQ2Oxwj/plf9H
 F3jpcUkUPWoiRgY5aRr+upp32lMRGL/dmQY5SXqO6RJkYhuq7IG8m5PVWasgRiYpw10t
 83eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fhbbqO70eYReDnemV03U2WqJFqhr9unuoXv8ipfHzp0=;
 b=LahU/32jjJAbcEWtr68t6mCTphh5nh20dC0TTZIVXD88kGec6Tf8hRT6qxrxWlXZvH
 T+ao2G2/zyMOYaeWulCDb/j1OEJ5lZV1zkEQ9TMcGgGSxzWAW2tNtSBe7GU0xjw7dhbF
 5xKSNQ9Ip8wa4P9wgZsu+s16X0EYLWSvqUhTmIxr52uYQFK0DU4aBuJ04OB4thXngslv
 nRhk8WsHIaz3S2QpsgrZBsBwVOjIaURaSZWBMMlj84D2mZf5UyjKHRcBs/Zy9aMBGDyW
 BwRi4oqEg65lpj9Fda6wNhNqWU1h6NPAn5o2cpLfEElC8dyCvI/BcpFMnbdinrXXfT0i
 n0JA==
X-Gm-Message-State: AGi0PuYZmvfcMPeSLv5h1MobqvDjQotD0wY3+c7WdwTa2R1QNX9CY7cC
 adEPdRIHEUoO0zE2NqYRvHNbW7tJVdM=
X-Google-Smtp-Source: APiQypLkZtRRQf9o/aISmQ0qf8TD3FnDYVBtyAVxiVTgOdNIpwY5A8C4y8iGbGb2ngMYqiiVVRy17w==
X-Received: by 2002:aca:cd0e:: with SMTP id d14mr18041804oig.167.1586964151457; 
 Wed, 15 Apr 2020 08:22:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id h14sm2685171oov.11.2020.04.15.08.22.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Apr 2020 08:22:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL for-5.0 2/4] qga: Extract guest_file_handle_find() to
 commands-common.h
Date: Wed, 15 Apr 2020 10:22:00 -0500
Message-Id: <20200415152202.14463-3-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
References: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

As we are going to reuse this method, declare it in common
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-common.h | 18 ++++++++++++++++++
 qga/commands-posix.c  |  7 ++++---
 qga/commands-win32.c  |  7 ++++---
 3 files changed, 26 insertions(+), 6 deletions(-)
 create mode 100644 qga/commands-common.h

diff --git a/qga/commands-common.h b/qga/commands-common.h
new file mode 100644
index 0000000000..af90e5481e
--- /dev/null
+++ b/qga/commands-common.h
@@ -0,0 +1,18 @@
+/*
+ * QEMU Guest Agent common/cross-platform common commands
+ *
+ * Copyright (c) 2020 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef QGA_COMMANDS_COMMON_H
+#define QGA_COMMANDS_COMMON_H
+
+#include "qga-qapi-types.h"
+
+typedef struct GuestFileHandle GuestFileHandle;
+
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp);
+
+#endif
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index cc69b82704..c59c32185c 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -26,6 +26,7 @@
 #include "qemu/sockets.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
+#include "commands-common.h"
 
 #ifdef HAVE_UTMPX
 #include <utmpx.h>
@@ -237,12 +238,12 @@ typedef enum {
     RW_STATE_WRITING,
 } RwState;
 
-typedef struct GuestFileHandle {
+struct GuestFileHandle {
     uint64_t id;
     FILE *fh;
     RwState state;
     QTAILQ_ENTRY(GuestFileHandle) next;
-} GuestFileHandle;
+};
 
 static struct {
     QTAILQ_HEAD(, GuestFileHandle) filehandles;
@@ -268,7 +269,7 @@ static int64_t guest_file_handle_add(FILE *fh, Error **errp)
     return handle;
 }
 
-static GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
 {
     GuestFileHandle *gfh;
 
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 46cea7d1d9..cfaf6b84b8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -37,6 +37,7 @@
 #include "qemu/queue.h"
 #include "qemu/host-utils.h"
 #include "qemu/base64.h"
+#include "commands-common.h"
 
 #ifndef SHTDN_REASON_FLAG_PLANNED
 #define SHTDN_REASON_FLAG_PLANNED 0x80000000
@@ -50,11 +51,11 @@
 
 #define INVALID_SET_FILE_POINTER ((DWORD)-1)
 
-typedef struct GuestFileHandle {
+struct GuestFileHandle {
     int64_t id;
     HANDLE fh;
     QTAILQ_ENTRY(GuestFileHandle) next;
-} GuestFileHandle;
+};
 
 static struct {
     QTAILQ_HEAD(, GuestFileHandle) filehandles;
@@ -126,7 +127,7 @@ static int64_t guest_file_handle_add(HANDLE fh, Error **errp)
     return handle;
 }
 
-static GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
+GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp)
 {
     GuestFileHandle *gfh;
     QTAILQ_FOREACH(gfh, &guest_file_state.filehandles, next) {
-- 
2.17.1


