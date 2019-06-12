Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D23DC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EFE12080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EFE12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0AG-0004JW-7j
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:07:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49617)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hb08h-0003aF-Hi
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:05:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hb08f-0003Hb-05
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:05:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35416)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hb08T-0002NW-AX; Wed, 12 Jun 2019 06:05:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 914C97FDFA;
 Wed, 12 Jun 2019 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-60.ams2.redhat.com
 [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EDD995D9D1;
 Wed, 12 Jun 2019 10:03:28 +0000 (UTC)
Date: Wed, 12 Jun 2019 12:03:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612100327.GA9699@localhost.localdomain>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-5-kwolf@redhat.com>
 <877e9r41fu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877e9r41fu.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Wed, 12 Jun 2019 10:03:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 04/11] monitor: Create MonitorHMP with
 readline state
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
Cc: Peter Xu <peterx@redhat.com>, berrange@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.06.2019 um 11:07 hat Markus Armbruster geschrieben:
> Cc: Peter for a monitor I/O thread question.
> 
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > The ReadLineState in Monitor is only used for HMP monitors. Create
> > MonitorHMP and move it there.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> > @@ -218,6 +210,17 @@ struct Monitor {
> >      int mux_out;
> >  };
> >  
> > +struct MonitorHMP {
> > +    Monitor common;
> > +    /*
> > +     * State used only in the thread "owning" the monitor.
> > +     * If @use_io_thread, this is @mon_iothread.
> > +     * Else, it's the main thread.
> > +     * These members can be safely accessed without locks.
> > +     */
> > +    ReadLineState *rs;
> > +};
> > +
> 
> Hmm.
> 
> The monitor I/O thread code makes an effort not to restrict I/O thread
> use to QMP, even though we only use it there.  Whether the code would
> actually work for HMP as well we don't know.
> 
> Readline was similar until your PATCH 02: the code made an effort not to
> restrict it to HMP, even though we only use it there.  Whether the code
> would actually work for QMP as well we don't know.
> 
> Should we stop pretending and hard-code "I/O thread only for QMP"?
> 
> If yes, the comment above gets simplified by the patch that hard-codes
> "I/O thread only for QMP".
> 
> If no, we should perhaps point out that we currently don't use an I/O
> thread with HMP.  The comment above seems like a good place for that.
> 
> Perhaps restricting readline to HMP should be a separate patch before
> PATCH 02.

Yes, possibly iothreads could be restricted to QMP. It doesn't help me
in splitting the monitor in any way, though, so I don't see it within
the scope of this series.

Keeping readline around for QMP, on the other hand, would probably have
been harder than making the restriction.

As for splitting patch 2, I don't think that reorganising a patch that
already does its job and already received review is the most productive
thing we could do, but if you insist on a separate patch, I can do that.

> > @@ -748,12 +754,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> >                                  int64_t cpu_index, Error **errp)
> >  {
> >      char *output = NULL;
> > -    Monitor *old_mon, hmp;
> > +    Monitor *old_mon;
> > +    MonitorHMP hmp = {};
> 
> Any particular reason for adding the initializer?

Yes:

> >  
> > -    monitor_data_init(&hmp, 0, true, false);
> > +    monitor_data_init(&hmp.common, 0, true, false);

monitor_data_init() does a memset(), but only on hmp.common, so the
fields outside of hmp.common would remain uniniitialised. Specifically,
hmp.rs wouldn't be initialised to NULL and attempting to free it in the
end would crash.

> >      old_mon = cur_mon;
> > -    cur_mon = &hmp;
> > +    cur_mon = &hmp.common;
> >  
> >      if (has_cpu_index) {
> >          int ret = monitor_set_cpu(cpu_index);

> > @@ -1341,16 +1348,19 @@ static void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
> >  
> >  static void hmp_info_history(Monitor *mon, const QDict *qdict)
> >  {
> > +    MonitorHMP *hmp_mon = container_of(mon, MonitorHMP, common);
> 
> Unchecked conversion.  Tolerable, I think, since HMP command handlers
> generally don't get invoked manually, unlike QMP command handlers.

I would like to see all HMP command handlers take MonitorHMP* instead of
Monitor*, but that would be a big ugly patch touching everything that
isn't really needed for the goal of this series, so I didn't include it.

If you consider it valuable to get rid of this container_of(), that's
probably the follow-up you could do.

> > @@ -4460,6 +4474,7 @@ static void monitor_qmp_event(void *opaque, int event)
> >  static void monitor_event(void *opaque, int event)
> >  {
> >      Monitor *mon = opaque;
> > +    MonitorHMP *hmp_mon = container_of(cur_mon, MonitorHMP, common);
> 
> Any particular reason for changing from @opaque to @cur_mon?

Probably a copy & paste error, thanks for catching it! I'll fix it.

> > @@ -4662,11 +4679,11 @@ static void monitor_init_qmp(Chardev *chr, int flags)
> >  
> >  static void monitor_init_hmp(Chardev *chr, int flags)
> >  {
> > -    Monitor *mon = g_malloc(sizeof(*mon));
> > +    MonitorHMP *mon = g_malloc0(sizeof(*mon));
> 
> Any particular reason for changing to g_malloc0()?
> 
> You hid the same change for monitor_init_qmp() in PATCH 03, where I
> missed it until now.

As above, initialising the fields outside mon->common.

Kevin

