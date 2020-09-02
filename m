Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A81C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF06820767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 22:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7FiWTm2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF06820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbb2-0007bJ-VL
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 18:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUI-0002U4-NU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbUG-0008Mo-T7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lt1IC/XNJ8g37UsGuausIOFYYvEoABFnZL05pfNJNRM=;
 b=B7FiWTm29ZADf9XTdG0BmLjnXAs3LJh93aSlA2e8+deLoovCOpxRBjMi7HVyxFQJjMqdyF
 mydPCrADUHdMjv5eeECGKAWbKuAXe9D5F6g2llxzeB0ZQJCbkTznvFaBOjPpDn53Koc+h7
 yBuJSEyc0vNmoe2Z1mvwM5Sd/vyA8fA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-MBodZYnOOcuThSSoRotfMw-1; Wed, 02 Sep 2020 18:44:14 -0400
X-MC-Unique: MBodZYnOOcuThSSoRotfMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 304A818A2251
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:44:13 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7703460C0F;
 Wed,  2 Sep 2020 22:44:09 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/63] intel-hda: Rename TYPE_INTEL_HDA_GENERIC to
 TYPE_INTEL_HDA
Date: Wed,  2 Sep 2020 18:42:25 -0400
Message-Id: <20200902224311.1321159-18-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 17:54:06
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
Cc: berrange@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will make the type name constant consistent with the name of
the type checking macro.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
---
 hw/audio/intel-hda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 4330213fff..28c4edeece 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -202,10 +202,10 @@ struct IntelHDAState {
     bool old_msi_addr;
 };
 
-#define TYPE_INTEL_HDA_GENERIC "intel-hda-generic"
+#define TYPE_INTEL_HDA "intel-hda-generic"
 
 DECLARE_INSTANCE_CHECKER(IntelHDAState, INTEL_HDA,
-                         TYPE_INTEL_HDA_GENERIC)
+                         TYPE_INTEL_HDA)
 
 struct IntelHDAReg {
     const char *name;      /* register name */
@@ -1257,7 +1257,7 @@ static void intel_hda_class_init_ich9(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo intel_hda_info = {
-    .name          = TYPE_INTEL_HDA_GENERIC,
+    .name          = TYPE_INTEL_HDA,
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(IntelHDAState),
     .class_init    = intel_hda_class_init,
@@ -1270,13 +1270,13 @@ static const TypeInfo intel_hda_info = {
 
 static const TypeInfo intel_hda_info_ich6 = {
     .name          = "intel-hda",
-    .parent        = TYPE_INTEL_HDA_GENERIC,
+    .parent        = TYPE_INTEL_HDA,
     .class_init    = intel_hda_class_init_ich6,
 };
 
 static const TypeInfo intel_hda_info_ich9 = {
     .name          = "ich9-intel-hda",
-    .parent        = TYPE_INTEL_HDA_GENERIC,
+    .parent        = TYPE_INTEL_HDA,
     .class_init    = intel_hda_class_init_ich9,
 };
 
-- 
2.26.2


