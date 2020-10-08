Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE06C43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:05:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58470217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXfaXYLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58470217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQPzc-000492-2y
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPwG-0000p4-QC; Thu, 08 Oct 2020 03:02:09 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kQPwE-0002wm-1o; Thu, 08 Oct 2020 03:02:08 -0400
Received: by mail-ej1-x642.google.com with SMTP id e22so6546217ejr.4;
 Thu, 08 Oct 2020 00:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JeRqgtDBYnHt5SiMKhN4RpRt4Xe1xXTtzB3loz7l9lE=;
 b=aXfaXYLutYEFPbA811Sjsv3WJPjDJao+A4UYGzOWwtnjC5+nSoqbpIMuEjez82ivhX
 0gmul1O0IyyzKzQ7wD1C3Y9T7lxHiLilPogwYUnrWI9I+AcYqV/Q7sowLwx2TWqLm9gD
 6Pn1P6veaD9beAI+IEbNZoRw4j6zwiLU/JuC+V0fVosy4OolYdaE7U3LFQHnv3XJcKy0
 Wc1omKCkd+XEiBgAnz5JAYioCtzfNFPLTo5bcNGwMwjPOZT6nAp6ApstROPkLzuo0NVE
 lBtzqykztoR0Qim2pvZEkUmY0es5KMKq4I52lhsCpHvpTfINda6vPrEV5JookdiPGCIt
 cqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JeRqgtDBYnHt5SiMKhN4RpRt4Xe1xXTtzB3loz7l9lE=;
 b=bnLmBXz69WWZj8Eu5Sq9H2LM5uBT6u3HsfNZaxLqaZMRonTXoQf5oixAN9ulJodEPj
 8PGODMXLKzEzmAscXQ8iYS4j4xYPop0shn5OPZP6/uG+ProiNrUqoz+x9oo0xwTGMKNS
 oNQyzEFOkHyKAS0nsUKf7QIWhYj9AOlwW9b9c8stWRAh3gv1TTQGs486ObjTfCXeBGZ7
 LEwUpa5N338IIduamfidjvMBZ7kCCjItt7Qns1IKo20Icghrnf2wLHhTnSL2mQ1mwQC5
 uVdBl65a7PEMT7ea3pqp1yq5lY9LWxvR2EnW1TLEUpZuVC8v5+mdnUilcSjcNU/tLbkE
 VFQA==
X-Gm-Message-State: AOAM531L48Snid/CTqsVDabUHLEOSjdpDEUIsPPs2rqO+ElxwkjMQpCI
 z4i3BlZMaemZT+SUd2M5DsbeNYK7yfFhCiTj9wk=
X-Google-Smtp-Source: ABdhPJxZx/OeEvTmIYzGl25AD13iihRSWkEsRRkJFCZu6VT1ac53IMKaMb73pibS8ZgvuxR+T8WlRHVET3gEe+9VeaY=
X-Received: by 2002:a17:906:4e16:: with SMTP id
 z22mr1182161eju.527.1602140523901; 
 Thu, 08 Oct 2020 00:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201007220255.1170167-1-ehabkost@redhat.com>
In-Reply-To: <20201007220255.1170167-1-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 8 Oct 2020 11:01:52 +0400
Message-ID: <CAJ+F1C+G-oU9qQMUFKqQqWxPqvA2k_qSJnYcYCPMu=Y8T+Hw5A@mail.gmail.com>
Subject: Re: [PATCH] qom: Fix "typddef" typo
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ceb96405b12368ce"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x642.google.com
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
Cc: qemu trival <qemu-trivial@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ceb96405b12368ce
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2020 at 2:04 AM Eduardo Habkost <ehabkost@redhat.com> wrote:

> Fix typo introduced in the C11 #ifdef for qemu_max_align_t.  It
> never caused any problems because we always compile using
> -std=3Dgnu99.
>
> Fixes: 4c880f363e9e ("qom: Allow objects to be allocated with increased
> alignment")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qom/object.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qom/object.c b/qom/object.c
> index c335dce7e4..125dabd28b 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -692,7 +692,7 @@ static void object_finalize(void *data)
>
>  /* Find the minimum alignment guaranteed by the system malloc. */
>  #if __STDC_VERSION__ >=3D 201112L
> -typddef max_align_t qemu_max_align_t;
> +typedef max_align_t qemu_max_align_t;
>  #else
>  typedef union {
>      long l;
> --
> 2.26.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ceb96405b12368ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 8, 2020 at 2:04 AM Eduard=
o Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fix=
 typo introduced in the C11 #ifdef for qemu_max_align_t.=C2=A0 It<br>
never caused any problems because we always compile using<br>
-std=3Dgnu99.<br>
<br>
Fixes: 4c880f363e9e (&quot;qom: Allow objects to be allocated with increase=
d alignment&quot;)<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qom/object.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/qom/object.c b/qom/object.c<br>
index c335dce7e4..125dabd28b 100644<br>
--- a/qom/object.c<br>
+++ b/qom/object.c<br>
@@ -692,7 +692,7 @@ static void object_finalize(void *data)<br>
<br>
=C2=A0/* Find the minimum alignment guaranteed by the system malloc. */<br>
=C2=A0#if __STDC_VERSION__ &gt;=3D 201112L<br>
-typddef max_align_t qemu_max_align_t;<br>
+typedef max_align_t qemu_max_align_t;<br>
=C2=A0#else<br>
=C2=A0typedef union {<br>
=C2=A0 =C2=A0 =C2=A0long l;<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ceb96405b12368ce--

