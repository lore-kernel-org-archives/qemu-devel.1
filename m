Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9008DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603CA206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 15:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603CA206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtBxS-00025G-Lj
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 11:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwI-0000jG-AR
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:50 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jtBwG-0003rN-Hc
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 11:24:50 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPXxi-1kFgtj0fyc-00MaZS; Wed, 08 Jul 2020 17:24:45 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/2] linux-user: fix the errno value in print_syscall_err()
Date: Wed,  8 Jul 2020 17:24:34 +0200
Message-Id: <20200708152435.706070-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708152435.706070-1-laurent@vivier.eu>
References: <20200708152435.706070-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VHD9ehhBaWuKdpbNajPOHdzu+ebTX4PFxPkHtCs6Hovgx+0cpcK
 4DLmKJdyzf6PoQmDc18oF7dL/C44LLiLAgWylzgwRmf/0p1LH21i01ycBgfLAdBG7Gm4/p7
 y6EiNNKorhUW7JNnRV5Tb+NEWQuzuKtQ0L3WM+4vbEAXdtuM6iOtuImjkuqiRJmKdMu18J4
 N1WdJrNG9wPUktN2+LHww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8yHDU6Z+D8s=:8wkcHH1x+ALEDFbjqmeSi5
 S75Fv4hNwcZAKy4xMedCJe1BqVe1Y5EpOhmzuVrjM/9B1YVULI2gd8FNIbqvXWgrQ8fe8O8jZ
 HTIOssGcME3BupInb+4c05pfQZRWGNNrG58HAC8sa7mv8dQqJ2NDHPljx5UWoz4NYcMSpq/80
 HIfvPfliwKLMw9vCtPYBsd2gNvI/Ols7ZYskmS4mgOwRiGGO06PP9bDNX6yl6/JeSoKzSkgmW
 f8kv/oFhiiU0ftFaNgM53aQrntcZQa2fWpuuREd/DtZ3483BNOcHGe3D7kEB+MA4aJyKD70MM
 DUsDsk7nAMnHJaAVhJiqsqPBdSoLB4W7kZw/14C2I7EiFv0Wu4K/KWUiJ6lgFccl0ZsezrUHe
 VHnDRufG4hT8721wxf8/NzyfIO6Pf9UOK5vgho72PGkcay8c3yxScdHoD35MACMA9KnLV9DUt
 dSEFel0tJ69a+P9NPCjLmVmWFvz2bfvUnXkoWAd0wHzk1L7fhrhN5YgOUpdG5865LRmM8n0bR
 OY8BLYC2y78VgAsYunoXUXU+OKjEXa49tsMqYGbxrCU19w0o76hqT2R6XoNJ9Xe3u2e70y6Uh
 KFAJcuEZzG0zgNEENF/FZBRhwNqB3rq0miPFAex1F2X1AvCzOuTmDnQh8SLZ0135eXKlWYc1L
 L+n4aS6RdCbS3SHBIhJecTGtalCMhjCKYcOCOFyKKwr+zG0EwdTgFDEdBuidLI7/SFwO/XXU2
 0Ev9Tpoe9JTBlEuOuPNSvsdevHHH/h/LnHHrWPup6zV0q1biZtFRvBhqGHQvUpBjanfO4EqNX
 ZrwhIcCGD9jYvJow2aO8fc9xsswy5dVRe8+nZlkEl7uBDAdswSy/2Q5LqwF8CXRnmV5LA/P
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 11:24:46
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


