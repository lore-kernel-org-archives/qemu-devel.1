Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D8CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BC6206E6
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 11:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC6206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhAk9-0003Vc-0C
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 07:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj9-0002CT-SZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:53979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jhAj9-0005f3-1J
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 07:41:35 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Md76B-1j7pm12Y4J-00a9wI; Fri, 05 Jun 2020 13:41:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/19] linux-user: return target error codes for socket() and
 prctl()
Date: Fri,  5 Jun 2020 13:41:03 +0200
Message-Id: <20200605114120.1051236-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605114120.1051236-1-laurent@vivier.eu>
References: <20200605114120.1051236-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yd6XIaELBsx2mJxCyYJBS6LYBEOtFTzmsw8aLpEKsBJJvBen0cF
 bqyOCkKtGuBSm2W17n45c/reIH3z7of1vubvPAjs83Z8+Fh7FjraDP0dfWrqYMm9AssX1DC
 OpGJNX6S2zfHAoINTtBSDTMBXKP68RNtdGn5fGTCRjg4UmaT93LxO2/T8cOxYkWDlQBG6AX
 aQhaDqxhYf2OHgyic+e0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dDCu5qbq0l0=:TFrkawL/Nz3420iuWd8P3F
 mpwfFlAP6KPLQmz3ERW1H/iBYmMoWe7Db9eit+MqdLbi/Ji7fNUvF7aN82xEa681VYSt6DFTL
 TTVh8JlblOly6Tv+TG+ERIp5d6ajYQnvUDIY+bPzcBjxzFu6isKAH0aVxulMilFWARBbx9DrG
 lb4iAMFWlAEzq0O9E2s0IGrqoJrd+kcL0niNsSYlK0lIVB1FfE4UkAgDGv4vXSnmLjRf+D2z2
 z+9UueT+ABeZ2cWjQxlH4dGNVw3s02BKjLklcV61J5Be52kL10ChYyvvdt60j+FwQaUmpvE30
 CnjPTtMmfjnLJyy3+uli0hJCk8Ra2ovIyXP/bczY7BXHzjAIlW4Vz9MoqWzlh8K30v+/l2v4I
 UjJASO1PTm19dYgRcucReyg3nGZraVAqXVLUqarjRHsLyGb9IGmbBdlk3Ux4mOP+li/ix35xJ
 ABDBMLQ25vUFWNbRnfh0HmmB/r/2uu7UYr81OoG87UONb9FjDdrsWHrXoXB4fL64iWdXB4dtw
 4IE2vAjAo34YM7HVNAdQWkCHJQrD5pSxEUPVjNpMZCo9TIfUHsnBWL8tW+m6BspRcpupqtEeU
 W/ge9gy9hNOkv04MT+h6/5czZmsDUFhGW96YidfNApt/e+v/JesPSzWCZp0Hr1PvwDgrZKwL1
 KWHZ84/SXXtTTjRJbn7mYBkRJ/fW7gjo4RP7bL30mjynmvEKkXSmhPX2SpWPYqCHcMyfOqCBB
 32Fc4Eo6Ax3DCjbJEPxOrsFlH9ZCpAIHg4ZAcVj/IM6Bmlvpc+g4Iy8W4718FpCw2QLWe551r
 9pK00fqm4bmSn2IndbG2w4WuYB2mansXookdqjEMZsLu/2q24NVS4pB11qq5cWyTxPUh/U+
Received-SPF: none client-ip=212.227.126.134; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 07:41:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Helge Deller <deller@gmx.de>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Helge Deller <deller@gmx.de>

Return target error codes instead of host error codes.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Message-Id: <20200424220033.GA28140@ls3530.fritz.box>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e89b815ce983..fd5c4f1d73e6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -2987,7 +2987,7 @@ static abi_long do_socket(int domain, int type, int protocol)
 #endif
          protocol == NETLINK_KOBJECT_UEVENT ||
          protocol == NETLINK_AUDIT)) {
-        return -EPFNOSUPPORT;
+        return -TARGET_EPFNOSUPPORT;
     }
 
     if (domain == AF_PACKET ||
@@ -5856,7 +5856,7 @@ static abi_long do_get_thread_area(CPUX86State *env, abi_ulong ptr)
 
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 {
-    return -ENOSYS;
+    return -TARGET_ENOSYS;
 }
 #else
 abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
-- 
2.26.2


