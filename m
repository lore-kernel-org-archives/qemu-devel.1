Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12A0C433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C81A92229C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 18:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C81A92229C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvQwC-0005ee-4i
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 14:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hvQvl-0005Ci-3I
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:45:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hvQvj-0005XT-Nq
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:45:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hvQvi-0005PH-Fx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 14:44:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F6D12D6A04;
 Wed,  7 Aug 2019 18:44:56 +0000 (UTC)
Received: from work-vm (ovpn-117-204.ams2.redhat.com [10.36.117.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 643035D71C;
 Wed,  7 Aug 2019 18:44:55 +0000 (UTC)
Date: Wed, 7 Aug 2019 19:44:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190807184452.GQ27871@work-vm>
References: <20190806003645.8426-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806003645.8426-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 07 Aug 2019 18:44:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] hmp: Remove migration capabilities from
 "info migrate"
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
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> With the growth of migration capabilities, it is not proper to display
> them in "info migrate". Users are recommended to use "info
> migrate_capabiltiies" to list them.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Queued

> ---
> v3:
>   * remove un-used variable caps
> v2:
>   * remove capabilities from "info migrate"
> ---
>  monitor/hmp-cmds.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 5ca3ebe942..35788c0645 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -220,24 +220,11 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>  void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  {
>      MigrationInfo *info;
> -    MigrationCapabilityStatusList *caps, *cap;
>  
>      info = qmp_query_migrate(NULL);
> -    caps = qmp_query_migrate_capabilities(NULL);
>  
>      migration_global_dump(mon);
>  
> -    /* do not display parameters during setup */
> -    if (info->has_status && caps) {
> -        monitor_printf(mon, "capabilities: ");
> -        for (cap = caps; cap; cap = cap->next) {
> -            monitor_printf(mon, "%s: %s ",
> -                           MigrationCapability_str(cap->value->capability),
> -                           cap->value->state ? "on" : "off");
> -        }
> -        monitor_printf(mon, "\n");
> -    }
> -
>      if (info->has_status) {
>          monitor_printf(mon, "Migration status: %s",
>                         MigrationStatus_str(info->status));
> @@ -370,7 +357,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>          monitor_printf(mon, "]\n");
>      }
>      qapi_free_MigrationInfo(info);
> -    qapi_free_MigrationCapabilityStatusList(caps);
>  }
>  
>  void hmp_info_migrate_capabilities(Monitor *mon, const QDict *qdict)
> -- 
> 2.17.1
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

