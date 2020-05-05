Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB1C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E20206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEqC30jY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E20206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVupv-0003eP-Pa
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVujH-00034c-0X
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:23:11 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVujF-00021E-Po
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:23:10 -0400
Received: by mail-wm1-x343.google.com with SMTP id u127so1714979wmg.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=GBSP5CqJ50V4GXbDH9gnIscg4meCA2LQ/ec3DF0Px4E=;
 b=pEqC30jY9HqR1YrJy918sA7xMhkXU06KBp5f7y2SW5knjqv+lRHLbL2VYUQRbSDByZ
 wi0iOMsOFC+1uZ0zQOrkE6GtqV9zjI3iXawMZHTy8PtTcjlW6XXv4OydnCQY8O1+TmH3
 iHQEUkXlKEH+6WDdjXqFwrw08QgO+0KYBre23BpGvEEsEBs+79pfQCno2VA36ecQc3wH
 ZJDtFT6YJBOMZXb3MId9xdAV7gKpvE5xXKqCA8qkB3yDXv8qsTZ6CYkq5uHnqZV3pkSC
 cZUGT6rJRxQV0R9i3vh9ooD1WY0lcR0aoplzTcNMY3h/Pz7B8RFqmpUFCSnxkBHm8oiE
 cSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=GBSP5CqJ50V4GXbDH9gnIscg4meCA2LQ/ec3DF0Px4E=;
 b=CjbXlNrcbo+nbjsKeFpYO+GK/+o3AoNcPcErI/aEB/nxk/j7UmOm/wy0lo6V7cHKVU
 pTt69TyKxXo1uxdlVH09z6dSly7G0H2IHSmnWLWVIpkWATmgQTS1agKeNT6/FBhxXOfT
 yOj17h3mx68ZAgTUPKHn582FwbnnlzWswEGKod1ZSEKBCOHMhilOf78eyRoqK/U6wpIS
 ysUKzbbGSZ5cWlauctmxa6bS3aIrlKezEi6+mXi8953sin3bY44fvhJUurtrq5xjs5TM
 tmGTdOhS49708bIzvQugX3YQcn4I2eKA3pwgZ0VwuKZTqlaoDBVXpZoKPzqtRXufA8m7
 v98w==
X-Gm-Message-State: AGi0PubWnk+cdc4QVxihbGqw0ytilF9Zb6aLJ4wEgxC8QokjRDWps/Ge
 2FpgHxUsnrklS88TiPzU/OuAcUf+vSSJZO8qddY=
X-Google-Smtp-Source: APiQypIOqHoMYndaV5h1XwkCt7HOSqAFNszaWkPwgOQPAj7VeHixdnilEtFhmtz5BQcyzPSAwi4fEZ+P+gJ/wlTmiA8=
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr2579607wme.159.1588674188402; 
 Tue, 05 May 2020 03:23:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:23:08 -0700 (PDT)
In-Reply-To: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
References: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:23:08 +0200
Message-ID: <CAHiYmc669jBy1ms3QuRsHrKaawGOh6tVb4L-Z2izd9t_upRHNg@mail.gmail.com>
Subject: Re: [PATCH] tests/Makefile: Fix description of "make check"
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a9e39705a4e408d0"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Fam Zheng <fam@euphon.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a9e39705a4e408d0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> The description of "make check" is out-of-date, so fix it by adding
> block and softfloat.
>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 03a74b6..5d32239 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,7 +4,7 @@
>  check-help:
>         @echo "Regression testing targets:"
>         @echo
> -       @echo " $(MAKE) check                Run unit, qapi-schema, qtest
> and decodetree"
> +       @echo " $(MAKE) check                Run block, qapi-schema, unit=
,
> softfloat, qtest and decodetree"
>         @echo
>         @echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given
> target"
>         @echo " $(MAKE) check-qtest          Run qtest tests"
> --
> 2.7.0
>
>
>

--000000000000a9e39705a4e408d0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020.,=
 Huacai Chen &lt;<a href=3D"mailto:zltjiangshi@gmail.com">zltjiangshi@gmail=
.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">The description of &quot;make che=
ck&quot; is out-of-date, so fix it by adding<br>
block and softfloat.<br>
<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_b=
lank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.qe=
mu.devel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34);font-size:14p=
x;line-height:22.1200008392334px">&gt;</span></div><div>=C2=A0<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
=C2=A0tests/Makefile.include | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/Makefile.include b/tests/Makefile.include<br>
index 03a74b6..5d32239 100644<br>
--- a/tests/Makefile.include<br>
+++ b/tests/Makefile.include<br>
@@ -4,7 +4,7 @@<br>
=C2=A0check-help:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @echo &quot;Regression testing targets:&quot;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @echo<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0@echo &quot; $(MAKE) check=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Run unit, qapi-schema, qtest and decodet=
ree&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0@echo &quot; $(MAKE) check=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Run block, qapi-schema, unit, softfloat,=
 qtest and decodetree&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @echo<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @echo &quot; $(MAKE) check-qtest-TARGET=C2=A0 =
=C2=A0Run qtest tests for given target&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 @echo &quot; $(MAKE) check-qtest=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 Run qtest tests&quot;<br>
-- <br>
2.7.0<br>
<br>
<br>
</blockquote>

--000000000000a9e39705a4e408d0--

