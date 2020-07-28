Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06801C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:50:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5FFC206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn0dnKjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FFC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0O80-0001kc-0O
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0O7K-0001CQ-Bd
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:49:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60762
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1k0O7H-0003ta-Hx
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 07:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595936994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9eKNN/yMYXjoW9FgWv1cJXHJmoxbYd2z/e558xaIOb8=;
 b=Yn0dnKjLXH6gF22z4jj5cXvUhSbHl36+je2608L76GOSavY/c99niT5r2Fya4J1N0KvfpM
 BrPtSH3bjmgVP1Nc/ZCXLvR1h+0GQBhqdtn2l8UMpTwSPGxxpDc9WSuDgYs1z+qdA0SDTV
 cvy8iP3blSdaXSjupPAT92PrNRRNQxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-fiYkIHh9NhqWNCuF-PXNYg-1; Tue, 28 Jul 2020 07:49:51 -0400
X-MC-Unique: fiYkIHh9NhqWNCuF-PXNYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99B3C10059A2;
 Tue, 28 Jul 2020 11:49:50 +0000 (UTC)
Received: from titinator (ovpn-114-132.ams2.redhat.com [10.36.114.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38CED726BE;
 Tue, 28 Jul 2020 11:49:44 +0000 (UTC)
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-3-dinechin@redhat.com>
 <20200630130257.GP1370404@redhat.com> <7ha6zq2zxr.fsf@turbo.dinechin.lan>
 <87mu3qgwbx.fsf@dusky.pond.sub.org> <7ha6zq2ooj.fsf@turbo.dinechin.lan>
 <87pn8h5puj.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.5.2; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 2/3] trace: Add support for recorder back-end
In-reply-to: <87pn8h5puj.fsf@dusky.pond.sub.org>
Date: Tue, 28 Jul 2020 13:49:43 +0200
Message-ID: <lya6zjhnag.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-07-27 at 10:23 CEST, Markus Armbruster wrote...
> Christophe de Dinechin <dinechin@redhat.com> writes:
>
>> On 2020-07-23 at 16:06 CEST, Markus Armbruster wrote...
>>> Christophe de Dinechin <dinechin@redhat.com> writes:
>>>
>>>> On 2020-06-30 at 15:02 CEST, Daniel P. Berrang=C3=A9 wrote...
>>>>> On Fri, Jun 26, 2020 at 06:27:05PM +0200, Christophe de Dinechin wrot=
e:
>>>>>> The recorder library provides support for low-cost continuous
>>>>>> recording of events, which can then be replayed. This makes it
>>>>>> possible to collect data "after the fact",for example to show the
>>>>>> events that led to a crash.
>>>>>>
>>>>>> Recorder support in qemu is implemented using the existing tracing
>>>>>> interface. In addition, it is possible to individually enable
>>>>>> recorders that are not traces, although this is probably not
>>>>>> recommended.
>>>>>>
>>>>>> HMP COMMAND:
>>>>>> The 'recorder' hmp command has been added, which supports two
>>>>>> sub-commands:
>>>>>> - recorder dump: Dump the current state of the recorder. You can
>>>>>> - recorder trace: Set traces using the recorder_trace_set() syntax.
>>>>>>   You can use "recorder trace help" to list all available recorders.
>>>>>>
>>>>>> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
>>>>>> ---
>>>>>>  configure                             |  5 +++
>>>>>>  hmp-commands.hx                       | 19 ++++++++--
>>>>>>  monitor/misc.c                        | 27 ++++++++++++++
>>>>>>  scripts/tracetool/backend/recorder.py | 51 ++++++++++++++++++++++++=
+++
>>>>>>  trace/Makefile.objs                   |  2 ++
>>>>>>  trace/control.c                       |  7 ++++
>>>>>>  trace/recorder.c                      | 22 ++++++++++++
>>>>>>  trace/recorder.h                      | 34 ++++++++++++++++++
>>>>>>  util/module.c                         |  8 +++++
>>>>>>  9 files changed, 173 insertions(+), 2 deletions(-)
>>>>>>  create mode 100644 scripts/tracetool/backend/recorder.py
>>>>>>  create mode 100644 trace/recorder.c
>>>>>>  create mode 100644 trace/recorder.h
>>>>>
>>>>>> +RECORDER_CONSTRUCTOR
>>>>>> +void recorder_trace_init(void)
>>>>>> +{
>>>>>> +    recorder_trace_set(getenv("RECORDER_TRACES"));
>>>>>> +
>>>>>> +    // Allow a dump in case we receive some unhandled signal
>>>>>> +    // For example, send USR2 to a hung process to get a dump
>>>>>> +    if (getenv("RECORDER_TRACES"))
>>>>>> +        recorder_dump_on_common_signals(0,0);
>>>>>> +}
>>>>>
>>>>> What is the syntax of this RECORDER_TRACES env variable,
>>>>
>>>> It's basically a colon-separated list of regexps,
>>>> e.g. ".*_error:.*_warning", with special syntax for some additional
>>>> functionality such as real-time graphing.
>>>>
>>>> Here are a few examples:
>>>>
>>>> - Activate the foo, bar and baz traces:
>>>>       foo:bar:baz
>>>>
>>>> - Activate all traces that contain "lock", as well as "recorder" trace=
:
>>>>       *lock.*:recorder
>>>>
>>>> - Deactivate traces ending in _error
>>>>       .*_error=3D0
>>>>
>>>> There are also a few tweaks and special names, for example you can adj=
ust
>>>> the output to show the function name and source code location as follo=
ws::
>>>>
>>>> - Show source information in the traces
>>>>       recorder_function:recorder_location
>>>>
>>>>   As is not very useful in qemu because it sohws the wrapper location:
>>>>      % RECORDER_TRACES=3Dvm_state_notify qemu-system-x86_64
>>>>      [35225 7.092175] vm_state_notify: running 1 reason 9 (running)
>>>>
>>>>      % RECORDER_TRACES=3Dvm_state_notify:recorder_function:recorder_lo=
cation qemu-system-x86_64
>>>>      /home/ddd/Work/qemu/trace-root.h:346:_nocheck__trace_vm_state_not=
ify:[94277 0.294906] vm_state_notify: running 1 reason 9 (running)
>>>>
>>>>   This is not as good as what you get with "real" record entries:
>>>>      % RECORDER_TRACES=3Drecorder_function:recorder_location:recorder =
qemu-system-x86_64
>>>>      recorder.c:2036:recorder_allocate_alt_stack:[29561 0.006434] reco=
rder: Set alt stack to 0x7fc567b87000 size 8192
>>>>
>>>> - Get some help on available traces:
>>>>       help
>>>>
>>>> - Enable real-time graphing for trace "perfdata"
>>>>       perfdata=3Dbytes,loops
>>>>
>>>> The last one assumes that you would have a record that looks like:
>>>>
>>>>      record(perfdata, "Transferred %lu bytes in %lu iterations",
>>>>             bytes, itercount);
>>>>
>>>> You could then have a real-time graph of the values for variables "byt=
es"
>>>> and "itercount" using the recorder_scope program, and using the names =
you
>>>> gave to the channels in your RECORDER_TRACES variable, i.e. bytes and =
loops:
>>>>
>>>>      recorder_scope bytes loops
>>>>
>>>> See man recorder_trace_set(3), recorder_scope(1) or
>>>> https://github.com/c3d/recorder#recorder-tracing for more information.
>>>>
>>>>
>>>>> and perhaps more importantly should we have this modelled as a comman=
d
>>>>> line arg instead of an env variable. We've generally been aiming to g=
et
>>>>> rid of env variables and have QAPI modelled CLI. QAPI modelling would=
 be
>>>>> particularly important if we want to expose the ablity to change sett=
ings
>>>>> on the fly via QMP.
>>>>
>>>> The rationale for the recorder using an environment variable is that i=
t was
>>>> initially designed to be able to trace libraries, notably SPICE or the
>>>> recorder library itself. A single environment variable can be used to
>>>> activate traces in the main binary as well as in the libraries.
>>>
>>> Makes sense.
>>>
>>>> I'm certainly not against adding a command-line option to activate rec=
order
>>>> options specifically, but as I understand, the option -trace already e=
xists,
>>>> and its semantics is sufficiently different from the one in recorder
>>>> patterns that I decided to not connect the two for now. For example, t=
o
>>>> disable trace foo, you'd pass "-foo" to the -trace option, but "foo=3D=
0" to
>>>> RECORDER_TRACES. The parsing of graphing options and other related
>>>> recorder-specific stuff is a bit difficult to integrate with -trace to=
o.
>>>
>>> We need proper integration with the existing trace UI.
>>
>> I agree, but I don't think this belongs to this particular patch series.
>> See below why.
>>
>>>
>>> In particular, the ability to enable and disable trace events
>>> dynamically provided by QMP commands trace-event-get-state,
>>> trace-event-set-state, and HMP command trace-event is really useful.
>>
>> That ability exists, but given the many differences between the
>> recorder and other tracing mechanisms, I found it useful to add a specif=
ic
>> "recorder" command.
>
> Precedence for commands specific to a trace backend: trace-file.
>
> Name yours trace-recorder?

But then "recorder dump" does not fit with any "trace" concept.

>
>> For example, assuming I built with both recorder and log trace backends,
>> from the monitor, I can type:
>>
>>   trace-event kvm_run_exit on
>>
>> What I get then is something like that:
>>
>>   2091091@1595518935.441273:kvm_run_exit cpu_index 0, reason 2
>>   2091091@1595518935.441292:kvm_run_exit cpu_index 0, reason 2
>>   2091091@1595518935.441301:kvm_run_exit cpu_index 0, reason 2
>>   2091091@1595518935.441309:kvm_run_exit cpu_index 0, reason 2
>>   2091091@1595518935.441254:kvm_run_exit cpu_index 0, reason 2
>>
>> It would not be very useful to activate recorder traces as well when tha=
t
>> happens, which would have the undesired side effect of purging any
>> corresponding entry from a following recorder dump.
>
> I'm afraid I don't understand, because the gaps in my understanding of
> what the recorder can do are just too big.

There is a video at the top of https://github.com/c3d/recorder, or direct
link https://www.youtube.com/watch?v=3DkEnQY1zFa0Y. Hope this helps.


>
> From your cover letter:
>
>     1. Flight recorder: Dump information on recent events in case of cras=
h
>
> Define "recent events", please.  Is it all trace events (except for the
> ones disabled at build time, of course)?

For event categories only known through qemu trace definitions, by default,
it's the last 8 events. If you manually declare a recorder, then you can
specify any size.

(The difference between this manual recorder usage and the recorder backend
generated code is similar to the difference between the log backend and
"DPRINTF")

>
> "Flight recorder" hints at recording in some ring buffer.  True?

Yes.

>
> Can you explain the difference to trace backend "ftrace"?

- It's not recording function calls nor stack traces.
- It's faster (no fd write, no % parameter expansion)
- It works on non-Linux platforms
- It's always on

>
>     2. Tracing: Individual traces can be enabled using environment variab=
les
>
> I guess "individual traces" means "individual trace events".

Maybe I'm unwittingly opposing some well-established qemu habits here, as
indicated by the "trace-event" command, but to me, a "trace" reports multip=
le
"events" of the same class (distinguished e.g. by their timestamps). So I
would say that I am indeed enabling a trace in order to be shown all the
events associated to this trace.

Does that make sense?

But then I understand that the existing command is called "trace-event".
So there's that. I don't mind changing the text that much.

>
> What does it mean to enable a trace event?  How does this affect the
> recorder's behavior?

For a given recorder instrumentation point, three things can happen:
- It is recorded in a circular buffer (always)
- If tracing is active, then a trace message is displayed
- If sharing is active, then it is copied in shared memory for use by some
  external program, e.g. recorder_scope.


>
>     3. Real-time graphing / control, using the recorder_scope application
>
> I'm ignoring this one for now.
>
>> There are, however, new monitor commands, so now I can do:
>>
>>   recorder trace kvm_run_exit
>>
>> I now get an output where each trace shows up twice.
>>
>>   [120139718 137.127269] kvm_run_exit: cpu_index 0, reason 2
>>   2091091@1595518954.209803:kvm_run_exit cpu_index 0, reason 2
>>   [120139734 137.127281] kvm_run_exit: cpu_index 0, reason 2
>>   2091091@1595518954.209814:kvm_run_exit cpu_index 0, reason 2
>>   [120139751 137.127293] kvm_run_exit: cpu_index 0, reason 2
>>
>>  I don't find particularly useful, so I don't think having that as the
>> normal behaviour would qualify as what you called proper integration.
>
> Well, I asked for it by configuring two trace backends, didn't I?

Not really IMO. By configuring two trace backends, what you requested was t=
o
have two different kinds of instrumentation active at the same time. It doe=
s
not imply (at least to me) that these two kinds of instrumentation have to
react to *run-time* configuration identically, in particular if that means
in a way that happens to not be helpful.

If you configure log and ftrace, you are not requesting them to behave
identically at run time.


>
> If I configured just the recorder backend, would I get a useful trace?

Yes, but not the full functionality that "recorder" gives you.
Notably, there is nothing in the existing trace-event command that would
allow me to configure recorder sharing or trace output format, whereas the
proposed patch allows me to do that.

>
> If yes, what's wrong with letting me control what's being traced with
> the common trace-event command in addition to a backend-specific
> command?

This would force that code to a lower common denominator that would remove =
a
lot of useful functionality specific to the recorder, even assuming we keep
both the "recorder" and "trace-event" commands to configure the recorder.

There is a problem with the semantics of the underlying API. For example,
disabling trace foo is "-foo" in qemu, "foo=3D0" in the recorder API. I don=
't
really like the idea of adding some string manipulation code to transform
"-foo" into "foo=3D0". I would prefer to extend the recorder API to accept
-foo, but that's not the case today.

Things get worse for multiple traces. In qemu, you would have
"virtio_blk_*", for the recorder it is "virtio_blk_.*" (it's a true regexp)=
.
So examples from the recorder documentation such as ".*_(error|warning)"
will not work with trace-enable, and you'd have to convert the qemu syntax
to true regexps to pass them to the recorder API, which is borderline
insanity.


>
>> Having a separate recorder command, OTOH, allows me to also do things
>> that are not possible with other trace back-ends, and presumably never w=
ill
>
> I'm not arguing against an additional recorder command to control things
> only the recorder backend can do.

I am also favorable to trying to see if a better integration would make
sense, but that would be a much more intrusive patch, with an impact on
other trace backends, e.g. add some back-end specific callback to parse the
parameter of "trace-event" to allow for more than "on|off", and possibly to
switch to true regexps or something like that for multiple traces, which
undoubtedly would break many a script.


>
>> be, like:
>>
>>     recorder trace kvm_run_exit=3Dcpu,reason
>>
>> That configures things so that I can now do real-time graphing using
>> recorder-scope. The only output from qemu will be:
>>
>>   Creating new /tmp/recorder_share
>>
>> But I can now run somewhere else:
>>
>>    recorder_scope cpu reason
>>
>> and have a real-time view of what is happening in my qemu. Not particula=
rly
>> interesting with existing instrumentation, which was not designed for
>> graphing, but that's easily changed.
>>
>> Another key feature I get from the new monitor command is
>>
>>   recorder dump
>>
>> Now the output will be something like (cut for brevity)
>>
>>   [150261271 461.814366] lock: Locked state 2 for 0x55d842d66d18
>>   [150261272 461.814366] qemu_mutex_unlock: released mutex 0x55d842d66d1=
8 (0x55d840d032c0:119)
>>   [150261273 461.814366] lock: Unkocked state 0 for 0x55d842d66d18
>>   [150261274 461.814367] lockcnt_fast_path_attempt: lockcnt 0x55d842b630=
ec fast path 0->4
>>   [150261275 461.814367] lockcnt_fast_path_success: lockcnt 0x55d842b630=
ec fast path 0->4 succeeded
>>   [150261276 461.814515] qemu_mutex_lock: waiting on mutex 0x55d842ded59=
0 (0x55d840c63019:161)
>>   [150261277 461.814515] lock: Locking state 1 for 0x55d842ded590
>>   [150261278 461.814515] qemu_mutex_locked: taken mutex 0x55d842ded590 (=
0x55d840c63019:161)
>>   [150261279 461.814515] lock: Locked state 2 for 0x55d842ded590
>>   [150261280 461.814517] object_class_dynamic_cast_assert: 0x55d842dea5e=
0->0x55d840cdfcc0 (0x55d840cdfcb1:114:0x55d840ce02a0)
>>   [150261281 461.814518] qemu_mutex_lock: waiting on mutex 0x55d842db27b=
8 (0x55d840cdfcb1:118)
>>   [150261282 461.814518] lock: Locking state 1 for 0x55d842db27b8
>>   [150261283 461.814518] qemu_mutex_locked: taken mutex 0x55d842db27b8 (=
0x55d840cdfcb1:118)
>>   [150261284 461.814518] lock: Locked state 2 for 0x55d842db27b8
>>   [150261285 461.814518] object_dynamic_cast_assert: 0x55d842dea5e0->0x7=
f7f88f304d9 (0x7f7f88f304d0:1668:0x7f7f88f308c0)
>>   [150261286 461.814521] qemu_mutex_unlock: released mutex 0x55d842db27b=
8 (0x55d840cdfcb1:143)
>>   [150261287 461.814521] lock: Unkocked state 0 for 0x55d842db27b8
>>   [150261288 461.814523] qemu_mutex_unlock: released mutex 0x55d842ded59=
0 (0x55d840c63019:172)
>>   [150261289 461.814523] lock: Unkocked state 0 for 0x55d842ded590
>>   [150261290 461.814524] monitor_suspend: mon 0x55d842ded530: 1
>>   [150261291 461.814525] handle_hmp_command: mon 0x55d842ded530 cmdline:=
 0x55d842e18d50
>>   [150261292 461.814537] recorder: Recorder dump
>>
>> Of course, in general, you will probably want to focus on some particula=
r
>> trace after an event happened, e.g.
>>
>>   recorder dump qemu_mutex_unlock
>>
>> which will get you:
>>
>>   [150617808 508.134486] qemu_mutex_unlock: released mutex 0x55d842d6689=
8 (0x55d840d032c0:119)
>>   [150617814 508.134487] qemu_mutex_unlock: released mutex 0x55d842d6691=
8 (0x55d840d032c0:119)
>>   [150617820 508.134489] qemu_mutex_unlock: released mutex 0x55d842d66d1=
8 (0x55d840d032c0:119)
>>   [150617822 508.134494] qemu_mutex_unlock: released mutex 0x55d84136050=
0 (0x55d840b85f40:1790)
>>   [150617834 508.136546] qemu_mutex_unlock: released mutex 0x55d842d66d1=
8 (0x55d840d032c0:119)
>>   [150617848 508.136630] qemu_mutex_unlock: released mutex 0x55d842db27b=
8 (0x55d840cdfcb1:143)
>>   [150617850 508.136631] qemu_mutex_unlock: released mutex 0x55d842ded59=
0 (0x55d840c63019:172)
>>
>> So as you can see, the usage pattern is IMO sufficiently different from =
the
>> existing tracing mechanism that slightly different commands and usage mo=
dels
>> may be warranted.
>
> Separate commands for sufficiently different usage patterns may make
> sense.  My question is whether the recorder backend can also support the
> same old usage patterns.

Not easily. Long-term, with intrusive changes that affect other back-ends, =
yes.

>
> Supporting the same old usage patterns is nice, because then I don't
> have to configure two trace backends, one for old usage patterns, and
> recorder for the recorder usage patterns.
>
> But then I'd like to be able to use the same old commands, too.
>
>> Does that interface make sense?

It does, but as part of a later discussion IMO. For example, is it OK to
have backends specify some extended syntax for trace-enable? Can we somehow
accept different regexp syntax for trace-event? etc.

>>
>>
>> As an aside, if you have activated the recorder sharing mechanism by usi=
ng
>> some "recorder_name=3Drecorder_field,recorder_field" option, then you ca=
n
>> remote-control some aspects of qemu as well using recorder_scope. For
>> example, instead of using the monitor, you can use:
>>
>>   recorder_scope -c qemu_mutex_unlock
>>
>> Or
>>
>>   recorder_scope -c dump
>>
>>>
>>> Integration need not mean implement the existing interface slavishly!
>>> Feel free to evolve it.  For instance, the QMP commands provide
>>> "case-sensitive glob", while you have full regexps.  You could extend
>>> the commands to also accept regexps.
>>
>> Yes, as I have indicated in the cover letter, further integration is a t=
opic
>> of interest. This is likely to require some relatively "minor" changes l=
ike
>> the one you mentioned, as well as more significant ones.
>>
>> What I want to avoid is shooting for some "lowest common denominator" by
>> constraining the recorder library to just tracing. If this was just
>> functionally equivalent to the log trace backend, the recorder trace bac=
kend
>> would add very little value and not be worth integrating.
>
> The point of integrating the recorder backends is of course gaining
> features the other backends don't already provide.  Additional features
> taking additional UI is fine.
>
>>> We can talk about leaving gaps for later.
>>>
>>> I recommend to start with QMP.
>>
>> Does the existing qmp integration work for you, or do you have suggestio=
ns
>> for reworking it?
>
> I'm afraid I need to learn a bit more before I can answer this.

OK. Thanks.



--
Cheers,
Christophe de Dinechin (IRC c3d)


