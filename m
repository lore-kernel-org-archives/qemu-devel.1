Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42FAC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 799D720673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:10:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799D720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJzBE-00020w-IL
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzL-0005RQ-LP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzJ-0003WB-BR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:11 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:35685)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzJ-0003V3-0c
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:09 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 5E5AC6E181;
 Mon, 14 Oct 2019 20:58:08 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 1E89524008F;
 Mon, 14 Oct 2019 20:58:08 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v26 12/21] target/rx: Collect all bytes during disassembly
Date: Mon, 14 Oct 2019 20:57:48 +0900
Message-Id: <20191014115757.51866-13-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014115757.51866-1-ysato@users.sourceforge.jp>
References: <20191014115757.51866-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
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
Cc: philmd@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Collected, to be used in the next patch.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-23-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 62 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 20 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index ebc1a44249..5a32a87534 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -25,43 +25,59 @@ typedef struct DisasContext {
     disassemble_info *dis;
     uint32_t addr;
     uint32_t pc;
+    uint8_t len;
+    uint8_t bytes[8];
 } DisasContext;
=20
=20
 static uint32_t decode_load_bytes(DisasContext *ctx, uint32_t insn,
-                           int i, int n)
+                                  int i, int n)
 {
-    bfd_byte buf;
+    uint32_t addr =3D ctx->addr;
+
+    g_assert(ctx->len =3D=3D i);
+    g_assert(n <=3D ARRAY_SIZE(ctx->bytes));
+
     while (++i <=3D n) {
-        ctx->dis->read_memory_func(ctx->addr++, &buf, 1, ctx->dis);
-        insn |=3D buf << (32 - i * 8);
+        ctx->dis->read_memory_func(addr++, &ctx->bytes[i - 1], 1, ctx->d=
is);
+        insn |=3D ctx->bytes[i - 1] << (32 - i * 8);
     }
+    ctx->addr =3D addr;
+    ctx->len =3D n;
+
     return insn;
 }
=20
 static int32_t li(DisasContext *ctx, int sz)
 {
-    int32_t addr;
-    bfd_byte buf[4];
-    addr =3D ctx->addr;
+    uint32_t addr =3D ctx->addr;
+    uintptr_t len =3D ctx->len;
=20
     switch (sz) {
     case 1:
+        g_assert(len + 1 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        return (int8_t)buf[0];
+        ctx->len +=3D 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        return (int8_t)ctx->bytes[len];
     case 2:
+        g_assert(len + 2 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        return ldsw_le_p(buf);
+        ctx->len +=3D 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        return ldsw_le_p(ctx->bytes + len);
     case 3:
+        g_assert(len + 3 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 3;
-        ctx->dis->read_memory_func(addr, buf, 3, ctx->dis);
-        return (int8_t)buf[2] << 16 | lduw_le_p(buf);
+        ctx->len +=3D 3;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 3, ctx->dis);
+        return (int8_t)ctx->bytes[len + 2] << 16 | lduw_le_p(ctx->bytes =
+ len);
     case 0:
+        g_assert(len + 4 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 4;
-        ctx->dis->read_memory_func(addr, buf, 4, ctx->dis);
-        return ldl_le_p(buf);
+        ctx->len +=3D 4;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 4, ctx->dis);
+        return ldl_le_p(ctx->bytes + len);
     default:
         g_assert_not_reached();
     }
@@ -110,7 +126,7 @@ static const char psw[] =3D {
 static void rx_index_addr(DisasContext *ctx, char out[8], int ld, int mi=
)
 {
     uint32_t addr =3D ctx->addr;
-    uint8_t buf[2];
+    uintptr_t len =3D ctx->len;
     uint16_t dsp;
=20
     switch (ld) {
@@ -119,14 +135,18 @@ static void rx_index_addr(DisasContext *ctx, char o=
ut[8], int ld, int mi)
         out[0] =3D '\0';
         return;
     case 1:
+        g_assert(len + 1 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 1;
-        ctx->dis->read_memory_func(addr, buf, 1, ctx->dis);
-        dsp =3D buf[0];
+        ctx->len +=3D 1;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 1, ctx->dis);
+        dsp =3D ctx->bytes[len];
         break;
     case 2:
+        g_assert(len + 2 <=3D ARRAY_SIZE(ctx->bytes));
         ctx->addr +=3D 2;
-        ctx->dis->read_memory_func(addr, buf, 2, ctx->dis);
-        dsp =3D lduw_le_p(buf);
+        ctx->len +=3D 2;
+        ctx->dis->read_memory_func(addr, ctx->bytes + len, 2, ctx->dis);
+        dsp =3D lduw_le_p(ctx->bytes + len);
         break;
     default:
         g_assert_not_reached();
@@ -1392,8 +1412,10 @@ int print_insn_rx(bfd_vma addr, disassemble_info *=
dis)
     DisasContext ctx;
     uint32_t insn;
     int i;
+
     ctx.dis =3D dis;
     ctx.pc =3D ctx.addr =3D addr;
+    ctx.len =3D 0;
=20
     insn =3D decode_load(&ctx);
     if (!decode(&ctx, insn)) {
--=20
2.20.1


