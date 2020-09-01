Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8994CC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56993206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56993206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7EL-0005ak-FB
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zQ-0005iK-Q7; Tue, 01 Sep 2020 10:10:24 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54469)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zN-0003uZ-VA; Tue, 01 Sep 2020 10:10:24 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MirfI-1kpj3P28pg-00es6T; Tue, 01 Sep 2020 16:10:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/44] target/cris: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:19 +0200
Message-Id: <20200901140954.889743-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XPGk1ppX/yIcmerFfjdQ8YEXT48yPdytcScu35k7J4MP4OtT53r
 eWf/sK8GFUOSw71FV2s7xmY/QBP0WSp8FGJPSmdKB/4jRSwLdWTZBdYpmyCYnmqrMBhzhcE
 QXiOk1SQ4cckOUe5h/eRktxlLA116LEaTibX7B7yVkQbkybzftKYJJCqofwwQHaFfnjEH0f
 knnYmomER83ZRAOLx841w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2yHF8nSWOIs=:sBPsy+AaCj1nt0Aou7cjxw
 C2Q4pP+qftH+i6TNfTN3BLrfAGeXchsK+bqY92ENQiZw/Q93SJhRPvIB542m8FZnhTa3lp0lO
 00fhUj94INR2WytAflneLLgz0Rs9JfEzpIKNeGpAa2qTdemZY5AA+4taa1WqnMsnfKpnDJl7a
 rbsrafxfnf4Jhec0T2l28W+2UJcd6ZZ0rlyZpqjDv9lKYgERcFHGmpDvJRe/c4wr51FDurLXI
 o8m0zPuaXmr4YDXPFRly/2xWxaEgW7foRvpPDXd0RUzBy3M1Keft4ET9TyrwWROFNY1AxTqcO
 iQaGoOfNeQpSez9V0nIYNg2Utz8x7KvixO5zy6F3ZcyC+N1xf8HEtPs2DPOm0Xv6fUGpD6QFo
 ooY+pYkXU1De1nGQStb0/h7LXlgi/B0bLDXDw36yyC2ChNJBY5TgtZXWrr6AMESg9RiKQJQNM
 ofe9joVixHz/RcgvcmIpTY+iJLCTKzzic8Xvk+xjWwtfCbCx71F4eD8b4l4lDhXyaL/pLzGE2
 nZvfn5m5+XpMa3YQM9Z9P5SMGXm6FUektosEN7KxHgCmhvvXQfzrFVCvw87tNDgANNVkf4Rqu
 Lz07MreGe5gxSrmMvOJtr3qrLgewM8pnDR1C4nzUwunD+X8n45/JL7Dxs2qGLpKSxa3S5HeIh
 YtOQ+p7cSOBkcIWCTsXXJum2XfNpkb0sI9R92Xh8krt6UvMriDq0AIdeQFjoqTKcqAe8KFKVi
 erNHLtuf29tWwc1eggXnvVdLwnGEqlzT9YqJhl0u7gi4zwoxcX3brkgQ+BisYdgbpCBN8PsOO
 qsEtORnC7zBeFYpVHcXeRqPkgQUCn22Qzj9wLqGq20umRDOmgAD+DwDV3vdAtrRvjGdLCMo
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Yi Wang <wang.yi59@zte.com.cn>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Liao Pingfang <liao.pingfang@zte.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1594631150-36801-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/cris/translate.c         | 7 +++----
 target/cris/translate_v10.c.inc | 2 --
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index ee5e359c7788..c312e6f8a65f 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -1178,12 +1178,11 @@ static inline void t_gen_zext(TCGv d, TCGv s, int size)
 static char memsize_char(int size)
 {
     switch (size) {
-    case 1: return 'b';  break;
-    case 2: return 'w';  break;
-    case 4: return 'd';  break;
+    case 1: return 'b';
+    case 2: return 'w';
+    case 4: return 'd';
     default:
         return 'x';
-        break;
     }
 }
 #endif
diff --git a/target/cris/translate_v10.c.inc b/target/cris/translate_v10.c.inc
index ae34a0d1a3d8..7f38fd215eae 100644
--- a/target/cris/translate_v10.c.inc
+++ b/target/cris/translate_v10.c.inc
@@ -1026,10 +1026,8 @@ static unsigned int dec10_ind(CPUCRISState *env, DisasContext *dc)
         switch (dc->opcode) {
             case CRISV10_IND_MOVE_M_R:
                 return dec10_ind_move_m_r(env, dc, size);
-                break;
             case CRISV10_IND_MOVE_R_M:
                 return dec10_ind_move_r_m(dc, size);
-                break;
             case CRISV10_IND_CMP:
                 LOG_DIS("cmp size=%d op=%d %d\n",  size, dc->src, dc->dst);
                 cris_cc_mask(dc, CC_MASK_NZVC);
-- 
2.26.2


