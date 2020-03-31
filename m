Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784FAC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:27:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADAB20771
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 00:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=thatjames.org header.i=@thatjames.org header.b="iVx0cfHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADAB20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=thatjames.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJ4kF-0003N1-BN
	for qemu-devel@archiver.kernel.org; Mon, 30 Mar 2020 20:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <benjamin@thatjames.org>) id 1jJ4j6-0002dS-UY
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <benjamin@thatjames.org>) id 1jJ4j3-0004Qy-9c
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:25:55 -0400
Received: from gateway36.websitewelcome.com ([192.185.185.36]:39338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <benjamin@thatjames.org>)
 id 1jJ4j2-0004Mk-Sx
 for qemu-devel@nongnu.org; Mon, 30 Mar 2020 20:25:53 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
 by gateway36.websitewelcome.com (Postfix) with ESMTP id 673CB401F8009
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2020 18:42:32 -0500 (CDT)
Received: from box5531.bluehost.com ([162.241.218.31]) by cmsmtp with SMTP
 id J4j1jxkqp1s2xJ4j1jeBkj; Mon, 30 Mar 2020 19:25:51 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=thatjames.org; s=default; h=Content-Type:Cc:To:Subject:Message-ID:Date:From
 :In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bf7uBw4lJnts6k6fqFb4kEFHYAN+OQhMczEoCaumFZk=; b=iVx0cfHdDAOzGXzhYI+Uq6IVa
 bPziRXoe789oPSr2naqmtbI7qSv5mY4fSyKXWpUm4xapOuTqXqpVWoOJJ43ZghX/WZFvSN+O5dVxg
 iPGaytWz3E5b2PCiTr2CxgcYlGbcSLWtLeALwZf5g+81JigDXm1hkwolQftwyy/E+iRkDvCtkG+j5
 1FeDRc+Q9wIuiBiNc10KNazbq8RYpcfezL/ZFK0PHdBFBw0RBv5GUv6YegyfeeUXa/tZUSJFFdx2o
 GptoPz6RaqKy1mfehZTwLjZp/b5S8K+dQ6rUfxD+3iUjvIOYuVOauUltdTpR1Mk2Anfhq13ofE1NN
 VYf/UjpHw==;
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43074)
 by box5531.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <benjamin@thatjames.org>)
 id 1jJ4j1-0049A7-22; Mon, 30 Mar 2020 18:25:51 -0600
Received: by mail-lj1-f181.google.com with SMTP id g27so20063200ljn.10;
 Mon, 30 Mar 2020 17:25:50 -0700 (PDT)
X-Gm-Message-State: AGi0PuYSlkxxvytwEwBj0FAnF3xgqWFYmy5t2Dc/D89XtBAqzZfqTEIe
 2lch7GVG/eMWSl1o0aCIV1yTVHjh1aynVUkF/J4=
X-Google-Smtp-Source: APiQypL7U4ESO2ed/7FU64dSrgatVhuOwvNYWwAA9kYRIjuY0sEGiuZfzXkY0+Co0sNZUuufZ11OFYRs7t49Qcrmb28=
X-Received: by 2002:a2e:894e:: with SMTP id b14mr8327140ljk.103.1585614349667; 
 Mon, 30 Mar 2020 17:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAOragkw8XgbEOiaE9n=wKzPAMkzdOcqA5VA5ihN80v-g7V8TRw@mail.gmail.com>
 <20200329111311.272958fe@luklap> <878sjhho0s.fsf@linaro.org>
 <CAOragkwcnAYYdGOjaHWc1F7-hRnB9CHbgoUqEcc40A7muV+06Q@mail.gmail.com>
 <87wo71fxc1.fsf@linaro.org>
In-Reply-To: <87wo71fxc1.fsf@linaro.org>
From: Benjamin <benjamin@thatjames.org>
Date: Mon, 30 Mar 2020 18:25:38 -0600
X-Gmail-Original-Message-ID: <CAOragkwi-s7PvDEMB-OKF1s-N3D7caASOjWKJsQFmCu2bTvCaA@mail.gmail.com>
Message-ID: <CAOragkwi-s7PvDEMB-OKF1s-N3D7caASOjWKJsQFmCu2bTvCaA@mail.gmail.com>
Subject: Re: Qemu TCG Plugins - how to access guest registers?
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001013c805a21b9cdc"
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5531.bluehost.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thatjames.org
X-BWhitelist: no
X-Source-IP: 209.85.208.181
X-Source-L: No
X-Exim-ID: 1jJ4j1-0049A7-22
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: mail-lj1-f181.google.com [209.85.208.181]:43074
X-Source-Auth: benjamin@thatjames.org
X-Email-Count: 5
X-Source-Cap: dGhhdGphbWU7dGhhdGphbWU7Ym94NTUzMS5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 192.185.185.36
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
Cc: Lukas Straub <lukasstraub2@web.de>, "Emilio G . Cota" <cota@braap.org>,
 qemu-devel@nongnu.org, qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001013c805a21b9cdc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 1:37 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:

>
> Benjamin <benjamin@thatjames.org> writes:
>
> > Thanks for your quick response.
> >
> > On Mon, Mar 30, 2020 at 9:15 AM Alex Benn=C3=A9e <alex.bennee@linaro.or=
g>
> wrote:
> >
> >>
> >> Lukas Straub <lukasstraub2@web.de> writes:
> >>
> >> >> My question is, how do I access the guest memory and registers from
> the
> >> >> plugin callback function? The API seems to indicate that it is
> possible,
> >> >> since the callback registering requires you to say if you will acce=
ss
> >> them,
> >> >> and if it's RW or just read.
> >>
> >> Currently we document what plugins can do in docs/devel/tcg-plugins.rs=
t:
> >>
> >>   TCG plugins are unable to change the system state only monitor it
> >>   passively. However they can do this down to an individual instructio=
n
> >>   granularity including potentially subscribing to all load and store
> >>   operations.
> >>
> >> This was a conscious decision to avoid plugins being used as an end-ru=
n
> >> around the GPL to implement proprietary out-of-tree extensions.
> >>
> >> That is not to say we might relax the rules in the future - it was a
> >> topic of discussion at the maintainers summit and we wanted to documen=
t
> >> some guidelines around interfacing with QEMU so people didn't get the
> >> wrong idea about what these APIs provide (c.f. multi-process qemu and
> >> vhost-user which could also be abused in similar ways).
> >>
> >
> > I understand restricting the API so that the system state cannot be
> > changed, only inspected.  I should have been more specific in my
> question.
> > I am attempting to create a plugin that tracks all memory accesses, so =
I
> > can emulate cache behavior.
>
> Emulate or measure? By the way there is a GSoC project proposal to add
> this:
>
>   https://wiki.qemu.org/Internships/ProjectIdeas/CacheModelling
>

Definitely emulate - I already have C code that can track which memory
addresses have been loaded into the cache (though not the actual data).
The idea for using QEMU for this project came from a research paper I read
awhile ago, but they were using version 0.12:
https://ieeexplore.ieee.org/document/6945730
I started trying to create this with helper functions, but when I heard
about the plugins, that sounded like a cleaner way to go.
The end goal is being able to use QEMU as a fault injection platform, to
test the effects of Single-bit upsets on baremetal C code.  So I would like
some way to interact with the plugin as QEMU is running; I have some ideas
on how to do this, but none fleshed out yet.
I actually saw this morning on qemu-discuss that someone was asking if
something like Valgrind could be created using the TCG plugins, so there is
certainly interest in this kind of thing.


> > The reason I would like to read the registers,
> > is because many load/store instructions depend on register values, whic=
h
> I
> > can only be sure of at run-time.
>
> You don't need the registers at that point because at run time QEMU will
> have already resolved the address and will pass it via the
> qemu_plugin_register_vcpu_mem_cb. The hotpages and mem plugin examples
> demonstrate the use of the API.
>

The way you explained this, although it might seem simple, really helped me
understand better the level at which the TCG plugins operate.
I went and changed my code to be more based on the code in hotpages.c, and
it is much simpler now.
I'm going to go look at that Dinero Cache Simulator you linked to see if I
can get any ideas on how to improve my cache code.


> > Some of the concepts you mentioned I am not very familiar with; I am
> simply
> > emulating an ARM A9 processor in bare-metal mode, to give you a point o=
f
> > reference of my use case.
> >
> >
> >> Indeed Emilio's original tree did contain these more invasive hooks an=
d
> >> while we deliberate upstream it will hopefully not be as hard to
> >> maintain a light out-of-tree fork should you need such functionality
> now.
> >>
> >
> > Could you please point me towards this tree?  I haven't run across it y=
et
> > in my investigating of all of this.
>
> His tree is at:
>
>   https://github.com/cota/qemu
>
> But I'm not sure what his latest branch is. I've CC'd him.
>
> >
> >
> >> >> Are there any examples of using this part of the API? I realize thi=
s
> is
> >> a
> >> >> very new part of Qemu functionality.
> >>
> >> So far the examples represent the totality of the API that has been
> >> exercised and I'm keen we add more as new extensions to the API are
> >> added. As to the specific question about accessing register values tha=
t
> >> is exactly down to the newness of the API.
> >>
> >> Register access is a tricky problem because of the fact that QEMU
> >> supports so many guest architectures. I wasn't keen on slapping in a
> >> functional but ugly API that hard-coded values like gdb register ids s=
o
> >> I left it out for the time being. I'd happily accept patches to add th=
at
> >> functionality assuming it meets the projects quality and taste
> >> guidelines.
> >>
> >> Some approaches we could take include:
> >>
> >>   - hook into tcg_global_*_new and allow plugin to introspect register=
s
> >>   - hook into gdbstub in some way
> >>
> >> The first approach elides over the fact that a lot of registers aren't
> >> actually known to the TCG - pretty much all vector registers tend to b=
e
> >> loaded into anonymous TCG temps as we go. Maybe this could just be fix=
ed
> >> by just providing a few more registrations functions at the start even
> >> if the TCG itself wouldn't use that knowledge.
> >>
> >> The gdbstub provides a lot more visibility of register state and for
> >> some architectures this can be quite comprehensive - for example in
> >> system mode you can access pretty much every ARM co-processor register=
.
> >> However the gdb interface is a little clunky as there are a lot of mag=
ic
> >> register id numbers and the canonical way to enumerate this is to chew
> >> through a bunch of XML that each target generates (see
> >> gdb_register_coprocessor). I'm not keen on exposing that pile of XML v=
ia
> >> the register interface. Maybe there is scope to improve our internal
> >> APIs so the enumeration of registers can be handled by helpers that
> >> record mappings and ids and generate the XML for the gdbstub centrally=
?
> >>
> >> There may be other approaches we could take and I'm open to suggestion=
s.
> >>
> >
> > I'd be happy to look into ways to implement this functionality.
> However, I
> > just started using Qemu this year, so these things sound like they woul=
d
> > have a steep learning curve for me.
> > The gdbstub approach seems like it would provide the most introspection
> > ability.  What would you suggest as a starting point for looking into
> this?
> > All of this being said, if you think my project is too complicated, to
> > implement a cache emulator with TCG plugins, then I could always try ju=
st
> > hacking together some custom helper functions.
>
> As I said above I don't think you need register values to do cache
> emulation as you have the addresses. You will need to decode some of the
> cache management instructions though. Fortunately you can do that at
> translation time and only instrument the ones you need. See howvec for
> examples.
>

I'm not familiar with cache management instructions.  What exactly do you
mean by that?  It sounds like something that would be dependent on the
guest architecture.
Or maybe it's things like pre-fetching hints?  Then the plugin would need
to take into account cache latencies, something my code doesn't deal with
right now.


> --
> Alex Benn=C3=A9e
>

I would be glad to share my implementation once it's in a better working
state.
Where can I find guidelines on the coding standard expected of QEMU
software?
Thanks

--0000000000001013c805a21b9cdc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 30, 2020 at 1:37 PM Alex Benn=
=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org" target=3D"_blank">ale=
x.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex"><br>
Benjamin &lt;<a href=3D"mailto:benjamin@thatjames.org" target=3D"_blank">be=
njamin@thatjames.org</a>&gt; writes:<br>
<br>
&gt; Thanks for your quick response.<br>
&gt;<br>
&gt; On Mon, Mar 30, 2020 at 9:15 AM Alex Benn=C3=A9e &lt;<a href=3D"mailto=
:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a>&gt; w=
rote:<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt; Lukas Straub &lt;<a href=3D"mailto:lukasstraub2@web.de" target=3D"=
_blank">lukasstraub2@web.de</a>&gt; writes:<br>
&gt;&gt;<br>
&gt;&gt; &gt;&gt; My question is, how do I access the guest memory and regi=
sters from the<br>
&gt;&gt; &gt;&gt; plugin callback function? The API seems to indicate that =
it is possible,<br>
&gt;&gt; &gt;&gt; since the callback registering requires you to say if you=
 will access<br>
&gt;&gt; them,<br>
&gt;&gt; &gt;&gt; and if it&#39;s RW or just read.<br>
&gt;&gt;<br>
&gt;&gt; Currently we document what plugins can do in docs/devel/tcg-plugin=
s.rst:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0TCG plugins are unable to change the system state only=
 monitor it<br>
&gt;&gt;=C2=A0 =C2=A0passively. However they can do this down to an individ=
ual instruction<br>
&gt;&gt;=C2=A0 =C2=A0granularity including potentially subscribing to all l=
oad and store<br>
&gt;&gt;=C2=A0 =C2=A0operations.<br>
&gt;&gt;<br>
&gt;&gt; This was a conscious decision to avoid plugins being used as an en=
d-run<br>
&gt;&gt; around the GPL to implement proprietary out-of-tree extensions.<br=
>
&gt;&gt;<br>
&gt;&gt; That is not to say we might relax the rules in the future - it was=
 a<br>
&gt;&gt; topic of discussion at the maintainers summit and we wanted to doc=
ument<br>
&gt;&gt; some guidelines around interfacing with QEMU so people didn&#39;t =
get the<br>
&gt;&gt; wrong idea about what these APIs provide (c.f. multi-process qemu =
and<br>
&gt;&gt; vhost-user which could also be abused in similar ways).<br>
&gt;&gt;<br>
&gt;<br>
&gt; I understand restricting the API so that the system state cannot be<br=
>
&gt; changed, only inspected.=C2=A0 I should have been more specific in my =
question.<br>
&gt; I am attempting to create a plugin that tracks all memory accesses, so=
 I<br>
&gt; can emulate cache behavior.<br>
<br>
Emulate or measure? By the way there is a GSoC project proposal to add<br>
this:<br>
<br>
=C2=A0 <a href=3D"https://wiki.qemu.org/Internships/ProjectIdeas/CacheModel=
ling" rel=3D"noreferrer" target=3D"_blank">https://wiki.qemu.org/Internship=
s/ProjectIdeas/CacheModelling</a><br></blockquote><div>=C2=A0</div><div>Def=
initely emulate - I already have C code that can track which memory address=
es have been loaded into the cache (though not the actual data).</div><div>=
The idea for using QEMU for this project came from a research paper I read =
awhile ago, but they were using version 0.12:</div><div><a href=3D"https://=
ieeexplore.ieee.org/document/6945730" target=3D"_blank">https://ieeexplore.=
ieee.org/document/6945730</a><br></div><div>I started trying to create this=
 with helper functions, but when I heard about the plugins, that sounded li=
ke a cleaner way to go.</div><div>The end goal is being able to use QEMU as=
 a fault injection platform, to test the effects of Single-bit upsets on ba=
remetal=C2=A0C code.=C2=A0 So I would like some way to interact with the pl=
ugin as QEMU is running; I have some ideas on how to do this, but none fles=
hed out yet.</div><div>I actually saw this morning on qemu-discuss that som=
eone was asking if something like Valgrind could be created using the TCG p=
lugins, so there is certainly interest in this kind of thing.<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; The reason I would like to read the registers,<br>
&gt; is because many load/store instructions depend on register values, whi=
ch I<br>
&gt; can only be sure of at run-time.<br>
<br>
You don&#39;t need the registers at that point because at run time QEMU wil=
l<br>
have already resolved the address and will pass it via the<br>
qemu_plugin_register_vcpu_mem_cb. The hotpages and mem plugin examples<br>
demonstrate the use of the API.=C2=A0<br></blockquote><div><br></div><div>T=
he way you explained this, although it might seem simple, really helped me =
understand better the level at which the TCG plugins operate.</div><div>I w=
ent and changed my code to be more based on the code in hotpages.c, and it =
is much simpler now.</div><div>I&#39;m going to go look at that Dinero Cach=
e Simulator you linked to see if I can get any ideas on how to improve my c=
ache code.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
&gt; Some of the concepts you mentioned I am not very familiar with; I am s=
imply<br>
&gt; emulating an ARM A9 processor in bare-metal mode, to give you a point =
of<br>
&gt; reference of my use case.<br>
&gt;<br>
&gt;<br>
&gt;&gt; Indeed Emilio&#39;s original tree did contain these more invasive =
hooks and<br>
&gt;&gt; while we deliberate upstream it will hopefully not be as hard to<b=
r>
&gt;&gt; maintain a light out-of-tree fork should you need such functionali=
ty now.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Could you please point me towards this tree?=C2=A0 I haven&#39;t run a=
cross it yet<br>
&gt; in my investigating of all of this.<br>
<br>
His tree is at:<br>
<br>
=C2=A0 <a href=3D"https://github.com/cota/qemu" rel=3D"noreferrer" target=
=3D"_blank">https://github.com/cota/qemu</a><br>
<br>
But I&#39;m not sure what his latest branch is. I&#39;ve CC&#39;d him.<br>
<br>
&gt;<br>
&gt;<br>
&gt;&gt; &gt;&gt; Are there any examples of using this part of the API? I r=
ealize this is<br>
&gt;&gt; a<br>
&gt;&gt; &gt;&gt; very new part of Qemu functionality.<br>
&gt;&gt;<br>
&gt;&gt; So far the examples represent the totality of the API that has bee=
n<br>
&gt;&gt; exercised and I&#39;m keen we add more as new extensions to the AP=
I are<br>
&gt;&gt; added. As to the specific question about accessing register values=
 that<br>
&gt;&gt; is exactly down to the newness of the API.<br>
&gt;&gt;<br>
&gt;&gt; Register access is a tricky problem because of the fact that QEMU<=
br>
&gt;&gt; supports so many guest architectures. I wasn&#39;t keen on slappin=
g in a<br>
&gt;&gt; functional but ugly API that hard-coded values like gdb register i=
ds so<br>
&gt;&gt; I left it out for the time being. I&#39;d happily accept patches t=
o add that<br>
&gt;&gt; functionality assuming it meets the projects quality and taste<br>
&gt;&gt; guidelines.<br>
&gt;&gt;<br>
&gt;&gt; Some approaches we could take include:<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0- hook into tcg_global_*_new and allow plugin to intro=
spect registers<br>
&gt;&gt;=C2=A0 =C2=A0- hook into gdbstub in some way<br>
&gt;&gt;<br>
&gt;&gt; The first approach elides over the fact that a lot of registers ar=
en&#39;t<br>
&gt;&gt; actually known to the TCG - pretty much all vector registers tend =
to be<br>
&gt;&gt; loaded into anonymous TCG temps as we go. Maybe this could just be=
 fixed<br>
&gt;&gt; by just providing a few more registrations functions at the start =
even<br>
&gt;&gt; if the TCG itself wouldn&#39;t use that knowledge.<br>
&gt;&gt;<br>
&gt;&gt; The gdbstub provides a lot more visibility of register state and f=
or<br>
&gt;&gt; some architectures this can be quite comprehensive - for example i=
n<br>
&gt;&gt; system mode you can access pretty much every ARM co-processor regi=
ster.<br>
&gt;&gt; However the gdb interface is a little clunky as there are a lot of=
 magic<br>
&gt;&gt; register id numbers and the canonical way to enumerate this is to =
chew<br>
&gt;&gt; through a bunch of XML that each target generates (see<br>
&gt;&gt; gdb_register_coprocessor). I&#39;m not keen on exposing that pile =
of XML via<br>
&gt;&gt; the register interface. Maybe there is scope to improve our intern=
al<br>
&gt;&gt; APIs so the enumeration of registers can be handled by helpers tha=
t<br>
&gt;&gt; record mappings and ids and generate the XML for the gdbstub centr=
ally?<br>
&gt;&gt;<br>
&gt;&gt; There may be other approaches we could take and I&#39;m open to su=
ggestions.<br>
&gt;&gt;<br>
&gt;<br>
&gt; I&#39;d be happy to look into ways to implement this functionality.=C2=
=A0 However, I<br>
&gt; just started using Qemu this year, so these things sound like they wou=
ld<br>
&gt; have a steep learning curve for me.<br>
&gt; The gdbstub approach seems like it would provide the most introspectio=
n<br>
&gt; ability.=C2=A0 What would you suggest as a starting point for looking =
into this?<br>
&gt; All of this being said, if you think my project is too complicated, to=
<br>
&gt; implement a cache emulator with TCG plugins, then I could always try j=
ust<br>
&gt; hacking together some custom helper functions.<br>
<br>
As I said above I don&#39;t think you need register values to do cache<br>
emulation as you have the addresses. You will need to decode some of the<br=
>
cache management instructions though. Fortunately you can do that at<br>
translation time and only instrument the ones you need. See howvec for<br>
examples.<br></blockquote><div><br></div><div>I&#39;m not familiar with cac=
he management instructions.=C2=A0 What exactly do you mean by that?=C2=A0 I=
t sounds like something that would be dependent on the guest architecture.=
=C2=A0</div><div>Or maybe it&#39;s things like pre-fetching hints?=C2=A0 Th=
en the plugin would need to take into account cache latencies, something my=
 code doesn&#39;t deal with right now.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
-- <br>
Alex Benn=C3=A9e<br></blockquote><div><br></div><div>I would be glad to sha=
re my implementation once it&#39;s in a better working state.</div><div>Whe=
re can I find guidelines on the coding standard expected of QEMU software?<=
/div><div>Thanks=C2=A0</div><div><br></div></div></div>

--0000000000001013c805a21b9cdc--

