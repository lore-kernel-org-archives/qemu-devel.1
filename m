Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94FDC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:49:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D9D6206F5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 12:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6KPWvUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9D6206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYUM2-0004sM-Om
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 08:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <radoslaw.biernacki@gmail.com>)
 id 1jYT03-0004ab-B3; Tue, 12 May 2020 07:23:03 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c]:39856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <radoslaw.biernacki@gmail.com>)
 id 1jYT01-0002Qd-Fp; Tue, 12 May 2020 07:23:02 -0400
Received: by mail-ot1-x32c.google.com with SMTP id m13so10164364otf.6;
 Tue, 12 May 2020 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A6r3NaFnAcVrEeMqXBb5G94A6MKmDfEU/jj3VfxkxEo=;
 b=A6KPWvUBtQC0Vzwotm99EbXHRuICLUByTW2St1ZPGDjmca70SOwXf8z8zBBawAjMlc
 K/euaAM2YB+Zb0lsPoJnFvm7BY8XmpBvCtjjq9Z1hUiY4R+GAzdBUEBF3lFeT3BSTnrg
 bQQ8VARsBqizeTgDR9xTk9ylviYVZH1ughlMxS1ZCcudqR17RQXRpSs2FzGCkY5CoyTg
 KUTYykBXYCRDBcHcy7ks3r3zd8LUYLAN5Z0ZvX9SBS+uuV1IwGu8xyzUAnwLdS2qTc6e
 NyZ/XMZdg5Yr/yAhZpt84znrwiD0+3QLF5PEcFhNNj3sOFWwFouR02mOB/UMhrCxkVWt
 3tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A6r3NaFnAcVrEeMqXBb5G94A6MKmDfEU/jj3VfxkxEo=;
 b=uUtkQeEULwIkObo8guQtvEoj0RNiwe3/0iAgeHx2JpvKRyjLE4/M0zJBLrxsXee9RA
 XgtXF1VwB2LXCxL3Q07ix0ZGwI3rkaRiyZs2hsP4yf1p9XloU0RfVnZ4NTdnHCyEu+YR
 4ynb0DXuZw11DOETrD1k9oH9MqruNa2JHIEhjfe8DESITimI1xuRyh5x8PfiSTXx4WZg
 ZNz4ckU+PG39SDWnpUi1xV0Ntn/HJG7vHWlEiWuvD5/eMEZzM5VyjSGmjFxSTeClDgBc
 BY5UIIRps5P8a6iCTIyrhJv51EryUi5/OGBfIXg5BXypjuVly19m0b/6x3g+zr/y846v
 xjGA==
X-Gm-Message-State: AGi0PubWESvZj1ARAiASx+xVLu4CGK4tJi16Mbe7ujwlW0Ld3XpvkAiG
 zQEa0kfnbKFsgvrw3yILMgptWQ8XAK4aSr7eiLc=
X-Google-Smtp-Source: APiQypIgdzetvrjawfIq5nDSAbjTIUjBi4kqoBHpxYHHsMYcu2BjBofGRmoyU+Sj8+Oo6sr2x/cx9gp5yOaevbWJMAU=
X-Received: by 2002:a05:6830:1b65:: with SMTP id
 d5mr15417069ote.141.1589282579309; 
 Tue, 12 May 2020 04:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <dcb8d325-a2af-0c68-ad64-87f41521d4bb@redhat.com>
 <20200512093717.GZ21486@vanye>
In-Reply-To: <20200512093717.GZ21486@vanye>
From: Radoslaw Biernacki <radoslaw.biernacki@gmail.com>
Date: Tue, 12 May 2020 13:22:49 +0200
Message-ID: <CADp3C4vtiHnrcXCTzj-bUOCs=G=V6ayAtn9L7nEf+0BQSxDcWg@mail.gmail.com>
Subject: Re: SBSA-REF maintainer email bouncing
To: Leif Lindholm <leif@nuviainc.com>
Content-Type: multipart/alternative; boundary="0000000000009669fb05a571af28"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=radoslaw.biernacki@gmail.com; helo=mail-ot1-x32c.google.com
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
X-Mailman-Approved-At: Tue, 12 May 2020 08:48:17 -0400
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009669fb05a571af28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes my Linaro account is not active anymore.
I will sent a patch witch email update to rad@semihalf.com as this is my
company's email.

wt., 12 maj 2020, 11:37 u=C5=BCytkownik Leif Lindholm <leif@nuviainc.com>
napisa=C5=82:

> On Tue, May 12, 2020 at 08:34:13 +0200, Philippe Mathieu-Daud=C3=A9 wrote=
:
> > Hello,
> >
> > Radoslaw Biernacki is listed as maintainer for the SBSA-REF board.
> >
> > His radoslaw.biernacki@linaro.org email address no longer works,
> > apparently "Radoslaw Biernacki no longer works for Linaro".
>
> That was probably technically the case already when the patches went
> in, but Radek was given an "associate account" for continuity.
>
> I'm digging into what happened (although as _I_ don't work for Linaro
> anymore, that might take a bit longer than it otherwise would have).
>
> /
>     Leif
>
> >   SBSA-REF
> >   M: Radoslaw Biernacki <radoslaw.biernacki@linaro.org>
> >   M: Peter Maydell <peter.maydell@linaro.org>
> >   R: Leif Lindholm <leif@nuviainc.com>
> >   L: qemu-arm@nongnu.org
> >   S: Maintained
> >   F: hw/arm/sbsa-ref.c
> >
>

--0000000000009669fb05a571af28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Yes my Linaro account is not active anymore.<div dir=3D"a=
uto">I will sent a patch witch email update to <a href=3D"mailto:rad@semiha=
lf.com">rad@semihalf.com</a> as this is my company&#39;s email.</div></div>=
<br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">wt., 1=
2 maj 2020, 11:37 u=C5=BCytkownik Leif Lindholm &lt;<a href=3D"mailto:leif@=
nuviainc.com">leif@nuviainc.com</a>&gt; napisa=C5=82:<br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">On Tue, May 12, 2020 at 08:34:13 +0200, Philippe Mathieu=
-Daud=C3=A9 wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; Radoslaw Biernacki is listed as maintainer for the SBSA-REF board.<br>
&gt; <br>
&gt; His <a href=3D"mailto:radoslaw.biernacki@linaro.org" target=3D"_blank"=
 rel=3D"noreferrer">radoslaw.biernacki@linaro.org</a> email address no long=
er works,<br>
&gt; apparently &quot;Radoslaw Biernacki no longer works for Linaro&quot;.<=
br>
<br>
That was probably technically the case already when the patches went<br>
in, but Radek was given an &quot;associate account&quot; for continuity.<br=
>
<br>
I&#39;m digging into what happened (although as _I_ don&#39;t work for Lina=
ro<br>
anymore, that might take a bit longer than it otherwise would have).<br>
<br>
/<br>
=C2=A0 =C2=A0 Leif<br>
<br>
&gt;=C2=A0 =C2=A0SBSA-REF<br>
&gt;=C2=A0 =C2=A0M: Radoslaw Biernacki &lt;<a href=3D"mailto:radoslaw.biern=
acki@linaro.org" target=3D"_blank" rel=3D"noreferrer">radoslaw.biernacki@li=
naro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0M: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt=
;<br>
&gt;=C2=A0 =C2=A0R: Leif Lindholm &lt;<a href=3D"mailto:leif@nuviainc.com" =
target=3D"_blank" rel=3D"noreferrer">leif@nuviainc.com</a>&gt;<br>
&gt;=C2=A0 =C2=A0L: <a href=3D"mailto:qemu-arm@nongnu.org" target=3D"_blank=
" rel=3D"noreferrer">qemu-arm@nongnu.org</a><br>
&gt;=C2=A0 =C2=A0S: Maintained<br>
&gt;=C2=A0 =C2=A0F: hw/arm/sbsa-ref.c<br>
&gt; <br>
</blockquote></div>

--0000000000009669fb05a571af28--

