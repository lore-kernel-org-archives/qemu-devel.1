Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D50C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:25:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786C220880
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786C220880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htQ3u-0006iN-MV
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 01:25:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36870)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htQ3W-0006Ic-O0
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htQ3U-0007sv-Rj
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:24:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htQ3T-0007sL-2H
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:24:40 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C76BF30860B6;
 Fri,  2 Aug 2019 05:24:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A963119C68;
 Fri,  2 Aug 2019 05:24:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 362541138619; Fri,  2 Aug 2019 07:24:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190802020716.11985-1-richardw.yang@linux.intel.com>
Date: Fri, 02 Aug 2019 07:24:34 +0200
In-Reply-To: <20190802020716.11985-1-richardw.yang@linux.intel.com> (Wei
 Yang's message of "Fri, 2 Aug 2019 10:07:16 +0800")
Message-ID: <87a7csm965.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 05:24:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] hmp/info_migration: formatting migration
 capability output
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Subject doesn't quite conform to conventions.  Suggest

    hmp: Improve how "info migrate" formats capabilities

Wei Yang <richardw.yang@linux.intel.com> writes:

> Current we put all migration capability in one line, which make it hard
> to read them and someone them are missed due to terminal width.
>
> This patch formats it to print 4 in one line, which looks like this now:
>
> capabilities:
>               xbzrle: off         rdma-pin-all: off        auto-converge: off          zero-blocks: off
>             compress:  on               events: off         postcopy-ram: off               x-colo: off
>          release-ram: off                block: off          return-path: off pause-before-switchover: off
>              multifd: off        dirty-bitmaps: off   postcopy-blocktime: off  late-block-activate: off
>      x-ignore-shared: off
>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  monitor/hmp-cmds.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
> index 5ca3ebe942..29ce5b73e4 100644
> --- a/monitor/hmp-cmds.c
> +++ b/monitor/hmp-cmds.c
> @@ -229,9 +229,13 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>  
>      /* do not display parameters during setup */
>      if (info->has_status && caps) {
> +        int index = 0;
>          monitor_printf(mon, "capabilities: ");
> -        for (cap = caps; cap; cap = cap->next) {
> -            monitor_printf(mon, "%s: %s ",
> +        for (cap = caps; cap; cap = cap->next, index++) {
> +            if (!(index % 4)) {
> +                monitor_printf(mon, "\n");
> +            }
> +            monitor_printf(mon, "%20s: %3s ",
>                             MigrationCapability_str(cap->value->capability),
>                             cap->value->state ? "on" : "off");
>          }

This assumes migration capability names are at most 20 characters long.
late-block-activate is pushing it already: 19 characters.

It adds up to 104 characters per line, which is rather wide.

What about putting each capability on its own line, just like globals,
and just like "info migrate_capabilities"?

(qemu) info migrate
globals:
store-global-state: on
only-migratable: off
send-configuration: on
send-section-footer: on
decompress-error-check: on
clear-bitmap-shift: 18
capabilities:
xbzrle: off
rdma-pin-all: off
auto-converge: off
[...]

