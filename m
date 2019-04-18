Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEAEC10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:43:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD19F214DA
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 20:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD19F214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHDsS-0000MQ-1t
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 16:43:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnx-0001J4-41
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHDnv-0002du-N0
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHDnv-0002c1-Ei
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:38:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51856883BA
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EFC5E1001DC5
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:38:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 7CB791132B74; Thu, 18 Apr 2019 22:38:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Apr 2019 22:38:35 +0200
Message-Id: <20190418203840.10528-5-armbru@redhat.com>
In-Reply-To: <20190418203840.10528-1-armbru@redhat.com>
References: <20190418203840.10528-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 18 Apr 2019 20:38:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL for-4.1 4/9] linux-user/nios2 linux-user/riscv:
 Clean up header guards
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418203835.h364mOw6YUpN-YEckfPMk2zICwetOqP12uFTSd6Yr0k@z>

Reuse of the same guard symbol in multiple headers is okay as long as
they cannot be included together.  scripts/clean-header-guards.pl
can't tell, so it warns.

Since we can avoid guard symbol reuse easily, do so: use guard symbol
${target^^}_${fname^^} for linux-user/$target/$fname, just like we did
in commit a9c94277f0..3500385697.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190315145123.28030-4-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 linux-user/nios2/target_cpu.h     | 4 ++--
 linux-user/nios2/target_signal.h  | 6 +++---
 linux-user/nios2/target_structs.h | 4 ++--
 linux-user/nios2/target_syscall.h | 6 +++---
 linux-user/riscv/target_cpu.h     | 4 ++--
 linux-user/riscv/target_signal.h  | 6 +++---
 linux-user/riscv/target_structs.h | 4 ++--
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/linux-user/nios2/target_cpu.h b/linux-user/nios2/target_cpu.=
h
index 14f63338fa..5596c05c9c 100644
--- a/linux-user/nios2/target_cpu.h
+++ b/linux-user/nios2/target_cpu.h
@@ -17,8 +17,8 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
=20
-#ifndef TARGET_CPU_H
-#define TARGET_CPU_H
+#ifndef NIOS2_TARGET_CPU_H
+#define NIOS2_TARGET_CPU_H
=20
 static inline void cpu_clone_regs(CPUNios2State *env, target_ulong newsp=
)
 {
diff --git a/linux-user/nios2/target_signal.h b/linux-user/nios2/target_s=
ignal.h
index 7776bcdbfd..fe48721b3d 100644
--- a/linux-user/nios2/target_signal.h
+++ b/linux-user/nios2/target_signal.h
@@ -1,5 +1,5 @@
-#ifndef TARGET_SIGNAL_H
-#define TARGET_SIGNAL_H
+#ifndef NIOS2_TARGET_SIGNAL_H
+#define NIOS2_TARGET_SIGNAL_H
=20
 /* this struct defines a stack used during syscall handling */
=20
@@ -18,4 +18,4 @@ typedef struct target_sigaltstack {
=20
 #include "../generic/signal.h"
=20
-#endif /* TARGET_SIGNAL_H */
+#endif /* NIOS2_TARGET_SIGNAL_H */
diff --git a/linux-user/nios2/target_structs.h b/linux-user/nios2/target_=
structs.h
index 8713772089..7145251706 100644
--- a/linux-user/nios2/target_structs.h
+++ b/linux-user/nios2/target_structs.h
@@ -16,8 +16,8 @@
  * You should have received a copy of the GNU Lesser General Public
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
-#ifndef TARGET_STRUCTS_H
-#define TARGET_STRUCTS_H
+#ifndef NIOS2_TARGET_STRUCTS_H
+#define NIOS2_TARGET_STRUCTS_H
=20
 struct target_ipc_perm {
     abi_int __key;                      /* Key.  */
diff --git a/linux-user/nios2/target_syscall.h b/linux-user/nios2/target_=
syscall.h
index ca6b7e69f6..f3b2a500f4 100644
--- a/linux-user/nios2/target_syscall.h
+++ b/linux-user/nios2/target_syscall.h
@@ -1,5 +1,5 @@
-#ifndef TARGET_SYSCALL_H
-#define TARGET_SYSCALL_H
+#ifndef NIOS2_TARGET_SYSCALL_H
+#define NIOS2_TARGET_SYSCALL_H
=20
 #define UNAME_MACHINE "nios2"
 #define UNAME_MINIMUM_RELEASE "3.19.0"
@@ -34,4 +34,4 @@ struct target_pt_regs {
 #define TARGET_MLOCKALL_MCL_CURRENT 1
 #define TARGET_MLOCKALL_MCL_FUTURE  2
=20
-#endif  /* TARGET_SYSCALL_H */
+#endif /* NIOS2_TARGET_SYSCALL_H */
diff --git a/linux-user/riscv/target_cpu.h b/linux-user/riscv/target_cpu.=
h
index 7e090f376a..90f9a4171e 100644
--- a/linux-user/riscv/target_cpu.h
+++ b/linux-user/riscv/target_cpu.h
@@ -1,5 +1,5 @@
-#ifndef TARGET_CPU_H
-#define TARGET_CPU_H
+#ifndef RISCV_TARGET_CPU_H
+#define RISCV_TARGET_CPU_H
=20
 static inline void cpu_clone_regs(CPURISCVState *env, target_ulong newsp=
)
 {
diff --git a/linux-user/riscv/target_signal.h b/linux-user/riscv/target_s=
ignal.h
index c8b1455800..f113ba9a55 100644
--- a/linux-user/riscv/target_signal.h
+++ b/linux-user/riscv/target_signal.h
@@ -1,5 +1,5 @@
-#ifndef TARGET_SIGNAL_H
-#define TARGET_SIGNAL_H
+#ifndef RISCV_TARGET_SIGNAL_H
+#define RISCV_TARGET_SIGNAL_H
=20
 typedef struct target_sigaltstack {
     abi_ulong ss_sp;
@@ -15,4 +15,4 @@ typedef struct target_sigaltstack {
=20
 #include "../generic/signal.h"
=20
-#endif /* TARGET_SIGNAL_H */
+#endif /* RISCV_TARGET_SIGNAL_H */
diff --git a/linux-user/riscv/target_structs.h b/linux-user/riscv/target_=
structs.h
index 4f0462c497..ea3e5ed17e 100644
--- a/linux-user/riscv/target_structs.h
+++ b/linux-user/riscv/target_structs.h
@@ -4,8 +4,8 @@
  * This is a copy of ../aarch64/target_structs.h atm.
  *
  */
-#ifndef TARGET_STRUCTS_H
-#define TARGET_STRUCTS_H
+#ifndef RISCV_TARGET_STRUCTS_H
+#define RISCV_TARGET_STRUCTS_H
=20
 struct target_ipc_perm {
     abi_int __key;                      /* Key.  */
--=20
2.17.2


