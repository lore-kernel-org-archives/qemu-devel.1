Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E749C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:24:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53B202070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53B202070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRHZ-0007Nr-If
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRGw-0006nn-Gp
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:23:34 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRGu-0000Sn-Nc
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:23:34 -0400
Received: from mail-vs1-f69.google.com ([209.85.217.69])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <christian.ehrhardt@canonical.com>)
 id 1jwRGs-00037p-Jh
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 14:23:30 +0000
Received: by mail-vs1-f69.google.com with SMTP id l26so1790599vsb.23
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 07:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gRTJnjj9AxDPUWZQL7OWihkmKTHSnl+aXdyW5qkviXU=;
 b=YZVAv8uyDwnydDshfac5tuMgX2y/YwH/tsLBDDILhiu0Cs0EJN7uw3W5/3ceWmDd4R
 qlcg3fJ2WzkKT8pKFKEC7uDAjZqrmit9KMeZcGSLNbBkbrYJVQbxX1JgMgW9jwlpKUgt
 ail8Yl/jj79Tzk5n3oeiphTdEgeJ9w/s6ONFpYV3cHOEL0Qjupq1sVVR8pFMhYMwuWjg
 MiK/MINaRhatbESV0vgmGRDT5cOO4hvoOreoQYbGTB9idKLPz4xvLXy+mAt71ZdLF/Ae
 bRYEXlceXW+4l1AJE5eNF+lHhk9UwTuN4F1FPN6zjIW6b+aXSqi9A+nk8vjpM/xzlnek
 XzrQ==
X-Gm-Message-State: AOAM530EQXIuTRoyUamyPNhXu1hUT9os85Ie4EPyha1ICVr2Q/KQWdZY
 HIQsD7WM86OqAi/sTcWMsuwhBWNnZ7a7splqZUtqmwmWKiReiS5W2RLGM/UvbtWRQXGGWemz0El
 J7gb4Muj7jlJj8qEsFJqUafi657kJW3o9el5IVQ4/ghPp+wL3
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr7607198uan.9.1594995809361;
 Fri, 17 Jul 2020 07:23:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbpJPTDBGKjPgpidvaI9QcFpM9yNOcwhKLvAoL6+7rt4i8YKYTPUcKqza82UfC5dsGfeSkdZ2HP6t5PBqQ7uw=
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr7607169uan.9.1594995809024;
 Fri, 17 Jul 2020 07:23:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200717105139.25293-1-alex.bennee@linaro.org>
 <20200717105139.25293-6-alex.bennee@linaro.org>
In-Reply-To: <20200717105139.25293-6-alex.bennee@linaro.org>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 17 Jul 2020 16:23:03 +0200
Message-ID: <CAATJJ0+XL6-49cK0duxtYO1smywsoi3bL+03DxJG=OrpyZkdjQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] accel/tcg: better handle memory constrained systems
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000009d98d105aaa3e603"
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=christian.ehrhardt@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 09:40:52
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: fam@euphon.net, "Daniel P. Berrange" <berrange@redhat.com>,
 richard.henderson@linaro.org, qemu-devel <qemu-devel@nongnu.org>,
 f4bug@amsat.org, cota@braap.org, Paolo Bonzini <pbonzini@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009d98d105aaa3e603
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:51 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:

> It turns out there are some 64 bit systems that have relatively low
> amounts of physical memory available to them (typically CI system).
> Even with swapping available a 1GB translation buffer that fills up
> can put the machine under increased memory pressure. Detect these low
> memory situations and reduce tb_size appropriately.
>
> Fixes: 600e17b261
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Christian Ehrhardt <christian.ehrhardt@canonical.com>
> ---
>  accel/tcg/translate-all.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 2afa46bd2b1..2ff0ba6d19b 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t
> tb_size)
>  {
>      /* Size the buffer.  */
>      if (tb_size =3D=3D 0) {
> -        tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        size_t phys_mem =3D qemu_get_host_physmem();
> +        if (phys_mem > 0 && phys_mem < (2 *
> DEFAULT_CODE_GEN_BUFFER_SIZE)) {
> +            tb_size =3D phys_mem / 4;
>

In my experiments I've found that /8 more closely matches the former
behavior
on small hosts while at the same time not affecting common large hosts.


> +        } else {
> +            tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;
> +        }
>      }
>      if (tb_size < MIN_CODE_GEN_BUFFER_SIZE) {
>          tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;
> --
> 2.20.1
>
>

--=20
Christian Ehrhardt
Staff Engineer, Ubuntu Server
Canonical Ltd

--0000000000009d98d105aaa3e603
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 17, 2020 at 12:51 PM Alex=
 Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@lina=
ro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">It turns out there are some 64 bit systems that have relatively low<b=
r>
amounts of physical memory available to them (typically CI system).<br>
Even with swapping available a 1GB translation buffer that fills up<br>
can put the machine under increased memory pressure. Detect these low<br>
memory situations and reduce tb_size appropriately.<br>
<br>
Fixes: 600e17b261<br>
Signed-off-by: Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.or=
g" target=3D"_blank">alex.bennee@linaro.org</a>&gt;<br>
Cc: BALATON Zoltan &lt;<a href=3D"mailto:balaton@eik.bme.hu" target=3D"_bla=
nk">balaton@eik.bme.hu</a>&gt;<br>
Cc: Christian Ehrhardt &lt;<a href=3D"mailto:christian.ehrhardt@canonical.c=
om" target=3D"_blank">christian.ehrhardt@canonical.com</a>&gt;<br>
---<br>
=C2=A0accel/tcg/translate-all.c | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c<br>
index 2afa46bd2b1..2ff0ba6d19b 100644<br>
--- a/accel/tcg/translate-all.c<br>
+++ b/accel/tcg/translate-all.c<br>
@@ -976,7 +976,12 @@ static inline size_t size_code_gen_buffer(size_t tb_si=
ze)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0/* Size the buffer.=C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size =3D=3D 0) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D DEFAULT_CODE_GEN_BUFFER_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t phys_mem =3D qemu_get_host_physmem();<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (phys_mem &gt; 0 &amp;&amp; phys_mem &lt; (=
2 * DEFAULT_CODE_GEN_BUFFER_SIZE)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D phys_mem / 4;<br></b=
lockquote><div><br></div><div>In my experiments I&#39;ve found that /8 more=
 closely matches the former behavior</div><div>on small hosts while at the =
same time not affecting common large hosts.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tb_size =3D DEFAULT_CODE_GEN_BUF=
FER_SIZE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0if (tb_size &lt; MIN_CODE_GEN_BUFFER_SIZE) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tb_size =3D MIN_CODE_GEN_BUFFER_SIZE;<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Christian Ehrhardt<br>Staff Engineer, Ubuntu Ser=
ver<br>Canonical Ltd</div></div>

--0000000000009d98d105aaa3e603--

