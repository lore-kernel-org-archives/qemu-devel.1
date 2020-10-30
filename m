Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FBDC00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:04:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88F732075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tTK6GLnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88F732075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXoy-0008Ld-9M
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXnK-0007rp-E9
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:02:30 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:37354)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXnI-0005cX-Jn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 13:02:30 -0400
Received: by mail-ej1-x642.google.com with SMTP id p9so9582258eji.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NDw2hbOXQxpFtccsuIDcRcZrdQIJDRNcsj9xXfd8Iqc=;
 b=tTK6GLnLgJGrjhlSdrf+BqGh5J9ql064Df94sHJxVjFEH3IeF5RidrO6MqiQVISfTX
 hbrjK4FqrLL+6qXr6BjS5fnaYbhTbw2V04kaHAfGT9gjrYD+Y9+QRfl9Rnm7/QXJal9C
 DWngGwnDiz+iFdW2mw2U4rXr72Hwt4itUWyJxstP81w2eTZOdRXZ89haWEkHhDrFS7qJ
 Vl/C/TFwPZB2io9xzJInT3oa2PPrBgufKTe+uqlZi1hCGuSBup7w+WCw85VPftsmS07+
 idekswbs86Cek7+/Rw+ODTKpWv0MszWj1aDIC+np1FWocqXVDNbpAW1q84UvdhQuXL3S
 PkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NDw2hbOXQxpFtccsuIDcRcZrdQIJDRNcsj9xXfd8Iqc=;
 b=tu34YSHI9WJqtVyyEX/PB1EiszCkln2JSw2HaYp8HMtklvuGBc+1ASGDCKCo/055Mk
 VReZOgM7+L13nrXZ+ibVza6LiKuo5qnWbIG0v2ZQ4hNcF9BTLIaVGyCiPytRWdr83a4t
 PS8BxhTtZZmJKy6PHROTW6sQBa0x7cck2vHbYER0Sl2/8c5AGrwakrDyS+mbWeB4IirM
 YcWKfipDFYLkln/UP6rEQAMebx+mRcXeSVfIAjRQHgauyhs/1mzvILe68+vtHfkrld0P
 E40cBPu827gAJNrwkU5Y8Og3nQTpSK5SVZ4HioRfaKyd3yrybEsGRK/R9mU/+mKQu56e
 0MAg==
X-Gm-Message-State: AOAM530tNfgfp8JDxRHcJTyNAS6R1AdYbIMr5Wg6BRy+ib/ut+o9UfJB
 zwzj30o4pZ4S9X9eWnfOLp0sSl4t8Ejj9UdYwhbtLrOhCQWsbg==
X-Google-Smtp-Source: ABdhPJzL1GVjGweMO5vE9M82xBB3jg57ocxd+1QGiy3nRKh1qGm8joGETb4CTjJj9jXTA+AlYOXDTmrUNRbEWNgT5Vg=
X-Received: by 2002:a17:906:2798:: with SMTP id
 j24mr3353378ejc.109.1604077347111; 
 Fri, 30 Oct 2020 10:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-30-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-30-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 21:02:15 +0400
Message-ID: <CAJ+F1C+NBOXgo8=cEjoJbJ145NoUr93SEp-Y4L1GcyjsG7E-cw@mail.gmail.com>
Subject: Re: [PATCH 29/36] qdev: Move qdev_prop_tpm declaration to tpm_prop.h
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007788ed05b2e65c2c"
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000007788ed05b2e65c2c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:24 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Move the variable declaration close to the macro that uses it.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/tpm/tpm_prop.h            | 2 ++
>  include/hw/qdev-properties.h | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h
> index 85e1ae5718..871af584b7 100644
> --- a/hw/tpm/tpm_prop.h
> +++ b/hw/tpm/tpm_prop.h
> @@ -25,6 +25,8 @@
>  #include "sysemu/tpm_backend.h"
>  #include "hw/qdev-properties.h"
>
> +extern const PropertyInfo qdev_prop_tpm;
> +
>  #define DEFINE_PROP_TPMBE(_n, _s, _f)                     \
>      DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)
>
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index e1ef466790..2b00a1bcf6 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_uint64;
>  extern const PropertyInfo qdev_prop_int64;
>  extern const PropertyInfo qdev_prop_size;
>  extern const PropertyInfo qdev_prop_string;
> -extern const PropertyInfo qdev_prop_tpm;
>  extern const PropertyInfo qdev_prop_on_off_auto;
>  extern const PropertyInfo qdev_prop_size32;
>  extern const PropertyInfo qdev_prop_uuid;
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007788ed05b2e65c2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:24 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Mo=
ve the variable declaration close to the macro that uses it.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
;</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: Stefan Berger &lt;<a href=3D"mailto:stefanb@linux.vnet.ibm.com" target=
=3D"_blank">stefanb@linux.vnet.ibm.com</a>&gt;<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/tpm/tpm_prop.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 ++<br>
=C2=A0include/hw/qdev-properties.h | 1 -<br>
=C2=A02 files changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/hw/tpm/tpm_prop.h b/hw/tpm/tpm_prop.h<br>
index 85e1ae5718..871af584b7 100644<br>
--- a/hw/tpm/tpm_prop.h<br>
+++ b/hw/tpm/tpm_prop.h<br>
@@ -25,6 +25,8 @@<br>
=C2=A0#include &quot;sysemu/tpm_backend.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
<br>
+extern const PropertyInfo qdev_prop_tpm;<br>
+<br>
=C2=A0#define DEFINE_PROP_TPMBE(_n, _s, _f)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP(_n, _s, _f, qdev_prop_tpm, TPMBackend *)<br=
>
<br>
diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h<br=
>
index e1ef466790..2b00a1bcf6 100644<br>
--- a/include/hw/qdev-properties.h<br>
+++ b/include/hw/qdev-properties.h<br>
@@ -18,7 +18,6 @@ extern const PropertyInfo qdev_prop_uint64;<br>
=C2=A0extern const PropertyInfo qdev_prop_int64;<br>
=C2=A0extern const PropertyInfo qdev_prop_size;<br>
=C2=A0extern const PropertyInfo qdev_prop_string;<br>
-extern const PropertyInfo qdev_prop_tpm;<br>
=C2=A0extern const PropertyInfo qdev_prop_on_off_auto;<br>
=C2=A0extern const PropertyInfo qdev_prop_size32;<br>
=C2=A0extern const PropertyInfo qdev_prop_uuid;<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000007788ed05b2e65c2c--

