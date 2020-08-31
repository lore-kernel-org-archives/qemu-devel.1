Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF72C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E8AA2072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:11:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E8AA2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChin-0006qJ-DB
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChew-0007CS-15
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45437)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChet-0000Rx-6P
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:33 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt7x1-1kSA0S2TUX-00tPa2; Mon, 31 Aug 2020 13:07:25 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 8/8] linux-user: Add support for btrfs ioctls used to scrub a
 filesystem
Date: Mon, 31 Aug 2020 13:07:16 +0200
Message-Id: <20200831110716.536808-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831110716.536808-1-laurent@vivier.eu>
References: <20200831110716.536808-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CCW9AexK0GkcNm3W2pqEF7JSHqttkHMxdsJNxco1V5z4teWsW8f
 JAp+fG2Xl6x0wAyqbncqgZDiFcmGFUqKwPAgHemq3jsg24bYX3f+xrijgzXBnYU0zncOBm2
 SyTZ7ae/kwU62f2Grn/urwLAAfsNoHO8GAFy+xid3/U/GdPwx3Oy8ciAuJ2iI+q/eR3cDgU
 KNUle8NeeKF3vLOiqWTXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RSIf1ZjGfas=:gDihn2HzM3RIlTRM+d4uDn
 3I9tRWdiR4wa5Ok3n9o+viznjvkPnWgPb/36eL2RmXUrxgb7ohEoX5Vb5wBg5eEA04NiDc8PP
 DkCnFYcXND8Qt0FUGLQm7e0bLqSnXmRlHchkcEMLdLTaROmh5FsnsN/HNc6XUnwoXya25jZH9
 vV+Ae6IKQoHkNyl2+WDvX3yNNslkcVTz8wE+IToukkV7aXhOe/PnvovmBl4O/7m56f94dn7Mu
 zfTKEHBquL2EQfbwPmDGoSkCArDmQi2RI6ufWy9aWZLISAkfd0px488+6aQOfJIygzVxphF0b
 4lo8Z6TrhK85bGortJGGMKy5lA4EzGci7CbJcMZK2GimIMOR03Qxhgf0TP0qRfDFtnZnhJvf9
 GsvUugwxwDIUAnN4THOM4Btre97W9oTXRNDg66y4D/VLt5AdrUBJX9Q2CmUHxKxP5kpAUAZiG
 pt0aLV88jfH/1m6Se1/jb+KeDQhA2ZzeIFTvWeUU7Gb3WEYqLQHltuqfIusdURJU3Yrv5+CrM
 2JX2oWP2lQL33pX+U46OkXcDnt19wS6dlisJB/1mXK9+hcANiD58Fb07tC3MaSv6R1m6AaeuC
 VYRaSLPr/zgu4zcYepZUQJJDSB/EuJQC8fEjuo+yOHKFgdypCOpIx+ono/X4nIs76E73Cw1fn
 PSMnMDCYJIiNhgli3ADZG5UGvuq+5RZAYGDcxNPAIhq3srvyHo7QhpBs+dcZtZV58ytKPwX06
 +xN26ZYX/1s2X5gmBY0ytOQw1lrqWPaME60eGxjuD9RX9Uc6/3z2k6LyPaODlRB2QZ9piEayH
 ai3P+5lQZgBVFNa6Yv1vdT7ZRPGUX877I/2tpfZg1wT6qCGVcbDnfWKQHzDMfEWW0xU/yyr
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:07:29
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
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following ioctls:

BTRFS_IOC_SCRUB - Starting a btrfs filesystem scrub

    Start a btrfs filesystem scrub. The third ioctls argument
    is a pointer to a following type:

    struct btrfs_ioctl_scrub_args {
	__u64 devid;				/* in */
	__u64 start;				/* in */
	__u64 end;				/* in */
	__u64 flags;				/* in */
	struct btrfs_scrub_progress progress;	/* out */
	/* pad to 1k */
	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
    };

    Before calling this ioctl, field 'devid' should be filled
    with value that represents the device id of the btrfs filesystem
    for which the scrub is to be started.

BTRFS_IOC_SCRUB_CANCEL - Canceling scrub of a btrfs filesystem

    Cancel a btrfs filesystem scrub if it is running. The third
    ioctls argument is ignored.

BTRFS_IOC_SCRUB_PROGRESS - Getting status of a running scrub

    Read the status of a running btrfs filesystem scrub. The third
    ioctls argument is a pointer to the above mentioned
    'struct btrfs_ioctl_scrub_args'. Similarly as with 'BTRFS_IOC_SCRUB',
    the 'devid' field should be filled with value that represents the
    id of the btrfs device for which the scrub has started. The status
    of a running scrub is returned in the field 'progress' which is
    of type 'struct btrfs_scrub_progress' and its definition can be
    found at:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L150

Implementation nots:

    Ioctls in this patch use type 'struct btrfs_ioctl_scrub_args' as their
    third argument. That is the reason why an aproppriate thunk type
    definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-9-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 11 +++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 42759c0778b4..585874f090ff 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -215,6 +215,17 @@
 #ifdef BTRFS_IOC_SUBVOL_SETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
 #endif
+#ifdef BTRFS_IOC_SCRUB
+     IOCTL(BTRFS_IOC_SCRUB, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
+#ifdef BTRFS_IOC_SCRUB_CANCEL
+     IOCTL(BTRFS_IOC_SCRUB_CANCEL, 0, TYPE_NULL)
+#endif
+#ifdef BTRFS_IOC_SCRUB_PROGRESS
+     IOCTL(BTRFS_IOC_SCRUB_PROGRESS, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_scrub_args)))
+#endif
 #ifdef BTRFS_IOC_DEV_INFO
      IOCTL(BTRFS_IOC_DEV_INFO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_dev_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index b557b07eec85..33a414c50f19 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1020,6 +1020,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
                                                            abi_ullong)
+#define TARGET_BTRFS_IOC_SCRUB                  TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 27)
+#define TARGET_BTRFS_IOC_SCRUB_CANCEL           TARGET_IO(BTRFS_IOCTL_MAGIC, 28)
+#define TARGET_BTRFS_IOC_SCRUB_PROGRESS         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 29)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 51d9931b9546..ba2c1518eb5c 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -425,6 +425,35 @@ STRUCT(btrfs_ioctl_ino_lookup_user_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_INO_LOOKUP_USER_PATH_MAX)) /* path */
 #endif
 
+#if defined(BTRFS_IOC_SCRUB) || defined(BTRFS_IOC_SCRUB_PROGRESS)
+STRUCT(btrfs_scrub_progress,
+       TYPE_ULONGLONG, /* data_extents_scrubbed */
+       TYPE_ULONGLONG, /* tree_extents_scrubbed */
+       TYPE_ULONGLONG, /* data_bytes_scrubbed */
+       TYPE_ULONGLONG, /* tree_bytes_scrubbed */
+       TYPE_ULONGLONG, /* read_errors */
+       TYPE_ULONGLONG, /* csum_errors */
+       TYPE_ULONGLONG, /* verify_errors */
+       TYPE_ULONGLONG, /* no_csum */
+       TYPE_ULONGLONG, /* csum_discards */
+       TYPE_ULONGLONG, /* super_errors */
+       TYPE_ULONGLONG, /* malloc_errors */
+       TYPE_ULONGLONG, /* uncorrectable_errors */
+       TYPE_ULONGLONG, /* corrected_er */
+       TYPE_ULONGLONG, /* last_physical */
+       TYPE_ULONGLONG) /* unverified_errors */
+
+STRUCT(btrfs_ioctl_scrub_args,
+       TYPE_ULONGLONG, /* devid */
+       TYPE_ULONGLONG, /* start */
+       TYPE_ULONGLONG, /* end */
+       TYPE_ULONGLONG, /* flags */
+       MK_STRUCT(STRUCT_btrfs_scrub_progress), /* progress */
+       MK_ARRAY(TYPE_ULONGLONG,
+                (1024 - 32 -
+                 sizeof(struct btrfs_scrub_progress)) / 8)) /* unused */
+#endif
+
 #ifdef BTRFS_IOC_DEV_INFO
 STRUCT(btrfs_ioctl_dev_info_args,
        TYPE_ULONGLONG, /* devid */
-- 
2.26.2


