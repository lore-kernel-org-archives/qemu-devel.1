Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0EAC28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 10:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8791821473
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 10:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh4N5vVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8791821473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXMhi-0007wo-LR
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 06:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jXMgx-0007W2-N9
 for qemu-devel@nongnu.org; Sat, 09 May 2020 06:26:47 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:33532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jXMgw-0008LX-2X
 for qemu-devel@nongnu.org; Sat, 09 May 2020 06:26:47 -0400
Received: by mail-wm1-x344.google.com with SMTP id v8so11717955wma.0
 for <qemu-devel@nongnu.org>; Sat, 09 May 2020 03:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jwjgjQt5AJZkHuXbx6xFQRDwpns2JZ7m5+qWRXboZNY=;
 b=jh4N5vVhAdrYgnpQ4zjTDS5awwzjs2NQusOLHbT9xnqW5TmGpaM+fN2qBbB+i2/JBo
 qFMKCVVgA47s/By3XLDJSwMjlZcw5YqbWWG4TSsTV/+tzI64YiP+YaA54hruYmO/dYqQ
 dISAPif7WKSqinaHdX1zZ+/H8KJKp7tNaRq7FUpC8C5zTPSvwrBhX1Xf/ShAyh2Zd1Kq
 F3QvEFlSvcx3FU7oVbALnIq7OCaMv9vjgEPhK7e7WkiXdX22Y24QVF9u1qmGMF9oMKHh
 gnXlJbzOmAMdpG8wMD2HydAhIc+UzfeV48RVraCrUPovyRBwsySiipXhPaPrHml1Y2Xj
 txAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jwjgjQt5AJZkHuXbx6xFQRDwpns2JZ7m5+qWRXboZNY=;
 b=ZwmZIc2CboSRTXPdCMkb788skXu1JCaU7++IgvWvrS/3Uj2isp6MJxpR10hSPc+d5/
 L1vyrEs2oyIJ8Jq52raQfsWpMTiElaM5BZvJAKK/chvZKSQkHhuThEzN9SpQBrTFhw0O
 /Wu2+AiskXRf7+L86TWh3n2+8Z9YfgO5PwcQ6AUHd5EXqaKnGbSQ8X0XRKCdxXXKkzrS
 wNNXd4UQEWMQyXwKB4PyAkEesd038Nye5efsnWyg+s6VmZ0+qd0jPPXcLMk0LBDnW9Lf
 ZqC6mUpqGH9p72FmkNf0Qotq+sI5HY5M8QdJnn2x0VsU6/wOc6Cr04CiMUKLTlVAp2jV
 cBVg==
X-Gm-Message-State: AGi0PubNKBRJ7NxS6xQV8KOXZj1YsFkyTRNARCOcQG5q6d46My+jCRD8
 9F0YaqeJHZexF694039jI57bxTr7gLWWMs/9J7Y=
X-Google-Smtp-Source: APiQypKWD1EjxKi9krb7MlGtr63NPxI9A8Ny792v29ZWGLhsRtjo8S62NFux6JFMuYHzg1fXEPYpOWtlEn6Z7nXb/PQ=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr22131411wmi.50.1589020004475; 
 Sat, 09 May 2020 03:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
 <87imh95mof.fsf@linaro.org>
 <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
In-Reply-To: <CAHiYmc4otn_oGqQoVThEs6pmBqWG8u3KjQ+aAvgnZ2jso0-2NQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sat, 9 May 2020 12:26:27 +0200
Message-ID: <CAHiYmc5YqspdLz4=40___6u9uzz5arxPY8g_sh01FTTK8c+1-Q@mail.gmail.com>
Subject: Re: [INFO] Some preliminary performance data
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e8687d05a5348cd9"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, ahmedkhaledkaraman@gmail.com,
 "Emilio G . Cota" <cota@braap.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e8687d05a5348cd9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=83=D0=B1, 9. =D0=BC=D0=B0=D1=98 2020. =D1=83 12:16 Aleksandar Mar=
kovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>
>
> =D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:26 Alex Benn=C3=
=A9e <alex.bennee@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >
> > Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> writes:
> >
> > Some preliminary thoughts....
> >
>
> Alex, many thanks for all your thoughts and hints that are truly helpful!
>
> I will most likely respond to all of them in some future mail, but for no=
w
> I will comment just one.
>

It looks right-click and "View Image" works for html mails with
embedded images - it displays the image in its original resolution.
So, no need for attachments. Good to know for potential Ahmed's
reports with images.

Aleksandar

> > >> Hi, all.
> > >>
> > >> I just want to share with you some bits and pieces of data that I go=
t
> > >> while doing some preliminary experimentation for the GSoC project
"TCG
> > >> Continuous Benchmarking", that Ahmed Karaman, a student of the
fourth final
> > >> year of Electical Engineering Faculty in Cairo, will execute.
> > >>
> > >> *User Mode*
> > >>
> > >>    * As expected, for any program dealing with any substantional
> > >> floating-point calculation, softfloat library will be the the
heaviest CPU
> > >> cycles consumer.
> > >>    * We plan to examine the performance behaviour of non-FP programs
> > >> (integer arithmetic), or even non-numeric programs (sorting strings,
for
> > >> example).
> >
> > Emilio was the last person to do extensive bench-marking on TCG and he
> > used a mild fork of the venerable nbench:
> >
> >   https://github.com/cota/dbt-bench
> >
> > as the hot code is fairly small it offers a good way of testing quality
> > of the output. Larger programs will differ as they can involve more cod=
e
> > generation.
> >
> > >>
> > >> *System Mode*
> > >>
> > >>    * I did profiling of booting several machines using a tool called
> > >> callgrind (a part of valgrind). The tool offers pletora of
information,
> > >> however it looks it is little confused by usage of coroutines, and
that
> > >> makes some of its reports look very illogical, or plain ugly.
> >
> > Doesn't running through valgrind inherently serialise execution anyway?
> > If you are looking for latency caused by locks we have support for the
> > QEMU sync profiler built into the code. See "help sync-profile" on the
HMP.
> >
> > >> Still, it
> > >> seems valid data can be extracted from it. Without going into
details, here
> > >> is what it says for one machine (bear in mind that results may vary
to a
> > >> great extent between machines):
> >
> > You can also use perf to use sampling to find hot points in the code.
> > One of last years GSoC student wrote some patches that included the
> > ability to dump a jit info file for perf to consume. We never got it
> > merged in the end but it might be worth having a go at pulling the
> > relevant bits out from:
> >
> >   Subject: [PATCH  v9 00/13] TCG code quality tracking and perf
integration
> >   Date: Mon,  7 Oct 2019 16:28:26 +0100
> >   Message-Id: <20191007152839.30804-1-alex.bennee@linaro.org>
> >
> > >>      ** The booting involved six threads, one for display handling,
one
> > >> for emulations, and four more. The last four did almost nothing
during
> > >> boot, just almost entire time siting idle, waiting for something. As
far as
> > >> "Total Instruction Fetch Count" (this is the main measure used in
> > >> callgrind), they were distributed in proportion 1:3 between display
thread
> > >> and emulation thread (the rest of threads were negligible) (but,
> > >> interestingly enough, for another machine that proportion was 1:20).
> > >>      ** The display thread is dominated by vga_update_display()
function
> > >> (21.5% "self" time, and 51.6% "self + callees" time, called almost
40000
> > >> times). Other functions worth mentioning are
> > >> cpu_physical_memory_snapshot_get_dirty() and
> > >> memory_region_snapshot_get_dirty(), which are very small functions,
but are
> > >> both invoked over 26 000 000 times, and contribute with over 20% of
display
> > >> thread instruction fetch count together.
> >
> > The memory region tracking code will end up forcing the slow path for a
> > lot of memory accesses to video memory via softmmu. You may want to
> > measure if there is a difference using one of the virtio based graphics
> > displays.
> >
> > >>      ** Focusing now on emulation thread, "Total Instruction Fetch
Counts"
> > >> were roughly distributed this way:
> > >>            - 15.7% is execution of GIT-ed code from translation bloc=
k
> > >> buffer
> > >>            - 39.9% is execution of helpers
> > >>            - 44.4% is code translation stage, including some
coroutine
> > >> activities
> > >>         Top two among helpers:
> > >>           - helper_le_stl_memory()
> >
> > I assume that is the MMU slow-path being called from the generated code=
.
> >
> > >>           - helper_lookup_tb_ptr() (this one is invoked whopping 36
000
> > >> 000 times)
> >
> > This is an optimisation to avoid exiting the run-loop to find the next
> > block. From memory I think the two main cases you'll see are:
> >
> >  - computed jumps (i.e. target not known at JIT time)
> >  - jumps outside of the current page
> >
> > >>         Single largest instruction consumer of code translation:
> > >>           - liveness_pass_1(), that constitutes 21.5% of the entire
> > >> "emulation thread" consumption, or, in other way, almost half of cod=
e
> > >> translation stage (that sits at 44.4%)
> >
> > This is very much driven by how much code generation vs running you see=
.
> > In most of my personal benchmarks I never really notice code generation
> > because I give my machines large amounts of RAM so code tends to stay
> > resident so not need to be re-translated. When the optimiser shows up
> > it's usually accompanied by high TB flush and invalidate counts in "inf=
o
> > jit" because we are doing more translation that we usually do.
> >
>
> Yes, I think the machine was setup with only 128MB RAM.
>
> That would be an interesting experiment for Ahmed actually - to
> measure impact of given RAM memory to performance.
>
> But it looks that at least for machines with small RAM, translation
> phase will take significant percentage.
>
> I am attaching call graph for translation phase for "Hello World" built
> for mips, and emulated by QEMU: *tb_gen_code() and its calees)
>
> (I am also attaching the pic in case it is not visible well inline)
>
>
>
>
> > I'll also mention my foray into tracking down the performance regressio=
n
> > of DOSBox Doom:
> >
> >   https://diasp.eu/posts/8659062
> >
> > it presented a very nice demonstration of the increasing complexity (an=
d
> > run time) of the optimiser which was completely wasted due to
> > self-modifying code causing us to regenerate code all the time.
> >
> > >>
> > >> Please take all this with a little grain of salt, since these
results are
> > >> just of preliminary nature.
> > >>
> > >> I would like to use this opportunity to welcome Ahmed Karaman, a
talented
> > >> young man from Egypt, into QEMU development community, that'll work
on "TCG
> > >> Continuous Benchmarking" project this summer. Please do help them in
his
> > >> first steps as our colleague. Best luck to Ahmed!
> >
> > Welcome to the QEMU community Ahmed. Feel free to CC me on TCG
> > performance related patches. I like to see things go faster ;-)
> >
> > --
> > Alex Benn=C3=A9e

--000000000000e8687d05a5348cd9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br><br>=D1=81=D1=83=D0=B1, 9. =D0=BC=D0=B0=D1=98 2020=
. =D1=83 12:16 Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.de=
vel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=
=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>&gt;<br>&gt;<br>&gt;<=
br>&gt; =D1=81=D1=80=D0=B5, 6. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:26 Alex B=
enn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro=
.org</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt; Aleksandar Markovic &lt;<a h=
ref=3D"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.=
com</a>&gt; writes:<br>&gt; &gt;<br>&gt; &gt; Some preliminary thoughts....=
<br>&gt; &gt;<br>&gt;<br>&gt; Alex, many thanks for all your thoughts and h=
ints that are truly helpful!<br>&gt;<br>&gt; I will most likely respond to =
all of them in some future mail, but for now<br>&gt; I will comment just on=
e.<br><div>&gt;</div><div><br></div><div>It looks right-click and &quot;Vie=
w Image&quot; works for html mails with</div><div>embedded images - it disp=
lays the image in its original resolution.</div><div>So, no need for attach=
ments. Good to know for potential Ahmed&#39;s</div><div>reports with images=
.<br></div><div><br></div><div>Aleksandar<br></div><div><br></div>&gt; &gt;=
 &gt;&gt; Hi, all.<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; I just want =
to share with you some bits and pieces of data that I got<br>&gt; &gt; &gt;=
&gt; while doing some preliminary experimentation for the GSoC project &quo=
t;TCG<br>&gt; &gt; &gt;&gt; Continuous Benchmarking&quot;, that Ahmed Karam=
an, a student of the fourth final<br>&gt; &gt; &gt;&gt; year of Electical E=
ngineering Faculty in Cairo, will execute.<br>&gt; &gt; &gt;&gt;<br>&gt; &g=
t; &gt;&gt; *User Mode*<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; =C2=A0 =
=C2=A0* As expected, for any program dealing with any substantional<br>&gt;=
 &gt; &gt;&gt; floating-point calculation, softfloat library will be the th=
e heaviest CPU<br>&gt; &gt; &gt;&gt; cycles consumer.<br>&gt; &gt; &gt;&gt;=
 =C2=A0 =C2=A0* We plan to examine the performance behaviour of non-FP prog=
rams<br>&gt; &gt; &gt;&gt; (integer arithmetic), or even non-numeric progra=
ms (sorting strings, for<br>&gt; &gt; &gt;&gt; example).<br>&gt; &gt;<br>&g=
t; &gt; Emilio was the last person to do extensive bench-marking on TCG and=
 he<br>&gt; &gt; used a mild fork of the venerable nbench:<br>&gt; &gt;<br>=
&gt; &gt; =C2=A0 <a href=3D"https://github.com/cota/dbt-bench">https://gith=
ub.com/cota/dbt-bench</a><br>&gt; &gt;<br>&gt; &gt; as the hot code is fair=
ly small it offers a good way of testing quality<br>&gt; &gt; of the output=
. Larger programs will differ as they can involve more code<br>&gt; &gt; ge=
neration.<br>&gt; &gt;<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; *System =
Mode*<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0* I did prof=
iling of booting several machines using a tool called<br>&gt; &gt; &gt;&gt;=
 callgrind (a part of valgrind). The tool offers pletora of information,<br=
>&gt; &gt; &gt;&gt; however it looks it is little confused by usage of coro=
utines, and that<br>&gt; &gt; &gt;&gt; makes some of its reports look very =
illogical, or plain ugly.<br>&gt; &gt;<br>&gt; &gt; Doesn&#39;t running thr=
ough valgrind inherently serialise execution anyway?<br>&gt; &gt; If you ar=
e looking for latency caused by locks we have support for the<br>&gt; &gt; =
QEMU sync profiler built into the code. See &quot;help sync-profile&quot; o=
n the HMP.<br>&gt; &gt;<br>&gt; &gt; &gt;&gt; Still, it<br>&gt; &gt; &gt;&g=
t; seems valid data can be extracted from it. Without going into details, h=
ere<br>&gt; &gt; &gt;&gt; is what it says for one machine (bear in mind tha=
t results may vary to a<br>&gt; &gt; &gt;&gt; great extent between machines=
):<br>&gt; &gt;<br>&gt; &gt; You can also use perf to use sampling to find =
hot points in the code.<br>&gt; &gt; One of last years GSoC student wrote s=
ome patches that included the<br>&gt; &gt; ability to dump a jit info file =
for perf to consume. We never got it<br>&gt; &gt; merged in the end but it =
might be worth having a go at pulling the<br>&gt; &gt; relevant bits out fr=
om:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 Subject: [PATCH =C2=A0v9 00/13] TCG co=
de quality tracking and perf integration<br>&gt; &gt; =C2=A0 Date: Mon, =C2=
=A07 Oct 2019 16:28:26 +0100<br>&gt; &gt; =C2=A0 Message-Id: &lt;<a href=3D=
"mailto:20191007152839.30804-1-alex.bennee@linaro.org">20191007152839.30804=
-1-alex.bennee@linaro.org</a>&gt;<br>&gt; &gt;<br>&gt; &gt; &gt;&gt; =C2=A0=
 =C2=A0 =C2=A0** The booting involved six threads, one for display handling=
, one<br>&gt; &gt; &gt;&gt; for emulations, and four more. The last four di=
d almost nothing during<br>&gt; &gt; &gt;&gt; boot, just almost entire time=
 siting idle, waiting for something. As far as<br>&gt; &gt; &gt;&gt; &quot;=
Total Instruction Fetch Count&quot; (this is the main measure used in<br>&g=
t; &gt; &gt;&gt; callgrind), they were distributed in proportion 1:3 betwee=
n display thread<br>&gt; &gt; &gt;&gt; and emulation thread (the rest of th=
reads were negligible) (but,<br>&gt; &gt; &gt;&gt; interestingly enough, fo=
r another machine that proportion was 1:20).<br>&gt; &gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0** The display thread is dominated by vga_update_display() fun=
ction<br>&gt; &gt; &gt;&gt; (21.5% &quot;self&quot; time, and 51.6% &quot;s=
elf + callees&quot; time, called almost 40000<br>&gt; &gt; &gt;&gt; times).=
 Other functions worth mentioning are<br>&gt; &gt; &gt;&gt; cpu_physical_me=
mory_snapshot_get_dirty() and<br>&gt; &gt; &gt;&gt; memory_region_snapshot_=
get_dirty(), which are very small functions, but are<br>&gt; &gt; &gt;&gt; =
both invoked over 26 000 000 times, and contribute with over 20% of display=
<br>&gt; &gt; &gt;&gt; thread instruction fetch count together.<br>&gt; &gt=
;<br>&gt; &gt; The memory region tracking code will end up forcing the slow=
 path for a<br>&gt; &gt; lot of memory accesses to video memory via softmmu=
. You may want to<br>&gt; &gt; measure if there is a difference using one o=
f the virtio based graphics<br>&gt; &gt; displays.<br>&gt; &gt;<br>&gt; &gt=
; &gt;&gt; =C2=A0 =C2=A0 =C2=A0** Focusing now on emulation thread, &quot;T=
otal Instruction Fetch Counts&quot;<br>&gt; &gt; &gt;&gt; were roughly dist=
ributed this way:<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0- 15.7% is execution of GIT-ed code from translation block<br>&gt; &g=
t; &gt;&gt; buffer<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0- 39.9% is execution of helpers<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0- 44.4% is code translation stage, including som=
e coroutine<br>&gt; &gt; &gt;&gt; activities<br>&gt; &gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Top two among helpers:<br>&gt; &gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 - helper_le_stl_memory()<br>&gt; &gt;<br>&gt; &=
gt; I assume that is the MMU slow-path being called from the generated code=
.<br>&gt; &gt;<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - h=
elper_lookup_tb_ptr() (this one is invoked whopping 36 000<br>&gt; &gt; &gt=
;&gt; 000 times)<br>&gt; &gt;<br>&gt; &gt; This is an optimisation to avoid=
 exiting the run-loop to find the next<br>&gt; &gt; block. From memory I th=
ink the two main cases you&#39;ll see are:<br>&gt; &gt;<br>&gt; &gt; =C2=A0=
- computed jumps (i.e. target not known at JIT time)<br>&gt; &gt; =C2=A0- j=
umps outside of the current page<br>&gt; &gt;<br>&gt; &gt; &gt;&gt; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Single largest instruction consumer of code translatio=
n:<br>&gt; &gt; &gt;&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 - liveness_pass=
_1(), that constitutes 21.5% of the entire<br>&gt; &gt; &gt;&gt; &quot;emul=
ation thread&quot; consumption, or, in other way, almost half of code<br>&g=
t; &gt; &gt;&gt; translation stage (that sits at 44.4%)<br>&gt; &gt;<br>&gt=
; &gt; This is very much driven by how much code generation vs running you =
see.<br>&gt; &gt; In most of my personal benchmarks I never really notice c=
ode generation<br>&gt; &gt; because I give my machines large amounts of RAM=
 so code tends to stay<br>&gt; &gt; resident so not need to be re-translate=
d. When the optimiser shows up<br>&gt; &gt; it&#39;s usually accompanied by=
 high TB flush and invalidate counts in &quot;info<br>&gt; &gt; jit&quot; b=
ecause we are doing more translation that we usually do.<br>&gt; &gt;<br>&g=
t;<br>&gt; Yes, I think the machine was setup with only 128MB RAM.<br>&gt;<=
br>&gt; That would be an interesting experiment for Ahmed actually - to<br>=
&gt; measure impact of given RAM memory to performance.<br>&gt;<br>&gt; But=
 it looks that at least for machines with small RAM, translation<br>&gt; ph=
ase will take significant percentage.<br>&gt;<br>&gt; I am attaching call g=
raph for translation phase for &quot;Hello World&quot; built<br>&gt; for mi=
ps, and emulated by QEMU: *tb_gen_code() and its calees)<br>&gt;<br>&gt; (I=
 am also attaching the pic in case it is not visible well inline)<br>&gt;<b=
r>&gt;<br>&gt;<br>&gt;<br>&gt; &gt; I&#39;ll also mention my foray into tra=
cking down the performance regression<br>&gt; &gt; of DOSBox Doom:<br>&gt; =
&gt;<br>&gt; &gt; =C2=A0 <a href=3D"https://diasp.eu/posts/8659062">https:/=
/diasp.eu/posts/8659062</a><br>&gt; &gt;<br>&gt; &gt; it presented a very n=
ice demonstration of the increasing complexity (and<br>&gt; &gt; run time) =
of the optimiser which was completely wasted due to<br>&gt; &gt; self-modif=
ying code causing us to regenerate code all the time.<br>&gt; &gt;<br>&gt; =
&gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; Please take all this with a little grai=
n of salt, since these results are<br>&gt; &gt; &gt;&gt; just of preliminar=
y nature.<br>&gt; &gt; &gt;&gt;<br>&gt; &gt; &gt;&gt; I would like to use t=
his opportunity to welcome Ahmed Karaman, a talented<br>&gt; &gt; &gt;&gt; =
young man from Egypt, into QEMU development community, that&#39;ll work on =
&quot;TCG<br>&gt; &gt; &gt;&gt; Continuous Benchmarking&quot; project this =
summer. Please do help them in his<br>&gt; &gt; &gt;&gt; first steps as our=
 colleague. Best luck to Ahmed!<br>&gt; &gt;<br>&gt; &gt; Welcome to the QE=
MU community Ahmed. Feel free to CC me on TCG<br>&gt; &gt; performance rela=
ted patches. I like to see things go faster ;-)<br>&gt; &gt;<br>&gt; &gt; -=
-<br>&gt; &gt; Alex Benn=C3=A9e</div>

--000000000000e8687d05a5348cd9--

