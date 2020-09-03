Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DB8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:04:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64CEC20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sak+nULS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CEC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtbD-0006yL-GQ
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYj-0003X6-8H
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33014
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYg-0007Pu-NJ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+yYChecXXfVTCuX6u0USpK6l7VFOUYL7LdClOPgVsEU=;
 b=Sak+nULSfH28TEulgm6qb9KM3Xdu7zD6sjIbxi5U7wSj8pA4QCwlMt0gY4hGya38Fjusfh
 V4S/3wft+GiObBJq2PX5MUplHuJYkPJiOtOozhyRPFywAvA3xy/izDl80z1GN1xLl3GyT+
 96eArdjaRvSQ6jWps4qluo0KOPBq95s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-OIJkdQD-P428NRdus78pRQ-1; Thu, 03 Sep 2020 14:01:57 -0400
X-MC-Unique: OIJkdQD-P428NRdus78pRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B58E1185A0C0;
 Thu,  3 Sep 2020 18:01:56 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8080D1002D46;
 Thu,  3 Sep 2020 18:01:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 3/8] i8259: Rename TYPE_I8259 to TYPE_ISA_I8259
Date: Thu,  3 Sep 2020 14:01:23 -0400
Message-Id: <20200903180128.1523959-4-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:28:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with QOM
type name string ("isa-i8259").

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Suggested-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 ->v2:
* v1 subject was "i8259: Rename TYPE_I8259 to TYPE_PIC"
* Rename it to TYPE_ISA_I8259 instead, to be consistent
  with the QOM type name ("isa-i8259")
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/intc/i8259.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
index 344fd04db1..ab55163340 100644
--- a/hw/intc/i8259.c
+++ b/hw/intc/i8259.c
@@ -37,10 +37,10 @@
 
 //#define DEBUG_IRQ_LATENCY
 
-#define TYPE_I8259 "isa-i8259"
+#define TYPE_ISA_I8259 "isa-i8259"
 typedef struct PICClass PICClass;
 DECLARE_CLASS_CHECKERS(PICClass, PIC,
-                       TYPE_I8259)
+                       TYPE_ISA_I8259)
 
 /**
  * PICClass:
@@ -418,7 +418,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
 
     irq_set = g_new0(qemu_irq, ISA_NUM_IRQS);
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, true);
+    isadev = i8259_init_chip(TYPE_ISA_I8259, bus, true);
     dev = DEVICE(isadev);
 
     qdev_connect_gpio_out(dev, 0, parent_irq);
@@ -428,7 +428,7 @@ qemu_irq *i8259_init(ISABus *bus, qemu_irq parent_irq)
 
     isa_pic = dev;
 
-    isadev = i8259_init_chip(TYPE_I8259, bus, false);
+    isadev = i8259_init_chip(TYPE_ISA_I8259, bus, false);
     dev = DEVICE(isadev);
 
     qdev_connect_gpio_out(dev, 0, irq_set[2]);
@@ -451,7 +451,7 @@ static void i8259_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo i8259_info = {
-    .name       = TYPE_I8259,
+    .name       = TYPE_ISA_I8259,
     .instance_size = sizeof(PICCommonState),
     .parent     = TYPE_PIC_COMMON,
     .class_init = i8259_class_init,
-- 
2.26.2


