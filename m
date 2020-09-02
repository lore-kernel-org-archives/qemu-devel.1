Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3861AC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B12920773
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12920773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDcEH-00041T-7T
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43228)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9p-0003vx-SI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:13 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kDc9n-0004rE-Fi
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 19:27:13 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mt6x5-1kXt3q13eL-00tPqb; Thu, 03 Sep 2020 01:27:07 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 7/9] linux-user: Add support for two btrfs ioctls used for
 subvolume
Date: Thu,  3 Sep 2020 01:26:59 +0200
Message-Id: <20200902232701.13299-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902232701.13299-1-laurent@vivier.eu>
References: <20200902232701.13299-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oe2ymBvkozW7TMTCEq580ikm0T1MtnIc61iK5y1KYT7l5UW77TZ
 xI4B+ALOCTIbwRoeM9BqOD7w4Qdw3Jk10Doa3DPKsJ3e7XJ0aykHFtqWJdo0U0pJkOiSJVp
 chxjKS86pMXwmXGnT2PYLYxhwIAS06ksiKZBwzrccAucE6+0eFugzYUYI4IUeGa1PflDEOL
 JFN2BUSBq4ArfAqhqBgPw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Rh/ZNMxCKQ8=:QKOsKbdqnGoUlEWJRKe9yZ
 7JnT0ybJHDHEwDVpd4VTEg+6eKS4F9AxyYpRBqqwPJfk8Wz12CmyaHsoyALf3m11NnhkHfg5D
 jOZSuDW5/ARD5Dl4QRoLNsYd3LnGW4oYtup/7BWAu4iy9j62mYAVKRUVe8rtvVW96m1M6A5pT
 3wmuT8ZkAW0LOB6C193I438+iQEAbsHbleECkc/7WgLHY0Gf4dSTLxVt+UqxVXde9MJhdj7/n
 v6gMhEdN9w3M4aDMQq1uK+YS/60mHuCQLNhxgro8R8+yWWGbB9hnayCjug6OE1sAPJ/K1Gm9u
 hXx+xEWZ4Cv7xQHLDlKmKbGKkJ9sdL/wO529xy77sVb6iSc6/iOZlT8eaNum9Z0NTFsC9RSSj
 fNtGsZXn4TIoJ1xcw719/XRHlLUDURx7VTaFXyj2Tj1oHHdM3EwMcrIIsxp/aulDaNGI3DyS7
 CSFYEyekSbm3zHaGuEdAeDqV/YXSnxzJOt77jMx72e5A5+CrngNRWSpjuTXAtLOIi3vUK61Dk
 9dkSxz24AfYYTY7yYU6vHpsnVR4WwRDvfbBtZWxyodOX0wSIL3nS8mUmJoHC6U67B4TXrd1Qo
 v7Yf+DrQTHWR3JY44wDDWFP8AeVuSVK+9BE7NBbztVgX2XXl6YKRfJ6Z1QDCiOAi/vyvjit+d
 Kq1uyhxboeuhDyXkHPl021tw0SuNY0p3mQOkmoh9ZSnTL/OMQ86scQ87biE7uWTHXLwC13cSW
 KrgxuyFwBZP8LsjN8KAGc1oUGzgwspy+zFUbdIg5kORf8GqIUFqBRbeWCZ2Pj+TeJzTKGFu6W
 7/PlHGJbDYMC4Vqz0T6nIMCL5/R0QeGh5m9I2sgJt8cRaB5dNzVpqcngDwBMAeIYKRE4Kgx
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 19:27:08
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

This patch implements functionality for following ioctl:

BTRFS_IOC_DEFAULT_SUBVOL - Setting a default subvolume

    Set a default subvolume for a btrfs filesystem. The third
    ioctl's argument is a '__u64' (unsigned long long) which
    represents the id of a subvolume that is to be set as
    the default.

BTRFS_IOC_GET_SUBVOL_ROOTREF - Getting tree and directory id of subvolumes

    Read tree and directory id of subvolumes from a btrfs
    filesystem. The tree and directory id's are returned in the
    ioctl's third argument which represents a pointer to a
    following type:

    struct btrfs_ioctl_get_subvol_rootref_args {
		/* in/out, minimum id of rootref's treeid to be searched */
		__u64 min_treeid;

		/* out */
		struct {
			__u64 treeid;
			__u64 dirid;
		} rootref[BTRFS_MAX_ROOTREF_BUFFER_NUM];

		/* out, number of found items */
		__u8 num_items;
		__u8 align[7];
     };

     Before calling this ioctl, 'min_treeid' field should be filled
     with value that represent the minimum value for the tree id.

Implementation notes:

    Ioctl BTRFS_IOC_GET_SUBVOL_ROOTREF uses the above mentioned structure
    type as third argument. That is the reason why a aproppriate thunk
    structure definition is added in file 'syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-7-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        |  7 +++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h | 13 +++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 23807513eed1..dc2f3d2413ed 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -206,6 +206,9 @@
      IOCTL(BTRFS_IOC_INO_LOOKUP, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_args)))
 #endif
+#ifdef BTRFS_IOC_DEFAULT_SUBVOL
+     IOCTL(BTRFS_IOC_DEFAULT_SUBVOL, IOC_W, MK_PTR(TYPE_ULONGLONG))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
@@ -248,6 +251,10 @@
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
 #endif
+#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
+     IOCTL(BTRFS_IOC_GET_SUBVOL_ROOTREF, IOC_RW,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_rootref_args)))
+#endif
 #ifdef BTRFS_IOC_INO_LOOKUP_USER
      IOCTL(BTRFS_IOC_INO_LOOKUP_USER, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_ino_lookup_user_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4929121956c6..bb60c728d81a 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1014,6 +1014,8 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
 #define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_INO_LOOKUP             TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 18)
+#define TARGET_BTRFS_IOC_DEFAULT_SUBVOL         TARGET_IOW(BTRFS_IOCTL_MAGIC, 19,\
+                                                           abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
@@ -1027,6 +1029,7 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_LOGICAL_INO_V2         TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 59)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
+#define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index dab2c16bcac7..73e36620cedc 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -435,6 +435,19 @@ STRUCT(btrfs_ioctl_dev_info_args,
        MK_ARRAY(TYPE_CHAR, BTRFS_DEVICE_PATH_NAME_MAX)) /* path */
 #endif
 
+#ifdef BTRFS_IOC_GET_SUBVOL_ROOTREF
+STRUCT(rootref,
+       TYPE_ULONGLONG, /* treeid */
+       TYPE_ULONGLONG) /* dirid */
+
+STRUCT(btrfs_ioctl_get_subvol_rootref_args,
+       TYPE_ULONGLONG, /* min_treeid */
+       MK_ARRAY(MK_STRUCT(STRUCT_rootref),
+                BTRFS_MAX_ROOTREF_BUFFER_NUM), /* rootref */
+       TYPE_CHAR, /* num_items */
+       MK_ARRAY(TYPE_CHAR, 7)) /* align */
+#endif
+
 #ifdef BTRFS_IOC_GET_DEV_STATS
 STRUCT(btrfs_ioctl_get_dev_stats,
        TYPE_ULONGLONG, /* devid */
-- 
2.26.2


