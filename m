Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6A6C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AE2B20838
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 14:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmluHkKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AE2B20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJHYi-0003oz-Ii
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 10:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJHXj-0002WQ-DI
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJHXi-0007no-2o
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46714
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJHXh-0007mg-Uo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 10:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585663621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aGdC97AkFNkFqaIwkp45N3YaBMRqu7kpW7vfEyDnaxg=;
 b=MmluHkKdNXwrgW9TcBDebjME9T9bmsDb0u0hUKcb6OJyypbVvJJ6pTXY+YB6sCeXNwQfdL
 x32Uicas/doLn2WPv8HyWQh7vUELr2EnIJd9wkd0U7FctJXpXQkUOpFbCxS3Z5tCKAZS3H
 TSXDLP0nawM3vy/Rpi2sjhVNcbu11h0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-aCrzIIloO-Czw9WpfQz0cg-1; Tue, 31 Mar 2020 10:07:00 -0400
X-MC-Unique: aCrzIIloO-Czw9WpfQz0cg-1
Received: by mail-wm1-f70.google.com with SMTP id p18so1097699wmk.9
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 07:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a3RvWLwvWAjQjAP9v638w2/vKcOEdj8FX6FbILwgYSA=;
 b=EUbyzDcXfPJXJ6cunBPUmopvJw9r9YZCA52e5E1dYP2npzY6MC8N6RFFPO9x4fgLds
 vMF6Xg1JhtZgSMIUNOm6xzIr3oE6TaKugvCzVoIadmnEpGSgzD/rqQMOxotgP68HhNe6
 T9Qzlzc6DRHmBgTZ4/rNuVDB5UrSNfBxXGKhIDYDleHQ3SY+sA3819bJeSwTiQSIvT9G
 MY2+soKUy9NAmgcf9oo2Zq6Crmvy3VDzbQ3kbcgAutU8swM2uVLO3Y8ZX8clhmsH6kKk
 4FbyKDe2ule3smO1Rccyx16y9Kh3ZZ3P9uRHaAMiilIx96oL9Xo4qzAowp2/2ZkwH7OI
 YtfA==
X-Gm-Message-State: ANhLgQ08xfteFGnYCeb3A2dQs7BejsStkUEDuCc1vALsZdCHJoPH4qBs
 ZZFt6WY5WTPYRSeBQmQYmIerd0j6nfw2QSJJ3aADhOQkjmDAWf056cLC18gOD+Q6bLhmZfRrGa6
 U28RIAOykxC+z9z0=
X-Received: by 2002:a1c:2842:: with SMTP id o63mr3629972wmo.73.1585663618611; 
 Tue, 31 Mar 2020 07:06:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvCz7WusVIWR9afBMCZ0NgXM5Z41+XHgF2mQwuEZ5HdUuKO/BVKxApkY85irHAus15rIymOcw==
X-Received: by 2002:a1c:2842:: with SMTP id o63mr3629948wmo.73.1585663618387; 
 Tue, 31 Mar 2020 07:06:58 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id h132sm4235721wmf.18.2020.03.31.07.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2020 07:06:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 3/4] qga: Extract qmp_guest_file_read() to common
 commands.c
Date: Tue, 31 Mar 2020 16:06:37 +0200
Message-Id: <20200331140638.16464-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200331140638.16464-1-philmd@redhat.com>
References: <20200331140638.16464-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fakhri Zulkifli <mohdfakhrizulkifli@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Sameeh Jubran <sjubran@redhat.com>, Basil Salman <basil@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Dietmar Maurer <dietmar@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract the common code shared by both POSIX/Win32 implementations.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-common.h |  3 +++
 qga/commands-posix.c  | 22 +++-------------------
 qga/commands-win32.c  | 20 +++-----------------
 qga/commands.c        | 25 +++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/qga/commands-common.h b/qga/commands-common.h
index af90e5481e..90785ed4bb 100644
--- a/qga/commands-common.h
+++ b/qga/commands-common.h
@@ -15,4 +15,7 @@ typedef struct GuestFileHandle GuestFileHandle;
=20
 GuestFileHandle *guest_file_handle_find(int64_t id, Error **errp);
=20
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp);
+
 #endif
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 2199b3b6d9..3352e9ca66 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -461,29 +461,14 @@ void qmp_guest_file_close(int64_t handle, Error **err=
p)
     g_free(gfh);
 }
=20
-struct GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                          int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
-    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
     GuestFileRead *read_data =3D NULL;
     guchar *buf;
-    FILE *fh;
+    FILE *fh =3D gfh->fh;
     size_t read_count;
=20
-    if (!gfh) {
-        return NULL;
-    }
-
-    if (!has_count) {
-        count =3D QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >=3D UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64 "' is invalid for argument coun=
t",
-                   count);
-        return NULL;
-    }
-
-    fh =3D gfh->fh;
-
     /* explicitly flush when switching from writing to reading */
     if (gfh->state =3D=3D RW_STATE_WRITING) {
         int ret =3D fflush(fh);
@@ -498,7 +483,6 @@ struct GuestFileRead *qmp_guest_file_read(int64_t handl=
e, bool has_count,
     read_count =3D fread(buf, 1, count, fh);
     if (ferror(fh)) {
         error_setg_errno(errp, errno, "failed to read file");
-        slog("guest-file-read failed, handle: %" PRId64, handle);
     } else {
         buf[read_count] =3D 0;
         read_data =3D g_new0(GuestFileRead, 1);
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index cfaf6b84b8..9717a8d52d 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -322,33 +322,19 @@ void qmp_guest_shutdown(bool has_mode, const char *mo=
de, Error **errp)
     }
 }
=20
-GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
-                                   int64_t count, Error **errp)
+GuestFileRead *guest_file_read_unsafe(GuestFileHandle *gfh,
+                                      int64_t count, Error **errp)
 {
     GuestFileRead *read_data =3D NULL;
     guchar *buf;
-    HANDLE fh;
+    HANDLE fh =3D gfh->fh;
     bool is_ok;
     DWORD read_count;
-    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
=20
-    if (!gfh) {
-        return NULL;
-    }
-    if (!has_count) {
-        count =3D QGA_READ_COUNT_DEFAULT;
-    } else if (count < 0 || count >=3D UINT32_MAX) {
-        error_setg(errp, "value '%" PRId64
-                   "' is invalid for argument count", count);
-        return NULL;
-    }
-
-    fh =3D gfh->fh;
     buf =3D g_malloc0(count + 1);
     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
-        slog("guest-file-read failed, handle %" PRId64, handle);
     } else {
         buf[read_count] =3D 0;
         read_data =3D g_new0(GuestFileRead, 1);
diff --git a/qga/commands.c b/qga/commands.c
index 4471a9f08d..8ee1244ebb 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -547,3 +547,28 @@ error:
     g_free(info);
     return NULL;
 }
+
+GuestFileRead *qmp_guest_file_read(int64_t handle, bool has_count,
+                                   int64_t count, Error **errp)
+{
+    GuestFileHandle *gfh =3D guest_file_handle_find(handle, errp);
+    GuestFileRead *read_data;
+
+    if (!gfh) {
+        return NULL;
+    }
+    if (!has_count) {
+        count =3D QGA_READ_COUNT_DEFAULT;
+    } else if (count < 0 || count >=3D UINT32_MAX) {
+        error_setg(errp, "value '%" PRId64 "' is invalid for argument coun=
t",
+                   count);
+        return NULL;
+    }
+
+    read_data =3D guest_file_read_unsafe(gfh, count, errp);
+    if (!read_data) {
+        slog("guest-file-write failed, handle: %" PRId64, handle);
+    }
+
+    return read_data;
+}
--=20
2.21.1


