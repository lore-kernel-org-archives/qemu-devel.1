Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCB6C7618B
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 07:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6E72084C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 07:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6E72084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrGwg-0004af-AE
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 03:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hrGwV-0004CT-V6
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 03:16:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hrGwU-0006F6-Mz
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 03:16:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38582)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hrGwU-0006Dj-Fd
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 03:16:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B84603091761
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 07:16:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB1ED5D719;
 Sat, 27 Jul 2019 07:16:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5736A1138619; Sat, 27 Jul 2019 09:16:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <1562775267-1222-1-git-send-email-pbonzini@redhat.com>
 <1562775267-1222-5-git-send-email-pbonzini@redhat.com>
 <87d0ie58cj.fsf@dusky.pond.sub.org>
 <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com>
Date: Sat, 27 Jul 2019 09:16:26 +0200
In-Reply-To: <78c3bba3-3e85-682b-b4ce-fc4809add90e@redhat.com> (Paolo
 Bonzini's message of "Sat, 13 Jul 2019 23:26:24 +0200")
Message-ID: <87sgqsx7zp.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Sat, 27 Jul 2019 07:16:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/8] convert libqemuutil to meson
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 berrange@redhat.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/07/19 16:15, Markus Armbruster wrote:
>>>                    In particular the tracing headers are using
>>> $(build_root)/$(<D); for now my solution is to generate headers like
>>> "trace/trace-audio.h" and have sixty one-line forwarding headers in the
>>> source tree; for example "audio/trace.h" includes "trace/trace-audio.h".
>>> I'm not sure if it's possible to instead add a one-line "generate
>>> trace headers" directive to each subdirectory's meson.build file.
>>> I suspect that it _is_ possible but you'd still have to change the
>>> include directives to include the subdirectory name (and then I prefer
>>> the forwarding headers).
>> 
>> I agree we want to keep '#include "trace.h"'.

Hmm, maybe we don't.

Having to add '#include "trace.h"' to FOO.c along with the first
tracepoint isn't really valuable.  It's not terrible, either.

What we don't want is having to add '#include "trace-FOO.h", because
that crosses the annoyance line.

Can we avoid having to add any #include to FOO.c?

The include has to happen *somewhere*, of course.  Can we make it happen
in qemu/osdep.h?

Appending

    #include "trace.h"

to it works as long as there is a "trace.h", but also makes even .o not
using tracepoints depend on it.  No good.

So make it conditional:

    #ifdef USING_TRACEPOINTS
    #include "trace.h"
    #endif

with suitable provision to compile FOO.c with -DUSING_TRACEPOINTS
exactly when it uses tracepoints.

Ways to do that:

* Add 'FOO.o-cflags := -DUSING_TRACEPOINTS' to Makefile.objs.  This is
  even worse than having to add '#include "trace-FOO.h".

* Add something like 'trace-using-obj += FOO.c' to build up a list of
  tracepoint using .c, then use it to add the -D in one place.  This
  could be tolerable, I guess.

* Generate the list from trace-events.  Now we're talking.

At this point, we can just as well add

    #ifdef TRACE_HEADER
    #include TRACE_HEADER
    #endif

and pass -DTRACE_HEADER='"trace-DIR.h"'.  Look Ma, no forwarding
headers!

But avoiding the silly forwarding headers with Meson this is not even
half the advantage.  Let me take a short detour away from Meson.

We have trace-events with hundreds of tracepoints for tens of source
files.  The generated trace.h clock in at hundreds of KiB for me.
Messing with tracepoints in one source file recompiles most of the
directory.  This is so much better than it used to be, but clearly not
as good as it could be.

The worst of the lot is trace-root.h, which gets included for >1300 .o
in my "build everything" tree, mostly because it contains tracepoints
for static inline functions in widely included headers.  See also
"[PATCH 07/28] trace: Do not include qom/cpu.h into generated trace.h",
Message-Id: <20190726120542.9894-8-armbru@redhat.com>.

We started with a single trace-events.  That wasn't good, so we split it
up into one per directory.  That isn't good, so what about splitting it
up into one per source file?  Pass -DTRACE_HEADER='"trace-DIR-FOO.h"
instead of -DTRACE_HEADER='"trace-DIR.h"' when compiling DIR/FOO.c.

This is admittedly a half-baked idea.  It doesn't address tracepoints in
headers, yet.  But those headers are rare.  A quick grep finds some
twenty possibles.  Perhaps we can tolerate manual #include there.

Since we're discussing half-baked ideas already, let me throw out
another one: move the tracepoint declarations from trace-events into the
source files.  No more silly merge conflicts between patches related
only through a shared trace-events file.

One more: make the format string optional, default to one containing the
declared parameter names and the obvious conversion specifications.
Because format strings like this one

    visit_start_struct(void *v, const char *name, void *obj, size_t size) "v=%p name=%s obj=%p size=%zu"

add zero bits of information to the declaration preceding it :)

[...]

