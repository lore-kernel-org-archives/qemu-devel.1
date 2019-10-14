Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE10C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D2B20673
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 12:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D2B20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJz7A-000415-M1
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 08:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53395)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzJ-0005Pr-UU
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzI-0003Uw-Kh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:09 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:35677)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1iJyzI-0003Tx-CF
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:58:08 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail02.asahi-net.or.jp (Postfix) with ESMTPA id A8B496E17E;
 Mon, 14 Oct 2019 20:58:07 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 59C5424008F;
 Mon, 14 Oct 2019 20:58:07 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Subject: [PATCH v26 10/21] target/rx: Use prt_ldmi for XCHG_mr disassembly
Date: Mon, 14 Oct 2019 20:57:46 +0900
Message-Id: <20191014115757.51866-11-ysato@users.sourceforge.jp>
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

Note that the ld =3D=3D 3 case handled by prt_ldmi is decoded as
XCHG_rr and cannot appear here.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20190607091116.49044-21-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/rx/disas.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/rx/disas.c b/target/rx/disas.c
index 515b365528..db10385fd0 100644
--- a/target/rx/disas.c
+++ b/target/rx/disas.c
@@ -366,13 +366,7 @@ static bool trans_XCHG_rr(DisasContext *ctx, arg_XCH=
G_rr *a)
 /* xchg dsp[rs].<mi>,rd */
 static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
 {
-    static const char msize[][4] =3D {
-        "b", "w", "l", "ub", "uw",
-    };
-    char dsp[8];
-
-    rx_index_addr(ctx, dsp, a->ld, a->mi);
-    prt("xchg\t%s[r%d].%s, r%d", dsp, a->rs, msize[a->mi], a->rd);
+    prt_ldmi(ctx, "xchg", a->ld, a->mi, a->rs, a->rd);
     return true;
 }
=20
--=20
2.20.1


