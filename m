Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970FBECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696FA20693
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696FA20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wcO-0001Y3-NF
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRg-00062y-1e
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRe-0004Mi-0d
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:39 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:39589)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRd-0004MJ-P2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N2lzA-1iFbM02H2y-0136Hn; Wed, 11 Sep 2019 08:49:32 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:18 +0200
Message-Id: <20190911064920.1718-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AIPZmokLRc935u1DfsDlb1DX8Hy2gMKz2nveL2WXzOhKWg2FH8t
 pFLKRViTCNSOCmazNf7cC7uG9MwOdVf4Ru9RNAFBtp4Bv9STVRPo/Pk9matPPLxkOZcA/Gz
 Y9KLzl2Z786yk1NiJ4meiCayZE5x7aL7KQTTE/uduPlONSehqOwUc4Oxtw+DUpiWORMzWEq
 TmQDJJrdmu3r5I/JHvUTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T2jYVP9ByZk=:gTOne5bqb3aPuPAnqfQbCP
 n6XFWHeZnEpz4n8jUdxKHC814Hcjge1NVXP1BYt6e0/3NAr08QZxtbsf6Qi5Eo/w88RN9moW0
 vj4QFPkPiCpI1IFxqsT3OrBXgHYyUBv6AIY7K6OzYHfS6iRPs1N5wDlG2jdVod2wwOu/k9qYm
 dexwtanJknBw7W2zHLnbmvxCxqNevOn5v3o82yG9rdcvw9PNwD81bTePNhU7oTjXViaPPz0H5
 I95jkDhXNFr760Rmk7QWyEM+i2mh4gbf3dKOynmNIuAXqt7mqnLj529DDN0ZpdGC4qPglUUUR
 pYuzle30ArfFlr0/V5F1Pp02wm5PFYN4UTxYUQplm1jkzj8uNX3EDAuDkgssXkKowgC6I01XK
 O0Dsmch3jilFxV6STzKcQOHvhmxE9DXDkDqGkTK8pU7ZTqHsytUF3d0RhbeXgL7D9JBNUQrr1
 YTVdvFSFAtBItik+FP7J3DzfSxFDXJm4Oskn8skl9ZurYdPdd8Z+nEVg5FtxwEHat1SHzGqxS
 6zd3CO8pywAIPYFAD+sVnKmDll7r3cCMKeAKqiJOEXC5CMbthR2s3urrz2Ylen460jT3Te4zr
 Is20Z2Rkfnk3W3JJLGIp6gKjShbZ4Yv4vpPlnpqlyufnp5EET5vXq8nW4swutZVTQaR2uaop2
 7Bc/pDd27LNNssfI12pGEWM2wpqgd2w6Zq1Td/qtBzvF44XoLDvU7ccSt5c0+xXHDxmrwngFG
 Ww3VIoVTkCx/ztcab6kdQ6MIcrjhN3utpi4Br+D+ORFjFn1J0oYZc9zOL2eDWiA07BFnyM4Bi
 sKDIoMCGL2pm8wTzE4ICJZMv+INnOzuCea03BK5lhUbccyy1Ds=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: [Qemu-devel] [PULL v2 13/15] linux-user: Add support for FDFLUSH
 ioctl
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
Cc: Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Yunqiang Su <ysu@wavecomp.com>, Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yunqiang Su <ysu@wavecomp.com>

FDFLUSH is used for flushing buffers of floppy drives. Support in
QEMU is needed because some of Debian packages use this ioctl while
running post-build tests. One such example is 'tar' package.

Signed-off-by: Yunqiang Su <ysu@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-5-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 2 ++
 linux-user/syscall.c      | 1 +
 linux-user/syscall_defs.h | 4 ++++
 3 files changed, 7 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 1830de96e12b..bc1944804220 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -112,6 +112,8 @@
      IOCTL(BLKZEROOUT, IOC_W, MK_PTR(MK_ARRAY(TYPE_ULONGLONG, 2)))
 #endif
 
+     IOCTL(FDFLUSH, 0, TYPE_NULL)
+
 #ifdef FIBMAP
      IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 6928f654ced3..e2af3c1494fa 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -89,6 +89,7 @@
 #include <linux/kd.h>
 #include <linux/mtio.h>
 #include <linux/fs.h>
+#include <linux/fd.h>
 #if defined(CONFIG_FIEMAP)
 #include <linux/fiemap.h>
 #endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 498223b77787..917202a2035d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -888,6 +888,10 @@ struct target_pollfd {
 #define TARGET_BLKROTATIONAL TARGET_IO(0x12, 126)
 #define TARGET_BLKZEROOUT TARGET_IO(0x12, 127)
 
+/* From <linux/fd.h> */
+
+#define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
+
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
 #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
 
-- 
2.21.0


