Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C3C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:28:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A302206B6
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A302206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl20-0001ua-Q0
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzI-00053O-VH
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzG-0002Nf-3U
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:00 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MVvGt-1kJYkZ1G0j-00RmpQ; Sat, 04 Jul 2020 18:25:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/12] linux-user/sparc64: Fix the handling of window spill trap
Date: Sat,  4 Jul 2020 18:25:35 +0200
Message-Id: <20200704162545.311133-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CZpX6YXxb7WOdVWhB9j9G6aVu4bzOf2oJWOAAtQezpH5aN5AZOD
 HE9BNn7lyhrixircWt3LQecA7EGMAmPl9d6op527Yvn4Lv1slsRRrkgXEiuIdn6/ujqWNew
 bLKqg9D7AdcKpFQQkDu/jIrKjotdb/c+ROlVCwoRb7WsMC029dzpr6h6nE0kZPjmKF9D/Lv
 ljEiza9bQu4MoNXgnltuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LF5MlfSwLoU=:fIVAsQp4pfVZJEZplL46hP
 Y3UPx4KpHUN1ih87pVvt9KyB882y3WLKvxwCTXns44vGVC5++8DszGn/zV2w15Yg3/08CBUnW
 dTYT66UC6UWJXlaPMOWPBMtR1ExyWGrLjmLEf4JUfOYxQEPZC92mHVmG7hBAcLqo6jCkbvY4d
 bF/nr9m4pd984tWvcxvuoziyfiKGoB6A+MJsNhZ6V7rRDCV7IHOxVfbkfvaeS8BbGpw7l3HLb
 08BVU7LAQsikox3iKss08JDvZs1TjwWTxEBc5OxS/v8BhpCmKj4/xNg89pPSyfCnldkp8rNgi
 TZKNn/6ZF8/KQxddR3TFaM3961I15YCq5iESTbmyFKSpqlDbcqNbZNDP/lwgwcR+aCaAZqZ9s
 RQ+hxzHm6fy5XSAjPYmcKD768wrFHwkvP0roLRmXnY58aD1TXF87WAkhTXBVNsgOSES7hU1oD
 Il2DIjJaG/h0fJI6Td9SKNu7XFDkP6pO7yqm0UHBO0WT+XaYd9pr1xvVPs2+j1pS/JkSXkcgc
 yMOHE4R25hFLDgtn+BuqgYHT3zG2azJ1u+x2x1fLZ1X0P/0W8MVakSZhM8kcq8gWUD2bqhuFZ
 ALgdDDK1nU/D6vxidVabFDOKRIlaLOhgp1UgFfB87daOJ6PPEqi7BBJ0XASNV8dDcUOJA5uD8
 iAJjIS8noQDKKvVGZMB4SqD8Q+E6npFTO2BN3/TWSfuqRdlwmrco27/hYYhZ3aj6Fy2nutjpW
 0baRGtqX0P+ZNkeoF+s+x03InsMFO3PeJAccrRIk9yfCxPuaYCfogdk8xwuqU5em+iSwNcSo4
 Qks77ehtyP9gLRIrKH8tDRwo7KTgzykrS53MYWTFwLHHXqVvTw=
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Giuseppe Musacchio <thatlemon@gmail.com>

Fix the handling of window spill traps by keeping cansave into account
when calculating the new CWP.

Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200625091204.3186186-3-laurent@vivier.eu>
---
 bsd-user/main.c             | 6 +++++-
 linux-user/sparc/cpu_loop.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/bsd-user/main.c b/bsd-user/main.c
index 0bfe46cff93e..ac40d79bfaac 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -413,7 +413,11 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /*
+     * cansave is zero if the spill trap handler is triggered by `save` and
+     * nonzero if triggered by a `flushw`
+     */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
diff --git a/linux-user/sparc/cpu_loop.c b/linux-user/sparc/cpu_loop.c
index 7645cc04ca73..02532f198df8 100644
--- a/linux-user/sparc/cpu_loop.c
+++ b/linux-user/sparc/cpu_loop.c
@@ -69,7 +69,11 @@ static void save_window(CPUSPARCState *env)
     save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
     env->wim = new_wim;
 #else
-    save_window_offset(env, cpu_cwp_dec(env, env->cwp - 2));
+    /*
+     * cansave is zero if the spill trap handler is triggered by `save` and
+     * nonzero if triggered by a `flushw`
+     */
+    save_window_offset(env, cpu_cwp_dec(env, env->cwp - env->cansave - 2));
     env->cansave++;
     env->canrestore--;
 #endif
-- 
2.26.2


