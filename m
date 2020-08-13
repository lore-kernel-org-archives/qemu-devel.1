Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EBCC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:51:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D688D20771
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 06:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D688D20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k675D-0008H9-4O
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 02:51:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673M-0006PB-NK
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:34 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:34523)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k673J-0004bo-Dz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 02:49:32 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MOAmt-1kLkDs3L8j-00OUWp; Thu, 13 Aug 2020 08:49:26 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] linux-user: Fix "print_fdset()" in "strace.c" to not
 print ", " after last value
Date: Thu, 13 Aug 2020 08:49:10 +0200
Message-Id: <20200813064923.263565-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200813064923.263565-1-laurent@vivier.eu>
References: <20200813064923.263565-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:k5WNklHgXJAKgUwHlCIhV2zupA6XopnwoqkM277mTHnXabjZgdG
 wl5JRLifnUxquMFokwBe0u/NEP/tGtdpeAGI6qIL4gKFalTJi2bSrlkOdJZmztHyvJrV1Vz
 w5D0i7XwBtE6zT+/LDzogqHinT9FptiFVTbNc5LylHmsTHL9AKqUKBOkJOVkSs3fmq7K4kS
 yJficVuZiEbdclqj/fjaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tx9HswNVwAk=:4qkAh7xZCsL+2Q+FVc08aV
 he/v4o5ENEnL8pfTT/ogi6bGPmc3xJ8p1VYNqNM16hYqgrOXwb+b1XfiKDmgCfrkP0bbV4SKB
 FcDak6mI2kk8RcHtwBxM/2VDEEibQZasUK3IErTGqVY7n+YXygfZoM7pUnxpdYuCqaql+wQgf
 ktvCeb0FaZMs+Fv1n2s2bkqnUGYvEKhj+dW9WOIKtD2g7vuVgZmsyTNARExQL2GzXFKu3WXDG
 i9n3fd/p/9kc15cODcVJX3a6KclF/KFGtaA6lFo9wHtHnLx5UMyUiO7hvps+fzjmsg6CNO6jg
 z0lyK9IOAK1thBtk7A9G77m6MiFhCzIeVTIuXsZW/FaFfJnOSklJ3qbCFp2rckuFHq5xPpcSb
 Ak+yJQodMB4fMus//odXfWCBf2h1vOlHvk89hDpskX3qzrF1PrcBrMioGMCw69OVRRzp8SG2y
 gurNxHSCIkSJg9dL3Qcd/7N7Hc7WSrD2xdkfSm5CQW/IEtgISq8hvLW7+JwvS/Jf5ENeG16Nl
 AjDiq7YEe4f6eGjID3CeyGA7q4zWyU2Fb46NHkPUIIPpx9WrHUTtmtsmrICiH1+yaKzphY9f2
 jg2q1XnmRW4Zy2fdIHl5ddSOdqFk+Q9Sm8v+te5L2NhLDZWHjgsol17A/VdUeB8mU3mYkxMBz
 gy8Fz/7R/TzS4sC5I7QGlnD825p8gs4/BETv8JxplbuhfFGXWnLbRALYisR9Fz5yM2pgi66YX
 Dgqpyho92SwqCGYKwMIqRN5MEAUBN8Yb20ChDTzAbxqWRvJH2jRt+7jC+ZJKe/Zsr4vkFBKnu
 YnlXSWjxlIkoCALHL2XcJoW2sOh6zK78f7GbH19voVDxJkPgN538g5N2wjapRaazsZwxBNm
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:49:28
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

Function "print_fdset()" in "strace.c" is used to print the file descriptor
values in "print__newselect()" which prints arguments of syscall _newselect().
Until changes from this patch, this function was printing "," even after the
last value of the fd_set argument. This was changed in this patch by removing
this unnecessary "," after the last fd value and thus improving the estetics of
the _newselect() "-strace" print.

Implementation notes:

   The printing fix was made possible by using an existing function "get_comma()"
   which returns a "," or an empty string "" based on its argument (0 for "," and
   other for "").

Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200702160915.9517-1-Filip.Bozuta@syrmia.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 13981341b327..5e380486433c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -541,6 +541,7 @@ static void
 print_fdset(int n, abi_ulong target_fds_addr)
 {
     int i;
+    int first = 1;
 
     qemu_log("[");
     if( target_fds_addr ) {
@@ -555,9 +556,12 @@ print_fdset(int n, abi_ulong target_fds_addr)
             return;
 
         for (i=n; i>=0; i--) {
-            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >> (i & (TARGET_ABI_BITS - 1))) & 1)
-                qemu_log("%d,", i);
+            if ((tswapal(target_fds[i / TARGET_ABI_BITS]) >>
+                (i & (TARGET_ABI_BITS - 1))) & 1) {
+                qemu_log("%s%d", get_comma(first), i);
+                first = 0;
             }
+        }
         unlock_user(target_fds, target_fds_addr, 0);
     }
     qemu_log("]");
-- 
2.26.2


