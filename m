Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB80C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:53:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520C820771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 520C820771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k677I-0003DD-HS
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673R-0006RC-9K
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673M-0004cK-Dt
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:36 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M9Evp-1k1SU20D3f-006QVh; Thu, 13 Aug 2020 08:49:29 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 07/14] linux-user: Add support for a group of btrfs ioctls used
 for snapshots
Date: Thu, 13 Aug 2020 08:49:16 +0200
Message-Id: <20200813064923.263565-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tsAE1iOXlHQiM4x0Z1TzTkGxdmG10Vmsy4wvE/faaGCJ2OC+GQT
 DMSUPpGtmr04G6TvzgqpLWy2PpHWBbHfX5fATwI9IHOY7G7DSetU3ai/lEutN3uJTO8GUyn
 taqHi0SUd+uhvEW3AubglYtSUsjV1nffSYW8zYdXz0oH+gYjkImnN/Au7c0uKOj1BEgvAKD
 d5SVDzJSwytj/0dOaGjeQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a5GWrqxTXFQ=:64r3JsbyovqS2yvHzmHiKz
 ih/HvbvMMKedD1aUog1hvAK45b50q13ZyDHgrFYgsWUTvNUTsAEvB39UjCoJ/A1LOppevgqrT
 04TPGzmd1BCQwdx4UaIiw+1Xxd1SRIjHvXIl7Lh/vtJNjtXifMsZYFD7Z6R103/5v04bb5ivM
 1k/cJ7FcaAMmrvBGjy3R85/PEqedI4Rflc5waFHMdW19n0sSAesjyLG9zfuqBIERc3aKxhlhl
 usD9at/TF1/fFcy+Q3pdshQbp99wUypGB2dkWKGGEU7sDd1anCVADLGQDVru7BqNdlVkhOMSv
 gfQ7y5Xe80QqG2LCgo4rjtfbXrIn5UHVEiZqCgxnEiL+Lj4wkmvfCOSOOHAT0Rzmf7FrvtzRe
 awOH9mJB3tjusBZaAb0ZsALpA/H/1quV8wL8sZxCHE+Q1vk11gG/m7YcmAbjARI3+Fwmi7J3u
 WX/03+Y++5UvxiYE8r9Okbj82/s2Os7Mz9J5moTL4D2NEybRfJWhfYlt5npji93p2RvrMTp47
 DjDQYg2UxlDoC87vywiIucXuKlEU8lJEFt869fMwH/wfyAAtwbBbI/b74mWL8IFJl0uyl1ra2
 J5vVofmxhZ1w0dIeOAImeGCogJp40McxYnJ0GHQj95pGeHllGh1WVuRX8RqMvDOgKktUHr9x3
 yW7uLVWrdLksme1nDYCPyk/pOtVJe2kz6aqY1/PTBOibQHYb3X4RQPV4RoI8sWkfSJD8+BrBr
 SsAovSFvmlXNXygTbq9nEfh8AY6QDTOPqSr3SwhI+vmvXuiwTWgce4O+PiJN8x/JhwDOzXhJv
 kwfwUjAAsbc3D1ElgcObkvb41aWORfPTQs7SRsu3bUPNZ4aZKyBwjNvI+4HhBr7BUuzfwek
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200803094629.21898-3-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 8 ++++++++
 linux-user/syscall_defs.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 12d14442249f..f33a99f8b642 100644
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
index 5435baea38d9..e514cb6916ed 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -973,7 +973,9 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SUBVOL_CREATE          TARGET_IOWU(BTRFS_IOCTL_MAGIC, 14)
+#define TARGET_BTRFS_IOC_SNAP_DESTROY           TARGET_IOWU(BTRFS_IOCTL_MAGIC, 15)
 #define TARGET_BTRFS_IOC_SUBVOL_GETFLAGS        TARGET_IOR(BTRFS_IOCTL_MAGIC, 25,\
                                                            abi_ullong)
 #define TARGET_BTRFS_IOC_SUBVOL_SETFLAGS        TARGET_IOW(BTRFS_IOCTL_MAGIC, 26,\
-- 
2.26.2


