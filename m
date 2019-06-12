Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF18C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A426220665
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 11:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A426220665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb1mB-00054q-Pp
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42681)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hb1hK-0003Fq-Cd
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hb1hI-0002EN-FL
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:45:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hb1h5-000272-2D; Wed, 12 Jun 2019 07:45:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D488A3082129;
 Wed, 12 Jun 2019 11:45:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A265A282DA;
 Wed, 12 Jun 2019 11:45:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 30E3D1138648; Wed, 12 Jun 2019 13:45:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-6-kwolf@redhat.com>
Date: Wed, 12 Jun 2019 13:45:22 +0200
In-Reply-To: <20190611134043.9524-6-kwolf@redhat.com> (Kevin Wolf's message of
 "Tue, 11 Jun 2019 15:40:37 +0200")
Message-ID: <87a7en2fjh.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 12 Jun 2019 11:45:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 05/11] monitor: Move cmd_table to
 MonitorHMP
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Monitor.cmd_table contains the handlers for HMP commands, so there is no
> reason to keep it in the state shared with QMP. Move it to MonitorHMP.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  monitor.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index f8730e4462..56af8ed448 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -191,7 +191,6 @@ struct Monitor {
>      bool use_io_thread;
>  
>      gchar *mon_cpu_path;
> -    mon_cmd_t *cmd_table;
>      QTAILQ_ENTRY(Monitor) entry;
>  
>      /*
> @@ -219,6 +218,7 @@ struct MonitorHMP {
>       * These members can be safely accessed without locks.
>       */
>      ReadLineState *rs;
> +    mon_cmd_t *cmd_table;
>  };
>  
>  typedef struct {
> @@ -720,13 +720,19 @@ static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->mon_lock);
>      mon->outbuf = qstring_new();
> -    /* Use *mon_cmds by default. */
> -    mon->cmd_table = mon_cmds;

As far as I can tell, this is the only assignment to Monitor member
cmd_table.  Why not delete it outright, and use mon_cmds directly?
Preferably renamed to something like hmp_cmds.

[...]

