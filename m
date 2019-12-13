Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00298C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76C6F2465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnZpdbs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C6F2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifldj-0002xu-4b
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 09:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iflcT-0001a9-VM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:08:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iflcS-0002r3-KK
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:08:37 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iflcS-0002o1-9j
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 09:08:36 -0500
Received: by mail-wr1-x442.google.com with SMTP id g17so6803826wro.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 06:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id;
 bh=hZVVOGkgb20bftRL1JMnXY5FFlbJTfG81bARHGzmB20=;
 b=jnZpdbs6SjYgk7LzucfU12QOVZDocVJ2eH9K6plxNUQI/SeeibKxVozGNn6bLRydtX
 hP3cZ3uHjierypFb2lnf/ctHoBrs1/bT8wv0qAketxyPhEoACyj1Ijfj+QsWNAI/hczg
 kgbwKjevasduibAjtifobnR6JeQuf4bAo3nn1DoEwYHX6M0MqmNU/yJLWkvtwLFQ2e4o
 HD0NOmP9NG2BhCK59GmuZ12Ou47Iz8gubkZUaI1G9Z+VqRCO3rq2ixNzB4CQCbmDolpY
 3mL49QrPq5qUeD1v5SJiMzFWihoEmqUPv3lDi7kGUqIDEFRsCoEtcmeeSQJMruvbeXg0
 rdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
 bh=hZVVOGkgb20bftRL1JMnXY5FFlbJTfG81bARHGzmB20=;
 b=Bh46O18S2qE/7sj21pRg3knEisyTAclsA4+Cv+/HAbIvhDEx7nNTGnYk8khK1oWdb4
 VJGISqu5yV/Iu6aAfoRaKNU0XNReHe6LUhKNG3zdlgOEksirDpYsbrXdyvZ2hK5MjanY
 FWefOzFBvwtzR2orb8jxEFiXMmmjiQiFeAqqsE2KRElkv9Y3C8OiJSucnVd6PGpeDNk3
 5XGKtTPo1nVW43+h7cneWXLgWYXBzAu6KPkdX2eldfIzu7KarHhAo4SOrKu8bpYxoNnN
 qT+qcYYDRMWTdNs07waOyoqvDiYgxY3NNDQJqTeUoWPxljsld+1+Ntd2glNMoJoKhIbJ
 uDcg==
X-Gm-Message-State: APjAAAUbuOw2sDot0HC1LS5sW793ndyQfmboPA8ZJ5V9OA/L8YQ2/t/w
 k2mbdb0VztYRrFrgNV5N4sPB1yB8
X-Google-Smtp-Source: APXvYqwa1E2eHoXRj8+FlttCYlWEJPPWifTNnVAuqV+v8DNKbuQAXxsk7iNw0uGWyY6gYV9taaPlTg==
X-Received: by 2002:a5d:690e:: with SMTP id t14mr12837482wru.65.1576246114348; 
 Fri, 13 Dec 2019 06:08:34 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id i8sm10268193wro.47.2019.12.13.06.08.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Dec 2019 06:08:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] memory: use RCU_READ_LOCK_GUARD
Date: Fri, 13 Dec 2019 15:08:31 +0100
Message-Id: <1576246112-23406-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memory.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e499dc2..e42a9d7 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -2165,7 +2165,7 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
 
     if (__builtin_constant_p(len)) {
         if (len) {
-            rcu_read_lock();
+            RCU_READ_LOCK_GUARD();
             fv = address_space_to_flatview(as);
             l = len;
             mr = flatview_translate(fv, addr, &addr1, &l, false, attrs);
@@ -2176,7 +2176,6 @@ MemTxResult address_space_read(AddressSpace *as, hwaddr addr,
                 result = flatview_read_continue(fv, addr, attrs, buf, len,
                                                 addr1, l, mr);
             }
-            rcu_read_unlock();
         }
     } else {
         result = address_space_read_full(as, addr, attrs, buf, len);
-- 
1.8.3.1


