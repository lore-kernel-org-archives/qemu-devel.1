Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199A1C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:53:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD33420771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD33420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k677J-0003Ew-2N
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673Z-0006Yp-JL
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:45 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:48837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673O-0004cV-9L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:43 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MUXd0-1kEoCQ0Zqy-00QROc; Thu, 13 Aug 2020 08:49:30 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 09/14] linux-user: Add support for btrfs ioctls used to get/set
 features
Date: Thu, 13 Aug 2020 08:49:18 +0200
Message-Id: <20200813064923.263565-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:m6VFafcuoNf5mrYO2G0qw5Y+EVpgAne4v30b/Wd/urDsIc19UKR
 JASVzk6h6Q1Z+LoSd7rd3nLpaAOJ8rsy8rx9rniFd3DGpirPPfCasJe1izhma1QFIIT0ind
 hnlAzEBdSmp8DQJcbdmExxBBXlJNUNCUUwxCZiCN4IobW/EuSqZ511jI70NxTLY7R+70kKV
 +kGcCFllhglI0xKVm5maw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gDbEU3g0TYM=:8YUL5o8Xi1Eh5gEneCwr3f
 kT2a+gVGT54NTYcgC5QyM6sSOJ6oeIle7Thq27Wf2kOAY5U438TaV198z5s3dnE0GXZlYOL8I
 8UUzBgD1OHjs0NqLMB2K84FPuQ9uuLSiybX7iNMytVZqgQiq6LSra6W7FU7X8puLWICng7jd/
 McYZDB8gZ3iAVr8NeYRNgfopu8KZxzB3VQgwDqhLRSvaPDeMf0y6FBLhCYPQmJHmrsquIcQe4
 eaonlSK4pIBTGxKqLj6wbUZzNOdwQpEAFFva09J2oTl7Br+AADexQ/k4xgzOQeagFqdzIWwb6
 YHSLNa9/CI4atSqzrdEzCHp4RQkx4+NkhXN+b2ir/V4iDwheaj+nu5gEhOTLch+qxRkj0D/w2
 mqxoNOF/ltWwVs4Fyb5FxBLKky/TnGOAl0QV1ZkEL2pKBrWrgcnEIX0OuhL5CtuHK9RXS0wwd
 wsnq9C0SXwbt52P7U19I1A1dfouBa+TZFsH8XYjx/eYxxDXRQMhBHa4Hpzb0prwgN9lGhbHL0
 JmxuxnhJos/X1fRADnHmI+iASauWvfhglwUqjRenoOpHiO0zW9/3eTTnH4nm5LsoKb9PhvOS6
 XB8lmLRJYPvfLUwK+iT54o5GYMOdnNKb/8AdSNkYdUCdClF51EwW7+y++VCKrMCNH9RVcJEkT
 3lrrHQVQaJ4565/zZjChGlovbbrZNQbzeywfvgU887oIagwKMeVaCqPwhkvRzcDapbSZ2lZEK
 zE1Vh/pvSOhBEASNVAb146zEIA6Xv9LNn0Gvl/WhtcYYTZYciHPb1ZYPMp3wBdWWaDSegviU3
 N3lXB+rprWHQsZNEiB4oAN8ZrPxwLO0w3VfgpVI1VADy/RqnIBaItz+tennz3Yq0ucgRqKN
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

This patch implements functionality for following ioctls:

BTRFS_IOC_GET_FEATURES - Getting feature flags

    Read feature flags for a btrfs filesystem. The feature flags
    are returned inside the ioctl's third argument which represents
    a pointer to a following structure type:

    struct btrfs_ioctl_feature_flags {
	__u64 compat_flags;
	__u64 compat_ro_flags;
	__u64 incompat_flags;
    };

    All of the structure field represent bit masks that can be composed
    of values which can be found on:
    https://elixir.bootlin.com/linux/latest/source/fs/btrfs/ctree.h#L282

BTRFS_IOC_SET_FEATURES - Setting feature flags

    Set and clear feature flags for a btrfs filesystem. The feature flags
    are set using the ioctl's third argument which represents a
    'struct btrfs_ioctl_feature_flags[2]' array. The first element of the
    array represent flags which are to be cleared and the second element of
    the array represent flags which are to be set. The second element has the
    priority over the first, which means that if there are matching flags
    in the elements, they will be set in the filesystem. If the flag values
    in the third argument aren't correctly set to be composed of the available
    predefined flag values, errno ENOPERM ("Operation not permitted") is returned.

BTRFS_IOC_GET_SUPPORTED_FEATURES - Getting supported feature flags

    Read supported feature flags for a btrfs filesystem. The supported
    feature flags are read using the ioctl's third argument which represents
    a 'struct btrfs_ioctl_feature_flags[3]' array. The first element of this
    array represents all of the supported flags in the btrfs filesystem.
    The second element represents flags that can be safely set and third element
    represent flags that can be safely clearead.

Implementation notes:

    All of the implemented ioctls use 'struct btrfs_ioctl_feature_flags' as
    third argument. That is the reason why a corresponding defintion was added
    in file 'linux-user/syscall_types.h'.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-5-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 12 ++++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 55a6cbeca515..50fae1e33bc4 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -216,6 +216,18 @@
      IOCTL(BTRFS_IOC_GET_DEV_STATS, IOC_RW,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_dev_stats)))
 #endif
+#ifdef BTRFS_IOC_GET_FEATURES
+     IOCTL(BTRFS_IOC_GET_FEATURES, IOC_R,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags)))
+#endif
+#ifdef BTRFS_IOC_SET_FEATURES
+     IOCTL(BTRFS_IOC_SET_FEATURES, IOC_W,
+           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 2)))
+#endif
+#ifdef BTRFS_IOC_GET_SUPPORTED_FEATURES
+     IOCTL(BTRFS_IOC_GET_SUPPORTED_FEATURES, IOC_R,
+           MK_PTR(MK_ARRAY(MK_STRUCT(STRUCT_btrfs_ioctl_feature_flags), 3)))
+#endif
 #ifdef BTRFS_IOC_GET_SUBVOL_INFO
      IOCTL(BTRFS_IOC_GET_SUBVOL_INFO, IOC_R,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_get_subvol_info_args)))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index f9f94c9c08cc..6cc3c1f6f5ba 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -986,6 +986,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
+#define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 35f94cdfc8ba..808f4daaf72e 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -398,6 +398,11 @@ STRUCT(btrfs_ioctl_get_dev_stats,
        MK_ARRAY(TYPE_ULONGLONG,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 
+STRUCT(btrfs_ioctl_feature_flags,
+       TYPE_ULONGLONG, /* compat_flags */
+       TYPE_ULONGLONG, /* compat_ro_flags */
+       TYPE_ULONGLONG) /* incompat_flags */
+
 STRUCT(rtc_time,
        TYPE_INT, /* tm_sec */
        TYPE_INT, /* tm_min */
-- 
2.26.2


