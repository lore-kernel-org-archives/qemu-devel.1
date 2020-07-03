Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840AEC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5144420936
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 13:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RUKOm0O+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5144420936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLSE-0001ns-HN
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 09:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrLRA-0000b0-Ax
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:09:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41863
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrLR7-0006gO-C7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 09:09:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593781740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxo2rsRhjFNTLgAh3vJS7PTiBhOMi8APjA6Kl5+KQd0=;
 b=RUKOm0O+7R5ugkm82SkEhwybs/zl6uIZDJt9ryX18WWANkUbfmREct9qSl1g6/jtXKviXP
 wTVxBLin3YDhj0bFZXY32hzAuIMsz+Z0t9RRxCu44YBb1nfenU0VbG2VSphAba1s1sDLpE
 Sio/GyTIbTIYsQQCLjqmQoexEFqHt3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169--4mgh1lxORqfpC9jFUSl5A-1; Fri, 03 Jul 2020 09:08:58 -0400
X-MC-Unique: -4mgh1lxORqfpC9jFUSl5A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E68018A0760;
 Fri,  3 Jul 2020 13:08:57 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 391EB2DE79;
 Fri,  3 Jul 2020 13:08:49 +0000 (UTC)
Date: Fri, 3 Jul 2020 14:08:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200703130846.GI2213227@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
 <20200701160906.GT126613@stefanha-x1.localdomain>
 <20200701161501.GJ1427561@redhat.com>
 <20200702134713.GH152912@stefanha-x1.localdomain>
 <lywo3kc3gh.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lywo3kc3gh.fsf@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 12:12:14PM +0200, Christophe de Dinechin wrote:
> 
> On 2020-07-02 at 15:47 CEST, Stefan Hajnoczi wrote...
> > On Wed, Jul 01, 2020 at 05:15:01PM +0100, Daniel P. Berrangé wrote:
> > At most it should require an
> >> extra annotation in the trace-events file to take the extra parameter
> >> for grouping, and other trace backends can ignore that.
> >
> > It's true, it may be possible to put this functionality in the
> > trace-events.
> 
> Let me think more about integrating these features with other trace
> backends. See below for short-term impact.
> 
> > Christophe: how does this differ from regular trace events and what
> > extra information is needed?
> 
> - Grouping, as indicated above, mostly useful in practice to make selection
>   of tracing topics easy (e.g. "modules") but also for real-time graphing,
>   because typically a state change occurs in different functions, which is
>   why I used locking as an example.

In many cases we already have a form of grouping via the backdoor by
using a common string prefix on trace point names. eg

qio_task_new(void *task, void *source, void *func, void *opaque) "Task new task=%p source=%p func=%p opaque=%p"
qio_task_complete(void *task) "Task complete task=%p"
qio_task_thread_start(void *task, void *worker, void *opaque) "Task thread start task=%p worker=%p opaque=%p"
qio_task_thread_run(void *task) "Task thread run task=%p"
qio_task_thread_exit(void *task) "Task thread exit task=%p"
qio_task_thread_result(void *task) "Task thread result task=%p"
qio_task_thread_source_attach(void *task, void *source) "Task thread source attach task=%p source=%p"
qio_task_thread_source_cancel(void *task, void *source) "Task thread source cancel task=%p source=%p"

We could turn this into an explicit multi-level grouping concept,
using "." separator for each level of the group. eg

qio.task.new(void *task, void *source, void *func, void *opaque) "Task new task=%p source=%p func=%p opaque=%p"
qio.task.complete(void *task) "Task complete task=%p"
qio.task.thread_start(void *task, void *worker, void *opaque) "Task thread start task=%p worker=%p opaque=%p"
qio.task.thread_run(void *task) "Task thread run task=%p"
qio.task.thread_exit(void *task) "Task thread exit task=%p"
qio.task.thread_result(void *task) "Task thread result task=%p"
qio.task.thread_source_attach(void *task, void *source) "Task thread source attach task=%p source=%p"
qio.task.thread_source_cancel(void *task, void *source) "Task thread source cancel task=%p source=%p"


For backends that dont support groups, the "." can be turned back
into a "_", and everything is unchanged. For backends that do support
groups, we now have the info required.

This would be useful for the systemtap backend because that has an
explicit grouping concept already. ie we have probes definitions
like:

probe qemu.system.x86_64.qio_task_new = process("/usr/bin/qemu-system-x86_64").mark("qio_task_new")
{
  task = $arg1;
  source = $arg2;
  func = $arg3;
  opaque = $arg4;
}


which we can now turn into

probe qemu.system.x86_64.qio.task.new = process("/usr/bin/qemu-system-x86_64").mark("qio_task_new")
{
  task = $arg1;
  source = $arg2;
  func = $arg3;
  opaque = $arg4;
}


the generated C trace macro would still use "_" not "." of course
so  qio_task_new(src, func, opaque)

> - Self-documentation. Right now, the recorder back-end generates rather
>   unhelpful help messages.

Not sure I understand the problem here.

> - Trace buffer size. This is important to make post-mortem dumps usable if
>   you record infrequent events alongside much higher-rate ones. For example,
>   you may want a large buffer to record info about command-line option
>   processing, the default 8 is definitely too small.

Sure, that's a problem for all the trace backends. They all need to be
good at filtering / controlling what probes are fired to avoid signal
getting lost in noise.  The grouping feature would certainly help with
that making it easier to control what it turned on/off.

> - Support for %+s, which tells that a string is safe to print later (e.g. it
>   is a compile-time constant, or never ever freed).

Seems we should be able to support that in the trace-events format string.
Any other backend can turn "%+s" back into a normal "%s".

> - Support for custom formats, e.g. I use %v in the XL compiler for LLVM
>   value pointers. This is a bit more advanced, but it would be neat to be
>   able to print out QOM objects using %q :-)

Seems like a similar trick can be used here. The %v/%q could be turned
back into a plain %p for backends which don't have the pretty-printing
support.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


