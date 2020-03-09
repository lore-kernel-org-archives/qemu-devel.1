Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4E6C10F25
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:06:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDAE20663
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 20:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPlgBjCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDAE20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBOfW-0001KV-LA
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 16:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57437)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOeh-0000K1-FP
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1jBOeg-00034q-0O
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 16:05:39 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134]:46280)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1jBOef-00033c-R6; Mon, 09 Mar 2020 16:05:37 -0400
Received: by mail-il1-x134.google.com with SMTP id e8so9866397ilc.13;
 Mon, 09 Mar 2020 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bCYjf/nlzsguEkQ3fBcBcG1cf7H0czOyrYB+Vo3sjRk=;
 b=EPlgBjCmOk44QDTFZu9P8HU05uklFnrxiT0sygEUZDUmWPKjzrRmgEcoviXhpxXkxu
 3gzEzbCpnU33Z8u4x2M9wZ1T901+TZK6T9w7E8wd7GPH1gLVq15CkYSM03CvbFzMLbe1
 bRjPAFY4sN8UBOCZv5V1BN0/b8rRbD95MQVCLfofc4fuw7UWIireAufbLMQIU7dGnx2/
 i8kcgtsH2vs3w+6GEOg3ECBYeV0TPzExLzvWLWdEqKDGF8YPPejBjU5kSeAyb5MK/IGL
 uWglFq1O4mn05eiVQOVdhdv4JhTJnFveta8FO49fRQM5RLZEeDRpDE0uPpx6GKEilb5C
 4dkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bCYjf/nlzsguEkQ3fBcBcG1cf7H0czOyrYB+Vo3sjRk=;
 b=AVVvvAXOgPA/Kblx4CG5nlh7xt4eXAAG2ZhPVE3x6NU71nvk24Ct/Tt2Bi6imlUueS
 PW9CA3jzS5EuaxI83Dpa+oy4xRukBrc9s66fxGzxqM53oKRwcjxxPciYrs8DiBdzVbCO
 vpTt0QBSWqEtifinnHnabR5oF/CSFvdzTf5vDlaRSB3zJqKcu8habDltgijGQ2uEsxjI
 HvKMwZujQRrW8QkExTBDiXEFMSzkMHHYLjJhJfUuQcV9EqQjJ1gURnlo9nMMa5OsXfYR
 QnXnW0U95m+XkTSx/XJ5+aV1r9bMrKLhY4jv5YpjfNdzmvFhAF1sWesfmeq3351bVGxq
 ONWg==
X-Gm-Message-State: ANhLgQ1vKjYSJ0TgWe+fK/G86vC8yTiHr7D7unetjjhDIPpTIbVVwRQk
 cbiac81kwYx2mbAeA/i7K9dwNOeDsRQ2/Kxh1Ms=
X-Google-Smtp-Source: ADFU+vuL2w+fj5uxwgVGvT0yw4jfqLtY4PekeokxsqS0iYfanr5JdvYeg1Y8txU9HoAjqUZJdhY9wXIOeyHUHqOeERs=
X-Received: by 2002:a92:d3c7:: with SMTP id c7mr2609319ilh.265.1583784336853; 
 Mon, 09 Mar 2020 13:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200301215029.15196-1-nieklinnenbank@gmail.com>
 <20200301215029.15196-19-nieklinnenbank@gmail.com> <871rq876h3.fsf@linaro.org>
 <CAPan3WrNnrnngwE4pGeYpR9HS7Vr936-ojPZZovNo8ZdoAA0sg@mail.gmail.com>
 <CAFEAcA_6Lm-JwbXFLWeetc7+fhnrc5m2+YU28ymFw0MSoKOhwg@mail.gmail.com>
 <CAPan3Wo2Nf_d4AxsV5=sfOxv66rmQNfN==rpMn9=FtM5cZG9rw@mail.gmail.com>
 <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
In-Reply-To: <CAFEAcA-2-tz7F1vmbggpLnc1SSX+_W5pij-w8Vgjx+vqr-LRUA@mail.gmail.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 9 Mar 2020 21:05:25 +0100
Message-ID: <CAPan3Wr-oS-QRxmCDPXLRBG81yqjnp56B2WNuxtBMOxr2b9D6A@mail.gmail.com>
Subject: Re: [PATCH v6 18/18] docs: add Orange Pi PC document
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000cc916e05a071866c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::134
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cc916e05a071866c
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 9, 2020 at 8:43 PM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Mon, 9 Mar 2020 at 19:38, Niek Linnenbank <nieklinnenbank@gmail.com>
> wrote:
> > On Mon, Mar 9, 2020 at 12:22 PM Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >> Yes, this is now the right place to put arm board-specific
> >> documentation (the rearranging and conversion from texinfo
> >> is now in master). I should move microvm.rst's contents there
> >> I guess.
> >
> >
> > OK, I'll move orangepi.rst to docs/system/orangepi.rst and add a short
> section
> > about the Orange Pi PC machine to docs/system/target-arm.rst as well.
>
> You should include/reference the orangepi.rst from target-arm.rst, I think
> --
> that's where the per-board docs would belong in the structure we have.
> If you just drop a .rst file into the docs directory somewhere it won't
> actually go into the documentation and instead Sphinx will error
> out about it not being in the table of contents anywhere.
>

Ah now I see what is going on here. So the new rst files are ment to
automatically generate
documentation in various formats using the Python sphinx tool, correct?
I played around a bit with running 'make html' and using the include
directive you suggested in
the target-arm.rst file like:

  .. include:: orangepi.rst

That seems to work. And, now I also see that the orangepi.rst file contains
rst syntax errors which
I need to resolve. I'll make sure those are resolved in the next version.


>
> (I'll have a look at microvm.rst to see how best to make the structure
> work -- at the moment it kind of assumes there board documentation
> is always quite short so they're all in one file.)
>

Yeah that is fine Peter. If you have any update on that later, I'll adjust
the orangepi.rst file to fit in as well.

Regards,
Niek


>
> thanks
> -- PMM
>


-- 
Niek Linnenbank

--000000000000cc916e05a071866c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 9, 2020 at 8:43 PM Peter =
Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Mon, 9 Mar 2020 at 19:38, Niek Linnenbank &lt;<a href=3D"mailto:nie=
klinnenbank@gmail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt; w=
rote:<br>
&gt; On Mon, Mar 9, 2020 at 12:22 PM Peter Maydell &lt;<a href=3D"mailto:pe=
ter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; =
wrote:<br>
&gt;&gt; Yes, this is now the right place to put arm board-specific<br>
&gt;&gt; documentation (the rearranging and conversion from texinfo<br>
&gt;&gt; is now in master). I should move microvm.rst&#39;s contents there<=
br>
&gt;&gt; I guess.<br>
&gt;<br>
&gt;<br>
&gt; OK, I&#39;ll move orangepi.rst to docs/system/orangepi.rst and add a s=
hort section<br>
&gt; about the Orange Pi PC machine to docs/system/target-arm.rst as well.<=
br>
<br>
You should include/reference the orangepi.rst from target-arm.rst, I think =
--<br>
that&#39;s where the per-board docs would belong in the structure we have.<=
br>
If you just drop a .rst file into the docs directory somewhere it won&#39;t=
<br>
actually go into the documentation and instead Sphinx will error<br>
out about it not being in the table of contents anywhere.<br></blockquote><=
div><br></div><div>Ah now I see what is going on here. So the new rst files=
 are ment to automatically generate</div><div>documentation in various form=
ats using the Python sphinx tool, correct?</div><div>I played around a bit =
with running &#39;make html&#39; and using the include directive you sugges=
ted in</div><div>the target-arm.rst file like:</div><div><br></div><div>=C2=
=A0 .. include:: orangepi.rst</div><div><br></div><div>That seems to work. =
And, now I also see that the orangepi.rst file contains rst syntax errors w=
hich</div><div>I need to resolve. I&#39;ll make sure those are resolved in =
the next version.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
(I&#39;ll have a look at microvm.rst to see how best to make the structure<=
br>
work -- at the moment it kind of assumes there board documentation<br>
is always quite short so they&#39;re all in one file.)<br></blockquote><div=
><br></div><div>Yeah that is fine Peter. If you have any update on that lat=
er, I&#39;ll adjust the orangepi.rst file to fit in as well.</div><div><br>=
</div><div>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
thanks<br>
-- PMM<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000cc916e05a071866c--

