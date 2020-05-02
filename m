Return-Path: <SRS0=t3yw=6Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FFEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:25:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E44B2137B
	for <qemu-devel@archiver.kernel.org>; Sat,  2 May 2020 23:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTrMk/B6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E44B2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV1W6-0006Kn-SA
	for qemu-devel@archiver.kernel.org; Sat, 02 May 2020 19:25:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jV1VO-0005is-Bn
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:25:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jV1VN-0001Hb-Gx
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:25:10 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:43860)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jV1VN-0001Cj-12
 for qemu-devel@nongnu.org; Sat, 02 May 2020 19:25:09 -0400
Received: by mail-wr1-x432.google.com with SMTP id i10so16415438wrv.10
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 16:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=hnngqx/64GdCM0MTisKc2/pYLh04+dj4UjD2b/V1u8c=;
 b=aTrMk/B6euW28Hgrw/4sRBT4MvTVRDgrMCS2pDX7S5v4UoJ4iOX2EwONimPhGBN8q0
 1YXqOy1jp4IJjZV0qFU/GVrmBvow1fR74DHb+HZxDcD0X5a6g5WI9/6M7VXawFqzkKZG
 g7828tx7lVEk6HO/kSZiZe/ggEB8VF56a1j5QK0VR6HHNMaEQnVnJfbEH9NUfgmq4d+j
 EH5XaIFd53BUvd+zwtbJnIG64pJdzPwcKN6nIUuoapkt+XCs8gyIP4X4BtslvGE0ng8N
 hdlDh1ek6fe79CBMfrI6v6ihHb+x6e/zTPrCLMcCbOh6Zc6IMAU7cXnNe8AR5TD38mo2
 DPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hnngqx/64GdCM0MTisKc2/pYLh04+dj4UjD2b/V1u8c=;
 b=QLDZWH2uMQlSUQXYdH85VqNg/sdQ+9tHNCJOsqaj65XRtjzQF8Cr1fPD4dRTOq7qwy
 08ojHReUS7ZvCt3hMDPAXrZdCmqd/QQCVd1YUOMxKlIDzY+VFf7zzMiNSjUWKoNKRe4K
 FphQb2UDaTViSCAFpWqiwF0LlWiBxwQns6sn6ylicnSQK7IR4pTBGhAcKc0RbgD1Np1M
 /TmLg6QoaWgGIr1NKQnp5SOzJHw6mAkcJuqUjiaWSuOJ+cJdVwPXzpB1BXCd8bPyGIqL
 czDmMzbwLxq17cxmen14eKv4iRwGll6cXVBp2VmecuDpRDkZ6BLzMGtTPg+KNnQ1dWpL
 2lDw==
X-Gm-Message-State: AGi0PubHCC4ybsjyYij3gt3pOuZ8FXwVp07d/RZKvsiZtJ3R2Lwk2fEU
 VuiM7yxX+m7ls7v2XrvBOJmdrY0Jbm3Cv8+c8VXRjhlw
X-Google-Smtp-Source: APiQypIV+X8/VYdKI/rn80UDH4j84yNTspnXbGtp8WYDJwW4ri6xGYmuvYFvITn0BK0tJxeItmt4yjjIaSRPiz9rj6s=
X-Received: by 2002:adf:9793:: with SMTP id s19mr10493856wrb.147.1588461907370; 
 Sat, 02 May 2020 16:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
In-Reply-To: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 01:24:55 +0200
Message-ID: <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
Subject: Re: [INFO] Some preliminary performance data
To: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, kraxel@redhat.com, 
 ahmedkhaledkaraman@gmail.com
Content-Type: multipart/alternative; boundary="000000000000ba66e205a4b29b56"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x432.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::432
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

--000000000000ba66e205a4b29b56
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[correcting some email addresses]

=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 01:20 Aleksandar Mar=
kovic <
aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi, all.
>
> I just want to share with you some bits and pieces of data that I got
> while doing some preliminary experimentation for the GSoC project "TCG
> Continuous Benchmarking", that Ahmed Karaman, a student of the fourth fin=
al
> year of Electical Engineering Faculty in Cairo, will execute.
>
> *User Mode*
>
>    * As expected, for any program dealing with any substantional
> floating-point calculation, softfloat library will be the the heaviest CP=
U
> cycles consumer.
>    * We plan to examine the performance behaviour of non-FP programs
> (integer arithmetic), or even non-numeric programs (sorting strings, for
> example).
>
> *System Mode*
>
>    * I did profiling of booting several machines using a tool called
> callgrind (a part of valgrind). The tool offers pletora of information,
> however it looks it is little confused by usage of coroutines, and that
> makes some of its reports look very illogical, or plain ugly. Still, it
> seems valid data can be extracted from it. Without going into details, he=
re
> is what it says for one machine (bear in mind that results may vary to a
> great extent between machines):
>      ** The booting involved six threads, one for display handling, one
> for emulations, and four more. The last four did almost nothing during
> boot, just almost entire time siting idle, waiting for something. As far =
as
> "Total Instruction Fetch Count" (this is the main measure used in
> callgrind), they were distributed in proportion 1:3 between display threa=
d
> and emulation thread (the rest of threads were negligible) (but,
> interestingly enough, for another machine that proportion was 1:20).
>      ** The display thread is dominated by vga_update_display() function
> (21.5% "self" time, and 51.6% "self + callees" time, called almost 40000
> times). Other functions worth mentioning are
> cpu_physical_memory_snapshot_get_dirty() and
> memory_region_snapshot_get_dirty(), which are very small functions, but a=
re
> both invoked over 26 000 000 times, and contribute with over 20% of displ=
ay
> thread instruction fetch count together.
>      ** Focusing now on emulation thread, "Total Instruction Fetch Counts=
"
> were roughly distributed this way:
>            - 15.7% is execution of GIT-ed code from translation block
> buffer
>            - 39.9% is execution of helpers
>            - 44.4% is code translation stage, including some coroutine
> activities
>         Top two among helpers:
>           - helper_le_stl_memory()
>           - helper_lookup_tb_ptr() (this one is invoked whopping 36 000
> 000 times)
>         Single largest instruction consumer of code translation:
>           - liveness_pass_1(), that constitutes 21.5% of the entire
> "emulation thread" consumption, or, in other way, almost half of code
> translation stage (that sits at 44.4%)
>
> Please take all this with a little grain of salt, since these results are
> just of preliminary nature.
>
> I would like to use this opportunity to welcome Ahmed Karaman, a talented
> young man from Egypt, into QEMU development community, that'll work on "T=
CG
> Continuous Benchmarking" project this summer. Please do help them in his
> first steps as our colleague. Best luck to Ahmed!
>
> Thanks,
> Aleksandar
>
>

--000000000000ba66e205a4b29b56
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[correcting some email addresses]<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BD=D0=B5=D0=B4, =
3. =D0=BC=D0=B0=D1=98 2020. =D1=83 01:20 Aleksandar Markovic &lt;<a href=3D=
"mailto:aleksandar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a=
>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr=
">Hi, all.<br><br><div>I just want to share with you some bits and pieces o=
f data that I got while doing some preliminary experimentation for the GSoC=
 project &quot;TCG Continuous Benchmarking&quot;, that Ahmed Karaman, a stu=
dent of the fourth final year of Electical Engineering Faculty in Cairo, wi=
ll execute.</div><div><br></div><div><u>User Mode</u></div><div><br></div><=
div>=C2=A0=C2=A0 * As expected, for any program dealing with any substantio=
nal floating-point calculation, softfloat library will be the the heaviest =
CPU cycles consumer.</div><div>=C2=A0=C2=A0 * We plan to examine the perfor=
mance behaviour of non-FP programs (integer arithmetic), or even non-numeri=
c programs (sorting strings, for example).</div><div><br></div><div><div><u=
>System Mode</u></div></div><div><br></div><div>=C2=A0=C2=A0 * I did profil=
ing of booting several machines using a tool called callgrind (a part of va=
lgrind). The tool offers pletora of information, however it looks it is lit=
tle confused by usage of coroutines, and that makes some of its reports loo=
k very illogical, or plain ugly. Still, it seems valid data can be extracte=
d from it. Without going into details, here is what it says for one machine=
 (bear in mind that results may vary to a great extent between machines):</=
div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The booting involved six threads, one =
for display handling, one for emulations, and four more. The last four did =
almost nothing during boot, just almost entire time siting idle, waiting fo=
r something. As far as &quot;Total Instruction Fetch Count&quot; (this is t=
he main measure used in callgrind), they were distributed in proportion 1:3=
 between display thread and emulation thread (the rest of threads were negl=
igible) (but, interestingly enough, for another machine that proportion was=
 1:20).</div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The display thread is dominat=
ed by vga_update_display() function (21.5% &quot;self&quot; time, and 51.6%=
 &quot;self + callees&quot; time, called almost 40000 times). Other functio=
ns worth mentioning are cpu_physical_memory_snapshot_get_dirty() and memory=
_region_snapshot_get_dirty(), which are very small functions, but are both =
invoked over 26 000 000 times, and contribute with over 20% of display thre=
ad instruction fetch count together.<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
 ** Focusing now on emulation thread, &quot;Total Instruction Fetch Counts&=
quot; were roughly distributed this way:</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 15.7% is execution of GIT-ed code fr=
om translation block buffer</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 - 39.9% is execution of helpers</div><div>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - 44.4% is code tran=
slation stage, including some coroutine activities</div><div>=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Top two among helpers:</div><div>=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - helper_le_stl_memory()</div=
><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - helper_looku=
p_tb_ptr() (this one is invoked whopping 36 000 000 times)</div><div>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Single largest instruction consumer of=
 code translation:</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - liveness_pass_1(), that constitutes 21.5% of the entire &quot;e=
mulation thread&quot; consumption, or, in other way, almost half of code tr=
anslation stage (that sits at 44.4%)</div><div><br></div><div>Please take a=
ll this with a little grain of salt, since these results are just of prelim=
inary nature.</div><div><br></div><div>I would like to use this opportunity=
 to welcome Ahmed Karaman, a talented young man from Egypt, into QEMU devel=
opment community, that&#39;ll work on &quot;TCG Continuous Benchmarking&quo=
t; project this summer. Please do help them in his first steps as our colle=
ague. Best luck to Ahmed!<br></div><div><br></div><div>Thanks,</div><div>Al=
eksandar<br></div><div><br></div></div>
</blockquote></div>

--000000000000ba66e205a4b29b56--

