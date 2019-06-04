Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A83C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7898B207E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 18:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7898B207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYE0u-0000r8-Mx
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 14:18:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDz1-00089X-CN
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYDz0-000317-25
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYDyz-00030d-Qk
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 14:16:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A7572F8BDE
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C4E225B68D
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 18:16:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 3DE3511386A7; Tue,  4 Jun 2019 20:16:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 20:16:17 +0200
Message-Id: <20190604181618.19980-4-armbru@redhat.com>
In-Reply-To: <20190604181618.19980-1-armbru@redhat.com>
References: <20190604181618.19980-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Tue, 04 Jun 2019 18:16:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/4] Clean up a few header guard symbols
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

Commit 58ea30f5145 "Clean up header guards that don't match their file
name" messed up contrib/elf2dmp/qemu_elf.h and
tests/migration/migration-test.h.

It missed target/cris/opcode-cris.h and
tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.h
due to the scripts/clean-header-guards.pl bug fixed in the previous
commit.

Commit a8b991b52dc "Clean up ill-advised or unusual header guards"
missed include/hw/xen/io/ring.h for the same reason.

Commit 3979fca4b69 "disas: Rename include/disas/bfd.h back to
include/disas/dis-asm.h" neglected to update the guard symbol for the
rename.

Commit a331c6d7741 "semihosting: implement a semihosting console"
created include/hw/semihosting/console.h with an ill-advised guard
symbol.

Clean them up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 contrib/elf2dmp/qemu_elf.h                                  | 5 ++---
 include/disas/dis-asm.h                                     | 6 +++---
 include/hw/semihosting/console.h                            | 6 +++---
 include/hw/xen/io/ring.h                                    | 6 +++---
 target/cris/opcode-cris.h                                   | 6 +++---
 tests/migration/migration-test.h                            | 2 +-
 .../UefiTestToolsPkg/Include/Guid/BiosTablesTest.h          | 6 +++---
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
index 66ee1f0ed5..b2f0d9cbc9 100644
--- a/contrib/elf2dmp/qemu_elf.h
+++ b/contrib/elf2dmp/qemu_elf.h
@@ -2,11 +2,10 @@
  * Copyright (c) 2018 Virtuozzo International GmbH
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
- *
  */
=20
-#ifndef EMPF2DMP_QEMU_ELF_H
-#define EMPF2DMP_QEMU_ELF_H
+#ifndef ELF2DMP_QEMU_ELF_H
+#define ELF2DMP_QEMU_ELF_H
=20
 #include "elf.h"
=20
diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 9240ec32c2..e9c7dd8eb4 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -6,8 +6,8 @@
    interface, for making instruction-processing programs more independen=
t
    of the instruction set being processed.  */
=20
-#ifndef DISAS_BFD_H
-#define DISAS_BFD_H
+#ifndef DISAS_DIS_ASM_H
+#define DISAS_DIS_ASM_H
=20
 typedef void *PTR;
 typedef uint64_t bfd_vma;
@@ -508,4 +508,4 @@ bfd_vma bfd_getl16 (const bfd_byte *addr);
 bfd_vma bfd_getb16 (const bfd_byte *addr);
 typedef bool bfd_boolean;
=20
-#endif /* DISAS_BFD_H */
+#endif /* DISAS_DIS_ASM_H */
diff --git a/include/hw/semihosting/console.h b/include/hw/semihosting/co=
nsole.h
index 30e66ae20a..9eb45b7c53 100644
--- a/include/hw/semihosting/console.h
+++ b/include/hw/semihosting/console.h
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
=20
-#ifndef _SEMIHOST_CONSOLE_H_
-#define _SEMIHOST_CONSOLE_H_
+#ifndef SEMIHOST_CONSOLE_H
+#define SEMIHOST_CONSOLE_H
=20
 /**
  * qemu_semihosting_console_out:
@@ -35,4 +35,4 @@ int qemu_semihosting_console_out(CPUArchState *env, tar=
get_ulong s, int len);
  */
 int qemu_semihosting_log_out(const char *s, int len);
=20
-#endif /* _SEMIHOST_CONSOLE_H_ */
+#endif /* SEMIHOST_CONSOLE_H */
diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
index 1adacf09f9..62abfd7a6e 100644
--- a/include/hw/xen/io/ring.h
+++ b/include/hw/xen/io/ring.h
@@ -24,8 +24,8 @@
  * Tim Deegan and Andrew Warfield November 2004.
  */
=20
-#ifndef __XEN_PUBLIC_IO_RING_H__
-#define __XEN_PUBLIC_IO_RING_H__
+#ifndef XEN_PUBLIC_IO_RING_H
+#define XEN_PUBLIC_IO_RING_H
=20
 /*
  * When #include'ing this header, you need to provide the following
@@ -469,7 +469,7 @@ struct name##_data_intf {                            =
                         \
 };                                                                      =
      \
 DEFINE_XEN_FLEX_RING(name)
=20
-#endif /* __XEN_PUBLIC_IO_RING_H__ */
+#endif /* XEN_PUBLIC_IO_RING_H */
=20
 /*
  * Local variables:
diff --git a/target/cris/opcode-cris.h b/target/cris/opcode-cris.h
index e7ebb98cd0..40509c88db 100644
--- a/target/cris/opcode-cris.h
+++ b/target/cris/opcode-cris.h
@@ -19,8 +19,8 @@ GNU General Public License for more details.
 You should have received a copy of the GNU General Public License
 along with this program; if not, see <http://www.gnu.org/licenses/>.  */
=20
-#ifndef __CRIS_H_INCLUDED_
-#define __CRIS_H_INCLUDED_
+#ifndef TARGET_CRIS_OPCODE_CRIS_H
+#define TARGET_CRIS_OPCODE_CRIS_H
=20
 #if !defined(__STDC__) && !defined(const)
 #define const
@@ -345,7 +345,7 @@ extern const struct cris_opcode cris_opcodes[];
    sign-extended before adding to "target".  */
 #define CRIS_DIS_FLAG_MEM_TARGET2_MEM_WORD (1 << 7)
=20
-#endif /* __CRIS_H_INCLUDED_ */
+#endif /* TARGET_CRIS_OPCODE_CRIS_H */
=20
 /*
  * Local variables:
diff --git a/tests/migration/migration-test.h b/tests/migration/migration=
-test.h
index aa3c3a9625..68512c0b1b 100644
--- a/tests/migration/migration-test.h
+++ b/tests/migration/migration-test.h
@@ -32,4 +32,4 @@
  */
 #define ARM_TEST_MAX_KERNEL_SIZE (512 * 1024)
=20
-#endif /* _MIGRATION_TEST_H */
+#endif /* MIGRATION_TEST_H */
diff --git a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTabl=
esTest.h b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTables=
Test.h
index 7a74c121d5..07808787cc 100644
--- a/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.=
h
+++ b/tests/uefi-test-tools/UefiTestToolsPkg/Include/Guid/BiosTablesTest.=
h
@@ -21,8 +21,8 @@
   WARRANTIES OR REPRESENTATIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
 **/
=20
-#ifndef __BIOS_TABLES_TEST_H__
-#define __BIOS_TABLES_TEST_H__
+#ifndef BIOSTABLESTEST_H
+#define BIOSTABLESTEST_H
=20
 #include <Uefi/UefiBaseType.h>
=20
@@ -77,4 +77,4 @@ typedef struct {
 } BIOS_TABLES_TEST;
 #pragma pack ()
=20
-#endif // __BIOS_TABLES_TEST_H__
+#endif /* BIOSTABLESTEST_H */
--=20
2.21.0


