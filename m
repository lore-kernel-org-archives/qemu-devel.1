Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D3C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5AAB206FA
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpJ5NcYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AAB206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrIB-0001Jz-TJ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3g-0006re-1A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36045)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kCr3e-0000J5-6N
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598908181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6b4xBWy8WQuhQthmWGIy2Zb3NGXH6qeT5Yf4lCM9IA=;
 b=ZpJ5NcYhkw85Ueek7OHyZy9VRhi8JntMq/hBrMjDL/Z/T9WIusF0Ne2YtvpVAUPzRtxqkh
 /Kcj4maqqyuvYgF5Xx6ZTB+uEPRLg7rWbSvkj/d0/Cm/oaCdPT+78sZIs0b70tDEDkjafW
 saC6sEL/+g7LvtYwWMIaGT/5/VIxaC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-hDT5kukYNOOqRmOgWWZHlw-1; Mon, 31 Aug 2020 17:09:39 -0400
X-MC-Unique: hDT5kukYNOOqRmOgWWZHlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AC921888A0A;
 Mon, 31 Aug 2020 21:09:38 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 351435D9CD;
 Mon, 31 Aug 2020 21:09:38 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 16/18] [automated] Use OBJECT_DECLARE_TYPE where possible
 (pass 2)
Date: Mon, 31 Aug 2020 17:07:38 -0400
Message-Id: <20200831210740.126168-17-ehabkost@redhat.com>
In-Reply-To: <20200831210740.126168-1-ehabkost@redhat.com>
References: <20200831210740.126168-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 13:03:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace DECLARE_OBJ_CHECKERS with OBJECT_DECLARE_TYPE where the
typedefs can be safely removed.

Generated running:

$ ./scripts/codeconverter/converter.py -i \
  --pattern=DeclareObjCheckers $(git grep -l '' -- '*.[ch]')

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v3 -> v4: none

Changes series v2 -> v3: this is a new patch added in series v3

The script was re-run after rebase and after additional patches
were added to this series.

This is being submitted as a separate patch to make review
easier, but it can be squashed into the previous patch once it
gets reviewed.

---
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
---
 include/hw/ppc/xive.h | 6 ++----
 target/rx/cpu-qom.h   | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 48595ab641..482fafccfd 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -345,12 +345,10 @@ struct XiveRouter {
 
     XiveFabric *xfb;
 };
-typedef struct XiveRouter XiveRouter;
 
 #define TYPE_XIVE_ROUTER "xive-router"
-typedef struct XiveRouterClass XiveRouterClass;
-DECLARE_OBJ_CHECKERS(XiveRouter, XiveRouterClass,
-                     XIVE_ROUTER, TYPE_XIVE_ROUTER)
+OBJECT_DECLARE_TYPE(XiveRouter, XiveRouterClass,
+                    xive_router, XIVE_ROUTER)
 
 struct XiveRouterClass {
     SysBusDeviceClass parent;
diff --git a/target/rx/cpu-qom.h b/target/rx/cpu-qom.h
index 05f5773ab1..6c5321078d 100644
--- a/target/rx/cpu-qom.h
+++ b/target/rx/cpu-qom.h
@@ -26,10 +26,8 @@
 
 #define TYPE_RX62N_CPU RX_CPU_TYPE_NAME("rx62n")
 
-typedef struct RXCPU RXCPU;
-typedef struct RXCPUClass RXCPUClass;
-DECLARE_OBJ_CHECKERS(RXCPU, RXCPUClass,
-                     RX_CPU, TYPE_RX_CPU)
+OBJECT_DECLARE_TYPE(RXCPU, RXCPUClass,
+                    rx_cpu, RX_CPU)
 
 /*
  * RXCPUClass:
-- 
2.26.2


