Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:36:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E88ED20684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwN2Pb4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88ED20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueX2-0006CM-NL
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrc-0005KV-4m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iucrb-00044m-00
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:39 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:36380)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iucra-00042j-QI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:49:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id z3so3162078wru.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DKAk75UkCwuPlyN5K83IjxSwbXLW3UXbzJBFox5GXjM=;
 b=bwN2Pb4aKherd8cZVUeShzKQgdOZLj3/lQKOidaGEdjYS2Ne4WnqPTi/vU5lJoZWlI
 x0c8OVPM6p+bKKHcMgUa8EhQAkIgeK5hSTY3wXdQ5KOwa4jRQq7qGYYuehEk6IUlLA21
 Myf8NYrZVV5KHGCcBBJCdOHDfwnhlDaQW0PcZ2RPBvs4oARyuU14IF4Gn6xXWYQdWQcp
 t+DWWzDNVPX1YYrNFBpN67yAGYMg8SbLAJzBkbJl7a9ylg917NZakhdy1kxPNQkHh4x6
 iSQPzHiDC5xMBStt0LLbGBf27I2kz3spT8MEJqRlTg0WznHsSfEdPiLzjoXKlzB6w0RR
 0UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DKAk75UkCwuPlyN5K83IjxSwbXLW3UXbzJBFox5GXjM=;
 b=aSTbYpcbGZiuaJyNkpkw2a2Cek2qXQal764OjdCWzrOD7hzu1o8E+XFiOdNXjVTqCB
 bVGr2zUtyoTM6DVZgzrD3PUfKKj9s1Vso3A0q3rkJBjpkk10qIEmjHCCjn19WJtStYzK
 ZHE7d9rieVt4tOCDgLZaKle8aHDTvX4Ro7i27OdWqqr4GfYunkeKNuzJ/aOjYhbZbu4u
 HMioFNXv+DHR2TJwaKnad0ECKPpJct6iM+VOxqrRcw0Wauod/ygu9OfM5i+iKU95/NOa
 aclbbpr1rd3zipNKODLFrfxgUQVwRIAcJNY84BcQk8jNjX3nXsUVitGur0AyKrJ2gR0l
 4Q5g==
X-Gm-Message-State: APjAAAXhjYGm/0vbYcCrmUcrZswXbnd1JBgp/wAVcKbncLo5/Jqttc7j
 KyPToGOEbsrtPZzL9tzHKyeQI4js
X-Google-Smtp-Source: APXvYqzixxqyeY1Omgo9V2GyCeO1+ilKjr1ZAqg29pzqQd5Fj9FAnxeWZrlEbwurxYM1CHKcJUqr/A==
X-Received: by 2002:a5d:44ca:: with SMTP id z10mr17817602wrr.266.1579787377731; 
 Thu, 23 Jan 2020 05:49:37 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id s15sm3073171wrp.4.2020.01.23.05.49.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 23 Jan 2020 05:49:37 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 35/59] object: avoid extra class property key duplication
Date: Thu, 23 Jan 2020 14:48:38 +0100
Message-Id: <1579787342-27146-36-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
References: <1579787342-27146-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Like object properties, no need to duplicate property name, as it is
owned already by ObjectProperty value.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20200110153039.1379601-6-marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qom/object.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index dcb6863..e921363 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -311,7 +311,7 @@ static void type_initialize(TypeImpl *ti)
         memcpy(ti->class, parent->class, parent->class_size);
         ti->class->interfaces = NULL;
         ti->class->properties = g_hash_table_new_full(
-            g_str_hash, g_str_equal, g_free, object_property_free);
+            g_str_hash, g_str_equal, NULL, object_property_free);
 
         for (e = parent->class->interfaces; e; e = e->next) {
             InterfaceClass *iface = e->data;
@@ -343,7 +343,7 @@ static void type_initialize(TypeImpl *ti)
         }
     } else {
         ti->class->properties = g_hash_table_new_full(
-            g_str_hash, g_str_equal, g_free, object_property_free);
+            g_str_hash, g_str_equal, NULL, object_property_free);
     }
 
     ti->class->type = ti;
@@ -1187,7 +1187,7 @@ object_class_property_add(ObjectClass *klass,
     prop->release = release;
     prop->opaque = opaque;
 
-    g_hash_table_insert(klass->properties, g_strdup(name), prop);
+    g_hash_table_insert(klass->properties, prop->name, prop);
 
     return prop;
 }
-- 
1.8.3.1



