Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC12CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1233A2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 19:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6hP/imI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1233A2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNjCi-0001WB-6j
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 15:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNjBk-0000PV-Js
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iNjBj-0000IO-Bs
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:54:28 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:45895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iNjBj-0000Hr-7I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 15:54:27 -0400
Received: by mail-ot1-x32a.google.com with SMTP id 41so45566oti.12
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=a9f/3LEr+7ToZpTXngm9Y6uYyTA25LvtjRYExaHs7ZA=;
 b=Q6hP/imIW6Z0tLI6olzowLP/aEv67zpKlW9nvXQVlzdtnqRLCT/w1j0+QhI7+lqtKA
 LRCHSYlwMqp7YCXKyx30L1031BpjT0tdaOEKyUnihSyWfQSGU8ARsJjNv5wCXarZWcyD
 ingQkWmIKlng032Bbk0SDLUxCxl8gFmbk6SKRvyhvpQYOe5lG9Uv0UoPVNqDIUD8iJJf
 gOMUndasX0kmFTw0y0gXrgYsmrwuq7YrRwNMe8qbhHv1qtrY0pLC4KOZNyoL+mNXeBbq
 CTtXkIkriYGAl6J4rL5ip78AVahwngfVcV3hM2mV0o3UFFAsWmt5c6JZuwgnamu6RGY9
 +HAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=a9f/3LEr+7ToZpTXngm9Y6uYyTA25LvtjRYExaHs7ZA=;
 b=fLRq4DublozPcJOfiFoKKd8hFUygQY2hawBC6v715fRMpE+wydydntOKrd0q1b4DJv
 qTK8VDaTxpbzyyioUUZikz9cGWOMiUPekaJdjVWCsYjOT5zXgpA6uU0cRd5t8veHZ5jB
 wy/m4Lzbm8z2jzH6EcIFpsNdMlJpzzhwK8D/feftSgjxsZFDPGanM1ayNyc5X9mhoKsB
 7EGHTOOnlL7ghnf7OVHK4W3u1Vr+euR2ATdlu74OGPImDbYyyHXfBnNOaWXvBqT2V3C4
 iHMA1FCqb4nD+UYJT0Hp2s+IVrgYGM6NDdeldkkxay3+ux/gJI9i+ekeQYsUcwp3XZOr
 vKvA==
X-Gm-Message-State: APjAAAUozIh3jqBBCi9DjsZ+3ca+6Y7DzdThIsibKgL5WxZjBfZsgDVH
 Wfr5YmC+qWberYnC3WSjtu9lxjCy/gL0zuKl1FE=
X-Google-Smtp-Source: APXvYqyHLCA31pSETMSUjGyXkNvV6CdUmy6//MR7kMIOfbcaqpF+JLk4iSNKTz006NZEmFCdzNnuqF9QpY0M1SlQS2I=
X-Received: by 2002:a9d:4f0f:: with SMTP id d15mr12788275otl.64.1571946865562; 
 Thu, 24 Oct 2019 12:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 24 Oct 2019 12:54:24
 -0700 (PDT)
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 24 Oct 2019 12:54:24
 -0700 (PDT)
In-Reply-To: <1571925835-31930-4-git-send-email-pbonzini@redhat.com>
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <1571925835-31930-4-git-send-email-pbonzini@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 24 Oct 2019 21:54:24 +0200
Message-ID: <CAL1e-=jtrSuPmVzBAbPipjBu+8-ZAyMzTmFyu_ujDCUzbosq-g@mail.gmail.com>
Subject: Re: [PULL 03/39] Updated Bulgarian translation (19) - 4.1.0
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000872b280595ad66ac"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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
Cc: Alexander Shopov <ash@kambanaria.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000872b280595ad66ac
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

24.10.2019. 16.26, "Paolo Bonzini" <pbonzini@redhat.com> =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> From: Alexander Shopov <ash@kambanaria.org>
>
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>
> Message-Id: <20191019120534.27479-2-ash@kambanaria.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  po/bg.po | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

How come my "Reviewed-by" is not recorded here? It is not a big deal, just
curious how it happened.

A.

> diff --git a/po/bg.po b/po/bg.po
> index 3d8c353..98c57e5 100644
> --- a/po/bg.po
> +++ b/po/bg.po
> @@ -1,14 +1,14 @@
>  # Bulgarian translation of qemu po-file.
> -# Copyright (C) 2016 Alexander Shopov <ash@kambanaria.org>
> +# Copyright (C) 2016, 2019 Alexander Shopov <ash@kambanaria.org>
>  # This file is distributed under the same license as the qemu package.
> -# Alexander Shopov <ash@kambanaria.org>, 2016.
> +# Alexander Shopov <ash@kambanaria.org>, 2016, 2019.
>  #
>  msgid ""
>  msgstr ""
> -"Project-Id-Version: QEMU 2.6.50\n"
> +"Project-Id-Version: QEMU 4.1.0\n"
>  "Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
>  "POT-Creation-Date: 2018-07-18 07:56+0200\n"
> -"PO-Revision-Date: 2016-06-09 15:54+0300\n"
> +"PO-Revision-Date: 2019-10-19 13:14+0200\n"
>  "Last-Translator: Alexander Shopov <ash@kambanaria.org>\n"
>  "Language-Team: Bulgarian <dict@ludost.net>\n"
>  "Language: bg\n"
> @@ -66,7 +66,7 @@ msgid "Detach Tab"
>  msgstr "=D0=9A=D1=8A=D0=BC =D1=81=D0=B0=D0=BC=D0=BE=D1=81=D1=82=D0=BE=D1=
=8F=D1=82=D0=B5=D0=BB=D0=B5=D0=BD =D0=BF=D0=BE=D0=B4=D0=BF=D1=80=D0=BE=D0=
=B7=D0=BE=D1=80=D0=B5=D1=86"
>
>  msgid "Show Menubar"
> -msgstr ""
> +msgstr "=D0=9B=D0=B5=D0=BD=D1=82=D0=B0 =D0=B7=D0=B0 =D0=BC=D0=B5=D0=BD=
=D1=8E=D1=82=D0=BE"
>
>  msgid "_Machine"
>  msgstr "_=D0=9C=D0=B0=D1=88=D0=B8=D0=BD=D0=B0"
> --
> 1.8.3.1
>
>
>

--000000000000872b280595ad66ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"><br>
24.10.2019. 16.26, &quot;Paolo Bonzini&quot; &lt;<a href=3D"mailto:pbonzini=
@redhat.com">pbonzini@redhat.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; From: Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.org">ash@k=
ambanaria.org</a>&gt;<br>
&gt;<br>
&gt; Signed-off-by: Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.o=
rg">ash@kambanaria.org</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20191019120534.27479-2-ash@kambanari=
a.org">20191019120534.27479-2-ash@kambanaria.org</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0po/bg.po | 10 +++++-----<br>
&gt; =C2=A01 file changed, 5 insertions(+), 5 deletions(-)<br>
&gt;</p>
<p dir=3D"ltr">How come my &quot;Reviewed-by&quot; is not recorded here? It=
 is not a big deal, just curious how it happened.</p>
<p dir=3D"ltr">A.</p>
<p dir=3D"ltr">&gt; diff --git a/po/bg.po b/po/bg.po<br>
&gt; index 3d8c353..98c57e5 100644<br>
&gt; --- a/po/bg.po<br>
&gt; +++ b/po/bg.po<br>
&gt; @@ -1,14 +1,14 @@<br>
&gt; =C2=A0# Bulgarian translation of qemu po-file.<br>
&gt; -# Copyright (C) 2016 Alexander Shopov &lt;<a href=3D"mailto:ash@kamba=
naria.org">ash@kambanaria.org</a>&gt;<br>
&gt; +# Copyright (C) 2016, 2019 Alexander Shopov &lt;<a href=3D"mailto:ash=
@kambanaria.org">ash@kambanaria.org</a>&gt;<br>
&gt; =C2=A0# This file is distributed under the same license as the qemu pa=
ckage.<br>
&gt; -# Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.org">ash@kamb=
anaria.org</a>&gt;, 2016.<br>
&gt; +# Alexander Shopov &lt;<a href=3D"mailto:ash@kambanaria.org">ash@kamb=
anaria.org</a>&gt;, 2016, 2019.<br>
&gt; =C2=A0#<br>
&gt; =C2=A0msgid &quot;&quot;<br>
&gt; =C2=A0msgstr &quot;&quot;<br>
&gt; -&quot;Project-Id-Version: QEMU 2.6.50\n&quot;<br>
&gt; +&quot;Project-Id-Version: QEMU 4.1.0\n&quot;<br>
&gt; =C2=A0&quot;Report-Msgid-Bugs-To: <a href=3D"mailto:qemu-devel@nongnu.=
org">qemu-devel@nongnu.org</a>\n&quot;<br>
&gt; =C2=A0&quot;POT-Creation-Date: 2018-07-18 07:56+0200\n&quot;<br>
&gt; -&quot;PO-Revision-Date: 2016-06-09 15:54+0300\n&quot;<br>
&gt; +&quot;PO-Revision-Date: 2019-10-19 13:14+0200\n&quot;<br>
&gt; =C2=A0&quot;Last-Translator: Alexander Shopov &lt;<a href=3D"mailto:as=
h@kambanaria.org">ash@kambanaria.org</a>&gt;\n&quot;<br>
&gt; =C2=A0&quot;Language-Team: Bulgarian &lt;<a href=3D"mailto:dict@ludost=
.net">dict@ludost.net</a>&gt;\n&quot;<br>
&gt; =C2=A0&quot;Language: bg\n&quot;<br>
&gt; @@ -66,7 +66,7 @@ msgid &quot;Detach Tab&quot;<br>
&gt; =C2=A0msgstr &quot;=D0=9A=D1=8A=D0=BC =D1=81=D0=B0=D0=BC=D0=BE=D1=81=
=D1=82=D0=BE=D1=8F=D1=82=D0=B5=D0=BB=D0=B5=D0=BD =D0=BF=D0=BE=D0=B4=D0=BF=
=D1=80=D0=BE=D0=B7=D0=BE=D1=80=D0=B5=D1=86&quot;<br>
&gt;<br>
&gt; =C2=A0msgid &quot;Show Menubar&quot;<br>
&gt; -msgstr &quot;&quot;<br>
&gt; +msgstr &quot;=D0=9B=D0=B5=D0=BD=D1=82=D0=B0 =D0=B7=D0=B0 =D0=BC=D0=B5=
=D0=BD=D1=8E=D1=82=D0=BE&quot;<br>
&gt;<br>
&gt; =C2=A0msgid &quot;_Machine&quot;<br>
&gt; =C2=A0msgstr &quot;_=D0=9C=D0=B0=D1=88=D0=B8=D0=BD=D0=B0&quot;<br>
&gt; -- <br>
&gt; 1.8.3.1<br>
&gt;<br>
&gt;<br>
&gt;<br>
</p>

--000000000000872b280595ad66ac--

