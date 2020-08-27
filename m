Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57922C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2152F207CD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2152F207CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNYC-0000CD-8S
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS2-00047n-3E
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:46 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1kBNS0-0000F2-2w
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:20:45 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLz3X-1ju7a43Nb7-00HtDD; Thu, 27 Aug 2020 21:20:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 14/18] linux-user: fix target_to_host_timespec64()
Date: Thu, 27 Aug 2020 21:20:14 +0200
Message-Id: <20200827192018.2442099-15-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200827192018.2442099-1-laurent@vivier.eu>
References: <20200827192018.2442099-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CxGRs9mXvVilNaZtC1+4zOwQ4YePjGTWdV1cfU3v0vhyS+jNciE
 lnxORXPq6DQNd552ZLo+YEp5Ffd69UW9teohj9FNtCDeHSsTpD7WzjEJMhuWjP3V61TREuO
 tHFU6DnpHH9OawT6tOJmbKm7hG8TUD+4Jb6zc68phWhs1eor5zXgdPX74ZGbYUIenRuDAba
 X/dsKZSR58XL9w6yM5eqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bLdgEUoafGc=:NOlUBAdb7Qe60cJJRELIv4
 8WCz+MZfyvfhZ0BVGm81Fvv/PR1Ubb4oO5l9HN+4KzpdnirWwOzTxyRCnCOvsh/2YvB7DMrMV
 Xc/FBiagjOKAR5BNDUSzqG/q9Gd8LpQ+TtUHcjOKW+M0RHxu4i+WbPAhHGWGHqntVHbBoHN3M
 hwUd1UWJig0EAMNSAydZ062GU/iTSiC0RISjrDVxDXuE5VxofGZ8bW1asaZT+xO/l2FAMjo0t
 V7zJLuX4gScVwCe+aoO45comS5MQIjucGE5b3JK8NYsE+rb2pC8dLVsGpyGIRDXzL5C8f8tsn
 RCj85SaOV1CLoELAaYDo1FWgdUkP4e+zEMRuC/rpKG7Za3qtqvLZbRpFQg0IP6oRQuHGea6cS
 D62WBxnGnl8dVVFrHp22Mccy6B1j0WW1UwJyDRVrMyHiRw5oDns3BlIYE4hhoRPBuL3k2+Ti7
 cP0nz5BPQjssoO++vYlAxVOMO5+fSr75PxN0n2G0z1f8Hw8cZHUPyoViDdSvc5w1/QPRrXL64
 t3K3eQlpK91dFzcSELEtQcsd8Jz0HerO+YO18V0uRZUm2oYSMPXFecL+1Us1eUUXOaobeImO4
 39pZxVUq1Q5LNc07ejKAbND5oJ4zqcJhf6NUnw/wzgx5yHZQSN3gtsmOi+WjyGmho/L22OtBf
 LU3+FzVBBgMqn69NNk5zFynCdU7QthjFISti6cJ/f7naOqC0tnAF3/RamfYFKAa5N/D9kSwRH
 CW5VMujbACnt51fvQrURl5rgek9unwuAiRpxOKQGgYrj8gmAU43z1p/bp5tdEwP4fppeO0W1P
 TE38jFuw/HV1ViC0ObFd68V6zLW3tFTJTaeYVm3UefLkedwv7l0vwDikAt6bmlhdqnbLabN
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 15:20:29
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

in 32 bit mode, drop the padding in tv_nsec. If host is 64bit and target
is 32bit, the padding bytes will be copied from the target and as the
kernel checks the value, the syscall exits with EINVAL.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200827070449.2386007-1-laurent@vivier.eu>
Fixes: c6c8d1026e75 ("linux-user/syscall: Add support for clock_gettime64/clock_settime64")
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fd13e72305de..3b725bbe2513 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -1229,6 +1229,8 @@ static inline abi_long target_to_host_timespec64(struct timespec *host_ts,
     }
     __get_user(host_ts->tv_sec, &target_ts->tv_sec);
     __get_user(host_ts->tv_nsec, &target_ts->tv_nsec);
+    /* in 32bit mode, this drops the padding */
+    host_ts->tv_nsec = (long)(abi_long)host_ts->tv_nsec;
     unlock_user_struct(target_ts, target_addr, 0);
     return 0;
 }
-- 
2.26.2


