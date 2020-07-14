Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB676C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:37:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF28C2084C
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 07:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF28C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvFV0-0008MV-0x
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 03:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFRC-0001fG-JF
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:14 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jvFRA-00025A-MA
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 03:33:14 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAxLT-1k1b5O3U3F-00BONa; Tue, 14 Jul 2020 09:33:08 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] linux-user: fix the errno value in print_syscall_err()
Date: Tue, 14 Jul 2020 09:32:58 +0200
Message-Id: <20200714073259.1464675-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714073259.1464675-1-laurent@vivier.eu>
References: <20200714073259.1464675-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oCUu1ehJPhU3cSnwuBUwhoU/Os00IvSHSwc4weBqHvZLuio0IDa
 l+4ioJa6FCbqrWssA/ojEMMcDog1Rd5FtwucybHQc38ASUdAHNqg+nNwj0wRsdIb7CZPbkW
 guzn7LqIfmz7+SK3IsbuyGvuM7QSZcLIetSE1V3qyKPT0YDCo10XJPh80YVRhieg3f/so2M
 HVcrysSNgsV6Dtg6xMveA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7dpG+BiOCmQ=:0gJOjl1qhHCMD+SiUvKFiF
 BW9BHtNfO8rIlWJ1pHGIjJskFbFTmAe/xCLDEcFSgbOZCQIiHkFMy+T4KpO2tFcGfDECx3zIT
 OY+9XXwkV4kZQjT+MMTQI1lKKiB1TUdxo1jZeVtgj02P3sIfrMmolY9kKM0BL9wpAIrzIxGEp
 Ui+Bxbpd2OmjRBznViNsmj+RrRYnHEzLAfQtJPCTSlkobdFA5bphSTDyrU6v/oq0261LQsUsu
 jgDNWgvaWA60/91mPH+Q7g6RsZQ5CrQnIgxj4wCMjDq7E4VfonOUMUjz6tKQbR9N8xBwJWoLn
 MYHaGLiNkHJuSLjwXXtBbp2NDQETBIo7yN8+hWF6JaOHEXchPli91PbooK7ppc7Vy49nQlWeC
 uwVIqDIPB7/iavoXKJ88srjI8fCm1F3KJ8PocLKd/J/7hMK/TBkLPluyGoZ3/hqbi1ebV+0lT
 XRBH1q5cslJFQqvksgkSOHX2RgH69VPMOcYiLABy68wp5o5thZAgBEubxE5ZJi4/SkHn+rUFf
 RyXWGQS4IvV6LjnuAWUMZqUyXaMZVV7v2ndkHv0JN9F2qVJFPtSMfvoKbwJoZTBY75rFKfcf5
 bUZdEW1FctJIVwD7BfYUUbPgIrABAeR5vEL6xDYCOlcdS3xe2dDtExliLoo6mZD6tKDXoImIY
 jbs5+r+lLriVaYvsTStKMni/pMCO2o0FvMC2nv0h8QQ+Go6g7zJYHdeIczyPrnD8eN0hH9mES
 gGNRxUPBSbsm3kSOAjP3/mXyFLAI/y8oSEWdW+AT+BSGR3/4i5nXYaBMlSym/4dOdnM8jwVRa
 FDtfhTUSDIfTKuhUSyOnYkdTtZ3oPGYwBS6I9Lc462CQaW8ctudZEpxa/hC7JnzJUwcbwnA
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:28:46
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Filip.Bozuta@syrmia.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
Message-Id: <20200708152435.706070-2-laurent@vivier.eu>
---
 linux-user/strace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 39554d903911..7769f53bd5ed 100644
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


