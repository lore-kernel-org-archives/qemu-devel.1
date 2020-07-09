Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A59C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC382078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 15:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=syrmia.com header.i=@syrmia.com header.b="iD49jeqp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC382078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=syrmia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtYuW-0007LM-SF
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 11:56:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr4-0002kU-S0
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:58 -0400
Received: from mail-eopbgr40114.outbound.protection.outlook.com
 ([40.107.4.114]:3260 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Filip.Bozuta@syrmia.com>)
 id 1jtYr2-0006dz-Ux
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 11:52:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O++m3JLR4iVEhYz43pWNEtNK1WSdGxVZHsKi8kDr4Owlo2C5pkE+Y3Oh5sX4+b0cFr3L9mBayrlwEMv4g8NG5B1ZrrkHfJA+oFT66QrMERWwwm0N0bogigP7PJBiXLSQLYSFVv/0Cs18zy61+HPH62zrFlnnucUdqS5o226wk5yc15p8AoMg75gPJdbeftqJ/2eKnGBpWgBw6wNDPJBk2DRZ1P9bCG/F7xNxP5ZASn+FaoXnL9BpwRvzz0VSmUkHY/oH1HIFWdcHo/BF6lFuEvWYKwz3RDZBxYnz6wd6o98KgS5oWz9ng+k2pm6MRZuDNKGmzVETxRXHiqeANpGSfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPLAH/G9vgWPTku/SYzbQHovQwheNJ2U+WpCD4xjPRc=;
 b=mZLC04FXvYsO3S0LAGdVklfPxwmmP+GgTnx9T5d1Erbra+Ae6s/qnsK+dlRe1q84lVBvVdriSUdhmCZ/LPclGYqgNlAVpwrgggFZhlBvXZwXpeBI9qtavrwkDn/9K4H9QVEhGXzTLI4sEMmic+JMoeKvWyz+eRaL/D8EG07gN4ywE3aEIiYB5KHexqfTtfr8ZE95Hrum281qdN4d7freTnybFcWiuePHu578IPObU2lHW1JeiIGhLUf7j85gNhf9M28kjKRg/WMzmuXHW4BKJl3F3C0LQGSUYKxTI5GtlyWRFR5OKkEB4LWMRGmQA+kKtYIbjxTUIJJItiuTye6I8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=syrmia.com; dmarc=pass action=none header.from=syrmia.com;
 dkim=pass header.d=syrmia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrmia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPLAH/G9vgWPTku/SYzbQHovQwheNJ2U+WpCD4xjPRc=;
 b=iD49jeqp2QCb7opGMx10n6YASqnWXv2LQdqIlOdwsIvm7p7o/iMuqKBMy9F0lUrXnEaqvRiHz2oMvRUwJgejVtJHLA8VYbtpunjiTL+U2miOxmCc0Xf5jiQN9W82AyeE5dx4nk4zVJ8pcOlBjErsR4zay4zsF0RQZUbV1apQfDo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=syrmia.com;
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com (2603:10a6:20b:d1::19)
 by AM6PR0302MB3223.eurprd03.prod.outlook.com (2603:10a6:209:1d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Thu, 9 Jul
 2020 15:52:21 +0000
Received: from AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618]) by AM6PR03MB5233.eurprd03.prod.outlook.com
 ([fe80::98f0:b948:78a8:f618%7]) with mapi id 15.20.3174.021; Thu, 9 Jul 2020
 15:52:21 +0000
From: Filip Bozuta <Filip.Bozuta@syrmia.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] linux-user: Add support for a group of btrfs ioctls used
 for subvolumes
Date: Thu,  9 Jul 2020 17:52:00 +0200
Message-Id: <20200709155203.21106-2-Filip.Bozuta@syrmia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
References: <20200709155203.21106-1-Filip.Bozuta@syrmia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AM6PR03MB5233.eurprd03.prod.outlook.com
 (2603:10a6:20b:d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (109.245.225.24) by
 AM3PR07CA0147.eurprd07.prod.outlook.com (2603:10a6:207:8::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.8 via Frontend Transport; Thu, 9 Jul 2020 15:52:20 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [109.245.225.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 947df85a-4bd5-4844-523d-08d8242010a8
X-MS-TrafficTypeDiagnostic: AM6PR0302MB3223:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0302MB322310527C0E025D74FABEF5EB640@AM6PR0302MB3223.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04599F3534
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OgCMJg9JFLintZH0/OolZPYTISyAD5euEpFFkY0rnsql/SmFSsYpmcSH00bOwf2wRuybGktmNLOXcAJwxhz+AW17XwFwew57qf3LRbLl8dlfqZhrI+4kIjdwe6mPuTfmdX1rlw6sGtUfwdWtS8tBTxudx1ptNfYGQN3W1y7dFbozAKMB3FQaTakgcWbqa5kYEKtFa/vtT7VNzs3yy+F/jWs3qJEJ716WSHdG130/ZSNWoS73GCVj40RR0IhsBfeJPa17gBaEF6Q7jpyVJjfgRvCx6I0qmDc4dXfdD4pZg0qJ1Jj+YzwY4LelsX3bNa6KJ8I/2igTEme0HnOXBassA5AAQkqEaQGvBuAE1ZSwQ6cg6CromDE7haBwIb+8XGSk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR03MB5233.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(376002)(396003)(39830400003)(366004)(136003)(346002)(66946007)(66476007)(16526019)(186003)(66556008)(26005)(36756003)(52116002)(2616005)(956004)(6506007)(6916009)(107886003)(2906002)(6486002)(83380400001)(54906003)(6512007)(86362001)(1076003)(4326008)(8676002)(508600001)(5660300002)(316002)(6666004)(69590400007)(8936002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Q4MvKjJ6ImLlWxnWu3ZR8BjKw3VexPo0hOOAvlNymvpiVCuJu7AC89FRYQ+kFmgJFtfliOKI9SgJt+U46P23lJUzUpKGxZZinXVPmkblYxNI/x9Z4RC6S55lCkRdTAqJVNodOFcfYEDAWO0w9ni60DGDUXyAKRk/GWE01CH5NQCNZHKwcmec6e+2Nz6rP0IJ4Ky3QxLpSQCwvA3opZuHroYK+1GwRao9LweUHpZTicLrkhr2apXlk7wElzOyXdQFum9qvf9MMsKM0XcIaGH/rBwjYDJkrgS3cE2y1yp910tdPVVRCAoN+u51t+k298264gaTaTUodeCouQHNgDvBj48tXXpa6EH7aQ82GsmHxSuf/b33+5zDquXzrx4S7gUYd7BZTURsECOFD2qGhXjgyIKBLKyeLln0hwFtz05fvAoH4foOjl9NmNoDoSkwqEUOtdgkwLKkEoeCDNaTB54w7po71mLY8a26/LJ43KuahrY=
X-OriginatorOrg: syrmia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947df85a-4bd5-4844-523d-08d8242010a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2020 15:52:21.2413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 19214a73-c1ab-4e19-8f59-14bdcb09a66e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klwWcg6BeuvrCy3GXseCYFyTStdOPcTqL5IMbPRWhbI0fIjowTzZoD6QW+q3KCbTyHTWCf1bjxBwzWBBIUn+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0302MB3223
Received-SPF: pass client-ip=40.107.4.114;
 envelope-from=Filip.Bozuta@syrmia.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 11:52:55
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch implements functionality of following ioctls:

BTRFS_IOC_SUBVOL_CREATE - Creating a btrfs subvolume

    Create a btrfs subvolume. The subvolume is created using the ioctl's
    third argument which represents a pointer to a following structure
    type:

    struct btrfs_ioctl_vol_args {
	__s64 fd;
	char name[BTRFS_PATH_NAME_MAX + 1];
    };

    Before calling this ioctl, the fields of this structure should be filled
    with aproppriate values. The fd field represents the file descriptor
    value of the subvolume and the name field represents the subvolume
    path.

BTRFS_IOC_SUBVOL_GETFLAGS - Getting subvolume flags

    Read the flags of the btrfs subvolume. The flags are read using
    the ioctl's third argument that is a pointer of __u64 (unsigned long).
    The third argument represents a bit mask that can be composed of following
    values:
    BTRFS_SUBVOL_RDONLY           (1ULL << 1)
    BTRFS_SUBVOL_QGROUP_INHERIT   (1ULL << 2)
    BTRFS_DEVICE_SPEC_BY_ID       (1ULL << 3)
    BTRFS_SUBVOL_SPEC_BY_ID       (1ULL << 4)

BTRFS_IOC_SUBVOL_SETFLAGS - Setting subvolume flags

    Set the flags of the btrfs subvolume. The flags are set using the
    ioctl's third argument that is a pointer of __u64 (unsigned long).
    The third argument represents a bit mask that can be composed of same
    values as in the case of previous ioctl (BTRFS_IOC_SUBVOL_GETFLAGS).

BTRFS_IOC_SUBVOL_GETINFO - Getting subvolume information

    Read information about the subvolume. The subvolume information is
    returned in the ioctl's third argument which represents a pointer to
    a following structure type:

    struct btrfs_ioctl_get_subvol_info_args {
	/* Id of this subvolume */
	__u64 treeid;

	/* Name of this subvolume, used to get the real name at mount point */
	char name[BTRFS_VOL_NAME_MAX + 1];

	/*
	 * Id of the subvolume which contains this subvolume.
	 * Zero for top-level subvolume or a deleted subvolume.
	 */
	__u64 parent_id;

	/*
	 * Inode number of the directory which contains this subvolume.
	 * Zero for top-level subvolume or a deleted subvolume
	 */
	__u64 dirid;

	/* Latest transaction id of this subvolume */
	__u64 generation;

	/* Flags of this subvolume */
	__u64 flags;

	/* UUID of this subvolume */
	__u8 uuid[BTRFS_UUID_SIZE];

	/*
	 * UUID of the subvolume of which this subvolume is a snapshot.
	 * All zero for a non-snapshot subvolume.
	 */
	__u8 parent_uuid[BTRFS_UUID_SIZE];

	/*
	 * UUID of the subvolume from which this subvolume was received.
	 * All zero for non-received subvolume.
	 */
	__u8 received_uuid[BTRFS_UUID_SIZE];

	/* Transaction id indicating when change/create/send/receive happened */
	__u64 ctransid;
	__u64 otransid;
	__u64 stransid;
	__u64 rtransid;
	/* Time corresponding to c/o/s/rtransid */
	struct btrfs_ioctl_timespec ctime;
	struct btrfs_ioctl_timespec otime;
	struct btrfs_ioctl_timespec stime;
	struct btrfs_ioctl_timespec rtime;

	/* Must be zero */
	__u64 reserved[8];
     };

     All of the fields of this structure are filled after the ioctl call.

Implementation notes:

    Ioctls BTRFS_IOC_SUBVOL_CREATE and BTRFS_IOC_SUBVOL_GETINFO have structure
    types as third arguments. That is the reason why a corresponding definition
    are added in file 'linux-user/syscall_types.h'.

    The line '#include <linux/btrfs.h>' is added in file 'linux-user/syscall.c' to
    recognise preprocessor definitions for these ioctls. Since the file "linux/btrfs.h"
    was added in the kernel version 3.9, it is enwrapped in an #ifdef statement
    with parameter CONFIG_BTRFS which is defined in 'configure' if the
    header file is present.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
---
 configure                  |  9 +++++++++
 linux-user/ioctls.h        | 15 +++++++++++++++
 linux-user/syscall.c       |  3 +++
 linux-user/syscall_defs.h  | 10 ++++++++++
 linux-user/syscall_types.h | 28 ++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+)

diff --git a/configure b/configure
index b969dee675..8b3b214031 100755
--- a/configure
+++ b/configure
@@ -4945,6 +4945,12 @@ if check_include sys/kcov.h ; then
     kcov=yes
 fi
 
+# check for btrfs filesystem support (kernel must be 3.9+)
+btrfs=no
+if check_include linux/btrfs.h ; then
+    btrfs=yes
+fi
+
 # If we're making warnings fatal, apply this to Sphinx runs as well
 sphinx_werror=""
 if test "$werror" = "yes"; then
@@ -7057,6 +7063,9 @@ fi
 if test "$kcov" = "yes" ; then
   echo "CONFIG_KCOV=y" >> $config_host_mak
 fi
+if test "$btrfs" = "yes" ; then
+  echo "CONFIG_BTRFS=y" >> $config_host_mak
+fi
 if test "$inotify" = "yes" ; then
   echo "CONFIG_INOTIFY=y" >> $config_host_mak
 fi
diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 0defa1d8c1..544184ff95 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -174,6 +174,21 @@
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef BTRFS_IOC_SUBVOL_CREATE
+     IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
+#ifdef BTRFS_IOC_SUBVOL_GETFLAGS
+     IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
+#endif
+#ifdef BTRFS_IOC_SUBVOL_SETFLAGS
+     IOCTL(BTRFS_IOC_SUBVOL_SETFLAGS, IOC_W, MK_PTR(TYPE_ULONGLONG))
+#endif
+#ifdef BTRFS_IOC_GET_SUBVOL_INFO
+     IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
+#endif
+
 #ifdef CONFIG_USBFS
   /* USB ioctls */
   IOCTL(USBDEVFS_CONTROL, IOC_RW,
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 05f03919ff..4a65b28999 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -112,6 +112,9 @@
 #include <linux/if_alg.h>
 #include <linux/rtc.h>
 #include <sound/asound.h>
+#ifdef CONFIG_BTRFS
+#include <linux/btrfs.h>
+#endif
 #include "linux_loop.h"
 #include "uname.h"
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 152ec637cb..c11bcc6ba9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -967,6 +967,16 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_GETVERSION TARGET_IOR('v', 1, int)
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
+/* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                               14, struct btrfs_ioctl_vol_args)
+#define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                                           25, abi_ullong)
+#define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, \
+                                                           26, abi_ullong)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IOR(BTRFS_IOCTL_MAGIC, \
+                                   60, struct btrfs_ioctl_get_subvol_info_args)
+
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
 #define TARGET_USBDEVFS_BULK TARGET_IOWRU('U', 2)
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 4e12c1661e..75ce6482ea 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -321,6 +321,34 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
+STRUCT(btrfs_ioctl_vol_args,
+       TYPE_LONGLONG, /* fd */
+       MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
+
+STRUCT(btrfs_ioctl_timespec,
+       TYPE_ULONGLONG, /* sec */
+       TYPE_INT) /* nsec */
+
+STRUCT(btrfs_ioctl_get_subvol_info_args,
+       TYPE_ULONGLONG, /* treeid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_VOL_NAME_MAX + 1),
+       TYPE_ULONGLONG, /* parentid */
+       TYPE_ULONGLONG, /* dirid */
+       TYPE_ULONGLONG, /* generation */
+       TYPE_ULONGLONG, /* flags */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* uuid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* parent_uuid */
+       MK_ARRAY(TYPE_CHAR, BTRFS_UUID_SIZE), /* received_uuid */
+       TYPE_ULONGLONG, /* ctransid */
+       TYPE_ULONGLONG, /* otransid */
+       TYPE_ULONGLONG, /* stransid */
+       TYPE_ULONGLONG, /* rtransid */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* ctime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* otime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* stime */
+       MK_STRUCT(STRUCT_btrfs_ioctl_timespec), /* rtime */
+       MK_ARRAY(TYPE_ULONGLONG, 8)) /* reserved */
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.25.1


