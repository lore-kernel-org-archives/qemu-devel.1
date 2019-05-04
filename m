Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2830C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66A92206DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJF5BpXM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A92206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55665 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMtRv-0008Ix-8A
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 08:07:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ9-000792-2H
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hMtQ6-0001C6-Tj
	for qemu-devel@nongnu.org; Sat, 04 May 2019 08:05:36 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:41296)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hMtQ6-0001BM-HE; Sat, 04 May 2019 08:05:34 -0400
Received: by mail-ot1-x330.google.com with SMTP id g8so7624690otl.8;
	Sat, 04 May 2019 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=pmZJgq4sgMXP9qHYEfxrgn9xoXzv+P55K0/VCJX3rj4=;
	b=eJF5BpXMrgWoO8/CcxRFeGVCJLQXnvspWD8+IbqaS8DA5XMPCRmxHhNeTkegwhr0d0
	g0cfu2yfrx1muxQqq5aJbYa8lHeZiz416kzLBRv23fEOvIJTNMQd7B6NdXdPw1YV+ngg
	n2k9A4BV4bZJ9Ki3gUHQYWQdgzdNjCNX9EYF9g+7H45RDqQLG8ypWq7BSmdOM6ErSJpX
	uebJHdvZqd5g3dPpQ0uVpPebXFDTMhj1BPWtf9fr/sQdV+YcqHbep5KaAzZ06UlvS2Do
	RhEqf+C4hOR0ytCtQiL5MzV6Ya17M3KfOq9XpEZA4qBTOyQKBl4eyWMp6G9BB3zotxUO
	IEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	bh=pmZJgq4sgMXP9qHYEfxrgn9xoXzv+P55K0/VCJX3rj4=;
	b=HDepH0WIK3elGuNTPks+CnTvyfwtw85UFSHqmnw1h33smpZJJ9omrHHI9WKD3CqUhj
	nBYBJ45jq4S9mkDlFuLUQn9T4HocySinF/jjG+mbkQ/kTrOdvuEQrC6ipxnAgTL201W1
	ceqNANPpo6iROUzsvmb4QdOTiVO5nrVoFswuKp6ND+9GgNjss7smNdyG+1Zifr5whx/P
	sKcsoQbc0PaMkK9SgHUHh6kLbrWqb4tMECxZKHwM+a8+5qlP/qlUuiDthl6Nr1vDVABd
	Cxox+o3Hr4B5iym4uHDzhBO81Xr8YJ76LKINmX1z8hrFcIN9VKilPD4BNkpZns2v4RbV
	tFvA==
X-Gm-Message-State: APjAAAWry7HC1mYxbYnBbnGojneqXKhE403Qs1pC+COsceVP7VcG5fmd
	NKMcAd5HW1Y6c+TMDa0If8AZIuo3
X-Google-Smtp-Source: APXvYqwGdiOQa1jDHcPHGwZBGeKDoOqm6JKnguYPiYDm2NeNqwqnd9MjsZFphMkhn9LfTQahaqFVTA==
X-Received: by 2002:a05:6830:2106:: with SMTP id
	i6mr9763319otc.146.1556971531677; 
	Sat, 04 May 2019 05:05:31 -0700 (PDT)
Received: from localhost.localdomain ([198.59.53.9])
	by smtp.gmail.com with ESMTPSA id
	s26sm1844978otk.24.2019.05.04.05.05.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 04 May 2019 05:05:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 06:05:19 -0600
Message-Id: <20190504120528.6389-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190504120528.6389-1-pbonzini@redhat.com>
References: <20190504120528.6389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::330
Subject: [Qemu-devel] [PATCH 1/9] qemugdb: allow adding support for other
 coroutine backends
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, cohuck@redhat.com, richard.henderson@linaro.org,
	qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504120519.VgwTVSHDXxxso0qlca4VWt2LbVhFMw0sidJvdYtazsw@z>

Split the jmpbuf access to a separate module and dispatch based
on which CoroutineXYZ type is defined.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qemugdb/coroutine.py          | 106 ++++++++------------------
 scripts/qemugdb/coroutine_ucontext.py |  69 +++++++++++++++++
 2 files changed, 100 insertions(+), 75 deletions(-)
 create mode 100644 scripts/qemugdb/coroutine_ucontext.py

diff --git a/scripts/qemugdb/coroutine.py b/scripts/qemugdb/coroutine.py
index 41e079d0e2..db2753d949 100644
--- a/scripts/qemugdb/coroutine.py
+++ b/scripts/qemugdb/coroutine.py
@@ -1,6 +1,6 @@
 #!/usr/bin/python
 
-# GDB debugging support
+# GDB debugging support, coroutine dispatch
 #
 # Copyright 2012 Red Hat, Inc. and/or its affiliates
 #
@@ -10,82 +10,25 @@
 # This work is licensed under the terms of the GNU GPL, version 2
 # or later.  See the COPYING file in the top-level directory.
 
+from . import coroutine_ucontext
 import gdb
 
 VOID_PTR = gdb.lookup_type('void').pointer()
+UINTPTR_T = gdb.lookup_type('uintptr_t')
 
-def get_fs_base():
-    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
-       pthread_self().'''
-    # %rsp - 120 is scratch space according to the SystemV ABI
-    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
-    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
-    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
-    return fs_base
-
-def pthread_self():
-    '''Fetch pthread_self() from the glibc start_thread function.'''
-    f = gdb.newest_frame()
-    while f.name() != 'start_thread':
-        f = f.older()
-        if f is None:
-            return get_fs_base()
-
-    try:
-        return f.read_var("arg")
-    except ValueError:
-        return get_fs_base()
-
-def get_glibc_pointer_guard():
-    '''Fetch glibc pointer guard value'''
-    fs_base = pthread_self()
-    return gdb.parse_and_eval('*(uint64_t*)((uint64_t)%s + 0x30)' % fs_base)
-
-def glibc_ptr_demangle(val, pointer_guard):
-    '''Undo effect of glibc's PTR_MANGLE()'''
-    return gdb.parse_and_eval('(((uint64_t)%s >> 0x11) | ((uint64_t)%s << (64 - 0x11))) ^ (uint64_t)%s' % (val, val, pointer_guard))
-
-def get_jmpbuf_regs(jmpbuf):
-    JB_RBX  = 0
-    JB_RBP  = 1
-    JB_R12  = 2
-    JB_R13  = 3
-    JB_R14  = 4
-    JB_R15  = 5
-    JB_RSP  = 6
-    JB_PC   = 7
-
-    pointer_guard = get_glibc_pointer_guard()
-    return {'rbx': jmpbuf[JB_RBX],
-        'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
-        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
-        'r12': jmpbuf[JB_R12],
-        'r13': jmpbuf[JB_R13],
-        'r14': jmpbuf[JB_R14],
-        'r15': jmpbuf[JB_R15],
-        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
-
-def bt_jmpbuf(jmpbuf):
-    '''Backtrace a jmpbuf'''
-    regs = get_jmpbuf_regs(jmpbuf)
-    old = dict()
-
-    for i in regs:
-        old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, regs[i]))
-
-    gdb.execute('bt')
-
-    for i in regs:
-        gdb.execute('set $%s = %s' % (i, old[i]))
-
-def coroutine_to_jmpbuf(co):
-    coroutine_pointer = co.cast(gdb.lookup_type('CoroutineUContext').pointer())
-    return coroutine_pointer['env']['__jmpbuf']
+backends = {
+    'CoroutineUContext': coroutine_ucontext
+}
 
+def coroutine_backend():
+    for k, v in backends.items():
+        try:
+            gdb.lookup_type(k)
+        except:
+            continue
+        return v
+
+    raise Exception('could not find coroutine backend')
 
 class CoroutineCommand(gdb.Command):
     '''Display coroutine backtrace'''
@@ -99,18 +42,31 @@ class CoroutineCommand(gdb.Command):
             gdb.write('usage: qemu coroutine <coroutine-pointer>\n')
             return
 
-        bt_jmpbuf(coroutine_to_jmpbuf(gdb.parse_and_eval(argv[0])))
+        addr = gdb.parse_and_eval(argv[0])
+        regs = coroutine_backend().get_coroutine_regs(addr)
+        old = dict()
+
+        for i in regs:
+            old[i] = gdb.parse_and_eval('(uint64_t)$%s' % i)
+
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, regs[i].cast(UINTPTR_T)))
+
+        gdb.execute('bt')
+
+        for i in regs:
+            gdb.execute('set $%s = %s' % (i, old[i].cast(UINTPTR_T)))
 
 class CoroutineSPFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_sp')
 
     def invoke(self, addr):
-        return get_jmpbuf_regs(coroutine_to_jmpbuf(addr))['rsp'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['rsp'].cast(VOID_PTR)
 
 class CoroutinePCFunction(gdb.Function):
     def __init__(self):
         gdb.Function.__init__(self, 'qemu_coroutine_pc')
 
     def invoke(self, addr):
-        return get_jmpbuf_regs(coroutine_to_jmpbuf(addr))['rip'].cast(VOID_PTR)
+        return coroutine_backend().get_coroutine_regs(addr)['rip'].cast(VOID_PTR)
diff --git a/scripts/qemugdb/coroutine_ucontext.py b/scripts/qemugdb/coroutine_ucontext.py
new file mode 100644
index 0000000000..a2f8c1dbbf
--- /dev/null
+++ b/scripts/qemugdb/coroutine_ucontext.py
@@ -0,0 +1,69 @@
+#!/usr/bin/python
+
+# GDB debugging support
+#
+# Copyright 2012 Red Hat, Inc. and/or its affiliates
+#
+# Authors:
+#  Avi Kivity <avi@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import gdb
+
+def get_fs_base():
+    '''Fetch %fs base value using arch_prctl(ARCH_GET_FS).  This is
+       pthread_self().'''
+    # %rsp - 120 is scratch space according to the SystemV ABI
+    old = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
+    gdb.execute('call (int)arch_prctl(0x1003, $rsp - 120)', False, True)
+    fs_base = gdb.parse_and_eval('*(uint64_t*)($rsp - 120)')
+    gdb.execute('set *(uint64_t*)($rsp - 120) = %s' % old, False, True)
+    return fs_base
+
+def pthread_self():
+    '''Fetch pthread_self() from the glibc start_thread function.'''
+    f = gdb.newest_frame()
+    while f.name() != 'start_thread':
+        f = f.older()
+        if f is None:
+            return get_fs_base()
+
+    try:
+        return f.read_var("arg")
+    except ValueError:
+        return get_fs_base()
+
+def get_glibc_pointer_guard():
+    '''Fetch glibc pointer guard value'''
+    fs_base = pthread_self()
+    return gdb.parse_and_eval('*(uint64_t*)((uint64_t)%s + 0x30)' % fs_base)
+
+def glibc_ptr_demangle(val, pointer_guard):
+    '''Undo effect of glibc's PTR_MANGLE()'''
+    return gdb.parse_and_eval('(((uint64_t)%s >> 0x11) | ((uint64_t)%s << (64 - 0x11))) ^ (uint64_t)%s' % (val, val, pointer_guard))
+
+def get_jmpbuf_regs(jmpbuf):
+    JB_RBX  = 0
+    JB_RBP  = 1
+    JB_R12  = 2
+    JB_R13  = 3
+    JB_R14  = 4
+    JB_R15  = 5
+    JB_RSP  = 6
+    JB_PC   = 7
+
+    pointer_guard = get_glibc_pointer_guard()
+    return {'rbx': jmpbuf[JB_RBX],
+        'rbp': glibc_ptr_demangle(jmpbuf[JB_RBP], pointer_guard),
+        'rsp': glibc_ptr_demangle(jmpbuf[JB_RSP], pointer_guard),
+        'r12': jmpbuf[JB_R12],
+        'r13': jmpbuf[JB_R13],
+        'r14': jmpbuf[JB_R14],
+        'r15': jmpbuf[JB_R15],
+        'rip': glibc_ptr_demangle(jmpbuf[JB_PC], pointer_guard) }
+
+def get_coroutine_regs(addr):
+    co = addr.cast(gdb.lookup_type('CoroutineUContext').pointer())
+    return get_jmpbuf_regs(co['env']['__jmpbuf'])
-- 
2.21.0



