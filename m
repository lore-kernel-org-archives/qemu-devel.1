Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D93DC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:39:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03C5D20856
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 05:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C5D20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Hp8-0005Dr-C6
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 01:39:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56543)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hmu-0003Vg-TZ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1i8Hms-0002wg-QC
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:37:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:18593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1i8Hmq-0002tG-S6
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 01:36:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Sep 2019 22:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,495,1559545200"; d="scan'208";a="186030758"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga007.fm.intel.com with ESMTP; 11 Sep 2019 22:36:47 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Date: Thu, 12 Sep 2019 13:36:30 +0800
Message-Id: <20190912053638.4858-4-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190912053638.4858-1-tao3.xu@intel.com>
References: <20190912053638.4858-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v11 03/11] qapi: Add builtin type time
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, jonathan.cameron@huawei.com, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add optional builtin type time, fallback is uint64. This type use
qemu_strtotime_ps() for pre-converting time suffix to numbers.

Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v11.

New patch in v10.
---
 include/qapi/visitor-impl.h  |  4 ++++
 include/qapi/visitor.h       |  9 +++++++++
 qapi/opts-visitor.c          | 22 ++++++++++++++++++++++
 qapi/qapi-visit-core.c       | 12 ++++++++++++
 qapi/qobject-input-visitor.c | 18 ++++++++++++++++++
 qapi/trace-events            |  1 +
 scripts/qapi/common.py       |  2 ++
 7 files changed, 68 insertions(+)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 8ccb3b6c20..e0979563c7 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -88,6 +88,10 @@ struct Visitor
     void (*type_size)(Visitor *v, const char *name, uint64_t *obj,
                       Error **errp);
 
+    /* Optional; fallback is type_uint64() */
+    void (*type_time)(Visitor *v, const char *name, uint64_t *obj,
+                      Error **errp);
+
     /* Must be set */
     void (*type_bool)(Visitor *v, const char *name, bool *obj, Error **errp);
 
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 5b2ed3f202..4c3198b1c5 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -554,6 +554,15 @@ void visit_type_int64(Visitor *v, const char *name, int64_t *obj,
 void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
                      Error **errp);
 
+/*
+ * Visit a uint64_t value.
+ * Like visit_type_uint64(), except that some visitors may choose to
+ * recognize numbers with timeunit suffix, such as "ps", "ns", "us"
+ * "ms" and "s".
+ */
+void visit_type_time(Visitor *v, const char *name, uint64_t *obj,
+                     Error **errp);
+
 /*
  * Visit a boolean value.
  *
diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 324b197495..d73b2e51a0 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -508,6 +508,27 @@ opts_type_size(Visitor *v, const char *name, uint64_t *obj, Error **errp)
     processed(ov, name);
 }
 
+static void
+opts_type_time(Visitor *v, const char *name, uint64_t *obj, Error **errp)
+{
+    OptsVisitor *ov = to_ov(v);
+    const QemuOpt *opt;
+    int err;
+
+    opt = lookup_scalar(ov, name, errp);
+    if (!opt) {
+        return;
+    }
+
+    err = qemu_strtotime_ps(opt->str ? opt->str : "", NULL, obj);
+    if (err < 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, opt->name,
+                   "a time value");
+        return;
+    }
+
+    processed(ov, name);
+}
 
 static void
 opts_optional(Visitor *v, const char *name, bool *present)
@@ -555,6 +576,7 @@ opts_visitor_new(const QemuOpts *opts)
     ov->visitor.type_int64  = &opts_type_int64;
     ov->visitor.type_uint64 = &opts_type_uint64;
     ov->visitor.type_size   = &opts_type_size;
+    ov->visitor.type_time   = &opts_type_time;
     ov->visitor.type_bool   = &opts_type_bool;
     ov->visitor.type_str    = &opts_type_str;
 
diff --git a/qapi/qapi-visit-core.c b/qapi/qapi-visit-core.c
index 5365561b07..ac8896455c 100644
--- a/qapi/qapi-visit-core.c
+++ b/qapi/qapi-visit-core.c
@@ -277,6 +277,18 @@ void visit_type_size(Visitor *v, const char *name, uint64_t *obj,
     }
 }
 
+void visit_type_time(Visitor *v, const char *name, uint64_t *obj,
+                     Error **errp)
+{
+    assert(obj);
+    trace_visit_type_time(v, name, obj);
+    if (v->type_time) {
+        v->type_time(v, name, obj, errp);
+    } else {
+        v->type_uint64(v, name, obj, errp);
+    }
+}
+
 void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp)
 {
     assert(obj);
diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 32236cbcb1..9b66941d8a 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -627,6 +627,23 @@ static void qobject_input_type_size_keyval(Visitor *v, const char *name,
     }
 }
 
+static void qobject_input_type_time_keyval(Visitor *v, const char *name,
+                                           uint64_t *obj, Error **errp)
+{
+    QObjectInputVisitor *qiv = to_qiv(v);
+    const char *str = qobject_input_get_keyval(qiv, name, errp);
+
+    if (!str) {
+        return;
+    }
+
+    if (qemu_strtotime_ps(str, NULL, obj) < 0) {
+        /* TODO report -ERANGE more nicely */
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
+                   full_name(qiv, name), "time");
+    }
+}
+
 static void qobject_input_optional(Visitor *v, const char *name, bool *present)
 {
     QObjectInputVisitor *qiv = to_qiv(v);
@@ -708,6 +725,7 @@ Visitor *qobject_input_visitor_new_keyval(QObject *obj)
     v->visitor.type_any = qobject_input_type_any;
     v->visitor.type_null = qobject_input_type_null;
     v->visitor.type_size = qobject_input_type_size_keyval;
+    v->visitor.type_time = qobject_input_type_time_keyval;
     v->keyval = true;
 
     return &v->visitor;
diff --git a/qapi/trace-events b/qapi/trace-events
index 5eb4afa110..c4605a7ccc 100644
--- a/qapi/trace-events
+++ b/qapi/trace-events
@@ -29,6 +29,7 @@ visit_type_int16(void *v, const char *name, int16_t *obj) "v=%p name=%s obj=%p"
 visit_type_int32(void *v, const char *name, int32_t *obj) "v=%p name=%s obj=%p"
 visit_type_int64(void *v, const char *name, int64_t *obj) "v=%p name=%s obj=%p"
 visit_type_size(void *v, const char *name, uint64_t *obj) "v=%p name=%s obj=%p"
+visit_type_time(void *v, const char *name, uint64_t *obj) "v=%p name=%s obj=%p"
 visit_type_bool(void *v, const char *name, bool *obj) "v=%p name=%s obj=%p"
 visit_type_str(void *v, const char *name, char **obj) "v=%p name=%s obj=%p"
 visit_type_number(void *v, const char *name, void *obj) "v=%p name=%s obj=%p"
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d61bfdc526..3a6f108794 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -35,6 +35,7 @@ builtin_types = {
     'uint32':   'QTYPE_QNUM',
     'uint64':   'QTYPE_QNUM',
     'size':     'QTYPE_QNUM',
+    'time':     'QTYPE_QNUM',
     'any':      None,           # any QType possible, actually
     'QType':    'QTYPE_QSTRING',
 }
@@ -1834,6 +1835,7 @@ class QAPISchema(object):
                   ('uint32', 'int',     'uint32_t'),
                   ('uint64', 'int',     'uint64_t'),
                   ('size',   'int',     'uint64_t'),
+                  ('time',   'int',     'uint64_t'),
                   ('bool',   'boolean', 'bool'),
                   ('any',    'value',   'QObject' + pointer_suffix),
                   ('null',   'null',    'QNull' + pointer_suffix)]:
-- 
2.20.1


