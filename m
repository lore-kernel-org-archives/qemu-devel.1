Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F216C43613
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 664812089F
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 07:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664812089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48372 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfJ3X-0004pf-Gu
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 03:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48980)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ1N-0003bM-G2
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.org>) id 1hfJ1M-0002xk-3v
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:09 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59567)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
 id 1hfJ1L-0002vI-Kd
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 03:04:08 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M9Wqa-1hbz6b0PuW-005VKq; Mon, 24 Jun 2019 09:04:01 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Mon, 24 Jun 2019 09:03:36 +0200
Message-Id: <20190624070339.4408-3-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
References: <20190624070339.4408-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:Z9+2iBbciBKCIS3KKIyY9wV/ZenbicUrCBy5QeDDpTv5Z2flY6q
 OsBq83+wEf88Tzkr15ufS0neXHAqByrO7sJegneKsR9kTFau4J6I2KAb0rYQgtrFygBQl2A
 LlAEi5ZpBYc6IWxcSmBvBRslZ8kZWuenRCBGzvQt/xeY5HKcIDMsxoiXLqJCVMZaV+Ki/zI
 r/OT25KM7frbpBKpnU3/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WdBCc6q1Mh4=:sY52BVC2OpkTPUiRM/eLD/
 SKaQe2B1DyvAIQ5FT3ld0MiySI2/moYjfNC9BQp/S8V2o/3+E+vCDNOhP96HaSwFQh2mEzQ9/
 CxKImcEa6FNrwAyZrKsRNpanS6F2xar7AvdAw57aVw4MNAlEyTPNOpHcmMb7+tDRd8Yesbqyk
 3A2UqGMGId7uQYCteu6J+5PrccmYuasllhuGuq5Blaw+jB8aOHQAdaYzThSdo7lfPpO+xAP+v
 KRZIsjE+4K0DXTvOQkUVW58IVNokmtwfMpsvo4Y4BqhEzvMQrd6SPbhEyEMm4H7hQO2bceMJP
 y34/TUtmrYGXJLat7YENCIWWVrsWu8BsfbQdz4rbwNjuPk0ljCPmn0SZPMZNq1/Mfn5Huajkt
 mNgaYpHX4iE0bEP4bsng4wDsi+Ub2+0GbTroVWuAQd43oXYVBx14CdTB5NWaBL52+qhuC4guo
 czR95WYlVsyr4lpG8GfiHgjsOFsjFU/TbNm01Xd6pUbQs07JAj2biJO9NOLzFgN3gYR9DVCwc
 iRckTTjkkykMB0dlpHHhnpE9Ybl+QkagnR7A+ui1gam2WEwtwiea/g4oFPwJU/z/hSqrJAmD4
 oMZcRVnNemP8hSFEihJeLB1BZUjEistCkg1znPebqewqhm9qQVJX1lwqP+wCaI/ZyfABEydfA
 dlJu+as1EZuE93YWVmU/yxMvUf+eGb+ab6I/RdNJF3ZbnydTEszuxpcIECBpml275eRmgYkc7
 Skt0jGYx7zJunp668E4KG9NCkh48lcg4Ia35ngsKVIhnFtegrnWXZfx62AM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PATCH v3 2/5] tricore: add UTOF instruction
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
Cc: kbastian@mail.uni-paderborn.de,
 Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>

Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
Signed-off-by: David Brenken <david.brenken@efs-auto.de>
Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/fpu_helper.c | 16 ++++++++++++++++
 target/tricore/helper.h     |  1 +
 target/tricore/translate.c  |  3 +++
 3 files changed, 20 insertions(+)

diff --git a/target/tricore/fpu_helper.c b/target/tricore/fpu_helper.c
index f079d9e939..432079c8e2 100644
--- a/target/tricore/fpu_helper.c
+++ b/target/tricore/fpu_helper.c
@@ -303,6 +303,22 @@ uint32_t helper_itof(CPUTriCoreState *env, uint32_t arg)
     return (uint32_t)f_result;
 }
 
+uint32_t helper_utof(CPUTriCoreState *env, uint32_t arg)
+{
+    float32 f_result;
+    uint32_t flags;
+
+    f_result = uint32_to_float32(arg, &env->fp_status);
+
+    flags = f_get_excp_flags(env);
+    if (flags) {
+        f_update_psw_flags(env, flags);
+    } else {
+        env->FPU_FS = 0;
+    }
+    return (uint32_t)f_result;
+}
+
 uint32_t helper_ftoiz(CPUTriCoreState *env, uint32_t arg)
 {
     float32 f_arg = make_float32(arg);
diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index 16b62edf7f..f1a5cb367e 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -111,6 +111,7 @@ DEF_HELPER_4(fmsub, i32, env, i32, i32, i32)
 DEF_HELPER_3(fcmp, i32, env, i32, i32)
 DEF_HELPER_2(ftoi, i32, env, i32)
 DEF_HELPER_2(itof, i32, env, i32)
+DEF_HELPER_2(utof, i32, env, i32)
 DEF_HELPER_2(ftoiz, i32, env, i32)
 DEF_HELPER_2(ftouz, i32, env, i32)
 DEF_HELPER_2(updfl, void, env, i32)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5e1c4f54b9..bd913d71a1 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6747,6 +6747,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
     case OPC2_32_RR_UPDFL:
         gen_helper_updfl(cpu_env, cpu_gpr_d[r1]);
         break;
+    case OPC2_32_RR_UTOF:
+        gen_helper_utof(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
+        break;
     case OPC2_32_RR_FTOIZ:
         gen_helper_ftoiz(cpu_gpr_d[r3], cpu_env, cpu_gpr_d[r1]);
         break;
-- 
2.22.0.windows.1


