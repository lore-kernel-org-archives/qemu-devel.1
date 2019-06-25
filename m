Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5030C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:42:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 946CA2133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 13:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="albDdkX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946CA2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60346 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfli8-00017f-Oj
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 09:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53857)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <renyime@gmail.com>) id 1hflLC-0001a4-5I
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <renyime@gmail.com>) id 1hflLB-0007M8-28
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:30 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <renyime@gmail.com>) id 1hflLA-0007LR-SV
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 09:18:28 -0400
Received: by mail-pl1-x642.google.com with SMTP id bi6so8836210plb.12
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=A81J0YiD0K6WO2Vr8c3+kOQFFeejvAujm62dKkKzNVc=;
 b=albDdkX2VHeP6fD7UKogZxaneBq/dkHH6G8juuo6/PPVqU6kSnJ9E6m69mcn/snHiX
 ZomoaUOKyQ166L1u6gN06ihqLln04+p5xxV+Ui7VSmPZGxq/Aw6gDmRBYdQZteVlYzNG
 bmqwJIGmBCFV0aiLEqXj2wzzUSGU1oIpkHIXIaClTWb9Vm73sktun9HlJ0Fpa1wObKKc
 fC7MLsiKdwN6BmhUvHm88oRzH09aiWzePft5Z1wIMigNRuGlUTCv71jX7p9tbIK+DFHv
 4n5RnmaMNTOnZJRfLSpgrHyN42T6cQcSkCpgeSD5/FHqnV+8e/Cs+H2hL/FQzmffyQAy
 PoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=A81J0YiD0K6WO2Vr8c3+kOQFFeejvAujm62dKkKzNVc=;
 b=hubraZnZfx0PI1Haj6rhdvt2yno4zRapBY0EiHpkh/X8t0PneP2L+O8qpkhZYz1PbR
 7AKK3/muTddSwNM1ifdUAhrWg2gP1dVdbeIZ9YtKB17XwDeaVjmMRUxC3EQzZ2TvFn9M
 +t0iT15IwE6qITCJO6NVPEDXjP7UZn+XN/TuAQcikj8x5iHIUvib9k5kKYZnMPGX897k
 0qchW1uTIm1sr+QkN6lCd8Y/qvP+9mxDmUBIwe01x5LK4CKOtoHXh/g5gGL1b7BpHMeM
 QRNkp9cR7Vm8A8lp3HRpN+zK5LzTBW0o1zWJCpnMyAKzl3jvHVuxXyuVk7tA3aP3C3ua
 KePQ==
X-Gm-Message-State: APjAAAWMo6QyRkfbujqA8HvTeYo3UecDk/P1+dRhZfEZdEQuq3WQAdU6
 ffoSLNi0RnKkPcb1gPvzr+A=
X-Google-Smtp-Source: APXvYqxe+D1q6wcnab+hGM7sC8LhWoJdM/h0w47bF3qyFPZJXAkZ2PgHdiGnR8iULQe7mMrdUbFoZA==
X-Received: by 2002:a17:902:7887:: with SMTP id
 q7mr69601418pll.129.1561468708054; 
 Tue, 25 Jun 2019 06:18:28 -0700 (PDT)
Received: from VM_64_241_centos.localdomain ([129.226.57.92])
 by smtp.gmail.com with ESMTPSA id f186sm15675814pfb.5.2019.06.25.06.18.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Jun 2019 06:18:27 -0700 (PDT)
From: Ivan Ren <renyime@gmail.com>
X-Google-Original-From: Ivan Ren <ivanren@tencent.com>
To: quintela@redhat.com,
	dgilbert@redhat.com
Date: Tue, 25 Jun 2019 21:18:18 +0800
Message-Id: <1561468699-9819-3-git-send-email-ivanren@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
References: <1561468699-9819-1-git-send-email-ivanren@tencent.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH 2/3] migration: fix migrate_cancel leads
 live_migration thread hung forever
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When we 'migrate_cancel' a multifd migration, live_migration thread may
hung forever at some points, because of multifd_send_thread has already
exit for socket error:
1. multifd_send_pages may hung at qemu_sem_wait(&multifd_send_state->
   channels_ready)
2. multifd_send_sync_main my hung at qemu_sem_wait(&multifd_send_state->
   sem_sync)

Signed-off-by: Ivan Ren <ivanren@tencent.com>
---
 migration/ram.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index f8908286c2..e4eb9c441f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1097,7 +1097,11 @@ static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p = opaque;
     Error *local_err = NULL;
-    int ret;
+    int ret = 0;
+
+    uint32_t used = 0;
+    uint64_t packet_num = 0;
+    uint32_t flags = 0;
 
     trace_multifd_send_thread_start(p->id);
     rcu_register_thread();
@@ -1113,9 +1117,9 @@ static void *multifd_send_thread(void *opaque)
         qemu_mutex_lock(&p->mutex);
 
         if (p->pending_job) {
-            uint32_t used = p->pages->used;
-            uint64_t packet_num = p->packet_num;
-            uint32_t flags = p->flags;
+            used = p->pages->used;
+            packet_num = p->packet_num;
+            flags = p->flags;
 
             p->next_packet_size = used * qemu_target_page_size();
             multifd_send_fill_packet(p);
@@ -1164,6 +1168,17 @@ out:
         multifd_send_terminate_threads(local_err);
     }
 
+    /*
+     * Error happen, I will exit, but I can't just leave, tell
+     * who pay attention to me.
+     */
+    if (ret != 0) {
+        if (flags & MULTIFD_FLAG_SYNC) {
+            qemu_sem_post(&multifd_send_state->sem_sync);
+        }
+        qemu_sem_post(&multifd_send_state->channels_ready);
+    }
+
     qemu_mutex_lock(&p->mutex);
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
-- 
2.17.2 (Apple Git-113)


