Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0215C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:17:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E966D2064C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rgc61S1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E966D2064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLTY-0007T8-Pd
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:17:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42780)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFg-0003WJ-Ap
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31164)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaLFY-0005hF-G0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:03:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604505783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rXOWGCGA+d/hfJcc31DXpxSizWnehmyAJE5US4GBeJA=;
 b=Rgc61S1siCbs5z34/XrjbyOeyREBEeDhrnz6N8xnC+BvEef0KhgaC+rGVzIzVGYRBzhlsV
 Al01w6nn8MSRo9eH0FbOGdf/cnv2MMLzPvWg3AyppuAdq7s1C4IYvd+1L+BjQWLglIUV/6
 rp5TnvO6ukDsf+tsk1SrxuX/cVlWEuc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-_dgPiV3mPBy6QfxjINt7TQ-1; Wed, 04 Nov 2020 11:03:01 -0500
X-MC-Unique: _dgPiV3mPBy6QfxjINt7TQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36D1C1016D0C;
 Wed,  4 Nov 2020 16:02:40 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE8504DA3D;
 Wed,  4 Nov 2020 16:02:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 42/44] qom: Include static property API reference in
 documentation
Date: Wed,  4 Nov 2020 11:00:19 -0500
Message-Id: <20201104160021.2342108-43-ehabkost@redhat.com>
In-Reply-To: <20201104160021.2342108-1-ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add new doc comments and reformat the existing ones,
and include the static-properties.h API reference in
docs/devel/qom.rst.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* Redone patch after changes in previous patches in the series
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 docs/devel/qom.rst           |  17 +++++-
 include/qom/field-property.h |  47 ++++++++++++---
 include/qom/property-types.h | 111 ++++++++++++++++++++++++++++++++++-
 3 files changed, 165 insertions(+), 10 deletions(-)

diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 42d0dc4f4d..9e43aa46f2 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -376,6 +376,21 @@ the OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used instead:
 
 
 API Reference
--------------
+=============
+
+Core QOM API Reference
+----------------------
 
 .. kernel-doc:: include/qom/object.h
+
+
+Field Property API Reference
+----------------------------
+
+.. kernel-doc:: include/qom/field-property.h
+
+
+Property Types Reference
+------------------------
+
+.. kernel-doc:: include/qom/property-types.h
diff --git a/include/qom/field-property.h b/include/qom/field-property.h
index bdc89b38a6..bc866e1c93 100644
--- a/include/qom/field-property.h
+++ b/include/qom/field-property.h
@@ -8,15 +8,16 @@
 #include "qapi/util.h"
 
 /**
- * Property:
- * @set_default: true if the default value should be set from @defval,
- *    in which case @info->set_default_value must not be NULL
- *    (if false then no default value is set by the property system
- *     and the field retains whatever value it was given by instance_init).
- * @defval: default value for the property. This is used only if @set_default
- *     is true.
+ * struct Property: definition of a field property
+ *
+ * Field properties are used to read and write fields in object
+ * instance structs.  Field properties are declared using
+ * ``DEFINE_PROP_<type>`` (for property arrays registered using
+ * device_class_set_props()), or using ``PROP_<type>`` (for
+ * object_class_property_add_field() calls).
  */
 struct Property {
+    /* private: */
     /**
      * @qdev_prop_name: qdev property name
      *
@@ -28,27 +29,59 @@ struct Property {
     const PropertyInfo *info;
     ptrdiff_t    offset;
     uint8_t      bitnr;
+    /**
+     * @set_default: true if the default value should be set from @defval,
+     *    in which case @info->set_default_value must not be NULL
+     *    (if false then no default value is set by the property system
+     *     and the field retains whatever value it was given by instance_init).
+     */
     bool         set_default;
+    /**
+     * @defval: default value for the property. This is used only if @set_default
+     *     is true.
+     */
     union {
         int64_t i;
         uint64_t u;
     } defval;
+    /* private: */
     int          arrayoffset;
     const PropertyInfo *arrayinfo;
     int          arrayfieldsize;
     const char   *link_type;
 };
 
+/**
+ * struct PropertyInfo: information on a specific QOM property type
+ */
 struct PropertyInfo {
+    /** @name: property type name */
     const char *name;
+    /** @description: Description for help text */
     const char *description;
+    /** @enum_table: Used by field_prop_get_enum() and field_prop_set_enum() */
     const QEnumLookup *enum_table;
+    /** @print: String formatting function, for the human monitor */
     int (*print)(Object *obj, Property *prop, char *dest, size_t len);
+    /** @set_default_value: Callback for initializing the default value */
     void (*set_default_value)(ObjectProperty *op, const Property *prop);
+    /** @create: Optional callback for creation of property */
     ObjectProperty *(*create)(ObjectClass *oc, const char *name,
                               Property *prop);
+    /**
+     * @get: Property getter.  The opaque parameter will point to
+     *        the &Property struct for the property.
+     */
     ObjectPropertyAccessor *get;
+    /**
+     * @set: Property setter.  The opaque parameter will point to
+     *        the &Property struct for the property.
+     */
     ObjectPropertyAccessor *set;
+    /**
+     * @release: Optional release function, called when the object
+     * is destroyed
+     */
     ObjectPropertyRelease *release;
 };
 
diff --git a/include/qom/property-types.h b/include/qom/property-types.h
index 75f758e835..a891dffb6e 100644
--- a/include/qom/property-types.h
+++ b/include/qom/property-types.h
@@ -39,6 +39,14 @@ extern const PropertyInfo prop_info_link;
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
@@ -53,12 +61,27 @@ extern const PropertyInfo prop_info_link;
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
@@ -71,9 +94,10 @@ extern const PropertyInfo prop_info_link;
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
@@ -100,31 +124,114 @@ extern const PropertyInfo prop_info_link;
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
+ * DEFINE_PROP_END_OF_LIST: Mark end of property array
+ *
+ * This must be the last entry in #Property arrays when calling
+ * object_class_add_static_props().
+ */
 #define DEFINE_PROP_END_OF_LIST()               \
     {}
 
-- 
2.28.0


