Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93227C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:59:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687E220781
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687E220781
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k67Cw-0005jr-NG
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60442)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673c-0006df-M7
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:48 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673Q-0004cu-1L
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:48 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Ma1HG-1k9KY50mNY-00Vxhe; Thu, 13 Aug 2020 08:49:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] linux-user: Fix 'utimensat()' implementation
Date: Thu, 13 Aug 2020 08:49:23 +0200
Message-Id: <20200813064923.263565-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ciq6cPuHeA4AGiSmNqi0J42q6MLfR/IXUMXK4fPs/iZgsmVr6jD
 lHt0vM0mVHnqPPFpAW7VnaC/vhwza4tlJuKZ2LZsWUgACMeaYqj/LTHKIfq1PiX3aG6IP+E
 wtWtjU+4HSnogSoAfkPPrWRkJB5PyJRo5yFeeTQmpwRyjwzAaeOFAtQEunUOvxPN9SjMGL3
 FtcAn1fPtZZOcSFiQbkVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zmZxLy57UYI=:qhlGyJnwzJXAYhd1gjj4XG
 DmsnhoLOjF0XrC8hxDMt3FPbHDPAVzFV8SjXra3Vd/Gkj0dXv0fhRLU/AKld9xSFrLVZlqWFn
 YKHCKVlZ8Kqkmx5Zcy6k7SFRm6qIRQRCVmQfsSwOy9CdQY1Zk7lncgiFP6BD1siDdeAEJRKu9
 cjHqDJ3oLIIlRqLDmxmIqyUghsnTu3dE2fMAKmxz2r0+H5WBLi73ctoCHjeUWvcl37+d2jo8Z
 rlUDV75LjRluRsM71wbd3ql3sraTcQ3wAQe9e6g/KP8Wjtix+ZxjqQhV2SHoGDWoblcXMxOXv
 PMuB9ncnheKaql6Klc9Q7k0cyXSKr92+RoXty6+Klt1cxZaVcC5EgFW5LlZl0w5noRo5YHOdj
 zRL/jD5JUIiqw3FSVbooXJPZtCklbBLS9yvjqT6axWu0//tAO9++DnmTPG9Mt+gTzkjkVemiZ
 cdABxDbVsV6sAaY3MSD55fdGTAslyjsbbCZQx6bdk1ls/LK8KXQ55YksJ29d05JK1pC+q4DFi
 AL7OKTJdffab36ANLb4MjvIxNC8V4/l8//4kgF8iEd+uewoVeA/6vSN+kODP4psDQiUcgQdmI
 ItX7dGHVxuheS9EXA/U/b8PwoFhGzRz9LdOm3pTiuXeXw909ONbgowOWez7EjcJA4rt1FIIsK
 qi+4j7KoFK46hIaX/bXhfixUA9l89GuGMix94rRt8ufCgLacogulczI6IDfE9lGCrXz+T6QYi
 O0aS9tu5/6ee9A2WoHye/wWXWMvySBn9IWv5+iBIaBSM4U9TFwtv2qNylkZtu6xwCvz61DiGr
 dovxunUbo0xAXGO/5kaniEpTrB8ny6zyRDQNRpiN05HQoP7rWdZBPddwR/iRp1by2obZUSB
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:30
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

Implementation of syscall 'utimensat()' in 'syscall.c' uses functions
target_to_host/host_to_target_timespec() to convert values of
'struct timespec' between host and target. However, the implementation
doesn't check whether the conversion succeeds and thus can cause an
inappropriate error or succeed unappropriately instead of setting errno
EFAULT ('Bad address') which is supposed to be set in these cases.

This was confirmed with the LTP test for utimensat ('testcases/utimensat')
which fails for test cases when the errno EFAULT is expected. After changes
from this patch, the test passes for all test cases.

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200811113101.6636-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/syscall.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 10dd53bf999b..96ae942909ab 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11922,8 +11922,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
             if (!arg3) {
                 tsp = NULL;
             } else {
-                target_to_host_timespec(ts, arg3);
-                target_to_host_timespec(ts+1, arg3+sizeof(struct target_timespec));
+                if (target_to_host_timespec(ts, arg3)) {
+                    return -TARGET_EFAULT;
+                }
+                if (target_to_host_timespec(ts + 1, arg3 +
+                                            sizeof(struct target_timespec))) {
+                    return -TARGET_EFAULT;
+                }
                 tsp = ts;
             }
             if (!arg2)
-- 
2.26.2


