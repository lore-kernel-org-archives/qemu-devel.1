Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E184C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D97205F4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 10:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D97205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkn3h-0002vh-J9
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 06:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53541)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hkn0a-0008Q3-NI
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:06:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hkn0Z-0003ok-Gj
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:06:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hkn0Z-0003ZG-6Y
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 06:05:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFBF830860C1;
 Tue,  9 Jul 2019 09:57:19 +0000 (UTC)
Received: from work-vm (ovpn-117-75.ams2.redhat.com [10.36.117.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EF535DA96;
 Tue,  9 Jul 2019 09:57:18 +0000 (UTC)
Date: Tue, 9 Jul 2019 10:57:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: vandersonmr <vandersonmr2@gmail.com>
Message-ID: <20190709095716.GC2725@work-vm>
References: <20190702210017.4275-1-vandersonmr2@gmail.com>
 <20190702210017.4275-5-vandersonmr2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702210017.4275-5-vandersonmr2@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 09 Jul 2019 09:57:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 5/6] monitor: adding info tb and tbs to
 monitor
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* vandersonmr (vandersonmr2@gmail.com) wrote:
> adding options to list tbs by some metric and
> investigate their code.
> 
> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>

As Markus said you need a short justification that it's for debug etc
to justify HMP only; it doesn't need to be huge, but we should have it.

> ---
>  hmp-commands-info.hx | 22 ++++++++++++++
>  monitor/misc.c       | 69 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index c59444c461..0b8c0de95d 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -288,6 +288,28 @@ ETEXI
>          .params     = "",
>          .help       = "show dynamic compiler info",
>          .cmd        = hmp_info_jit,
> +    {
> +        .name       = "tbs",
> +        .args_type  = "number:i?,sortedby:s?",
> +        .params     = "[number sortedby]",
> +        .help       = "show a [number] translated blocks sorted by [sortedby]"
> +                      "sortedby opts: hotness hg",

If this is showing 'number' blocks then I think it should be called
'count'

> +        .cmd        = hmp_info_tbs,
> +    },
> +    {
> +        .name       = "tb",
> +        .args_type  = "id:i,flags:s?",
> +        .params     = "id [log1[,...] flags]",
> +        .help       = "show information about one translated block by id",
> +        .cmd        = hmp_info_tb,

That doesn't say what those flags are for; qemu has lots of flags for
different things; I think you're  saying it's some log flag?

> +    },
> +    {
> +        .name       = "coverset",
> +        .args_type  = "number:i?",
> +        .params     = "[number]",
> +        .help       = "show hottest translated blocks neccesary to cover"
> +                      "[number]% of the execution count",
> +        .cmd        = hmp_info_coverset,
>      },

That 'number' should be something like 'percent' or 'coverage'
>  #endif
>  
> diff --git a/monitor/misc.c b/monitor/misc.c
> index bf9faceb86..1fb4d75871 100644
> --- a/monitor/misc.c
> +++ b/monitor/misc.c
> @@ -469,6 +469,75 @@ static void hmp_info_jit(Monitor *mon, const QDict *qdict)
>      dump_drift_info();
>  }
>  
> +static void hmp_info_tbs(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    const char *s = NULL;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +    if (!tb_ctx.tb_stats.map) {
> +        error_report("no TB information recorded");
> +        return;
> +    }
> +
> +    n = qdict_get_try_int(qdict, "number", 10);
> +    s = qdict_get_try_str(qdict, "sortedby");

No need to use single characters; sortedby_str  is fine for
example.

> +    int sortedby = 0;
> +    if (s == NULL || strcmp(s, "hotness") == 0) {
> +        sortedby = SORT_BY_HOTNESS;
> +    } else if (strcmp(s, "hg") == 0) {
> +        sortedby = SORT_BY_HG;
> +    }

You should error if there's another word in 's'

> +    dump_tbs_info(n, sortedby, true);
> +}
> +
> +static void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    const int id = qdict_get_int(qdict, "id");
> +    const char *flags = qdict_get_try_str(qdict, "flags");
> +    int mask;
> +
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +
> +    mask = flags ? qemu_str_to_log_mask(flags) : CPU_LOG_TB_IN_ASM;
> +
> +    if (!mask) {
> +        help_cmd(mon, "log");

That's not obvious - I'd perfer you said something like
     Unable to parse log flags, see 'help log'

> +        return;
> +    }
> +
> +    dump_tb_info(id, mask, true);
> +}
> +
> +static void hmp_info_coverset(Monitor *mon, const QDict *qdict)
> +{
> +    int n;
> +    if (!tcg_enabled()) {
> +        error_report("TB information is only available with accel=tcg");
> +        return;
> +    }
> +    if (!qemu_loglevel_mask(CPU_LOG_HOT_TBS)) {
> +        error_report("TB information not being recorded");
> +        return;
> +    }
> +
> +    n = qdict_get_try_int(qdict, "number", 90);
> +
> +    if (n < 0 || n > 100) {
> +        error_report("Coverset percentage should be between 0 and 100");
> +        return;
> +    }
> +
> +    dump_coverset_info(n, true);
> +}
> +
>  static void hmp_info_opcount(Monitor *mon, const QDict *qdict)
>  {
>      dump_opcount_info();
> -- 
> 2.22.0
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

