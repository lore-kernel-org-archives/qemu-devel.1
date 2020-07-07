Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD072C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731AF206F6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 20:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNVfCDC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731AF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsueA-0007Li-Nl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 16:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsudS-0006u4-PP
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:56:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsudP-0003R3-VW
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 16:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594155370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iWRJUZCTvH8UeqhFyht4StDC/6OAUOrKBtGLZL7MZTo=;
 b=SNVfCDC0Iw5AaaQv4ooSAlwuOVl5EMhYIVNQ85/cx04sieOf4TpWS59Gg6skpi5Uw0Ak8G
 EPvKDJVWTyxItFYvNtlrMtdQnoHpbmKyuqMwrhbxRwwI8vUOfhgXXuiuTgt3Wna/BWLGg8
 Ww489pE1jmrK3/keF0t05duG4TXZn9M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-i7qjLer5N4mMeqBnaamjvQ-1; Tue, 07 Jul 2020 16:56:06 -0400
X-MC-Unique: i7qjLer5N4mMeqBnaamjvQ-1
Received: by mail-ej1-f70.google.com with SMTP id a26so36779667ejr.7
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 13:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iWRJUZCTvH8UeqhFyht4StDC/6OAUOrKBtGLZL7MZTo=;
 b=ScgM/P/yQjIPUFvx/znRGv6rAEUF5Rmwsyfnlf4g3xaEEZF/8lIovmuObjU2sY/1YV
 1qDH08puLbyYP38uATG5q1gkEcunqS0zhc/BeHneTtuQ3qjqpe+KJV9w9UzxaC3l1cYU
 QjiM0QXh9eI2U8JrGKG8KBqde1WKl+zSb3wreBn8K+rtW3QPIc9Eca+JHuw/rYkeQAB4
 vg5oTQC55T12G/71JlHyLGZIGymCR/BN3zlNSu6Yt0N+LR1fzzrdhDtAdsvzQoZ5rxwY
 qbBi3ILY94GVg3zIYpxuTtWRrn7Fikgo8Ab0wt6hS9E0L6/wAy3waWhqDMby2x3Hm6As
 zgYQ==
X-Gm-Message-State: AOAM533tbejg7MLdJ9arjNHfdkuuzybMZlp3TTq0fZeXd63orpczbxQ2
 iM6heZeZfanBx/G1CFhogFV1tsia8m+5cZjm4lFVxTsXflXMrterDddQdn7gNxVXHjfDUVFRmA/
 NG/MX33Qp6Lo5ge4UgHR8IH30zmdv7Y4=
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr40063591edo.161.1594155365663; 
 Tue, 07 Jul 2020 13:56:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFP8q9VCMAhRd6YQxBdork+GBiw8eR5DMLPWE0uBgLIojRB69dMzafL6lCUg1nBvDb2ZlcJD7q4OH9S+pJkb4=
X-Received: by 2002:aa7:d04e:: with SMTP id n14mr40063575edo.161.1594155365430; 
 Tue, 07 Jul 2020 13:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <1594140062-23522-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <05a9301c-dbad-f11c-12a0-3c60fe0fcccb@redhat.com>
In-Reply-To: <05a9301c-dbad-f11c-12a0-3c60fe0fcccb@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jul 2020 22:55:53 +0200
Message-ID: <CABgObfagZ+=+sv6j_3LyBd5Y7=+mzPdQHpS3JRPtin4Tvtgc2w@mail.gmail.com>
Subject: Re: [PULL 0/3] MIPS + TCG Continuous Benchmarking queue for July 7th,
 2020
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000460c1205a9e038d4"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 00:46:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000460c1205a9e038d4
Content-Type: text/plain; charset="UTF-8"

I haven't looked at the disassembler code; assuming it comes from an
upstream code base I don't think we should treat it differently from the
ARM disassembler (or for that matter the binutils ones) and basically
handle it as a black box for which we don't really care about the code
quality or style. It's not security sensitive code, and forking the
upstream is probably not justified. On the other hand the pull request
should have explained the provenance of the code (even if only in the
subject line of the relevant patch).

Regarding the recommendation of a "vacation" after last week's facts,
QEMU's enforcing of behavior standards so far has been informal, therefore
my suggestion cannot be anything more than a suggestion, though a strongly
recommended one. I can also understand the soft freeze pressure. I defer to
Peter as to whether to merge this pull request or not due to Thomas's
objections, but I do wish to reinforce that taking some time off to cool
down can often times be a good idea.

Thanks,

Paolo

Il mar 7 lug 2020, 22:20 Thomas Huth <thuth@redhat.com> ha scritto:

> On 07/07/2020 18.40, Aleksandar Markovic wrote:
> > The following changes since commit
> 710fb08fd297d7a92163debce1959fae8f3b6ed7:
> >
> >   Merge remote-tracking branch
> 'remotes/huth-gitlab/tags/pull-request-2020-07-06' into staging (2020-07-07
> 12:41:15 +0100)
> >
> > are available in the git repository at:
> >
> >   https://github.com/AMarkovic/qemu tags/mips-queue-jul-07-2020
> >
> > for you to fetch changes up to fa6e7da119b6da4067e757924e165bc737bb1260:
> >
> >   scripts/performance: Add dissect.py script (2020-07-07 18:32:20 +0200)
> >
> > ----------------------------------------------------------------
> >
> > MIPS + TCG Continuous Benchmarking queue for July 7th, 2020
> >
> >   Highlights:
> >
> >      - Fix for a regression in FPU emulation add.s.
> >      - Add Loongson 2F disassembler.
> >      - Add a script for a GSoC project.
> >
> >   Note:
> >
> >      - A checkpatch error and a checkpatch warning are known and
> >      should be ignored.
> >
> > ----------------------------------------------------------------
> >
> > Ahmed Karaman (1):
> >   scripts/performance: Add dissect.py script
> >
> > Alex Richardson (1):
> >   target/mips: fpu: Fix recent regression in add.s after 1ace099f2a
> >
> > Stefan Brankovic (1):
> >   disas: mips: Add Loongson 2F disassembler
> >
> >  configure                      |    1 +
> >  disas/loongson2f.h             | 2562 +++++++++++++
> >  include/disas/dis-asm.h        |    1 +
> >  include/exec/poison.h          |    1 +
> >  target/mips/cpu.c              |    6 +
> >  target/mips/fpu_helper.c       |    2 +-
> >  MAINTAINERS                    |    1 +
> >  disas/Makefile.objs            |    1 +
> >  disas/loongson2f.cpp           | 8154
> ++++++++++++++++++++++++++++++++++++++++
>
> Honestly, no. Peter, please don't merge this pull request.
>
> That disassembler source code is really huge, and I think someone should
> give this a *proper* review first before we include this in our repo. I
> just had a quick look at it, and I don't think that it is in the right
> shape already. For example, there are hard-coded magic numbers there, like:
>
> bool ADD::disas_output(disassemble_info *info)
> +{
> +    char alias1[5];
> +    char alias2[5];
> +    char alias3[5];
> ...
>
> and in a completely different function, this hard-coded 5 is used again:
>
> +void Instruction32::getAlias(char *buffer, int regNo)
> +{
> +    switch (regNo) {
> +    case 0:
> +        strncpy(buffer, "zero", 5);
> +        break;
> +    case 1:
> +        strncpy(buffer, "at", 5);
> ...
>
> That definitely needs to be turned into a proper #define or the length
> needs to be passed as parameter to the function.
>
> Also the coding style is weird in a couple of places, and there were
> checkpatch warnings.
>
> Apart from that, Paolo asked you to take a break from MIPS
> maintainership for a while, Aleksandar. I strongly support that
> suggestion. Your derogatory behavior during the last weeks, especially
> in the last one, looked completely unacceptable to me. In my opinion you
> really need some time to reflect yourself. You, and we all as a
> community, now cannot continue just like nothing happened.
>
>  Thanks,
>   Thomas
>
>

--000000000000460c1205a9e038d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>I haven&#39;t looked at the disassembler code; assum=
ing it comes from an upstream code base I don&#39;t think we should treat i=
t differently from the ARM disassembler (or for that matter the binutils on=
es) and basically handle it as a black box for which we don&#39;t really ca=
re about the code quality or style. It&#39;s not security sensitive code, a=
nd forking the upstream is probably not justified. On the other hand the pu=
ll request should have explained the provenance of the code (even if only i=
n the subject line of the relevant patch).</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><span style=3D"font-family:sans-serif">Regarding the rec=
ommendation of a &quot;vacation&quot; after last week&#39;s facts, QEMU&#39=
;s enforcing of behavior standards so far has been informal, therefore my s=
uggestion cannot be anything more than a suggestion, though a strongly reco=
mmended one. I can also understand the soft freeze pressure. I=C2=A0</span>=
defer to Peter as to whether to merge this pull request or not due to Thoma=
s&#39;s objections, but I do wish to reinforce that taking some time off to=
 cool down can often times be a good idea.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Paolo<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">Il mar 7 lug 2020, 22:20 Thomas Huth &lt;<a href=3D"mail=
to:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">On 07/07/2020 18.40, Aleksandar Markovic wrote:<br>
&gt; The following changes since commit 710fb08fd297d7a92163debce1959fae8f3=
b6ed7:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/huth-gitlab/tags=
/pull-request-2020-07-06&#39; into staging (2020-07-07 12:41:15 +0100)<br>
&gt; <br>
&gt; are available in the git repository at:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://github.com/AMarkovic/qemu" rel=3D"noref=
errer noreferrer" target=3D"_blank">https://github.com/AMarkovic/qemu</a> t=
ags/mips-queue-jul-07-2020<br>
&gt; <br>
&gt; for you to fetch changes up to fa6e7da119b6da4067e757924e165bc737bb126=
0:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0scripts/performance: Add dissect.py script (2020-07-07 18:=
32:20 +0200)<br>
&gt; <br>
&gt; ----------------------------------------------------------------<br>
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
&gt; ----------------------------------------------------------------<br>
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
154 ++++++++++++++++++++++++++++++++++++++++<br>
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
bool ADD::disas_output(disassemble_info *info)<br>
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

--000000000000460c1205a9e038d4--


