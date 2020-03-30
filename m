Return-Path: <SRS0=g3Vr=5P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B230C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485862073B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2020 17:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=thatjames.org header.i=@thatjames.org header.b="pz1H/SkW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485862073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thatjames.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIyd4-0003Eg-FP
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 13:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benjamin@thatjames.org>) id 1jIyPe-0003pF-Ol
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benjamin@thatjames.org>) id 1jIyPb-0004hR-V5
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:26 -0400
Received: from gateway30.websitewelcome.com ([192.185.149.4]:45638)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benjamin@thatjames.org>)
 id 1jIyPa-0004PI-Qo
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 13:41:23 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
 by gateway30.websitewelcome.com (Postfix) with ESMTP id 59CC5D6FCA
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 12:41:10 -0500 (CDT)
Received: from box5531.bluehost.com ([162.241.218.31]) by cmsmtp with SMTP
 id IyPOjOu0I8vkBIyPOjE222; Mon, 30 Mar 2020 12:41:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=thatjames.org; s=default; h=Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OVmb57nRK1un8qE1g7nKwaAtiQsj8X/4LgHPqL0HXXU=; b=pz1H/SkW50HM9wry6DmAmysLi
 hMBR/3dI/IoY1opyxctwuM7RJlyiqDaO/gogZ1u6DLzoaXcPMHoglaNIRYBJfku4+dQ31kYGv9OQF
 kXJkUFzQeqP4PG/otDusLX9qBI8S+0RGsQRpKGbWqSG4Pyf4oSmNMMZqCQd0NR074JJb+yeHo7WdU
 h43/aLqKYyt4heUnFvRH/Wf29Ar/tsmHL8y0nxglsMvZYcoqy8nwlOSTGPhY0s8ATHLASR/9nVgqV
 ibasqfp+04ChiSoWM43/pvPRB+QYcpCwgjGRv8qZP5GeJ2aCZOZvyTvc1veIYiwpr+WUosnkDOTAF
 9byvlcAsg==;
Received: from mail-lf1-f54.google.com ([209.85.167.54]:41657)
 by box5531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <benjamin@thatjames.org>)
 id 1jIyPN-0016ef-Ty; Mon, 30 Mar 2020 11:41:10 -0600
Received: by mail-lf1-f54.google.com with SMTP id z23so14968425lfh.8;
 Mon, 30 Mar 2020 10:41:09 -0700 (PDT)
X-Gm-Message-State: AGi0PubzjBrTv5UNVJfiDwJasmsjaVZFO+ExioUjO0onmxY8qP9AIssW
 I4aJdqcR63ss4zO2aLA0GV4p7ZSNLnWzLLJpjqc=
X-Google-Smtp-Source: APiQypIM8U259fBRcApwJAVH+xGb8vI7f1VfsHITvUcYbs+7YFb7HwkojfCl24XPZ3N+LiTZl0P/fwIMuhgVeiIJ2Wo=
X-Received: by 2002:a05:6512:202d:: with SMTP id
 s13mr8689189lfs.19.1585590068820; 
 Mon, 30 Mar 2020 10:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAOragkw8XgbEOiaE9n=wKzPAMkzdOcqA5VA5ihN80v-g7V8TRw@mail.gmail.com>
 <20200329111311.272958fe@luklap> <878sjhho0s.fsf@linaro.org>
In-Reply-To: <878sjhho0s.fsf@linaro.org>
From: Benjamin <benjamin@thatjames.org>
Date: Mon, 30 Mar 2020 11:40:57 -0600
X-Gmail-Original-Message-ID: <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
Message-ID: <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
Subject: Re: Qemu TCG Plugins - how to access guest registers?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cfc14805a215f45b"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5531.bluehost.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thatjames.org
X-BWhitelist: no
X-Source-IP: 209.85.167.54
X-Source-L: No
X-Exim-ID: 1jIyPN-0016ef-Ty
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-lf1-f54.google.com [209.85.167.54]:41657
X-Source-Auth: benjamin@thatjames.org
X-Email-Count: 2
X-Source-Cap: dGhhdGphbWU7dGhhdGphbWU7Ym94NTUzMS5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.185.149.4
X-Mailman-Approved-At: Mon, 30 Mar 2020 13:54:13 -0400
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
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cfc14805a215f45b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for your quick response.

On Mon, Mar 30, 2020 at 9:15 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Lukas Straub <lukasstraub2@web.de> writes:
>
> >> My question is, how do I access the guest memory and registers from th=
e
> >> plugin callback function? The API seems to indicate that it is possibl=
e,
> >> since the callback registering requires you to say if you will access
> them,
> >> and if it's RW or just read.
>
> Currently we document what plugins can do in docs/devel/tcg-plugins.rst:
>
>   TCG plugins are unable to change the system state only monitor it
>   passively. However they can do this down to an individual instruction
>   granularity including potentially subscribing to all load and store
>   operations.
>
> This was a conscious decision to avoid plugins being used as an end-run
> around the GPL to implement proprietary out-of-tree extensions.
>
> That is not to say we might relax the rules in the future - it was a
> topic of discussion at the maintainers summit and we wanted to document
> some guidelines around interfacing with QEMU so people didn't get the
> wrong idea about what these APIs provide (c.f. multi-process qemu and
> vhost-user which could also be abused in similar ways).
>

I understand restricting the API so that the system state cannot be
changed, only inspected.  I should have been more specific in my question.
I am attempting to create a plugin that tracks all memory accesses, so I
can emulate cache behavior.  The reason I would like to read the registers,
is because many load/store instructions depend on register values, which I
can only be sure of at run-time.
Some of the concepts you mentioned I am not very familiar with; I am simply
emulating an ARM A9 processor in bare-metal mode, to give you a point of
reference of my use case.


> Indeed Emilio's original tree did contain these more invasive hooks and
> while we deliberate upstream it will hopefully not be as hard to
> maintain a light out-of-tree fork should you need such functionality now.
>

Could you please point me towards this tree?  I haven't run across it yet
in my investigating of all of this.


> >> Are there any examples of using this part of the API? I realize this i=
s
> a
> >> very new part of Qemu functionality.
>
> So far the examples represent the totality of the API that has been
> exercised and I'm keen we add more as new extensions to the API are
> added. As to the specific question about accessing register values that
> is exactly down to the newness of the API.
>
> Register access is a tricky problem because of the fact that QEMU
> supports so many guest architectures. I wasn't keen on slapping in a
> functional but ugly API that hard-coded values like gdb register ids so
> I left it out for the time being. I'd happily accept patches to add that
> functionality assuming it meets the projects quality and taste
> guidelines.
>
> Some approaches we could take include:
>
>   - hook into tcg_global_*_new and allow plugin to introspect registers
>   - hook into gdbstub in some way
>
> The first approach elides over the fact that a lot of registers aren't
> actually known to the TCG - pretty much all vector registers tend to be
> loaded into anonymous TCG temps as we go. Maybe this could just be fixed
> by just providing a few more registrations functions at the start even
> if the TCG itself wouldn't use that knowledge.
>
> The gdbstub provides a lot more visibility of register state and for
> some architectures this can be quite comprehensive - for example in
> system mode you can access pretty much every ARM co-processor register.
> However the gdb interface is a little clunky as there are a lot of magic
> register id numbers and the canonical way to enumerate this is to chew
> through a bunch of XML that each target generates (see
> gdb_register_coprocessor). I'm not keen on exposing that pile of XML via
> the register interface. Maybe there is scope to improve our internal
> APIs so the enumeration of registers can be handled by helpers that
> record mappings and ids and generate the XML for the gdbstub centrally?
>
> There may be other approaches we could take and I'm open to suggestions.
>

I'd be happy to look into ways to implement this functionality.  However, I
just started using Qemu this year, so these things sound like they would
have a steep learning curve for me.
The gdbstub approach seems like it would provide the most introspection
ability.  What would you suggest as a starting point for looking into this?
All of this being said, if you think my project is too complicated, to
implement a cache emulator with TCG plugins, then I could always try just
hacking together some custom helper functions.


> --
> Alex Benn=C3=A9e
>

Thanks

--000000000000cfc14805a215f45b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks for your quick response.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 30, 2020=
 at 9:15 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">=
alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
Lukas Straub &lt;<a href=3D"mailto:lukasstraub2@web.de" target=3D"_blank">l=
ukasstraub2@web.de</a>&gt; writes:<br>
<br>&gt;&gt; My question is, how do I access the guest memory and registers=
 from the<br>
&gt;&gt; plugin callback function? The API seems to indicate that it is pos=
sible,<br>
&gt;&gt; since the callback registering requires you to say if you will acc=
ess them,<br>
&gt;&gt; and if it&#39;s RW or just read.<br>
<br>
Currently we document what plugins can do in docs/devel/tcg-plugins.rst:<br=
>
<br>
=C2=A0 TCG plugins are unable to change the system state only monitor it<br=
>
=C2=A0 passively. However they can do this down to an individual instructio=
n<br>
=C2=A0 granularity including potentially subscribing to all load and store<=
br>
=C2=A0 operations.<br>
<br>
This was a conscious decision to avoid plugins being used as an end-run<br>
around the GPL to implement proprietary out-of-tree extensions.<br>
<br>
That is not to say we might relax the rules in the future - it was a<br>
topic of discussion at the maintainers summit and we wanted to document<br>
some guidelines around interfacing with QEMU so people didn&#39;t get the<b=
r>
wrong idea about what these APIs provide (c.f. multi-process qemu and<br>
vhost-user which could also be abused in similar ways).<br></blockquote><di=
v><br></div><div>I understand restricting the API so that the system state =
cannot be changed, only inspected.=C2=A0 I should have been more specific i=
n my question.</div><div>I am attempting to create a plugin that tracks all=
 memory accesses, so I can emulate cache behavior.=C2=A0 The reason I would=
 like to read the registers, is because many load/store instructions depend=
 on register values, which I can only be sure of at run-time.</div><div>Som=
e of the concepts you mentioned I am not very familiar with; I am simply em=
ulating an ARM A9 processor in bare-metal mode, to give you a point of refe=
rence of my use case.</div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Indeed Emilio&#39;s original tree did contain these more invasive hooks and=
<br>
while we deliberate upstream it will hopefully not be as hard to<br>
maintain a light out-of-tree fork should you need such functionality now.<b=
r></blockquote><div>=C2=A0</div><div>Could you please point me towards this=
 tree?=C2=A0 I haven&#39;t run across it yet in my investigating of all of =
this.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
&gt;&gt; Are there any examples of using this part of the API? I realize th=
is is a<br>
&gt;&gt; very new part of Qemu functionality.<br>
<br>
So far the examples represent the totality of the API that has been<br>
exercised and I&#39;m keen we add more as new extensions to the API are<br>
added. As to the specific question about accessing register values that<br>
is exactly down to the newness of the API.<br>
<br>
Register access is a tricky problem because of the fact that QEMU<br>
supports so many guest architectures. I wasn&#39;t keen on slapping in a<br=
>
functional but ugly API that hard-coded values like gdb register ids so<br>
I left it out for the time being. I&#39;d happily accept patches to add tha=
t<br>
functionality assuming it meets the projects quality and taste<br>
guidelines.<br>
<br>
Some approaches we could take include:<br>
<br>
=C2=A0 - hook into tcg_global_*_new and allow plugin to introspect register=
s<br>
=C2=A0 - hook into gdbstub in some way<br>
<br>
The first approach elides over the fact that a lot of registers aren&#39;t<=
br>
actually known to the TCG - pretty much all vector registers tend to be<br>
loaded into anonymous TCG temps as we go. Maybe this could just be fixed<br=
>
by just providing a few more registrations functions at the start even<br>
if the TCG itself wouldn&#39;t use that knowledge.<br>
<br>
The gdbstub provides a lot more visibility of register state and for<br>
some architectures this can be quite comprehensive - for example in<br>
system mode you can access pretty much every ARM co-processor register.<br>
However the gdb interface is a little clunky as there are a lot of magic<br=
>
register id numbers and the canonical way to enumerate this is to chew<br>
through a bunch of XML that each target generates (see<br>
gdb_register_coprocessor). I&#39;m not keen on exposing that pile of XML vi=
a<br>
the register interface. Maybe there is scope to improve our internal<br>
APIs so the enumeration of registers can be handled by helpers that<br>
record mappings and ids and generate the XML for the gdbstub centrally?<br>
<br>
There may be other approaches we could take and I&#39;m open to suggestions=
.<br></blockquote><div>=C2=A0</div><div>I&#39;d be happy to look into ways =
to implement this functionality.=C2=A0 However, I just started using Qemu t=
his year, so these things sound like they would have a steep learning curve=
 for me.</div><div>The gdbstub approach seems like it would provide the mos=
t introspection ability.=C2=A0 What would you suggest as a starting point f=
or looking into this?</div><div>All of this being said, if you think my pro=
ject is too complicated, to implement a cache emulator with TCG plugins, th=
en I could always try just hacking together some custom helper functions.</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br></blockquote><div>=C2=A0</div><div>Thanks<br></div></di=
v></div>

--000000000000cfc14805a215f45b--

