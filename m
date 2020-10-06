Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B80C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:06:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16559206F7
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 11:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mao7d1sS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16559206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPknf-0000LC-0I
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 07:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPkmG-0007qt-OE; Tue, 06 Oct 2020 07:05:04 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45208)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPkmE-0004Pd-5y; Tue, 06 Oct 2020 07:05:04 -0400
Received: by mail-lf1-x144.google.com with SMTP id r127so9999738lff.12;
 Tue, 06 Oct 2020 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=ShgKJIATCRLc1UZrwWiQMsp7fArWY7bDngTdzl+gdnY=;
 b=Mao7d1sSmrWhj0aPTs3+aTtl4f3rJMSMQooutcxfr6ykVohv8vGgYSfntolyTHg6Gq
 VlppAILooLobzS7sQ4WqUaREUG8pMD/FhuX8uaWo8sbH452jKGQnk3cWePuKlOpyU6OG
 uc1Uzh7mgiwOAPLaPWghLEcJGDZAimg9AvMT8jyZmyUnwSRLX3wsk4Pq7QBK7p37IBna
 GQCi4EUsW6EGPyZjXkwkRN1RO4ds5zbSwnuQbeWDiuxGH1GCSH4pijP0jXl7VKjPypdX
 SBuCLCfl9vUxjc7eY0PnkprRfIyboNHKoZbLzMEDeqXwrfDfEcK9URF6e6W4G/EN1/dR
 ntXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=ShgKJIATCRLc1UZrwWiQMsp7fArWY7bDngTdzl+gdnY=;
 b=NrpwWKSMXF5ONQ1q24CVnQy+SXiBNgnxeJ1EjixLfgdTzKkyQOCtggAegScyGmi0La
 xSS8k2BAruD5Gg5eWb7intYJ9HeAgF32pJDRGK4Yxx4O1yCPdhS2LXp/EaeuuiYCrO2n
 FbedRgc3p8pX9E23wZ6aS4mnFR2vOC/Qig5++YaAITwcq+kk2AsKSQA1rddoZSaiMOUX
 AsfgT3VNSTvRE5nCt9BwYeaUMm9ZF24QhzyUU5AtcU1eBwTRrc0zthZtJCVsKMeiozZa
 c/XUcOGHPMKGXhWigV11Qsxq2Y24uFfwvpwjcHt8DzFQ2EfNa0UeGEHsqiYIzROQ0mQL
 y2Yg==
X-Gm-Message-State: AOAM533Lb25cPI+iMxsWvubtmVKrNb3KbrzN/vjAxYmUtejxXdKNifmt
 +SHwb0cCUKOlMl/apBhKWnijbxUITPrADr3q1SY=
X-Google-Smtp-Source: ABdhPJwCT8vQ3RvuMQQ/af+rieh08Diu2fFBax5fWlk9rIFssfKMWPZW//Nl5ih0W6B/Ag73oUJf3TB931jVmtX8fhU=
X-Received: by 2002:a19:f819:: with SMTP id a25mr299940lff.382.1601982299955; 
 Tue, 06 Oct 2020 04:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201005195129.1507-1-luoyonggang@gmail.com>
 <CAFEAcA8oa7A8f9EjSTnutUKC8tZ98Y_DrSYxdhy22T3y9NHRaQ@mail.gmail.com>
In-Reply-To: <CAFEAcA8oa7A8f9EjSTnutUKC8tZ98Y_DrSYxdhy22T3y9NHRaQ@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 6 Oct 2020 19:04:48 +0800
Message-ID: <CAE2XoE-QZBm=nkimjzTN424LsciD1J3p4DwjDR4uFm2tY07y3w@mail.gmail.com>
Subject: Re: [PATCH v3] scripts: Convert qemu-version.sh to qemu-version.py
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ece64505b0fe9172"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ece64505b0fe9172
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 6:33 PM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Mon, 5 Oct 2020 at 20:51, Yonggang Luo <luoyonggang@gmail.com> wrote:
> >
> > The sh script are harder to maintain for compatible different
> > xsh environment so convert it to python script
> > Also incorporate the fixes in
> >
https://patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.co=
m/
> >
> > Testing args length and if not enough, setting pkgversion and version
to ''
> >
> > +#
> > +# Script for retrieve qemu git version information
> > +#
> > +# Author: Yonggang Luo <luoyonggang@gmail.com>
> > +#
> > +# This work is licensed under the terms of the GNU GPL, version 2.  Se=
e
> > +# the COPYING file in the top-level directory.
>
> Does this have to be GPL-v2-only ? We strongly prefer
> v2-or-later...
Directly copy from other python script, do you have a template for this?
>
> thanks
> -- PMM



--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000ece64505b0fe9172
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Tue, Oct 6, 2020 at 6:33 PM Peter Maydell &lt;<=
a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;=
 wrote:<br>&gt;<br>&gt; On Mon, 5 Oct 2020 at 20:51, Yonggang Luo &lt;<a hr=
ef=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; wrote:<br=
>&gt; &gt;<br>&gt; &gt; The sh script are harder to maintain for compatible=
 different<br>&gt; &gt; xsh environment so convert it to python script<br>&=
gt; &gt; Also incorporate the fixes in<br>&gt; &gt; <a href=3D"https://patc=
hew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/">https://=
patchew.org/QEMU/20200929143654.518157-1-marcandre.lureau@redhat.com/</a><b=
r>&gt; &gt;<br>&gt; &gt; Testing args length and if not enough, setting pkg=
version and version to &#39;&#39;<br>&gt; &gt;<br>&gt; &gt; +#<br>&gt; &gt;=
 +# Script for retrieve qemu git version information<br>&gt; &gt; +#<br>&gt=
; &gt; +# Author: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com"=
>luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; +#<br>&gt; &gt; +# This work is=
 licensed under the terms of the GNU GPL, version 2.=C2=A0 See<br>&gt; &gt;=
 +# the COPYING file in the top-level directory.<br>&gt;<br>&gt; Does this =
have to be GPL-v2-only ? We strongly prefer<br>&gt; v2-or-later...<div>Dire=
ctly copy from other python script, do you have a template for this?<br>&gt=
;<br>&gt; thanks<br>&gt; -- PMM<br><br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A=
<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--000000000000ece64505b0fe9172--

