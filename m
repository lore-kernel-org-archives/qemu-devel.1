Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CDED21734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 16:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md/tOE2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CDED21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iufLu-0006mo-7X
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 11:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrj-0005W9-UO
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucri-0004NM-OG
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:33988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucri-0004LP-HF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:46 -0500
Received: by mail-wr1-x436.google.com with SMTP id t2so3186079wrr.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NKQefvh4U78BlEUri4dbdA4PBZUpYRKEAzo+PNIiyOU=;
 b=Md/tOE2YZwQVkSXXYiFxlNyLgzOaGdqxmNMXqPSwP9HdoPEODuHnolNbIutFLGmDQh
 IyeSIUVHEeGUOiy1GVmfEU5cdztZtPSmGFs4+pE50ybum3q54Cd7zKF4ROkFqS4ia5/l
 YaQqyD6XweqP7TJTor63jOc/iI9J3XqA2bJEhkfdVWk6iaZItBxuXeqqCXdw9ttR5cbn
 6qY6ypxw6HpVYGNScu+xTK5lxGxoPm2MSlbpRIdsDrd55QfMj6Bs57NoZuoN4czMaqER
 77+JC5ODZdSYfV9w7wNXN6t/018rPfO/9CpbQDKumjbFabt7mGoU4uAFCgIItQay/Zzi
 hoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=NKQefvh4U78BlEUri4dbdA4PBZUpYRKEAzo+PNIiyOU=;
 b=uMwH2j7z64LI9t10QbRXuHO4ugjCWX75sKrT1nAhmmuVyjU3gjuvPvi+Bg21lMiwVd
 PYHQuoBpRfM9+GFxFB8Q9R8tmQMV70czoIOEsat1bFL5LrK2MNI4bhlrzLPlzjNxuKxN
 AGu4q6+j5hSU1LfY6I1uy12vw2ezEmwQVKxjuovGbD0dqd3wzSkspNxiRlYScj5CB0oA
 B0wno2jsP6+hAQwwwEuttjvyL5OrU2ssnm8KuQYba2rJq8W0CyFmrPc40+TcrR4m4ThX
 LKv0tqJHHUPCtPop/CF7UIGsYS/MN1gadr9Ef+hTblYRT0HbDfOXXnWlHPKwFyOznnoL
 jBEg==
X-Gm-Message-State: APjAAAXiCjgjN3iOsZeZJmqQq1mjZ6HluS6DQhEKWaYQd0msGzRocpbB
 eArk/HxuUXF6+snCw9MGeR6MZh2d
X-Google-Smtp-Source: APXvYqzk3N9W9Mna8U59ycNM+RLUi6njsjsa84+7ywowBwA3I49csIISfYGZ+wCvb2PkWaUCEHhNyQ==
X-Received: by 2002:adf:e692:: with SMTP id r18mr17886336wrm.413.1579787385277; 
 Thu, 23 Jan 2020 05:49:45 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.44
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/59] object: add direct link flag
Date: Thu, 23 Jan 2020 14:48:47 +0100
Message-Id: <1579787342-27146-45-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

Allow the link property to hold the pointer to the target, instead of
indirectly through another variable.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-15-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h |  3 +++
 qom/object.c         | 26 ++++++++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 7e66bc7..5b02be6 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1528,6 +1528,9 @@ void object_property_add_child(Object *obj, const char *name,
 typedef enum {
     /* Unref the link pointer when the property is deleted */
     OBJ_PROP_LINK_STRONG = 0x1,
+
+    /* private */
+    OBJ_PROP_LINK_DIRECT = 0x2,
 } ObjectPropertyLinkFlags;
 
 /**
diff --git a/qom/object.c b/qom/object.c
index ced5e0b..dff16da 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1729,17 +1729,30 @@ void object_property_allow_set_link(const Object *obj, const char *name,
 }
 
 typedef struct {
-    Object **targetp;
+    union {
+        Object **targetp;
+        Object *target; /* if OBJ_PROP_LINK_DIRECT, when holding the pointer  */
+    };
     void (*check)(const Object *, const char *, Object *, Error **);
     ObjectPropertyLinkFlags flags;
 } LinkProperty;
 
+static Object **
+object_link_get_targetp(Object *obj, LinkProperty *lprop)
+{
+    if (lprop->flags & OBJ_PROP_LINK_DIRECT) {
+        return &lprop->target;
+    } else {
+        return lprop->targetp;
+    }
+}
+
 static void object_get_link_property(Object *obj, Visitor *v,
                                      const char *name, void *opaque,
                                      Error **errp)
 {
     LinkProperty *lprop = opaque;
-    Object **targetp = lprop->targetp;
+    Object **targetp = object_link_get_targetp(obj, lprop);
     gchar *path;
 
     if (*targetp) {
@@ -1798,7 +1811,7 @@ static void object_set_link_property(Object *obj, Visitor *v,
 {
     Error *local_err = NULL;
     LinkProperty *prop = opaque;
-    Object **targetp = prop->targetp;
+    Object **targetp = object_link_get_targetp(obj, prop);
     Object *old_target = *targetp;
     Object *new_target = NULL;
     char *path = NULL;
@@ -1832,16 +1845,17 @@ static Object *object_resolve_link_property(Object *parent, void *opaque, const
 {
     LinkProperty *lprop = opaque;
 
-    return *lprop->targetp;
+    return *object_link_get_targetp(parent, lprop);
 }
 
 static void object_release_link_property(Object *obj, const char *name,
                                          void *opaque)
 {
     LinkProperty *prop = opaque;
+    Object **targetp = object_link_get_targetp(obj, prop);
 
-    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *prop->targetp) {
-        object_unref(*prop->targetp);
+    if ((prop->flags & OBJ_PROP_LINK_STRONG) && *targetp) {
+        object_unref(*targetp);
     }
     g_free(prop);
 }
-- 
1.8.3.1



