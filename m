Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3006C10F14
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F26A21848
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 18:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lYKC2Dv8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F26A21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFj2K-0006eZ-TY
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 14:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1iFj18-0005ol-Fx
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1iFj15-00058V-Ot
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:06:26 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:40146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1iFj15-000585-Dd
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 14:06:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id d22so83859pll.7
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 11:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tJKKum+4wgOevIYB58GwAamZSBkaHkRA5ulIY+f3RvY=;
 b=lYKC2Dv8phWXiqEQhiSYyNqOtp3GDqmfVyiL6fz4JLkbZUtEzQ73y9kPAPWM5kaJqB
 3csMUrLCBE9GE+kpxXcdlr42av+rycBckoAAEpJZLAel3njHI0kOEmtv42t9U+7E+E8D
 Dr/t1z7I8vaTuhZwFLTl/xnrDN56v7fIIyZvi3A2Jhv8aQyTkwtQEH3SX3w0dDS35Gix
 obw7b7amMTIjdIWTi6RLoWofx5V/YIMMS4Ec2ucCXrrCEIRFMCVYOSjuYrKH6sibYdp0
 GAJONSt/8WPF5Z1KGpSd7c6rFn0Hfhq9h6mw4HtVyRCFALMEvhtjncDSmCF42VIu1A1O
 zWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tJKKum+4wgOevIYB58GwAamZSBkaHkRA5ulIY+f3RvY=;
 b=f5oVEEp6Z30XHgqVpnMndfodAdRKXT64Wvt7r/dnCGbIEEwggMD765UOIIdBCX+SDm
 +wxpnvHiBrixsVLD8wykFHvkuPmypjFQJsAKyQkXrDq0khfh+nt+k9Czq6R0t1/si/7a
 zru1hjZ8hrkICp2gRGz9jph1cIhlBCpy8Ib52cPniKQaQAMTOw/F8LzIlewgYW3O52Pl
 F1T52gWS449REjkHWuPDuAOd7CDpy+1iBbRBDMqD2m9Gd/o4NJcI/sph5T9EcpFF+b88
 i+rT9SSpHevFOMblMZQDmhgadpKVgq7V26lkUlnP4GhVgNL8qZDf8z4yr5CT1tE9J1bG
 LWpA==
X-Gm-Message-State: APjAAAVjO1lWwhuiQSGTtD0e0hO6uLP/nyPa36zpph5YVN7FVa1S0l2/
 fsORw26+D482ggt5Hsip7GHNBYsx0naFBoU9xlcepA==
X-Google-Smtp-Source: APXvYqxvIf3QYkwS4MA7Ek5r0a2PZQagXEW2FpXI86uKBS7IMiVI5R4rXQI3VzGON6G0wHyTgXT8ouYleeCGvOK46hY=
X-Received: by 2002:a17:902:8d87:: with SMTP id
 v7mr5062792plo.126.1570039581227; 
 Wed, 02 Oct 2019 11:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
 <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
 <BN6PR2201MB125123754144B7214725BF05C6A30@BN6PR2201MB1251.namprd22.prod.outlook.com>
 <CADgy-2vkeDa2kPsamm=K=uceqo30A2n53AUfND4Dx3CifQeJAw@mail.gmail.com>
In-Reply-To: <CADgy-2vkeDa2kPsamm=K=uceqo30A2n53AUfND4Dx3CifQeJAw@mail.gmail.com>
From: Josh Kunz <jkz@google.com>
Date: Wed, 2 Oct 2019 11:06:09 -0700
Message-ID: <CADgy-2tjHYuK3Y66LGQHUoSesCeSYO40DoQk+oVkC1UzNP93Wg@mail.gmail.com>
Subject: Re: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and
 SIGRTMAX - 1
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Laurent Vivier <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, 
 "milos.stojanovic@rt-rk.com" <milos.stojanovic@rt-rk.com>,
 Petar Jovanovic <pjovanovic@wavecomp.com>, 
 "marlies.ruck@gmail.com" <marlies.ruck@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Shu-Chun Weng <scw@google.com>
Content-Type: multipart/alternative; boundary="0000000000008646000593f1538a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::635
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008646000593f1538a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So, this turned out to be much more complicated than I initially expected.

The current linux-user signal-handling implementation makes the assumption
that there is a 1:1 correspondence between host signals, and target (guest)
signals in a whole bunch of places. Breaking this assumption breaks a lot
of the signal handling code. I=E2=80=99m no longer sure that =E2=80=9Cmulti=
plexing=E2=80=9D is a
good solution. Here are some of the issues I=E2=80=99ve run into while impl=
ementing
this patch:

* Signal masks no longer work. The existing signal handling routines assume
that target masks can be translated into equivalent host masks, but if
multiple target signals map to a single host signal, the masks are no
longer equivalent. This can be addressed by maintaining a separate emulated
target signal mask (which is checked in process_pending_signals). Note:
this is largely addressed by Milos/Aleksandar's patch.
* sigaction no longer works. Right now, even though SIGRTMIN is mapped to
SIGRTMAX, we are still allowed to do a =E2=80=9Csigaction=E2=80=9D on the s=
ignal. Without a
1:1 mapping, the action table must be fully emulated.
* Syscall interruption (SA_RESTART and EINTR) breaks. Emulating the signal
action table means that QEMU must now implement SA_RESTART behavior (we
can=E2=80=99t rely on the kernel to do this), which will require changes to=
 most
syscalls.
* sigsuspend breaks. To avoid masking too many signals with a sigsuspend,
the host mask used for =E2=80=9Csigsuspend=E2=80=9D cannot block the multip=
lexing signal.
This means that the sigsuspend handler may get interrupted by a multiplexed
signal that is supposed to be masked by the target. Linux user-mode will
have to support signal queueing to track pending RT signals.
* signalfd breaks. If the user includes a multiplexed signal in the
=E2=80=9Csignalfd=E2=80=9D set, then signalfd behavior will have to be full=
y emulated. The
only way I can think to support this is by either completely emulating FDs,
or by using something like =E2=80=9Ceventfd=E2=80=9D or =E2=80=9Cmemfd=E2=
=80=9D to make a fake signalfd
(that still works with select), and then injecting siginfo structures when
the fake FD is read. Not pretty.
* sigtimedwait breaks. The given (target) sigset will not have an
equivalent host sigset if some target signals are multiplexed. The host
sigset will either be too large (possibly receiving some signals that
should remain pending), or too small (missing signals that fulfil the
target=E2=80=99s criteria, which is unacceptable). This can be worked-aroun=
d by
re-queuing signals and using -TARGET_ERESTARTSYS, but it=E2=80=99s quite
complicated to make this appear atomic.

These are just the things I have found so far. I=E2=80=99m not sure if this=
 is
everything that is required to add actual signal multiplexing support.

If QEMU follows through with signal multiplexing, it will be a big change
to QEMU signal handling. Full emulation of these signal aspects will bring
QEMU further away from kernel behavior, and introduce the possibility of
bugs or incompatibilities in QEMU=E2=80=99s signal-handling layer. To suppo=
rt
signals outside the host range, this is unavoidable; but for the SIGRTMIN,
SIGRTMIN+1 case, I=E2=80=99m not sure it=E2=80=99s worth it.

After considering these drawbacks, do the QEMU maintainers still think this
is the right approach for handling these libc reserved signals?

On Fri, Aug 30, 2019 at 6:26 PM Josh Kunz <jkz@google.com> wrote:

> I can take over the series. I'll rebase the patch set, and update it to
> address the SIGRTMIN - 1 issue. I should have an update sometime next wee=
k.
>
> On Wed, Aug 28, 2019 at 10:31 AM Aleksandar Markovic <
> amarkovic@wavecomp.com> wrote:
>
>> > From: Laurent Vivier <laurent@vivier.eu>
>> > Sent: Wednesday, August 28, 2019 10:51 AM
>> > To: Josh Kunz; Aleksandar Markovic; milos.stojanovic@rt-rk.com
>> > Cc: marlies.ruck@gmail.com; qemu-devel@nongnu.org; riku.voipio@iki.fi;
>> > qemu-trivial@nongnu.org; Peter Maydell; Shu-Chun Weng; Aleksandar
>> Markovic
>> > Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and
>> SIGRTMAX - 1
>> >
>> > Le 26/08/2019 =C3=A0 23:10, Josh Kunz a =C3=A9crit :
>> > > On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu
>> > > <mailto:laurent@vivier.eu>> wrote:
>> > >
>> > >     Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu-devel a =C3=A9cri=
t :
>> > >     > Hi all,
>> > >     >
>> > >     > I have also experienced issues with SIGRTMIN + 1, and am
>> interested in
>> > >     > moving this patch forwards. Anything I can do here to help?
>> Would the
>> > >     > maintainers prefer myself or Marli re-submit the patch?
>> > >     >
>> > >     > The Go issue here seems particularly sticky. Even if we update
>> the Go
>> > >     > runtime, users may try and run older binaries built with older
>> > >     versions of
>> > >     > Go for quite some time (months? years?). Would it be better to
>> > >     hide this
>> > >     > behind some kind of build-time flag
>> > >     (`--enable-sigrtmin-plus-one-proxy` or
>> > >     > something), so that some users can opt-in, but older binaries
>> > >     still work as
>> > >     > expected?
>> > >     >
>> > >     > Also, here is a link to the original thread this message is in
>> > >     reply to
>> > >     > in-case my mail-client doesn't set up the reply properly:
>> > >     >
>> https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html
>> > >
>> > >     The problem here is we break something to fix something else.
>> > >
>> > >     I'm wondering if the series from Aleksandar Markovic, "linux-use=
r:
>> > >     Support signal passing for targets having more signals than host=
"
>> [1]
>> > >     can fix the problem in a better way?
>> > >
>> > >
>> > > That patch[1] (which I'll refer to as the MUX patch to avoid
>> confusion)
>> > > does not directly fix the issue addressed by this patch (re-wiring
>> > > SIGRTMIN+1), but since it basically implements generic signal
>> > > multiplexing, it could be re-worked to address this case as well. Th=
e
>> > > way it handles `si_code` spooks me a little bit. It could easily be
>> > > broken by a kernel version change, and such a breakage could be hard
>> to
>> > > detect or lead to surprising results. Other than that, it looks like=
 a
>> > > reasonable implementation.
>> > >
>> > > That said, overall, fixing the SIGRTMIN+1 issue using a more-generic
>> > > signal-multiplexing mechanism doesn't seem *that* much better to me.
>> It
>> > > adds a lot of complexity, and only saves a single signal (assuming
>> glibc
>> > > doesn't add more reserved signals). The "big win" is additional
>> > > emulation features, like those introduced in MUX patch (being able t=
o
>> > > utilize signals outside of the host range). If having those features
>> in
>> > > QEMU warrants the additional complexity, then re-working this patch
>> > > on-top of that infrastructure seems like a good idea.
>> > >
>> > > If the maintainers want to go down that route, then I would be happy
>> to
>> > > re-work this patch utilizing the infrastructure from the MUX patch.
>> > > Unfortunately it will require non-trivial changes, so it may be best
>> to
>> > > wait until that patch is merged. I could also provide a patch "on to=
p
>> > > of" the MUX patch, if that's desired/more convenient.
>> > >
>> > > Just one last note, if you do decide to merge the MUX patch, then it
>> > > would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the
>> > > multiplexing signal if possible, to avoid breaking go binaries.
>> > >
>> >
>> > Personally, I prefer a solution that breaks nothing.
>> >
>> > Aleksandar, Milos,
>> >
>> > do you have an updated version of you series "Support signal passing f=
or
>> > targets having more signals than host"?
>> >
>>
>> Milos is unfortunetely working on an entirely different project now, and
>> can't spare enough time to finish the series. I am also busy with other
>> issues, even though I would like very much this or equivalent solution t=
o
>> be integrated. Alternatively, someone in the team may have time later th=
is
>> year, but I do not know that yet  - perhaps somebody else (Josh) can tak=
e
>> over the series?
>>
>> Sincerely,
>> Aleksandar
>>
>>
>> > Thanks,
>> > Laurent
>> >
>
>

--0000000000008646000593f1538a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">So, this turned out to be much more complicated than I ini=
tially expected.<br><br>The current linux-user signal-handling implementati=
on makes the assumption that there is a 1:1 correspondence between host sig=
nals, and target (guest) signals in a whole bunch of places. Breaking this =
assumption breaks a lot of the signal handling code. I=E2=80=99m no longer =
sure that =E2=80=9Cmultiplexing=E2=80=9D is a good solution. Here are some =
of the issues I=E2=80=99ve run into while implementing this patch:<br><br>*=
 Signal masks no longer work. The existing signal handling routines assume =
that target masks can be translated into equivalent host masks, but if mult=
iple target signals map to a single host signal, the masks are no longer eq=
uivalent. This can be addressed by maintaining a separate emulated target s=
ignal mask (which is checked in process_pending_signals). Note: this is lar=
gely addressed by Milos/Aleksandar&#39;s patch.<br>* sigaction no longer wo=
rks. Right now, even though SIGRTMIN is mapped to SIGRTMAX, we are still al=
lowed to do a =E2=80=9Csigaction=E2=80=9D on the signal. Without a 1:1 mapp=
ing, the action table must be fully emulated.<br>* Syscall interruption (SA=
_RESTART and EINTR) breaks. Emulating the signal action table means that QE=
MU must now implement SA_RESTART behavior (we can=E2=80=99t rely on the ker=
nel to do this), which will require changes to most syscalls.<br>* sigsuspe=
nd breaks. To avoid masking too many signals with a sigsuspend, the host ma=
sk used for =E2=80=9Csigsuspend=E2=80=9D cannot block the multiplexing sign=
al. This means that the sigsuspend handler may get interrupted by a multipl=
exed signal that is supposed to be masked by the target. Linux user-mode wi=
ll have to support signal queueing to track pending RT signals.<br>* signal=
fd breaks. If the user includes a multiplexed signal in the =E2=80=9Csignal=
fd=E2=80=9D set, then signalfd behavior will have to be fully emulated. The=
 only way I can think to support this is by either completely emulating FDs=
, or by using something like =E2=80=9Ceventfd=E2=80=9D or =E2=80=9Cmemfd=E2=
=80=9D to make a fake signalfd (that still works with select), and then inj=
ecting siginfo structures when the fake FD is read. Not pretty.<br>* sigtim=
edwait breaks. The given (target) sigset will not have an equivalent host s=
igset if some target signals are multiplexed. The host sigset will either b=
e too large (possibly receiving some signals that should remain pending), o=
r too small (missing signals that fulfil the target=E2=80=99s criteria, whi=
ch is unacceptable). This can be worked-around by re-queuing signals and us=
ing -TARGET_ERESTARTSYS, but it=E2=80=99s quite complicated to make this ap=
pear atomic.<br><br>These are just the things I have found so far. I=E2=80=
=99m not sure if this is everything that is required to add actual signal m=
ultiplexing support.<br><br>If QEMU follows through with signal multiplexin=
g, it will be a big change to QEMU signal handling. Full emulation of these=
 signal aspects will bring QEMU further away from kernel behavior, and intr=
oduce the possibility of bugs or incompatibilities in QEMU=E2=80=99s signal=
-handling layer. To support signals outside the host range, this is unavoid=
able; but for the SIGRTMIN, SIGRTMIN+1 case, I=E2=80=99m not sure it=E2=80=
=99s worth it.<div><br></div><div>After considering these drawbacks, do the=
 QEMU maintainers still think this is the right approach for handling these=
 libc reserved signals?<br></div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Fri, Aug 30, 2019 at 6:26 PM Josh Kunz =
&lt;<a href=3D"mailto:jkz@google.com">jkz@google.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">I can =
take over the series. I&#39;ll rebase the patch set, and update it to addre=
ss the SIGRTMIN - 1 issue. I should have an update sometime next week.</div=
><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On We=
d, Aug 28, 2019 at 10:31 AM Aleksandar Markovic &lt;<a href=3D"mailto:amark=
ovic@wavecomp.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; From: Laure=
nt Vivier &lt;<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank">lauren=
t@vivier.eu</a>&gt;<br>
&gt; Sent: Wednesday, August 28, 2019 10:51 AM<br>
&gt; To: Josh Kunz; Aleksandar Markovic; <a href=3D"mailto:milos.stojanovic=
@rt-rk.com" target=3D"_blank">milos.stojanovic@rt-rk.com</a><br>
&gt; Cc: <a href=3D"mailto:marlies.ruck@gmail.com" target=3D"_blank">marlie=
s.ruck@gmail.com</a>; <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_b=
lank">qemu-devel@nongnu.org</a>; <a href=3D"mailto:riku.voipio@iki.fi" targ=
et=3D"_blank">riku.voipio@iki.fi</a>; &gt; <a href=3D"mailto:qemu-trivial@n=
ongnu.org" target=3D"_blank">qemu-trivial@nongnu.org</a>; Peter Maydell; Sh=
u-Chun Weng; Aleksandar Markovic<br>
&gt; Subject: [EXTERNAL]Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIG=
RTMAX - 1<br>
&gt; <br>
&gt; Le 26/08/2019 =C3=A0 23:10, Josh Kunz a =C3=A9crit :<br>
&gt; &gt; On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier &lt;<a href=3D"mai=
lto:laurent@vivier.eu" target=3D"_blank">laurent@vivier.eu</a><br>
&gt; &gt; &lt;mailto:<a href=3D"mailto:laurent@vivier.eu" target=3D"_blank"=
>laurent@vivier.eu</a>&gt;&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Le 19/08/2019 =C3=A0 23:46, Josh Kunz via Qemu=
-devel a =C3=A9crit :<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi all,<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; I have also experienced issues with SIGRT=
MIN + 1, and am interested in<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; moving this patch forwards. Anything I ca=
n do here to help? Would the<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; maintainers prefer myself or Marli re-sub=
mit the patch?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; The Go issue here seems particularly stic=
ky. Even if we update the Go<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; runtime, users may try and run older bina=
ries built with older<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0versions of<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Go for quite some time (months? years?). =
Would it be better to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0hide this<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; behind some kind of build-time flag<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0(`--enable-sigrtmin-plus-one-proxy` or<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; something), so that some users can opt-in=
, but older binaries<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0still work as<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; expected?<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; Also, here is a link to the original thre=
ad this message is in<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0reply to<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; in-case my mail-client doesn&#39;t set up=
 the reply properly:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0&gt; <a href=3D"https://lists.nongnu.org/archi=
ve/html/qemu-devel/2019-07/msg01303.html" rel=3D"noreferrer" target=3D"_bla=
nk">https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html<=
/a><br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0The problem here is we break something to fix =
something else.<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0I&#39;m wondering if the series from Aleksanda=
r Markovic, &quot;linux-user:<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0Support signal passing for targets having more=
 signals than host&quot; [1]<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0can fix the problem in a better way?<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; That patch[1] (which I&#39;ll refer to as the MUX patch to avoid =
confusion)<br>
&gt; &gt; does not directly fix the issue addressed by this patch (re-wirin=
g<br>
&gt; &gt; SIGRTMIN+1), but since it basically implements generic signal<br>
&gt; &gt; multiplexing, it could be re-worked to address this case as well.=
 The<br>
&gt; &gt; way it handles `si_code` spooks me a little bit. It could easily =
be<br>
&gt; &gt; broken by a kernel version change, and such a breakage could be h=
ard to<br>
&gt; &gt; detect or lead to surprising results. Other than that, it looks l=
ike a<br>
&gt; &gt; reasonable implementation.<br>
&gt; &gt;<br>
&gt; &gt; That said, overall, fixing the SIGRTMIN+1 issue using a more-gene=
ric<br>
&gt; &gt; signal-multiplexing mechanism doesn&#39;t seem *that* much better=
 to me. It<br>
&gt; &gt; adds a lot of complexity, and only saves a single signal (assumin=
g glibc<br>
&gt; &gt; doesn&#39;t add more reserved signals). The &quot;big win&quot; i=
s additional<br>
&gt; &gt; emulation features, like those introduced in MUX patch (being abl=
e to<br>
&gt; &gt; utilize signals outside of the host range). If having those featu=
res in<br>
&gt; &gt; QEMU warrants the additional complexity, then re-working this pat=
ch<br>
&gt; &gt; on-top of that infrastructure seems like a good idea.<br>
&gt; &gt;<br>
&gt; &gt; If the maintainers want to go down that route, then I would be ha=
ppy to<br>
&gt; &gt; re-work this patch utilizing the infrastructure from the MUX patc=
h.<br>
&gt; &gt; Unfortunately it will require non-trivial changes, so it may be b=
est to<br>
&gt; &gt; wait until that patch is merged. I could also provide a patch &qu=
ot;on top<br>
&gt; &gt; of&quot; the MUX patch, if that&#39;s desired/more convenient.<br=
>
&gt; &gt;<br>
&gt; &gt; Just one last note, if you do decide to merge the MUX patch, then=
 it<br>
&gt; &gt; would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the<br>
&gt; &gt; multiplexing signal if possible, to avoid breaking go binaries.<b=
r>
&gt; &gt;<br>
&gt; <br>
&gt; Personally, I prefer a solution that breaks nothing.<br>
&gt; <br>
&gt; Aleksandar, Milos,<br>
&gt; <br>
&gt; do you have an updated version of you series &quot;Support signal pass=
ing for<br>
&gt; targets having more signals than host&quot;?<br>
&gt; <br>
<br>
Milos is unfortunetely working on an entirely different project now, and ca=
n&#39;t spare enough time to finish the series. I am also busy with other i=
ssues, even though I would like very much this or equivalent solution to be=
 integrated. Alternatively, someone in the team may have time later this ye=
ar, but I do not know that yet=C2=A0 - perhaps somebody else (Josh) can tak=
e over the series?<br>
<br>
Sincerely,<br>
Aleksandar<br>
<br>
<br>
&gt; Thanks,<br>
&gt; Laurent<br>
&gt; </blockquote></div>
</blockquote></div>

--0000000000008646000593f1538a--

