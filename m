Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0006C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BE6C20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 18:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fb1hf9vI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BE6C20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDtZU-0004Zf-NS
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 14:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYS-0003Jo-7u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27694
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDtYQ-0007OZ-Cc
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 14:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599156105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QfSa/Pu+cYufPXc3u6jsH7mhzEHWboKSUmufz2Fy7lA=;
 b=fb1hf9vISPQvXEthiX33ey7IG6n/RSUDMOLBlMZRjud3voTqAsKbAUbh9u8FEOM0iQBnCM
 4APusNAqQtmRmg5ozfEjIjZDB/JJ/RqvRs/aWoREzVkrQLJOPh2cR16V6jyWoA5JUgcrXx
 nwY99h61fEIlwLFytcgqVTVlOoibF/E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-0Efk-prYMquaiRy53j6W5w-1; Thu, 03 Sep 2020 14:01:43 -0400
X-MC-Unique: 0Efk-prYMquaiRy53j6W5w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EC271075140;
 Thu,  3 Sep 2020 18:01:42 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DD1E7EECD;
 Thu,  3 Sep 2020 18:01:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	"Daniel P. Berrange" <berrange@redhat.com>
Subject: [PATCH 1/8] i8254: Rename TYPE_I8254 to TYPE_ISA_PIT
Date: Thu,  3 Sep 2020 14:01:21 -0400
Message-Id: <20200903180128.1523959-2-ehabkost@redhat.com>
In-Reply-To: <20200903180128.1523959-1-ehabkost@redhat.com>
References: <20200903180128.1523959-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the QOM type ("isa-pit").

Suggested-by:  "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* v1 subject was: "i8254: Rename TYPE_I8254 to TYPE_PIT"
* Rename it to TYPE_ISA_PIT instead of TYPE_PIT,
  to be consistent with the existing "isa-pit" type
  name
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 include/hw/timer/i8254.h | 4 ++--
 hw/timer/i8254.c         | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/i8254.h b/include/hw/timer/i8254.h
index 1a522a2457..b21e67c124 100644
--- a/include/hw/timer/i8254.h
+++ b/include/hw/timer/i8254.h
@@ -45,7 +45,7 @@ typedef struct PITCommonClass PITCommonClass;
 DECLARE_OBJ_CHECKERS(PITCommonState, PITCommonClass,
                      PIT_COMMON, TYPE_PIT_COMMON)
 
-#define TYPE_I8254 "isa-pit"
+#define TYPE_ISA_PIT "isa-pit"
 #define TYPE_KVM_I8254 "kvm-pit"
 
 static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
@@ -54,7 +54,7 @@ static inline ISADevice *i8254_pit_init(ISABus *bus, int base, int isa_irq,
     DeviceState *dev;
     ISADevice *d;
 
-    d = isa_new(TYPE_I8254);
+    d = isa_new(TYPE_ISA_PIT);
     dev = DEVICE(d);
     qdev_prop_set_uint32(dev, "iobase", base);
     isa_realize_and_unref(d, bus, &error_fatal);
diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index c01ee2c72a..5666bcb4ef 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -39,7 +39,7 @@
 
 typedef struct PITClass PITClass;
 DECLARE_CLASS_CHECKERS(PITClass, PIT,
-                       TYPE_I8254)
+                       TYPE_ISA_PIT)
 
 struct PITClass {
     PITCommonClass parent_class;
@@ -370,7 +370,7 @@ static void pit_class_initfn(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo pit_info = {
-    .name          = TYPE_I8254,
+    .name          = TYPE_ISA_PIT,
     .parent        = TYPE_PIT_COMMON,
     .instance_size = sizeof(PITCommonState),
     .class_init    = pit_class_initfn,
-- 
2.26.2


