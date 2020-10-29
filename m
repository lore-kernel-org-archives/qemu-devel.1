Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661BDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:30:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEFB20729
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 22:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JEVWJE9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEFB20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYGR3-00048L-Jf
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 18:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1x-0003yQ-61
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24640)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kYG1f-0006gE-6Z
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 18:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604009046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEYbP5Fufv/2Pc0hBcb52f+uJ8RaCQiISEAH9HcQPW4=;
 b=JEVWJE9+fgRjAdlNZrBruOGap6+vwlOnxLolgvebnAKYj0aHxZiRsXlrrWBN1hQL7UJVoK
 WF+H9BOGpGwAH1D39434BUxJlH6ZpBFbqASk975uoIbjTcidvIN8m7cVFQJHchp0LX7ah7
 4ZymazMvJCYS0s7VED/dNJkxbzovK38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-7n55JuXOMGacp3gh8NUOdQ-1; Thu, 29 Oct 2020 18:04:04 -0400
X-MC-Unique: 7n55JuXOMGacp3gh8NUOdQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BF085C706
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 22:04:03 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 123E26EF68;
 Thu, 29 Oct 2020 22:04:02 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 36/36] qom: Include static property API reference in
 documentation
Date: Thu, 29 Oct 2020 18:02:46 -0400
Message-Id: <20201029220246.472693-37-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-1-ehabkost@redhat.com>
References: <20201029220246.472693-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 00:47:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new doc comments and reformat the existing ones,
and include the static-properties.h API reference in
docs/devel/qom.rst.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/qom.rst            |   6 ++
 include/qom/static-property.h | 154 ++++++++++++++++++++++++++++++++--
 2 files changed, 151 insertions(+), 9 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 42d0dc4f4d..0989b4e690 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -379,3 +379,9 @@ API Reference
 -------------
 
 .. kernel-doc:: include/qom/object.h
+
+
+Static Property API Reference
+-----------------------------
+
+.. kernel-doc:: include/qom/static-property.h
diff --git a/include/qom/static-property.h b/include/qom/static-property.h
index 779918c947..8339700818 100644
--- a/include/qom/static-property.h
+++ b/include/qom/static-property.h
@@ -8,20 +8,31 @@
 #include "qapi/util.h"
 
 /**
- * Property:
- * @set_default: true if the default value should be set from @defval,
- *    in which case @info->set_default_value must not be NULL
- *    (if false then no default value is set by the property system
- *     and the field retains whatever value it was given by instance_init).
- * @defval: default value for the property. This is used only if @set_default
- *     is true.
+ * struct Property: Definition of a static Property
+ *
+ * #Property structs should be always initialized using the
+ * ``DEFINE_PROP`` family of macros.
  */
 struct Property {
+    /* private: */
     const char   *name;
     const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
+    /**
+     *  @set_default: true if the default value should be set
+     *                from @defval, in which case
+     *                @info->set_default_value must not be NULL
+     *                (if false then no default value is set by
+     *                the property system and the field retains
+     *                whatever value it was given by
+     *                instance_init).
+     */
     bool         set_default;
+    /**
+     * @defval: default value for the property. This is used only
+     *          if @set_default is true.
+     */
     union {
         int64_t i;
         uint64_t u;
@@ -110,6 +121,14 @@ extern const PropertyInfo prop_info_link;
 #define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
 
+/**
+ * DEFINE_PROP_BIT: Define bit property in uint32_t field
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of ``uint32_t`` field in @_state
+ * @_bit: bit offset in @_field
+ * @_defval: default value for bit
+ */
 #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval)   \
     DEFINE_PROP(_name, _state, _field, prop_info_bit, uint32_t, \
                 .bitnr       = (_bit),                          \
@@ -124,12 +143,27 @@ extern const PropertyInfo prop_info_link;
 #define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) \
     DEFINE_PROP(_name, _state, _field, _prop, _type)
 
+/**
+ * DEFINE_PROP_BIT64: Define bit property in uint64_t field
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of ``uint64_t`` field in @_state
+ * @_bit: bit offset in @_field
+ * @_defval: default value for bit
+ */
 #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval)   \
     DEFINE_PROP(_name, _state, _field, prop_info_bit64, uint64_t, \
                 .bitnr    = (_bit),                               \
                 .set_default = true,                              \
                 .defval.u  = (bool)_defval)
 
+/**
+ * DEFINE_PROP_BOOL:
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of ``bool`` field in @_state
+ * @_defval: default value of property
+ */
 #define DEFINE_PROP_BOOL(_name, _state, _field, _defval)     \
     DEFINE_PROP(_name, _state, _field, prop_info_bool, bool, \
                 .set_default = true,                         \
@@ -142,9 +176,10 @@ extern const PropertyInfo prop_info_link;
  * @_name: name of the array
  * @_state: name of the device state structure type
  * @_field: uint32_t field in @_state to hold the array length
- * @_arrayfield: field in @_state (of type '@_arraytype *') which
+ * @_arrayfield: field in @_state (of type ``_arraytype *``) which
  *               will point to the array
- * @_arrayprop: PropertyInfo defining what property the array elements have
+ * @_arrayprop: #PropertyInfo variable defining property type of
+ *              array elements
  * @_arraytype: C type of the array elements
  *
  * Define device properties for a variable-length array _name.  A
@@ -171,36 +206,137 @@ extern const PropertyInfo prop_info_link;
                 .arrayfieldsize = sizeof(_arraytype),          \
                 .arrayoffset = offsetof(_state, _arrayfield))
 
+/**
+ * DEFINE_PROP_LINK: Define object link property
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of field in @_state holding the property value
+ * @_type: QOM type name of link target
+ * @_ptr_type: Type of field @_field in struct @_state
+ */
 #define DEFINE_PROP_LINK(_name, _state, _field, _type, _ptr_type)     \
     DEFINE_PROP(_name, _state, _field, prop_info_link, _ptr_type,     \
                 .link_type  = _type)
 
+/**
+ * DEFINE_PROP_UINT8: Define uint8 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint8_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_UINT8(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint8, uint8_t)
+/**
+ * DEFINE_PROP_UINT16: Define uint16 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint16_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_UINT16(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint16, uint16_t)
+/**
+ * DEFINE_PROP_UINT32: Define uint32 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint32_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_UINT32(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint32, uint32_t)
+/**
+ * DEFINE_PROP_INT32: Define int32 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``int32_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_INT32(_n, _s, _f, _d)                      \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int32, int32_t)
+/**
+ * DEFINE_PROP_UINT64: Define uint64 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint64_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_UINT64(_n, _s, _f, _d)                      \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_uint64, uint64_t)
+/**
+ * DEFINE_PROP_INT64: Define int64 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``int64_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_INT64(_n, _s, _f, _d)                      \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_int64, int64_t)
+/**
+ * DEFINE_PROP_SIZE: Define uint64 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint64_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_SIZE(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size, uint64_t)
+/**
+ * DEFINE_PROP_STRING:
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``char *`` field in @_state
+ */
 #define DEFINE_PROP_STRING(_n, _s, _f)             \
     DEFINE_PROP(_n, _s, _f, prop_info_string, char*)
+/**
+ * DEFINE_PROP_ON_OFF_AUTO: Define OnOffAuto property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``OnOffAuto`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_ON_OFF_AUTO(_n, _s, _f, _d) \
     DEFINE_PROP_SIGNED(_n, _s, _f, _d, prop_info_on_off_auto, OnOffAuto)
+/**
+ * DEFINE_PROP_SIZE32: Define uint32 property
+ * @_n: name of the property
+ * @_s: name of the object state structure type
+ * @_f: name of ``uint32_t`` field in @_s
+ * @_d: default value of property
+ */
 #define DEFINE_PROP_SIZE32(_n, _s, _f, _d)                       \
     DEFINE_PROP_UNSIGNED(_n, _s, _f, _d, prop_info_size32, uint32_t)
+/**
+ * DEFINE_PROP_UUID: Define UUID property
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of field in @_state holding the property value
+ *
+ * The @_f field in struct @_s must be of type ``QemuUUID``.
+ * The default value of the property will be "auto".
+ */
 #define DEFINE_PROP_UUID(_name, _state, _field)                      \
     DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID,     \
                 .set_default = true)
+/**
+ * DEFINE_PROP_UUID_NODEFAULT: Define UUID property with no default
+ * @_name: name of the property
+ * @_state: name of the object state structure type
+ * @_field: name of field in @_state holding the property value
+ *
+ * The @_f field in struct @_s must be of type ``QemuUUID``.
+ * No default value will be set for the property.
+ */
 #define DEFINE_PROP_UUID_NODEFAULT(_name, _state, _field) \
     DEFINE_PROP(_name, _state, _field, prop_info_uuid, QemuUUID)
 
+/**
+ * DEFINE_PROP_END_OF_LIST: Mark end of property array
+ *
+ * This must be the last entry in #Property arrays when calling
+ * object_class_add_static_props().
+ */
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
-- 
2.28.0


