Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3852BC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:11:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08EFE206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="EQ7xL+Q0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EFE206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39941 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu5J-0001Zn-4d
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:11:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0X-0005Rm-45
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004NO-FE
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:49 -0400
Received: from ozlabs.org ([203.11.71.1]:44461)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0V-0004IM-2v; Fri, 26 Apr 2019 02:06:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tl4Tmfz9sDn; Fri, 26 Apr 2019 16:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258795;
	bh=+NSCKHsz7Epefi0fzIqxusInerJTGVGvLh4ho+rkMlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EQ7xL+Q0R4YG/bdYQYQF4yo3QX+9tyoed1chkIROqBkgNKy/twoejln6koCLw3urO
	227NoQMBEizAlpUsuiReNyieAmfTxKJO0OiChNyBqN5J+rN+zl7GD4WQJec5xlB5p8
	jNNqUIn25Yv0RNhETPjaHChW452L4HbOcJA7a+ik=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:02 +1000
Message-Id: <20190426060627.18153-12-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 11/36] target/ppc: Style fixes for gdbstub.c
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060602.BpPxdU4xjwz48s-Mt1XopeDUAQHAbNLjimmDqKrdowU@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/gdbstub.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index fbf3821f4b..ce3625f44e 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -33,14 +33,14 @@ static int ppc_gdb_register_len_apple(int n)
         return 8;
     case 64 ... 95:
         return 16;
-    case 64+32: /* nip */
-    case 65+32: /* msr */
-    case 67+32: /* lr */
-    case 68+32: /* ctr */
-    case 70+32: /* fpscr */
+    case 64 + 32: /* nip */
+    case 65 + 32: /* msr */
+    case 67 + 32: /* lr */
+    case 68 + 32: /* ctr */
+    case 70 + 32: /* fpscr */
         return 8;
-    case 66+32: /* cr */
-    case 69+32: /* xer */
+    case 66 + 32: /* cr */
+    case 69 + 32: /* xer */
         return 4;
     default:
         return 0;
@@ -84,11 +84,14 @@ static int ppc_gdb_register_len(int n)
     }
 }
=20
-/* We need to present the registers to gdb in the "current" memory order=
ing.
-   For user-only mode we get this for free; TARGET_WORDS_BIGENDIAN is se=
t to
-   the proper ordering for the binary, and cannot be changed.
-   For system mode, TARGET_WORDS_BIGENDIAN is always set, and we must ch=
eck
-   the current mode of the chip to see if we're running in little-endian=
.  */
+/*
+ * We need to present the registers to gdb in the "current" memory
+ * ordering.  For user-only mode we get this for free;
+ * TARGET_WORDS_BIGENDIAN is set to the proper ordering for the
+ * binary, and cannot be changed.  For system mode,
+ * TARGET_WORDS_BIGENDIAN is always set, and we must check the current
+ * mode of the chip to see if we're running in little-endian.
+ */
 void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int le=
n)
 {
 #ifndef CONFIG_USER_ONLY
@@ -104,11 +107,12 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uin=
t8_t *mem_buf, int len)
 #endif
 }
=20
-/* Old gdb always expects FP registers.  Newer (xml-aware) gdb only
+/*
+ * Old gdb always expects FP registers.  Newer (xml-aware) gdb only
  * expects whatever the target description contains.  Due to a
  * historical mishap the FP registers appear in between core integer
- * regs and PC, MSR, CR, and so forth.  We hack round this by giving the
- * FP regs zero size when talking to a newer gdb.
+ * regs and PC, MSR, CR, and so forth.  We hack round this by giving
+ * the FP regs zero size when talking to a newer gdb.
  */
=20
 int ppc_cpu_gdb_read_register(CPUState *cs, uint8_t *mem_buf, int n)
--=20
2.20.1


