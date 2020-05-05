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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECD1C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:57:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66BDB206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+DZRgiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66BDB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvFz-0008QH-Jn
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVvFB-0007PU-LI; Tue, 05 May 2020 06:56:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51909)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVvFA-0001uj-7L; Tue, 05 May 2020 06:56:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id x4so1789926wmj.1;
 Tue, 05 May 2020 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ZD1umptvEliusyhpKubHlHVNvSEPcPBtnKIH7M3+kzU=;
 b=r+DZRgiJkb5PyrzRaLyASb31anGODSxEEHp5N3/9QtbFziLDXndOK7mU7Lg7e4rOFM
 QDvqBYm/g++b6A3Vs7MWdIpP+Q+C5194/1zYhSsTKbmCzCUIlk77UrJf+vZXEW3dIwdl
 AliEgjj3xOSsgSrhnSfjZ+SMO07iDus+GajXtYBTW1os40Fe7RQkQLnIgf1lxKF9gRS5
 bDzRbEnOXIuwfVpgan0aVhBARqESiH4KShqlNYp5lTpDNZO7yYj8eZ193MJbVakcGFl4
 5EjCfJ8/W08OhUS74br/GKE38qJb+NHLGpa/hoAiFiD3ZBlOX9+SNrQ+dl69TDbb1cqp
 LTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ZD1umptvEliusyhpKubHlHVNvSEPcPBtnKIH7M3+kzU=;
 b=oTq7MSXf2deQtg/mJXLfKHwbau7UGGvJvVB31Xggoix4fCIw+J0TvXI31ou60JLNGt
 SmbKXe1v3u1RXeKO7PAlqUvUIf6jrIe722W9DUy4egeMcdH+hVE47wTQT/tJzZkjDCwO
 4AVYH+3xDrIzfhKZEJ4Yf4G7M9FvNQRlKbESXB+po0cK4UHkUUD41/P28jqL37ooIRAm
 8E/TLST3PnUyyYkNUuUpk+rUViTx9uXzBvLU5RpSEY4LJZb67OLwxLkqycGZXIRqGw94
 xeVrpRInV87hXjZt2VpqAIOQncrgOfhU7wmFttY9CDfvPaM2G1ru7LLmTz6pkN7e6tG1
 PNCA==
X-Gm-Message-State: AGi0Puas1iFbkvazBCNR9UvYRvW230G3A5J8ycPTQVdDd4MKGG2LV3H3
 0Zy+DH8ZPZ9OTy5/PfjNkGsCumol4vNYJPopNdU=
X-Google-Smtp-Source: APiQypKfnvJs5Yc2Z1pYc+0IbkdSjhsc7HML9ChtNftZEm9t3c1J+pT42Xja57SVi0s20i1bXwR5THU/dNDHevpDDjA=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr2897679wmi.50.1588676166524; 
 Tue, 05 May 2020 03:56:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:56:05 -0700 (PDT)
In-Reply-To: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
References: <1588674291-6486-1-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:56:05 +0200
Message-ID: <CAHiYmc5KYKYaSe6brjP0W6pJ74-x1HYCQSfRkMrtySdC_vuvRw@mail.gmail.com>
Subject: Re: [PATCH V2] tests/Makefile: Fix description of "make check"
To: Huacai Chen <zltjiangshi@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000091a20705a4e47ed2"
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
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Huacai Chen <chenhuacai@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000091a20705a4e47ed2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., Huacai =
Chen <zltjiangshi@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BE/=D0=BB=D0=B0:

> The description of "make check" is out-of-date, so fix it by adding
> block and softfloat.
>
> Reviewed-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
For this version too:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


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
> softfloat, qtest and decodetree tests"
>         @echo
>         @echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given
> target"
>         @echo " $(MAKE) check-qtest          Run qtest tests"
> --
> 2.7.0
>
>
>

--00000000000091a20705a4e47ed2
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
Reviewed-by: Claudio Fontana &lt;<a href=3D"mailto:cfontana@suse.de">cfonta=
na@suse.de</a>&gt;<br>
Signed-off-by: Huacai Chen &lt;<a href=3D"mailto:chenhc@lemote.com">chenhc@=
lemote.com</a>&gt;<br>
---<br>
=C2=A0tests/Makefile.include | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br></blockquote><div><br></div><div>For this version too:</div><div><br></=
div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px">Reviewed-by: Aleksandar Markovic &lt;</span><a href=3D"mail=
to:aleksandar.qemu.devel@gmail.com" target=3D"_blank" style=3D"font-size:14=
px;line-height:22.1200008392334px">aleksandar.qemu.devel@gmail.<wbr>com</a>=
<span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1200008392=
334px">&gt;</span></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>
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
 qtest and decodetree tests&quot;<br>
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

--00000000000091a20705a4e47ed2--

