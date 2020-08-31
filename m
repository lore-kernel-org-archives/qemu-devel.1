Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EAC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B372072D
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 11:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B372072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kChhr-0004up-L5
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 07:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChes-00072a-Bt
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:30 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kChep-0000Qy-D2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 07:07:30 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MD9Gh-1kLoKJ1c2L-009BmA; Mon, 31 Aug 2020 13:07:22 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 2/8] linux-user: Add support for a group of btrfs ioctls used
 for snapshots
Date: Mon, 31 Aug 2020 13:07:10 +0200
Message-Id: <20200831110716.536808-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200831110716.536808-1-laurent@vivier.eu>
References: <20200831110716.536808-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EzA98sguEbHWsaMgKalaPTLyEYD/KlsQ4v+9uyJDCi+wZ1+V2Ih
 iUCcgkBxqend/NaEu0CJ2K8OEbJXqbEnkTce+/alSJh5cIAfI2fa7rYeQxoiPUDmBnp2bcg
 2AZP1SVTbhIoSrT7tA2i5RPPV9G9k0vwJeKxCoG1h8/6iHA19+d1wNx3uV+7lP8wDzuS2Kn
 CZ0lS0PaCeHgmZVS533Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wyznPZP/ip4=:HPgBjFCkUwa3b3eVEEtpBx
 hZoDst76CmkRSp3uYMIIiZCZh50HH/YqObRCt/RXTa7RVZY2uhVBvkpR1Bkz3mjb1EytS1XLc
 YyELD3Uu2EJc/42HNrKSEsk20Fnr5FZTiJR6GbTaspxnykEjKMJXRPDrnYkgm1eYUntlsYiAX
 xBjO5hfpKl9HhbMQ4rn1vCpzS2SDKheHo5sn+X/uPHlEds+VypnCrEc+7CaDtgeCY/G9qph3a
 3iqF6KNpvmu31N4Pi1LulQ3m97pCldWJ3IYYFctAi/DoOj2fl4XioDj5m5p7T5fkm2OrCWI38
 VGdimf23pLb5GWkGpdAvuKxJ/8juE6DM0H/wqt6Vu6fduq/Ql27GfXX9CMaMz2aVwGlKZ5exB
 2RLi47gqU4ZwnDo1W0MWSjJuYImGFh1Qv0Z8wMZOUeXX927ttXvGZpL3XZIGHo8rCwBQ77TPm
 vkDacS2AXHu6xHo0Y6o85CwlwHHpVZkZm4fWpPSWzqaFMlzKxR3OjcyE29TGIG0i25f1o/cTu
 A7sGL5xAc6i0+rRfa31sUCRAmqmAZxu2TgBWrZXM2kuaivR04OdFavCW9rVevYxXv07/TnWNl
 w2ZctmPnyvYHusgfwgTmMO2/nyWRUuoYY9AXLMVxh/ZbgXi6fY63cuubjTBHTRtmjxNzqVfSp
 Ww+JjKWnx2L3yvaZrv0k3uS6T+AVE7QL9EQQtLwm6tkBy8+kZ2LCP83ecVKXjWn0sK8MNmV6U
 5mw4I0aw7Anlngw/iqPw951cPKzQMUK6zPnuwobzpKkNTYdW49ijK6PEUjNSsfn0hkkZHH4wG
 yvL5mUDE5AbzCaRPpNpvqFM/wUfE8J5bbqKC6sw3wQiSaT2vyMtjvxOcYuaK9Sh8k0yUppx
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 07:07:26
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

BTRFS_IOC_SNAP_CREATE - Creating a subvolume snapshot

    Create a snapshot of a btrfs subvolume. The snapshot is created using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be created.

BTRFS_IOC_SNAP_DESTROY - Removing a subvolume snapshot

    Delete a snapshot of a btrfs subvolume. The snapshot is deleted using the
    ioctl's third argument that is a pointer to a 'struct btrfs_ioctl_vol_args'
    (which was mentioned in the previous patch). Before calling this ioctl,
    the fields of the structure should be filled with aproppriate values for
    the file descriptor and path of the subvolume for which the snapshot is to
    be deleted.

Implementation notes:

    Since the thunk type 'struct btrfs_ioctl_vol_args' is defined in the
    previous patch, the implementation for these ioctls was straightforward.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200823195014.116226-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h        | 8 ++++++++
 linux-user/syscall_defs.h  | 2 ++
 linux-user/syscall_types.h | 3 ++-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index bf89b96d27b0..bddeaca9e7ec 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -174,10 +174,18 @@
      IOCTL(FS_IOC32_GETVERSION, IOC_R, MK_PTR(TYPE_INT))
      IOCTL(FS_IOC32_SETVERSION, IOC_W, MK_PTR(TYPE_INT))
 
+#ifdef BTRFS_IOC_SNAP_CREATE
+     IOCTL(BTRFS_IOC_SNAP_CREATE, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_CREATE
      IOCTL(BTRFS_IOC_SUBVOL_CREATE, IOC_W,
            MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
 #endif
+#ifdef BTRFS_IOC_SNAP_DESTROY
+     IOCTL(BTRFS_IOC_SNAP_DESTROY, IOC_W,
+           MK_PTR(MK_STRUCT(STRUCT_btrfs_ioctl_vol_args)))
+#endif
 #ifdef BTRFS_IOC_SUBVOL_GETFLAGS
      IOCTL(BTRFS_IOC_SUBVOL_GETFLAGS, IOC_R, MK_PTR(TYPE_ULONGLONG))
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cae79f8492e1..1519de7a5565 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1006,7 +1006,9 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index 0ce58d77727c..853b91d21275 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -358,7 +358,8 @@ STRUCT(blkpg_partition,
        MK_ARRAY(TYPE_CHAR, BLKPG_DEVNAMELTH), /* devname */
        MK_ARRAY(TYPE_CHAR, BLKPG_VOLNAMELTH)) /* volname */
 
-#ifdef BTRFS_IOC_SUBVOL_CREATE
+#if defined(BTRFS_IOC_SUBVOL_CREATE) || defined(BTRFS_IOC_SNAP_CREATE) || \
+    defined(BTRFS_IOC_SNAP_DESTROY)
 STRUCT(btrfs_ioctl_vol_args,
        TYPE_LONGLONG, /* fd */
        MK_ARRAY(TYPE_CHAR, BTRFS_PATH_NAME_MAX + 1)) /* name */
-- 
2.26.2


