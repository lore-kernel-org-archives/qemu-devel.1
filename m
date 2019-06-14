Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67414C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:49:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9322133D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 08:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9322133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbhtr-0003HH-I9
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 04:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hbhrd-0002Hh-Dx
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:47:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hbhrc-0004uF-9G
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 04:47:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56870)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hbhrZ-0004sc-Kt; Fri, 14 Jun 2019 04:47:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5923C83F44;
 Fri, 14 Jun 2019 08:47:06 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 197F47C584;
 Fri, 14 Jun 2019 08:47:03 +0000 (UTC)
Date: Fri, 14 Jun 2019 10:47:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190614084702.GA6042@dhcp-200-226.str.redhat.com>
References: <20190613153405.24769-1-kwolf@redhat.com>
 <20190613153405.24769-10-kwolf@redhat.com>
 <87h88shdue.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h88shdue.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 14 Jun 2019 08:47:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 09/15] monitor: Create
 monitor-internal.h with common definitions
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

Am 14.06.2019 um 08:37 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> 
> > Before we can split monitor/misc.c, we need to create a header file that
> > contains the common definitions that will be used by multiple source
> > files.
> >
> > For a start, add the type definitions for Monitor, MonitorHMP and
> > MonitorQMP and their dependencies. We'll add functions as needed when
> > splitting monitor/misc.c.
> >
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  monitor/monitor-internal.h | 148 +++++++++++++++++++++++++++++++++++++
> >  monitor/misc.c             | 110 +--------------------------
> >  MAINTAINERS                |   2 +
> >  3 files changed, 151 insertions(+), 109 deletions(-)
> >  create mode 100644 monitor/monitor-internal.h
> >
> > diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> > new file mode 100644
> > index 0000000000..17a632b0ad
> > --- /dev/null
> > +++ b/monitor/monitor-internal.h
> > @@ -0,0 +1,148 @@
> > +/*
> > + * QEMU monitor
> > + *
> > + * Copyright (c) 2003-2004 Fabrice Bellard
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a copy
> > + * of this software and associated documentation files (the "Software"), to deal
> > + * in the Software without restriction, including without limitation the rights
> > + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> > + * copies of the Software, and to permit persons to whom the Software is
> > + * furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> > + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> > + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> > + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> > + * THE SOFTWARE.
> > + */
> > +
> > +#ifndef MONITOR_INT_H
> > +#define MONITOR_INT_H
> 
> Rename to MONITOR_INTERNAL_H, so it again matches the file name.  Can
> touch up in my tree.

Oops, yes, please do.

> > +
> > +#include "monitor/monitor.h"
> > +#include "qapi/qmp/qdict.h"
> 
> These too are superfluous.  I'm willing to tolerate monitor.h anyway,
> since anything including monitor-internal.h is almost certainly going to
> need monitor.h, too.

I tried to drop them because you suggested so, but it results in compile
errors. On closer look, I think qdict.h can go because the typedef will
be present through qemu/osdep.h, which must be included before this one,
but MonitorHMP is only defined by monitor/monitor.h.

> > +#include "qapi/qmp/json-parser.h"
> > +#include "qapi/qmp/dispatch.h"
> > +#include "qapi/qapi-types-misc.h"
> > +
> > +#include "qemu/readline.h"
> > +#include "chardev/char-fe.h"
> > +#include "sysemu/iothread.h"
> 
> Another superfluous one.

IOThread is only defined by system/iothread.h, so I don't think you can
remove this one either.

> Happy to drop these two #include in my tree.

As long as the result still builds, feel free to drop includes from the
header (and probably add them to source files instead where they will be
missing then).

Kevin

