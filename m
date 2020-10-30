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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F66C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73B0320723
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcNd2MaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73B0320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYOaL-0003iE-LU
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYOZS-0003Hr-Su
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:11:34 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYOZR-0005QW-6M
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:11:34 -0400
Received: by mail-ed1-x541.google.com with SMTP id w25so5581974edx.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YmYiCfqvU+kswp/vWc7dm7rU4EoXrGat4AFHiQrJg5s=;
 b=rcNd2MaQTQI2QsbU9oR1dlG5+p4lbAAXB+oAt3BdEKgMKY5W9f5qY7n5VdOjYIZ80N
 DnWCXNUUBJpBLZmPqnAliXoEQFXTA/hfzmE4xWDSswxvjI3GEV1713iGelb5GOnsu9Ev
 1JJO/da1kNxRNE6jg0tBX96hFAT6gnjNPlgVWaupkAKnqeowWTFv6pwHD7LjINntksUD
 wTm16CL3lIt9itRCY034rvvFEsbI21bpTj7OnLSLcUd7bwnhYM6cMhiFC+k/5wPxJZca
 032tLkFvGpkAfOYdm03KXW+2TfveqxIK6P7DTbj11Hpp0z6XqRfn8VW+3tSR/CvlubF6
 vhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YmYiCfqvU+kswp/vWc7dm7rU4EoXrGat4AFHiQrJg5s=;
 b=QyyzEuc/nk+ZmeyRwsDRm6QEWUgv1Rhv/M6pPbNTktESaw4Xbq1MO0AXsM158L1sjI
 A2j6hOjSH1Tu3fF0xEk3tx6hTFAoi1pmPaIWal8JEW6FRfX3iJqfNQ4MQ6b7nW/BfgOx
 91LigoBjYQFsnTQsHaEnJfDw/J9T71CU8DesB4tBcouJyhPysDhgedHS3UbG5kloe7EP
 pBigkwkMVEoskxSc3lNRJwAhdk20NHeuOU2qDM08egB2SnrGtrnKAek77WngceoWE7kl
 +fUnYOEumKyvM+8Ze0Zx3rcCAWqoYuxsbcGuTTxAz6E6uLp9WZmlPjGVDDxeoZ4ciOO7
 RMCA==
X-Gm-Message-State: AOAM532l2g3Sq44aRjXDHeihCXOAMtCk0Sz5Z0/lXMKo7ozfZT/06xez
 FnkskcSx7tKcWNIKARz3BLHcHp1Jscp+2MLYfYg=
X-Google-Smtp-Source: ABdhPJxh5po7hXLAb0r6ztG+3eWwal37NOmdFChwLS7MuBIGQyhHKLdsog3FLIdO7wnItc4O7dpuzPvhwe+1hWyRkc0=
X-Received: by 2002:aa7:cd56:: with SMTP id v22mr511615edw.245.1604041891729; 
 Fri, 30 Oct 2020 00:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-5-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-5-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:11:19 +0400
Message-ID: <CAJ+F1CL3CGLv=AYSq3Gpun2KfXv3iqYVsj15gObkqaJt+Gno8g@mail.gmail.com>
Subject: Re: [PATCH 04/36] qdev: Check dev->realized at set_size()
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002955f105b2de1b6d"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002955f105b2de1b6d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:06 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> This setter is one of the very few property setters that don't
> check dev->realized, and there's no reason to make size
> properties different from the rest.  Add the missing check.
>
> Fixes: e8cd45c78f53 ("qdev: Add SIZE type to qdev properties")
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Suitable for 5.2 imho (you should send/pr separately)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrang=C3=A9" <berrange@redhat.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/core/qdev-properties.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
> index 12a053e732..67ae19df05 100644
> --- a/hw/core/qdev-properties.c
> +++ b/hw/core/qdev-properties.c
> @@ -905,6 +905,11 @@ static void set_size(Object *obj, Visitor *v, const
> char *name, void *opaque,
>      Property *prop =3D opaque;
>      uint64_t *ptr =3D qdev_get_prop_ptr(dev, prop);
>
> +    if (dev->realized) {
> +        qdev_prop_set_after_realize(dev, name, errp);
> +        return;
> +    }
> +
>      visit_type_size(v, name, ptr, errp);
>  }
>
> --
> 2.28.0
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002955f105b2de1b6d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:06 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
is setter is one of the very few property setters that don&#39;t<br>
check dev-&gt;realized, and there&#39;s no reason to make size<br>
properties different from the rest.=C2=A0 Add the missing check.<br>
<br>
Fixes: e8cd45c78f53 (&quot;qdev: Add SIZE type to qdev properties&quot;)<br=
>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Suitable for 5.2 imho (you should send/pr separately)<br></div><div><=
br></div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:mar=
candre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
Cc: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_bla=
nk">pbonzini@redhat.com</a>&gt;<br>
Cc: &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:berrange@redh=
at.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
Cc: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_b=
lank">ehabkost@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-devel@n=
ongnu.org</a><br>
---<br>
=C2=A0hw/core/qdev-properties.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c<br>
index 12a053e732..67ae19df05 100644<br>
--- a/hw/core/qdev-properties.c<br>
+++ b/hw/core/qdev-properties.c<br>
@@ -905,6 +905,11 @@ static void set_size(Object *obj, Visitor *v, const ch=
ar *name, void *opaque,<br>
=C2=A0 =C2=A0 =C2=A0Property *prop =3D opaque;<br>
=C2=A0 =C2=A0 =C2=A0uint64_t *ptr =3D qdev_get_prop_ptr(dev, prop);<br>
<br>
+=C2=A0 =C2=A0 if (dev-&gt;realized) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_after_realize(dev, name, errp);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0visit_type_size(v, name, ptr, errp);<br>
=C2=A0}<br>
<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--0000000000002955f105b2de1b6d--

