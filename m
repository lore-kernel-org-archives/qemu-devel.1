Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC163C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DCFE221E2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BILCuQlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DCFE221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYP8J-0002Ms-Vl
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP68-000107-Vb
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:45:21 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:44629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP65-0001DL-I0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:45:20 -0400
Received: by mail-ej1-x632.google.com with SMTP id j24so7234124ejc.11
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T8HtrfaL/wRxenliszI/ARlAGwnPawe8alyY8rU6FGU=;
 b=BILCuQlTbK0CvU5khItqS03znCy+j7gegwdnlTMbnNZEHu5NDAfGLEcup14M3Oqrqe
 tYC+sKXLDA7/aF5eKeSgZx9q7elUfcjJhMmddMkuQNzNxGlspLvUPxVThy5eZ+5qfmo9
 z8VV1Ott4aestMXhlh73u+eXvgfs9sHnZxqiTgTjp6qTRWSD6260qGuq3SpWESp783MX
 n3YsmpfgzIq56VccbFo72NrMzHoD9pW5VDwQrNpltSLL5uWG49aLAWJjfpt4/sTWJZ1S
 7CEpkKK7UF8xqF9eNSdwhfPorikIimZ/6E9mcdqqBeVor3sd4CG+YS7GtWvirbmK5c85
 0vcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T8HtrfaL/wRxenliszI/ARlAGwnPawe8alyY8rU6FGU=;
 b=apJ0dgPQffWbGarJWqjul7poTj0IecuNSY1LvQmrb1sJBqnZTaLtDqnxCbL2MPXUDm
 P8slv4esNLQN2FZM2Bl4CfSLwYL7ezhd1Cf+zI1uAnzd5PGGobiFUlwIrqEQwQGFIXNP
 N0R0XmFC9C9tHT9hQ3LtfXvISbZ7T0i0aHxjUzbdW50FFXALimQzeiua1fnqrfb4wX0U
 QmQ1DmKPDn73ezOyQx21wAgPlBLH7C07hjhTD+Fw20NtfQmOf7/ANxP4b9VWKPG8aw3P
 HzCO3EGC1WuKrSpJLh2qrHBvDMvPfaTfzcM5ILp/NIvOSaXAqTNp1uFztWCahyBWxis9
 VK1Q==
X-Gm-Message-State: AOAM530e3cUxy2V1Ni6nC38/CZIAe4sdw5XfRqPkH/ECfSj9CnBdExE+
 Jw/EBL6BtnBo0EHnXvEO9cw1fVa9lmqpCDTkoAQAB9AQh6o=
X-Google-Smtp-Source: ABdhPJzumE+gG9vp1CXJ+yd4PuWSAgU15tybyuzdncYDXhzLPoYxrfWZy59P/uGVyMWTBz2qEncJ183gmUnCyijjFU8=
X-Received: by 2002:a17:906:388d:: with SMTP id
 q13mr1199245ejd.92.1604043915589; 
 Fri, 30 Oct 2020 00:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-11-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-11-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:45:03 +0400
Message-ID: <CAJ+F1CJ78nnvu+nRf6w9xyRRmbiD1eRPDCavEnds0qT3qq2dcg@mail.gmail.com>
Subject: Re: [PATCH 10/36] qdev: Make qdev_find_global_prop() get Object*
 argument
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cafe2205b2de9376"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x632.google.com
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

--000000000000cafe2205b2de9376
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:09 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Make the code more generic and not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

--000000000000cafe2205b2de9376
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:09 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Make the code more generic and not specific to TYPE_DEVICE.=
<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>=C2=A0Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marca=
ndre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&g=
t;</div><div> <br></div><br clear=3D"all"></div><br>-- <br><div dir=3D"ltr"=
>Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000cafe2205b2de9376--

