Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F68C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEDD20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZP3GkgS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEDD20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbeP-0007Q4-Uw
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUe-0003Pj-Jr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32915
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUc-0008Q7-Tr
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JU9/znqWg2TUYNPH2icBhlpG7DUAJjHZQMnhpf3zXFo=;
 b=ZP3GkgS2ln/1AW+nVdBpgnbwCctzmt3+jqHdKkR/I1gzEaHliyBJ7/9HDPBBvFONRmHjg5
 8Mf2Xwx8OI8JdsQMz5RuiOw+i3wskhbol82k9LedU/5BjPeAvkwJSvRRS9QJ7Gn4qpM+dc
 sm/s9k2M1XO9uinLCyXP3dKXWvJcHlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-VYNSAfAzPayqH8SBh91ByQ-1; Wed, 02 Sep 2020 18:44:36 -0400
X-MC-Unique: VYNSAfAzPayqH8SBh91ByQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28BF48030C7;
 Wed,  2 Sep 2020 22:44:35 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E17DA19C59;
 Wed,  2 Sep 2020 22:44:34 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 27/63] sun4u: Rename TYPE_SUN4U_MEMORY to TYPE_SUN4U_RAM
Date: Wed,  2 Sep 2020 18:42:35 -0400
Message-Id: <20200902224311.1321159-28-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, berrange@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org
---
 hw/sparc64/sun4u.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 67985414e2..fe0d84bf6c 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -493,10 +493,10 @@ static const TypeInfo prom_info = {
 };
 
 
-#define TYPE_SUN4U_MEMORY "memory"
+#define TYPE_SUN4U_RAM "memory"
 typedef struct RamDevice RamDevice;
 DECLARE_INSTANCE_CHECKER(RamDevice, SUN4U_RAM,
-                         TYPE_SUN4U_MEMORY)
+                         TYPE_SUN4U_RAM)
 
 struct RamDevice {
     SysBusDevice parent_obj;
@@ -524,7 +524,7 @@ static void ram_init(hwaddr addr, ram_addr_t RAM_size)
     RamDevice *d;
 
     /* allocate RAM */
-    dev = qdev_new(TYPE_SUN4U_MEMORY);
+    dev = qdev_new(TYPE_SUN4U_RAM);
     s = SYS_BUS_DEVICE(dev);
 
     d = SUN4U_RAM(dev);
@@ -548,7 +548,7 @@ static void ram_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo ram_info = {
-    .name          = TYPE_SUN4U_MEMORY,
+    .name          = TYPE_SUN4U_RAM,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(RamDevice),
     .class_init    = ram_class_init,
-- 
2.26.2


