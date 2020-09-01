Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF6C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2EF9206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2EF9206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD790-0001Bm-Tw
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zP-0005fA-TX; Tue, 01 Sep 2020 10:10:23 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zN-0003uP-Op; Tue, 01 Sep 2020 10:10:23 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MEVBa-1kNaK03rti-00Fxjj; Tue, 01 Sep 2020 16:10:19 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 32/44] linux-user: Add strace support for printing OFD fcntl
 operations
Date: Tue,  1 Sep 2020 16:09:42 +0200
Message-Id: <20200901140954.889743-33-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o3ur6JqCZo4qSN9nasD1Ujj6N0dcSAJWVFOYwBK7k0Z2J5rk7FK
 l/XuWxcgHOQT2gicVeubPtUNGwnDjVdUur2Ru2Tc05FnW2djSsz/9I+YUMR8X6Sy/UV5P6P
 qp6eHNNgEO3c4dFsuvSqrjseJrcYJZQt4EX3V6CsCmzqlnrhc8WOj8glrL3kK08Ao4SsWDX
 gax1A0f3X9dkFHK5D0jyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qu1gcnBW3yM=:c2k70dmoJ8wgiwGMUehr7I
 BnlfXaPy+eB0InYKHm1GOOk7420F5TwO+v5dw7rupS6rsxCqUwmPp029OL0T/aJd14AlQr+/g
 oqa/QowMsUJgpUkcUWfN1L4PoJAiU7LFC4LBDeqexCCM128k+n6LV2v+r4GcZFbBH0+362oGV
 zS1wtfiRs4Q7fqhaS3r8ZhI/KHSSTPw6faWpswr3hp56TmyiQgt7+h/OwMVTFb+r1eAlbt1uL
 XccFO8EKtJzT1U8KzkocG8IRki3U09lsRpfXoQv08UMD8IiOHdH5W0ZBNfbr6lB0k2+XGlE3N
 6NULtDovtOmsKXWQZbc/ciVbpNiyrWi6LpkodN0pH093AvAhdX0cnLrs+1579xJG0DffINm2Z
 Bh6poE1cFd/R8XYDp7hXIHm/rDbKjl47WkIZs3++RkGxksL8JXxCvab8nGd/aG+BKgRcX2LiS
 U10OmD9kgJuXM55NxitUiUnTcqrmbpnGnsoMkYUm06DHvhgTBG01AZ4axYtcj8pM+J0E4PdMf
 8MMs++aH7ZN6jTck53e+K1vHE7E1XksBX67MH+yiyX3Ba8tcZ3qOiTNEu+LtPGXEpIeYXeQ1F
 aLIx7TYxYgoHAYbjXazL42UcvrDer/OqGygzn+yRcs1lNChBPbIK1YKPPm8Ervz5a3keFlsBy
 3kn5nroVloIS9F0W/MYnjxSHvCTsmyvWBVDWVrBQZ7BmngJKG5flu/3kOPXXcvMDjPng3P58+
 ARLDpTrBczOEYwuCjf2Vyf6uUkiCd6/Gp4zPy/sviBfqRTchV6lT9gPVUvllSNhPfy6CqR7Cy
 L5rykaFLhu9RCnjW/8KZ+DIhdU/V00vH15Qi5xWt643rVK6sursTq/p2vO9TP6E/cKbR/6M
Received-SPF: none client-ip=212.227.126.131; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:10
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
Cc: qemu-trivial@nongnu.org, Mike Gelfand <mikedld@mikedld.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mike Gelfand <mikedld@mikedld.com>

Signed-off-by: Mike Gelfand <mikedld@mikedld.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20200830092242.31506-1-mikedld@mikedld.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/strace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 4f77b0cf76eb..11fea14fba2e 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -2056,6 +2056,18 @@ print_fcntl(void *cpu_env, const struct syscallname *name,
         print_pointer(arg2, 1);
         break;
 #endif
+    case TARGET_F_OFD_GETLK:
+        qemu_log("F_OFD_GETLK,");
+        print_pointer(arg2, 1);
+        break;
+    case TARGET_F_OFD_SETLK:
+        qemu_log("F_OFD_SETLK,");
+        print_pointer(arg2, 1);
+        break;
+    case TARGET_F_OFD_SETLKW:
+        qemu_log("F_OFD_SETLKW,");
+        print_pointer(arg2, 1);
+        break;
     case TARGET_F_SETLEASE:
         qemu_log("F_SETLEASE,");
         print_raw_param(TARGET_ABI_FMT_ld, arg2, 0);
-- 
2.26.2


