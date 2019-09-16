Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECCCC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B69912184D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMOU6mtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B69912184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9t9q-0001Hz-Kv
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCy-0006WQ-8R
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1i9sCv-0007UB-Oq
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45714)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1i9sCu-0007TP-VM
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 10:42:25 -0400
Received: by mail-wr1-x444.google.com with SMTP id r5so5213255wrm.12
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2019 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=15ASw7Sda32hAHbQApt0nrRp6KAHHCRUIPuWH1EYvBg=;
 b=OMOU6mtrfGuxY/0J7L+RmnKRgwzrrpCXLBu1CTTFUIFVF1eb0j3pD0cuxjpAhVyWJ1
 w/y/BRDuqD8UvJYB6FuQypcnZbma6V8Jwmzx5b4e9oKrF1UQPDUhwUqzQ7X87iH9L3m+
 QrzGSeVx5RuSIB1Q9qgehlSIZOeYJjC4DIZBuToDrX/Z03y0LW1Supn7p9wEV+Z3N7kf
 HWVbHwZihD5yZNvY+xradXxJkL1vePQSa3JXR75X3P7ytm6bHW5tVDjbiA2LzJsg2yRE
 am5Cby3z04DOgYRm3++Q6ecv0CgsoIz1lmqN0MhMbHPRBOVxrAmHW7qjrnkmh6mRiBHa
 kY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=15ASw7Sda32hAHbQApt0nrRp6KAHHCRUIPuWH1EYvBg=;
 b=DrJYvGzUauly16a2roQu5RYqnzSuUU+AJCr6wjDISCXneEJCrIOC5I5bEvkU3snZP8
 hChMN8HYW0YdbhJ+w9LBWHhyE5oR4yAM6E1ifbz9hdfHcOdMS0BVggMKMjlLeMeMv8Od
 Z+BFTAmLvw8nzuA0MWmRUzOx9pQ1cdqyWqKBSG8qRiVEdbcPnFEXdt4ffuTIQrl2tIes
 n6Coi80iW29reVnhPu18SzfMVga57crSU5bDIM2jPs59xmOurGzVUB0jOtq0XcR8z1nk
 9p6oOIG9bAtuag8B2+QdH7d64QCIlkbCoj/S2LaCDeEjcCwJVmQa7AdV68IiW5V0skq1
 lemA==
X-Gm-Message-State: APjAAAUBrr8anK6wBLwnoiROMt0kGPDXNpXJcn7wtjmFLS+Km9TZ35rz
 EIwC/oB4iAmn0eYJl4EEVs1j2LMY
X-Google-Smtp-Source: APXvYqw2adYeU9ECLXlFSIAwn/FLPlPa0xwiPidSvx5xC1vhMCYPmb/IE3hRwcpqudxOTAg1I24pQQ==
X-Received: by 2002:a5d:548d:: with SMTP id h13mr93168wrv.215.1568644943237;
 Mon, 16 Sep 2019 07:42:23 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i14sm17024298wra.78.2019.09.16.07.42.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Sep 2019 07:42:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 16:41:51 +0200
Message-Id: <1568644929-9124-12-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
References: <1568644929-9124-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PULL 11/29] memory: fetch pmem size in get_file_size()
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

Neither stat(2) nor lseek(2) report the size of Linux devdax pmem
character device nodes.  Commit 314aec4a6e06844937f1677f6cba21981005f389
("hostmem-file: reject invalid pmem file sizes") added code to
hostmem-file.c to fetch the size from sysfs and compare against the
user-provided size=NUM parameter:

  if (backend->size > size) {
      error_setg(errp, "size property %" PRIu64 " is larger than "
                 "pmem file \"%s\" size %" PRIu64, backend->size,
                 fb->mem_path, size);
      return;
  }

It turns out that exec.c:qemu_ram_alloc_from_fd() already has an
equivalent size check but it skips devdax pmem character devices because
lseek(2) returns 0:

  if (file_size > 0 && file_size < size) {
      error_setg(errp, "backing store %s size 0x%" PRIx64
                 " does not match 'size' option 0x" RAM_ADDR_FMT,
                 mem_path, file_size, size);
      return NULL;
  }

This patch moves the devdax pmem file size code into get_file_size() so
that we check the memory size in a single place:
qemu_ram_alloc_from_fd().  This simplifies the code and makes it more
general.

This also fixes the problem that hostmem-file only checks the devdax
pmem file size when the pmem=on parameter is given.  An unchecked
size=NUM parameter can lead to SIGBUS in QEMU so we must always fetch
the file size for Linux devdax pmem character device nodes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20190830093056.12572-1-stefanha@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/hostmem-file.c | 22 --------------------
 exec.c                  | 34 ++++++++++++++++++++++++++++++-
 include/qemu/osdep.h    | 13 ------------
 util/oslib-posix.c      | 54 -------------------------------------------------
 util/oslib-win32.c      |  6 ------
 5 files changed, 33 insertions(+), 96 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index ecc15e3..be64020 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -58,28 +58,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
-    /*
-     * Verify pmem file size since starting a guest with an incorrect size
-     * leads to confusing failures inside the guest.
-     */
-    if (fb->is_pmem) {
-        Error *local_err = NULL;
-        uint64_t size;
-
-        size = qemu_get_pmem_size(fb->mem_path, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            return;
-        }
-
-        if (size && backend->size > size) {
-            error_setg(errp, "size property %" PRIu64 " is larger than "
-                       "pmem file \"%s\" size %" PRIu64, backend->size,
-                       fb->mem_path, size);
-            return;
-        }
-    }
-
     backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
diff --git a/exec.c b/exec.c
index b9511be..8b99897 100644
--- a/exec.c
+++ b/exec.c
@@ -1791,7 +1791,39 @@ long qemu_maxrampagesize(void)
 #ifdef CONFIG_POSIX
 static int64_t get_file_size(int fd)
 {
-    int64_t size = lseek(fd, 0, SEEK_END);
+    int64_t size;
+#if defined(__linux__)
+    struct stat st;
+
+    if (fstat(fd, &st) < 0) {
+        return -errno;
+    }
+
+    /* Special handling for devdax character devices */
+    if (S_ISCHR(st.st_mode)) {
+        g_autofree char *subsystem_path = NULL;
+        g_autofree char *subsystem = NULL;
+
+        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
+                                         major(st.st_rdev), minor(st.st_rdev));
+        subsystem = g_file_read_link(subsystem_path, NULL);
+
+        if (subsystem && g_str_has_suffix(subsystem, "/dax")) {
+            g_autofree char *size_path = NULL;
+            g_autofree char *size_str = NULL;
+
+            size_path = g_strdup_printf("/sys/dev/char/%d:%d/size",
+                                    major(st.st_rdev), minor(st.st_rdev));
+
+            if (g_file_get_contents(size_path, &size_str, NULL, NULL)) {
+                return g_ascii_strtoll(size_str, NULL, 0);
+            }
+        }
+    }
+#endif /* defined(__linux__) */
+
+    /* st.st_size may be zero for special files yet lseek(2) works */
+    size = lseek(fd, 0, SEEK_END);
     if (size < 0) {
         return -errno;
     }
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index af2b91f..c7d242f 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -571,19 +571,6 @@ void os_mem_prealloc(int fd, char *area, size_t sz, int smp_cpus,
                      Error **errp);
 
 /**
- * qemu_get_pmem_size:
- * @filename: path to a pmem file
- * @errp: pointer to a NULL-initialized error object
- *
- * Determine the size of a persistent memory file.  Besides supporting files on
- * DAX file systems, this function also supports Linux devdax character
- * devices.
- *
- * Returns: the size or 0 on failure
- */
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp);
-
-/**
  * qemu_get_pid_name:
  * @pid: pid of a process
  *
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 5fda67d..f869338 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -514,60 +514,6 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     }
 }
 
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
-{
-    struct stat st;
-
-    if (stat(filename, &st) < 0) {
-        error_setg(errp, "unable to stat pmem file \"%s\"", filename);
-        return 0;
-    }
-
-#if defined(__linux__)
-    /* Special handling for devdax character devices */
-    if (S_ISCHR(st.st_mode)) {
-        char *subsystem_path = NULL;
-        char *subsystem = NULL;
-        char *size_path = NULL;
-        char *size_str = NULL;
-        uint64_t ret = 0;
-
-        subsystem_path = g_strdup_printf("/sys/dev/char/%d:%d/subsystem",
-                                         major(st.st_rdev), minor(st.st_rdev));
-        subsystem = g_file_read_link(subsystem_path, NULL);
-        if (!subsystem) {
-            error_setg(errp, "unable to read subsystem for pmem file \"%s\"",
-                       filename);
-            goto devdax_err;
-        }
-
-        if (!g_str_has_suffix(subsystem, "/dax")) {
-            error_setg(errp, "pmem file \"%s\" is not a dax device", filename);
-            goto devdax_err;
-        }
-
-        size_path = g_strdup_printf("/sys/dev/char/%d:%d/size",
-                                    major(st.st_rdev), minor(st.st_rdev));
-        if (!g_file_get_contents(size_path, &size_str, NULL, NULL)) {
-            error_setg(errp, "unable to read size for pmem file \"%s\"",
-                       size_path);
-            goto devdax_err;
-        }
-
-        ret = g_ascii_strtoull(size_str, NULL, 0);
-
-devdax_err:
-        g_free(size_str);
-        g_free(size_path);
-        g_free(subsystem);
-        g_free(subsystem_path);
-        return ret;
-    }
-#endif /* defined(__linux__) */
-
-    return st.st_size;
-}
-
 char *qemu_get_pid_name(pid_t pid)
 {
     char *name = NULL;
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 9583fb4..c62cd43 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -562,12 +562,6 @@ void os_mem_prealloc(int fd, char *area, size_t memory, int smp_cpus,
     }
 }
 
-uint64_t qemu_get_pmem_size(const char *filename, Error **errp)
-{
-    error_setg(errp, "pmem support not available");
-    return 0;
-}
-
 char *qemu_get_pid_name(pid_t pid)
 {
     /* XXX Implement me */
-- 
1.8.3.1



