Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF7C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1532C20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcRHtXSV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1532C20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbao-0006xa-5D
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU6-0001xM-5B
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43789
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbU4-0008KY-GQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q/zWs0Iqm8qjm2AQU+5h59ogQtgv2ldaJ5Kj+razBv4=;
 b=UcRHtXSVXVs7KZ4rqGU6R6ItuMLJyg5YhAD/hAoM5MG8MrkzxX+WpXEgF9X5Q/jDba2ThS
 IVDAi5FIGh17upAf/Dc2Lx5UVIWeAydfPO8VAoTw6TGsYKUDNe7UC9HPq6aRA6qPGqr92h
 O0kEwnAlAn6YfOrKXr8SYYkZN20SQiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-BXNQflOLNWK1WMdxemvPAg-1; Wed, 02 Sep 2020 18:44:02 -0400
X-MC-Unique: BXNQflOLNWK1WMdxemvPAg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C2C38030C7;
 Wed,  2 Sep 2020 22:44:01 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31DC27E670;
 Wed,  2 Sep 2020 22:43:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/63] etrax: Rename TYPE_ETRAX_FS_SERIAL to TYPE_ETRAX_SERIAL
Date: Wed,  2 Sep 2020 18:42:20 -0400
Message-Id: <20200902224311.1321159-13-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:07
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/char/etraxfs_ser.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/char/etraxfs_ser.c b/hw/char/etraxfs_ser.c
index d9fba2ae6c..6bfc6d376d 100644
--- a/hw/char/etraxfs_ser.c
+++ b/hw/char/etraxfs_ser.c
@@ -49,10 +49,10 @@
 #define STAT_TR_IDLE 22
 #define STAT_TR_RDY  24
 
-#define TYPE_ETRAX_FS_SERIAL "etraxfs,serial"
+#define TYPE_ETRAX_SERIAL "etraxfs,serial"
 typedef struct ETRAXSerial ETRAXSerial;
 DECLARE_INSTANCE_CHECKER(ETRAXSerial, ETRAX_SERIAL,
-                         TYPE_ETRAX_FS_SERIAL)
+                         TYPE_ETRAX_SERIAL)
 
 struct ETRAXSerial {
     SysBusDevice parent_obj;
@@ -251,7 +251,7 @@ static void etraxfs_ser_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo etraxfs_ser_info = {
-    .name          = TYPE_ETRAX_FS_SERIAL,
+    .name          = TYPE_ETRAX_SERIAL,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ETRAXSerial),
     .instance_init = etraxfs_ser_init,
-- 
2.26.2


