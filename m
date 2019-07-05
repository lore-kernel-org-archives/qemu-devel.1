Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8F1C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AAEB218CA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 13:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAEB218CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjO8u-0004f8-Np
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 09:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hjO7S-0003kC-BR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hjO7O-0001bn-Pv
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:19:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hjO7O-00016g-HY
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 09:19:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1747D30C0DE1
 for <qemu-devel@nongnu.org>; Fri,  5 Jul 2019 13:19:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4337D1001925;
 Fri,  5 Jul 2019 13:19:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C4CBC1132ABF; Fri,  5 Jul 2019 15:19:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190703171005.26231-1-philmd@redhat.com>
 <20190703172501.GI23082@redhat.com>
 <20190704102457.GE1609@stefanha-x1.localdomain>
 <20190704102837.GA24190@redhat.com>
 <20190705080717.GD10995@stefanha-x1.localdomain>
 <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com>
Date: Fri, 05 Jul 2019 15:19:01 +0200
In-Reply-To: <8470a203-430b-1814-b2ef-6adf3fa739a6@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 5 Jul 2019 11:48:51
 +0200")
Message-ID: <87d0iok4ai.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 05 Jul 2019 13:19:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH-for-4.2] tracing: Allow to tune tracing
 options via the environment
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
Cc: "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/5/19 10:07 AM, Stefan Hajnoczi wrote:
>> On Thu, Jul 04, 2019 at 11:28:37AM +0100, Daniel P. Berrang=C3=A9 wrote:
>>> On Thu, Jul 04, 2019 at 11:24:57AM +0100, Stefan Hajnoczi wrote:
>>>> On Wed, Jul 03, 2019 at 06:25:01PM +0100, Daniel P. Berrang=C3=A9 wrot=
e:
>>>>> On Wed, Jul 03, 2019 at 07:10:05PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
>>>>>> We can pass trace trace options with the -trace command line
>>>>>> argument.
>>>>>>=20
>>>>>> Tracing might be useful when running qtests. To avoid to have
>>>>>> to modify the tests and recompile, add the possibility to pass
>>>>>> trace options via the shell environment.

Unless I'm missing something, you don't have to recompile to pass
additional options.  The qtest binaries already read environment
variables QTEST_QEMU_BINARY and QTEST_QEMU_IMG.  Have them point to
suitable wrappers.

Perhaps there's still a need for a more convenient way.

>>>>>>=20
>>>>>> We add:
>>>>>> - QEMU_TRACE_EVENTS:    List of events to enable (coma separated)
>>>>>> - QEMU_TRACE_EVENTFILE: File with list of events to enable
>>>>>> - QEMU_TRACE_LOGFILE:   File to log the trace events.
>>>>>>=20
>>>>>> Example of use:
>>>>>>=20
>>>>>>   $ QEMU_TRACE_EVENTS=3Dpl011\* make check-qtest-arm
>>>>>>     TEST    check-qtest-arm: tests/boot-serial-test
>>>>>>   18650@1562168430.027490:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18650@1562168430.027535:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18650@1562168430.027544:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18650@1562168430.028037:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18650@1562168430.028049:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18650@1562168430.028057:pl011_can_receive LCR 0x00000000 read_coun=
t 0 returning 1
>>>>>>   18653@1562168430.053250:pl011_write addr 0x00000000 value 0x000000=
54
>>>>>>   18653@1562168430.053276:pl011_irq_state irq state 0
>>>>>>   [...]
>>>>>>=20
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>> ---
>>>>>> I'm not sure where to document that...
>>>>>> ---
>>>>>>  trace/control.c | 9 +++++++++
>>>>>>  1 file changed, 9 insertions(+)
>>>>>>=20
>>>>>> diff --git a/trace/control.c b/trace/control.c
>>>>>> index 43fb7868db..aea802623c 100644
>>>>>> --- a/trace/control.c
>>>>>> +++ b/trace/control.c
>>>>>> @@ -288,6 +288,8 @@ void trace_fini_vcpu(CPUState *vcpu)
>>>>>>=20=20
>>>>>>  bool trace_init_backends(void)
>>>>>>  {
>>>>>> +    char *trace_env;
>>>>>> +
>>>>>>  #ifdef CONFIG_TRACE_SIMPLE
>>>>>>      if (!st_init()) {
>>>>>>          fprintf(stderr, "failed to initialize simple tracing backen=
d.\n");
>>>>>> @@ -306,6 +308,13 @@ bool trace_init_backends(void)
>>>>>>      openlog(NULL, LOG_PID, LOG_DAEMON);
>>>>>>  #endif
>>>>>>=20=20
>>>>>> +    trace_init_file(getenv("QEMU_TRACE_LOGFILE"));
>>>>>> +    trace_init_events(getenv("QEMU_TRACE_EVENTFILE"));
>>>>>> +    trace_env =3D getenv("QEMU_TRACE_EVENTS");
>>>>>> +    if (trace_env) {
>>>>>> +        trace_enable_events(trace_env);
>>>>>> +    }
>>>>>> +
>>>>>
>>>>> I don't think it is a nice idea to add this via environment variables
>>>>> to QEMU itself. Why not modify libqtest qtest_init_without_qmp_handsh=
ake
>>>>> to read the env vars and then pass a suitable -trace arg when spawning
>>>>> QEMU ?
>>>>
>>>> What is the concern about adding these environment variables to QEMU?
>>>>
>>>> It is convenient to be able to use tracing even if QEMU is invoked by
>>>> something you cannot modify/control.
>>>>
>>>> The main issues I see with environment variables are:
>>>>
>>>> 1. Security.  Is there a scenario where an attacker can use environment
>>>>    variables to influence the behavior of a QEMU process running at a
>>>>    different trust level?

The common (and sad) solution for this is to require whatever runs $PROG
at a different trust level to scrub the environment.

>>>> 2. Name collision.  What is the chance that existing users already
>>>>    define environment variables with these names and that unexpected
>>>>    behavior could result?
>>>
>>> One of the biggest problems with QEMU in general has been poorly modell=
ed
>>> & defined interfaces for configuration. At runtime we've solved this wi=
th
>>> QMP. At startup we're still fighting the horror of QemuOpts in general =
and
>>> haven't got startup modelling to be on a par with that offered by QEMU.
>>> It was even worse when Audio didn't even use QemuOpts and instead used
>>> an arbitrary set of poorly defined env variables. To me adding yet anot=
her
>>> way to configure QEMU via env vars is moving in the opposite direction =
to
>>> what we want.
>>=20
>> In this case the environment variables are optional and meant for cases
>> where the user cannot change the QEMU command-line.  I think they serve
>> a different purpose from the audio subsystem environment variables and
>> I'd be happy to merge them.

You're right, there is a difference between "also" and "only".  Audio
could only be configured via environment, and that was without doubt
awful.  Does not imply permitting trace configuration via environment
also would be similarly awful.

However, adding special cases as needed is what got us into the startup
mess Dan highlighted.  Are we confident tracing will remain the only
thing we also want to configure via environment?

I sympathize with Dan's plea for more uniform configuration interfaces.

>> Philippe: Have you tried adding the environment variable to libqtest as
>> Dan suggested and did it work for your use case?

This would fit into our existing use of the environment with qtest.  Try
grep '"QTEST_'.

> Yes, but we loose the ability to use this feature from linux-user and
> other tools:
>
> $ git grep trace_opt_parse
> bsd-user/main.c:851:            trace_file =3D trace_opt_parse(optarg);
> linux-user/main.c:387:    trace_file =3D trace_opt_parse(arg);
> qemu-img.c:5063:            trace_file =3D trace_opt_parse(optarg);
> qemu-io.c:579:            trace_file =3D trace_opt_parse(optarg);
> qemu-nbd.c:862:            trace_file =3D trace_opt_parse(optarg);
> scsi/qemu-pr-helper.c:969:            trace_file =3D trace_opt_parse(opta=
rg);
> vl.c:3730:                trace_file =3D trace_opt_parse(optarg);
>
> So I'm now mixed about the trade off regarding Daniel worries.

Philippe, your commit message mentions just qtest.  That use case would
be covered by Dan's suggestion, wouldn't it?  If not, please explain.
If you have additional use cases, please state them.

