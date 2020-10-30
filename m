Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C009C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:54:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B9E32071A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGcdMajj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B9E32071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUrY-0002IR-H1
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYUqx-0001sO-BO
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kYUqv-00053G-0K
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 09:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604066039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w1sNFlKeFv+R7z4swC+EwUcPCyoErZNczC3y42HB3Z4=;
 b=KGcdMajj/klPC+hbmOAnWRUA58NZZPLbCWyFFY0GE412PefEH3pLYCfRgekSaIDZYP+eID
 9iaORgW9escec4gCynZwJlPllcjydCa/dLHdHp36vL29rg1y+NdxLIFf9Scc+cfNHSxfFj
 1gZQ5nrhcN2xmo6CjGM4AFSFrBnHals=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-HAtDWylSN2aV-oBrlxVRzw-1; Fri, 30 Oct 2020 09:53:53 -0400
X-MC-Unique: HAtDWylSN2aV-oBrlxVRzw-1
Received: by mail-qk1-f200.google.com with SMTP id f9so3921829qkg.13
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 06:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JiKrxgqmW3caL3S6bXXo6Cc/ACTFApk18fbx/I5VCwQ=;
 b=lTsblQAMSFeQLELv7KdsE56Ko++HT7U/9vPsDw+5Thp9k5PwOrPN2BgOajztw18+iD
 mJnJBNbV4TyigxQcHkvz1pwnBtpzeX5t7MxK4SIVGBCe7/ISG7u/s1V4EUdLbSEutOYg
 b2z9lMlKiyQMou//T9jup697wVmdniVCPwYD5RCD6gawb4CnrFMQe+rcny9jWYvNH1T8
 P2td7goLP7UkIpXfWps2U5udmLyVx/MDNapcw9ndkoEVqwgQ5mAslJ9sSF/B3QkdGdIB
 YM++r+FEwwlaWPFdIBPtlftBenmTWuR160esa210QN3odyLpkfoceD1deoARD7Wmbpq5
 OH2w==
X-Gm-Message-State: AOAM532wI1nASGWaV2ow5eTgSeo3x6lFMCEC7obAjQSQPYt7ejl5fFUI
 AJWqFeRDoXmLN5pQt5wyDk9XyIZERyZzmTSxF3nclqm41DoCMceuFocz0b6Irb2dbflwQXzEEbR
 zwAmHmUzT8+0JLS0=
X-Received: by 2002:a05:622a:4b:: with SMTP id
 y11mr2225182qtw.348.1604066032557; 
 Fri, 30 Oct 2020 06:53:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi2o/B3gzkFNRTpqKxNjMxtcGORxG9e0yk0CW8gfDxSHL9qA2SJyy5yjvfs6CNukOIE6fkJg==
X-Received: by 2002:a05:622a:4b:: with SMTP id
 y11mr2225154qtw.348.1604066032217; 
 Fri, 30 Oct 2020 06:53:52 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id k4sm2576696qkj.46.2020.10.30.06.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 06:53:51 -0700 (PDT)
Date: Fri, 30 Oct 2020 09:53:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: recent flakiness (intermittent hangs) of migration-test
Message-ID: <20201030135350.GA588069@xz-x1>
References: <CAFEAcA-EsEZWDbUSy6_AXym5e-wP_B4buZYG0swF946ue41WKg@mail.gmail.com>
 <20201029174124.GD3335@work-vm>
 <CAFEAcA9ex69Ov=hfb4LUQak=_bnwQc8mjUx4MgEwgSciD8Ut+A@mail.gmail.com>
 <20201029193433.GE3335@work-vm> <20201029202810.GD455015@xz-x1>
 <CAFEAcA_ZEHHdKO+82G_e16uZkSbtH-Rjn701Nc0e7pOfk3OUoA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_ZEHHdKO+82G_e16uZkSbtH-Rjn701Nc0e7pOfk3OUoA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Fri, Oct 30, 2020 at 11:48:28AM +0000, Peter Maydell wrote:
> > Peter, is it possible that you enable QTEST_LOG=1 in your future migration-test
> > testcase and try to capture the stderr?  With the help of commit a47295014d
> > ("migration-test: Only hide error if !QTEST_LOG", 2020-10-26), the test should
> > be able to dump quite some helpful information to further identify the issue.
> 
> Here's the result of running just the migration test with
> QTEST_LOG=1:
> https://people.linaro.org/~peter.maydell/migration.log
> It's 300MB because when the test hangs one of the processes
> is apparently in a polling state and continues to send status
> queries.
> 
> My impression is that the test is OK on an unloaded machine but
> more likely to fail if the box is doing other things at the
> same time. Alternatively it might be a 'parallel make check' bug.

Thanks for collecting that, Peter.

I'm copy-pasting the important information out here (with some moves and
indents to make things even clearer):

...
{"execute": "migrate-recover", "arguments": {"uri": "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}, "id": "recover-cmd"}
{"timestamp": {"seconds": 1604056292, "microseconds": 177955}, "event": "MIGRATION", "data": {"status": "setup"}}
{"return": {}, "id": "recover-cmd"}
{"execute": "query-migrate"}
...
{"execute": "migrate", "arguments": {"resume": true, "uri": "unix:/tmp/migration-test-nGzu4q/migsocket-recover"}}
qemu-system-x86_64: ram_save_queue_pages no previous block
qemu-system-x86_64: Detected IO failure for postcopy. Migration paused.
{"return": {}}
{"execute": "migrate-set-parameters", "arguments": {"max-postcopy-bandwidth": 0}}
...

The problem is probably an misuse on last_rb on destination node.  When looking
at it, I also found a race.  So I guess I should fix both...

Peter, would it be easy to try apply the two patches I attached to see whether
the test hang would be resolved?  Dave, feel free to give early comments too on
the two fixes before I post them on the list.

Thanks!

-- 
Peter Xu

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-migration-Unify-reset-of-last_rb-on-destination-node.patch"

From b9af559df89ae9c2eed506ebdd811356ea799f63 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Oct 2020 09:37:44 -0400
Subject: [PATCH 1/2] migration: Unify reset of last_rb on destination node
 when recover

When postcopy recover happens, we need to reset last_rb after each return of
postcopy_pause_fault_thread() because that means we just got the postcopy
migration continued.

Unify this reset to the place right before we want to kick the fault thread
again, when we get the command MIG_CMD_POSTCOPY_RESUME from source.

This is actually more than that - because the main thread on destination will
now be able to call migrate_send_rp_req_pages_pending() too, so the fault
thread is not the only user of last_rb now.  Move the reset earlier will allow
the first call to migrate_send_rp_req_pages_pending() to use the reset value
even if called from the main thread.

(NOTE: this is not a real fix to 0c26781c09 mentioned below, however it is just
 a mark that when picking up 0c26781c09 we'd better have this one too; the real
 fix will come later)

Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 2 --
 migration/savevm.c       | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index d3bb3a744b..d99842eb1b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -903,7 +903,6 @@ static void *postcopy_ram_fault_thread(void *opaque)
              * the channel is rebuilt.
              */
             if (postcopy_pause_fault_thread(mis)) {
-                mis->last_rb = NULL;
                 /* Continue to read the userfaultfd */
             } else {
                 error_report("%s: paused but don't allow to continue",
@@ -985,7 +984,6 @@ retry:
                 /* May be network failure, try to wait for recovery */
                 if (ret == -EIO && postcopy_pause_fault_thread(mis)) {
                     /* We got reconnected somehow, try to continue */
-                    mis->last_rb = NULL;
                     goto retry;
                 } else {
                     /* This is a unavoidable fault */
diff --git a/migration/savevm.c b/migration/savevm.c
index 21ccba9fb3..e8834991ec 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2061,6 +2061,12 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
         return 0;
     }
 
+    /*
+     * Reset the last_rb before we resend any page req to source again, since
+     * the source should have it reset already.
+     */
+    mis->last_rb = NULL;
+
     /*
      * This means source VM is ready to resume the postcopy migration.
      * It's time to switch state and release the fault thread to
-- 
2.26.2


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0002-migration-Postpone-the-kick-of-the-fault-thread-afte.patch"

From 2a28241de49d27d7b0968f1d1b137aea153fc3b4 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Fri, 30 Oct 2020 09:44:32 -0400
Subject: [PATCH 2/2] migration: Postpone the kick of the fault thread after
 recover

The new migrate_send_rp_req_pages_pending() call should greatly improve
destination responsiveness because it will resync faulted address after
postcopy recovery.  However it is also the 1st place to initiate the page
request from the main thread.

One thing is overlooked on that migrate_send_rp_message_req_pages() is not
designed to be thread-safe.  So if we wake the fault thread before syncing all
the faulted pages in the main thread, it means they can race.

Postpone the wake up operation after the sync of faulted addresses.

Fixes: 0c26781c09 ("migration: Sync requested pages after postcopy recovery")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index e8834991ec..5f937a2762 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,12 +2069,9 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 
     /*
      * This means source VM is ready to resume the postcopy migration.
-     * It's time to switch state and release the fault thread to
-     * continue service page faults.
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
                       MIGRATION_STATUS_POSTCOPY_ACTIVE);
-    qemu_sem_post(&mis->postcopy_pause_sem_fault);
 
     trace_loadvm_postcopy_handle_resume();
 
@@ -2095,6 +2092,14 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
      */
     migrate_send_rp_req_pages_pending(mis);
 
+    /*
+     * It's time to switch state and release the fault thread to continue
+     * service page faults.  Note that this should be explicitly after the
+     * above call to migrate_send_rp_req_pages_pending().  In short:
+     * migrate_send_rp_message_req_pages() is not thread safe, yet.
+     */
+    qemu_sem_post(&mis->postcopy_pause_sem_fault);
+
     return 0;
 }
 
-- 
2.26.2


--HlL+5n6rz5pIUxbD--


