Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5711C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:49:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BB3B20725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 16:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWVKjCl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB3B20725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXaY-0005kx-41
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXUH-0006Ei-3x
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:42:49 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:37799)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXUF-000355-AH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:42:48 -0400
Received: by mail-ed1-x543.google.com with SMTP id o18so7346173edq.4
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6yYkPSmtTyZx4Tr/CmInbdlIjHzB+3zaylgHbwePlrE=;
 b=OWVKjCl2bDe8Ns8ptJY1ywc0gySD2qRZEyhi7JulPX/DeiegaT2SJWzjAp2m/at7Hj
 rAoIMpX4Xl5j5D4llox8XYfCpm1RSFd3j0BNOgYHGOLeIURHhCWVs6dTh7PIV2awNOkj
 qYQ0fVlDxuRC1YqJAqpahFHLsCdA0rYBlufSmJ4piabxF/2teeD/1+G6N47gHm05e2tg
 AqOCyo5OnJMsq7zgH8wGlacPRS8oH3U+ha3+k73jy24N5IpflJfIRlN8HZF3qp4ZiY0b
 M0JL7+yKBLWboWWRG4cJU798jXyyhXAk7gvobv9gpHz6DNNvi5YT74HtDZ8Zo/oLtTHm
 GF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6yYkPSmtTyZx4Tr/CmInbdlIjHzB+3zaylgHbwePlrE=;
 b=YhRIxje18zZkhAX2ETINMgwk4Sjqfmj4tQS3KDIxlqQ8FZfj9w5bsLdQLyxUjhO0rg
 weSs6DHTu5inZ+2t9+5d+5puQ4u5OiOpp59JPcgM0OzPYA0T0GIVkfq1pk9hK0KidEqz
 R4dSr5YWOch4Is5ginSl1662t3x42LbA50lXEVykzpJPyoD+MkF9ZBMYe/IMzqAcjQ8m
 7nFw+2QS2hLHU4E97IYAyHxpAb2wvnE8P/EG9855NNKqxiNmchfLTOJ1egWijTU8q9+/
 jPgrkPW3FbGEjtTcuzQZU1ENDft4nwAnoJY6/HldDVUAqVE1vcZ9vEgcHfbCXFTK4bp8
 Hqhw==
X-Gm-Message-State: AOAM531/pJ88rp1ctZmsufI6OrUes5AhY/GPANPh/ph+jl5fQFfhpHS3
 Ix1biorLeMo9ic7sh8JrDmaNzoVDPdJqUJUdjJs=
X-Google-Smtp-Source: ABdhPJwY36Y2LLPTeOgELwkLC3pugXbYsz86fpJTIWhi0sgxiBdR8rNxx0lg9GcrvGr3MwzlQ3Pn/hG/iYLlYgfOgKU=
X-Received: by 2002:a05:6402:6ca:: with SMTP id
 n10mr3411385edy.314.1604076164769; 
 Fri, 30 Oct 2020 09:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-23-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-23-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:42:32 +0400
Message-ID: <CAJ+F1CJGW3q=x4_DHxeSOuPaNdub6kHeb13WaFH-E_uMx_54LA@mail.gmail.com>
Subject: Re: [PATCH 22/36] qdev: Make qdev_prop_allow_set() a property
 allow_set callback
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fe6c0f05b2e615ed"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x543.google.com
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

--000000000000fe6c0f05b2e615ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:15 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> This removes the last remaining DeviceState-specific line of code
> inside qdev property registration code, and will allow us to make
> static properties a core QOM feature.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000fe6c0f05b2e615ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:15 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
is removes the last remaining DeviceState-specific line of code<br>
inside qdev property registration code, and will allow us to make<br>
static properties a core QOM feature.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
</blockquote></div><div><br></div><div><br></div><div>Reviewed-by: Marc-And=
r=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre=
.lureau@redhat.com</a>&gt;</div><br>-- <br><div dir=3D"ltr" class=3D"gmail_=
signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000fe6c0f05b2e615ed--

