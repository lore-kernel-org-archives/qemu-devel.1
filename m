Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A36C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52550207DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D7kN7Yx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52550207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBNuo-0008Rz-IB
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 15:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTr-0007fR-CC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21875)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kBNTp-0000UY-Ng
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 15:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598556156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClHMBwjDNhYDDMdiCYbxXiOD5wk+OXlFAseOOxzfMuk=;
 b=D7kN7Yx8yXAHG0gj7tcmT0p3lyxZBUq3aI1VWhJWKKECqvSZfv6XuEko15hBzFQE3Sslkq
 7W+fmJr9p/2K/qlohhavZWlFSZERdmkhAjU5m1qiZdOTFl/ipUUPg2ffbm9g6OWJ9DAexD
 2hkREaNYvYZnweEiQzNSPmwiai/TaPo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-RfQeboBbNgStEfGASWAG6w-1; Thu, 27 Aug 2020 15:22:34 -0400
X-MC-Unique: RfQeboBbNgStEfGASWAG6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2FE48018A4;
 Thu, 27 Aug 2020 19:22:32 +0000 (UTC)
Received: from localhost (unknown [10.10.67.254])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B346F795B0;
 Thu, 27 Aug 2020 19:22:32 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 32/53] pckbd: Move QOM macro to header
Date: Thu, 27 Aug 2020 15:21:01 -0400
Message-Id: <20200827192122.658035-33-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
References: <20200827192122.658035-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
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

Move the I8042 macro close to the TYPE_I8042 define.

This will make future conversion to OBJECT_DECLARE* easier.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Tested-By: Roman Bolshakov <r.bolshakov@yadro.com>
Message-Id: <20200825192110.3528606-34-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/input/i8042.h | 1 +
 hw/input/pckbd.c         | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
index 8eaebf50ce..4569dfddd9 100644
--- a/include/hw/input/i8042.h
+++ b/include/hw/input/i8042.h
@@ -11,6 +11,7 @@
 #include "hw/isa/isa.h"
 
 #define TYPE_I8042 "i8042"
+#define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
 
 #define I8042_A20_LINE "a20"
 
diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
index 29d633ca94..dde85ba6c6 100644
--- a/hw/input/pckbd.c
+++ b/hw/input/pckbd.c
@@ -481,8 +481,6 @@ void i8042_mm_init(qemu_irq kbd_irq, qemu_irq mouse_irq,
     qemu_register_reset(kbd_reset, s);
 }
 
-#define I8042(obj) OBJECT_CHECK(ISAKBDState, (obj), TYPE_I8042)
-
 struct ISAKBDState {
     ISADevice parent_obj;
 
-- 
2.26.2


