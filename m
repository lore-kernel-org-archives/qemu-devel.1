Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A0EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 23:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896B52065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 23:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGlgblh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896B52065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jswZD-0000c3-Ne
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 18:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jswYe-00009x-6Q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 18:59:24 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:36296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jswYc-00089S-2T
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 18:59:23 -0400
Received: by mail-wr1-x429.google.com with SMTP id k6so47014110wrn.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 15:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=sOI7D3PjzIkj1sgDkYV0v/4/Hd9jJ4SYUyIN/qavyec=;
 b=cGlgblh4jTz8WZsfa6JeRPsLFlCUj4TFc0fOIuQWghUSd0ZEoqYiRwlNrjnU6U9ySY
 KOe1+TEXVZzluVnGpx10Iu5HfksUkPm94xfiKmET4q9e9JMhKPkfgk6a366c5b/ZOiZs
 x0o9lm1xee55KVgyVU9gYe/AGzdhIdws+yF2opagjgk6S/AU0cTovI14vYHEPtbpu5Wt
 EQEPMezT5GcmpdDrOPMqXSfmATXpl9ci0NwiPvtw1MyO8gLlMWNN9cXk1EcACABj1626
 gieRJgPfgeS+VDDxjZYb+T9x6Db4GmQSU3SxCKYkDPg+b5Q/rWMx0nArHLAbvMwEFBe1
 fLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=sOI7D3PjzIkj1sgDkYV0v/4/Hd9jJ4SYUyIN/qavyec=;
 b=VULhF4VCaOYzPKPONW6pn7hnymwdHJcOgszKTWNwrEI8C5xrRbNhLE62T8NmiGOCMy
 wu6jDHXXvdLIaXh1T5xiN6R9Wirnte5vzeg5LsWwDSyU+Hk1cmEQaMVbTDPb4AwgZqIg
 5tgMvUUVJblcfsCGNAfuf2TTOvy5A+kjQcIcnLChRYY0l9PKRzQegsCkyporKi+kduo4
 +XYWCOjzR9BXqeWo3jYl4M/N9Nx+Sx5i1oCUdtnyIJdwzM9O8Sxx7kTmD0AyHhNVBaU+
 mM7za4l7BE6uLgvJfE26+iNFuGGIR7KWl5Z5POY9QfXcjpgDGsYMuaqH+OH0b7LirQH7
 igwA==
X-Gm-Message-State: AOAM533pYs5WIaa9sssbnevTu/9bFlIkEdDu2OU6jl8mFauIQvdeGmMb
 kuoF/VnmQZxy8OUFf3x5/s7OFjhCRl0rYVz2VmTCWw==
X-Google-Smtp-Source: ABdhPJyIxmzk5uAzqmIf8n9ACk9VL8JHFMrhwocg76AhWjLxTxSAe1pAtwXqiIfEa9iXb19jj219ajQ5U3kvSTQushk=
X-Received: by 2002:adf:8462:: with SMTP id 89mr54683437wrf.420.1594159128757; 
 Tue, 07 Jul 2020 14:58:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:b407:0:0:0:0:0 with HTTP;
 Tue, 7 Jul 2020 14:58:48 -0700 (PDT)
In-Reply-To: <CABgObfagZ+=+sv6j_3LyBd5Y7=+mzPdQHpS3JRPtin4Tvtgc2w@mail.gmail.com>
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <05a9301c-dbad-f11c-12a0-3c60fe0fcccb@redhat.com>
 <CABgObfagZ+=+sv6j_3LyBd5Y7=+mzPdQHpS3JRPtin4Tvtgc2w@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 7 Jul 2020 23:58:48 +0200
Message-ID: <CAHiYmc6Df1O=siF4L-MC2qg+W7XGoMyhZCm8p=Mo1-92w4o+jg@mail.gmail.com>
Subject: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th, 2020
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000095cb4405a9e118ce"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000095cb4405a9e118ce
Content-Type: text/plain; charset="UTF-8"

On Tuesday, July 7, 2020, Paolo Bonzini <pbonzini@redhat.com> wrote:

> I haven't looked at the disassembler code; assuming it comes from an
> upstream code base I don't think we should treat it differently from the
> ARM disassembler (or for that matter the binutils ones) and basically
> handle it as a black box for which we don't really care about the code
> quality or style. It's not security sensitive code, and forking the
> upstream is probably not justified. On the other hand the pull request
> should have explained the provenance of the code (even if only in the
> subject line of the relevant patch).
>
> Regarding the recommendation of a "vacation" after last week's facts,
> QEMU's enforcing of behavior standards so far has been informal, therefore
> my suggestion cannot be anything more than a suggestion, though a strongly
> recommended one. I can also understand the soft freeze pressure. I defer
> to Peter as to whether to merge this pull request or not due to Thomas's
> objections, but I do wish to reinforce that taking some time off to cool
> down can often times be a good idea.
>
>
Sure, I respect the opinion of both Paolo and Thomas. I already reflected
on everything, and will not be an obstacle in any way in qemu community.

There is truly no ulterior motive from my side regarding this pull request
- I was just trying to integrate some code before soft-freeze.

Peter, please discard this pull request, I will send a new one, as soon as
I can, most likely tomorrow, that will fully follow Paolo's and Thomas'
recommendations, no need to worry.

Thanks,
Aleksamdar



> Thanks,
>
> Paolo
>
> Il mar 7 lug 2020, 22:20 Thomas Huth <thuth@redhat.com> ha scritto:
>
>> On 07/07/2020 18.40, Aleksandar Markovic wrote:
>> > The following changes since commit 710fb08fd297d7a92163debce1959f
>> ae8f3b6ed7:
>> >
>> >   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-07-06'
>> into staging (2020-07-07 12:41:15 +0100)
>> >
>> > are available in the git repository at:
>> >
>> >   https://github.com/AMarkovic/qemu tags/mips-queue-jul-07-2020
>> >
>> > for you to fetch changes up to fa6e7da119b6da4067e757924e165b
>> c737bb1260:
>> >
>> >   scripts/performance: Add dissect.py script (2020-07-07 18:32:20 +0200)
>> >
>> > ----------------------------------------------------------------
>> >
>> > MIPS + TCG Continuous Benchmarking queue for July 7th, 2020
>> >
>> >   Highlights:
>> >
>> >      - Fix for a regression in FPU emulation add.s.
>> >      - Add Loongson 2F disassembler.
>> >      - Add a script for a GSoC project.
>> >
>> >   Note:
>> >
>> >      - A checkpatch error and a checkpatch warning are known and
>> >      should be ignored.
>> >
>> > ----------------------------------------------------------------
>> >
>> > Ahmed Karaman (1):
>> >   scripts/performance: Add dissect.py script
>> >
>> > Alex Richardson (1):
>> >   target/mips: fpu: Fix recent regression in add.s after 1ace099f2a
>> >
>> > Stefan Brankovic (1):
>> >   disas: mips: Add Loongson 2F disassembler
>> >
>> >  configure                      |    1 +
>> >  disas/loongson2f.h             | 2562 +++++++++++++
>> >  include/disas/dis-asm.h        |    1 +
>> >  include/exec/poison.h          |    1 +
>> >  target/mips/cpu.c              |    6 +
>> >  target/mips/fpu_helper.c       |    2 +-
>> >  MAINTAINERS                    |    1 +
>> >  disas/Makefile.objs            |    1 +
>> >  disas/loongson2f.cpp           | 8154 ++++++++++++++++++++++++++++++
>> ++++++++++
>>
>> Honestly, no. Peter, please don't merge this pull request.
>>
>> That disassembler source code is really huge, and I think someone should
>> give this a *proper* review first before we include this in our repo. I
>> just had a quick look at it, and I don't think that it is in the right
>> shape already. For example, there are hard-coded magic numbers there,
>> like:
>>
>> bool ADD::disas_output(disassemble_info *info)
>> +{
>> +    char alias1[5];
>> +    char alias2[5];
>> +    char alias3[5];
>> ...
>>
>> and in a completely different function, this hard-coded 5 is used again:
>>
>> +void Instruction32::getAlias(char *buffer, int regNo)
>> +{
>> +    switch (regNo) {
>> +    case 0:
>> +        strncpy(buffer, "zero", 5);
>> +        break;
>> +    case 1:
>> +        strncpy(buffer, "at", 5);
>> ...
>>
>> That definitely needs to be turned into a proper #define or the length
>> needs to be passed as parameter to the function.
>>
>> Also the coding style is weird in a couple of places, and there were
>> checkpatch warnings.
>>
>> Apart from that, Paolo asked you to take a break from MIPS
>> maintainership for a while, Aleksandar. I strongly support that
>> suggestion. Your derogatory behavior during the last weeks, especially
>> in the last one, looked completely unacceptable to me. In my opinion you
>> really need some time to reflect yourself. You, and we all as a
>> community, now cannot continue just like nothing happened.
>>
>>  Thanks,
>>   Thomas
>>
>>

--00000000000095cb4405a9e118ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, July 7, 2020, Paolo Bonzini &lt;<a href=3D"mailto:pbonz=
ini@redhat.com" target=3D"_blank">pbonzini@redhat.com</a>&gt; wrote:<br><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"auto"><div>I haven&#39;t looked at =
the disassembler code; assuming it comes from an upstream code base I don&#=
39;t think we should treat it differently from the ARM disassembler (or for=
 that matter the binutils ones) and basically handle it as a black box for =
which we don&#39;t really care about the code quality or style. It&#39;s no=
t security sensitive code, and forking the upstream is probably not justifi=
ed. On the other hand the pull request should have explained the provenance=
 of the code (even if only in the subject line of the relevant patch).</div=
><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=3D"font-family:s=
ans-serif">Regarding the recommendation of a &quot;vacation&quot; after las=
t week&#39;s facts, QEMU&#39;s enforcing of behavior standards so far has b=
een informal, therefore my suggestion cannot be anything more than a sugges=
tion, though a strongly recommended one. I can also understand the soft fre=
eze pressure. I=C2=A0</span>defer to Peter as to whether to merge this pull=
 request or not due to Thomas&#39;s objections, but I do wish to reinforce =
that taking some time off to cool down can often times be a good idea.</div=
><div dir=3D"auto"><br></div></div></blockquote><div><br></div><div>Sure, I=
 respect the opinion of both Paolo and Thomas. I already reflected on every=
thing, and will not be an obstacle in any way in qemu community.</div><div>=
<br></div><div>There is truly no ulterior motive from my side regarding thi=
s pull request - I was just trying to integrate some code before soft-freez=
e.</div><div><br></div><div>Peter, please discard this pull request, I will=
 send a new one, as soon as I can, most likely tomorrow, that will fully fo=
llow Paolo&#39;s and Thomas&#39; recommendations, no need to worry.</div><d=
iv><br></div><div>Thanks,</div><div>Aleksamdar</div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"=
>Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<br><br><d=
iv class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" class=3D"gmail_attr"=
>Il mar 7 lug 2020, 22:20 Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.co=
m" target=3D"_blank">thuth@redhat.com</a>&gt; ha scritto:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">On 07/07/2020 18.40, Aleksandar Markovic wrote:<br>
&gt; The following changes since commit 710fb08fd297d7a92163debce1959f<wbr>=
ae8f3b6ed7:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/huth-gitlab/tags=
/pull<wbr>-request-2020-07-06&#39; into staging (2020-07-07 12:41:15 +0100)=
<br>
&gt; <br>
&gt; are available in the git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/AMarkovic/qemu" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/AMarkovic/<wbr>qemu<=
/a> tags/mips-queue-jul-07-2020<br>
&gt; <br>
&gt; for you to fetch changes up to fa6e7da119b6da4067e757924e165b<wbr>c737=
bb1260:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0scripts/performance: Add dissect.py script (2020-07-07 18:=
32:20 +0200)<br>
&gt; <br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
----<br>
&gt; <br>
&gt; MIPS + TCG Continuous Benchmarking queue for July 7th, 2020<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Highlights:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Fix for a regression in FPU emulation add.s.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Add Loongson 2F disassembler.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - Add a script for a GSoC project.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Note:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 - A checkpatch error and a checkpatch warning are =
known and<br>
&gt;=C2=A0 =C2=A0 =C2=A0 should be ignored.<br>
&gt; <br>
&gt; ------------------------------<wbr>------------------------------<wbr>=
----<br>
&gt; <br>
&gt; Ahmed Karaman (1):<br>
&gt;=C2=A0 =C2=A0scripts/performance: Add dissect.py script<br>
&gt; <br>
&gt; Alex Richardson (1):<br>
&gt;=C2=A0 =C2=A0target/mips: fpu: Fix recent regression in add.s after 1ac=
e099f2a<br>
&gt; <br>
&gt; Stefan Brankovic (1):<br>
&gt;=C2=A0 =C2=A0disas: mips: Add Loongson 2F disassembler<br>
&gt; <br>
&gt;=C2=A0 configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 disas/loongson2f.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 2562 +++++++++++++<br>
&gt;=C2=A0 include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A0 1 +<br>
&gt;=C2=A0 include/exec/poison.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A0 1 +<br>
&gt;=C2=A0 target/mips/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 6 +<br>
&gt;=C2=A0 target/mips/fpu_helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 2 +-<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 disas/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 1 +<br>
&gt;=C2=A0 disas/loongson2f.cpp=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 8=
154 ++++++++++++++++++++++++++++++<wbr>++++++++++<br>
<br>
Honestly, no. Peter, please don&#39;t merge this pull request.<br>
<br>
That disassembler source code is really huge, and I think someone should<br=
>
give this a *proper* review first before we include this in our repo. I<br>
just had a quick look at it, and I don&#39;t think that it is in the right<=
br>
shape already. For example, there are hard-coded magic numbers there, like:=
<br>
<br>
bool ADD::disas_output(disassemble_<wbr>info *info)<br>
+{<br>
+=C2=A0 =C2=A0 char alias1[5];<br>
+=C2=A0 =C2=A0 char alias2[5];<br>
+=C2=A0 =C2=A0 char alias3[5];<br>
...<br>
<br>
and in a completely different function, this hard-coded 5 is used again:<br=
>
<br>
+void Instruction32::getAlias(char *buffer, int regNo)<br>
+{<br>
+=C2=A0 =C2=A0 switch (regNo) {<br>
+=C2=A0 =C2=A0 case 0:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;zero&quot;, 5);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 case 1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(buffer, &quot;at&quot;, 5);<br>
...<br>
<br>
That definitely needs to be turned into a proper #define or the length<br>
needs to be passed as parameter to the function.<br>
<br>
Also the coding style is weird in a couple of places, and there were<br>
checkpatch warnings.<br>
<br>
Apart from that, Paolo asked you to take a break from MIPS<br>
maintainership for a while, Aleksandar. I strongly support that<br>
suggestion. Your derogatory behavior during the last weeks, especially<br>
in the last one, looked completely unacceptable to me. In my opinion you<br=
>
really need some time to reflect yourself. You, and we all as a<br>
community, now cannot continue just like nothing happened.<br>
<br>
=C2=A0Thanks,<br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>
</blockquote>

--00000000000095cb4405a9e118ce--

