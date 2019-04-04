Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70368C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3833121850
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 14:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qq.com header.i=@qq.com header.b="r3h582x0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3833121850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qq.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCPde-00025a-EH
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 10:16:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <706701795@qq.com>) id 1hCPLb-0001Hs-Mp
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <706701795@qq.com>) id 1hCP65-0006iV-1B
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:41:36 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:36009)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <706701795@qq.com>) id 1hCP5z-0006bp-0S
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 09:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1554471672; bh=nyJNqCoMMURuCw8Q3fZCj65WLicCeE3Z4+/Xo4V6XEQ=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=r3h582x0j+hRwn1xpG7vwLbISTPoVfj83dSHs2ZnF6rnkcMGzgZTwbffYSZAZYDm+
	+EQ44p1+D+T01m5Uvcm/OB1/I1t8W2dEOR6UqnLejH5qjdyL6Gc32fAA95jmVtHEzl
	cug5Zkb3eLERjxcPDXVJFGis+3QwmL5n+XetGE98=
X-QQ-mid: esmtp4t1554471671t7rysrxbz
Received: from CentOS.localdomain (unknown [110.84.226.186])
	by esmtp4.qq.com (ESMTP) with 
	id ; Fri, 05 Apr 2019 21:41:10 +0800 (CST)
X-QQ-SSF: B1000000000000F0FF101600000000Q
X-QQ-FEAT: 8YYOEVtNMVk8R2tFsv/LgtwshEzvfUz/q0APUrWv2dgvsfg3+dU/eJTtOrH47
	ksNOqoy979Xvgon+EL1VSdl1946vrmvXxIMkpxkY8KbeW+gbu4rGwSShEo09ogH6q9sXZxm
	if2TWgj+cW49NUZ7ewLIBxl1pJk/GqjWel5WCuKO8+5lj5Cxpe7cWTbJdKweh7pcNNIjZwW
	uKzE8J0HTmhf76tzxYO6Vj8nlXYYOl5/rBk0fDw3nU+e24UAiPdckf/ESdWRuEoqZufEnkK
	EhyMnlhV3ZZnizeJulGZxClCip170qfvE6aA==
X-QQ-GoodBg: 0
From: lichun <706701795@qq.com>
To: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2019 19:46:45 +0800
Message-Id: <1554378405-11640-1-git-send-email-706701795@qq.com>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: esmtp:qq.com:bgforeign:bgforeign4
X-QQ-Bgrelay: 1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 52.59.177.22
X-Mailman-Approved-At: Fri, 05 Apr 2019 10:14:44 -0400
Subject: [Qemu-devel] [PATCH] Fixed dump_buffer function parameter offset
 does not take effect
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lichun <706701795@qq.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190404114645.kBqRCSPYl7mpzWicknp_QKs4ZGxeUs9YCkCdD8Tgom8@z>

Signed-off-by: lichun <706701795@qq.com>
---
 qemu-io-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qemu-io-cmds.c b/qemu-io-cmds.c
index 09750a2..8d93dc6 100644
--- a/qemu-io-cmds.c
+++ b/qemu-io-cmds.c
@@ -357,7 +357,7 @@ static void dump_buffer(const void *buffer, int64_t offset, int64_t len)
     int j;
     const uint8_t *p;
 
-    for (i = 0, p = buffer; i < len; i += 16) {
+    for (i = 0, p = buffer + offset; i < len; i += 16) {
         const uint8_t *s = p;
 
         printf("%08" PRIx64 ":  ", offset + i);
-- 
1.8.3.1





