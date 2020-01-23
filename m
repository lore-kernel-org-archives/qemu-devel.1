Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C16C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:44:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BD4721734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q8lXCI+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BD4721734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuefC-0001EC-E2
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:44:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51862)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrk-0005XJ-NJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrj-0004Q8-FI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:48 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:44801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrj-0004NB-8Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:47 -0500
Received: by mail-wr1-x434.google.com with SMTP id q10so3118222wrm.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=awVtpnL9oZaP3rpg/kqMTiM2s2IPaZQzWstJTlLEN4g=;
 b=q8lXCI+PV7XGMvxyjCGHQEWtkcrtPuyTvJ0oA0xRTITdag3oNGNusZ/J++znp3zYcW
 y/9p2YeJ2EJa7cJN2oZg5op/mukYrfRZigFy9aDggCNNzoqyN6Zbw2Ig5QQzm2a6cWtD
 9przIj+vene6hs+CxTFoMauNFMFVZp2S1tiVolk18SKYJO6rYFVajcVaGECsOE4M3k11
 Hx1HwUZeOAStfjv6dQQdGXGQpmTXv0RwFmjQd8/roPfpGBRA2BGex38hcYt1lvztghAt
 EbIzUubiJ+Vc5+flmtn9RtDrgXal1F95KB9IjK+4vER4xKpwGY7hePwMP7NOfzNL+l4h
 VRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=awVtpnL9oZaP3rpg/kqMTiM2s2IPaZQzWstJTlLEN4g=;
 b=DI+SCZG/ESUcEzQB7dSHxjPmcTxTmg5fF3ChPug7doRdZrh0qOQU15PjXa1uI/30dz
 BqM6qjaxY8L1rLG+YUGvPwy0CcqY4uQAqYtESy2lFVaf7wm8/Bpplgf61eQvSrr9F4P6
 OLPspa07qdeIeUUs3VEhTLe20r+59W7AIVLmBRjUDOzkqoKLFd7d1/n8d2KX1TLHYWK2
 GQ+/6LB6YSirKHXUzxPQky0ohcc4tZ9znbD0eOEub/RSly9VzYRImrcx6jTT/P78Y37X
 ti4mKWK+Shp+aMc4FpGnxI1tii9S+Aqs1nGDlT+uy3anKInWKPJQBcd1tz2zeRs/LtF2
 RuKw==
X-Gm-Message-State: APjAAAVgg6jEqWajnq1DSk+l8Sg9KOva7IZp+FohXynSENqu1ASPLALq
 wDTiwjh8sblo7rw28rNh5MczihAi
X-Google-Smtp-Source: APXvYqzve2MTsqCnFxlxICNo/jk4iat5ibpG962voyuGw8AoueHQO24WyGKUfUpfAhWenVbKFWyuVQ==
X-Received: by 2002:adf:f581:: with SMTP id f1mr17817310wro.264.1579787386138; 
 Thu, 23 Jan 2020 05:49:46 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 45/59] object: express const link with link property
Date: Thu, 23 Jan 2020 14:48:48 +0100
Message-Id: <1579787342-27146-46-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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

Let's not mix child property and link property callbacks, as this is
confusing, use LinkProperty with DIRECT flag to hold the target pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-16-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index dff16da..e6617c2 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1860,19 +1860,23 @@ static void object_release_link_property(Object *obj, const char *name,
     g_free(prop);
 }
 
-void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **targetp,
-                              void (*check)(const Object *, const char *,
-                                            Object *, Error **),
-                              ObjectPropertyLinkFlags flags,
-                              Error **errp)
+static void object_add_link_prop(Object *obj, const char *name,
+                                 const char *type, void *ptr,
+                                 void (*check)(const Object *, const char *,
+                                               Object *, Error **),
+                                 ObjectPropertyLinkFlags flags,
+                                 Error **errp)
 {
     Error *local_err = NULL;
     LinkProperty *prop = g_malloc(sizeof(*prop));
     gchar *full_type;
     ObjectProperty *op;
 
-    prop->targetp = targetp;
+    if (flags & OBJ_PROP_LINK_DIRECT) {
+        prop->target = ptr;
+    } else {
+        prop->targetp = ptr;
+    }
     prop->check = check;
     prop->flags = flags;
 
@@ -1896,20 +1900,21 @@ out:
     g_free(full_type);
 }
 
+void object_property_add_link(Object *obj, const char *name,
+                              const char *type, Object **targetp,
+                              void (*check)(const Object *, const char *,
+                                            Object *, Error **),
+                              ObjectPropertyLinkFlags flags,
+                              Error **errp)
+{
+    object_add_link_prop(obj, name, type, targetp, check, flags, errp);
+}
+
 void object_property_add_const_link(Object *obj, const char *name,
                                     Object *target, Error **errp)
 {
-    char *link_type;
-    ObjectProperty *op;
-
-    link_type = g_strdup_printf("link<%s>", object_get_typename(target));
-    op = object_property_add(obj, name, link_type,
-                             object_get_child_property, NULL,
-                             NULL, target, errp);
-    if (op != NULL) {
-        op->resolve = object_resolve_child_property;
-    }
-    g_free(link_type);
+    object_add_link_prop(obj, name, object_get_typename(target), target,
+                         NULL, OBJ_PROP_LINK_DIRECT, errp);
 }
 
 gchar *object_get_canonical_path_component(Object *obj)
-- 
1.8.3.1



