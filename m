Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB38C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:45:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B80620719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+qFRXlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B80620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYP6Y-0000sG-NK
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3h-0007Jx-MZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:40952)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3g-0000Nj-6z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:49 -0400
Received: by mail-ed1-x52d.google.com with SMTP id p93so5602373edd.7
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lkzrzNC9uo1Ei1wQFhfc46awGpfP9sF5bbRLJW+JhCk=;
 b=k+qFRXlVBaYTZIvAzgVbPop4T61xsgP+wKmeRTIgevSGhxngDf80m+/w//NX8wX4AB
 anjownn/IZA4YqaaZScCpk0lHAkDjPiY+bU7mg+ySt0agw60qeUpbb00+tjctQMaMbFG
 2u2c+Ce3wzwoCA+65DWgUDCuKbPPeJ727jXLIR1n/o7wnP5THdAXk6voTgcVj4z29brN
 px0SecxARA7KloqPauUZ2qVgjE+w0gAaO7IsnJqfRcA/BvDvAhQ3l/Yv2aztJgHpMJPp
 dH4nWGLyOHS0Un0lVzqe+RpW4EV0or25IesxGpTwmYI2PHja+qj9Gqifmu9Vm5I9a4qs
 5eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lkzrzNC9uo1Ei1wQFhfc46awGpfP9sF5bbRLJW+JhCk=;
 b=ARMRsqtQlmmJoV5VC6QGFfpTueXLbu/3pjXIb2SyYuXsrcD6sjz+MVNZtbSKKe8kLb
 GQbCZGg7A5LrJ7MNHSAj0DxPEIj+OmgmJkGP7rQdvhYSnNtnLTcy/NcRlTiiyDXFYFVd
 eJ/dRrM5uPyZjICbc7rENhgy8t4a67nzxe6117gOedx1fTrz+VuVy/98uDFjPsGiQ8OG
 oEPY5Lvqmd0UNjaiaiLvBbYd94RS6Nau9CSCA78eeXgfEwtlGhsvM9ZRBZ8bBhXJkXxk
 graq6liqb6uSSInQdJSEa/jYzNF2Cyez1erJe4Yi3/WbKuJ+edYSlvPw6D9O98F/pzWV
 hiWQ==
X-Gm-Message-State: AOAM531xfRsHakq4IcwpnssxXpMlXx2livkLdhXRCC4T8IiqksONPWUi
 ftRt9UuKFC1gc+KU+sJ1W9Gczs+sZKeZ3dxAORY=
X-Google-Smtp-Source: ABdhPJwcZ6qPSs6gVcvVg85BFwVxIcXqBtblF/jq4yfRkR4EEFkdFUNmmWEqinSK1300N3ZeDxqtoKPsheDJX9Hg87I=
X-Received: by 2002:a05:6402:6ca:: with SMTP id
 n10mr954495edy.314.1604043766822; 
 Fri, 30 Oct 2020 00:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-4-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-4-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:42:33 +0400
Message-ID: <CAJ+F1CLWo2OYjgQVRY9W-U8c8CxWW63JoiU+p4-0eT2kgp5yKQ@mail.gmail.com>
Subject: Re: [PATCH 03/36] qdev: Move property code to qdev-properties.[ch]
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ecfca805b2de8a09"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52d.google.com
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

--000000000000ecfca805b2de8a09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:05 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Move everything related to Property and PropertyInfo to
> qdev-properties.[ch] to make it easier to refactor that code.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000ecfca805b2de8a09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:05 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Move everything related to Property and PropertyInfo to<br>
qdev-properties.[ch] to make it easier to refactor that code.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br></div>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000ecfca805b2de8a09--

