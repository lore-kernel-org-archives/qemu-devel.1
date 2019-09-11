Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999C2ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:06:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 712EE222BF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 712EE222BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wi9-0006lQ-67
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i7wRq-0006HP-V6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i7wRp-0004Tg-Ru
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1i7wRp-0004TN-Ik
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:49:49 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MlfL0-1iYmw32kjK-00inyb; Wed, 11 Sep 2019 08:49:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 08:49:20 +0200
Message-Id: <20190911064920.1718-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190911064920.1718-1-laurent@vivier.eu>
References: <20190911064920.1718-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BbpMENamDwMG3Ang8EA2towk7A2z2LCjA7Hz3tIlbb6OUm6OjY0
 0xDnvGVt5ByAEtnMYXVMR2lyFDPv/8QWOZ+dwh0wsZBE+ABNfcCRhs0KkG6m3Lvg6CkE6qP
 wfKY4X+xQ9S311/jWGJzLC1b34VOhnIwxOOSIVqsJ8HBVxcABmRL79Pasf5PwcU6HGnTeuS
 ettWEOqexFvw3qbMUxNBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:drFmzaq5Q/0=:r+QBFBFVf5HBIze3nd5buA
 k5ckR2wMxt7C8VF7Fpe+9xgtYFBOsOqjQuNxyNakAGy/EZJiC9GfcmIJ+SSdzMvI7HVsb5m/K
 emaAJUeQVlYtt4KgwfUTTCQQAbxfVdr142CXquoexDfmOyUH8yxfY61AVo9XaqTGIkSGG3Koz
 JCb4xXwvQYJQTEWM8ElKNzzDyWYB9N2kxfkP1UWwOAiGWtrGI6mOFyyeXAuJyFmrEndRkLq8F
 fRJWqsmxaYjEj3I0hJUWxXXNOc+VWZbLDzwhZXcma0LPNiGUE7dMW+fiR6zkvBM+LdAzLx9+S
 yYBumIlGW9Jme9rRMT75N09AqQWba4Y38RiTpf7LkAZQEDnAGtKDAPCJouHIhusJ6Jz+NsotY
 /+NXO6rSYcJwn8ed4J9hzEA3/2Tu3f+AFdQx7hA+EMNNng6yxKmkuG0KFY/8BO8zC9BMwoM6Q
 wSSfU9/b21Couj9zVk5Irqb2jqxTof/EOeYcoeU3ngDuVbyuGORE+jdaP2NxnSLChhaAxAj0N
 WAYuAzNaOd2u6uNmhXjUrMQPtGRnHcml/Ac265IAwovAsAcqLwsp74EMoDL17RPh7paLgFMxM
 AxUBJWNNZQiydOD0U3dSBC19oikKC+R+Ks7dWXs6Ccllw5QGQ/ns3FQ0uoUmWpbVggXHi1d0W
 iBw4+rYrWeBrYX8cPo1Hb/T7qGSfZbPbj5TplGV+EwchrEGSbwPfc94Mf/6rHXeMFKyIrGbfV
 Ldl0CE+mvzUyQMSgQa+CPSui0q59mvl+gZ8WSuVPQowRBuH9cKdjgbr7d+jahCdA3j67g69Ci
 jmyi8SlAiKUYM9DDfM2doq7yoWeeQ==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: [Qemu-devel] [PULL v2 15/15] linux-user: Add support for FDRESET,
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


