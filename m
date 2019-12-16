Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79FFC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7663D206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUmXWaGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7663D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtcD-0000H5-8I
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFM-0005OV-43
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFL-00081d-15
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:24 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:39552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFK-0007zL-QR
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:22 -0500
Received: by mail-wm1-x331.google.com with SMTP id b72so5375224wme.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WjRgIZ5qePVVbis5wVrr7iekZjJDuuFlCCqKYtN7ZTM=;
 b=JUmXWaGMzO8UioG9KTKHtW8U23SKuq2LL0XPNjgreOg/xDgEPalF08ohbjPtnygXhC
 W2LaV4gVSGBUx2rCOCjr3kLzijti5gHNf3s68tcWtved7qcjFXBDKdKtz/YcYqdUPbQR
 Z/OFE40Xg8iuxYH3SROVULykBVmZiv+AGDGytC7qDKzthAb3Y9DUpXCRzbbrWSvX7A2a
 U3GJlMmNpYQoAjiHp0b2m4hkJoGAq6EVQ7kZtvyMCeWAnZ3qzrMq6fgsbU8c+m6wybrA
 eP/GHvHdYFO83W4tlgqND+eYh5M1ADB3l/CKVy6Q50fXnGmwCfx4lMPydmPnegXWoBEe
 KyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=WjRgIZ5qePVVbis5wVrr7iekZjJDuuFlCCqKYtN7ZTM=;
 b=J/oVxWya/kDjugQ2zIiTTZKpcJWuFfgWJJfxy/1CZ+aKc3SSMZh5zgTx2H1qvPPomg
 xVJnJbIvX0TJ3ULdkzhgVRfqm/N5UJ2hp3YrGM5HEZ2FlLV1dUK5oDgDhzp7LgWM3zOL
 rPnYepW5BJC+g+NQ/puHvXhtctsqvhmN+rQtsUAsGfnDsbLuBsopbEY5WDctVWE5GOWS
 ciLQf6xxy6bixcd3yDj5PxSIM/cheLdo8E69Tf4g8LJS5gMXP2kH0JRgaD9wBYJ4B/iS
 9IuqNbBQoRGHwRG98Lv2ZrNnVJDlLA//ez8dD9IdW/LRj9/mayHMWqOy6fbDHUuzPRb/
 lb2w==
X-Gm-Message-State: APjAAAXwD6IDe9EyN3VkcnwGlluTCBiSWzUXdH8NtytSXAJlTGiykchH
 Tjq34NNyy8K7zqHD35a9yjk4qW4L
X-Google-Smtp-Source: APXvYqx3510oLGQATAh3ke9cWF1UswFWulfF2GCgbVkCjbtmt6zIBnAsMvR/OeYcWjdSn6mg8iLPow==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr30231145wmh.74.1576513761680; 
 Mon, 16 Dec 2019 08:29:21 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:21 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/62] migration: fix maybe-uninitialized warning
Date: Mon, 16 Dec 2019 17:28:18 +0100
Message-Id: <1576513726-53700-35-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
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



