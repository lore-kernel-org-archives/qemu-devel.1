Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6602CC2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:32:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356792072C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356792072C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qindel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7V8-0001kS-DH
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:32:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salvador@qindel.com>) id 1iv7U7-0000ml-C9
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salvador@qindel.com>) id 1iv7U5-0004di-JK
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:31:27 -0500
Received: from smtp.qindel.com ([89.140.90.34]:48475 helo=thor.qindel.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <salvador@qindel.com>)
 id 1iv7U5-0004Z8-8L; Fri, 24 Jan 2020 17:31:25 -0500
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id EF38E6068A;
 Fri, 24 Jan 2020 23:31:22 +0100 (CET)
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id 5nU1brbrjbIU; Fri, 24 Jan 2020 23:31:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id C1BE26068C;
 Fri, 24 Jan 2020 23:31:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at thor.qindel.com
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id HyoAS4yCBDCN; Fri, 24 Jan 2020 23:31:22 +0100 (CET)
Received: from freeso.my.domain (unknown [82.213.225.96])
 by thor.qindel.com (Postfix) with ESMTPSA id 3878E6068A;
 Fri, 24 Jan 2020 23:31:22 +0100 (CET)
From: salvador@qindel.com
To: qemu-devel@nongnu.org
Subject: [PATCH] bsd-user: improve support for sparc syscall flags
Date: Fri, 24 Jan 2020 23:31:18 +0100
Message-Id: <20200124223118.58596-1-salvador@qindel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <6cb0886b-2b28-6dd2-92d4-7b524a6b4bf7@qindel.com>
References: <6cb0886b-2b28-6dd2-92d4-7b524a6b4bf7@qindel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 89.140.90.34
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com,
 Salvador Fandino <salvador@qindel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Salvador Fandino <salvador@qindel.com>

Under sparc and sparc64, both NetBSD and OpenSSH use two bits of the
syscall number as flags. Until now, those bits where only supported
for sparc64 when emulating OpenBSD.

This patch extends support for syscall flags to the sparc architecture
and NetBSD emulation. It had allowed my to run simple NetBSD sparc
applications with qemu-sparc on a FreeBSD x64 machine.

The code supporting OpenBSD sparc and sparc64 emulation has been
refactored in order to make it simpler and similar to the new one for
NetBSD.

Signed-off-by: Salvador Fandino <salvador@qindel.com>
---
 bsd-user/main.c              | 66 +++++++++++++++++++++++-------------
 bsd-user/netbsd/syscall_nr.h | 52 ++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 23 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 770c2b267a..9158ecbc5c 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -491,7 +491,7 @@ static void flush_windows(CPUSPARCState *env)
 void cpu_loop(CPUSPARCState *env)
 {
     CPUState *cs =3D env_cpu(env);
-    int trapnr, ret, syscall_nr;
+    int trapnr, ret, syscall_nr, syscall_flags;
     //target_siginfo_t info;
=20
     while (1) {
@@ -511,21 +511,27 @@ void cpu_loop(CPUSPARCState *env)
         case 0x100:
 #endif
             syscall_nr =3D env->gregs[1];
-            if (bsd_type =3D=3D target_freebsd)
+            if (bsd_type =3D=3D target_freebsd) {
                 ret =3D do_freebsd_syscall(env, syscall_nr,
                                          env->regwptr[0], env->regwptr[1=
],
                                          env->regwptr[2], env->regwptr[3=
],
                                          env->regwptr[4], env->regwptr[5=
], 0, 0);
-            else if (bsd_type =3D=3D target_netbsd)
+            } else if (bsd_type =3D=3D target_netbsd) {
+                syscall_flags =3D syscall_nr & (TARGET_NETBSD_SYSCALL_G7=
RFLAG |
+                                              TARGET_NETBSD_SYSCALL_G5RF=
LAG |
+                                              TARGET_NETBSD_SYSCALL_G2RF=
LAG);
+                syscall_nr &=3D ~(TARGET_NETBSD_SYSCALL_G7RFLAG |
+                                TARGET_NETBSD_SYSCALL_G5RFLAG |
+                                TARGET_NETBSD_SYSCALL_G2RFLAG);
                 ret =3D do_netbsd_syscall(env, syscall_nr,
                                         env->regwptr[0], env->regwptr[1]=
,
                                         env->regwptr[2], env->regwptr[3]=
,
                                         env->regwptr[4], env->regwptr[5]=
);
-            else { //if (bsd_type =3D=3D target_openbsd)
-#if defined(TARGET_SPARC64)
-                syscall_nr &=3D ~(TARGET_OPENBSD_SYSCALL_G7RFLAG |
-                                TARGET_OPENBSD_SYSCALL_G2RFLAG);
-#endif
+            } else { //if (bsd_type =3D=3D target_openbsd)
+                syscall_flags =3D syscall_nr & (TARGET_OPENBSD_SYSCALL_G=
2RFLAG |
+                                              TARGET_OPENBSD_SYSCALL_G7R=
FLAG);
+                syscall_nr &=3D ~(TARGET_OPENBSD_SYSCALL_G2RFLAG |
+                                TARGET_OPENBSD_SYSCALL_G7RFLAG);
                 ret =3D do_openbsd_syscall(env, syscall_nr,
                                          env->regwptr[0], env->regwptr[1=
],
                                          env->regwptr[2], env->regwptr[3=
],
@@ -547,23 +553,37 @@ void cpu_loop(CPUSPARCState *env)
             }
             env->regwptr[0] =3D ret;
             /* next instruction */
-#if defined(TARGET_SPARC64)
-            if (bsd_type =3D=3D target_openbsd &&
-                env->gregs[1] & TARGET_OPENBSD_SYSCALL_G2RFLAG) {
-                env->pc =3D env->gregs[2];
-                env->npc =3D env->pc + 4;
-            } else if (bsd_type =3D=3D target_openbsd &&
-                       env->gregs[1] & TARGET_OPENBSD_SYSCALL_G7RFLAG) {
-                env->pc =3D env->gregs[7];
-                env->npc =3D env->pc + 4;
-            } else {
+            if (bsd_type =3D=3D target_openbsd) {
+                switch (syscall_flags) {
+                case 0:
+                    env->pc =3D env->npc;
+                    break;
+                case TARGET_OPENBSD_SYSCALL_G7RFLAG:
+                    env->pc =3D env->gregs[7];
+                    break;
+                default: /* G2 or G2|G7 */
+                    env->pc =3D env->gregs[2];
+                    break;
+                }
+            } else if (bsd_type =3D=3D target_netbsd) {
+                switch (syscall_flags) {
+                case 0:
+                    env->pc =3D env->npc;
+                    break;
+                case TARGET_NETBSD_SYSCALL_G7RFLAG:
+                    env->pc =3D env->gregs[7];
+                    break;
+                case TARGET_NETBSD_SYSCALL_G5RFLAG:
+                    env->pc =3D env->gregs[5];
+                    break;
+                case TARGET_NETBSD_SYSCALL_G2RFLAG:
+                    env->pc =3D env->gregs[2];
+                    break;
+                }
+            } else  {  //if (bsd_type =3D=3D target_freebsd)
                 env->pc =3D env->npc;
-                env->npc =3D env->npc + 4;
             }
-#else
-            env->pc =3D env->npc;
-            env->npc =3D env->npc + 4;
-#endif
+            env->npc =3D env->pc + 4;
             break;
         case 0x83: /* flush windows */
 #ifdef TARGET_ABI32
diff --git a/bsd-user/netbsd/syscall_nr.h b/bsd-user/netbsd/syscall_nr.h
index 2e9ab5378e..79022b0b4e 100644
--- a/bsd-user/netbsd/syscall_nr.h
+++ b/bsd-user/netbsd/syscall_nr.h
@@ -371,3 +371,55 @@
 #define TARGET_NETBSD_NR_pset_assign 414
 #define TARGET_NETBSD_NR__pset_bind  415
 #define TARGET_NETBSD_NR___posix_fadvise50   416
+
+/*	$NetBSD: trap.h,v 1.18 2011/03/27 18:47:08 martin Exp $ */
+
+/*
+ * Copyright (c) 1992, 1993
+ *	The Regents of the University of California.  All rights reserved.
+ *
+ * This software was developed by the Computer Systems Engineering group
+ * at Lawrence Berkeley Laboratory under DARPA contract BG 91-66 and
+ * contributed to Berkeley.
+ *
+ * All advertising materials mentioning features or use of this software
+ * must display the following acknowledgement:
+ *	This product includes software developed by the University of
+ *	California, Lawrence Berkeley Laboratory.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in th=
e
+ *    documentation and/or other materials provided with the distributio=
n.
+ * 3. Neither the name of the University nor the names of its contributo=
rs
+ *    may be used to endorse or promote products derived from this softw=
are
+ *    without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS'' A=
ND
+ * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PU=
RPOSE
+ * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIA=
BLE
+ * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUE=
NTIAL
+ * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOO=
DS
+ * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
+ * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, S=
TRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY=
 WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY O=
F
+ * SUCH DAMAGE.
+ *
+ *	@(#)trap.h	8.1 (Berkeley) 6/11/93
+ */
+/*
+ * Sun4m support by Aaron Brown, Harvard University.
+ * Changes Copyright (c) 1995 The President and Fellows of Harvard Colle=
ge.
+ * All rights reserved.
+ */
+
+/* flags to system call (flags in %g1 along with syscall number) */
+#define	TARGET_NETBSD_SYSCALL_G2RFLAG	0x400	/* on success, return to %g2=
 rather than npc */
+#define	TARGET_NETBSD_SYSCALL_G7RFLAG	0x800	/* use %g7 as above (depreca=
ted) */
+#define	TARGET_NETBSD_SYSCALL_G5RFLAG	0xc00	/* use %g5 as above (only AB=
I compatible way) */
--=20
2.24.1


