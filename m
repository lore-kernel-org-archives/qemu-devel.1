Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190F8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:09:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B6D2137B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B6D2137B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChh9-0003bz-1j
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kCheu-00077B-44
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kCheq-0000RQ-P1
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:31 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N6t3Z-1kepiW1t4p-018JXs; Mon, 31 Aug 2020 13:07:23 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 4/8] linux-user: Add support for btrfs ioctls used to get/set
 features
Date: Mon, 31 Aug 2020 13:07:12 +0200
Message-Id: <20200831110716.536808-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831110716.536808-1-laurent@vivier.eu>
References: <20200831110716.536808-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:j7ljY1ww8JtvgeUo2cgQ8ZbxgFvaHXLSn/jZDDAC4x4mVl6qKvd
 r56KwoOnLAcQkE1El/MgVpqneMS4/G4nteP5EszreOlTT1IJwUXAY30rwlUz2z4JV+5aD0L
 hJrjqpwOSdxdn5f1ITySPlNq5BqR+lkyeXOt7IB9+K9tL8NFrIwpXUk2KZYNy6ef4g7DhRY
 q5cWd4jbYUA48bUO+A2zQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2WQC4smgRqA=:4dMe/2waTPp/dgZZUUlVon
 opmtgt06MAfHNydlUmf4l1eE1fdwrfWodVxD5ZXu7hzc70gL/ABH3PbFO7hx+GWL/pgxrcPMS
 L09y/3K6Ik25dMf03C0R+z98EbKfTnUyOfn6If1n66VW+26xhiS27fdHMaRKV0qYSRWaa+kcg
 glYS0lN6X9nFcXFh1neFoHEwD8obDfeO7B/BvQF8Mf1Bpmlh6ap5CE82ENOgLJxh+eLGsEwjm
 3IsRdXjDWCjxhhNbpwdcNj1vrV/q6DIhPjcZINpQMxj5Ocqx/mCNI3yu7SXGskOdA84W5yt8N
 J6O9zMgt7fm2vHk7j5JIVegArGE/i7VFJhH/9+7Eu1BsiCWRLm4AtyNAAnQ+zL99dakfWJ2ta
 W5ITEkMxBN5lU3b8geSIdA9KecuMZ35cipJgZsvTgZwnQaijV3RiEQ3IycNc+Y7V2/6g7je3k
 GpcPaxLWUCBrqxZnfyANw0EAJyNvf0nGJjIXQnyhsW4hpPxZ2mIcx4H2eGkT9+tLZIb0/Hzrj
 8P4I+qqhJiWOG7MchAD4F3fKCrEQXjNWXd2IT+5fK8cfzEAnMtK7ggDaQiatGjaB79236CsQk
 qgjgPM8UFgOachEzuHEu38xgoE6ko5cOKunD1zJ8JAdXWqmgYYghW4cRHmkZ0NhdkkwtcrcyX
 MGS/B9qwK7QKhjoiS4Ne38oxjNJJgWV04Nvn4V76UJXUWpy/D/UVc6V/ajxEIb6sI1Z8cge2C
 HzlBjDNr8kqcOi6v11n3CbJdI3+ePpPP0DreH3y/1WFx2meVyVaufuKWvRU1Etd/WYSsufNT7
 KkdX9wUwD6yGduxKcrraKrYsVId6wxc9mELtNDFJzsjKgQN6ssZVdFdq8kHVMXMl199cQxh
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:07:27
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
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-5-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 12 ++++++++++++
 linux-user/syscall_defs.h  |  3 +++
 linux-user/syscall_types.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 74d73994f691..11d7361848dd 100644
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
index d11279b78bbe..f70138979704 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1019,6 +1019,9 @@ struct target_rtc_pll_info {
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_DEV_INFO               TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 30)
 #define TARGET_BTRFS_IOC_GET_DEV_STATS          TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 52)
+#define TARGET_BTRFS_IOC_GET_FEATURES           TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_SET_FEATURES           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 57)
+#define TARGET_BTRFS_IOC_GET_SUPPORTED_FEATURES TARGET_IORU(BTRFS_IOCTL_MAGIC, 57)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 
 /* usb ioctls */
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 7e52b7aec5d9..eba0c43d4493 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -413,6 +413,11 @@ STRUCT(btrfs_ioctl_get_dev_stats,
                 128 - 2 - BTRFS_DEV_STAT_VALUES_MAX)) /* unused */
 #endif
 
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


