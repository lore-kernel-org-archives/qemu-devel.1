Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708CCC5DF9D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:44:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7CCA20719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldH8rVqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CCA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYP56-0008QB-Ga
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP40-0007X7-UW
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:43:08 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:45332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3z-0000UV-Ii
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:43:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id dk16so6683675ejb.12
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ce6CmTKEtb7rZhZ4T68foPmpS0FQlP1jmDULP3/uI9o=;
 b=ldH8rVqUdKh85n+CUrgjbZs7ZXE7oWqybP5qpm7HrqltG/4SCQ0H+035TTVP6hdfuy
 K8deHIibj7DSRuxEYZUniNtU9/LM7ZyT61ZHxgigrDIcOgen/0/4PV21mqjWFQ2b/jwY
 rP9uI70OCPggjyGzbTFziKlc7ODpRyPYK9izx2xzlNAjI0jOrNMN7ft1TspZnVoEZXz5
 Yo12jacs+EbamkgodyBKDGfaoznyHkfu3F0T2CWpacLqEDC+jzm9qUmNJgXhCetWP/aY
 AJpqL34DKb9Ssb3Rripmfd8ZU4K9Ywa4eNVlCzMnzz7OYMyvaS0joHRK03qwOrJJiRLI
 EWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ce6CmTKEtb7rZhZ4T68foPmpS0FQlP1jmDULP3/uI9o=;
 b=NSSL0lW8TkWNrMRPKxzZoy49+xj6qq2l88tP2xFFxUMTY0EK/IYg8w8M60K8buiJtU
 FHMXOO1FGJGQxH1I4bingP8ajFwJihbTGVBDfp35zLQ3yWeLFfQ00UrlaWDtVNGlq0NB
 /xycJtXIKNuPT1KHuGMabxT+QbsL+iBHziwc+6daQFYGy0gEEq5DSHScpFUKzaLDkib+
 ARouYEMj68dXk+N2YprigFMdj01Lg3goK8LT2EoOjfD7NzomK2OGif44zKHq9ofwA7Tp
 CdFA3wv4h3vtXkaSU3ziFfgu2+55W0R1R2boSXolE/Q8oxu/on/ZKgBfdtsINWoxk/I7
 8tgg==
X-Gm-Message-State: AOAM530YXgJ5P5T2tw2HedVKf1ZPOYsyRZI0ur61IOEj7rBFnsIsU/uc
 sMTe1BheeOZlfGMS9N5IGoUo0TX3dpLWhRulDng=
X-Google-Smtp-Source: ABdhPJzirUyWvXRD8bhL9/Z9YXICt3cWox+OcKZfsA9YvE+YnPQ/w9VwbTzWiAIuutg3AsLMkamOGa6/Vy5xjVE3AYM=
X-Received: by 2002:a17:906:4e16:: with SMTP id
 z22mr1153444eju.527.1604043786234; 
 Fri, 30 Oct 2020 00:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-3-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-3-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:42:52 +0400
Message-ID: <CAJ+F1CLKpSGLY+zCdbuQSEbYLfs_L1RK8MpO0YzFLh1FHSw66A@mail.gmail.com>
Subject: Re: [PATCH 02/36] cpu: Move cpu_common_props to hw/core/cpu.c
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000015307105b2de8c29"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62d.google.com
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

--00000000000015307105b2de8c29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:07 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> There's no reason to keep the property list separate from the CPU
> class code.  Move the variable to hw/core/cpu.c and make it
> static.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000015307105b2de8c29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:07 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">There&#39;s no reason to keep the property list separate fr=
om the CPU<br>
class code.=C2=A0 Move the variable to hw/core/cpu.c and make it<br>
static.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br clear=3D"all"></div><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lurea=
u<br></div></div>

--00000000000015307105b2de8c29--

