Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7AEC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4BDC21848
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGd5rkPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4BDC21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKLnl-0000CS-Pz
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 08:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iKLlQ-0007tW-DJ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iKLlO-0002rx-VW
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:17:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:39644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iKLlO-0002qj-Ql
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 08:17:18 -0400
Received: by mail-oi1-x243.google.com with SMTP id w144so16571633oia.6
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 05:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=DW+pwd5ccaEqPqdb1U2F0RHM5IB3TG9RH0PzgM6eKP0=;
 b=uGd5rkPw0g+Llgq5VG6wuDkCIJC5ewqQmgvbz5nOOmPThr3OkFa05Ubys2wcL30HU3
 kAWmAZwyCmS8UwgmPjtESfT63vJK7MXcFxQdhoAfufJVaKQrMjQTU1w1quvuS/ZGtnT1
 1ai1rjzKFUCxiuejXQ9XCfYu1x9hU2kDJM//WjEz2D01MFF6xI/DoTsd3K/ojZ23m9U4
 FWv59h850W2N2NoEFppavA2+Fjz6PV+cWwD3e6pAP5DbfFtQhTPPah+LUZNphcOPdbnw
 wISLuyUOS8sDJsHYPZjaDOO7xfRS0ENPjdbKevNz054pUjxztf/HodU7XLsahiPGsLNq
 St1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=DW+pwd5ccaEqPqdb1U2F0RHM5IB3TG9RH0PzgM6eKP0=;
 b=YerkI04b/rnVE8UmaYrTmXoV06AAMgmdGYcMMv2oFaxIGxE59yvKVuOIdy4z3ougVJ
 4eQDG1PZxQmqZA9jRoxvelnRW2B30BCgMRJSLvZfBCA2JeZ+hbcK8MlsoJms81bC4NOK
 L4dbUpswWB5QIn74o+rXRFCWTtOCiR8o+062ZQ8ALxwAouywZslMvXP9YZ2XtnBtkzK1
 JbZfKVvH9ouLdHQ4OtxrH9xLDSkSwHedmmg2sx/LsnYDFMI60iybSYW0JV4WU8ZM551K
 nPI/jj9VFW/qDlMAavCyVYbjUcK6MTLsmYw3XdPLmX7m6hJrNxJdfHJW3NJNqD6dgSyU
 z+lg==
X-Gm-Message-State: APjAAAU78TOq1dGri2XpC8VJfVLs6c6aZkhWzX2HtyBPhbNoMQSmhT0e
 MqHm19BJFLPvq/d/axRAHQf1d5AWMpfKBTqY/gQ=
X-Google-Smtp-Source: APXvYqxdTQNPj0atazn4u+WeHUNxL+8JfRonBIU9W5OuZz75/suHsAZFdLBo2T92PqoSd0anPN9F/5otocxMaGifne8=
X-Received: by 2002:a54:460c:: with SMTP id p12mr28962919oip.62.1571141837642; 
 Tue, 15 Oct 2019 05:17:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Tue, 15 Oct 2019 05:17:17
 -0700 (PDT)
In-Reply-To: <87mue2xy3l.fsf@dusky.pond.sub.org>
References: <1570991178-5511-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1570991178-5511-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <87a7a36awg.fsf@dusky.pond.sub.org>
 <CAL1e-=gD629LfDPokJ6XAnR_xxE-vHw3RZqg=JDai-xAcJC0Dg@mail.gmail.com>
 <87mue2xy3l.fsf@dusky.pond.sub.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 15 Oct 2019 14:17:17 +0200
Message-ID: <CAL1e-=gBkZEg-o7uy6wEW1M4eyf+OYbvWjxUAB7zwmvAPUahdw@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] target/mips: Clean up helper.c
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001fde310594f1f7f7"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001fde310594f1f7f7
Content-Type: text/plain; charset="UTF-8"

>
>
>
Markus wrote:


> However, I find the common pattern applied here
>
>     case 3: /* ERL */
>         /* If EU is set, always unmapped */
>         if (eu) {
>             return 0;
>         }
>
> more readable ...


>
>
 I am going to do it this way in v5.

Thanks,
Aleksandar



> ... than the unusual (to my eyes)
>
>     case 3:
>         /*
>          * ERL
>          * If EU is set, always unmapped
>          */
>         if (eu) {
>             return 0;
>         }
>
> The first line of the comment applies to the value preceding it, the
> second to the code following it.  Making these connections doesn't
> exactly take genius, but neither is it effortless.
>
> Nice and consistent coding style is all about reducing the effort of
> reading code.
>
> For what it's worth, the pattern
>
>     case VALUE: /* comment on VALUE */
>         /* comment on CODE */
>         CODE
>
> occurs almost 300 times.
>
> > I don't see any reason to change this patch. Please let me know it you
> > still think I should do something else. And you are welcome to analyse
> any
> > patches of mine.
>
> Please consider keeping two separate comments, i.e. just move the colon
> to its usual place.
>
> Thanks!
>

--0000000000001fde310594f1f7f7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br></blockquote><div>=C2=A0</div><div>Marku=
s wrote:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
However, I find the common pattern applied here<br>
<br>
=C2=A0 =C2=A0 case 3: /* ERL */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If EU is set, always unmapped */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
more readable ...</blockquote><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br></blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><br></blockquote><div>=C2=A0</div><div>=
=C2=A0I am going to do it this way in v5.</div><div><br></div><div>Thanks,<=
/div><div>Aleksandar</div><div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><br></blockquote><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">... than the =
unusual (to my eyes)<br>
<br>
=C2=A0 =C2=A0 case 3:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ERL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If EU is set, always unmapped<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (eu) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
The first line of the comment applies to the value preceding it, the<br>
second to the code following it.=C2=A0 Making these connections doesn&#39;t=
<br>
exactly take genius, but neither is it effortless.<br>
<br>
Nice and consistent coding style is all about reducing the effort of<br>
reading code.<br>
<br>
For what it&#39;s worth, the pattern<br>
<br>
=C2=A0 =C2=A0 case VALUE: /* comment on VALUE */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* comment on CODE */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 CODE<br>
<br>
occurs almost 300 times.<br>
<br>
&gt; I don&#39;t see any reason to change this patch. Please let me know it=
 you<br>
&gt; still think I should do something else. And you are welcome to analyse=
 any<br>
&gt; patches of mine.<br>
<br>
Please consider keeping two separate comments, i.e. just move the colon<br>
to its usual place.<br>
<br>
Thanks!<br>
</blockquote>

--0000000000001fde310594f1f7f7--

