Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21905C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:29:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE4C20782
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 16:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE4C20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrl2V-0002gn-8e
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 12:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzX-0005UJ-Qv
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:15 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:49483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jrkzT-0002Pj-V3
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 12:26:15 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mq2rM-1keYCx3cLS-00nBG7; Sat, 04 Jul 2020 18:26:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] linux-user: Add thunk argument types for SIOCGSTAMP and
 SIOCGSTAMPNS
Date: Sat,  4 Jul 2020 18:25:43 +0200
Message-Id: <20200704162545.311133-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200704162545.311133-1-laurent@vivier.eu>
References: <20200704162545.311133-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pTTCOxm2ObIFqhLPF/KT8+Fby1UqCBeHIhaRvTpY31mrNZRQrPT
 iMsJmXhASEu77lIURFFp52J8U9lPS1MrSkOVXVu8/BAqOxi1hYrF9lfd7Lq6cZDYMIq0oyZ
 KqFS/wN2TZZVuX3RVe8CXi9JWe4kwJ3oBBqsMoV66wXTGuJdKq56gWKJoKbJEuQcA2L+tN5
 ups1U59LsX+M3KSYJvyYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rv6DaqYj6K4=:6xM3IcwC1R7bl+7SQ0VJuJ
 2zkPdYL9kOAYwmY+Dm0uMg7LVmBxsRm9kag+gmWfZmSYFjbSxHiQMifr4tUGEHf4FGvboUutZ
 oq5Rzgr5Uue35Ql33bGXAscW12omMGjUEwpChwcIcwWfWthD1W6/TM8Zy3BN0GZj2oIMwBd+V
 21h0AoQQXrSVd3IBmB6ioIgOcR4jV/B7Oyp7vipkZYOtHHY+kUttiBAMmYeIFmowUfd8/1Yrp
 I3Qr51yWO6t8vGdUe8B6JIu91hVG3louz0/XKkllytzdDwZJLW157jqZGAQiSjW67ZtklPSbL
 oRTC3n398ux2PpbBm97kb0spyY+AfiH3yHEQsOfG+RD9J25u3WOlNI1fikCB87D/vQBoTjaAf
 Dlx791k8kWIFJPWG4Be4mpuu8rW3u9uEi6YewHJVi+C/6oVUtqa9H/AwvDI9gbZNZwP5n7lXN
 0EvWRqifkISyjjPzrvaUD/ZSjPAqYOr8rt7I469Gb4kC18BQeCPsMVHGpv5MsAv83krBuhKUn
 RNIXlQVQwttPQDZMnZIvcg2ERyArPId+D5WH5usOHT+qwwSkUqDSNOZ/1aPOjfXRMWQjgb5p/
 CqAYNY39WF70u6Q9vWv+g14USqzhQJGli44blwnEjvP/FpLMAVAnmWrP/Xf1VVuYm/91Nh3D1
 PICJq9YAj25dXcdO++sgjwJchGin9tf4arjKdSI2wjaLXH7jNgEVo31nvq5gle9ye2HbCcTvF
 dv6KAoEw6PsOJnlOWslW+FMuuncU+431DOt+PyMehowcid2o9Hq5sUDDKSiOjQVg6PMwzvE/x
 FeOXypCf2oWJdn/eDfXLPGyYdTBgrbqa6n3FyxmvVrZ5fLiMHM=
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 12:25:54
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>, Riku Voipio <riku.voipio@iki.fi>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Socket ioctls SIOCGSTAMP and SIOCGSTAMPNS, used for timestamping the socket
connection, are defined in file "ioctls.h" differently from other ioctls.
The reason for this difference is explained in the comments above their definition.
These ioctls didn't have defined thunk argument types before changes from this
patch. They have special handling functions ("do_ioctl_SIOCGSTAMP" and
"do_ioctl_SIOCGSTAMPNS") that take care of setting values for approppriate argument
types (struct timeval and struct timespec) and thus no thunk argument types were
needed for their implementation. But this patch adds those argument type definitions
in file "syscall_types.h" and "ioctls.h" as it is needed for printing arguments
of these ioctls with strace.

Implementation notes:

    There are two variants of these ioctls: SIOCGSTAMP_OLD/SIOCGSTAM_NEW and
    SIOCGSTAMPNS_OLD/SIOCGSTAMPNS_NEW. One is the old existing definition and the
    other is the 2038 safe variant used for 32-bit architectures. Corresponding
    structure definitions STRUCT_timespec/STRUCT__kernel_timespec and
    STRUCT_timeval/STRUCT__kernel_sock_timeval were added for these variants.
    STRUCT_timeval definition was already inside the file as it is used by
    another implemented ioctl. Two cases were added for definitions
    STRUCT_timeval/STRUCT__kernel_sock_timeval to manage the case when the
    "u_sec" field of the timeval structure is of type int.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200619124727.18080-2-filip.bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 12 ++++++++----
 linux-user/syscall_types.h | 22 ++++++++++++++++++++++
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index f2e2fa9c878b..0713ae131162 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -279,13 +279,17 @@
    * FIXME: create a macro to define this kind of entry
    */
   { TARGET_SIOCGSTAMP_OLD, TARGET_SIOCGSTAMP_OLD,
-    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_OLD", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT_timeval)) } },
   { TARGET_SIOCGSTAMPNS_OLD, TARGET_SIOCGSTAMPNS_OLD,
-    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_OLD", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT_timespec)) } },
   { TARGET_SIOCGSTAMP_NEW, TARGET_SIOCGSTAMP_NEW,
-    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP },
+    "SIOCGSTAMP_NEW", IOC_R, do_ioctl_SIOCGSTAMP,
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_sock_timeval)) } },
   { TARGET_SIOCGSTAMPNS_NEW, TARGET_SIOCGSTAMPNS_NEW,
-    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS },
+    "SIOCGSTAMPNS_NEW", IOC_R, do_ioctl_SIOCGSTAMPNS,
+    { MK_PTR(MK_STRUCT(STRUCT__kernel_timespec)) } },
 
   IOCTL(RNDGETENTCNT, IOC_R, MK_PTR(TYPE_INT))
   IOCTL(RNDADDTOENTCNT, IOC_W, MK_PTR(TYPE_INT))
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index e2b0484f50e5..3f1f0334649b 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -137,10 +137,32 @@ STRUCT(snd_timer_params,
        TYPE_INT, /* filter */
        MK_ARRAY(TYPE_CHAR, 60)) /* reserved */
 
+#if defined(TARGET_SPARC64) && !defined(TARGET_ABI32)
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_INT) /* tv_usec */
+#else
+STRUCT(timeval,
+       TYPE_LONG, /* tv_sec */
+       TYPE_LONG) /* tv_usec */
+
+STRUCT(_kernel_sock_timeval,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_usec */
+#endif
+
 STRUCT(timespec,
        TYPE_LONG, /* tv_sec */
        TYPE_LONG) /* tv_nsec */
 
+STRUCT(_kernel_timespec,
+       TYPE_LONGLONG, /* tv_sec */
+       TYPE_LONGLONG) /* tv_nsec */
+
 STRUCT(snd_timer_status,
        MK_STRUCT(STRUCT_timespec), /* tstamp */
        TYPE_INT, /* resolution */
-- 
2.26.2


