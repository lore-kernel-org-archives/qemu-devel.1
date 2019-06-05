Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8460C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8139920673
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8139920673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36070 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPAi-0005uL-DE
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:13:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYP9M-0004yq-AA
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYP9L-0008LJ-AC
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:33441)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYP9L-0008Fy-1K
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:11:51 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MBUuP-1hPu2C0HKJ-00D3H0; Wed, 05 Jun 2019 08:11:43 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:23 +0200
Message-Id: <20190605061126.10244-3-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
In-Reply-To: <20190605061126.10244-1-david.brenken@efs-auto.org>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Provags-ID: V03:K1:TEZT9UUxGWLf9FfaWoDi1gOpgnmWXzXNN3KWJBjVttaxbPoOT6L
	4pCpyC+N4ukd4GCbqd129iT5KoztFspbo/bPDa7u7xOJ5Ams4Wbqwod1TDxHTtJzewLRv/Q
	27afpFbyy8AZghBUeW9+w5V7sAh4drxRba8TwvW4SJUXNu63YZFJ6bCUId8mjHX3x245p+S
	LSQJzvIer5LaLmSsxkiyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mdF6Qmfm4/o=:vf/z7gKJQTTIJqd6FLzEpY
	4wqoIHf9wcP0FBfkcWgw9X1I59UJUewcQ87N2aXn8wqXWfNkaeu1/W7KHqdlcpu9Cb1fbOIva
	VWqiWTpdtjU0lH3FdPvFsZSYJPElvSO7uUzH5o93gZAB/1x7zDvaFF8eATohYtsT6tak01hSD
	Towwv5/bDDcET/7Oh0efUgNs/KCBFN0uzRqwBTQmrp1F72WUVdL9RBud16fc2tsVUWjM06Rsg
	X/NbTfG46Uh0F+/NUt0+rusLqqCaIrrIv87iGAhBDr4D6+ON0ZyGKgihovXOiMqJHVMl8n2cW
	gtq8NXAJYCcgplBlG0XMLGCdZRJnIsKDrCm+asI4R2cAZwVMvn/KuEGTTWwKoPdFI5el4tUmx
	ItF1rVeD69igqlQaLVpHbU9Dj3kWSAzdQeDJ7k4kQcOU9O/9jJxXYZsBtd7YlemRcKFWeMAJ2
	mcvq8RTFGmD1hnIu+mDWNOfnaUq9k0jldJC5LR4VzhKCh3vX8DBpI39eQNebi32tjEiSmuxcR
	gNgfKZy9QGgoqT5Gj6I4tK5McpIqXfAImNVOoijFRgrrh33TnlPMvNG0YEatM9iTu119aUhQq
	TNoV83/V2IxUSEpEvs2wnB8btA8/4ZMfmPk0BH6wFVcTk7aOpkawqtO4SFQqNZ8/Dl8WNbASJ
	iY1NQtCYmkzCjqpp/bxg5THVJ91S2ShC7cTctqJUJbv5bE4DVpiwIecCvb/NRFuNYEq4WC4fg
	WVarkBk0bEZvF/F0iTpKNjvGYxWrLKUe6+2B0AUZOK1ra0tQn+LDQzk2byg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PATCH 2/5] tricore: add UTOF instruction
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
index 66cdc63286..a8b4de647a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -6764,6 +6764,9 @@ static void decode_rr_divide(CPUTriCoreState *env, DisasContext *ctx)
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
2.17.1


