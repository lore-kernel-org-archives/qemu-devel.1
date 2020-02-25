Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC274C35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C7D2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 12:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5C26D8Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C7D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6ZWS-0000JA-Or
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 07:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YlA-0001VD-Do
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yl8-0000gj-Lm
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:20 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yl8-0000dC-ER
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:52:18 -0500
Received: by mail-wm1-x333.google.com with SMTP id p9so2681774wmc.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=H+NtmYvujHnGZaCoxQXDpIcsQU+NXFCxY8uniwREKRo=;
 b=K5C26D8Q6smDKHjQUGXv+poft91PvX0b50gUE2xvVWNaOAOneCYSKzRgEObVCcrg8o
 CnMZ5huo39M9rM5BN0hldCONDjRtyMueeFl9UoaszKD5v7YTpjMs3lF5zYbMZnrxKrVF
 wcClWVvXPC/CPRc+i5uX1Lk4UjnoNrWjDFEvhQnnR2Wvcc9Rt8ds7AYs1Mo6iKWY7+q8
 I/s8G6JHI57Xi4mF6DmZKIdI1UNzPgae5W0QkQlT26tFV2aIxMgrtWnvsU16RnYgHt39
 pqa6+L2uCI7xt26Tms5WXaWHRhoV550vrEf63mnIOc7H8zhth6VxP8AVpx7A4B7Cfson
 2fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=H+NtmYvujHnGZaCoxQXDpIcsQU+NXFCxY8uniwREKRo=;
 b=f1AUcYuvasAtyWY1y9vfhBY7/Esz5Qt3QbTYLmPsy7eGClNL3k0buj6TC13xZK0dz8
 BendcslBrkuWchZ4S0/mszQD4UM2bUnTXU736//TryiLrkWpf+lmII5i25J9+V0Dgzpm
 Tmlv8S54ORBd9Bc4HKE7orlNIWcYhwbacoj/HVYZ0N89xkcYq6Tpit8NGGuGXYYwIo3e
 AWr0qbmmN7VMda6UoOAClOo/RRHv0OH2d0l0tBVxL7F65WJWEVyIhWpvsuaKPw8krUCP
 in8ldXj3PEXWlj+lXJoB5LzAU1iO0NG4LZKm+tw2CeYx5kQi38iZPWT2tc6kohDXZ/TK
 oi0g==
X-Gm-Message-State: APjAAAXvt8XItdpwG1tvr/mLa1urxV9PjAeM7Um9lQpCL36iUd2ihGW4
 LAB4u4+v282rFHP8hDTjXw8i8Nrf
X-Google-Smtp-Source: APXvYqxwbb3Jnauy8wVtIHYlhLqFjvsLE0byN20E+9rDOrbkrobtgHRzMKkWu9lBoffYzm+2nqjKPQ==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr4849370wml.71.1582631537168; 
 Tue, 25 Feb 2020 03:52:17 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.52.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:52:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 077/136] hostmem: fix strict bind policy
Date: Tue, 25 Feb 2020 12:50:07 +0100
Message-Id: <1582631466-13880-77-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

When option -mem-prealloc is used with one or more memory-backend
objects, created backends may not obey configured bind policy or
creation may fail after kernel attempts to move pages according
to bind policy.
Reason is in file_ram_alloc(), which will pre-allocate
any descriptor based RAM if global mem_prealloc != 0 and that
happens way before bind policy is applied to memory range.

One way to fix it would be to extend memory_region_foo() API
and add more invariants that could broken later due implicit
dependencies that's hard to track.

Another approach is to drop adhoc main RAM allocation and
consolidate it around memory-backend. That allows to have
single place that allocates guest RAM (main and memdev)
in the same way and then global mem_prealloc could be
replaced by backend's property[s] that will affect created
memory-backend objects but only in correct order this time.

With main RAM now converted to hostmem backends, there is no
point in keeping global mem_prealloc around, so alias
 -mem-prealloc to "memory-backend.prealloc=on"
machine compat[*] property and make mem_prealloc a local
variable to only stir registration of compat property.

*) currently user accessible -global works only with DEVICE
   based objects and extra work is needed to make it work
   with hostmem backends. But that is convenience option
   and out of scope of this already huge refactoring.
   Hence machine compat properties were used.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200219160953.13771-78-imammedo@redhat.com>
---
 backends/hostmem-file.c  |  1 -
 backends/hostmem-memfd.c |  1 -
 backends/hostmem.c       | 12 +-----------
 exec.c                   | 11 -----------
 include/sysemu/hostmem.h |  2 +-
 include/sysemu/sysemu.h  |  1 -
 vl.c                     |  3 ++-
 7 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/backends/hostmem-file.c b/backends/hostmem-file.c
index cb319a9..c8c355f 100644
--- a/backends/hostmem-file.c
+++ b/backends/hostmem-file.c
@@ -51,7 +51,6 @@ file_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
-    backend->force_prealloc = mem_prealloc;
     name = host_memory_backend_get_name(backend);
     memory_region_init_ram_from_file(&backend->mr, OBJECT(backend),
                                      name,
diff --git a/backends/hostmem-memfd.c b/backends/hostmem-memfd.c
index 26070b4..74ba987 100644
--- a/backends/hostmem-memfd.c
+++ b/backends/hostmem-memfd.c
@@ -45,7 +45,6 @@ memfd_backend_memory_alloc(HostMemoryBackend *backend, Error **errp)
         return;
     }
 
-    backend->force_prealloc = mem_prealloc;
     fd = qemu_memfd_create(TYPE_MEMORY_BACKEND_MEMFD, backend->size,
                            m->hugetlb, m->hugetlbsize, m->seal ?
                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL : 0,
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 0988986..a70867b 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -215,7 +215,7 @@ static bool host_memory_backend_get_prealloc(Object *obj, Error **errp)
 {
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
-    return backend->prealloc || backend->force_prealloc;
+    return backend->prealloc;
 }
 
 static void host_memory_backend_set_prealloc(Object *obj, bool value,
@@ -224,14 +224,6 @@ static void host_memory_backend_set_prealloc(Object *obj, bool value,
     Error *local_err = NULL;
     HostMemoryBackend *backend = MEMORY_BACKEND(obj);
 
-    if (backend->force_prealloc) {
-        if (value) {
-            error_setg(errp,
-                       "remove -mem-prealloc to use the prealloc property");
-            return;
-        }
-    }
-
     if (!host_memory_backend_mr_inited(backend)) {
         backend->prealloc = value;
         return;
@@ -288,8 +280,6 @@ static void host_memory_backend_init(Object *obj)
     /* TODO: convert access to globals to compat properties */
     backend->merge = machine_mem_merge(machine);
     backend->dump = machine_dump_guest_core(machine);
-    backend->prealloc = mem_prealloc;
-    backend->prealloc_threads = 1;
 }
 
 static void host_memory_backend_post_init(Object *obj)
diff --git a/exec.c b/exec.c
index 6ebff8b..8c0258a 100644
--- a/exec.c
+++ b/exec.c
@@ -1801,8 +1801,6 @@ static void *file_ram_alloc(RAMBlock *block,
                             bool truncate,
                             Error **errp)
 {
-    Error *err = NULL;
-    MachineState *ms = MACHINE(qdev_get_machine());
     void *area;
 
     block->page_size = qemu_fd_getpagesize(fd);
@@ -1858,15 +1856,6 @@ static void *file_ram_alloc(RAMBlock *block,
         return NULL;
     }
 
-    if (mem_prealloc) {
-        os_mem_prealloc(fd, area, memory, ms->smp.cpus, &err);
-        if (err) {
-            error_propagate(errp, err);
-            qemu_ram_munmap(fd, area, memory);
-            return NULL;
-        }
-    }
-
     block->fd = fd;
     return area;
 }
diff --git a/include/sysemu/hostmem.h b/include/sysemu/hostmem.h
index bdf8666..8276e53 100644
--- a/include/sysemu/hostmem.h
+++ b/include/sysemu/hostmem.h
@@ -70,7 +70,7 @@ struct HostMemoryBackend {
     /* protected */
     uint64_t size;
     bool merge, dump, use_canonical_path;
-    bool prealloc, force_prealloc, is_mapped, share;
+    bool prealloc, is_mapped, share;
     uint32_t prealloc_threads;
     DECLARE_BITMAP(host_nodes, MAX_NODES + 1);
     HostMemPolicy policy;
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index ae78b2a..55bdd57 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -50,7 +50,6 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
-extern int mem_prealloc;
 
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/vl.c b/vl.c
index afc682e..54857f7 100644
--- a/vl.c
+++ b/vl.c
@@ -140,7 +140,6 @@ enum vga_retrace_method vga_retrace_method = VGA_RETRACE_DUMB;
 int display_opengl;
 const char* keyboard_layout = NULL;
 ram_addr_t ram_size;
-int mem_prealloc = 0; /* force preallocation of physical target memory */
 bool enable_mlock = false;
 bool enable_cpu_pm = false;
 int nb_nics;
@@ -2883,6 +2882,7 @@ int main(int argc, char **argv, char **envp)
     const char *mem_path = NULL;
     BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
+    int mem_prealloc = 0; /* force preallocation of physical target memory */
 
     os_set_line_buffering();
 
@@ -3984,6 +3984,7 @@ int main(int argc, char **argv, char **envp)
         val = g_strdup_printf("%d", current_machine->smp.cpus);
         object_register_sugar_prop("memory-backend", "prealloc-threads", val);
         g_free(val);
+        object_register_sugar_prop("memory-backend", "prealloc", "on");
     }
 
     /*
-- 
1.8.3.1



