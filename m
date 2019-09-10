Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD0CC49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:45:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 519C22081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:45:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 519C22081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jGX-0005ph-EY
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j85-0004tJ-04
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j83-0002Gu-VU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:32 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59871)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j83-0002GU-Mt
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MuDLZ-1iPxOx41KH-00uXui; Tue, 10 Sep 2019 18:36:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:35:58 +0200
Message-Id: <20190910163600.19971-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:7qgUg+r2PreMjPeylXr3/hm5lIOx0wzUU6m4vf3hYTDBv5XZR5w
 l8hPg709p8ShakQ88AxFXbBOgr79r9NWhKflz+gKceELbd1LOkqaTSfrbTiy3NGoJZJ7qLD
 JvGG2s5yy7kGDfZRQsohxvFfMcQSIL47df3nZ6r/B7cS5lj5Gxo+dfqLvQiJ2K9RNTxcOie
 Wj1fJzow5X3tLkEvP5NyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4EE97/bQTxE=:v7bq8KfBkigv07lY2vMXIx
 EShrgXZ4kWOglB5rytzhxOeGOOpJQBibKyp/pwUZZHY64T4VgmrX9ljJ6QTlmdV8RJKVSxCVv
 owvIVASw5VmGcVL00PiqRzdQIs7WOWynQ4dbKrtGYXEoeFx2KX1mch9AcVCPx9fVu9C8hiVmg
 BT/trd9o8KrRCdsZHNRnyiq4iSK+d47HEKg/Fp3aQTex2p4T9LZ1n0LQEyNDipud2H+wQWPML
 fGGBTQxqZ6lnMVadCzZTAtlPc9tmBs2f4vihnTzT+Iuic5XJXqcHQTpkDGUxUPO3nKqWExDJC
 LYA5RaBrK4EfAYJC7ZC69ybkQW9Y5Ru3PPM9JWieRn+/66MFSaKNc1NeXxYt3QqECwUTdqmTs
 alUqPF3kI1Zwf/eVSe5wfvQT9crOLzvE5MR0D6Ynw3AJ0inT9RWiEOxPPtMX/VV9ETLCdfV32
 kb/NL+Uais5bPHSToxFelgjZXYGN8d5tAzVejTc55oNNC52YeHBsuMwx5NWVy1uFyR6BvVKkC
 wR17qcyRAA5o03Pa8oV2M4Y7kTI7rj8tbemPbMpAE+iP2QR2zlevKyv2JTeotCHTJRLBT2k1A
 VG5Amq/D58rtETNMrYR64YNhOq08tc672L9CsiH8luJx09fD3Ti9MAad7+1YHb0mhNU3/3C8X
 UZXLEpGevSgzinVfzrhEQRG17gUMRgAuWEARWqzzKkE01Lo2rg7HRqp299gUqp+2O98MPnoyG
 AJQRY0F0C46RK3VUt05FZyvZMUG4um3upCdYW/vUT+/5AQd/3LVTBoncqNbQCplipxP4YnPXV
 G4yLRE96cYwuyw8S3EErsYK+aexWwQSitlvSVjyQ9P2KsKivS8=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
Subject: [Qemu-devel] [PULL 13/15] linux-user: Add support for FDFLUSH ioctl
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


