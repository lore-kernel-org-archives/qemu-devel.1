Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 888D9C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EF21208FE
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIRRHqjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF21208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjzU-0006ui-9t
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 16:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjof-0001cJ-UO
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kFjoe-0004Od-3m
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 16:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599595327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oszayQ0VGZ94gc4rNIdB3VO4jFeqqjzbkxRkmz3dAZs=;
 b=SIRRHqjP8kTsxunb6Slz7ZJSoNEm+RVkcsQPu/c2AFI50eLzTCUYejTYCPjJlD0+DdUif4
 rTDLhdz6hbANDSP3LVgRsbuAE6FZjRDCBLFVPKmnjCCnFrk6/JVPhNMhEe9YT5RlrWST4d
 /L/laNGLCS3ktHz1KEZkqPsF4Vn68F0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-sDtA0RHVM265C0T6-BD-Og-1; Tue, 08 Sep 2020 16:02:04 -0400
X-MC-Unique: sDtA0RHVM265C0T6-BD-Og-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B654C801A9D;
 Tue,  8 Sep 2020 20:02:03 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82DB882470;
 Tue,  8 Sep 2020 20:02:03 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 28/34] tusb6010: Rename TUSB to TUSB6010
Date: Tue,  8 Sep 2020 16:01:17 -0400
Message-Id: <20200908200123.3402311-29-ehabkost@redhat.com>
In-Reply-To: <20200908200123.3402311-1-ehabkost@redhat.com>
References: <20200908200123.3402311-1-ehabkost@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make type checking function name consistent with the TYPE_TUSB6010
constant and QOM type name ("tusb6010").

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200903180128.1523959-9-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/usb/tusb6010.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/usb/tusb6010.c b/hw/usb/tusb6010.c
index 2bee3ae59f..dd20996d13 100644
--- a/hw/usb/tusb6010.c
+++ b/hw/usb/tusb6010.c
@@ -32,7 +32,7 @@
 
 #define TYPE_TUSB6010 "tusb6010"
 typedef struct TUSBState TUSBState;
-DECLARE_INSTANCE_CHECKER(TUSBState, TUSB,
+DECLARE_INSTANCE_CHECKER(TUSBState, TUSB6010,
                          TYPE_TUSB6010)
 
 struct TUSBState {
@@ -779,7 +779,7 @@ static void tusb6010_irq(void *opaque, int source, int level)
 
 static void tusb6010_reset(DeviceState *dev)
 {
-    TUSBState *s = TUSB(dev);
+    TUSBState *s = TUSB6010(dev);
     int i;
 
     s->test_reset = TUSB_PROD_TEST_RESET_VAL;
@@ -815,7 +815,7 @@ static void tusb6010_reset(DeviceState *dev)
 
 static void tusb6010_realize(DeviceState *dev, Error **errp)
 {
-    TUSBState *s = TUSB(dev);
+    TUSBState *s = TUSB6010(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
     s->otg_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, tusb_otg_tick, s);
-- 
2.26.2


