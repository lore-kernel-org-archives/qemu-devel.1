Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3ACFC433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 669EA20767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 23:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd0kWpo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669EA20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDbtX-0003sQ-Js
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 19:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVo-00067H-NA
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39531
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDbVm-0000Ht-Mq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 18:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086749;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVz4EFPAQ32B6HhEtuF+vndBPUQ03KNBGr119x+AUZI=;
 b=Gd0kWpo5mj7mdcpe/vk+XQJ9DaNW9h7eeWJUc0YHTiFfRMNXlRK3pFaNIEZefRMCp/QBXq
 wi5p/GyQm2qno/6xV82k1ol/X6nps7vTZKpsCYazQuvDbO2DPI4ohOIc8jiAJK6Zmiv/n6
 5W1k3cIGHXtksgzVvXTSyU8jwj9B2rQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-PqREQJxAMCKr7fTVbxCUNA-1; Wed, 02 Sep 2020 18:45:48 -0400
X-MC-Unique: PqREQJxAMCKr7fTVbxCUNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D6AF18A2251
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2020 22:45:47 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9EF672C6;
 Wed,  2 Sep 2020 22:45:47 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 62/63] tests: Rename DYNAMIC_TYPE to DYNAMIC_PROPS
Date: Wed,  2 Sep 2020 18:43:10 -0400
Message-Id: <20200902224311.1321159-63-ehabkost@redhat.com>
In-Reply-To: <20200902224311.1321159-1-ehabkost@redhat.com>
References: <20200902224311.1321159-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make the type checking macro name consistent with the TYPE_*
constant.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 tests/test-qdev-global-props.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/test-qdev-global-props.c b/tests/test-qdev-global-props.c
index 8a3c14d92c..bf6b9fb2a2 100644
--- a/tests/test-qdev-global-props.c
+++ b/tests/test-qdev-global-props.c
@@ -128,7 +128,7 @@ static void test_static_globalprop(void)
 }
 
 #define TYPE_DYNAMIC_PROPS "dynamic-prop-type"
-DECLARE_INSTANCE_CHECKER(MyType, DYNAMIC_TYPE,
+DECLARE_INSTANCE_CHECKER(MyType, DYNAMIC_PROPS,
                          TYPE_DYNAMIC_PROPS)
 
 #define TYPE_UNUSED_HOTPLUG   "hotplug-type"
@@ -137,7 +137,7 @@ DECLARE_INSTANCE_CHECKER(MyType, DYNAMIC_TYPE,
 static void prop1_accessor(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    MyType *mt = DYNAMIC_TYPE(obj);
+    MyType *mt = DYNAMIC_PROPS(obj);
 
     visit_type_uint32(v, name, &mt->prop1, errp);
 }
@@ -145,7 +145,7 @@ static void prop1_accessor(Object *obj, Visitor *v, const char *name,
 static void prop2_accessor(Object *obj, Visitor *v, const char *name,
                            void *opaque, Error **errp)
 {
-    MyType *mt = DYNAMIC_TYPE(obj);
+    MyType *mt = DYNAMIC_PROPS(obj);
 
     visit_type_uint32(v, name, &mt->prop2, errp);
 }
@@ -230,7 +230,7 @@ static void test_dynamic_globalprop_subprocess(void)
 
     register_global_properties(props);
 
-    mt = DYNAMIC_TYPE(object_new(TYPE_DYNAMIC_PROPS));
+    mt = DYNAMIC_PROPS(object_new(TYPE_DYNAMIC_PROPS));
     qdev_realize(DEVICE(mt), NULL, &error_fatal);
 
     g_assert_cmpuint(mt->prop1, ==, 101);
-- 
2.26.2


