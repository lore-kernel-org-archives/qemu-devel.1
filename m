Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB057C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B860820665
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9sOyLQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B860820665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtsZ-0005VP-Dd
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFl-00060T-Q7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFk-0000hy-N5
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37047)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFj-0000dK-US
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:48 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so7410565wmf.2
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=PMUWoCpuqKP+tFU4xIk4lPZAxU6QOkIu0guoobq7qFU=;
 b=C9sOyLQpIf9UG8d9SMxCbzTpCG4ty2fqSJZhYNSXG3jYoW49sUByVo8/7lyBJVZlmu
 tt6TUA3uuSTp/xroFqbWPzK4/D+9yxDomNBQTy2ofEfgvuYOLXM4ZGz8C0TMpXyxJs2r
 HMiZmb+NvhNjWtGu0r/SGpwuHrgumUJFSQTgLwvIRrBgQC7J6dsI/KK8nRXvAa32LH5y
 eOqbxJDN+U7cDmRl8iL0/qM27Kl+A/AuLigA+KCQLMtyRQbS8w/txju8JrUJP6d+n4CA
 G/aiblgelJNslnuNBQ3ytOQ8OZuaKjs8YYJqIlPYDjk2ycs9H99950koFphAyWYWirX6
 STPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=PMUWoCpuqKP+tFU4xIk4lPZAxU6QOkIu0guoobq7qFU=;
 b=AWryTgHukShGm3KHN0jvREPWJ2Q81wNYn26QJ3kBsqguYvfVHnNlxW9Ch9yUqnwQJg
 QbnOGxlYcN8gKTd5PJfFUtIFiSGZx5Bsp1mxmTFwVOX26EJX6bYoPj7n2Ds60EfOaG2K
 6hn6io32hIpWof4wgqMgxqPxsbuIkmvTgFknxPmbS98HiQAxH9pd4klvPXZb8TcRD/sV
 O9e8q47s/2PiabdX0pvQnLniTZZED0+GO4aRG0wYa2hLl9cjy5AWrYdrzvXqTIdSKZEo
 ZK8JBOlIcaUgnjEsxIdbcEltwyAGDFm7CC5pEt1BKLAHLECISmhRKBQRSzHP2xgfxXTM
 zy/Q==
X-Gm-Message-State: APjAAAXPhk7fXr2ZSgQzfLxS6HmqjJ1U8HRMD6MW6crQPcBLzP3Ihuz0
 2G43st3Fgd2btgaEGKS+oN869YYm
X-Google-Smtp-Source: APXvYqxdKGIP9cMmvM5dLh6wVeaP0szbeL01d62k1FoRC5gckefhUxKFuVPBXy5n/bW9qi4+vwxiRA==
X-Received: by 2002:a1c:740b:: with SMTP id p11mr33186397wmc.78.1576513786750; 
 Mon, 16 Dec 2019 08:29:46 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/62] hyperv: Use auto rcu_read macros
Date: Mon, 16 Dec 2019 17:28:43 +0100
Message-Id: <1576513726-53700-60-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Use RCU_READ_LOCK_GUARD and WITH_RCU_READ_LOCK_GUARD
to replace the manual rcu_read_(un)lock calls.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 6ebf31c..da8ce82 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -546,14 +546,14 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bool fast)
     }
 
     ret = HV_STATUS_INVALID_CONNECTION_ID;
-    rcu_read_lock();
-    QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
-        if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
-            ret = mh->handler(msg, mh->data);
-            break;
+    WITH_RCU_READ_LOCK_GUARD() {
+        QLIST_FOREACH_RCU(mh, &msg_handlers, link) {
+            if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
+                ret = mh->handler(msg, mh->data);
+                break;
+            }
         }
     }
-    rcu_read_unlock();
 
 unmap:
     cpu_physical_memory_unmap(msg, len, 0, 0);
@@ -619,7 +619,6 @@ int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
 
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
-    uint16_t ret;
     EventFlagHandler *handler;
 
     if (unlikely(!fast)) {
@@ -645,15 +644,12 @@ uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
         return HV_STATUS_INVALID_HYPERCALL_INPUT;
     }
 
-    ret = HV_STATUS_INVALID_CONNECTION_ID;
-    rcu_read_lock();
+    RCU_READ_LOCK_GUARD();
     QLIST_FOREACH_RCU(handler, &event_flag_handlers, link) {
         if (handler->conn_id == param) {
             event_notifier_set(handler->notifier);
-            ret = 0;
-            break;
+            return 0;
         }
     }
-    rcu_read_unlock();
-    return ret;
+    return HV_STATUS_INVALID_CONNECTION_ID;
 }
-- 
1.8.3.1



