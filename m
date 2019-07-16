Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD847C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FB020665
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 09:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FB020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnKFQ-0001OG-NF
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 05:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38493)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hnKFF-0000zh-6r
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:59:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hnKFD-0003PP-3v
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hnKFC-0003OW-RC
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 05:59:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5B4C08553F;
 Tue, 16 Jul 2019 09:59:33 +0000 (UTC)
Received: from work-vm (ovpn-117-169.ams2.redhat.com [10.36.117.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82106100164A;
 Tue, 16 Jul 2019 09:59:32 +0000 (UTC)
Date: Tue, 16 Jul 2019 10:59:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190716095930.GA2770@work-vm>
References: <20190716005411.4156-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190716005411.4156-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 16 Jul 2019 09:59:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: consolidate time info into
 populate_time_info
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
> Consolidate time information fill up into its function for better
> readability.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/migration.c | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 47fe22d327..18ef933105 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -822,6 +822,25 @@ bool migration_is_setup_or_active(int state)
>      }
>  }
>  
> +static void populate_time_info(MigrationInfo *info, MigrationState *s)
> +{
> +    info->has_status = true;
> +    info->has_setup_time = true;
> +    info->setup_time = s->setup_time;
> +    if (s->state == MIGRATION_STATUS_COMPLETED) {
> +        info->has_total_time = true;
> +        info->total_time = s->total_time;
> +        info->has_downtime = true;
> +        info->downtime = s->downtime;
> +    } else {
> +        info->has_total_time = true;
> +        info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
> +                           s->start_time;
> +        info->has_expected_downtime = true;
> +        info->expected_downtime = s->expected_downtime;
> +    }
> +}
> +
>  static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>  {
>      info->has_ram = true;
> @@ -907,16 +926,8 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> -         /* TODO add some postcopy stats */
> -        info->has_status = true;
> -        info->has_total_time = true;
> -        info->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> -            - s->start_time;
> -        info->has_expected_downtime = true;
> -        info->expected_downtime = s->expected_downtime;
> -        info->has_setup_time = true;
> -        info->setup_time = s->setup_time;
> -
> +        /* TODO add some postcopy stats */
> +        populate_time_info(info, s);
>          populate_ram_info(info, s);
>          populate_disk_info(info);
>          break;
> @@ -925,14 +936,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>          /* TODO: display COLO specific information (checkpoint info etc.) */
>          break;
>      case MIGRATION_STATUS_COMPLETED:
> -        info->has_status = true;
> -        info->has_total_time = true;
> -        info->total_time = s->total_time;
> -        info->has_downtime = true;
> -        info->downtime = s->downtime;
> -        info->has_setup_time = true;
> -        info->setup_time = s->setup_time;
> -
> +        populate_time_info(info, s);
>          populate_ram_info(info, s);
>          break;
>      case MIGRATION_STATUS_FAILED:
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

