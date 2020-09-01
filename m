Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EECBC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23FCE206EF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23FCE206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7I6-00056M-60
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zX-000645-Vs; Tue, 01 Sep 2020 10:10:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:53745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zV-0003zS-QH; Tue, 01 Sep 2020 10:10:31 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MDQqk-1kKI030IWU-00AT1v; Tue, 01 Sep 2020 16:10:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 35/44] target/arm/translate-a64:Remove dead assignment in
 handle_scalar_simd_shli()
Date: Tue,  1 Sep 2020 16:09:45 +0200
Message-Id: <20200901140954.889743-36-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7MytmcQlZbd0x7aW2n0tHP/lWDilC+4WyjdtE03XZV3dMl9gCsZ
 tid0ho/0Rf9qrqda7CX6DNS501cq7GAz5hr1Zgx2+2CXIj9XvqJoSNA+3ypl/lKgG7rTwG1
 g7Id7vtrHF/6fSodLQ1CsEsZ+8N2+FlZ4AvmEGOTib5ml55ebxl6wUr12gyirZjEeaKmjPH
 76j2kBTAynlNNOs0IgX/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D4SzP2V09+Y=:fnfFRWUCmK17meChl6FvaY
 T1KcPuDeEGrPeQEFpIBHHQo07agKz84T87KDYRFTbFap4N8dtl90B3+KjiXqFSelhvSE2qhXs
 lIyipI2swjin96Wq/Xdow+mgic95mPzarA6QX1FYES0aAfN+C6pTWrR+6W0pdUyRcE+etJ87K
 +hgT0qH6Wbsec/gdI0ul8ydJLqG4FpJRFTP/zqExuO9nsd0c8QuEO/puvOm3jMMiNSGavXqIG
 8/Z+1pMKD+Azv9iOp/0GV8rDzd2TcauUSN+hCQ8n4TZ/zhdD1rDiaHXvhdYc9ImZNADN8iIi/
 pOXMY61j4rJNgLzLr1YnjWeb1Smc5bhoB/axBbg+/hiq5eem1hRrU4vEfTPdgHc+chx0AjXfM
 9EAR5ODihDQUwNINZYdDJcPj04l/RRMnrq07MRGeh4pgQyp9hHK0M12St72+usb/5+ousNY9b
 /AeL5rBGtpyeXO0wVLBOu9VxnhekIRXQ53Thj8WUSwedo6CqODZ48p6YrfJT7RO5xjRAymbot
 X6hTaCayI7OrdUCHk83hp72vGLaAdLXAWpJSe4Rhx6jo+8xxecLOgg6yjaHMEsALIhwMMKz9u
 lzGUs93nxEYQao+gWH+ObIlD2I5u1r7ZLQ15m+QMdZJ4x2qANVJb2KtKssrFe1YLZ+rAtmAvm
 pCNYsv+q+HhPMUgbz/e1D+ZJG6exB7fEALaazSls8mU0rHsnno8qhgCXivtKkAdM1iXmV7mRZ
 4iIELbGKNsQz/aNeNz1UP7OfvawPvN669Br7Icy9Lf+UDVRF4VuuYPif5xiJ4SLYVhYlCbbVc
 AUvguDxHYgiTNdzg9hM7FQyokLDrinq6AatWKG+43y3a0m0FGumNFdXId+pDszfml1n+GfP
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:09:57
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
Cc: qemu-trivial@nongnu.org, Chen Qun <kuhn.chenqun@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Qun <kuhn.chenqun@huawei.com>

Clang static code analyzer show warning:
target/arm/translate-a64.c:8635:14: warning: Value stored to 'tcg_rn' during its
 initialization is never read
    TCGv_i64 tcg_rn = new_tmp_a64(s);
             ^~~~~~   ~~~~~~~~~~~~~~
target/arm/translate-a64.c:8636:14: warning: Value stored to 'tcg_rd' during its
 initialization is never read
    TCGv_i64 tcg_rd = new_tmp_a64(s);
             ^~~~~~   ~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200827110311.164316-4-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/arm/translate-a64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 4ba6918b6063..1fc3b2273207 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -8631,8 +8631,8 @@ static void handle_scalar_simd_shli(DisasContext *s, bool insert,
     int size = 32 - clz32(immh) - 1;
     int immhb = immh << 3 | immb;
     int shift = immhb - (8 << size);
-    TCGv_i64 tcg_rn = new_tmp_a64(s);
-    TCGv_i64 tcg_rd = new_tmp_a64(s);
+    TCGv_i64 tcg_rn;
+    TCGv_i64 tcg_rd;
 
     if (!extract32(immh, 3, 1)) {
         unallocated_encoding(s);
-- 
2.26.2


