Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA172C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2EE206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:17:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2EE206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD76P-0003oA-NY
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zJ-0005Ok-TX; Tue, 01 Sep 2020 10:10:17 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:47201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zE-0003lu-C5; Tue, 01 Sep 2020 10:10:17 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MGQaz-1kNJB93WBh-00GmgK; Tue, 01 Sep 2020 16:10:03 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 08/44] target/sh4: Remove superfluous breaks
Date: Tue,  1 Sep 2020 16:09:18 +0200
Message-Id: <20200901140954.889743-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Mcik9TkeaKMGYqCdcFrXhfx40gE1qlW7PBlZrqP4zLUPcyVZChD
 13lly84avryWHAnP6r2HXf23Vj9QwmaZwbXjcdLujdMtBEOONUNeOv1mfGXO6Xaujy7S+Yp
 V1wBXrgbndhh0Tr95doz0VYWZku5zv9v17j3+3HEyiWGHB1uHkfRc2VA0E7q5llY/qYDjH+
 WJCfPtfftNBNch+mjBRYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kb4Txv76HBI=:fO/W8IRpcaTuf6XW8+J3wI
 u0wuLJYEWvURKE1Xa+Pf66/A9b+NQ0tCbMtoSkR8yP9qwstunYkw9SaEHi7mj5wyuBtoftExF
 tD6bTBoSEanWiahEXYMk4X2MaxbeHK0VmjL59hPjqAAN6m4V6gXVHSeeMzCucE5D5lJDwUjn0
 dBR2qcvETPfEWeB3IdnAnO/QR8jnoobe624jnfGCfsWb/+M0TADuI03XUgMAZ9718pG+39QrI
 XDmw9T+vH0ZC+asYfpUT3X/0i7UnCeiBAVMrHM+WQOHYWGkICWDA4oafXGFqAHrARGMO7uY+I
 HBddrBHguFlYqZUewWOo3btcMaB1HhfQM4D89cRs/F5m5FHsg222r7GbXZ3TIlrbt/U3JtTCC
 3UtFJDyVNVfxXrOz9HSstVAuCqfJHhj90n1GjgoNDMYJ7BQGSEexk18km5OIXjUu2UNmyo/DB
 Rs5V8+G10MJS+F6x4LAlqGqRs6dJB6AloOpHaY2CEysDN2qe7lP0whSfh9ItVp52PO2Y8zB09
 55L+fhhAwqG97LxGsOuHbuvM6+0drTZhXv8l7v3+ruqkqBlXHMFACZi195UHSemEBJSQBDBCX
 S9m/P3wYXAecPXzrwIDutBPtCo+JeafrkSNyVyyCex33pqFpQLm4IFVRs/Tk+qXl+aPWHkDid
 rAov4aLWwEIeYgx8e4lRL9Jy0S6SFspE0M1fl3/fQ/SW4sVOOwTZLvdh2yaosHd+W9y44p9Qb
 B8ITVVL/89IRvPYgRfg8/59jaAY8PzAdQY5nuolL4dem0R0uYTvoOmkuucTr1igoyWwxTtfvA
 NYplVdTEkoyk9cYS2uu2JK44nt91C8ewqJgoy1yn3QiG23bsfUUtEJMhtcCvm8GM8Qh8SUD
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Message-Id: <1594631142-36745-1-git-send-email-wang.yi59@zte.com.cn>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sh4/translate.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 6192d83e8c66..60c863d9e1b0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1542,7 +1542,6 @@ static void _decode_opc(DisasContext * ctx)
         tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx,
                             MO_TEUL | MO_UNALN);
         return;
-        break;
     case 0x40e9:                /* movua.l @Rm+,R0 */
         CHECK_SH4A
         /* Load non-boundary-aligned data */
@@ -1550,7 +1549,6 @@ static void _decode_opc(DisasContext * ctx)
                             MO_TEUL | MO_UNALN);
         tcg_gen_addi_i32(REG(B11_8), REG(B11_8), 4);
         return;
-        break;
     case 0x0029:		/* movt Rn */
         tcg_gen_mov_i32(REG(B11_8), cpu_sr_t);
 	return;
@@ -1638,7 +1636,6 @@ static void _decode_opc(DisasContext * ctx)
         CHECK_SH4A
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
         return;
-        break;
     case 0x4024:		/* rotcl Rn */
 	{
 	    TCGv tmp = tcg_temp_new();
-- 
2.26.2


