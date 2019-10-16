Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAEAECE58F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:35:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE22B2086A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 02:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE22B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKZ9Q-0005ZO-Pv
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 22:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKZ4f-0000yt-Hm
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKZ4e-0004kj-DM
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKZ4e-0004kb-4w
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 22:30:04 -0400
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5F44E2A09AE
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 02:30:03 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id 194so17518956pfu.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 19:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=7bd+lVFSE5RnEgJZXIACTVDkbxanzqoTb19QHbkBI5s=;
 b=mqs0iMiKIPQF2+Xhv8GIerVyJjeg+8MkMu08cgo+uq/CH/r5sKUVJKy9gbtipFqcT1
 cdXGzrYddig0BXIkiaKp77DNJcUbhC2YhQqKea7aTqV+cp/QmhMP2ZAbLrvog8qgwDk/
 pBQbs3fZ5Jzsj0KisOf5bC9PvgMBQ0hfgtZNKtSpgx/hf1airoE82us7vlnqQxZ2TNdk
 ld6Z9BLBGpbgAqFUnQvicpcyCenVxGMhMsLFWoHrV55DTH4tQUqwKDRF/Y8CT3iQm3xv
 UvA9Wgvc3ltx9YROqee1/O4FiGP48NHUseej8oR0TGcpobxgcPYZBcr74Z7kXWtE+C6z
 R6BA==
X-Gm-Message-State: APjAAAU0NqGaSxNrb4yXOKyvkxXnuQAcG/dTxTJIZXHBYLMxvKoGzepx
 cQpa3iJ+w9iG8P+0ka/imQ1a+1a2/V2hjSgBBIvNDCOj75r8SN82rG7nhtr5P4QzJgdkV0pLwkx
 Bewik0Dm0oy3r800=
X-Received: by 2002:a17:90b:288:: with SMTP id
 az8mr1980584pjb.18.1571193002355; 
 Tue, 15 Oct 2019 19:30:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdkpSdsV62EU9GADl1SOVDSbmhziF/4LpFB6fp9yUchi9Ia/Pd3Yfewl5GU9xHcClA3ln5Uw==
X-Received: by 2002:a17:90b:288:: with SMTP id
 az8mr1980563pjb.18.1571193002133; 
 Tue, 15 Oct 2019 19:30:02 -0700 (PDT)
Received: from xz-x1.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id b5sm26175722pfp.38.2019.10.15.19.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 19:30:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/4] migration: Check in savevm_state_handler_insert for
 dups
Date: Wed, 16 Oct 2019 10:29:33 +0800
Message-Id: <20191016022933.7276-5-peterx@redhat.com>
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

Before finally register one SaveStateEntry, we detect for duplicated
entries.  This could be helpful to notify us asap instead of get
silent migration failures which could be hard to diagnose.

For example, this patch will generate a message like this (if without
previous fixes on x2apic) as long as we wants to boot a VM instance
with "-smp 200,maxcpus=3D288,sockets=3D2,cores=3D72,threads=3D2" and QEMU=
 will
bail out even before VM starts:

savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=3Dapic=
, instance_id=3D0x0

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 1e44f06d7a..83e91ddafa 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -264,6 +264,8 @@ static SaveState savevm_state =3D {
     .global_section_id =3D 0,
 };
=20
+static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
+
 static bool should_validate_capability(int capability)
 {
     assert(capability >=3D 0 && capability < MIGRATION_CAPABILITY__MAX);
@@ -714,6 +716,18 @@ static void savevm_state_handler_insert(SaveStateEnt=
ry *nse)
=20
     assert(priority <=3D MIG_PRI_MAX);
=20
+    /*
+     * This should never happen otherwise migration will probably fail
+     * silently somewhere because we can be wrongly applying one
+     * object properties upon another one.  Bail out ASAP.
+     */
+    if (find_se(nse->idstr, nse->instance_id)) {
+        error_report("%s: Detected duplicate SaveStateEntry: "
+                     "id=3D%s, instance_id=3D0x%"PRIx32, __func__,
+                     nse->idstr, nse->instance_id);
+        exit(EXIT_FAILURE);
+    }
+
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (save_state_priority(se) < priority) {
             break;
--=20
2.21.0


