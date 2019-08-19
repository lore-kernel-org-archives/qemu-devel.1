Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0931C3A59B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D8162082C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 03:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8162082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzYOJ-0008UV-OA
	for qemu-devel@archiver.kernel.org; Sun, 18 Aug 2019 23:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hzYN7-0007xa-4T
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1hzYN4-00016Z-Ga
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:30:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:22250)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1hzYN4-00012s-7J
 for qemu-devel@nongnu.org; Sun, 18 Aug 2019 23:30:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Aug 2019 20:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,403,1559545200"; d="scan'208";a="177755552"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2019 20:30:10 -0700
Date: Mon, 19 Aug 2019 11:29:47 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190819032947.GB18468@richard>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621142739.23703-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.120
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 21, 2019 at 10:27:39PM +0800, Wei Yang wrote:
>No functional change. Add default case to fix warning.
>

Hi, David & Juan

Do you like this?

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> migration/migration.c | 8 +++++++-
> migration/migration.h | 6 +++---
> 2 files changed, 10 insertions(+), 4 deletions(-)
>
>diff --git a/migration/migration.c b/migration/migration.c
>index 2865ae3fa9..0fd2364961 100644
>--- a/migration/migration.c
>+++ b/migration/migration.c
>@@ -946,6 +946,8 @@ static void fill_source_migration_info(MigrationInfo *info)
>     case MIGRATION_STATUS_CANCELLED:
>         info->has_status = true;
>         break;
>+    default:
>+        return;
>     }
>     info->status = s->state;
> }
>@@ -1054,6 +1056,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
>         info->has_status = true;
>         fill_destination_postcopy_migration_info(info);
>         break;
>+    default:
>+        return;
>     }
>     info->status = mis->state;
> }
>@@ -1446,7 +1450,7 @@ void qmp_migrate_start_postcopy(Error **errp)
> 
> /* shared migration helpers */
> 
>-void migrate_set_state(int *state, int old_state, int new_state)
>+void migrate_set_state(MigrationStatus *state, int old_state, int new_state)
> {
>     assert(new_state < MIGRATION_STATUS__MAX);
>     if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
>@@ -1683,6 +1687,8 @@ bool migration_is_idle(void)
>         return false;
>     case MIGRATION_STATUS__MAX:
>         g_assert_not_reached();
>+    default:
>+        g_assert_not_reached();
>     }
> 
>     return false;
>diff --git a/migration/migration.h b/migration/migration.h
>index 5e8f09c6db..418ee00053 100644
>--- a/migration/migration.h
>+++ b/migration/migration.h
>@@ -65,7 +65,7 @@ struct MigrationIncomingState {
> 
>     QEMUBH *bh;
> 
>-    int state;
>+    MigrationStatus state;
> 
>     bool have_colo_incoming_thread;
>     QemuThread colo_incoming_thread;
>@@ -151,7 +151,7 @@ struct MigrationState
>     /* params from 'migrate-set-parameters' */
>     MigrationParameters parameters;
> 
>-    int state;
>+    MigrationStatus state;
> 
>     /* State related to return path */
>     struct {
>@@ -234,7 +234,7 @@ struct MigrationState
>     bool decompress_error_check;
> };
> 
>-void migrate_set_state(int *state, int old_state, int new_state);
>+void migrate_set_state(MigrationStatus *state, int old_state, int new_state);
> 
> void migration_fd_process_incoming(QEMUFile *f);
> void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>-- 
>2.19.1

-- 
Wei Yang
Help you, Help me

