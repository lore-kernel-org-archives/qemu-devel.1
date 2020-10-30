Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D270C56202
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D3120719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbjQ7zN8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D3120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPG8-0000gi-Mh
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPEb-00084M-Nx
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:54:05 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:36217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPEY-0004B8-4O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:54:04 -0400
Received: by mail-ed1-x531.google.com with SMTP id l16so5673382eds.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=90pFzOxked17m4c8ghFksVGytoeYjHBIezpyvRFjWYw=;
 b=sbjQ7zN8w5rk9mBUXi7Wc+9xzcGXM6gwWCRAj8GEnCzpqh+Ykb/QunIhoFxrsuSTHH
 s2xv1Pex6D6LlAKSV6WI2/3E+rUND9rRi6Ey3cnulL7tiv30es8BldVB9g9hxEmiLl09
 OSq5eDkrGWiWTsRZEGwng3lQIStjHopEN4gddUroiUzDXR729yvTnQcL3sC+er9TjZVw
 kuG1tAqvZPGq/gtvlWZJOt7PZ5H3tq15MGjMMwSLQoe+z/BpStTzfjZT6NLVLpyTC1uj
 v9r6O+WL44KD6cXZHTraJBBI8F1tvg/g/2fFXT/mO9rV+ERwOxdob2+cqAxwOy0twDx/
 YsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=90pFzOxked17m4c8ghFksVGytoeYjHBIezpyvRFjWYw=;
 b=IelYfPjWGqng01ByIUWy5L55PmP0X9pINyK8LBaiQk+lGRgI3tIaAm/wTJva6lGh1L
 G6LRBjIj4r8dytIhOOo8rVSNW/PCRB+kSFpnoHzvMK/gDXTMpaRYd/5OJ3Unru+03FU/
 TjYnjA7hXOwRzMh/WZzN9R1W5BCWonKEKjRZEFb11J+snrGoz+n1mYfhnC74S8VR0C3N
 jPZIbIf71kts5NclbJi5oQ0VOGqemZ85opGAi53fqMbp+pDV1Flp8gzCDKcqxPHywbny
 vIq6eK+GIYKBE5Om342vdnJA2k/GcKEpgenNkM3pbfz/qORAWv3+0qXX85sRBI/Tm4dM
 +2nw==
X-Gm-Message-State: AOAM530rB3dk3t9cazRXBVi58NwIlaOQHg7qzKqjeM4kwYTKaoHl0H+8
 SZqbLvykPhVLhg/EGPqasciCag0N2Feag/NM0PM=
X-Google-Smtp-Source: ABdhPJwU288691E+OJmChaA0dNvZA+ZWRPRbbr0HxPcvyG+bvOqDR2inM6p9usMGN1OH7XOSBiigpc1F7XpsCNHGhNY=
X-Received: by 2002:a05:6402:195:: with SMTP id
 r21mr959954edv.164.1604044440383; 
 Fri, 30 Oct 2020 00:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-12-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-12-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:53:48 +0400
Message-ID: <CAJ+F1C+Ofu+i4C8dEiAuHbxFikBibQiLM8YkT82c+O7nrGs_ng@mail.gmail.com>
Subject: Re: [PATCH 11/36] qdev: Make check_prop_still_unset() get Object*
 argument
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000012be0105b2deb3e8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x531.google.com
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

--00000000000012be0105b2deb3e8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:14 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Make the code more generic and not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--00000000000012be0105b2deb3e8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:14 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ma=
ke the code more generic and not specific to TYPE_DEVICE.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>=C2=A0Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; <br></div></div=
><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Ma=
rc-Andr=C3=A9 Lureau<br></div></div>

--00000000000012be0105b2deb3e8--

