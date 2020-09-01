Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A897C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 199B5206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199B5206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD7Gc-0001j9-5i
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zY-00064g-3x; Tue, 01 Sep 2020 10:10:32 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55081)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zV-0003zV-U9; Tue, 01 Sep 2020 10:10:31 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzQbw-1kZA7R313g-00vRaH; Tue, 01 Sep 2020 16:10:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 36/44] target/arm/translate-a64:Remove redundant statement in
 disas_simd_two_reg_misc_fp16()
Date: Tue,  1 Sep 2020 16:09:46 +0200
Message-Id: <20200901140954.889743-37-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Se1aBbOJhO0bgrfhpYnwe20MluVmTL6jT+pVjZM/pAm3vTbgo+j
 ILqCMotw5/eAM/jbR/NH+F2+1tNZTdCshjUbZk/wDqAF7WN6lN23f0TbjAq6mxnoPRA4Qn1
 jbRpqn1baoaOyi6ODweAlaMJULAugd4AuURr+nVJZHMgm7WroS5er1Grke6GZXvm0L7Qsmw
 EV+dYhUDhKJvA3m1R8GYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B2d3lJ4w/A=:C6vvJh6M68fBAqFZ09tqA4
 6cUbZejz9V/IM7TlK/ngg0xZrM1G6Ov898oEX6LntS90J112++ZvGCMwWTZ0CFOVT8G+jJ8f0
 ScNcohjHS95I8jVsi4tAhc/Kz7Wcf9LqAW91EY5//KJA4gSWushdTcaTzgbZu/GL1b3xbJdrX
 ZSUgUOWB6lAg01PHqJKN2mr3RfCiRRVrHCqbpUGzGuP5QplllbZx3ALOJo8FYjlcNdm+ue4Kq
 ylAWreaITwCVHciCwrEt6CUV9yfQelb20bhOoYB/sf4kohKaNvwqrUB2KjlT0rnTY1Nj0OS6r
 o2GRhVW05nM8BKF2RAVjHcoPRIb8hufNeQYlpsVwmThyWjHJyUhoAyS/fTiVUS1FMcTF+wUkM
 fsBtHjBKzxnNAShpPnXym57RRgrimRJ3vQgiHIiwVY8Wnj+Vxsp2UOf6SablEyTA1g8VLhpKc
 gdic/1WzNS8sB3977BCwremVAyGrld/1fYaZaY25uYKHixGIqb57Dh2jN3cb48244q0yDeyTS
 2lJYL4m1UlhxpoiM8zfuM9szI97ra5vBEh8oPMv9SeBm8g371931FH3zTgOxigD75VJYhZplb
 Ryd5ocH7svGkXjHIBrRk5UoKMSNBH400WLaRBJStQw3L5uDbNUQFDrS2+yn7+31uJYEc9Xjsv
 uGkEjCP5WEAE/ig8Ct91eRU4ysocRmdYeOisvKNo194y00AS039g5joOV8SOyWCKO0V5V1mpQ
 myU/guO7X7pW02oC9g0Mkd52hH68P9ighpvOTCT7PfLIX0A504mxbsEKpsLwIJrrSfWosnym3
 8Y6TNUO6DQ2l2yF6ylwgu/1shNskK7mFdhZ+0z6yeGE3L8glyynP2xyfmMY5jTAu/dqPZnS
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
target/arm/translate-a64.c:13007:5: warning: Value stored to 'rd' is never read
    rd = extract32(insn, 0, 5);
    ^    ~~~~~~~~~~~~~~~~~~~~~
target/arm/translate-a64.c:13008:5: warning: Value stored to 'rn' is never read
    rn = extract32(insn, 5, 5);
    ^    ~~~~~~~~~~~~~~~~~~~~~

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20200827110311.164316-5-kuhn.chenqun@huawei.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/arm/translate-a64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 1fc3b2273207..71888083417d 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13014,9 +13014,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     fpop = deposit32(opcode, 5, 1, a);
     fpop = deposit32(fpop, 6, 1, u);
 
-    rd = extract32(insn, 0, 5);
-    rn = extract32(insn, 5, 5);
-
     switch (fpop) {
     case 0x1d: /* SCVTF */
     case 0x5d: /* UCVTF */
-- 
2.26.2


