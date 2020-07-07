Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FCC433E1
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0978E206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0978E206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsr8w-0003Vp-8K
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsr7p-0001tS-HZ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:11:21 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jsr7n-0001We-PY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:11:21 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQdI8-1kEO943odq-00NlA2; Tue, 07 Jul 2020 19:11:17 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: fix the errno value in print_syscall_err()
Date: Tue,  7 Jul 2020 19:11:15 +0200
Message-Id: <20200707171115.533166-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mbdHdlIRaJlrPKPTjeBlVNZSCH1MilbIkOqONOMFfzb+d9qSVnc
 48ttWRrI3w+9lloj/CZtPkFfVx9KpPogWG0k4myKMui2Kncd9hObwBrmtDGjE+DIL+wzZKH
 LV+JEr0ZOWrIf2HpC1s1TAtJxE8uin9TKzB7cyLDDL+8ZbdkneSZhlU6ho+OeSl/bXi2Djy
 oLd+x1k1M8/e+CJ0i8HQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2qK0BQ1RqDI=:zYzfa9/NUc0q3QBtFDjq4B
 F8EqSNP76gx3JGtJxg04DjmLYXXDAsQQUz/73kCeTMKglMm4IFNjdg4arT6ymbo5EpYb5nJf7
 aGdhHfs6fUWjQ7bkBn2BczgG32hIft2agvDCVwDlOnwtE95k8jx8Be3WrxnAnwaV3pRZug2ue
 gH/lZBdsF2QyC5DVMT/FDpxW/b96MJIZ6177DusK7H44kxkMjths4Uh9/Jhojp0u9A/NEzMQ7
 UCTrgflCkthGG2tfa4JvtaQWYVjoEW01Q/aZsmCOVThjKhBBxr0G1SWj+9FAiJySpdN3vNs8u
 KPrmftHM13RrWMjIK4s7HgU1zQt+vlUL/ljsmXAd91lZrWm2GrqlXleOVdct+++Agp7Gh62km
 nG7Iq+dYkwT/fKyMrqRyLTeno6wPLLT3ruIBZpTXnkLD6B32StQ8i+jw2TpgklaT9cChdGkJQ
 jADl7OVW67iZbZhFscgOOh/ArQewP0RiKwiAZ4av2Pmf0xF9/MxdiLptbvVCZ2XMXTFHp5733
 oczUKDKUJbtg9p2im/6RnKM24s4TiLj8GszdrjwejhvPnNxi2v+DM6wQ9IaUmfG9FTyE5mErC
 WJ4Esmh9rQB6Z1YcvBSdx6mhZp41+w3EQKn/2bBBFP4jRBJ6SiFNh7atYW61ZNGiJIP6aTG1o
 C0NKAXvgzPXhMNEIPKxx6UtjNyArtIDhe+t9VrBjtaiiNWKs8IAnTPSK2bG4yk1bYDgspE7m1
 37QPzhz7xcNeyEWKd1XmtDgTIkYxMMVTSs/2JS5Hf9P7z5cQng/7c8acrd1BYcV0OAfXuBo3D
 aHseXv6S8LRsnChaJ1UGVZ/28EYpljydQ9OfX6L4rhVT0Px+nsNlDczCLh3kVixeSZMzNg2
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 12:18:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

errno of the target is returned as a negative value by the syscall,
not in the host errno variable.

The emulation of the target syscall can return an error while the
host doesn't set an errno value. Target errnos and host errnos can
also differ in some cases.

Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
Cc: Filip.Bozuta@syrmia.com
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 5235b2260cdd..b42664bbd180 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -731,7 +731,7 @@ print_syscall_err(abi_long ret)
 
     qemu_log(" = ");
     if (ret < 0) {
-        qemu_log("-1 errno=%d", errno);
+        qemu_log("-1 errno=%d", (int)-ret);
         errstr = target_strerror(-ret);
         if (errstr) {
             qemu_log(" (%s)", errstr);
-- 
2.26.2


