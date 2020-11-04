Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8153C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08403206A5
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drp95awI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08403206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLZ4-0008OW-Tg
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42708)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFb-0003Lr-VJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41212)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFR-0005fn-82
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rnsAQS9p5qUxiHcURVAW27xa0Tv42zUraThvMLjpcjw=;
 b=drp95awIr5yWHeM8dKfR22zTxQyozi6iR24DNKFkGVjbruwxpYcOtXkJGZQARigWyIu2MG
 Mj7T35xE/EXa1E5AOxNrOCXVsfly92ElYJXJZUh3xkrtnEwFvK9H7gKWyVOBhi4h0mKso0
 2YuxC63n/NoozxPte3iGEjnEtVkcMNQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-vbGyTCQnPxuG1ICjw--aZQ-1; Wed, 04 Nov 2020 11:02:54 -0500
X-MC-Unique: vbGyTCQnPxuG1ICjw--aZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29FDF803F76;
 Wed,  4 Nov 2020 16:02:28 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C45176640;
 Wed,  4 Nov 2020 16:02:24 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/44] qdev: Rename qdev_prop_* to prop_info_*
Date: Wed,  4 Nov 2020 11:00:15 -0500
Message-Id: <20201104160021.2342108-39-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The basic property types in qdev-properties.c are not going to be
qdev-specific anymore.  Rename the variables to prop_info_*.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Redone patch after moving UUID property to qdev-properties-system.c
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
---
 include/hw/qdev-properties.h | 62 ++++++++++++++++++------------------
 hw/core/qdev-properties.c    | 36 ++++++++++-----------
 hw/intc/arm_gicv3_common.c   |  2 +-
 hw/intc/rx_icu.c             |  4 +--
 hw/misc/arm_sysctl.c         |  4 +--
 hw/net/e1000e.c              |  6 ++--
 target/arm/cpu.c             |  2 +-
 target/sparc/cpu.c           |  2 +-
 8 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index c3eaf5e3c5..0a44a91e6e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -51,22 +51,22 @@ struct PropertyInfo {
 
 /*** qdev-properties.c ***/
 
-extern const PropertyInfo qdev_prop_bit;
-extern const PropertyInfo qdev_prop_bit64;
-extern const PropertyInfo qdev_prop_bool;
-extern const PropertyInfo qdev_prop_enum;
-extern const PropertyInfo qdev_prop_uint8;
-extern const PropertyInfo qdev_prop_uint16;
-extern const PropertyInfo qdev_prop_uint32;
-extern const PropertyInfo qdev_prop_int32;
-extern const PropertyInfo qdev_prop_uint64;
-extern const PropertyInfo qdev_prop_int64;
-extern const PropertyInfo qdev_prop_size;
-extern const PropertyInfo qdev_prop_string;
-extern const PropertyInfo qdev_prop_on_off_auto;
-extern const PropertyInfo qdev_prop_size32;
-extern const PropertyInfo qdev_prop_arraylen;
-extern const PropertyInfo qdev_prop_link;
+extern const PropertyInfo prop_info_bit;
+extern const PropertyInfo prop_info_bit64;
+extern const PropertyInfo prop_info_bool;
+extern const PropertyInfo prop_info_enum;
+extern const PropertyInfo prop_info_uint8;
+extern const PropertyInfo prop_info_uint16;
+extern const PropertyInfo prop_info_uint32;
+extern const PropertyInfo prop_info_int32;
+extern const PropertyInfo prop_info_uint64;
+extern const PropertyInfo prop_info_int64;
+extern const PropertyInfo prop_info_size;
+extern const PropertyInfo prop_info_string;
+extern const PropertyInfo prop_info_on_off_auto;
+extern const PropertyInfo prop_info_size32;
+extern const PropertyInfo prop_info_arraylen;
+extern const PropertyInfo prop_info_link;
 
 #define DEFINE_PROP(_name, _state, _field, _prop, _type, ...) {  \
         .qdev_prop_name      = (_name),                          \
@@ -85,7 +85,7 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_name, _state, _field, _prop, _type)
 
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_bit, uint32_t, \
+    DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
                 .bitnr       = (_bit),                          \
                 .set_default = true,                            \
                 .defval.u    = (bool)_defval)
@@ -99,13 +99,13 @@ extern const PropertyInfo qdev_prop_link;
     DEFINE_PROP(_name, _state, _field, _prop, _type)
 
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_bit64, uint64_t, \
+    DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
                 .bitnr    = (_bit),                               \
                 .set_default = true,                              \
                 .defval.u  = (bool)_defval)
 
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_bool, bool, \
+    DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
                 .set_default = true,                         \
                 .defval.u    = (bool)_defval)
 
@@ -138,7 +138,7 @@ extern const PropertyInfo qdev_prop_link;
 #define DEFINE_PROP_ARRAY(_name, _state, _field,               \
                           _arrayfield, _arrayprop, _arraytype) \
     DEFINE_PROP((PROP_ARRAY_LEN_PREFIX _name),                 \
-                _state, _field, qdev_prop_arraylen, uint32_t,  \
+                _state, _field, prop_info_arraylen, uint32_t,  \
                 .set_default = true,                           \
                 .defval.u = 0,                                 \
                 .arrayinfo = &(_arrayprop),                    \
@@ -146,29 +146,29 @@ extern const PropertyInfo qdev_prop_link;
                 .arrayoffset = offsetof(_state, _arrayfield))
 
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
-    DEFINE_PROP(_name, _state, _field, qdev_prop_link, _ptr_type,     \
+    DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type,     \
                 .link_type  = _type)
 
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint8, uint8_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_t)
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint16, uint16_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint16_t)
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint32, uint32_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint32_t)
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int32, int32_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_uint64, uint64_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint64_t)
 #define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_int64, int64_t)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size, uint64_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_t)
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
-    DEFINE_PROP(_n, _s, _f, qdev_prop_string, char*)
+    DEFINE_PROP(_n, _s, _f, prop_info_string, char*)
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
-    DEFINE_PROP_SIGNED(_n, _s, _f, _d, qdev_prop_on_off_auto, OnOffAuto)
+    DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, OnOffAuto)
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
-    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, qdev_prop_size32, uint32_t)
+    DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint32_t)
 
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 9aebd7b8a9..64b803a200 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -117,7 +117,7 @@ void field_prop_set_default_value_enum(ObjectProperty *op,
         qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
 }
 
-const PropertyInfo qdev_prop_enum = {
+const PropertyInfo prop_info_enum = {
     .name  = "enum",
     .get   = field_prop_get_enum,
     .set   = field_prop_set_enum,
@@ -128,7 +128,7 @@ const PropertyInfo qdev_prop_enum = {
 
 static uint32_t qdev_get_prop_mask(Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit);
+    assert(prop->info == &prop_info_bit);
     return 0x1 << prop->bitnr;
 }
 
@@ -170,7 +170,7 @@ static void set_default_value_bool(ObjectProperty *op, const Property *prop)
     object_property_set_default_bool(op, prop->defval.u);
 }
 
-const PropertyInfo qdev_prop_bit = {
+const PropertyInfo prop_info_bit = {
     .name  = "bool",
     .description = "on/off",
     .get   = prop_get_bit,
@@ -182,7 +182,7 @@ const PropertyInfo qdev_prop_bit = {
 
 static uint64_t qdev_get_prop_mask64(Property *prop)
 {
-    assert(prop->info == &qdev_prop_bit64);
+    assert(prop->info == &prop_info_bit64);
     return 0x1ull << prop->bitnr;
 }
 
@@ -219,7 +219,7 @@ static void prop_set_bit64(Object *obj, Visitor *v, const char *name,
     bit64_prop_set(obj, prop, value);
 }
 
-const PropertyInfo qdev_prop_bit64 = {
+const PropertyInfo prop_info_bit64 = {
     .name  = "bool",
     .description = "on/off",
     .get   = prop_get_bit64,
@@ -247,7 +247,7 @@ static void set_bool(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_bool(v, name, ptr, errp);
 }
 
-const PropertyInfo qdev_prop_bool = {
+const PropertyInfo prop_info_bool = {
     .name  = "bool",
     .get   = get_bool,
     .set   = set_bool,
@@ -286,7 +286,7 @@ void field_prop_set_default_value_uint(ObjectProperty *op,
     object_property_set_default_uint(op, prop->defval.u);
 }
 
-const PropertyInfo qdev_prop_uint8 = {
+const PropertyInfo prop_info_uint8 = {
     .name  = "uint8",
     .get   = get_uint8,
     .set   = set_uint8,
@@ -313,7 +313,7 @@ static void set_uint16(Object *obj, Visitor *v, const char *name,
     visit_type_uint16(v, name, ptr, errp);
 }
 
-const PropertyInfo qdev_prop_uint16 = {
+const PropertyInfo prop_info_uint16 = {
     .name  = "uint16",
     .get   = get_uint16,
     .set   = set_uint16,
@@ -358,14 +358,14 @@ static void set_int32(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_int32(v, name, ptr, errp);
 }
 
-const PropertyInfo qdev_prop_uint32 = {
+const PropertyInfo prop_info_uint32 = {
     .name  = "uint32",
     .get   = get_uint32,
     .set   = set_uint32,
     .set_default_value = field_prop_set_default_value_uint,
 };
 
-const PropertyInfo qdev_prop_int32 = {
+const PropertyInfo prop_info_int32 = {
     .name  = "int32",
     .get   = field_prop_get_int32,
     .set   = set_int32,
@@ -410,14 +410,14 @@ static void set_int64(Object *obj, Visitor *v, const char *name,
     visit_type_int64(v, name, ptr, errp);
 }
 
-const PropertyInfo qdev_prop_uint64 = {
+const PropertyInfo prop_info_uint64 = {
     .name  = "uint64",
     .get   = get_uint64,
     .set   = set_uint64,
     .set_default_value = field_prop_set_default_value_uint,
 };
 
-const PropertyInfo qdev_prop_int64 = {
+const PropertyInfo prop_info_int64 = {
     .name  = "int64",
     .get   = get_int64,
     .set   = set_int64,
@@ -460,7 +460,7 @@ static void set_string(Object *obj, Visitor *v, const char *name,
     *ptr = str;
 }
 
-const PropertyInfo qdev_prop_string = {
+const PropertyInfo prop_info_string = {
     .name  = "str",
     .release = release_string,
     .get   = get_string,
@@ -469,7 +469,7 @@ const PropertyInfo qdev_prop_string = {
 
 /* --- on/off/auto --- */
 
-const PropertyInfo qdev_prop_on_off_auto = {
+const PropertyInfo prop_info_on_off_auto = {
     .name = "OnOffAuto",
     .description = "on/off/auto",
     .enum_table = &OnOffAuto_lookup,
@@ -512,7 +512,7 @@ static void set_size32(Object *obj, Visitor *v, const char *name, void *opaque,
     *ptr = value;
 }
 
-const PropertyInfo qdev_prop_size32 = {
+const PropertyInfo prop_info_size32 = {
     .name  = "size",
     .get = field_prop_get_size32,
     .set = set_size32,
@@ -575,7 +575,7 @@ static void set_prop_arraylen(Object *obj, Visitor *v, const char *name,
     }
 }
 
-const PropertyInfo qdev_prop_arraylen = {
+const PropertyInfo prop_info_arraylen = {
     .name = "uint32",
     .get = get_uint32,
     .set = set_prop_arraylen,
@@ -774,7 +774,7 @@ static void set_size(Object *obj, Visitor *v, const char *name, void *opaque,
     visit_type_size(v, name, ptr, errp);
 }
 
-const PropertyInfo qdev_prop_size = {
+const PropertyInfo prop_info_size = {
     .name  = "size",
     .get = get_size,
     .set = set_size,
@@ -796,7 +796,7 @@ static ObjectProperty *create_link_property(ObjectClass *oc, const char *name,
                                           OBJ_PROP_LINK_STRONG);
 }
 
-const PropertyInfo qdev_prop_link = {
+const PropertyInfo prop_info_link = {
     .name = "link",
     .create = create_link_property,
 };
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 58ef65f589..6d06b4d4c5 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -496,7 +496,7 @@ static Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
     DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
-                      redist_region_count, qdev_prop_uint32, uint32_t),
+                      redist_region_count, prop_info_uint32, uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/intc/rx_icu.c b/hw/intc/rx_icu.c
index 94e17a9dea..823160d9a8 100644
--- a/hw/intc/rx_icu.c
+++ b/hw/intc/rx_icu.c
@@ -365,9 +365,9 @@ static const VMStateDescription vmstate_rxicu = {
 
 static Property rxicu_properties[] = {
     DEFINE_PROP_ARRAY("ipr-map", RXICUState, nr_irqs, map,
-                      qdev_prop_uint8, uint8_t),
+                      prop_info_uint8, uint8_t),
     DEFINE_PROP_ARRAY("trigger-level", RXICUState, nr_sense, init_sense,
-                      qdev_prop_uint8, uint8_t),
+                      prop_info_uint8, uint8_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 42d4693854..634f3d916f 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -628,10 +628,10 @@ static Property arm_sysctl_properties[] = {
     DEFINE_PROP_UINT32("proc_id", arm_sysctl_state, proc_id, 0),
     /* Daughterboard power supply voltages (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-voltage", arm_sysctl_state, db_num_vsensors,
-                      db_voltage, qdev_prop_uint32, uint32_t),
+                      db_voltage, prop_info_uint32, uint32_t),
     /* Daughterboard clock reset values (as reported via SYS_CFG) */
     DEFINE_PROP_ARRAY("db-clock", arm_sysctl_state, db_num_clocks,
-                      db_clock_reset, qdev_prop_uint32, uint32_t),
+                      db_clock_reset, prop_info_uint32, uint32_t),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index b6f1ae3c8f..7928939ae2 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -686,15 +686,15 @@ static void e1000e_class_init(ObjectClass *class, void *data)
     dc->reset = e1000e_qdev_reset;
     dc->vmsd = &e1000e_vmstate;
 
-    e1000e_prop_disable_vnet = qdev_prop_uint8;
+    e1000e_prop_disable_vnet = prop_info_uint8;
     e1000e_prop_disable_vnet.description = "Do not use virtio headers, "
                                            "perform SW offloads emulation "
                                            "instead";
 
-    e1000e_prop_subsys_ven = qdev_prop_uint16;
+    e1000e_prop_subsys_ven = prop_info_uint16;
     e1000e_prop_subsys_ven.description = "PCI device Subsystem Vendor ID";
 
-    e1000e_prop_subsys = qdev_prop_uint16;
+    e1000e_prop_subsys = prop_info_uint16;
     e1000e_prop_subsys.description = "PCI device Subsystem ID";
 
     device_class_set_props(dc, e1000e_properties);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07492e9f9a..cef92879b0 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1108,7 +1108,7 @@ static Property arm_cpu_has_mpu_property =
 static Property arm_cpu_pmsav7_dregion_property =
             DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
                                            pmsav7_dregion,
-                                           qdev_prop_uint32, uint32_t);
+                                           prop_info_uint32, uint32_t);
 
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3375fffb38..ec59a13eb8 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -839,7 +839,7 @@ static Property sparc_cpu_properties[] = {
     DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
     DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
     DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
-                         qdev_prop_uint64, target_ulong),
+                         prop_info_uint64, target_ulong),
     DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
     DEFINE_PROP_UINT32("mmu-version", SPARCCPU, env.def.mmu_version, 0),
     DEFINE_PROP("nwindows",     SPARCCPU, env.def.nwindows,
-- 
2.28.0


