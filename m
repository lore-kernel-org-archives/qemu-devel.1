Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083E5C49ED7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28A62082C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28A62082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jP5-0007kE-Pe
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53319)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7j80-0004kY-NL
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7j7y-0002CM-Gg
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60739)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7j7y-0002A6-6c
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:36:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MCKSA-1hyPjj0ll4-009Qkh; Tue, 10 Sep 2019 18:36:21 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 18:36:00 +0200
Message-Id: <20190910163600.19971-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
References: <20190910163600.19971-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ulRcokUfmXdMbuiGnDuBpfBvI+ZopA0SBBBNyQnDkISRpg6SGTm
 8Z6PeQZxTTCGX4wcPaG2yH1DtPGItUI04WkkSJl4RxyaDnZKqN9/letktg1GrcsITV+Kacg
 n8M90wF1ciZsC1BMZ02UWlRD/a5rkLNQAOcrC/pEZeY5/fQYxhIMGlO2rq/5IB/zNyDpeqH
 DqElenvUr8QknxPVP0sRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hK/tHS/D818=:UQaPQow9eglUooyDRVejIr
 NDzTA7j1S10WZaiLqBIbDppIHFcdhCZC4OVtX4ymSDfKdL5191d0afqtCvEXAXlHYaL6AM8mr
 C74dKVKq8PogupkoO1LfX4pHIXtIzyoODEdFEA38o4TEgSHFzeKCN6BgQVqJTyD+ncSmahrCl
 Tnbwwt6mOWSp7+3MClq/8hlqjVePKvCSxvNocNWIzoxC4AbiqgwMKfQFPOr5rBA/JV+76947k
 byBpBrMUJu7+24KrzsgRbi1MfLihI/IYmScR9+IWDets+CE505eIjK6LztnKGRzWeY8b/+KxH
 D7rF/udx71QKyRqR7Jo3isL3qovv7X0hQmuZi8FdgWywvN2UAx07tbOdMsVbgZpKOiA/nAAsJ
 eN39PNAC0viDT+gGOlaqEuoqhUIq0pkCY4Pxk8hksrvyAfP1RzpohpNiuB0D8dGLACZ9isg8B
 3NyL8BwO8b+sJb4aFcyDcAGPakLeLkfffU1k9LN65s0t1AbkdqLtD6lphjvNRL8ZpXV7uoVDe
 +VrdEu9tb1WSAoxJUrSQqfVOtERz9raJXU2lQo8ozxzb+F14nH9y6aFMNRBXXUKtrJjOHTVBl
 kKXU9JYJrdEYh0cI0j2oO2wNF1RxloXk/NEdkP4HjasjsmfuYu+pAZIre1b+6EkuM2n3ljEf6
 U3Qe7XBbKl5BDpRAild7YbUkdti7IW7nR6SyAEQExOPg8owxioMp5uKYehOOczWsJ3HFa42g+
 bb4tiOCr+elx6RIswuUFettKBpKG/XKeOzEZUMfztg3uq2N08gnZGp6C6GIO5PaW2nyGW0ccd
 HfE0HL5Ag3fmpSAFyEGd4Id1QJIEPJoEVt56KIqUv9vWzmv/Ng=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: [Qemu-devel] [PULL 15/15] linux-user: Add support for FDRESET,
 FDRAWCMD, FDTWADDLE, and FDEJECT ioctls
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
 Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

FDRESET, FDRAWCMD, FDTWADDLE, and FDEJECT ioctls are misc commands
for controlling a floppy drive.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <1567601968-26946-7-git-send-email-aleksandar.markovic@rt-rk.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/ioctls.h       | 4 ++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index b253469999ee..c6b9d6ad6653 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -115,6 +115,10 @@
      IOCTL(FDMSGON, 0, TYPE_NULL)
      IOCTL(FDMSGOFF, 0, TYPE_NULL)
      IOCTL(FDFLUSH, 0, TYPE_NULL)
+     IOCTL(FDRESET, 0, TYPE_NULL)
+     IOCTL(FDRAWCMD, 0, TYPE_NULL)
+     IOCTL(FDTWADDLE, 0, TYPE_NULL)
+     IOCTL(FDEJECT, 0, TYPE_NULL)
 
 #ifdef FIBMAP
      IOCTL(FIBMAP, IOC_W | IOC_R, MK_PTR(TYPE_LONG))
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4e33ef396be4..fa69c6ab8d01 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -893,6 +893,10 @@ struct target_pollfd {
 #define TARGET_FDMSGON        TARGET_IO(2, 0x45)
 #define TARGET_FDMSGOFF       TARGET_IO(2, 0x46)
 #define TARGET_FDFLUSH        TARGET_IO(2, 0x4b)
+#define TARGET_FDRESET        TARGET_IO(2, 0x54)
+#define TARGET_FDRAWCMD       TARGET_IO(2, 0x58)
+#define TARGET_FDTWADDLE      TARGET_IO(2, 0x59)
+#define TARGET_FDEJECT        TARGET_IO(2, 0x5a)
 
 #define TARGET_FIBMAP     TARGET_IO(0x00,1)  /* bmap access */
 #define TARGET_FIGETBSZ   TARGET_IO(0x00,2)  /* get the block size used for bmap */
-- 
2.21.0


