Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADC6C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:28:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3B320836
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 14:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEfaMqGC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3B320836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if2yo-0002Ml-Cf
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 09:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tv-0005Pl-CW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1if2tt-0003Ce-FZ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 09:23:39 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52735)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1if2ts-0003AT-OP; Wed, 11 Dec 2019 09:23:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id p9so7296955wmc.2;
 Wed, 11 Dec 2019 06:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=WjRgIZ5qePVVbis5wVrr7iekZjJDuuFlCCqKYtN7ZTM=;
 b=WEfaMqGCuUlAbbxFYkO+RkiTtHeG8X+1D2/TZe01d5Pv6HxDHUMHO7tONfyG/qNnsr
 bUQr07YzwT2kbYLCEfwMGfwKeWlhZFtXeaUSgjTs3evCS2EfQPhkL5vrEeu7om4ojIDU
 +qnuMwqTi/wWRnHXpTBDjo7bDePQgZ7m3btSrwNuwaRARrS3XqwG8cfItcX5uhal7R4f
 vZrTd8KSmnwJuj857261waDF07emNMPDHrmFVflNUwZdyFdC0avK7IGH3pB8JXSO5Zy7
 puChf/BUoNmptO/iKvzWeFiAJwy8UHGsUuW6MU1PjvHuCFALw9PLrPagpp7RBgoAE54L
 AF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WjRgIZ5qePVVbis5wVrr7iekZjJDuuFlCCqKYtN7ZTM=;
 b=ZFxIeI5CkfdmrpxRjUdujnRPCizSvPyRFiNwPUI31eaXLUrT092Zww9iILjYQWFWtc
 Mv8IvP7PscWJDcO3kK2l63S0SUshBc2Io6XxbgsHo7TJ2wBkPE9IgVMVqYVwqhIsAVo0
 5msAiMM3EVyMig9oNuEfXP8wtNaILpYMzoyZdPdNRbz93Dovs+nWkkiIyoWQl7usAIJg
 FOO9G5CJocQA2ARWmbiuVzlQNtIQ+DYomJGgayTfenkNKNEb2+XfmQyfd3U6p8olCwXA
 V+0+q9lqytJaMi31hO0BIrhXy94fEf4drxk/jsrwWToR9+lknS2uNOQbEHO8wgiD8ICl
 Cw5w==
X-Gm-Message-State: APjAAAX475TJDVySAIGNzmKS7lADGLZqTswznXJ1wETVMke8QoIt+ht1
 prQybbRMNsrzPIXKZfAup/CearLS
X-Google-Smtp-Source: APXvYqySPGzmde3Kor2ZWDovZXS+gGeYpLbPi2/kwDQHXfKGMj44DpLt7N6V05b9T5++KqtYRUznZQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr83046wmf.60.1576074215437;
 Wed, 11 Dec 2019 06:23:35 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id g23sm2503783wmk.14.2019.12.11.06.23.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Dec 2019 06:23:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] migration: fix maybe-uninitialized warning
Date: Wed, 11 Dec 2019 15:23:25 +0100
Message-Id: <1576074210-52834-4-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../migration/ram.c: In function ‘multifd_recv_thread’:
/home/elmarco/src/qq/include/qapi/error.h:165:5: error: ‘block’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
  165 |     error_setg_internal((errp), __FILE__, __LINE__, __func__,   \
      |     ^~~~~~~~~~~~~~~~~~~
../migration/ram.c:818:15: note: ‘block’ was declared here
  818 |     RAMBlock *block;
      |               ^~~~~

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 migration/ram.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5078f94..7dd7f81 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -864,15 +864,17 @@ static int multifd_recv_unfill_packet(MultiFDRecvParams *p, Error **errp)
     p->next_packet_size = be32_to_cpu(packet->next_packet_size);
     p->packet_num = be64_to_cpu(packet->packet_num);
 
-    if (p->pages->used) {
-        /* make sure that ramblock is 0 terminated */
-        packet->ramblock[255] = 0;
-        block = qemu_ram_block_by_name(packet->ramblock);
-        if (!block) {
-            error_setg(errp, "multifd: unknown ram block %s",
-                       packet->ramblock);
-            return -1;
-        }
+    if (p->pages->used == 0) {
+        return 0;
+    }
+
+    /* make sure that ramblock is 0 terminated */
+    packet->ramblock[255] = 0;
+    block = qemu_ram_block_by_name(packet->ramblock);
+    if (!block) {
+        error_setg(errp, "multifd: unknown ram block %s",
+                   packet->ramblock);
+        return -1;
     }
 
     for (i = 0; i < p->pages->used; i++) {
-- 
1.8.3.1


