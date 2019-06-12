Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B730AC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE73215EA
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE73215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33184 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5K7-0006Ji-Px
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36320)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hb5Dy-0001zy-8Q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hb5Dx-000168-0P
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:31:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43244)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hb5Dj-0000ob-PJ; Wed, 12 Jun 2019 11:31:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E72B581DFB;
 Wed, 12 Jun 2019 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-60.ams2.redhat.com
 [10.36.117.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CC3595DD7E;
 Wed, 12 Jun 2019 15:31:09 +0000 (UTC)
Date: Wed, 12 Jun 2019 17:31:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190612153108.GF9699@localhost.localdomain>
References: <20190611134043.9524-1-kwolf@redhat.com>
 <20190611134043.9524-11-kwolf@redhat.com>
 <87wohrx7r7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wohrx7r7.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 12 Jun 2019 15:31:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 10/11] monitor: Split out monitor/hmp.c
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

Am 12.06.2019 um 15:17 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Move HMP infrastructure from monitor/misc.c to monitor/hmp.c. This is
> > code that can be shared for all targets, so compile it only once.
> >
> > The amount of function and particularly extern variables in
> > monitor_int.h is probably a bit larger than it needs to be, but this way
> > no non-trivial code modifications are needed. The interfaces between HMP
> > and the monitor core can be cleaned up later.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/monitor/monitor.h |    1 +
> >  monitor/monitor_int.h     |   31 +
> >  monitor/hmp.c             | 1387 +++++++++++++++++++++++++++++++++++++
> >  monitor/misc.c            | 1338 +----------------------------------
> >  monitor/Makefile.objs     |    2 +-
> >  monitor/trace-events      |    4 +-
> >  6 files changed, 1429 insertions(+), 1334 deletions(-)
> >  create mode 100644 monitor/hmp.c
> >
> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> > index 7bbab05320..8547529e49 100644
> > --- a/include/monitor/monitor.h
> > +++ b/include/monitor/monitor.h
> > @@ -22,6 +22,7 @@ bool monitor_cur_is_qmp(void);
> >  void monitor_init_globals(void);
> >  void monitor_init(Chardev *chr, int flags);
> >  void monitor_init_qmp(Chardev *chr, int flags);
> > +void monitor_init_hmp(Chardev *chr, int flags);
> >  void monitor_cleanup(void);
> >  
> >  int monitor_suspend(Monitor *mon);
> > diff --git a/monitor/monitor_int.h b/monitor/monitor_int.h
> > index 4aabee54e1..88eaed9c5c 100644
> > --- a/monitor/monitor_int.h
> > +++ b/monitor/monitor_int.h
> > @@ -27,6 +27,7 @@
> >  
> >  #include "qemu-common.h"
> >  #include "monitor/monitor.h"
> > +#include "qemu/cutils.h"
> >  
> >  #include "qapi/qmp/qdict.h"
> >  #include "qapi/qmp/json-parser.h"
> > @@ -154,6 +155,29 @@ static inline bool monitor_is_qmp(const Monitor *mon)
> >      return (mon->flags & MONITOR_USE_CONTROL);
> >  }
> >  
> > +/**
> > + * Is @name in the '|' separated list of names @list?
> > + */
> > +static inline int compare_cmd(const char *name, const char *list)
> > +{
> > +    const char *p, *pstart;
> > +    int len;
> > +    len = strlen(name);
> > +    p = list;
> > +    for (;;) {
> > +        pstart = p;
> > +        p = qemu_strchrnul(p, '|');
> > +        if ((p - pstart) == len && !memcmp(pstart, name, len)) {
> > +            return 1;
> > +        }
> > +        if (*p == '\0') {
> > +            break;
> > +        }
> > +        p++;
> > +    }
> > +    return 0;
> > +}
> > +
> 
> What's the justification for inline?

It seemed small enough, but maybe it isn't (it has also grown by two
lines after fixing the coding style). I can leave it in misc.c and just
make it public.

I'd just need a more specific name than compare_cmd() to make it public.

> >  typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
> >  extern IOThread *mon_iothread;
> >  extern QEMUBH *qmp_dispatcher_bh;
> > @@ -162,6 +186,8 @@ extern QemuMutex monitor_lock;
> >  extern MonitorList mon_list;
> >  extern int mon_refcount;
> >  
> > +extern mon_cmd_t mon_cmds[];
> > +
> 
> Any particular reason for not moving this one to hmp.c, along with
> info_cmds?  Question, not demand :)

Yes, it's not part of the core infrastructure, but contains commands
specific to the system emulator. If a tool were to use HMP, it would
have to provide its own command tables.

If we ever create a monitor/hmp-sysemu.c or something like it, this
would be a good place for the tables.

Kevin

