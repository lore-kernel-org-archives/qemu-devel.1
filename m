Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B63C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DB324125
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DB324125
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuXrR-0001Nk-0j
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 03:29:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56114)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuXlW-0001Od-5B
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003BM-R2
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:02 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37767)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuXlU-0003AO-Hf
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 03:23:00 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MWAf4-1j630V3rFS-00XYnL; Thu, 23 Jan 2020 09:22:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] linux-user: Add support for getting/setting RTC PLL
 correction using ioctls
Date: Thu, 23 Jan 2020 09:22:26 +0100
Message-Id: <20200123082227.2037994-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123082227.2037994-1-laurent@vivier.eu>
References: <20200123082227.2037994-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oMcSg9GRD3bTnJW2NH3roPN7XwG5h4iheUjy3D4zwUcPXX5pAjQ
 e4NFlR1jNdqVLW19GVz1SRl3WiTrvsJ7NmqTuws33Qc74/OXQo8J1jP1z+E1Yuw6dPm62Y5
 wcKafRlxczFSRs8ZfyjsUq/U7zW0RTOfyn9Ci8+N2KjqAUJ33dyhCBKKmHc9XleWuTAZg9E
 NS+l3XioavmegN7REtBFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g4flJtB8bK4=:Vj7AaXocgAXRQrMgXxVA6O
 Rli4biuoLjnyh/EQyrpAll9vg0AuHzKSKAmAy8RIqoKR9SrBfWk3LxXG4y7oFrtiDqn5py8Bf
 lQcyXqlaX9MBEMV28xLmi3TPDftku7QeygSkBQTOR4p48cSY5EiMW3QSe09dRPYvCKHDBbEte
 Dhglwf/wrI5IM8y4+hhFbRUcJTevPuZ+Iva+Kf0kZiqx60saTcGNdUaGMDqGkr1FTW+nicWgt
 yhIhnCMQkdvlXYk51Ot514GFWcI0Q1bMmarcSFefM1q4CaYA2NeJ9GVO8VxIXRS4VBYWac5kT
 1WsZNL9QD8EK+aWy3l2T36gqFrZ4PYGMSYZvUnfS3p0HE7QYBA7sQRzxAdgrnq02KVH5YJwrW
 eZDBUFK7UkYL39pJyGO0Nv0lqsRDwgDGFOPTFLQJSw3iZimTWHuAHrBQ9Ex9uN2Rmsg//pG0k
 P7HFynWWgSMDjTQUXx+1R6CDXnz93ZDLxuIuyvhnPirL7sEfJjJ1feegxW+jU3j/Yp4+o6Iv+
 DSrHUNESsek0BJNTgQHpwke8qJvx0tM/WSHZuDuGMx7SdP4JX1sPhn17xmnhktGTjTJnCuX2U
 hsmRml2LpvQRHCK/nOmK4fBUBD7He1M1wehT72OPOwpBQRj1FbOgB0B45FlrKjUAftyYY2i+W
 ajZndSELg+qV0PxzBQX6VcLllu0oCPB8u7xE2ovhgOHmUEXMB/Vx77bU2onVOZkzH5YR2mseb
 fRgJG37peePMSrbeKLYpaZf20jLAlGcC9c0GtoxOBUijqKEejhqPAYmOG0OeStAETILoTRlon
 a8QpeLN8thliN32z7dLn7BGNBEz+j2QXYAAJbcW0zHWOf8JYIFnxfO8jtiuJQELo6HAE0mL
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@rt-rk.com>

This patch implements functionalities of following ioctls:

RTC_PLL_GET - Getting PLL correction

    Read the PLL correction for RTCs that support PLL. The PLL correction
    is returned in the following structure:

        struct rtc_pll_info {
            int pll_ctrl;        /* placeholder for fancier control */
            int pll_value;       /* get/set correction value */
            int pll_max;         /* max +ve (faster) adjustment value */
            int pll_min;         /* max -ve (slower) adjustment value */
            int pll_posmult;     /* factor for +ve correction */
            int pll_negmult;     /* factor for -ve correction */
            long pll_clock;      /* base PLL frequency */
        };

    A pointer to this structure should be passed as the third
    ioctl's argument.

RTC_PLL_SET - Setting PLL correction

    Sets the PLL correction for RTCs that support PLL. The PLL correction
    that is set is specified by the rtc_pll_info structure pointed to by
    the third ioctl's' argument.

Implementation notes:

    All ioctls in this patch have a pointer to a structure rtc_pll_info
    as their third argument. All elements of this structure are of
    type 'int', except the last one that is of type 'long'. That is
    the reason why a separate target structure (target_rtc_pll_info)
    is defined in linux-user/syscall_defs. The rest of the
    implementation is straightforward.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Filip Bozuta <Filip.Bozuta@rt-rk.com>
Message-Id: <1579117007-7565-6-git-send-email-Filip.Bozuta@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  2 ++
 linux-user/syscall_defs.h  | 14 ++++++++++++++
 linux-user/syscall_types.h |  9 +++++++++
 3 files changed, 25 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index e4c1fbf52b1b..789764d11314 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -87,6 +87,8 @@
      IOCTL(RTC_EPOCH_SET, IOC_W, TYPE_ULONG)
      IOCTL(RTC_WKALM_RD, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
      IOCTL(RTC_WKALM_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_wkalrm)))
+     IOCTL(RTC_PLL_GET, IOC_R, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
+     IOCTL(RTC_PLL_SET, IOC_W, MK_PTR(MK_STRUCT(STRUCT_rtc_pll_info)))
 
      IOCTL(BLKROSET, IOC_W, MK_PTR(TYPE_INT))
      IOCTL(BLKROGET, IOC_R, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index c33432a374e5..9f7aad49c683 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -763,6 +763,16 @@ struct target_pollfd {
 #define TARGET_KDSETLED        0x4B32	/* set led state [lights, not flags] */
 #define TARGET_KDSIGACCEPT     0x4B4E
 
+struct target_rtc_pll_info {
+    int pll_ctrl;
+    int pll_value;
+    int pll_max;
+    int pll_min;
+    int pll_posmult;
+    int pll_negmult;
+    abi_long pll_clock;
+};
+
 /* real time clock ioctls */
 #define TARGET_RTC_AIE_ON           TARGET_IO('p', 0x01)
 #define TARGET_RTC_AIE_OFF          TARGET_IO('p', 0x02)
@@ -782,6 +792,10 @@ struct target_pollfd {
 #define TARGET_RTC_EPOCH_SET        TARGET_IOW('p', 0x0e, abi_ulong)
 #define TARGET_RTC_WKALM_RD         TARGET_IOR('p', 0x10, struct rtc_wkalrm)
 #define TARGET_RTC_WKALM_SET        TARGET_IOW('p', 0x0f, struct rtc_wkalrm)
+#define TARGET_RTC_PLL_GET          TARGET_IOR('p', 0x11,                      \
+                                               struct target_rtc_pll_info)
+#define TARGET_RTC_PLL_SET          TARGET_IOW('p', 0x12,                      \
+                                               struct target_rtc_pll_info)
 
 #if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_SH4) ||    \
        defined(TARGET_XTENSA)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 3efa9536ccfa..5ba4155047ba 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -271,6 +271,15 @@ STRUCT(rtc_wkalrm,
        TYPE_CHAR, /* pending */
        MK_STRUCT(STRUCT_rtc_time)) /* time */
 
+STRUCT(rtc_pll_info,
+       TYPE_INT, /* pll_ctrl */
+       TYPE_INT, /* pll_value */
+       TYPE_INT, /* pll_max */
+       TYPE_INT, /* pll_min */
+       TYPE_INT, /* pll_posmult */
+       TYPE_INT, /* pll_negmult */
+       TYPE_LONG) /* pll_clock */
+
 STRUCT(blkpg_ioctl_arg,
        TYPE_INT, /* op */
        TYPE_INT, /* flags */
-- 
2.24.1


