Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B90C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DC1E20679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 09:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DC1E20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3coq-0005Qg-F9
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 04:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j3ckN-0007fl-Ul
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j3ckM-00021I-6A
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:23 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:51747)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1j3ckL-0001zT-Ti
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 04:31:22 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPXxi-1ipn6j0nty-00MeF5; Mon, 17 Feb 2020 10:30:39 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] linux-user: arm: Update syscall numbers to kernel 5.5 level
Date: Mon, 17 Feb 2020 10:30:24 +0100
Message-Id: <20200217093031.678348-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200217093031.678348-1-laurent@vivier.eu>
References: <20200217093031.678348-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xV8OPr+iGQpgp75hl0fPszVQUBlZgkExTUQ5keuz3578te9q/Gx
 wXJZ3gu1PBX2dCCoVsWzfKyGN6Ln4+/Oc/MOUVJbT+uXrCv1gZ9YlCimTrNTAaEyAda5t25
 hWkAW/u9ubt9hda2qcKD3GvB/5Uv6+MmIn3vwyPGzINvhDE6WMksuAz0d9zu+flmZDK8GZO
 Dv5DQPXOkQqQq5+c3vDhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oPkIRVF9o80=:L65QFcTjy04A3GXaXNk4tO
 l8UQZnkOklj/wvbNsZXxmlPM8gaJw3RwFKLat+KsuLxEny8SDJmZ3YtQrlQCMaoaiAs5n6wEz
 sY9t0XUsX5QYML8JE1VdArks309ju7irGCEmX3tITzdmvcBvQDf3qv3k9hmG4z6XG31E1lr8r
 5U/gXCKYw0gaw114yLOBbODUaJnLcVOgpzMKhfvtq7S4Oyfv0IyjmqYOKcYgHxSd/M3ZEu1Xp
 oD26H/78iXUJ7B4bwaBtSMaffjU/xniPBjZv73qpDHVQ5mm48+Ke0PaS+pGUDghqJPOk5G/jl
 YqL8Z55UVP6w72coUZ9tFVE40dbdBVpkjBp0baSSiuG8ONd+EjTcs9omUMAdUMQoXr5zBPxvv
 oqDrOezvE5Yg163FJpQDc/ns+ArsQlZW2lKXlgQcK7rCxceVR1RVpcS2wlXpBjoDKStssgP60
 50/W2Jf62+BEQ1i4PUJy4kc55dXvPxdxxzgIHr3GytX/2TqnJTSHiU2DTX/dbhl1qwanQfd0K
 U71XeLJHF9ixnzX413B1m5DZ2RZ5s7jhSnPg3dT3my7PDYIX8UrwQF/t2AiYlbLzzDRba/yKC
 hYqRHlNrSURf2zmhw7zcsey/H2m2sUZ3eyFKQD4CXfJ4jhzSqKGnl44eK4jtCDggncDssf2SV
 yMfSucFqJeXpkh77U4eib3YIA0P+hRnP2nRdIIA09yHqjbSwLweOavGIJkfyE9Rp2T0Pozs7v
 WZzsOwWtvEBL5QFxLCVtnHYyl3tSJFCe3OOvsBQuf7MyYSQt3eZvwIF8NJXj0pudTfzr9LNNo
 Z0ie6yNo1kA195/Mx2guxMcGnJVJwZc7OtTMJ7X9Ik0w59jySSxF4EnsnbVzlYcCacnttyf
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Update arm syscall numbers based on Linux kernel v5.5.

CC: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1581596954-2305-3-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/arm/syscall_nr.h | 44 +++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/linux-user/arm/syscall_nr.h b/linux-user/arm/syscall_nr.h
index e7eda0d76658..6db9235f2bfd 100644
--- a/linux-user/arm/syscall_nr.h
+++ b/linux-user/arm/syscall_nr.h
@@ -399,5 +399,49 @@
 #define TARGET_NR_userfaultfd                  (388)
 #define TARGET_NR_membarrier                   (389)
 #define TARGET_NR_mlock2                       (390)
+#define TARGET_NR_copy_file_range              (391)
+#define TARGET_NR_preadv2                      (392)
+#define TARGET_NR_pwritev2                     (393)
+#define TARGET_NR_pkey_mprotect                (394)
+#define TARGET_NR_pkey_alloc                   (395)
+#define TARGET_NR_pkey_free                    (396)
+#define TARGET_NR_statx                        (397)
+#define TARGET_NR_rseq                         (398)
+#define TARGET_NR_io_pgetevents                (399)
+#define TARGET_NR_migrate_pages                (400)
+#define TARGET_NR_kexec_file_load              (401)
+/* 402 is unused */
+#define TARGET_NR_clock_gettime64              (403)
+#define TARGET_NR_clock_settime64              (404)
+#define TARGET_NR_clock_adjtime64              (405)
+#define TARGET_NR_clock_getres_time64          (406)
+#define TARGET_NR_clock_nanosleep_time64       (407)
+#define TARGET_NR_timer_gettime64              (408)
+#define TARGET_NR_timer_settime64              (409)
+#define TARGET_NR_timerfd_gettime64            (410)
+#define TARGET_NR_timerfd_settime64            (411)
+#define TARGET_NR_utimensat_time64             (412)
+#define TARGET_NR_pselect6_time64              (413)
+#define TARGET_NR_ppoll_time64                 (414)
+#define TARGET_NR_io_pgetevents_time64         (416)
+#define TARGET_NR_recvmmsg_time64              (417)
+#define TARGET_NR_mq_timedsend_time64          (418)
+#define TARGET_NR_mq_timedreceive_time64       (419)
+#define TARGET_NR_semtimedop_time64            (420)
+#define TARGET_NR_rt_sigtimedwait_time64       (421)
+#define TARGET_NR_futex_time64                 (422)
+#define TARGET_NR_sched_rr_get_interval_time64 (423)
+#define TARGET_NR_pidfd_send_signal            (424)
+#define TARGET_NR_io_uring_setup               (425)
+#define TARGET_NR_io_uring_enter               (426)
+#define TARGET_NR_io_uring_register            (427)
+#define TARGET_NR_open_tree                    (428)
+#define TARGET_NR_move_mount                   (429)
+#define TARGET_NR_fsopen                       (430)
+#define TARGET_NR_fsconfig                     (431)
+#define TARGET_NR_fsmount                      (432)
+#define TARGET_NR_fspick                       (433)
+#define TARGET_NR_pidfd_open                   (434)
+#define TARGET_NR_clone3                       (435)
 
 #endif
-- 
2.24.1


