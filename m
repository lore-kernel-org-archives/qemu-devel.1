Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287FCC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7922078E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 09:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7922078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFDL2-0002Pg-Lt
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 05:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHm-0005Xp-D9
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:02 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:44743)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kFDHj-0002ay-QE
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 05:18:02 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Md76B-1koXyA1bnP-00aGgh; Mon, 07 Sep 2020 11:17:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] linux-user: Protect btrfs ioctl target definitions
Date: Mon,  7 Sep 2020 11:17:48 +0200
Message-Id: <20200907091748.376101-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200907091748.376101-1-laurent@vivier.eu>
References: <20200907091748.376101-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:9bTeDSuOVnORdAtmx/OWwYEKWqgey9U/ZpINi2pdSvTFbm6Lnd8
 xaCjsLmhsoaaIqAOxPmwIx+QIlBoJ5MpESjaNijkpgj51xpWbm41RTVur+97CLfRfHl12t/
 edg1gRKyWToVamSNhS7NDoO1TMnIOnQJODrxmyvog95/9TvCC0MAzQQBD0WPo+TlK5SaYeo
 IFgJJ1n/jjHWphtJkLgMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nggVGtVBxcU=:3oFpqTkngSIWMbILRsmrlZ
 GHjQLIMcVPJkpETcDDylszV7AKPnALCSuKnFtq+tUT1UrFvKxGJ4eouQIBcgTXwHIzHw+5sBB
 xbJbwycRRM/xoIxX8jJTVE6d7hls0CceA/obc4w6mlTZ40hgkTDslI9h73evD6Lwfiyek1Qvt
 Q/r4ol2z/HOyMcfj1/7cUjPgbXPNp21LHlD5mshRJwt3jWodvFkS3t8Md/uVi6NZoOzK278RA
 RbsyuTabZjI3sHWf7orkRL1QjW9Yp1HsZnKV7UI8COiC35my1xjdL95irglWtZKIyUfn+6C5t
 /gP7cshpWV6MCVmUfSu6DMzdajDMqu9lwj3GSpZtiB6UA13t1iT9qK9LjUSL7Vqwo7FANv+8P
 FyGv+xqhqpUfPaWTwNRjY/fzPsDqcfK2KhfGTmixxkOqCBWEtLxqXnZDuoRjhj4q4e8OVhipT
 09izLHL4Q6Rhtr3VKGLT9m4iZd1nbNCk3hlYqQaGJxmWzd7kDwnk24Xiu6ZAHVPzYeyIOLNa8
 W90JNrKyG6akk+doFW4g0neOa4z6KFztYaFqD7BGSouKWHoMrEQrBoY42G4djtZwj8eAJ4nIp
 GPSXw7SwjNuY7ST11IZtXaPZGsoMNfb8BKkh/66VM7Wi5dHAHmvGUU3kUQmYemgzTK6k64Vuk
 oOveavdgKGtICNsw3AkQcnk0cIA1aqVbQNjvRmJq97eiaSfXulY2nvZe9TRI/wYPmItlX+tZb
 ekTKSJnFbUGXH+IMADmDXQ/cCMQrkGBnsc1g6MVrOQb3NwrAsVEH1kcqQ9EI30cbIHNNc+5cy
 s8ZCqgRe2BVsvV4SMDsmdmRl64rBPhHYuO8Xvvzlr/HzQoKtJl21HYksGa3nKG9SA5kiLJf
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 05:17:57
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Laurent Vivier <laurent@vivier.eu>, Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Filip Bozuta <Filip.Bozuta@syrmia.com>

Target definitions of btrfs ioctls in 'syscall_defs.h' use
the value BTRFS_IOCTL_MAGIC that is defined header 'btrfs.h'.
This header is not available in kernel versions before 3.9.
For that reason, these target ioctl definitions should be
enwrapped in an #ifdef directive to check whether the 'btrfs.h'
header is available as to not cause build errors on older
Linux systems.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200905163802.2666-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 33a414c50f19..731c3d5341a9 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1006,6 +1006,7 @@ struct target_rtc_pll_info {
 #define TARGET_FS_IOC32_SETVERSION TARGET_IOW('v', 2, int)
 
 /* btrfs ioctls */
+#ifdef CONFIG_BTRFS
 #define TARGET_BTRFS_IOC_SNAP_CREATE            TARGET_IOWU(BTRFS_IOCTL_MAGIC, 1)
 #define TARGET_BTRFS_IOC_SCAN_DEV               TARGET_IOWU(BTRFS_IOCTL_MAGIC, 4)
 #define TARGET_BTRFS_IOC_FORGET_DEV             TARGET_IOWU(BTRFS_IOCTL_MAGIC, 5)
@@ -1041,6 +1042,7 @@ struct target_rtc_pll_info {
 #define TARGET_BTRFS_IOC_GET_SUBVOL_INFO        TARGET_IORU(BTRFS_IOCTL_MAGIC, 60)
 #define TARGET_BTRFS_IOC_GET_SUBVOL_ROOTREF     TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 61)
 #define TARGET_BTRFS_IOC_INO_LOOKUP_USER        TARGET_IOWRU(BTRFS_IOCTL_MAGIC, 62)
+#endif
 
 /* usb ioctls */
 #define TARGET_USBDEVFS_CONTROL TARGET_IOWRU('U', 0)
-- 
2.26.2


