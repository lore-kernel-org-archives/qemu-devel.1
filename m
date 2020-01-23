Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E9EC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A70214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIySqjIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A70214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuep5-00071g-Qb
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrm-0005ad-TQ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrl-0004VT-Qg
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:50 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:35787)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrl-0004Si-Jz
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:49 -0500
Received: by mail-wm1-x331.google.com with SMTP id p17so2627119wmb.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MIVPt6AfB7Si2oRFoeO2RPXJ/HSxWbOijJs6IvacXC4=;
 b=lIySqjIGpijZ4dJsytu6VCMwAxKpQ5v2GVAVUZbn+bW3fkWMrtSfx9kuRu3XMDaZ92
 s5NfXcJX9lMjUcmKEj4DRN/V29TD8Ttn3nQUs/o7SlIeeRDxdKNjdgydOmIhyX7jOeVw
 i3G0VFA6rMjtBa50l7OxsjT0Ct3yMUau3Lkpvx0sRfEo8eb07gtjMfXXc+BW8n5DnX+3
 5PQ9xzbEN8oDGTs8iKUmmAHaQW3ZH6OCOnQ0k9TxH1kuKXfEv+YZvWPIOJAWNY9QwAFU
 WBgZqL4c1e+dvwj41SkHFg49Jd/1G8W1d3q5KI9Pr/7gGn1UjzR30xrE18sq0//fEOzT
 uthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=MIVPt6AfB7Si2oRFoeO2RPXJ/HSxWbOijJs6IvacXC4=;
 b=V3y5EFQ0WB4mqpuf8TmuNizxFcjYx/qD6sj7X7UfXnml8aKZU1JADoYLFPt0BKIxJg
 /p2bM8ftJ3eI9b0lVfld1ue/tO3h2SwZybwG7r2cwsjy/Cxzr0UFgdsY/pgJj51ah72p
 Pavi3uVZwoNFE9WcoiP/9erHMgr+ISH0XkC2gras5cnuK985HjM1QILy0qt4Muqd4m3W
 hI9rlYJPSafqcMOXzaLBzW6NLbSlfTmMyE5poEbOPiKRvnR9XgmrXrnBxr3AjliMtAjC
 BXSiwxosOEWhHyUgrClcYTtYqMrYbV8KsS6ydig8dJ736AH/WM0cRNF3lKx07LKxasV4
 gC/Q==
X-Gm-Message-State: APjAAAVHmMkS8mh4hAZ3EBTLHK3J92x9mDVzQ/tTshhsht19c4TC8Pes
 WEOZVil4RRw6M1edloHEzXBE5NY8
X-Google-Smtp-Source: APXvYqze5kc9ykXYM8BnoZ3clWESdXoRjAOe6WhscklrehcuAJ78m2JToo+E0pbKDefkz1n+urrw/w==
X-Received: by 2002:a7b:cc98:: with SMTP id p24mr4384055wma.139.1579787388489; 
 Thu, 23 Jan 2020 05:49:48 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 48/59] object: return self in object_ref()
Date: Thu, 23 Jan 2020 14:48:51 +0100
Message-Id: <1579787342-27146-49-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
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

This allow for simpler assignment with ref: foo = object_ref(bar)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200110153039.1379601-19-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 3 ++-
 qom/object.c         | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index ead9129..933e5c6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1013,8 +1013,9 @@ GSList *object_class_get_list_sorted(const char *implements_type,
  *
  * Increase the reference count of a object.  A object cannot be freed as long
  * as its reference count is greater than zero.
+ * Returns: @obj
  */
-void object_ref(Object *obj);
+Object *object_ref(Object *obj);
 
 /**
  * object_unref:
diff --git a/qom/object.c b/qom/object.c
index 84d234d..b774507 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1107,12 +1107,13 @@ GSList *object_class_get_list_sorted(const char *implements_type,
                         object_class_cmp);
 }
 
-void object_ref(Object *obj)
+Object *object_ref(Object *obj)
 {
     if (!obj) {
-        return;
+        return NULL;
     }
     atomic_inc(&obj->ref);
+    return obj;
 }
 
 void object_unref(Object *obj)
-- 
1.8.3.1



