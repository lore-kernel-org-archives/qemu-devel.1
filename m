Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19AE0C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:22:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FD42082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:22:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FD42082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33062 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb55J-0005Qh-Tf
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33033)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hb52i-0003b0-1m
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hb4mq-0002UT-Qo
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:03:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39286)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hb4mn-0002PR-C8; Wed, 12 Jun 2019 11:03:37 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46EEF223874;
 Wed, 12 Jun 2019 15:03:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-60.ams2.redhat.com
 [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D837196B1;
 Wed, 12 Jun 2019 15:03:29 +0000 (UTC)
Date: Wed, 12 Jun 2019 17:03:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612150327.GD9699@localhost.localdomain>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-5-kwolf@redhat.com>
 <877e9r41fu.fsf@dusky.pond.sub.org>
 <20190612100327.GA9699@localhost.localdomain>
 <87wohqx5e2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wohqx5e2.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 12 Jun 2019 15:03:36 +0000 (UTC)
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
Cc: qemu-block@nongnu.org, berrange@redhat.com, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.06.2019 um 16:08 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Am 12.06.2019 um 11:07 hat Markus Armbruster geschrieben:
> >> Cc: Peter for a monitor I/O thread question.
> >> 
> >> Kevin Wolf <kwolf@redhat.com> writes:
> >> 
> >> > The ReadLineState in Monitor is only used for HMP monitors. Create
> >> > MonitorHMP and move it there.
> >> >
> >> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> >> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >> > @@ -218,6 +210,17 @@ struct Monitor {
> >> >      int mux_out;
> >> >  };
> >> >  
> >> > +struct MonitorHMP {
> >> > +    Monitor common;
> >> > +    /*
> >> > +     * State used only in the thread "owning" the monitor.
> >> > +     * If @use_io_thread, this is @mon_iothread.
> >> > +     * Else, it's the main thread.
> >> > +     * These members can be safely accessed without locks.
> >> > +     */
> >> > +    ReadLineState *rs;
> >> > +};
> >> > +
> >> 
> >> Hmm.
> >> 
> >> The monitor I/O thread code makes an effort not to restrict I/O thread
> >> use to QMP, even though we only use it there.  Whether the code would
> >> actually work for HMP as well we don't know.
> >> 
> >> Readline was similar until your PATCH 02: the code made an effort not to
> >> restrict it to HMP, even though we only use it there.  Whether the code
> >> would actually work for QMP as well we don't know.
> >> 
> >> Should we stop pretending and hard-code "I/O thread only for QMP"?
> >> 
> >> If yes, the comment above gets simplified by the patch that hard-codes
> >> "I/O thread only for QMP".
> >> 
> >> If no, we should perhaps point out that we currently don't use an I/O
> >> thread with HMP.  The comment above seems like a good place for that.
> >> 
> >> Perhaps restricting readline to HMP should be a separate patch before
> >> PATCH 02.
> >
> > Yes, possibly iothreads could be restricted to QMP. It doesn't help me
> > in splitting the monitor in any way, though, so I don't see it within
> > the scope of this series.
> 
> That's okay.
> 
> Would you mind pointing out we don't actually use an I/O thread with HMP
> in the comment?

I do mind in a way (git doesn't really cope well with changing things in
the first patches of this series while the later patches move them to
different files - renaming mon_cmds resulted in a big mess and now I'm
kind of fed up with this kind of merge conflicts), but I'll do it
anyway. As long as it's only one line, it shouldn't be that hard to make
sure that it still exists at the end of the series...

> >> > @@ -748,12 +754,13 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> >> >                                  int64_t cpu_index, Error **errp)
> >> >  {
> >> >      char *output = NULL;
> >> > -    Monitor *old_mon, hmp;
> >> > +    Monitor *old_mon;
> >> > +    MonitorHMP hmp = {};
> >> 
> >> Any particular reason for adding the initializer?
> >
> > Yes:
> >
> >> >  
> >> > -    monitor_data_init(&hmp, 0, true, false);
> >> > +    monitor_data_init(&hmp.common, 0, true, false);
> >
> > monitor_data_init() does a memset(), but only on hmp.common, so the
> > fields outside of hmp.common would remain uniniitialised. Specifically,
> > hmp.rs wouldn't be initialised to NULL and attempting to free it in the
> > end would crash.
> 
> I see.
> 
> Drop the superfluous memset() in monitor_data_init() then.

Hm, yes, all callers already initialise the memory now, so that can be
done.

Kevin

