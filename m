Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7E6C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3BD923A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsxGDYQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BD923A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU9O-0000Wr-QA
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU27-0000b9-5n
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU22-0001ei-DN
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/EBpP8r6TKM0MA75vsOahpPWeODiE6EuJYCvSL2cu0U=;
 b=LsxGDYQu0m8hPk+rOw9772goAncEq6ZflTaUqmPdZJYeeb/9h+qBScrWdOBliuyUkR6PTG
 mhYARUcT5bHlTGUup8V88sVXLuTwOb0sOO/L8/FJomXAoDCHEpw0tbFJckBzQckbzmyI2S
 EtcON5BMaBNBC9sCJ0kui2ed2xyiVfY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-JHjv2d3aO6OUJxXtyCP9hg-1; Mon, 21 Sep 2020 18:11:28 -0400
X-MC-Unique: JHjv2d3aO6OUJxXtyCP9hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 281DD10059A2;
 Mon, 21 Sep 2020 22:11:27 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE4A510013BD;
 Mon, 21 Sep 2020 22:11:26 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/24] arm/cpu64: Register "aarch64" as class property
Date: Mon, 21 Sep 2020 18:10:39 -0400
Message-Id: <20200921221045.699690-19-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
---
 target/arm/cpu64.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 3c2b3d95993..349c9fa3a3a 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -758,15 +758,6 @@ static void aarch64_cpu_set_aarch64(Object *obj, bool value, Error **errp)
     }
 }
 
-static void aarch64_cpu_initfn(Object *obj)
-{
-    object_property_add_bool(obj, "aarch64", aarch64_cpu_get_aarch64,
-                             aarch64_cpu_set_aarch64);
-    object_property_set_description(obj, "aarch64",
-                                    "Set on/off to enable/disable aarch64 "
-                                    "execution state ");
-}
-
 static void aarch64_cpu_finalizefn(Object *obj)
 {
 }
@@ -786,6 +777,12 @@ static void aarch64_cpu_class_init(ObjectClass *oc, void *data)
     cc->gdb_num_core_regs = 34;
     cc->gdb_core_xml_file = "aarch64-core.xml";
     cc->gdb_arch_name = aarch64_gdb_arch_name;
+
+    object_class_property_add_bool(oc, "aarch64", aarch64_cpu_get_aarch64,
+                                   aarch64_cpu_set_aarch64);
+    object_class_property_set_description(oc, "aarch64",
+                                          "Set on/off to enable/disable aarch64 "
+                                          "execution state ");
 }
 
 static void aarch64_cpu_instance_init(Object *obj)
@@ -823,7 +820,6 @@ static const TypeInfo aarch64_cpu_type_info = {
     .name = TYPE_AARCH64_CPU,
     .parent = TYPE_ARM_CPU,
     .instance_size = sizeof(ARMCPU),
-    .instance_init = aarch64_cpu_initfn,
     .instance_finalize = aarch64_cpu_finalizefn,
     .abstract = true,
     .class_size = sizeof(AArch64CPUClass),
-- 
2.26.2


