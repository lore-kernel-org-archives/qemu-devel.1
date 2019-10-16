Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679F9ECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2512086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2512086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZ6v-0002aH-5u
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59388)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKZ4Z-0000pN-2D
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKZ4X-0004hi-LR
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41594)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKZ4X-0004hb-DV
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:29:57 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 769B3C053B34
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:29:55 +0000 (UTC)
Received: by mail-pl1-f200.google.com with SMTP id g20so13272467plj.15
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K5cy6JJY+zB2GpBFbTkVr/75+7PfK1teCD0nP9Cqyf4=;
 b=fM5aqNJ+ICy4Pedb5PZz+xyc5ntg2KFbRt4EXIBl1zAqESQDa82ozRqX7P+6V8iIZr
 jYCp8HytU1q90sF8mg8NyBnm4APctXhQmz/6wgxAh5ZplT/zNxEN1JKU6MVnC8IR76Vl
 TWIFnsn1bbBjlePTf43CnKxZaR63sMQBHTkEQgwrHtpzP/Szr3O1bkp5tbprdtndQLSM
 wkClELq/idxpEnCEu4OGjiMUN/LdLH2vG1pxwWSy8CVws/27DQFsWjWdJ6vygXgQ7dbI
 g0AGBdxSyU71lJAoR6QQZFrTNlkZ9yWAngknDmMGnX7TplKi1a3WPFj8diYmOd8FYeWl
 K+Pg==
X-Gm-Message-State: APjAAAWS6a1rHwSjBEmvDir02CRQCjy9WhAiHTha1c4QDJQ9kzw65xjW
 4zqzrBZ/RW2Rf9nQSToW5ZiTKQIsp4rPCt8lbkkM3fzpYZnsdU2nvuOTQS3abhwznqskJyxp0lj
 230On8Kfa2V8f8R0=
X-Received: by 2002:a62:5ec6:: with SMTP id
 s189mr41559756pfb.169.1571192994297; 
 Tue, 15 Oct 2019 19:29:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPfhT63lhjF4WZBKeGg7GND0dSlS5Nz15qwL/MFr7hzgwLu+ua+hCx1RERpERXGxL8BBrA0w==
X-Received: by 2002:a62:5ec6:: with SMTP id
 s189mr41559726pfb.169.1571192993983; 
 Tue, 15 Oct 2019 19:29:53 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm26175722pfp.38.2019.10.15.19.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 19:29:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] migration: Change SaveStateEntry.instance_id into
 uint32_t
Date: Wed, 16 Oct 2019 10:29:31 +0800
Message-Id: <20191016022933.7276-3-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191016022933.7276-1-peterx@redhat.com>
References: <20191016022933.7276-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was always used as 32bit, so define it as used to be clear.
Instead of using -1 as the auto-gen magic value, we switch to
UINT32_MAX.  We also make sure that we don't auto-gen this value to
avoid overflowed instance IDs without being noticed.

Suggested-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/intc/apic_common.c        |  2 +-
 include/migration/register.h |  2 +-
 include/migration/vmstate.h  |  6 +++---
 migration/savevm.c           | 18 ++++++++++--------
 stubs/vmstate.c              |  2 +-
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
index 22da53ce8a..fabfa7320b 100644
--- a/hw/intc/apic_common.c
+++ b/hw/intc/apic_common.c
@@ -315,7 +315,7 @@ static void apic_common_realize(DeviceState *dev, Err=
or **errp)
     APICCommonState *s =3D APIC_COMMON(dev);
     APICCommonClass *info;
     static DeviceState *vapic;
-    int instance_id =3D s->id;
+    uint32_t instance_id =3D s->id;
=20
     info =3D APIC_COMMON_GET_CLASS(s);
     info->realize(dev, errp);
diff --git a/include/migration/register.h b/include/migration/register.h
index a13359a08d..f3ba10b6ef 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -69,7 +69,7 @@ typedef struct SaveVMHandlers {
 } SaveVMHandlers;
=20
 int register_savevm_live(const char *idstr,
-                         int instance_id,
+                         uint32_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque);
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c551470299..67bc63e30e 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1113,17 +1113,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMSta=
teDescription *vmsd,
=20
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
-#define  VMSTATE_INSTANCE_ID_ANY  -1
+#define  VMSTATE_INSTANCE_ID_ANY  UINT32_MAX
=20
 /* Returns: 0 on success, -1 on failure */
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(DeviceState *dev, uint32_t instance_i=
d,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
                                    Error **errp);
=20
 /* Returns: 0 on success, -1 on failure */
-static inline int vmstate_register(DeviceState *dev, int instance_id,
+static inline int vmstate_register(DeviceState *dev, uint32_t instance_i=
d,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index 0074572a52..1e44f06d7a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -233,7 +233,7 @@ typedef struct CompatEntry {
 typedef struct SaveStateEntry {
     QTAILQ_ENTRY(SaveStateEntry) entry;
     char idstr[256];
-    int instance_id;
+    uint32_t instance_id;
     int alias_id;
     int version_id;
     /* version id read from the stream */
@@ -665,10 +665,10 @@ void dump_vmstate_json_to_file(FILE *out_file)
     fclose(out_file);
 }
=20
-static int calculate_new_instance_id(const char *idstr)
+static uint32_t calculate_new_instance_id(const char *idstr)
 {
     SaveStateEntry *se;
-    int instance_id =3D 0;
+    uint32_t instance_id =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (strcmp(idstr, se->idstr) =3D=3D 0
@@ -676,6 +676,8 @@ static int calculate_new_instance_id(const char *idst=
r)
             instance_id =3D se->instance_id + 1;
         }
     }
+    /* Make sure we never loop over without being noticed */
+    assert(instance_id !=3D VMSTATE_INSTANCE_ID_ANY);
     return instance_id;
 }
=20
@@ -730,7 +732,7 @@ static void savevm_state_handler_insert(SaveStateEntr=
y *nse)
    Meanwhile pass -1 as instance_id if you do not already have a clearly
    distinguishing id for all instances of your device class. */
 int register_savevm_live(const char *idstr,
-                         int instance_id,
+                         uint32_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque)
@@ -784,7 +786,7 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
     }
 }
=20
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(DeviceState *dev, uint32_t instance_i=
d,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
                                    int required_for_version,
@@ -1566,7 +1568,7 @@ int qemu_save_device_state(QEMUFile *f)
     return qemu_file_get_error(f);
 }
=20
-static SaveStateEntry *find_se(const char *idstr, int instance_id)
+static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
 {
     SaveStateEntry *se;
=20
@@ -2235,7 +2237,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, Migrati=
onIncomingState *mis)
     /* Find savevm section */
     se =3D find_se(idstr, instance_id);
     if (se =3D=3D NULL) {
-        error_report("Unknown savevm section or instance '%s' %d. "
+        error_report("Unknown savevm section or instance '%s' %"PRIu32".=
 "
                      "Make sure that your current VM setup matches your =
"
                      "saved VM setup, including any hotplugged devices",
                      idstr, instance_id);
@@ -2259,7 +2261,7 @@ qemu_loadvm_section_start_full(QEMUFile *f, Migrati=
onIncomingState *mis)
=20
     ret =3D vmstate_load(f, se);
     if (ret < 0) {
-        error_report("error while loading state for instance 0x%x of"
+        error_report("error while loading state for instance 0x%"PRIx32"=
 of"
                      " device '%s'", instance_id, idstr);
         return ret;
     }
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index e1e89b87f0..4ed5cc6e9e 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -4,7 +4,7 @@
 const VMStateDescription vmstate_dummy =3D {};
=20
 int vmstate_register_with_alias_id(DeviceState *dev,
-                                   int instance_id,
+                                   uint32_t instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
--=20
2.21.0


