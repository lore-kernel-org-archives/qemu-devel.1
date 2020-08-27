Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D9C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE1F2087E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh8FYfiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE1F2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNgi-0008FG-Ch
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSq-0005zG-Eg
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24689)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNSo-0000Ls-PO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZ19hG2ss9WIeWKCsX6AGJ0Oedd8u71zzCoJoHZ3RK8=;
 b=Eh8FYfiqUMn6UsfdxPosJsQ507XURSUvSyG3RxGqWFCxy/6qR+CWL0l8hkkC0A7dFrtBL2
 3eCJrxdME5Mtj7xhHtvgacIWQ+/QsRCROXbAXCwT+Hqj2gJu4bguz+Krx8z4u75BVOKupe
 iatI+kYViVFnEzZkeGHoc9qEHSW9gCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-1VsRYjSoOzWoF_UqloDw0w-1; Thu, 27 Aug 2020 15:21:31 -0400
X-MC-Unique: 1VsRYjSoOzWoF_UqloDw0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 538E9185FD95;
 Thu, 27 Aug 2020 19:21:30 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CBAA78392;
 Thu, 27 Aug 2020 19:21:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/53] e1000: Rename QOM class cast macros
Date: Thu, 27 Aug 2020 15:20:31 -0400
Message-Id: <20200827192122.658035-3-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename the E1000_DEVICE_CLASS() and E1000_DEVICE_GET_CLASS()
macros to be consistent with the E1000() instance cast macro.

This will allow us to register the type cast macros using
OBJECT_DECLARE_TYPE later.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/net/e1000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index a18f80e369..c4d896a9e6 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -151,9 +151,9 @@ typedef struct E1000BaseClass {
 #define E1000(obj) \
     OBJECT_CHECK(E1000State, (obj), TYPE_E1000_BASE)
 
-#define E1000_DEVICE_CLASS(klass) \
+#define E1000_CLASS(klass) \
      OBJECT_CLASS_CHECK(E1000BaseClass, (klass), TYPE_E1000_BASE)
-#define E1000_DEVICE_GET_CLASS(obj) \
+#define E1000_GET_CLASS(obj) \
     OBJECT_GET_CLASS(E1000BaseClass, (obj), TYPE_E1000_BASE)
 
 static void
@@ -365,7 +365,7 @@ e1000_autoneg_timer(void *opaque)
 static void e1000_reset(void *opaque)
 {
     E1000State *d = opaque;
-    E1000BaseClass *edc = E1000_DEVICE_GET_CLASS(d);
+    E1000BaseClass *edc = E1000_GET_CLASS(d);
     uint8_t *macaddr = d->conf.macaddr.a;
 
     timer_del(d->autoneg_timer);
@@ -1751,7 +1751,7 @@ static void e1000_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    E1000BaseClass *e = E1000_DEVICE_CLASS(klass);
+    E1000BaseClass *e = E1000_CLASS(klass);
     const E1000Info *info = data;
 
     k->realize = pci_e1000_realize;
-- 
2.26.2


