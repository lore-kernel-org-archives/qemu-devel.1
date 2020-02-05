Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27F9C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EEB321741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z25WADoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEB321741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izLWU-00031P-ML
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 09:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1izLVD-0001Mh-Ik
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1izLVC-00048Q-95
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1izLVC-00045v-4I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 09:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580912281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y8fsBRwMolg42syNt6jxBKLMK101VeBYIo5tMXgljYk=;
 b=Z25WADoaKfxvXw0VJMwgSJjtIV1TMI3hgodWZQw81FXGUo0+pRIXbWeDGpPuSfSrucgqR6
 icO8DFlanA/BX9gxROYWrlH/OHKGiGNtmkBX5jn5foWYPXG1xHNSpRQWj9PX7bARiD1+tS
 sf+3t9G9r9DZowRr9nNIRll2OGzgLDw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-btPD_UBINaKLfnQhYu0_BA-1; Wed, 05 Feb 2020 09:18:00 -0500
Received: by mail-qt1-f199.google.com with SMTP id c10so1391257qtk.18
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 06:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZwCAJ7+Bi8HYROxL4ZxVz+2gGyWK5YxztwwQiXiRp10=;
 b=cQfiDbwd2opPtnKqJUFOvOuVR7vCZbyfV2w0wUgB6Dqx2u3POPjjr0FWo6yH1hJ6Bs
 EdEl+ui5r4/nHWGtp++T8/8gy3v6yuz4IjTg8t/4v54EVH4j3vA+Iz1MnJUKDQMu7gu9
 KSaWrilqKcS8BUIUR3DdVk7lrCcv7NaZEUV3H7Uzapre02GR5cLNko4TygsamunFjUtU
 utr2YfoFUzZw5vhRf/OZq0Dez7TbS2X7rMB8l2TPijDADJn5XJHQ2/iLmRizZEYSYtQw
 hVILc4xXyfqQSLu9hPHeP9Xe7UgzPy86jhaBJ3TVC5oe4BznGNmdUaP9eFI4V37n2QhK
 j/0Q==
X-Gm-Message-State: APjAAAVQ+7Y8Wai8GZegvrXnjLq1BT5TQCikiviRbl00vsAQqF8ZMESr
 Ju+Ugkp4jqFZaie5orLj/JNO7lJMFpsTr1wUfnoC/mCapTzeth3DdDE3d4q/1mnnBHvW7NSZa4S
 sS8Nlcl0VuFNuuZc=
X-Received: by 2002:a05:6214:10cb:: with SMTP id
 r11mr31379338qvs.59.1580912279561; 
 Wed, 05 Feb 2020 06:17:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxBvXZgeGjML3JG/YZe80kwx1+vFa9Qd7H9HJpqhLhYYNtCtw1qU4fgg7lOY0sE7yFPWT4KRw==
X-Received: by 2002:a05:6214:10cb:: with SMTP id
 r11mr31379314qvs.59.1580912279255; 
 Wed, 05 Feb 2020 06:17:59 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id q5sm12833489qkf.14.2020.02.05.06.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2020 06:17:58 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 3/9] memory: Introduce log_sync_global() to memory listener
Date: Wed,  5 Feb 2020 09:17:43 -0500
Message-Id: <20200205141749.378044-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205141749.378044-1-peterx@redhat.com>
References: <20200205141749.378044-1-peterx@redhat.com>
MIME-Version: 1.0
X-MC-Unique: btPD_UBINaKLfnQhYu0_BA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some of the memory listener may want to do log synchronization without
being able to specify a range of memory to sync but always globally.
Such a memory listener should provide this new method instead of the
log_sync() method.

Obviously we can also achieve similar thing when we put the global
sync logic into a log_sync() handler. However that's not efficient
enough because otherwise memory_global_dirty_log_sync() may do the
global sync N times, where N is the number of flat views.

Make this new method be exclusive to log_sync().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/memory.h | 12 ++++++++++++
 memory.c              | 33 +++++++++++++++++++++++----------
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index e85b7de99a..c4427094bb 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -533,6 +533,18 @@ struct MemoryListener {
      */
     void (*log_sync)(MemoryListener *listener, MemoryRegionSection *sectio=
n);
=20
+    /**
+     * @log_sync_global:
+     *
+     * This is the global version of @log_sync when the listener does
+     * not have a way to synchronize the log with finer granularity.
+     * When the listener registers with @log_sync_global defined, then
+     * its @log_sync must be NULL.  Vice versa.
+     *
+     * @listener: The #MemoryListener.
+     */
+    void (*log_sync_global)(MemoryListener *listener);
+
     /**
      * @log_clear:
      *
diff --git a/memory.c b/memory.c
index aeaa8dcc9e..53828ba00c 100644
--- a/memory.c
+++ b/memory.c
@@ -2016,6 +2016,10 @@ void memory_region_set_dirty(MemoryRegion *mr, hwadd=
r addr,
                                         memory_region_get_dirty_log_mask(m=
r));
 }
=20
+/*
+ * If memory region `mr' is NULL, do global sync.  Otherwise, sync
+ * dirty bitmap for the specified memory region.
+ */
 static void memory_region_sync_dirty_bitmap(MemoryRegion *mr)
 {
     MemoryListener *listener;
@@ -2029,18 +2033,24 @@ static void memory_region_sync_dirty_bitmap(MemoryR=
egion *mr)
      * address space once.
      */
     QTAILQ_FOREACH(listener, &memory_listeners, link) {
-        if (!listener->log_sync) {
-            continue;
-        }
-        as =3D listener->address_space;
-        view =3D address_space_get_flatview(as);
-        FOR_EACH_FLAT_RANGE(fr, view) {
-            if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
-                MemoryRegionSection mrs =3D section_from_flat_range(fr, vi=
ew);
-                listener->log_sync(listener, &mrs);
+        if (listener->log_sync) {
+            as =3D listener->address_space;
+            view =3D address_space_get_flatview(as);
+            FOR_EACH_FLAT_RANGE(fr, view) {
+                if (fr->dirty_log_mask && (!mr || fr->mr =3D=3D mr)) {
+                    MemoryRegionSection mrs =3D section_from_flat_range(fr=
, view);
+                    listener->log_sync(listener, &mrs);
+                }
             }
+            flatview_unref(view);
+        } else if (listener->log_sync_global) {
+            /*
+             * No matter whether MR is specified, what we can do here
+             * is to do a global sync, because we are not capable to
+             * sync in a finer granularity.
+             */
+            listener->log_sync_global(listener);
         }
-        flatview_unref(view);
     }
 }
=20
@@ -2727,6 +2737,9 @@ void memory_listener_register(MemoryListener *listene=
r, AddressSpace *as)
 {
     MemoryListener *other =3D NULL;
=20
+    /* Only one of them can be defined for a listener */
+    assert(!(listener->log_sync && listener->log_sync_global));
+
     listener->address_space =3D as;
     if (QTAILQ_EMPTY(&memory_listeners)
         || listener->priority >=3D QTAILQ_LAST(&memory_listeners)->priorit=
y) {
--=20
2.24.1


