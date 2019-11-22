Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F71C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:35:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F1A2068E
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a42arHY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F1A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7Dr-0007fV-Jw
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:35:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dinechin@redhat.com>) id 1iY7CP-00079I-Et
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:34:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dinechin@redhat.com>) id 1iY7CM-0006vr-Cw
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:34:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34532
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dinechin@redhat.com>) id 1iY7CM-0006vd-3L
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:34:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574422441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eiApReMVs4oMOCy1N5r7WJDV0qfDFwhJOp0up6St424=;
 b=a42arHY7h3GJPC6Edq/UxshsNtyyl0MMUPpO9RqrwFG3kukDQvHGFobT5HvIbYWdgj50b9
 ewwD73frTsRgKafgh7Q3UfTOFcQ9S9fnEOt1w1so8ozIMKvzH5OJw8YxAQNURbmBTuHAH7
 qp6NpM5NyyR8W4mm7iNPjphzQnYfWbw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-s3OcI4e9Op-UZhlytXqL4Q-1; Fri, 22 Nov 2019 06:32:38 -0500
Received: by mail-wm1-f71.google.com with SMTP id p19so2043962wma.8
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:message-id:mime-version:subject:date
 :in-reply-to:cc:to:references;
 bh=ZfW6socPF27g5UKX9n7bDe/ukjXfwYFOdSDLHp938Io=;
 b=VC7J73nh+NsU/XHshdmGpRPHmd8WMZYeQqVPeuBvciDq8Jb/wmjGp99Mo0YnXtySqA
 wngfqypBQ1Pol9bPHKXWVq73KdCJRKQzzGdq2ej6AaOa5jhz8ZIa3G7Fvd+T/iqhUIRj
 /ciuoQTBBGnxBvxqiYhs/K7WV1x4IcZKXv2hxHMvHwKawAKYu4t7R8hkLvmYPuH4XH/s
 ACA+mjYCHwWj8VHoOEC5rYOr93KdbRwNKkNLdLpShRYWh9djSisfONybIkJUE+Mn1uau
 jDrwZnA7JMPFerEpMSyi+kxdzgTorRVpnw+UwRH6omm9J7ohiLuJ/kRp23Gey9d2WevC
 m1KA==
X-Gm-Message-State: APjAAAVywlXedH6d/iIxT9/Iy/TJCjlfDvymSqNZ3lZPkZefzzB4MfNB
 N07W4kVQP3BkiWPUVc+Vb8P9D+UEsk9R85E75nV6JV6EAvH4ol8cgLg1Loxtn2ppYC2DmTFs7wU
 0zImIZrCI2p2HlDc=
X-Received: by 2002:adf:c611:: with SMTP id n17mr17576013wrg.317.1574422357021; 
 Fri, 22 Nov 2019 03:32:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLuYeqR24E73dZBAnTxUHyaWQG+A6Is/hs7/6g1XLM9C4lW7A8t0XzMjuNrClXKeKJh/PtGg==
X-Received: by 2002:adf:c611:: with SMTP id n17mr17575962wrg.317.1574422356530; 
 Fri, 22 Nov 2019 03:32:36 -0800 (PST)
Received: from ?IPv6:2a01:e0a:466:71c0:5449:26a2:25f9:61fc?
 ([2a01:e0a:466:71c0:5449:26a2:25f9:61fc])
 by smtp.gmail.com with ESMTPSA id z2sm7443341wrs.89.2019.11.22.03.32.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:32:35 -0800 (PST)
From: Christophe de Dinechin <dinechin@redhat.com>
Message-Id: <FA8D191E-9144-4507-90DE-FE8F0107D00F@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [Qemu-devel] [libvirt] [PATCH 2/2] qapi: deprecate implicit
 filters
Date: Fri, 22 Nov 2019 12:32:33 +0100
In-Reply-To: <87blt4s3pq.fsf@dusky.pond.sub.org>
To: Markus Armbruster <armbru@redhat.com>
References: <20190814100735.24234-1-vsementsov@virtuozzo.com>
 <20190814100735.24234-3-vsementsov@virtuozzo.com>
 <3eded188-0161-d494-194c-9d67da644eb1@redhat.com>
 <20190815104928.GC7415@linux.fritz.box>
 <20190815114553.GQ300@andariel.pipo.sk> <87d0h6zfrt.fsf@dusky.pond.sub.org>
 <m1lfvbex92.fsf@redhat.com> <87blt4s3pq.fsf@dusky.pond.sub.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-MC-Unique: s3OcI4e9Op-UZhlytXqL4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_68302FBB-C9CC-4E14-8C88-6B42AFDB23AF"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, den@openvz.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Apple-Mail=_68302FBB-C9CC-4E14-8C88-6B42AFDB23AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 22 Nov 2019, at 09:41, Markus Armbruster <armbru@redhat.com> wrote:
>=20
> Reviving this old thread, because I'd like to connect it to more recent
> discussions.
>=20
> Christophe de Dinechin <dinechin@redhat.com <mailto:dinechin@redhat.com>>=
 writes:
>=20
>> Markus Armbruster writes:
>>=20
>>> Peter Krempa <pkrempa@redhat.com> writes:
>>>=20
>> [...]
>>>> From my experience users report non-fatal messages mostly only if it i=
s
>>>> spamming the system log. One of instances are very unlikely to be
>>>> noticed.
>>>>=20
>>>> In my experience it's better to notify us in libvirt of such change an=
d
>>>> we will try our best to fix it.
>>>=20
>>> How to best alert the layers above QEMU was one of the topic of the KVM
>>> Forum 2018 BoF on deprecating stuff.  Minutes:
>>>=20
>>>    Message-ID: <87mur0ls8o.fsf@dusky.pond.sub.org>
>>>    https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.ht=
ml
>>>=20
>>> Relevant part:
>>>=20
>>> * We need to communicate "you're using something that is deprecated".
>>>  How?  Right now, we print a deprecation message.  Okay when humans use
>>>  QEMU directly in a shell.  However, when QEMU sits at the bottom of a
>>>  software stack, the message will likely end up in a log file that is
>>>  effectively write-only.
>>>=20
>>>  - The one way to get people read log files is crashing their
>>>    application.  A command line option --future could make QEMU crash
>>>    right after printing a deprecation message.  This could help with
>>>    finding use of deprecated features in a testing environment.
>>>=20
>>>  - A less destructive way to grab people's attention is to make things
>>>    run really, really slow: have QEMU go to sleep for a while after
>>>    printing a deprecation message.
>>>=20
>>>  - We can also pass the buck to the next layer up: emit a QMP event.
>>>=20
>>>    Sadly, by the time the next layer connects to QMP, plenty of stuff
>>>    already happened.  We'd have to buffer deprecation events somehow.
>>>=20
>>>    What would libvirt do with such an event?  Log it, taint the domain,
>>>    emit a (libvirt) event to pass it on to the next layer up.
>>>=20
>>>  - A completely different idea is to have a configuratin linter.  To
>>>    support doing this at the libvirt level, QEMU could expose "is
>>>    deprecated" in interface introspection.  Feels feasible for QMP,
>>>    where we already have sufficiently expressive introspection.  For
>>>    CLI, we'd first have to provide that (but we want that anyway).
>>>=20
>>>  - We might also want to dispay deprecation messages in QEMU's GUI
>>>    somehow, or on serial consoles.
>>=20
>> Sorry for catching up late, this mail thread happened during my PTO.
>>=20
>> I remember bringing up at the time [1] that the correct solution needs
>> to take into account usage models that vary from
>>=20
>> - a workstation case, where displaying an error box is easy and
>>  convenient,
>>=20
>> - to local headless VMs where system-level notification would do the job
>>  better, allowing us to leverage things like system-wide email notificat=
ions
>>=20
>> - to large-scale collections of VMs managed by some layered product,
>>  where the correct reporting would be through something like Insights,
>>  i.e. you don't scan individual logs, you want something like "913 VMs
>>  are using deprecated X"
>>=20
>> To me, that implies that we need to have a clear division of roles, with
>> a standard way to
>>=20
>> a) produce the errors,
>> b) propagate them,
>> c) consume them (at least up to libvirt)
>>=20
>> Notice that this work has already been done for "real" errors,
>> i.e. there is a real QAPI notion of "errors". AFAICT, warn_report does
>> not connect to it, though, it goes through error_vprintf which is really
>> just basic logging.
>>=20
>> So would it make sense to:
>>=20
>> 1. Add a deprecation_report() alongside warn_report()?
>=20
> "Grepability" alone would make that worthwhile, I think.
>=20
>> 2. Connect warn_report() and all the error_vprintf output to QAPI,
>>   e.g. using John's suggestion of adding the messages using some
>>   "warning" or "deprecated" tag?
>=20
> This is the difficult part.  See my "Exposing feature deprecation to
> machine clients (was: [Qemu-devel] [PATCH 2/2] qapi: deprecate implicit
> filters)" in this thread.  Quote:
>=20
>    Propagating errors is painful.  It has caused massive churn all over t=
he
>    place.
>=20
>    I don't think we can hitch deprecation info to the existing error
>    propagation, since we need to take the success path back to the QMP
>    core, not an error path.
>=20
>    Propagating a second object for warnings... thanks, but no thanks.
>=20
>    The QMP core could provide a function for recording deprecation info f=
or
>    the currently executing QMP command.  This is how we used to record
>    errors in QMP commands, until Anthony rammed through what we have now.
>    The commit messages (e.g. d5ec4f27c38) provide no justification.  I
>    dimly recall adamant (oral?) claims that recording errors in the Monit=
or
>    object cannot work for us.
>=20
>    I smell a swamp.

This looks swampy the way you describe it, but this make me think that
the recorder library may provide a somewhat elegant solution to this.

First, my presupposition here is that part of the issues you are describing
is because there is no =E2=80=9Cone size fits all=E2=80=9D reporting of err=
ors, warnings, etc.
Essentially, it=E2=80=99s a policy that is defined outside of libvirt or qe=
mu, and not
all consumers will want the same policy.

The way the recorder library addresses that is to have as many recorders
as you need, and allowing the behavior for each recorder to be configured
individually at run-time, e.g. through env variables.

If you couple that with a naming convention for the recorders, you can
set the policy externally in a rather flexible way. For example, I will typ=
ically
have recorders that end with _error or _warning or _info or _verbose.
We could have a _deprecated convention just the same.

With a simple syntax, you can state that you want tracing on
all warnings and errors by activating a regexp like =E2=80=9C.*_(warning|er=
ror)=E2=80=9D,
or disable anything related to deprecation with =E2=80=9C.*_deprecated.*=3D=
0=E2=80=9D.
It wouldn=E2=80=99t be much of a stretch to have similar policies for =E2=
=80=9Ccreate a
qapi error object=E2=80=9D or even =E2=80=9Cabort the process=E2=80=9D.

This approach means that we would get to define the default policy
for the various deprecation cases, but that the user would ultimately
be able to override, maybe even individually, e.g.:

=09// I don=E2=80=99t care about deprecation at all
=09.*_deprecated=3D0

=09// Log all deprecation messages, do nothing else with it
=09.*_deprecated=3D<log>

=09// Log most deprecation, but ignore =E2=80=9Cblink_tag=E2=80=9D deprecat=
ion
=09// messages and abort on =E2=80=9Cserial_uart=E2=80=9D deprecation messa=
ge
=09.*_deprecated=3D<log>
=09blink_tag_deprecated=3D0
=09serial_uart_deprecated=3D<abort>


>    Can we avoid plumbing deprecation info from command code to QMP core?
>    Only if the QMP core itself can recognize deprecated interfaces.  I
>    believe it can for the cases we can expose in introspecion.  Let me
>    explain.

The recorder above (as it exists today) only deals with logging and reporti=
ng
messages. It provides no help whatsoever for introspection, which I assume
you would use to warn =E2=80=9Cahead of time=E2=80=9D that something is dep=
recated, right?

>=20
>    Kevin recently added "features" to the QAPI schema language.  The
>    implementation is incomplete, but that's detail.  The idea is to tack =
a
>    "deprecated" feature to deprecated stuff in the QAPI schema.
>=20
>    Commands and arguments need to support features for that.
>    Implementation should be relatively straightforward.
>=20
>    Deprecating an argument's optionalness may require a
>    "optional-deprecated" feature.  I've seen more elegant designs, but I'=
ve
>    also seen plenty of uglier ones.
>=20
>    Note that features are tied to schema syntax.  To express semantically
>    conditional deprecation like "if you specify argument FOO, then not
>    specifying argument BAR is deprecated", we'd have to add a language fo=
r
>    these conditions.  Uh, not now, maybe never.

For these cases, we can still fallback to C code, no? As long as the
=E2=80=9Creport_deprecated()=E2=80=9D being used is somewhat consistent bet=
ween
the two, the fact that there is a =E2=80=9Cshort, common case=E2=80=9D for =
optiions
and a =E2=80=9Ccomplicated, less common case=E2=80=9D would be invisible to=
 users.

>=20
>    The primary use of having deprecation defined in the QAPI schema is
>    introspection.  The BoF minutes mention this, too.
>=20
>    A secondary use could be detecting use of deprecated features right in
>    the QMP core.  No need for ad hoc code in commands, no need for plumbi=
ng
>    information from there to the QMP core.
>=20
>    I'd like to pursue this idea, then see how well it suits our deprecati=
on
>    needs.
>=20
> I've since explored this idea in
>=20
>    [RFC PATCH 00/19] Configurable policy for handling deprecated interfac=
es
>    Message-Id: <20191024123458.13505-1-armbru@redhat.com <mailto:20191024=
123458.13505-1-armbru@redhat.com>>
>    https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06534.html <h=
ttps://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06534.html>   =20

I had not paid attention to this one. I=E2=80=99ll take a look and get back=
 to you.



>=20
>> 3. Teach libvirt how to consume that new tag and pass it along?
>=20
> Pertinent:
> Message-ID: <20191024140146.GC8381@redhat.com <mailto:20191024140146.GC83=
81@redhat.com>>
> https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06604.html <http=
s://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06604.html>
>=20
> Quoting Dan's conclusion:
>=20
>    In summary, it is probably reasonable to include this info in the QMP
>    command reply, but don't expect much to be done with it beyond possibl=
y
>    writing it to a log file.
>=20
>> [1] https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.ht=
ml <https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.html>


Thanks
Christophe

>>=20
>>=20
>> --
>> Cheers,
>> Christophe de Dinechin (IRC c3d)


--Apple-Mail=_68302FBB-C9CC-4E14-8C88-6B42AFDB23AF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; line-break: after-white-space;" class=3D""><br class=3D""><div><br cl=
ass=3D""><blockquote type=3D"cite" class=3D""><div class=3D"">On 22 Nov 201=
9, at 09:41, Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com" cla=
ss=3D"">armbru@redhat.com</a>&gt; wrote:</div><br class=3D"Apple-interchang=
e-newline"><div class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displa=
y: inline !important;" class=3D"">Reviving this old thread, because I'd lik=
e to connect it to more recent</span><br style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""=
><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px; text-decoration: none; float: none; display: inline !important;" cla=
ss=3D"">discussions.</span><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">Christophe de Dinechin &lt;</span><a h=
ref=3D"mailto:dinechin@redhat.com" style=3D"font-family: Helvetica; font-si=
ze: 18px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=
=3D"">dinechin@redhat.com</a><span style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; disp=
lay: inline !important;" class=3D"">&gt; writes:</span><br style=3D"caret-c=
olor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration:=
 none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Hel=
vetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fon=
t-weight: normal; letter-spacing: normal; text-align: start; text-indent: 0=
px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-t=
ext-stroke-width: 0px; text-decoration: none;" class=3D""><blockquote type=
=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; orphans: auto; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-ad=
just: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D"">Markus Armbruster writes:<br class=3D""><br class=3D""><blockquote ty=
pe=3D"cite" class=3D"">Peter Krempa &lt;<a href=3D"mailto:pkrempa@redhat.co=
m" class=3D"">pkrempa@redhat.com</a>&gt; writes:<br class=3D""><br class=3D=
""></blockquote>[...]<br class=3D""><blockquote type=3D"cite" class=3D""><b=
lockquote type=3D"cite" class=3D"">From my experience users report non-fata=
l messages mostly only if it is<br class=3D"">spamming the system log. One =
of instances are very unlikely to be<br class=3D"">noticed.<br class=3D""><=
br class=3D"">In my experience it's better to notify us in libvirt of such =
change and<br class=3D"">we will try our best to fix it.<br class=3D""></bl=
ockquote><br class=3D"">How to best alert the layers above QEMU was one of =
the topic of the KVM<br class=3D"">Forum 2018 BoF on deprecating stuff. &nb=
sp;Minutes:<br class=3D""><br class=3D"">&nbsp;&nbsp;&nbsp;Message-ID: &lt;=
<a href=3D"mailto:87mur0ls8o.fsf@dusky.pond.sub.org" class=3D"">87mur0ls8o.=
fsf@dusky.pond.sub.org</a>&gt;<br class=3D"">&nbsp;&nbsp;&nbsp;<a href=3D"h=
ttps://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.html" clas=
s=3D"">https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg05828.ht=
ml</a><br class=3D""><br class=3D"">Relevant part:<br class=3D""><br class=
=3D"">* We need to communicate "you're using something that is deprecated".=
<br class=3D"">&nbsp;How? &nbsp;Right now, we print a deprecation message. =
&nbsp;Okay when humans use<br class=3D"">&nbsp;QEMU directly in a shell. &n=
bsp;However, when QEMU sits at the bottom of a<br class=3D"">&nbsp;software=
 stack, the message will likely end up in a log file that is<br class=3D"">=
&nbsp;effectively write-only.<br class=3D""><br class=3D"">&nbsp;- The one =
way to get people read log files is crashing their<br class=3D"">&nbsp;&nbs=
p;&nbsp;application. &nbsp;A command line option --future could make QEMU c=
rash<br class=3D"">&nbsp;&nbsp;&nbsp;right after printing a deprecation mes=
sage. &nbsp;This could help with<br class=3D"">&nbsp;&nbsp;&nbsp;finding us=
e of deprecated features in a testing environment.<br class=3D""><br class=
=3D"">&nbsp;- A less destructive way to grab people's attention is to make =
things<br class=3D"">&nbsp;&nbsp;&nbsp;run really, really slow: have QEMU g=
o to sleep for a while after<br class=3D"">&nbsp;&nbsp;&nbsp;printing a dep=
recation message.<br class=3D""><br class=3D"">&nbsp;- We can also pass the=
 buck to the next layer up: emit a QMP event.<br class=3D""><br class=3D"">=
&nbsp;&nbsp;&nbsp;Sadly, by the time the next layer connects to QMP, plenty=
 of stuff<br class=3D"">&nbsp;&nbsp;&nbsp;already happened. &nbsp;We'd have=
 to buffer deprecation events somehow.<br class=3D""><br class=3D"">&nbsp;&=
nbsp;&nbsp;What would libvirt do with such an event? &nbsp;Log it, taint th=
e domain,<br class=3D"">&nbsp;&nbsp;&nbsp;emit a (libvirt) event to pass it=
 on to the next layer up.<br class=3D""><br class=3D"">&nbsp;- A completely=
 different idea is to have a configuratin linter. &nbsp;To<br class=3D"">&n=
bsp;&nbsp;&nbsp;support doing this at the libvirt level, QEMU could expose =
"is<br class=3D"">&nbsp;&nbsp;&nbsp;deprecated" in interface introspection.=
 &nbsp;Feels feasible for QMP,<br class=3D"">&nbsp;&nbsp;&nbsp;where we alr=
eady have sufficiently expressive introspection. &nbsp;For<br class=3D"">&n=
bsp;&nbsp;&nbsp;CLI, we'd first have to provide that (but we want that anyw=
ay).<br class=3D""><br class=3D"">&nbsp;- We might also want to dispay depr=
ecation messages in QEMU's GUI<br class=3D"">&nbsp;&nbsp;&nbsp;somehow, or =
on serial consoles.<br class=3D""></blockquote><br class=3D"">Sorry for cat=
ching up late, this mail thread happened during my PTO.<br class=3D""><br c=
lass=3D"">I remember bringing up at the time [1] that the correct solution =
needs<br class=3D"">to take into account usage models that vary from<br cla=
ss=3D""><br class=3D"">- a workstation case, where displaying an error box =
is easy and<br class=3D"">&nbsp;convenient,<br class=3D""><br class=3D"">- =
to local headless VMs where system-level notification would do the job<br c=
lass=3D"">&nbsp;better, allowing us to leverage things like system-wide ema=
il notifications<br class=3D""><br class=3D"">- to large-scale collections =
of VMs managed by some layered product,<br class=3D"">&nbsp;where the corre=
ct reporting would be through something like Insights,<br class=3D"">&nbsp;=
i.e. you don't scan individual logs, you want something like "913 VMs<br cl=
ass=3D"">&nbsp;are using deprecated X"<br class=3D""><br class=3D"">To me, =
that implies that we need to have a clear division of roles, with<br class=
=3D"">a standard way to<br class=3D""><br class=3D"">a) produce the errors,=
<br class=3D"">b) propagate them,<br class=3D"">c) consume them (at least u=
p to libvirt)<br class=3D""><br class=3D"">Notice that this work has alread=
y been done for "real" errors,<br class=3D"">i.e. there is a real QAPI noti=
on of "errors". AFAICT, warn_report does<br class=3D"">not connect to it, t=
hough, it goes through error_vprintf which is really<br class=3D"">just bas=
ic logging.<br class=3D""><br class=3D"">So would it make sense to:<br clas=
s=3D""><br class=3D"">1. Add a deprecation_report() alongside warn_report()=
?<br class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none; float: none; display: inline !important;" class=3D"">=
"Grepability" alone would make that worthwhile, I think.</span><br style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquo=
te type=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; orphans: auto; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-=
size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" =
class=3D"">2. Connect warn_report() and all the error_vprintf output to QAP=
I,<br class=3D"">&nbsp;&nbsp;e.g. using John's suggestion of adding the mes=
sages using some<br class=3D"">&nbsp;&nbsp;"warning" or "deprecated" tag?<b=
r class=3D""></blockquote><br style=3D"caret-color: rgb(0, 0, 0); font-fami=
ly: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: norm=
al; font-weight: normal; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span styl=
e=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none; float: none; display: inline !important;" class=3D"">Thi=
s is the difficult part. &nbsp;See my "Exposing feature deprecation to</spa=
n><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: normal; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float=
: none; display: inline !important;" class=3D"">machine clients (was: [Qemu=
-devel] [PATCH 2/2] qapi: deprecate implicit</span><br style=3D"caret-color=
: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: non=
e;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none; float: none; display: inline !i=
mportant;" class=3D"">filters)" in this thread. &nbsp;Quote:</span><br styl=
e=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fo=
nt-style: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; text-align: start; text-indent: 0px; text-transform: none; w=
hite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text=
-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18p=
x; font-style: normal; font-variant-caps: normal; font-weight: normal; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none; float: none; display: inline !important;" class=3D"=
">&nbsp;&nbsp;&nbsp;Propagating errors is painful. &nbsp;It has caused mass=
ive churn all over the</span><br style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none; float: none; display: inline !important;" class=3D"">=
&nbsp;&nbsp;&nbsp;place.</span><br style=3D"caret-color: rgb(0, 0, 0); font=
-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps:=
 normal; font-weight: normal; letter-spacing: normal; text-align: start; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none;=
 display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;I don't think we=
 can hitch deprecation info to the existing error</span><br style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none; float: none; display: inli=
ne !important;" class=3D"">&nbsp;&nbsp;&nbsp;propagation, since we need to =
take the success path back to the QMP</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none; float: none; display: inline !importan=
t;" class=3D"">&nbsp;&nbsp;&nbsp;core, not an error path.</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>&nbsp;&nbsp;&nbsp;Propagating a second object for warnings... thanks, but =
no thanks.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helve=
tica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-=
weight: normal; letter-spacing: normal; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none; float: none; display: inli=
ne !important;" class=3D"">&nbsp;&nbsp;&nbsp;The QMP core could provide a f=
unction for recording deprecation info for</span><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helveti=
ca; font-size: 18px; font-style: normal; font-variant-caps: normal; font-we=
ight: normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; text-decoration: none; float: none; display: inline !imp=
ortant;" class=3D"">&nbsp;&nbsp;&nbsp;the currently executing QMP command. =
&nbsp;This is how we used to record</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">&nbsp;&nbsp;&nbsp;errors in QMP commands, until Anthony rammed=
 through what we have now.</span><br style=3D"caret-color: rgb(0, 0, 0); fo=
nt-family: Helvetica; font-size: 18px; font-style: normal; font-variant-cap=
s: normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; word-spacing: =
0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><sp=
an style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 1=
8px; font-style: normal; font-variant-caps: normal; font-weight: normal; le=
tter-spacing: normal; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0p=
x; text-decoration: none; float: none; display: inline !important;" class=
=3D"">&nbsp;&nbsp;&nbsp;The commit messages (e.g. d5ec4f27c38) provide no j=
ustification. &nbsp;I</span><br style=3D"caret-color: rgb(0, 0, 0); font-fa=
mily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; letter-=
spacing: normal; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; te=
xt-decoration: none; float: none; display: inline !important;" class=3D"">&=
nbsp;&nbsp;&nbsp;dimly recall adamant (oral?) claims that recording errors =
in the Monitor</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: H=
elvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; f=
ont-weight: normal; letter-spacing: normal; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit=
-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"=
caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-st=
yle: normal; font-variant-caps: normal; font-weight: normal; letter-spacing=
: normal; text-align: start; text-indent: 0px; text-transform: none; white-=
space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-deco=
ration: none; float: none; display: inline !important;" class=3D"">&nbsp;&n=
bsp;&nbsp;object cannot work for us.</span></div></blockquote><blockquote t=
ype=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">&nbsp;&nbsp;&nbsp;I smell a swamp.</span><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""></div></blockquote><div><br class=3D""></div><div>This lo=
oks swampy the way you describe it, but this make me think that</div><div>t=
he recorder library may provide a somewhat elegant solution to this.</div><=
div><br class=3D""></div><div>First, my presupposition here is that part of=
 the issues you are describing</div><div>is because there is no =E2=80=9Con=
e size fits all=E2=80=9D reporting of errors, warnings, etc.</div><div>Esse=
ntially, it=E2=80=99s a policy that is defined outside of libvirt or qemu, =
and not</div><div>all consumers will want the same policy.</div><div><br cl=
ass=3D""></div><div>The way the recorder library addresses that is to have =
as many recorders</div><div>as you need, and allowing the behavior for each=
 recorder to be configured</div><div>individually at run-time, e.g. through=
 env variables.</div><div><br class=3D""></div><div>If you couple that with=
 a naming convention for the recorders, you can</div><div>set the policy ex=
ternally in a rather flexible way. For example, I will typically</div><div>=
have recorders that end with _error or _warning or _info or _verbose.</div>=
<div>We could have a _deprecated convention just the same.</div><div><br cl=
ass=3D""></div><div>With a simple syntax, you can state that you want traci=
ng on</div><div>all warnings and errors by activating a regexp like =E2=80=
=9C.*_(warning|error)=E2=80=9D,</div><div>or disable anything related to de=
precation with =E2=80=9C.*_deprecated.*=3D0=E2=80=9D.</div><div>It wouldn=
=E2=80=99t be much of a stretch to have similar policies for =E2=80=9Ccreat=
e a</div><div>qapi error object=E2=80=9D or even =E2=80=9Cabort the process=
=E2=80=9D.</div><div><br class=3D""></div><div>This approach means that we =
would get to define the default policy</div><div>for the various deprecatio=
n cases, but that the user would ultimately</div><div>be able to override, =
maybe even individually, e.g.:</div><div><br class=3D""></div><div><span cl=
ass=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>// I don=E2=80=
=99t care about deprecation at all</div><div><span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">=09</span>.*_deprecated=3D0</div><div><br class=
=3D""></div><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">=
=09</span>// Log all deprecation messages, do nothing else with it</div><di=
v><div><span class=3D"Apple-tab-span" style=3D"white-space: pre;">=09</span=
>.*_deprecated=3D&lt;log&gt;</div><div><br class=3D""></div><div><span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>// Log most deprec=
ation, but ignore =E2=80=9Cblink_tag=E2=80=9D deprecation</div><div><span c=
lass=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>//&nbsp;message=
s and abort on =E2=80=9Cserial_uart=E2=80=9D deprecation message</div><div>=
<span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>.*_depre=
cated=3D&lt;log&gt;</div><div><span class=3D"Apple-tab-span" style=3D"white=
-space:pre">=09</span>blink_tag_deprecated=3D0</div><div><span class=3D"App=
le-tab-span" style=3D"white-space:pre">=09</span>serial_uart_deprecated=3D&=
lt;abort&gt;</div><div class=3D""><br class=3D""></div><div class=3D""><br =
class=3D""></div></div><blockquote type=3D"cite" class=3D""><div class=3D""=
><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px; text-decoration: none; float: none; display: inline !important;" cla=
ss=3D"">&nbsp; &nbsp;Can we avoid plumbing deprecation info from command co=
de to QMP core?</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none; float: none; display: inline !important;" class=3D"">&nbsp;&=
nbsp;&nbsp;Only if the QMP core itself can recognize deprecated interfaces.=
 &nbsp;I</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helveti=
ca; font-size: 18px; font-style: normal; font-variant-caps: normal; font-we=
ight: normal; letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-=
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration=
: none; float: none; display: inline !important;" class=3D"">&nbsp;&nbsp;&n=
bsp;believe it can for the cases we can expose in introspecion. &nbsp;Let m=
e</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
 float: none; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;exp=
lain.</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: normal; letter-spacing: normal; text-align: start; text-indent: 0px; tex=
t-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; text-decoration: none;" class=3D""></div></blockquote><div>=
<br class=3D""></div><div>The recorder above (as it exists today) only deal=
s with logging and reporting</div><div>messages. It provides no help whatso=
ever for introspection, which I assume</div><div>you would use to warn =E2=
=80=9Cahead of time=E2=80=9D that something is deprecated, right?</div><div=
><br class=3D""></div><blockquote type=3D"cite" class=3D""><div class=3D"">=
<br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0=
, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-var=
iant-caps: normal; font-weight: normal; letter-spacing: normal; text-align:=
 start; text-indent: 0px; text-transform: none; white-space: normal; word-s=
pacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: =
none; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;Kevin recen=
tly added "features" to the QAPI schema language. &nbsp;The</span><br style=
=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; fon=
t-style: normal; font-variant-caps: normal; font-weight: normal; letter-spa=
cing: normal; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-=
decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; dis=
play: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;implementation is in=
complete, but that's detail. &nbsp;The idea is to tack a</span><br style=3D=
"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-s=
tyle: normal; font-variant-caps: normal; font-weight: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-dec=
oration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-f=
amily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: start; text=
-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px;=
 -webkit-text-stroke-width: 0px; text-decoration: none; float: none; displa=
y: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;"deprecated" feature to=
 deprecated stuff in the QAPI schema.</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
 float: none; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;Com=
mands and arguments need to support features for that.</span><br style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decor=
ation: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-fam=
ily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: nor=
mal; font-weight: normal; letter-spacing: normal; text-align: start; text-i=
ndent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; text-decoration: none; float: none; display:=
 inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;Implementation should be =
relatively straightforward.</span><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><b=
r style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: normal; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: no=
ne; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;Deprecating a=
n argument's optionalness may require a</span><br style=3D"caret-color: rgb=
(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; fon=
t-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" c=
lass=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: normal; letter-spacing: normal; text-align: start; text-indent: 0px; tex=
t-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; text-decoration: none; float: none; display: inline !import=
ant;" class=3D"">&nbsp;&nbsp;&nbsp;"optional-deprecated" feature. &nbsp;I'v=
e seen more elegant designs, but I've</span><br style=3D"caret-color: rgb(0=
, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-=
variant-caps: normal; font-weight: normal; letter-spacing: normal; text-ali=
gn: start; text-indent: 0px; text-transform: none; white-space: normal; wor=
d-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cla=
ss=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; f=
ont-size: 18px; font-style: normal; font-variant-caps: normal; font-weight:=
 normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; -webkit-text-strok=
e-width: 0px; text-decoration: none; float: none; display: inline !importan=
t;" class=3D"">&nbsp;&nbsp;&nbsp;also seen plenty of uglier ones.</span><br=
 style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18p=
x; font-style: normal; font-variant-caps: normal; font-weight: normal; lett=
er-spacing: normal; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;=
 text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">&nbsp;&nbsp;&nbsp;Note that features are tied to schema syntax. &nbs=
p;To express semantically</span><br style=3D"caret-color: rgb(0, 0, 0); fon=
t-family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps=
: normal; font-weight: normal; letter-spacing: normal; text-align: start; t=
ext-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><spa=
n style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18=
px; font-style: normal; font-variant-caps: normal; font-weight: normal; let=
ter-spacing: normal; text-align: start; text-indent: 0px; text-transform: n=
one; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px=
; text-decoration: none; float: none; display: inline !important;" class=3D=
"">&nbsp;&nbsp;&nbsp;conditional deprecation like "if you specify argument =
FOO, then not</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; text-decoration: none;" class=3D""><span style=3D"c=
aret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-sty=
le: normal; font-variant-caps: normal; font-weight: normal; letter-spacing:=
 normal; text-align: start; text-indent: 0px; text-transform: none; white-s=
pace: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decor=
ation: none; float: none; display: inline !important;" class=3D"">&nbsp;&nb=
sp;&nbsp;specifying argument BAR is deprecated", we'd have to add a languag=
e for</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica;=
 font-size: 18px; font-style: normal; font-variant-caps: normal; font-weigh=
t: normal; letter-spacing: normal; text-align: start; text-indent: 0px; tex=
t-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-str=
oke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-col=
or: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: norm=
al; font-variant-caps: normal; font-weight: normal; letter-spacing: normal;=
 text-align: start; text-indent: 0px; text-transform: none; white-space: no=
rmal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: n=
one; float: none; display: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp=
;these conditions. &nbsp;Uh, not now, maybe never.</span><br style=3D"caret=
-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoratio=
n: none;" class=3D""></div></blockquote><div><br class=3D""></div><div>For =
these cases, we can still fallback to C code, no? As long as the</div><div>=
=E2=80=9Creport_deprecated()=E2=80=9D being used is somewhat consistent bet=
ween</div><div>the two, the fact that there is a =E2=80=9Cshort, common cas=
e=E2=80=9D for optiions</div><div>and a =E2=80=9Ccomplicated, less common c=
ase=E2=80=9D would be invisible to users.</div><br class=3D""><blockquote t=
ype=3D"cite" class=3D""><div class=3D""><br style=3D"caret-color: rgb(0, 0,=
 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-vari=
ant-caps: normal; font-weight: normal; letter-spacing: normal; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">&nbsp;&nbsp;&nbsp;The primary use of having deprecation define=
d in the QAPI schema is</span><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span =
style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px=
; font-style: normal; font-variant-caps: normal; font-weight: normal; lette=
r-spacing: normal; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; =
text-decoration: none; float: none; display: inline !important;" class=3D""=
>&nbsp;&nbsp;&nbsp;introspection. &nbsp;The BoF minutes mention this, too.<=
/span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-=
size: 18px; font-style: normal; font-variant-caps: normal; font-weight: nor=
mal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cl=
ass=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; font-weight=
: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none; float: none; display: inline !importa=
nt;" class=3D"">&nbsp;&nbsp;&nbsp;A secondary use could be detecting use of=
 deprecated features right in</span><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">&nbsp;&nbsp;&nbsp;the QMP core. &nbsp;No need for ad hoc code in com=
mands, no need for plumbing</span><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><s=
pan style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none; float: none; display: inline !important;" class=
=3D"">&nbsp;&nbsp;&nbsp;information from there to the QMP core.</span><br s=
tyle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; t=
ext-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><s=
pan style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: =
18px; font-style: normal; font-variant-caps: normal; font-weight: normal; l=
etter-spacing: normal; text-align: start; text-indent: 0px; text-transform:=
 none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0=
px; text-decoration: none; float: none; display: inline !important;" class=
=3D"">&nbsp;&nbsp;&nbsp;I'd like to pursue this idea, then see how well it =
suits our deprecation</span><br style=3D"caret-color: rgb(0, 0, 0); font-fa=
mily: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><span st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; letter-=
spacing: normal; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; te=
xt-decoration: none; float: none; display: inline !important;" class=3D"">&=
nbsp;&nbsp;&nbsp;needs.</span><br style=3D"caret-color: rgb(0, 0, 0); font-=
family: Helvetica; font-size: 18px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""><br st=
yle=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; letter-=
spacing: normal; text-align: start; text-indent: 0px; text-transform: none;=
 white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; te=
xt-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); =
font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-c=
aps: normal; font-weight: normal; letter-spacing: normal; text-align: start=
; text-indent: 0px; text-transform: none; white-space: normal; word-spacing=
: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;" class=3D"">I've since explored this idea in</s=
pan><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-si=
ze: 18px; font-style: normal; font-variant-caps: normal; font-weight: norma=
l; letter-spacing: normal; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; text-decoration: none;" class=3D""><br style=3D"caret-color: rgb(0,=
 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-v=
ariant-caps: normal; font-weight: normal; letter-spacing: normal; text-alig=
n: start; text-indent: 0px; text-transform: none; white-space: normal; word=
-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" clas=
s=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fo=
nt-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: =
normal; letter-spacing: normal; text-align: start; text-indent: 0px; text-t=
ransform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke=
-width: 0px; text-decoration: none; float: none; display: inline !important=
;" class=3D"">&nbsp;&nbsp;&nbsp;[RFC PATCH 00/19] Configurable policy for h=
andling deprecated interfaces</span><br style=3D"caret-color: rgb(0, 0, 0);=
 font-family: Helvetica; font-size: 18px; font-style: normal; font-variant-=
caps: normal; font-weight: normal; letter-spacing: normal; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"">=
<span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width:=
 0px; text-decoration: none; float: none; display: inline !important;" clas=
s=3D"">&nbsp;&nbsp;&nbsp;Message-Id: &lt;</span><a href=3D"mailto:201910241=
23458.13505-1-armbru@redhat.com" style=3D"font-family: Helvetica; font-size=
: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal;=
 letter-spacing: normal; orphans: auto; text-align: start; text-indent: 0px=
; text-transform: none; white-space: normal; widows: auto; word-spacing: 0p=
x; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px;" class=
=3D"">20191024123458.13505-1-armbru@redhat.com</a><span style=3D"caret-colo=
r: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: norma=
l; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: no=
ne; float: none; display: inline !important;" class=3D"">&gt;</span><br sty=
le=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; f=
ont-style: normal; font-variant-caps: normal; font-weight: normal; letter-s=
pacing: normal; text-align: start; text-indent: 0px; text-transform: none; =
white-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; tex=
t-decoration: none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); f=
ont-family: Helvetica; font-size: 18px; font-style: normal; font-variant-ca=
ps: normal; font-weight: normal; letter-spacing: normal; text-align: start;=
 text-indent: 0px; text-transform: none; white-space: normal; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: none; d=
isplay: inline !important;" class=3D"">&nbsp;&nbsp;&nbsp;</span><a href=3D"=
https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06534.html" style=
=3D"font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: normal; letter-spacing: normal; orphans: auto=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; -we=
bkit-text-stroke-width: 0px;" class=3D"">https://lists.gnu.org/archive/html=
/qemu-devel/2019-10/msg06534.html</a><span style=3D"caret-color: rgb(0, 0, =
0); font-family: Helvetica; font-size: 18px; font-style: normal; font-varia=
nt-caps: normal; font-weight: normal; letter-spacing: normal; text-align: s=
tart; text-indent: 0px; text-transform: none; white-space: normal; word-spa=
cing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none; float: no=
ne; display: inline !important;" class=3D""><span class=3D"Apple-converted-=
space">&nbsp;</span>&nbsp;&nbsp;&nbsp;</span><br style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cl=
ass=3D""></div></blockquote><div><br class=3D""></div><div>I had not paid a=
ttention to this one. I=E2=80=99ll take a look and get back to you.</div><d=
iv><br class=3D""></div><div><br class=3D""></div><div><br class=3D""></div=
><blockquote type=3D"cite" class=3D""><div class=3D""><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica=
; font-size: 18px; font-style: normal; font-variant-caps: normal; font-weig=
ht: normal; letter-spacing: normal; orphans: auto; text-align: start; text-=
indent: 0px; text-transform: none; white-space: normal; widows: auto; word-=
spacing: 0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0p=
x; text-decoration: none;" class=3D"">3. Teach libvirt how to consume that =
new tag and pass it along?<br class=3D""></blockquote><br style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: He=
lvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; fo=
nt-weight: normal; letter-spacing: normal; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; text-decoration: none; float: none; display: inline=
 !important;" class=3D"">Pertinent:</span><br style=3D"caret-color: rgb(0, =
0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font-va=
riant-caps: normal; font-weight: normal; letter-spacing: normal; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; word-=
spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; fon=
t-size: 18px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tr=
ansform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-=
width: 0px; text-decoration: none; float: none; display: inline !important;=
" class=3D"">Message-ID: &lt;</span><a href=3D"mailto:20191024140146.GC8381=
@redhat.com" style=3D"font-family: Helvetica; font-size: 18px; font-style: =
normal; font-variant-caps: normal; font-weight: normal; letter-spacing: nor=
mal; orphans: auto; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size=
-adjust: auto; -webkit-text-stroke-width: 0px;" class=3D"">20191024140146.G=
C8381@redhat.com</a><span style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none; float: none; display: inli=
ne !important;" class=3D"">&gt;</span><br style=3D"caret-color: rgb(0, 0, 0=
); font-family: Helvetica; font-size: 18px; font-style: normal; font-varian=
t-caps: normal; font-weight: normal; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D"=
"><a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2019-10/msg06604=
.html" style=3D"font-family: Helvetica; font-size: 18px; font-style: normal=
; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; o=
rphans: auto; text-align: start; text-indent: 0px; text-transform: none; wh=
ite-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-adjus=
t: auto; -webkit-text-stroke-width: 0px;" class=3D"">https://lists.gnu.org/=
archive/html/qemu-devel/2019-10/msg06604.html</a><br style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; tex=
t-align: start; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;=
" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica=
; font-size: 18px; font-style: normal; font-variant-caps: normal; font-weig=
ht: normal; letter-spacing: normal; text-align: start; text-indent: 0px; te=
xt-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-st=
roke-width: 0px; text-decoration: none;" class=3D""><span style=3D"caret-co=
lor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: nor=
mal; font-variant-caps: normal; font-weight: normal; letter-spacing: normal=
; text-align: start; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: =
none; float: none; display: inline !important;" class=3D"">Quoting Dan's co=
nclusion:</span><br style=3D"caret-color: rgb(0, 0, 0); font-family: Helvet=
ica; font-size: 18px; font-style: normal; font-variant-caps: normal; font-w=
eight: normal; letter-spacing: normal; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; word-spacing: 0px; -webkit-text=
-stroke-width: 0px; text-decoration: none;" class=3D""><br style=3D"caret-c=
olor: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration:=
 none;" class=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: H=
elvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; f=
ont-weight: normal; letter-spacing: normal; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webkit=
-text-stroke-width: 0px; text-decoration: none; float: none; display: inlin=
e !important;" class=3D"">&nbsp;&nbsp;&nbsp;In summary, it is probably reas=
onable to include this info in the QMP</span><br style=3D"caret-color: rgb(=
0, 0, 0); font-family: Helvetica; font-size: 18px; font-style: normal; font=
-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-al=
ign: start; text-indent: 0px; text-transform: none; white-space: normal; wo=
rd-spacing: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" cl=
ass=3D""><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; =
font-size: 18px; font-style: normal; font-variant-caps: normal; font-weight=
: normal; letter-spacing: normal; text-align: start; text-indent: 0px; text=
-transform: none; white-space: normal; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px; text-decoration: none; float: none; display: inline !importa=
nt;" class=3D"">&nbsp;&nbsp;&nbsp;command reply, but don't expect much to b=
e done with it beyond possibly</span><br style=3D"caret-color: rgb(0, 0, 0)=
; font-family: Helvetica; font-size: 18px; font-style: normal; font-variant=
-caps: normal; font-weight: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px; text-decoration: none;" class=3D""=
><span style=3D"caret-color: rgb(0, 0, 0); font-family: Helvetica; font-siz=
e: 18px; font-style: normal; font-variant-caps: normal; font-weight: normal=
; letter-spacing: normal; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-width=
: 0px; text-decoration: none; float: none; display: inline !important;" cla=
ss=3D"">&nbsp;&nbsp;&nbsp;writing it to a log file.</span><br style=3D"care=
t-color: rgb(0, 0, 0); font-family: Helvetica; font-size: 18px; font-style:=
 normal; font-variant-caps: normal; font-weight: normal; letter-spacing: no=
rmal; text-align: start; text-indent: 0px; text-transform: none; white-spac=
e: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; text-decorati=
on: none;" class=3D""><br style=3D"caret-color: rgb(0, 0, 0); font-family: =
Helvetica; font-size: 18px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -webki=
t-text-stroke-width: 0px; text-decoration: none;" class=3D""><blockquote ty=
pe=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-style: n=
ormal; font-variant-caps: normal; font-weight: normal; letter-spacing: norm=
al; orphans: auto; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-=
adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D"">[1]<span class=3D"Apple-converted-space">&nbsp;</span><a href=3D"http=
s://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.html" class=
=3D"">https://lists.nongnu.org/archive/html/qemu-devel/2018-10/msg06131.htm=
l</a><br class=3D""></blockquote></div></blockquote><div><br class=3D""></d=
iv><div><br class=3D""></div>Thanks</div><div>Christophe</div><div><br clas=
s=3D""><blockquote type=3D"cite" class=3D""><div class=3D""><blockquote typ=
e=3D"cite" style=3D"font-family: Helvetica; font-size: 18px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; orphans: auto; text-align: start; text-indent: 0px; text-transform: none=
; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-size-a=
djust: auto; -webkit-text-stroke-width: 0px; text-decoration: none;" class=
=3D""><br class=3D""><br class=3D"">--<br class=3D"">Cheers,<br class=3D"">=
Christophe de Dinechin (IRC c3d)</blockquote></div></blockquote></div><br c=
lass=3D""></body></html>
--Apple-Mail=_68302FBB-C9CC-4E14-8C88-6B42AFDB23AF--


