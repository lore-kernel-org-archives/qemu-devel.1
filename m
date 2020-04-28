Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E24C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7418F20BED
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 19:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILMdzVFb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7418F20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTW9Z-0007xG-J4
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 15:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7Z-0005dv-Lr
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTW7Y-0006sg-NA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25344
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTW7Y-0006sC-8L
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 15:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588102939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZznPfOzrDLzLrIvwsRJ50QCk3D2FtsvBi3yPYnpJWI=;
 b=ILMdzVFbFFz1tLAYcZUu9YutdrmOKB+irlamkvpJrhZK1F8jfKNmCrCDZaN9rtuA36zGyh
 EYFfAjYs7KvSM1ASgmqpBnsYg9JUpk/sURGeLYtBKPdUWkVhhfB8c+LeHJ3vKMOOpp5mLL
 msmueoy1v6krk85XGShNHq4rK9AV6Ok=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-1atRpVX6P_a6HtK8DEG1bw-1; Tue, 28 Apr 2020 15:42:17 -0400
X-MC-Unique: 1atRpVX6P_a6HtK8DEG1bw-1
Received: by mail-qk1-f197.google.com with SMTP id a187so24442856qkg.18
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 12:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j8HZaXRpKqMlGVGZxC3vqXUpalYaLscomhn30S95wLk=;
 b=P/1s0lFUkr8CoxNx0Y6L99jAeN90VrGhSwcdE3zLTyIlUaPZwM8YqL6AokuBtf/8FP
 Tm8CldPLAnsTeMNbLWqmbn+AGb/ILXddVKLcQq/qOS6BG7lBk8N+GqjMrAO68nA4PWLW
 HS9bqPS1L55UqZ4Nmz+w7vLMDyGJYB16tN2cg1k2U7pCHZqTS7w5nuTWqcMaYzEFmBIx
 HMCslOHE0m7yNEbR4OsTyukl+Kq4oBGZ9KDG7rt6Emx5+S+0Y7YAqb7qJU1negGK5Bv1
 CZirs9IaVYujEAVa14l8QHiqRE7eyh1giue3R10jW9uTUxglo70N5Byz8HIhRm5IQgeJ
 xFdQ==
X-Gm-Message-State: AGi0PuZ9/GmiSm/qhJxKdI95jvu2HNlTvDdXa0UaYwZHUPsIL4zVNUVy
 mxd9uV7ZS1/sqCZvzgC8Gd4cQr937ho8hf5mHL28jKUR3qk6+4aygQoNRkomizwV3KRG4ymk0ct
 2t0ti3WMI6oggKOw=
X-Received: by 2002:a37:6191:: with SMTP id
 v139mr26818554qkb.469.1588102937155; 
 Tue, 28 Apr 2020 12:42:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/1TuGLJnOpmLJPszo7iUOvTCnD2YASytQt0QUljLXX9AwU7HLc9zbNuiEIxKXBh/R6yzZRQ==
X-Received: by 2002:a37:6191:: with SMTP id
 v139mr26818522qkb.469.1588102936904; 
 Tue, 28 Apr 2020 12:42:16 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id j92sm14275237qtd.58.2020.04.28.12.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 12:42:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RFC 1/4] migration: Export migration_bitmap_sync_precopy()
Date: Tue, 28 Apr 2020 15:42:16 -0400
Message-Id: <20200428194219.10963-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200428194219.10963-1-peterx@redhat.com>
References: <20200428194219.10963-1-peterx@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tian Kevin <kevin.tian@intel.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make it usable outside migration.  To make it easier to use, remove the
RAMState parameter since after all ram.c has the reference of ram_state
directly from its context.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/ram.c          | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index d2762257aa..e338be8c30 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -66,6 +66,7 @@ void remove_migration_state_change_notifier(Notifier *not=
ify);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
+void migration_bitmap_sync_precopy(void);
 /* ...and after the device transmission */
 bool migration_in_postcopy_after_devices(MigrationState *);
 void migration_global_dump(Monitor *mon);
diff --git a/migration/ram.c b/migration/ram.c
index 04f13feb2e..d737175d4e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -970,7 +970,7 @@ static void migration_bitmap_sync(RAMState *rs)
     }
 }
=20
-static void migration_bitmap_sync_precopy(RAMState *rs)
+void migration_bitmap_sync_precopy(void)
 {
     Error *local_err =3D NULL;
=20
@@ -983,7 +983,7 @@ static void migration_bitmap_sync_precopy(RAMState *rs)
         local_err =3D NULL;
     }
=20
-    migration_bitmap_sync(rs);
+    migration_bitmap_sync(ram_state);
=20
     if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
         error_report_err(local_err);
@@ -2303,7 +2303,7 @@ static void ram_init_bitmaps(RAMState *rs)
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
         memory_global_dirty_log_start();
-        migration_bitmap_sync_precopy(rs);
+        migration_bitmap_sync_precopy();
     }
     qemu_mutex_unlock_ramlist();
     qemu_mutex_unlock_iothread();
@@ -2592,7 +2592,7 @@ static int ram_save_complete(QEMUFile *f, void *opaqu=
e)
=20
     WITH_RCU_READ_LOCK_GUARD() {
         if (!migration_in_postcopy()) {
-            migration_bitmap_sync_precopy(rs);
+            migration_bitmap_sync_precopy();
         }
=20
         ram_control_before_iterate(f, RAM_CONTROL_FINISH);
@@ -2642,7 +2642,7 @@ static void ram_save_pending(QEMUFile *f, void *opaqu=
e, uint64_t max_size,
         remaining_size < max_size) {
         qemu_mutex_lock_iothread();
         WITH_RCU_READ_LOCK_GUARD() {
-            migration_bitmap_sync_precopy(rs);
+            migration_bitmap_sync_precopy();
         }
         qemu_mutex_unlock_iothread();
         remaining_size =3D rs->migration_dirty_pages * TARGET_PAGE_SIZE;
--=20
2.24.1


