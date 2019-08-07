Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A52C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75902086D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75902086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQzZ-0000L9-0W
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43283)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvQyw-0008Mb-7x
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvQyu-0005S1-PI
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:48:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57230)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvQyu-0005QI-HK
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:48:16 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D101030017A7;
 Wed,  7 Aug 2019 18:48:15 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BB4160BE0;
 Wed,  7 Aug 2019 18:48:11 +0000 (UTC)
Date: Wed, 7 Aug 2019 19:48:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Ivan Ren <renyime@gmail.com>
Message-ID: <20190807184808.GS27871@work-vm>
References: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564741121-1840-1-git-send-email-ivanren@tencent.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 07 Aug 2019 18:48:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] migration: always initial ram_counters
 for a new migration
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
Cc: qemu-devel@nongnu.org, richardw.yang@linux.intel.com, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Ivan Ren (renyime@gmail.com) wrote:
> From: Ivan Ren <ivanren@tencent.com>
> 
> This patch fix a multifd migration bug in migration speed calculation, this
> problem can be reproduced as follows:
> 1. start a vm and give a heavy memory write stress to prevent the vm be
>    successfully migrated to destination
> 2. begin a migration with multifd
> 3. migrate for a long time [actually, this can be measured by transferred bytes]
> 4. migrate cancel
> 5. begin a new migration with multifd, the migration will directly run into
>    migration_completion phase
> 
> Reason as follows:
> 
> Migration update bandwidth and s->threshold_size in function
> migration_update_counters after BUFFER_DELAY time:
> 
>     current_bytes = migration_total_bytes(s);
>     transferred = current_bytes - s->iteration_initial_bytes;
>     time_spent = current_time - s->iteration_start_time;
>     bandwidth = (double)transferred / time_spent;
>     s->threshold_size = bandwidth * s->parameters.downtime_limit;
> 
> In multifd migration, migration_total_bytes function return
> qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes.
> s->iteration_initial_bytes will be initialized to 0 at every new migration,
> but ram_counters is a global variable, and history migration data will be
> accumulated. So if the ram_counters.multifd_bytes is big enough, it may lead
> pending_size >= s->threshold_size become false in migration_iteration_run
> after the first migration_update_counters.
> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Suggested-by: Wei Yang <richardw.yang@linux.intel.com>

Thank you,

Queued

> ---
> v2->v3:
> - fix the bug of update_iteration_initial_status function prototype
> 
> v1->v2:
> - Add interface update_iteration_initial_status to update statistic fields
>   at the same time to avoid info mismatch lead wrong calculation result.
> 
>  migration/migration.c | 25 +++++++++++++++++++------
>  migration/savevm.c    |  1 +
>  2 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8a607fe1e2..bea9b1d796 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1908,6 +1908,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>      }
>  
>      migrate_init(s);
> +    /*
> +     * set ram_counters memory to zero for a
> +     * new migration
> +     */
> +    memset(&ram_counters, 0, sizeof(ram_counters));
>  
>      return true;
>  }
> @@ -3025,6 +3030,17 @@ static void migration_calculate_complete(MigrationState *s)
>      }
>  }
>  
> +static void update_iteration_initial_status(MigrationState *s)
> +{
> +    /*
> +     * Update these three fields at the same time to avoid mismatch info lead
> +     * wrong speed calculation.
> +     */
> +    s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    s->iteration_initial_bytes = migration_total_bytes(s);
> +    s->iteration_initial_pages = ram_get_total_transferred_pages();
> +}
> +
>  static void migration_update_counters(MigrationState *s,
>                                        int64_t current_time)
>  {
> @@ -3060,9 +3076,7 @@ static void migration_update_counters(MigrationState *s,
>  
>      qemu_file_reset_rate_limit(s->to_dst_file);
>  
> -    s->iteration_start_time = current_time;
> -    s->iteration_initial_bytes = current_bytes;
> -    s->iteration_initial_pages = ram_get_total_transferred_pages();
> +    update_iteration_initial_status(s);
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                bandwidth, s->threshold_size);
> @@ -3186,7 +3200,7 @@ static void *migration_thread(void *opaque)
>      rcu_register_thread();
>  
>      object_ref(OBJECT(s));
> -    s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +    update_iteration_initial_status(s);
>  
>      qemu_savevm_state_header(s->to_dst_file);
>  
> @@ -3251,8 +3265,7 @@ static void *migration_thread(void *opaque)
>               * the local variables. This is important to avoid
>               * breaking transferred_bytes and bandwidth calculation
>               */
> -            s->iteration_start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> -            s->iteration_initial_bytes = 0;
> +            update_iteration_initial_status(s);
>          }
>  
>          current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 79ed44d475..480c511b19 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1424,6 +1424,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      }
>  
>      migrate_init(ms);
> +    memset(&ram_counters, 0, sizeof(ram_counters));
>      ms->to_dst_file = f;
>  
>      qemu_mutex_unlock_iothread();
> -- 
> 2.17.2 (Apple Git-113)
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

