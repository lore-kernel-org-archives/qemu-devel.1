Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E07C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6299B2067C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 15:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6299B2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9rVH-00018I-ND
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 11:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSs-0004s2-G3
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:22 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k9rSq-0006eB-7D
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 10:59:22 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MJn8J-1juocW3R85-00K4of; Sun, 23 Aug 2020 16:59:18 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/6] linux-user: Fix 'utimensat()' implementation
Date: Sun, 23 Aug 2020 16:59:12 +0200
Message-Id: <20200823145912.1171738-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200823145912.1171738-1-laurent@vivier.eu>
References: <20200823145912.1171738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n5vp6WaM/sVewsc4RZmh7Lyl7IvAgtl3tE6ukSGIg3/QHihDSIJ
 MwKaWLhRVKWhbKMVPe/wgFBN2A7OjKsWpxMI2MIRhd9jmjMT8qSbyXGdJ+7HZWCKAcSQC+A
 3qTDCIL7gaQ3nxcEUdVlowKcFeSMucHsI1KsOIBpJhLlXtO/QsoO2bfDdDlsUrD8E2E6rmJ
 WpCl9FkFeng4jRP1/8q+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eO/moa8BGRk=:dnfDGZAAdOKdLY80ZjTjZ2
 lFNu1f1gKl+UnJnQBuEOHDBqg3HUAlYjZzYU23cxU9VwTmLJbEjvddH65kdm5ES7qV6h/Qotc
 XgLniILwoqT4sG7XTw/1GUV39K8lpr/Twmu0Vkt71bfM0NuV4GqS5of9CXPlpDovHPumEqHqq
 2iEOWQ8qGtF9n62lV2mK8zaWFBBF54M0m5VtieiiMuPJnw0gQ9NTp6V8hXKH2Dv6511U2Ehg8
 6U7Qry9nM43m4uFr63s+6JXUCFrnJbQpW+vO6fc6PVa6xHhl2HYAu0lI9++lGU4nMiFgRP0YR
 kL1bMkN7NBceo+g6Wi0UbmW5WpPtKxaRDKdUU42wrRUy+2VLKvnlV1YF8P3vX2Kn9+pYFCzuA
 A30Z7fUmkXAdi+ON9Y0BbK6jnDN3Zaw+Y1NEtkqsHev147Ukk1Q+fxbtsd/bpzReNKwSctj8t
 9dl0PC3u542uPXSHXhf5XSwTQpXgzhDnprJGayi3if3efD3iCdQebe2vSWO6TleniPjRXWDtL
 KH6quW7TjcoeWSVNuKUFxFRXMObbmXV1A+wtkKwh0vv70iocEHkb46L1lUjqq98eN7/6y0dGw
 vyMycD+WECBpzkhkQst17OHODyBHxQiJcYuR740DJ2uNfIcexn4vKM0sF5DZEIaMvCDJGDoU5
 G31WHIfXkomeYsxNMcC7gXlqOFz9XefB5P5QGexoQTdoBE7whqgC5X2H/rniM2vV814MDjECL
 bGZljGfi4VGGJoKgilV/+2NOX/4yxJrAm8N4U9bxh7C9+UKWoVKyNoJCCiI2z6RM2ks1/tUFj
 mTCxzsqh16txGt7tP130T5cjdwTfMLuIxh2oVLFVi3gJHj1cbDwpPRaD1Pz8gGYkTQDLyvH
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/23 10:59:15
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
index bbb61a59c72f..b4a7b605f3d4 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11919,8 +11919,13 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
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


