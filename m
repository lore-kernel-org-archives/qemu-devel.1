Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3DAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CBA020691
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 00:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CBA020691
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYIXk-0006Y8-5T
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 20:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYITp-0001WP-Dz; Thu, 29 Oct 2020 20:41:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1kYITm-00013i-NU; Thu, 29 Oct 2020 20:41:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CMk583W8Wz15PJ3;
 Fri, 30 Oct 2020 08:41:16 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 08:41:08 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v2 4/8] linux-user/mips/cpu_loop: silence the compiler warnings
Date: Fri, 30 Oct 2020 08:40:42 +0800
Message-ID: <20201030004046.2191790-5-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
References: <20201030004046.2191790-1-kuhn.chenqun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=kuhn.chenqun@huawei.com; helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 20:41:14
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com,
 Laurent Vivier <laurent@vivier.eu>, ganqixin@huawei.com,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When using -Wimplicit-fallthrough in our CFLAGS, the compiler showed warning:
linux-user/mips/cpu_loop.c: In function ‘cpu_loop’:
linux-user/mips/cpu_loop.c:104:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  104 |                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:107:17: note: here
  107 |                 case 7:
      |                 ^~~~
linux-user/mips/cpu_loop.c:108:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  108 |                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:111:17: note: here
  111 |                 case 6:
      |                 ^~~~
linux-user/mips/cpu_loop.c:112:24: warning: this statement may fall through [-Wimplicit-fallthrough=]
  112 |                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
      |                        ^
linux-user/mips/cpu_loop.c:115:17: note: here
  115 |                 case 5:
      |                 ^~~~

Add the corresponding "fall through" comment to fix it.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
Cc: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/mips/cpu_loop.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/mips/cpu_loop.c b/linux-user/mips/cpu_loop.c
index 553e8ca7f5..cfe7ba5c47 100644
--- a/linux-user/mips/cpu_loop.c
+++ b/linux-user/mips/cpu_loop.c
@@ -104,18 +104,22 @@ void cpu_loop(CPUMIPSState *env)
                     if ((ret = get_user_ual(arg8, sp_reg + 28)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 7:
                     if ((ret = get_user_ual(arg7, sp_reg + 24)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 6:
                     if ((ret = get_user_ual(arg6, sp_reg + 20)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 case 5:
                     if ((ret = get_user_ual(arg5, sp_reg + 16)) != 0) {
                         goto done_syscall;
                     }
+                    /* fall through */
                 default:
                     break;
                 }
-- 
2.27.0


