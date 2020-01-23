Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:47:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420621734
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvqam1BT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420621734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuehW-0004Ic-4Q
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrl-0005ZT-Vk
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrk-0004SN-Ua
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:49 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:40809)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucrk-0004Qs-O5
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:48 -0500
Received: by mail-wm1-x329.google.com with SMTP id t14so2595748wmi.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6W21RtF4MhsJPffhnX5gfH1aakhUYnRTEcxuzNxGkrI=;
 b=Bvqam1BTeYAY8Q9IFxflI6GOooT7M8E4BXoPA6YiaS2i/bdUjm0fA4VFVMwTvCAt52
 XVkIRVKgsSe/hUGguukjLKuJk4H6wfl+rFBRRaRtVhgXuIYqOxfJkPFYHk6nHIlvgXLl
 XDGJ55R6zaHSIqQpJK1uO5aeLjXtYT0bfMmbPxVCRhbMVZVccl+QRfKhGp4ec1ZYWzsE
 ORh/i7TqtLqPlgZvMKDs0ZEa+0bOrnhD0oqlNA5donLXQxrmb6VPs1oAvmAdX3suf4Hm
 BTL2UmYjlkKSB1JK8725h6thrhK/wQ3N7527AjVjttoutcl/WU2XhSARu1F5eN5MEiRv
 hUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=6W21RtF4MhsJPffhnX5gfH1aakhUYnRTEcxuzNxGkrI=;
 b=LT0f6uOUmV0pibkLXJXJ18R3z8mMWIx89rqGqOtxOfl/5ERAQSFwDjfoT+Vme8GW80
 gZGGs6/1oj1DymY6xgBSoaX/3fMrFB0EfMwPltalPU33xWqB95HIV7GDPlYX51fjtP9I
 MQ8guDLGTCL9sckGcFwCPOUcuzNEt08VX1N8RYsF2QmOYpw42rtcNzBj69Dpn+ejNrvK
 X4A24ul75w6/6IF6pSbrZgHO6c8XuinA9osLyxNvgqP9dcVfLXZ1P1YRGFplMatsmqss
 tRUTBYP+Va4UnA3gEaJrXSVkYCfFC+sFSwaWX2Oex3McwX6Sqdum9pu2zvT9Zjz7E0R9
 H/1A==
X-Gm-Message-State: APjAAAULBq86ieOYJj5ytkLLURiUn4zb+zv2v81CveYZUKlj4Lxdbp2K
 PvVnopU6tshNpr4iNUAszByU7ra0
X-Google-Smtp-Source: APXvYqynm/nCI1LJsNISgpTFGkd7OSMtzbSQRhDwbypMjZ7B5LgP/HpWDXTPDk+3id5qJOoYvE7O4g==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4284529wmd.23.1579787387607;
 Thu, 23 Jan 2020 05:49:47 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 47/59] object: release all props
Date: Thu, 23 Jan 2020 14:48:50 +0100
Message-Id: <1579787342-27146-48-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

Class properties may have to release resources when the object is
destroyed. Let's use the existing release() callback for that, but
class properties must not release ObjectProperty, as it can be shared
by various instances.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-18-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 202d576..84d234d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -592,23 +592,22 @@ static inline bool object_property_is_child(ObjectProperty *prop)
 
 static void object_property_del_all(Object *obj)
 {
+    g_autoptr(GHashTable) done = g_hash_table_new(NULL, NULL);
     ObjectProperty *prop;
-    GHashTableIter iter;
-    gpointer key, value;
+    ObjectPropertyIterator iter;
     bool released;
 
     do {
         released = false;
-        g_hash_table_iter_init(&iter, obj->properties);
-        while (g_hash_table_iter_next(&iter, &key, &value)) {
-            prop = value;
-            if (prop->release) {
-                prop->release(obj, prop->name, prop->opaque);
-                prop->release = NULL;
-                released = true;
-                break;
+        object_property_iter_init(&iter, obj);
+        while ((prop = object_property_iter_next(&iter)) != NULL) {
+            if (g_hash_table_add(done, prop)) {
+                if (prop->release) {
+                    prop->release(obj, prop->name, prop->opaque);
+                    released = true;
+                    break;
+                }
             }
-            g_hash_table_iter_remove(&iter);
         }
     } while (released);
 
-- 
1.8.3.1



