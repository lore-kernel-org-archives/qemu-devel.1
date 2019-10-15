Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CBEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB5052089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB5052089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKHha-0003ib-3z
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 03:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKHfb-0001ho-31
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKHfZ-0005hN-RB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48076)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKHfZ-0005h3-Iy
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 03:55:01 -0400
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A25125313B
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:55:00 +0000 (UTC)
Received: by mail-pf1-f197.google.com with SMTP id r7so15352906pfg.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 00:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Prhq+elVYNderg0JL2udm40c7DMFWGn25Wjwjz4GK2c=;
 b=tFJW8n7gbP4AxuhaWzsMzFjq8AJpWKQDll5u7s8PGjzQ0bsk+pkdANLGD3WY0TbjxN
 Rygf9cXz/2dDoqFUd7ObZ/GeJbwhUeVnVgn2l3kBLXxuxwurvMwwZfhwqbN9Ft+P9JB7
 Qmm+mPcO8Q+iEFuWNvZ0v8JypnIAzbkcPcrjjKovvHmgVSbK99gQ8CveSotqunUClUTY
 uR/biaYgIWIMCKp5SFR5X1hDh+8JoBn/rwtEZmmzU9Ur8leB8plktGj5QFYwiKlhZC9L
 KtmqCQ3S+4DImrRqIddo+DzjL4maFBJ56aBzT/zJAraETCqzvm8ep0JVJqKMKoIZwaNT
 IgMA==
X-Gm-Message-State: APjAAAUUrmauxYx0XOMu2smKmYcKEMAkUgRTq6sUIvwez/OUHYM9ciNy
 pEQOz3OgcQzy0JBWS1aZ06Df9X3nxg+xmsVuRRJukheK7PGKFgnzupuADBrGBK9THauvwbgaokl
 04GAgZGfxtXkQx7E=
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr40658711pjq.96.1571126099652; 
 Tue, 15 Oct 2019 00:54:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKohrDHIiBy1fV/g+wU/ofwOOjwcZDoKQMEMzESTPKg8Zl3n/XjGr3U2g97PG5xPoyskcz+Q==
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr40658675pjq.96.1571126099130; 
 Tue, 15 Oct 2019 00:54:59 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id r30sm24599850pfl.42.2019.10.15.00.54.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 00:54:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] migration: Boost SaveStateEntry.instance_id to 64 bits
Date: Tue, 15 Oct 2019 15:54:43 +0800
Message-Id: <20191015075444.10955-2-peterx@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015075444.10955-1-peterx@redhat.com>
References: <20191015075444.10955-1-peterx@redhat.com>
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

It was "int" and used as 32bits fields (see save_section_header()).
It's unsafe already because sizeof(int) could be 2 on i386, I think.
So at least uint32_t would suite more.  While it also uses "-1" as a
placeholder of "we want to generate the instance ID automatically".
Hence a more proper value should be int64_t.

This will start to be useful after next patch in which we can start to
convert a real uint32_t value as instance ID.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/register.h |  2 +-
 include/migration/vmstate.h  |  4 ++--
 migration/savevm.c           | 10 +++++-----
 stubs/vmstate.c              |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index a13359a08d..54f42c7413 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -69,7 +69,7 @@ typedef struct SaveVMHandlers {
 } SaveVMHandlers;
=20
 int register_savevm_live(const char *idstr,
-                         int instance_id,
+                         int64_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque);
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1fbfd099dd..6a7498463c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1114,14 +1114,14 @@ int vmstate_save_state_v(QEMUFile *f, const VMSta=
teDescription *vmsd,
 bool vmstate_save_needed(const VMStateDescription *vmsd, void *opaque);
=20
 /* Returns: 0 on success, -1 on failure */
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(DeviceState *dev, int64_t instance_id=
,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
                                    Error **errp);
=20
 /* Returns: 0 on success, -1 on failure */
-static inline int vmstate_register(DeviceState *dev, int instance_id,
+static inline int vmstate_register(DeviceState *dev, int64_t instance_id=
,
                                    const VMStateDescription *vmsd,
                                    void *opaque)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index bb9462a54d..dc9281c897 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -233,7 +233,7 @@ typedef struct CompatEntry {
 typedef struct SaveStateEntry {
     QTAILQ_ENTRY(SaveStateEntry) entry;
     char idstr[256];
-    int instance_id;
+    int64_t instance_id;
     int alias_id;
     int version_id;
     /* version id read from the stream */
@@ -668,7 +668,7 @@ void dump_vmstate_json_to_file(FILE *out_file)
 static int calculate_new_instance_id(const char *idstr)
 {
     SaveStateEntry *se;
-    int instance_id =3D 0;
+    int64_t instance_id =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (strcmp(idstr, se->idstr) =3D=3D 0
@@ -730,7 +730,7 @@ static void savevm_state_handler_insert(SaveStateEntr=
y *nse)
    Meanwhile pass -1 as instance_id if you do not already have a clearly
    distinguishing id for all instances of your device class. */
 int register_savevm_live(const char *idstr,
-                         int instance_id,
+                         int64_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque)
@@ -784,7 +784,7 @@ void unregister_savevm(DeviceState *dev, const char *=
idstr, void *opaque)
     }
 }
=20
-int vmstate_register_with_alias_id(DeviceState *dev, int instance_id,
+int vmstate_register_with_alias_id(DeviceState *dev, int64_t instance_id=
,
                                    const VMStateDescription *vmsd,
                                    void *opaque, int alias_id,
                                    int required_for_version,
@@ -1566,7 +1566,7 @@ int qemu_save_device_state(QEMUFile *f)
     return qemu_file_get_error(f);
 }
=20
-static SaveStateEntry *find_se(const char *idstr, int instance_id)
+static SaveStateEntry *find_se(const char *idstr, int64_t instance_id)
 {
     SaveStateEntry *se;
=20
diff --git a/stubs/vmstate.c b/stubs/vmstate.c
index e1e89b87f0..699003f3b0 100644
--- a/stubs/vmstate.c
+++ b/stubs/vmstate.c
@@ -4,7 +4,7 @@
 const VMStateDescription vmstate_dummy =3D {};
=20
 int vmstate_register_with_alias_id(DeviceState *dev,
-                                   int instance_id,
+                                   int64_t instance_id,
                                    const VMStateDescription *vmsd,
                                    void *base, int alias_id,
                                    int required_for_version,
--=20
2.21.0


