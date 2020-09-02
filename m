Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9135EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56CD120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvnjFbtI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56CD120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbbH-0008FB-GU
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUE-0002JW-9P
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36251
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUC-0008Lp-H2
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ryWhSKZ2kM92ryVugO2eQWgjXmlubJLHGEAJiTuiJII=;
 b=cvnjFbtIyash4nfbCWWn49yf6HtCHRuB5FKY4Ku38kj2KO+zVjh1xi6RkxcsvfAM5MKday
 +9vevH5xOSEsc5PpsFeU9Pkn4I9ccG8VUOSi+glOxM6n9aIWjx/g+2QSD+lBtpEYQ/UF/P
 W6K1Px0bnNchFEO7nWhQ8LDOioTaEDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-dYje3GBnOsOpLPhojzpGHQ-1; Wed, 02 Sep 2020 18:44:09 -0400
X-MC-Unique: dYje3GBnOsOpLPhojzpGHQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFA431DE00;
 Wed,  2 Sep 2020 22:44:08 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 821275D9CC;
 Wed,  2 Sep 2020 22:44:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/63] i8259: Rename TYPE_KVM_I8259 to TYPE_KVM_PIC
Date: Wed,  2 Sep 2020 18:42:24 -0400
Message-Id: <20200902224311.1321159-17-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 16:20:39
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 berrange@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/i386/kvm/i8259.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/kvm/i8259.c b/hw/i386/kvm/i8259.c
index 3f8bf69e9c..687c0cd536 100644
--- a/hw/i386/kvm/i8259.c
+++ b/hw/i386/kvm/i8259.c
@@ -19,10 +19,10 @@
 #include "sysemu/kvm.h"
 #include "qom/object.h"
 
-#define TYPE_KVM_I8259 "kvm-i8259"
+#define TYPE_KVM_PIC "kvm-i8259"
 typedef struct KVMPICClass KVMPICClass;
 DECLARE_CLASS_CHECKERS(KVMPICClass, KVM_PIC,
-                       TYPE_KVM_I8259)
+                       TYPE_KVM_PIC)
 
 /**
  * KVMPICClass:
@@ -133,8 +133,8 @@ static void kvm_pic_realize(DeviceState *dev, Error **errp)
 
 qemu_irq *kvm_i8259_init(ISABus *bus)
 {
-    i8259_init_chip(TYPE_KVM_I8259, bus, true);
-    i8259_init_chip(TYPE_KVM_I8259, bus, false);
+    i8259_init_chip(TYPE_KVM_PIC, bus, true);
+    i8259_init_chip(TYPE_KVM_PIC, bus, false);
 
     return qemu_allocate_irqs(kvm_pic_set_irq, NULL, ISA_NUM_IRQS);
 }
@@ -152,7 +152,7 @@ static void kvm_i8259_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo kvm_i8259_info = {
-    .name = TYPE_KVM_I8259,
+    .name = TYPE_KVM_PIC,
     .parent = TYPE_PIC_COMMON,
     .instance_size = sizeof(PICCommonState),
     .class_init = kvm_i8259_class_init,
-- 
2.26.2


