Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F44C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3B9217D4
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 15:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE3B9217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpwst-0004pq-Sx
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 11:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hpwsk-0004RO-30
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:39:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hpwsj-0008De-3f
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:39:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hpwsi-0008DL-Sd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 11:39:13 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 914D1330265;
 Tue, 23 Jul 2019 15:39:11 +0000 (UTC)
Received: from work-vm (ovpn-117-202.ams2.redhat.com [10.36.117.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3FF260148;
 Tue, 23 Jul 2019 15:39:10 +0000 (UTC)
Date: Tue, 23 Jul 2019 16:39:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190723153908.GK2719@work-vm>
References: <20190722062435.2518-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722062435.2518-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 23 Jul 2019 15:39:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration/multifd: multifd_load_cleanup()
 always return 0
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> multifd_load_cleanup() always return 0 and never use the errp, just
> cleanup a little.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

I'd rather leave this; it wouldn't be that odd for us to add an error
check there later.

Dave

> ---
>  migration/migration.c | 9 ++-------
>  migration/ram.c       | 7 +++----
>  migration/ram.h       | 2 +-
>  3 files changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 27ca10122f..38d2fdfa73 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -399,10 +399,7 @@ static void process_incoming_migration_bh(void *opaque)
>       */
>      qemu_announce_self(&mis->announce_timer, migrate_announce_params());
>  
> -    if (multifd_load_cleanup(&local_err) != 0) {
> -        error_report_err(local_err);
> -        autostart = false;
> -    }
> +    multifd_load_cleanup();
>      /* If global state section was not received or we are in running
>         state, we need to obey autostart. Any other state is set with
>         runstate_set. */
> @@ -506,9 +503,7 @@ fail:
>      migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
>                        MIGRATION_STATUS_FAILED);
>      qemu_fclose(mis->from_src_file);
> -    if (multifd_load_cleanup(&local_err) != 0) {
> -        error_report_err(local_err);
> -    }
> +    multifd_load_cleanup();
>      exit(EXIT_FAILURE);
>  }
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 66792568e2..7d30f8484c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1243,13 +1243,12 @@ static void multifd_recv_terminate_threads(Error *err)
>      }
>  }
>  
> -int multifd_load_cleanup(Error **errp)
> +void multifd_load_cleanup(void)
>  {
>      int i;
> -    int ret = 0;
>  
>      if (!migrate_use_multifd()) {
> -        return 0;
> +        return;
>      }
>      multifd_recv_terminate_threads(NULL);
>      for (i = 0; i < migrate_multifd_channels(); i++) {
> @@ -1276,7 +1275,7 @@ int multifd_load_cleanup(Error **errp)
>      g_free(multifd_recv_state);
>      multifd_recv_state = NULL;
>  
> -    return ret;
> +    return;
>  }
>  
>  static void multifd_recv_sync_main(void)
> diff --git a/migration/ram.h b/migration/ram.h
> index e0a499b956..6fdd449899 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -44,7 +44,7 @@ uint64_t ram_bytes_total(void);
>  int multifd_save_setup(void);
>  void multifd_save_cleanup(void);
>  int multifd_load_setup(void);
> -int multifd_load_cleanup(Error **errp);
> +void multifd_load_cleanup(void);
>  bool multifd_recv_all_channels_created(void);
>  bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
>  
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

