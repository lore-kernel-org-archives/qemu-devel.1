Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A56C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1B420748
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1B420748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Km-0006B7-Tm
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17d-0000jY-MV
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37185)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jr17Z-0006KA-ED
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:27:33 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MQdtO-1jUNd01ICk-00Nkn9; Thu, 02 Jul 2020 17:27:20 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 10/12] linux-user: Add thunk argument types for SIOCGSTAMP
 and SIOCGSTAMPNS
Date: Thu,  2 Jul 2020 17:27:08 +0200
Message-Id: <20200702152710.84602-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702152710.84602-1-laurent@vivier.eu>
References: <20200702152710.84602-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3nIlbLU+2yQQKq6NSedOQYPnM4aUXCiwBB0MsNrGnBnEO0mZ4Wd
 +g4kt6vYOXkWHWhNm3rwGXzTcCab14RncLgR2kk5c5u0mZXNVoUZTNz4UbhIjJHjk1TzaP+
 6hXO8b6Y29O8sN/KmHUaLgYYheSEwj8yTHvWAANWBIz3v2YXWCVxViBORyHUd1SgIXHO//u
 DU1/wx7bMEIJv4L6goCjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPLfRaGoZa0=:ZPpFdgIoaNyOjWACIrLNks
 uVrd8dUh2mgL+BnJmCDhEY3ipDFyqWqwj1jhYOD6CzoMInqPPUt274kE9GIoYSKMVLSB9WkOs
 2zdtESmCcwYmepS3ZXsSP+ZDqGYp0YeqziVqWytgui+RXoUYJ55bWVTBaE5CoLNbKmk/7CXj7
 76H+9Khmf+2KAqzM9JKjKx56Thv3+NEzBwY7lfaZU7chkRvqcqYrfBRjFJOSIyPNI8MiluQKH
 MRp1TUukxi3Sv33eoKC55RVmXVn0FDMV5Td1IuMuikyt7OdDivSQw1ym4qRfDoe+SCdi/cnP1
 XTH2L5tQk1gBOApsm+3v9I4h4hhw3PkonMV4aTQi2tbWNhxhOEj6hZo5YFZYuHVIeX2dArQAB
 7Zw8iYsXqwMqSC+GUPSg4xoFxioXlSgtn4Vw4fHW/Sada10yAAcEdkyTFoOhjPYjO4Q6wmLyr
 K4/hZDGCm07WWVzKsUk200wInGvDnQtVSVmpIbQ0DkYFoVR02bwji+Llfm3xs8znfdkAHdjhk
 o3rIjymNXDY0kGoz7gmnx5GIWxLOeeDPNVT3axaZjCh5tsu8FKKPkb001bnGxyGYh1AIj1HVZ
 Lrk8FVuAasOBPwWsmKclq6WWKKUQVtp/67NjR7miIg1yy9nfLFSeZvZhcbPtPmGA0M9U1kdHl
 d7uyFSAUgGrjyl9UK6bZ4SMTw9otdm9CJFbNEDoy2D3lBQ588ULQn+SHMYx+GWorvB1dhePnc
 n4PvZBJCIDjd0vUSMSIelJj07RrM57stSCPibZemgUjyQUIiwNs0vRLh9iM3gjdoxIZWyc8wd
 n43bVnQk2ZshMAk40dbA1Ux20rlHISWzCljPBTrpnYXZilHsoU=
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 11:27:18
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


