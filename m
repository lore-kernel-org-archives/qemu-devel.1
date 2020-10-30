Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30409C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:43:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550CC20719
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbeVnuzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550CC20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYP4R-0007Wp-QY
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3T-00077I-Ka
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:35 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:32836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3S-0000Ix-5z
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:35 -0400
Received: by mail-ed1-x530.google.com with SMTP id v4so5657476edi.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hAoiKb6WvcquzLSSUlQCgvX/1s5C03CsIZFf+ozhYc4=;
 b=AbeVnuzGCtZGOKubR2Q7Bjq1jX2/jukvzW4uRt8iRDtEAia1E8E3dCcydUAfbLezC9
 wiiWCIXy+TlC1pBW12LcV0ZTO7wZyBKL9AnJrMyn3KPTu1bfcEg+bqdgp47Qi9AUtOVP
 2YbYh+H5Wz3pGBs5Ughiv02vokHb0HjKMaaxSSx/+OY48pFemWYptY0ytcoahCVb9GHj
 Rc4Ja+80RmVHeNOlicD6E4s6BPKG03lVur43tsNCv4IjD0li31ZYyY4D1NV436gdk8Xg
 aRDWLccLwI9QEK4Tevm2w4Lfauotr5aK9OkMIfzhni8DX6wwxBMRTitx04MluA/8PYUw
 ZzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hAoiKb6WvcquzLSSUlQCgvX/1s5C03CsIZFf+ozhYc4=;
 b=saoFdhfSxIGNtNE3bYFdD+HrdqoJNSDhp4vERY2JfzgxhtyREfXCehuJ2acWe4zIl2
 PqTwRlDln8SgZIR6uqELV8jVDZ9UwGATMyi0WjFPZPUUUCG9ouHB03uqxJr39edHUUyF
 UAPIfJjJpmOP/9EX/jDzqhOwmABRa0DCO/5J7h2Tm+kEbO8vilXY4kQnPe1bvbnhQmeL
 yN+nKqO5ZGciFOILBjLNiYql5vGFsrU4nnmXy5IPia46dukRx/irDWzXkTiakGbWY4of
 y8bpZ/6Iie+afgFLWnHHU7WrZEt/e6VvZoUubVqjTplp6LjxPzyMpS1Lhq3GQq59Eyst
 ZgvA==
X-Gm-Message-State: AOAM530XpQU+HT0OWoCt+vI8FOQJOHLr2CfO938M4MQWJKNh0jzzJ9hS
 odYS057ivnMgG/8UvB2bxGw3NyFCfBzSrLw/6Vs=
X-Google-Smtp-Source: ABdhPJyS0tkCknYX0tL3ItYS1yqIx7ndAb2To58lKW0Q4sQG/IwCxcWkP24ywSt5JXmbLJE7GX+RTI9gF6tv49QsCTw=
X-Received: by 2002:a50:a441:: with SMTP id v1mr948803edb.30.1604043752381;
 Fri, 30 Oct 2020 00:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-2-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-2-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:42:20 +0400
Message-ID: <CAJ+F1CLpGLriqf3Li7fPjOEZ3yHfNELJn0zSkqDTRB=WRts8Cw@mail.gmail.com>
Subject: Re: [PATCH 01/36] cs4231: Get rid of empty property array
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000010a62105b2de8a27"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x530.google.com
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
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000010a62105b2de8a27
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:05 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> An empty props array is unnecessary, we can just not call
> device_class_set_props().
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

--00000000000010a62105b2de8a27
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:05 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">An empty props array is unnecessary, we can just not call<b=
r>
device_class_set_props().<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 L=
ureau<br></div></div>

--00000000000010a62105b2de8a27--

