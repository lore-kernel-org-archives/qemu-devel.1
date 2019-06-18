Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C978C31E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361BB20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 15:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361BB20B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdG2J-0004IJ-Bd
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 11:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hdFGs-0002np-L3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:39:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hdFGq-0000jE-MM
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:39:38 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:36571)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hdFGq-0000ft-Ax
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 10:39:36 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 3F67B44042;
 Tue, 18 Jun 2019 23:39:34 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id EB3A5240085;
 Tue, 18 Jun 2019 23:39:33 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Tue, 18 Jun 2019 23:39:15 +0900
Message-Id: <20190618143923.53838-14-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190618143923.53838-1-ysato@users.sourceforge.jp>
References: <20190618143923.53838-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH RESEND v21 13/21] target/rx: Dump bytes for
 each insn during disassembly
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

There are so many different forms of each RX instruction
that it will be very useful to be able to look at the bytes
to see on which path a bug may lie.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-24-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 5a32a87534..d73b53db44 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -102,7 +102,21 @@ static int bdsp_s(DisasContext *ctx, int d)
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
=20
-#define prt(...) (ctx->dis->fprintf_func)((ctx->dis->stream), __VA_ARGS_=
_)
+static void dump_bytes(DisasContext *ctx)
+{
+    int i, len =3D ctx->len;
+
+    for (i =3D 0; i < len; ++i) {
+        ctx->dis->fprintf_func(ctx->dis->stream, "%02x ", ctx->bytes[i])=
;
+    }
+    ctx->dis->fprintf_func(ctx->dis->stream, "%*c", (8 - i) * 3, '\t');
+}
+
+#define prt(...) \
+    do {                                                        \
+        dump_bytes(ctx);                                        \
+        ctx->dis->fprintf_func(ctx->dis->stream, __VA_ARGS__);  \
+    } while (0)
=20
 #define RX_MEMORY_BYTE 0
 #define RX_MEMORY_WORD 1
--=20
2.11.0


