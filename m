Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857F2C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576AB207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MPcj5mPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576AB207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNty-00070K-Jl
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNUH-00007a-T8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:23:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38502
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNUG-0000XD-6L
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LH39dE9a5vM+1JuAteqvtu0Avzivktg7pVUG8JDWclI=;
 b=MPcj5mPjVOJeXb1vBVgCnOxGUB07ERaRlUPeYB2pjEGrUnU063lxJnG0kS6of2Wf8EFyuk
 b9Pors4B+P5fbH3jwTNljqLbRB96J4W/OkWjFQ2O/AD2mx8B37hnXIblTRyNl5MdhrcwzM
 rzqKWd/vgb6D7XCG0ejcFShhaty1Xxc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-2NEPvkS_M1O6Bx31J0yA0Q-1; Thu, 27 Aug 2020 15:22:59 -0400
X-MC-Unique: 2NEPvkS_M1O6Bx31J0yA0Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6D9C81CBDF;
 Thu, 27 Aug 2020 19:22:57 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19CA17959E;
 Thu, 27 Aug 2020 19:22:57 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 42/53] nubus: Rename class type checking macros
Date: Thu, 27 Aug 2020 15:21:11 -0400
Message-Id: <20200827192122.658035-43-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:56:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the existing class type checking macros to be consistent
with the type name and instance type checking macro.  Use a
NUBUS_MACFB prefix instead of MACFB_NUBUS.

This will make future conversion to OBJECT_DECLARE* easier.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-44-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/display/macfb.h | 4 ++--
 hw/display/macfb.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/display/macfb.h b/include/hw/display/macfb.h
index 26367ae2c4..347871b623 100644
--- a/include/hw/display/macfb.h
+++ b/include/hw/display/macfb.h
@@ -40,9 +40,9 @@ typedef struct {
     MacfbState macfb;
 } MacfbSysBusState;
 
-#define MACFB_NUBUS_DEVICE_CLASS(class) \
+#define NUBUS_MACFB_CLASS(class) \
     OBJECT_CLASS_CHECK(MacfbNubusDeviceClass, (class), TYPE_NUBUS_MACFB)
-#define MACFB_NUBUS_GET_CLASS(obj) \
+#define NUBUS_MACFB_GET_CLASS(obj) \
     OBJECT_GET_CLASS(MacfbNubusDeviceClass, (obj), TYPE_NUBUS_MACFB)
 
 typedef struct MacfbNubusDeviceClass {
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index b68faff4bb..ff8bdb846b 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -391,7 +391,7 @@ static void macfb_nubus_realize(DeviceState *dev, Error **errp)
 {
     NubusDevice *nd = NUBUS_DEVICE(dev);
     MacfbNubusState *s = NUBUS_MACFB(dev);
-    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_GET_CLASS(dev);
+    MacfbNubusDeviceClass *ndc = NUBUS_MACFB_GET_CLASS(dev);
     MacfbState *ms = &s->macfb;
 
     ndc->parent_realize(dev, errp);
@@ -443,7 +443,7 @@ static void macfb_sysbus_class_init(ObjectClass *klass, void *data)
 static void macfb_nubus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
-    MacfbNubusDeviceClass *ndc = MACFB_NUBUS_DEVICE_CLASS(klass);
+    MacfbNubusDeviceClass *ndc = NUBUS_MACFB_CLASS(klass);
 
     device_class_set_parent_realize(dc, macfb_nubus_realize,
                                     &ndc->parent_realize);
-- 
2.26.2


