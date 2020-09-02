Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440ADC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A96820767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiR3StZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A96820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbiS-0000Ga-7z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUq-0003hL-FE
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21478
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUo-0008Sd-De
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6ofSfJYUOIijxDXEI+ln7bb/vVelslorwkvaNNaAT8=;
 b=LiR3StZgmoHQzRPVjmQ7VNP9KgvAezBdvXPKpmYc/Yh7c965cnrsITEZFOj2x6UGXjriNp
 9iURdhK3jnd7IQtiqQJ+5V6uotVZ4njz02M6GT0JR5Xq/IXTj53bi8upl4w4D+6gYBPMvv
 cZEqAJEcsciZx/3Sx5D7UuvaT1piiNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-w1iS8sOaO5CJBWjCPVQJ1w-1; Wed, 02 Sep 2020 18:44:48 -0400
X-MC-Unique: w1iS8sOaO5CJBWjCPVQJ1w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 169718030C7;
 Wed,  2 Sep 2020 22:44:47 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DB215D9CC;
 Wed,  2 Sep 2020 22:44:41 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/63] virtio-console: Rename TYPE_VIRTIO_CONSOLE_SERIAL_PORT
 to TYPE_VIRTIO_CONSOLE
Date: Wed,  2 Sep 2020 18:42:39 -0400
Message-Id: <20200902224311.1321159-32-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:25:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, Amit Shah <amit@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/char/virtio-console.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index bc752cf90f..cf4c0a0a95 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -21,10 +21,10 @@
 #include "qapi/qapi-events-char.h"
 #include "qom/object.h"
 
-#define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
+#define TYPE_VIRTIO_CONSOLE "virtserialport"
 typedef struct VirtConsole VirtConsole;
 DECLARE_INSTANCE_CHECKER(VirtConsole, VIRTIO_CONSOLE,
-                         TYPE_VIRTIO_CONSOLE_SERIAL_PORT)
+                         TYPE_VIRTIO_CONSOLE)
 
 struct VirtConsole {
     VirtIOSerialPort parent_obj;
@@ -269,7 +269,7 @@ static void virtconsole_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo virtconsole_info = {
     .name          = "virtconsole",
-    .parent        = TYPE_VIRTIO_CONSOLE_SERIAL_PORT,
+    .parent        = TYPE_VIRTIO_CONSOLE,
     .class_init    = virtconsole_class_init,
 };
 
@@ -293,7 +293,7 @@ static void virtserialport_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo virtserialport_info = {
-    .name          = TYPE_VIRTIO_CONSOLE_SERIAL_PORT,
+    .name          = TYPE_VIRTIO_CONSOLE,
     .parent        = TYPE_VIRTIO_SERIAL_PORT,
     .instance_size = sizeof(VirtConsole),
     .class_init    = virtserialport_class_init,
-- 
2.26.2


