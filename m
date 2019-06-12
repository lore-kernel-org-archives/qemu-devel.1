Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FB0C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:04:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE36F20896
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 14:04:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE36F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60684 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb3rA-00034h-5D
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 10:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42866)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hb3jW-00073k-7C
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hb3jV-0001qJ-1K
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 09:56:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hb3jH-0001if-Su; Wed, 12 Jun 2019 09:55:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56C99800AD;
 Wed, 12 Jun 2019 13:55:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-60.ams2.redhat.com
 [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BCAC560BF1;
 Wed, 12 Jun 2019 13:55:42 +0000 (UTC)
Date: Wed, 12 Jun 2019 15:55:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612135541.GC9699@localhost.localdomain>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-6-kwolf@redhat.com>
 <87a7en2fjh.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7en2fjh.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 12 Jun 2019 13:55:46 +0000 (UTC)
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

Am 12.06.2019 um 13:45 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Monitor.cmd_table contains the handlers for HMP commands, so there is no
> > reason to keep it in the state shared with QMP. Move it to MonitorHMP.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  monitor.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index f8730e4462..56af8ed448 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -191,7 +191,6 @@ struct Monitor {
> >      bool use_io_thread;
> >  
> >      gchar *mon_cpu_path;
> > -    mon_cmd_t *cmd_table;
> >      QTAILQ_ENTRY(Monitor) entry;
> >  
> >      /*
> > @@ -219,6 +218,7 @@ struct MonitorHMP {
> >       * These members can be safely accessed without locks.
> >       */
> >      ReadLineState *rs;
> > +    mon_cmd_t *cmd_table;
> >  };
> >  
> >  typedef struct {
> > @@ -720,13 +720,19 @@ static void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
> >      memset(mon, 0, sizeof(Monitor));
> >      qemu_mutex_init(&mon->mon_lock);
> >      mon->outbuf = qstring_new();
> > -    /* Use *mon_cmds by default. */
> > -    mon->cmd_table = mon_cmds;
> 
> As far as I can tell, this is the only assignment to Monitor member
> cmd_table.  Why not delete it outright, and use mon_cmds directly?
> Preferably renamed to something like hmp_cmds.

Good idea, I'll do that.

Kevin

