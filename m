Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0F8C28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:41:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBA9206EB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 07:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxA4HXGq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBA9206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jV9FO-00014u-5t
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 03:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jV8Q7-0007z7-GG
 for qemu-devel@nongnu.org; Sun, 03 May 2020 02:48:11 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:47018)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jV8Q6-0000Vu-Bu
 for qemu-devel@nongnu.org; Sun, 03 May 2020 02:48:11 -0400
Received: by mail-lj1-x230.google.com with SMTP id f18so6445753lja.13
 for <qemu-devel@nongnu.org>; Sat, 02 May 2020 23:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dtmclcym2FkZzRv9WFrxSL6CIei3qm1CpKxIBh9TCZg=;
 b=lxA4HXGq+1IoPLNKTtBN7kXyENJs1LdwC4QnsKy93sKpt7FsO/l7zVOYc1GvgRE6EQ
 qCDab7JfVBdsjAyV79SFH7emu39MbjlTiIJrJQ4jV2dSvxSRFQdwdRg5ldCA8cHhT6Td
 wjc9FINqQMuLbNpk+lmHaQnLuHuMRabB8XggUOkXOblsslKo+JWlSDz/ckExWqdEMGv6
 5mwsDU/isphDza58Eu+UprGrNkQx9pS1ahiU7yuOeU+FQaxo3ZzrjEj/paI6MSqKP1xg
 Usiw65UJKv6U0J/pVCER5hhNVTosPA3Y+LGA+Q3RHV7R1iIJ1NA9AAj8hu4rG3D+vv3u
 KBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dtmclcym2FkZzRv9WFrxSL6CIei3qm1CpKxIBh9TCZg=;
 b=dj8QyC7cUpanot4RqXbJSq5CefLxXrtpu+WDNuAzAL6traCz2Aow094d5eNy8gMkE5
 BrKLZpijnmrAo7h+0aTZu6dicfkac2UnWRgohEKbw2m98zsFuxAx5BYh9sO9NEacllPe
 WAQIylvKeJxi1+PkPw4/5Hs+ysOUJQ+sU5gDjR1TlOXS1QTBjeTQXfrcVc6mzPCalns0
 xakuvnGqsUlCgGJUEq5zeix37lqwD+EGtEozRJySDug2ycVnOKyIN3mNYW3MrPc1aAyv
 NcaNM84GapPbk7HuDmnaE0IlteKy8dwHtoi3dQfdogNSyAMdQ77irbIhjqo8BivKEcj4
 Eopw==
X-Gm-Message-State: AGi0PubCKNUhJFBDuPV3M66c4HXB+DClJT1pefpaYLT5ojMGyRCWkswt
 sG8+O8Y7/TcWn5N1HyWe+JHpe+FxAw5V9MEmEp8=
X-Google-Smtp-Source: APiQypJm9VF0D1M6ET0r9V92Nu6Fai8fVzZcKeEODaWamgL2usmzhpKcQJS3qcIgMi9/jXvBTlDsw5+TQNMq2osU2DY=
X-Received: by 2002:a2e:700b:: with SMTP id l11mr7137048ljc.255.1588488487854; 
 Sat, 02 May 2020 23:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHiYmc67UNCKt0fqaGtj9d+w+qTHc3pYONqD_xLQsOXhMhKRDQ@mail.gmail.com>
 <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
In-Reply-To: <CAHiYmc4JuaPW7VsDiqK8ToZZzdBJhJjyKB-7614xts22p00RMQ@mail.gmail.com>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Sun, 3 May 2020 08:47:56 +0200
Message-ID: <CALTWKrUSC1CNzY4vQYCTvMPioFEeS23qtKKiq5z-gtpyaTm29g@mail.gmail.com>
Subject: Re: [INFO] Some preliminary performance data
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000000c698405a4b8cce3"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 May 2020 03:40:07 -0400
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
 QEMU Developers <qemu-devel@nongnu.org>, kraxel@redhat.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000c698405a4b8cce3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Mr. Aleksandar for the introduction.
I'm really looking forward to working with the QEMU developers community
this summer.
Wishing all of you health and safety.


On Sun, May 3, 2020, 1:25 AM Aleksandar Markovic <
aleksandar.qemu.devel@gmail.com> wrote:

> [correcting some email addresses]
>
> =D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 01:20 Aleksandar M=
arkovic <
> aleksandar.qemu.devel@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
>> Hi, all.
>>
>> I just want to share with you some bits and pieces of data that I got
>> while doing some preliminary experimentation for the GSoC project "TCG
>> Continuous Benchmarking", that Ahmed Karaman, a student of the fourth fi=
nal
>> year of Electical Engineering Faculty in Cairo, will execute.
>>
>> *User Mode*
>>
>>    * As expected, for any program dealing with any substantional
>> floating-point calculation, softfloat library will be the the heaviest C=
PU
>> cycles consumer.
>>    * We plan to examine the performance behaviour of non-FP programs
>> (integer arithmetic), or even non-numeric programs (sorting strings, for
>> example).
>>
>> *System Mode*
>>
>>    * I did profiling of booting several machines using a tool called
>> callgrind (a part of valgrind). The tool offers pletora of information,
>> however it looks it is little confused by usage of coroutines, and that
>> makes some of its reports look very illogical, or plain ugly. Still, it
>> seems valid data can be extracted from it. Without going into details, h=
ere
>> is what it says for one machine (bear in mind that results may vary to a
>> great extent between machines):
>>      ** The booting involved six threads, one for display handling, one
>> for emulations, and four more. The last four did almost nothing during
>> boot, just almost entire time siting idle, waiting for something. As far=
 as
>> "Total Instruction Fetch Count" (this is the main measure used in
>> callgrind), they were distributed in proportion 1:3 between display thre=
ad
>> and emulation thread (the rest of threads were negligible) (but,
>> interestingly enough, for another machine that proportion was 1:20).
>>      ** The display thread is dominated by vga_update_display() function
>> (21.5% "self" time, and 51.6% "self + callees" time, called almost 40000
>> times). Other functions worth mentioning are
>> cpu_physical_memory_snapshot_get_dirty() and
>> memory_region_snapshot_get_dirty(), which are very small functions, but =
are
>> both invoked over 26 000 000 times, and contribute with over 20% of disp=
lay
>> thread instruction fetch count together.
>>      ** Focusing now on emulation thread, "Total Instruction Fetch
>> Counts" were roughly distributed this way:
>>            - 15.7% is execution of GIT-ed code from translation block
>> buffer
>>            - 39.9% is execution of helpers
>>            - 44.4% is code translation stage, including some coroutine
>> activities
>>         Top two among helpers:
>>           - helper_le_stl_memory()
>>           - helper_lookup_tb_ptr() (this one is invoked whopping 36 000
>> 000 times)
>>         Single largest instruction consumer of code translation:
>>           - liveness_pass_1(), that constitutes 21.5% of the entire
>> "emulation thread" consumption, or, in other way, almost half of code
>> translation stage (that sits at 44.4%)
>>
>> Please take all this with a little grain of salt, since these results ar=
e
>> just of preliminary nature.
>>
>> I would like to use this opportunity to welcome Ahmed Karaman, a talente=
d
>> young man from Egypt, into QEMU development community, that'll work on "=
TCG
>> Continuous Benchmarking" project this summer. Please do help them in his
>> first steps as our colleague. Best luck to Ahmed!
>>
>> Thanks,
>> Aleksandar
>>
>>

--0000000000000c698405a4b8cce3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks Mr. Aleksandar for the introduction.<div dir=3D"au=
to">I&#39;m really looking forward to working with the QEMU developers comm=
unity this summer.</div><div dir=3D"auto">Wishing all of you health and saf=
ety.<div dir=3D"auto"><br style=3D"font-family:sans-serif"></div></div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On S=
un, May 3, 2020, 1:25 AM Aleksandar Markovic &lt;<a href=3D"mailto:aleksand=
ar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">[correcting some emai=
l addresses]<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">=D0=BD=D0=B5=D0=B4, 3. =D0=BC=D0=B0=D1=98 2020. =D1=83 01:2=
0 Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.com=
" target=3D"_blank" rel=3D"noreferrer">aleksandar.qemu.devel@gmail.com</a>&=
gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">=
Hi, all.<br><br><div>I just want to share with you some bits and pieces of =
data that I got while doing some preliminary experimentation for the GSoC p=
roject &quot;TCG Continuous Benchmarking&quot;, that Ahmed Karaman, a stude=
nt of the fourth final year of Electical Engineering Faculty in Cairo, will=
 execute.</div><div><br></div><div><u>User Mode</u></div><div><br></div><di=
v>=C2=A0=C2=A0 * As expected, for any program dealing with any substantiona=
l floating-point calculation, softfloat library will be the the heaviest CP=
U cycles consumer.</div><div>=C2=A0=C2=A0 * We plan to examine the performa=
nce behaviour of non-FP programs (integer arithmetic), or even non-numeric =
programs (sorting strings, for example).</div><div><br></div><div><div><u>S=
ystem Mode</u></div></div><div><br></div><div>=C2=A0=C2=A0 * I did profilin=
g of booting several machines using a tool called callgrind (a part of valg=
rind). The tool offers pletora of information, however it looks it is littl=
e confused by usage of coroutines, and that makes some of its reports look =
very illogical, or plain ugly. Still, it seems valid data can be extracted =
from it. Without going into details, here is what it says for one machine (=
bear in mind that results may vary to a great extent between machines):</di=
v><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The booting involved six threads, one fo=
r display handling, one for emulations, and four more. The last four did al=
most nothing during boot, just almost entire time siting idle, waiting for =
something. As far as &quot;Total Instruction Fetch Count&quot; (this is the=
 main measure used in callgrind), they were distributed in proportion 1:3 b=
etween display thread and emulation thread (the rest of threads were neglig=
ible) (but, interestingly enough, for another machine that proportion was 1=
:20).</div><div>=C2=A0=C2=A0=C2=A0=C2=A0 ** The display thread is dominated=
 by vga_update_display() function (21.5% &quot;self&quot; time, and 51.6% &=
quot;self + callees&quot; time, called almost 40000 times). Other functions=
 worth mentioning are cpu_physical_memory_snapshot_get_dirty() and memory_r=
egion_snapshot_get_dirty(), which are very small functions, but are both in=
voked over 26 000 000 times, and contribute with over 20% of display thread=
 instruction fetch count together.<br></div><div>=C2=A0=C2=A0=C2=A0=C2=A0 *=
* Focusing now on emulation thread, &quot;Total Instruction Fetch Counts&qu=
ot; were roughly distributed this way:</div><div>=C2=A0=C2=A0=C2=A0=C2=A0=
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
</blockquote></div>

--0000000000000c698405a4b8cce3--

