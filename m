Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FDCC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C566C20899
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g62CY+c0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C566C20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOpa-0000e2-1J
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrOow-0000CS-Lf
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:45:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27169
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jrOot-0004af-Mo
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 12:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593794746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R8DCxznmnJ5FcXZ0CKBOQXZ32IYzJuP1vFYuPwDzbww=;
 b=g62CY+c0rfNWUAG/f10JT3JvfbmiEhLt5WPUmn6WoovIeVT/8pOTyBqeRRmPEhoCsMqVOJ
 9z87opQxbD6alGCRlZwcRGqoizSJ5XJmCbF6KwJGIf1Cm3K7SBr6xCw7+OnsJOeyXzYkBo
 DSNqOEc/iHSlSVoL9bPKwmrdIo917ao=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-H_SsqJfpNImkfMnQSBqRuQ-1; Fri, 03 Jul 2020 12:45:42 -0400
X-MC-Unique: H_SsqJfpNImkfMnQSBqRuQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA8471005510;
 Fri,  3 Jul 2020 16:45:40 +0000 (UTC)
Received: from titinator (ovpn-113-254.ams2.redhat.com [10.36.113.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B3A067BD56;
 Fri,  3 Jul 2020 16:45:35 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
 <20200630124136.GM1370404@redhat.com>
 <20200701160906.GT126613@stefanha-x1.localdomain>
 <20200701161501.GJ1427561@redhat.com>
 <20200702134713.GH152912@stefanha-x1.localdomain> <lywo3kc3gh.fsf@redhat.com>
 <20200703130846.GI2213227@redhat.com>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
In-reply-to: <20200703130846.GI2213227@redhat.com>
Date: Fri, 03 Jul 2020 18:45:33 +0200
Message-ID: <lypn9cbl8y.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-03 at 15:08 CEST, Daniel P. Berrang=C3=A9 wrote...
> On Fri, Jul 03, 2020 at 12:12:14PM +0200, Christophe de Dinechin wrote:
>>
>> On 2020-07-02 at 15:47 CEST, Stefan Hajnoczi wrote...
>> > On Wed, Jul 01, 2020 at 05:15:01PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>> > At most it should require an
>> >> extra annotation in the trace-events file to take the extra parameter
>> >> for grouping, and other trace backends can ignore that.
>> >
>> > It's true, it may be possible to put this functionality in the
>> > trace-events.
>>
>> Let me think more about integrating these features with other trace
>> backends. See below for short-term impact.
>>
>> > Christophe: how does this differ from regular trace events and what
>> > extra information is needed?
>>
>> - Grouping, as indicated above, mostly useful in practice to make select=
ion
>>   of tracing topics easy (e.g. "modules") but also for real-time graphin=
g,
>>   because typically a state change occurs in different functions, which =
is
>>   why I used locking as an example.
>
> In many cases we already have a form of grouping via the backdoor by
> using a common string prefix on trace point names. eg
>
> qio_task_new(void *task, void *source, void *func, void *opaque) "Task ne=
w task=3D%p source=3D%p func=3D%p opaque=3D%p"
> qio_task_complete(void *task) "Task complete task=3D%p"
> qio_task_thread_start(void *task, void *worker, void *opaque) "Task threa=
d start task=3D%p worker=3D%p opaque=3D%p"
> qio_task_thread_run(void *task) "Task thread run task=3D%p"
> qio_task_thread_exit(void *task) "Task thread exit task=3D%p"
> qio_task_thread_result(void *task) "Task thread result task=3D%p"
> qio_task_thread_source_attach(void *task, void *source) "Task thread sour=
ce attach task=3D%p source=3D%p"
> qio_task_thread_source_cancel(void *task, void *source) "Task thread sour=
ce cancel task=3D%p source=3D%p"
>
> We could turn this into an explicit multi-level grouping concept,
> using "." separator for each level of the group. eg

Interesting idea.

>
> qio.task.new(void *task, void *source, void *func, void *opaque) "Task ne=
w task=3D%p source=3D%p func=3D%p opaque=3D%p"
> qio.task.complete(void *task) "Task complete task=3D%p"
> qio.task.thread_start(void *task, void *worker, void *opaque) "Task threa=
d start task=3D%p worker=3D%p opaque=3D%p"
> qio.task.thread_run(void *task) "Task thread run task=3D%p"
> qio.task.thread_exit(void *task) "Task thread exit task=3D%p"
> qio.task.thread_result(void *task) "Task thread result task=3D%p"
> qio.task.thread_source_attach(void *task, void *source) "Task thread sour=
ce attach task=3D%p source=3D%p"
> qio.task.thread_source_cancel(void *task, void *source) "Task thread sour=
ce cancel task=3D%p source=3D%p"
>
>
> For backends that dont support groups, the "." can be turned back
> into a "_", and everything is unchanged. For backends that do support
> groups, we now have the info required.
>
> This would be useful for the systemtap backend because that has an
> explicit grouping concept already. ie we have probes definitions
> like:
>
> probe qemu.system.x86_64.qio_task_new =3D process("/usr/bin/qemu-system-x=
86_64").mark("qio_task_new")
> {
>   task =3D $arg1;
>   source =3D $arg2;
>   func =3D $arg3;
>   opaque =3D $arg4;
> }
>
>
> which we can now turn into
>
> probe qemu.system.x86_64.qio.task.new =3D process("/usr/bin/qemu-system-x=
86_64").mark("qio_task_new")
> {
>   task =3D $arg1;
>   source =3D $arg2;
>   func =3D $arg3;
>   opaque =3D $arg4;
> }
>
>
> the generated C trace macro would still use "_" not "." of course
> so  qio_task_new(src, func, opaque)
>
>> - Self-documentation. Right now, the recorder back-end generates rather
>>   unhelpful help messages.
>
> Not sure I understand the problem here.

RECORDER_DEFINE specifies a text that is listed when you pass "help" as a
trace name. There is no equivalent concept that I'm aware of in the existin=
g
qemu trace infrastructure.

>
>> - Trace buffer size. This is important to make post-mortem dumps usable =
if
>>   you record infrequent events alongside much higher-rate ones. For exam=
ple,
>>   you may want a large buffer to record info about command-line option
>>   processing, the default 8 is definitely too small.
>
> Sure, that's a problem for all the trace backends. They all need to be
> good at filtering / controlling what probes are fired to avoid signal
> getting lost in noise.  The grouping feature would certainly help with
> that making it easier to control what it turned on/off.

Well, for the recorder it's a slightly different problem. When you do a
recorder post-mortem dump, entries are sorted and printed at that time. THi=
s
makes it possible to have a number of recent traces for high-frequency
events, as well as some much older traces for low-frequency events.

For example, you can have a buffer that records command-line options, and
another that records events that occur typically once per second, and yet
another that records high-frequency events. Then, when your program crashes
and you look at a dump, you see a context that includes both recent
high-frequency stuff as well as much older low-frequency events.

See https://gitlab.com/c3d/recorder for examples.


>
>> - Support for %+s, which tells that a string is safe to print later (e.g=
. it
>>   is a compile-time constant, or never ever freed).
>
> Seems we should be able to support that in the trace-events format string=
.
> Any other backend can turn "%+s" back into a normal "%s".

Yes, but it's much more complicated than this simple patch series ;-) As is=
,
the goal of this series is to not touch any other back-end.

>
>> - Support for custom formats, e.g. I use %v in the XL compiler for LLVM
>>   value pointers. This is a bit more advanced, but it would be neat to b=
e
>>   able to print out QOM objects using %q :-)
>
> Seems like a similar trick can be used here. The %v/%q could be turned
> back into a plain %p for backends which don't have the pretty-printing
> support.

Sure, but this is also touching the rest of the tracing infrastructure,
which was a definite non-goal for this specific series.

>
> Regards,
> Daniel


--
Cheers,
Christophe de Dinechin (IRC c3d)


