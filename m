Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF22C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:32:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D290620773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:32:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D290620773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcFK-0004vH-0b
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43256)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9r-0003zw-O1
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:15 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9p-0004rX-BN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:15 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MIxBc-1jyp5l3FTW-00KLwg; Thu, 03 Sep 2020 01:27:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 8/9] linux-user: Add support for btrfs ioctls used to manage
 quota
Date: Thu,  3 Sep 2020 01:27:00 +0200
Message-Id: <20200902232701.13299-9-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902232701.13299-1-laurent@vivier.eu>
References: <20200902232701.13299-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:4LoZuQ0aKYF+V0XrqauX7l7GM6QsxtFiFZo6J5+o8WBr5Fb6+v5
 8xmlHQPmvS38nDswSOSlThZHCcpzxWjzXx4bl8kDJK41sqmTLCV0xnoIqFUEb+KQz1opV/v
 NCkUD0o1DMKKqD2O61MwOk7FIVVjYXMKzt2ug60XTH67+fT6mb5rsZxJ8FpRO6vthxfdVZl
 NZGtbWSK2VPpPJaCxg+iQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QIxwyCzdhZE=:IMVJnW9k2mi4PwUBgiiY23
 hr7LMo1ygK/qXcYGBHkVIFd5RsI80LwxfQXl0v9F4s8IcMtnu7ZGZ5ZND2wL0VSeFChtGWn8C
 NROR8ATGdV2SaWknBALwox+X4WxjEtcVS4HJJ2XsYuzlyIf7lKGHX4ZWWaOhzvQFXJ2cREXQn
 yqWywZVphpKhducaOVj0EzaI0bW/hBBxqFHtH9YX1mfbpkC87901kX1Inn2vr2mh21xO29jHT
 A5e1DOKCSVUxhj8U4NcdqsJZco3APtH3ldprNsewlODlXfod8D/D4x7i+Jk7sVhZkcXE+nv0l
 EIE1a/ktgWWaS1YxUQ0wnPbX26X+AskVG7NRf0C2you7FFrx8LDELqgA0XfpdeIzCT0ZiCkvb
 uOGt/trwgdO1Cg/W0xjtr+wV4lcXamulH+ddWjUHzTyRIqO+DgfJEPw+2/hybCplAuATXQiHr
 Hq9rSW2Iv40PK7MKLsGHUwaQnm0iGnLqcWTOd4Ip7ep/Qg8X/Wjce0+hL+NFWpB1AStaiayvQ
 ZLvcuiGv0JyAp7QsSR/YUqRcWP9WJpPit5Dc9SS7QAM1bnrrFa074g+2gyZXbnwVT9B/9GEWG
 9/P4yGppiK44I/HxQFViU1syi17wPfWJMY6aRBxag62djw/tUD+qHHKnCB1IDIIyIDVE1C2FQ
 EnvkCAO05mcmmkoZzNakc4NqumcZGFPawL8Z+nt9+aTlIedj7jSUmU6OCBhicC6sUpdRTTI+j
 i4OfDT7bTJ+MwhOoSyUp223l1pNdpMqKjGVpQA1AAHOlgXyxOc1R8pW5A8beZ5Krx8ulz4Gog
 CnHmGS1Lmum26VdkXsDx5tpQDKRRziWPi9KpRbevc7uEsBhH/ujldppP0n96Yx6dLzkS281
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:27:04
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

BTRFS_IOC_QUOTA_CTL - Enabling/Disabling quota support

    Enable or disable quota support for a btrfs filesystem. Quota
    support is enabled or disabled using the ioctls third argument
    which represents a pointer to a following type:

    struct btrfs_ioctl_quota_ctl_args {
	__u64 cmd;
	__u64 status;
    };

    Before calling this ioctl, the 'cmd' field should be filled
    with one of the values 'BTRFS_QUOTA_CTL_ENABLE' (enabling quota)
    'BTRFS_QUOTA_CTL_DISABLE' (disabling quota).

BTRFS_IOC_QGROUP_CREATE - Creating/Removing a subvolume quota group

    Create or remove a subvolume quota group. The subvolume quota
    group is created or removed using the ioctl's third argument which
    represents a pointer to a following type:

    struct btrfs_ioctl_qgroup_create_args {
	__u64 create;
	__u64 qgroupid;
    };

    Before calling this ioctl, the 'create' field should be filled
    with the aproppriate value depending on if the user wants to
    create or remove a quota group (0 for removing, everything else
    for creating). Also, the 'qgroupid' field should be filled with
    the value for the quota group id that is to be created.

BTRFS_IOC_QGROUP_ASSIGN - Asigning or removing a quota group as child group

    Asign or remove a quota group as child quota group of another
    group in the btrfs filesystem. The asignment is done using the
    ioctl's third argument which represents a pointert to a following type:

    struct btrfs_ioctl_qgroup_assign_args {
	__u64 assign;
	__u64 src;
	__u64 dst;
    };

    Before calling this ioctl, the 'assign' field should be filled with
    the aproppriate value depending on if the user wants to asign or remove
    a quota group as a child quota group of another group (0 for removing,
    everythin else for asigning). Also, the 'src' and 'dst' fields should
    be filled with the aproppriate quota group id values depending on which
    quota group needs to asigned or removed as child quota group of another
    group ('src' gets asigned or removed as child group of 'dst').

BTRFS_IOC_QGROUP_LIMIT - Limiting the size of a quota group

    Limit the size of a quota group. The size of the quota group is limited
    with the ioctls third argument which represents a pointer to a following
    type:

    struct btrfs_ioctl_qgroup_limit_args {
	__u64	qgroupid;
	struct btrfs_qgroup_limit lim;
    };

    Before calling this ioctl, the 'qgroup' id field should be filled with
    aproppriate value of the quota group id for which the size is to be
    limited. The second field is of following type:

    struct btrfs_qgroup_limit {
	__u64	flags;
	__u64	max_rfer;
	__u64	max_excl;
	__u64	rsv_rfer;
	__u64	rsv_excl;
    };

    The 'max_rfer' field should be filled with the size to which the quota
    group should be limited. The 'flags' field can be used for passing
    additional options and can have values which can be found on:
    https://elixir.bootlin.com/linux/latest/source/include/uapi/linux/btrfs.h#L67

BTRFS_IOC_QUOTA_RESCAN_STATUS - Checking status of running rescan operation

    Check status of a running rescan operation. The status is checked using
    the ioctl's third argument which represents a pointer to a following type:

    struct btrfs_ioctl_quota_rescan_args {
        __u64   flags;
        __u64   progress;
        __u64   reserved[6];
    };

    If there is a rescan operation running, 'flags' field is set to 1, and
    'progress' field is set to aproppriate value which represents the progress
    of the operation.

BTRFS_IOC_QUOTA_RESCAN - Starting a rescan operation

    Start ar rescan operation to Trash all quota groups and scan the metadata
    again with the current config. Before calling this ioctl,
    BTRFS_IOC_QUOTA_RESCAN_STATUS sould be run to check if there is already a
    rescan operation runing. After that ioctl call, the received
    'struct btrfs_ioctl_quota_rescan_args' should be than passed as this ioctls
    third argument.

BTRFS_IOC_QUOTA_RESCAN_WAIT - Waiting for a rescan operation to finish

    Wait until a rescan operation is finished (if there is a rescan operation
    running). The third ioctls argument is ignored.

Implementation notes:

    Almost all of the ioctls in this patch use structure types as third arguments.
    That is the reason why aproppriate thunk definitions were added in file
    'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-8-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 27 +++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  7 +++++++
 linux-user/syscall_types.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index dc2f3d2413ed..42759c0778b4 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -227,6 +227,33 @@
      IOCTL(BTRFS_IOC_LOGICAL_INO, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_logical_ino_args)))
 #endif
+#ifdef BTRFS_IOC_QUOTA_CTL
+     IOCTL(BTRFS_IOC_QUOTA_CTL, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_ctl_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_ASSIGN
+     IOCTL(BTRFS_IOC_QGROUP_ASSIGN, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_assign_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_CREATE
+     IOCTL(BTRFS_IOC_QGROUP_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_create_args)))
+#endif
+#ifdef BTRFS_IOC_QGROUP_LIMIT
+     IOCTL(BTRFS_IOC_QGROUP_LIMIT, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_qgroup_limit_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN_STATUS
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN_STATUS, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_quota_rescan_args)))
+#endif
+#ifdef BTRFS_IOC_QUOTA_RESCAN_WAIT
+     IOCTL(BTRFS_IOC_QUOTA_RESCAN_WAIT, 0, TYPE_NULL)
+#endif
 #ifdef BTRFS_IOC_GET_DEV_STATS
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index bb60c728d81a..b557b07eec85 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1023,6 +1023,13 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_INO_PATHS              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 35)
 #define TARGET_BTRFS_IOC_LOGICAL_INO            TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 36)
+#define TARGET_BTRFS_IOC_QUOTA_CTL              TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 40)
+#define TARGET_BTRFS_IOC_QGROUP_ASSIGN          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 41)
+#define TARGET_BTRFS_IOC_QGROUP_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 42)
+#define TARGET_BTRFS_IOC_QGROUP_LIMIT           TARGET_IORU(BTRFS_IOCTL_MAGIC, 43)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 44)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_STATUS    TARGET_IORU(BTRFS_IOCTL_MAGIC, 45)
+#define TARGET_BTRFS_IOC_QUOTA_RESCAN_WAIT      TARGET_IO(BTRFS_IOCTL_MAGIC, 46)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
 #define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 73e36620cedc..51d9931b9546 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -458,6 +458,35 @@ STRUCT(btrfs_ioctl_get_dev_stats,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 #endif
 
+STRUCT(btrfs_ioctl_quota_ctl_args,
+       TYPE_ULONGLONG, /* cmd */
+       TYPE_ULONGLONG) /* status */
+
+STRUCT(btrfs_ioctl_quota_rescan_args,
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG, /* progress */
+       MK_ARRAY(TYPE_ULONGLONG, 6)) /* reserved */
+
+STRUCT(btrfs_ioctl_qgroup_assign_args,
+       TYPE_ULONGLONG, /* assign */
+       TYPE_ULONGLONG, /* src */
+       TYPE_ULONGLONG) /* dst */
+
+STRUCT(btrfs_ioctl_qgroup_create_args,
+       TYPE_ULONGLONG, /* create */
+       TYPE_ULONGLONG) /* qgroupid */
+
+STRUCT(btrfs_qgroup_limit,
+       TYPE_ULONGLONG, /* flags */
+       TYPE_ULONGLONG, /* max_rfer */
+       TYPE_ULONGLONG, /* max_excl */
+       TYPE_ULONGLONG, /* rsv_rfer */
+       TYPE_ULONGLONG) /* rsv_excl */
+
+STRUCT(btrfs_ioctl_qgroup_limit_args,
+       TYPE_ULONGLONG, /* qgroupid */
+       MK_STRUCT(STRUCT_btrfs_qgroup_limit)) /* lim */
+
 STRUCT(btrfs_ioctl_feature_flags,
        TYPE_ULONGLONG, /* compat_flags */
        TYPE_ULONGLONG, /* compat_ro_flags */
-- 
2.26.2


