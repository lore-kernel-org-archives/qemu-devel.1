Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02761C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 05:49:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BAA2084D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 05:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BAA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbIcM-0003ZX-ES
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 01:49:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hbIZR-0000uH-03
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 01:46:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hbIRS-0005GD-3l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 01:38:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54162)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hbIRP-0005E1-OX; Thu, 13 Jun 2019 01:38:27 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E5253128B5;
 Thu, 13 Jun 2019 05:38:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C05B16EEE;
 Thu, 13 Jun 2019 05:38:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3AEE1138648; Thu, 13 Jun 2019 07:38:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-10-kwolf@redhat.com>
 <874l4vymlo.fsf@dusky.pond.sub.org>
 <20190612152536.GE9699@localhost.localdomain>
Date: Thu, 13 Jun 2019 07:38:23 +0200
In-Reply-To: <20190612152536.GE9699@localhost.localdomain> (Kevin Wolf's
 message of "Wed, 12 Jun 2019 17:25:36 +0200")
Message-ID: <87zhmmqc34.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 13 Jun 2019 05:38:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 09/11] monitor: Split out monitor/qmp.c
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
Cc: berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.06.2019 um 15:11 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>> 
>> > Move QMP infrastructure from monitor/misc.c to monitor/qmp.c. This is
>> > code that can be shared for all targets, so compile it only once.
>> 
>> Less code compiled per target, yay!
>> 
>> > The amount of function and particularly extern variables in
>> > monitor_int.h is probably a bit larger than it needs to be, but this way
>> > no non-trivial code modifications are needed. The interfaces between QMP
>> > and the monitor core can be cleaned up later.
>> 
>> That's okay.
>> 
>> I have to admit I naively expected the previous patch moved everything
>> to the new header we need in a header for splitting up monitor/misc.c.
>> How did you decide what to move to the header in which patch?
>
> The previous patch moved only the Monitor{HMP,QMP} data structures and
> their dependencies as I was sure these would be shared. Everything else
> was added to address linker complaints as I was going. I'll clarify this
> in the commit message of the previous patch.
>
>> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> > ---
>> >  include/monitor/monitor.h |   1 +
>> >  monitor/monitor_int.h     |  30 ++-
>> >  monitor/misc.c            | 394 +------------------------------------
>> >  monitor/qmp.c             | 404 ++++++++++++++++++++++++++++++++++++++
>> >  Makefile.objs             |   1 +
>> >  monitor/Makefile.objs     |   1 +
>> >  monitor/trace-events      |   4 +-
>> >  7 files changed, 448 insertions(+), 387 deletions(-)
>> >  create mode 100644 monitor/qmp.c
>> >
>> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> > index 1ba354f811..7bbab05320 100644
>> > --- a/include/monitor/monitor.h
>> > +++ b/include/monitor/monitor.h
>> > @@ -21,6 +21,7 @@ bool monitor_cur_is_qmp(void);
>> >  
>> >  void monitor_init_globals(void);
>> >  void monitor_init(Chardev *chr, int flags);
>> > +void monitor_init_qmp(Chardev *chr, int flags);
>> 
>> Why does this one go to the non-internal header?
>
> Most callers already know whether they want QMP or HMP, so they can just
> directly create the right thing instead of going through the
> monitor_init() wrapper.
>
> If you prefer, I can move it to the internal header, though. It's not
> called externally yet.

As is, monitor_init_qmp() and monitor_init_hmp() are awkward interfaces:
what if you pass MONITOR_USE_CONTROL to monitor_init_hmp()?

I can see just one call passing flags that aren't compile-time
constant.  I think a better interface would be

    monitor_init_hmp(Chardev *chr);
    monitor_init_qmp(Chardev *chr, bool pretty);

replacing monitor_init() entirely.  This is my first preference.

My (somewhat distant) second is hiding the awkward interfaces in the
internal header for now, and clean them up later.

Your choice.

>> >  void monitor_cleanup(void);
>> >  
>> >  int monitor_suspend(Monitor *mon);
>> > diff --git a/monitor/monitor_int.h b/monitor/monitor_int.h
>> > index 7122418955..4aabee54e1 100644
>> > --- a/monitor/monitor_int.h
>> > +++ b/monitor/monitor_int.h
>> > @@ -30,10 +30,11 @@
>> >  
>> >  #include "qapi/qmp/qdict.h"
>> >  #include "qapi/qmp/json-parser.h"
>> > -#include "qapi/qapi-commands.h"
>> > +#include "qapi/qmp/dispatch.h"
>> 
>> This part should be squashed into the previous patch.  You'll
>> additionally need qapi/qapi-types-misc.h for QMP_CAPABILITY__MAX there,
>> or keep monitor/monitor.h, even though you need it only here for
>> MONITOR_USE_CONTROL.
>
> Yes, already happened while addressing the comments you had for the
> header.
>
>> >  
>> >  #include "qemu/readline.h"
>> >  #include "chardev/char-fe.h"
>> > +#include "sysemu/iothread.h"
>> 
>> Perhaps IOThread should be typedef'ed in qemu/typedefs.h.  I'm not
>> asking you to do that.
>> 
>> >  
>> >  /*
>> >   * Supported types:
>> > @@ -145,4 +146,31 @@ typedef struct {
>> >      GQueue *qmp_requests;
>> >  } MonitorQMP;
>> >  
>> > +/**
>> > + * Is @mon a QMP monitor?
>> > + */
>> > +static inline bool monitor_is_qmp(const Monitor *mon)
>> > +{
>> > +    return (mon->flags & MONITOR_USE_CONTROL);
>> > +}
>> > +
>> > +typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
>> > +extern IOThread *mon_iothread;
>> > +extern QEMUBH *qmp_dispatcher_bh;
>> > +extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>> > +extern QemuMutex monitor_lock;
>> > +extern MonitorList mon_list;
>> > +extern int mon_refcount;
>> > +
>> > +int monitor_puts(Monitor *mon, const char *str);
>> > +void monitor_data_init(Monitor *mon, int flags, bool skip_flush,
>> > +                       bool use_io_thread);
>> > +int monitor_can_read(void *opaque);
>> > +void monitor_list_append(Monitor *mon);
>> > +void monitor_fdsets_cleanup(void);
>> > +
>> > +void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
>> > +void monitor_data_destroy_qmp(MonitorQMP *mon);
>> > +void monitor_qmp_bh_dispatcher(void *data);
>> > +
>> >  #endif
>> 
>> I trust you these are indeed all needed.
>
> The linker said so. :-)

I've seen people stuff random crap into headers just because, but I
trust you wouldn't do that :)

>> > diff --git a/monitor/qmp.c b/monitor/qmp.c
>> > new file mode 100644
>> > index 0000000000..d425b0f2ba
>> > --- /dev/null
>> > +++ b/monitor/qmp.c
>> > @@ -0,0 +1,404 @@
>> > +/*
>> > + * QEMU monitor
>> > + *
>> > + * Copyright (c) 2003-2004 Fabrice Bellard
>> 
>> I'm pretty confident nothing in this file is actually due to Fabrice.
>> 
>> > + *
>> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> > + * of this software and associated documentation files (the "Software"), to deal
>> > + * in the Software without restriction, including without limitation the rights
>> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>> > + * copies of the Software, and to permit persons to whom the Software is
>> > + * furnished to do so, subject to the following conditions:
>> > + *
>> > + * The above copyright notice and this permission notice shall be included in
>> > + * all copies or substantial portions of the Software.
>> > + *
>> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
>> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>> > + * THE SOFTWARE.
>> > + */
>> 
>> We inherit the non-standard license regardless.  Lesson learned: do not
>> add substantial code to source files with a non-standard license.
>
> Yes. Nothing I can change here now, though. The legally safe way for
> splitting files is to copy the license header.
>
>> > +
>> > +#include "qemu/osdep.h"
>> > +#include "monitor_int.h"
>> > +
>> > +#include "chardev/char-io.h"
>> > +
>> > +#include "qapi/error.h"
>> > +#include "qapi/qmp/qjson.h"
>> > +#include "qapi/qmp/qstring.h"
>> > +#include "qapi/qmp/qlist.h"
>> > +#include "qapi/qapi-commands-misc.h"
>> > +
>> > +#include "trace.h"
>> 
>> Please sort the includes alphabetically (except qemu/osdep.h, of
>> course).
>
> In other words, move monitor_int.h down and remove the empty lines?
>
> I like separating header files by "category", but that's a matter of
> taste. I'll follow yours if you tell me whether I understood it
> correctly.

Yes.

I hate the quasi-random order of #include we have in QEMU.  The ordering
method you describe would be okay with me, except for one thing: it
takes actual thought.  Alphabetical order can be enforced / fixed up by
a simple machine.

>> > +
>> > +struct QMPRequest {
>> > +    /* Owner of the request */
>> > +    MonitorQMP *mon;
>> > +    /*
>> > +     * Request object to be handled or Error to be reported
>> > +     * (exactly one of them is non-null)
>> > +     */
>> > +    QObject *req;
>> > +    Error *err;
>> > +};
>> > +typedef struct QMPRequest QMPRequest;
>> 
>> Please fuse these two.
>
> This is a code motion patch. Are you sure? [y/n]

Nevermind :)

