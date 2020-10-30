Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88008C55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42B7A2075E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l56CqvOB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B7A2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYXlu-00074E-V1
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 13:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXkP-0006K1-Vv
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:59:30 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:33488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYXkM-000554-WE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 12:59:29 -0400
Received: by mail-ed1-x531.google.com with SMTP id v4so7422539edi.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+nUevLMuBuE4Dr6kJQfCYMRUdDVbF2xnXlT/aw5G85c=;
 b=l56CqvOBXd0okP+rcGuiegA6MgVmcjqhRFfbJ9+HuxAuyaSeuqca8yJ/rfj7icFym0
 OV+KssEqJBiXp2xBi2wooexmRW/Pm4pqjHpiWNPX1eO703VsZAr/M8MrmKcjTanh+w5r
 YVzLNJA35qw6RvboMVKxvqf9SaICgHM3+863h9JjUatlNWwUkrFkkXGAQZtcnbmPje+6
 ptAzxRAAVbu5SrW8PRlRowAl8nckINqzAW//JlkwmnIcsVmVqA8slMpzm0eQG8AEG1DM
 myAsxnu6oS5/aUFHQqzk6n0j4ss9swkpD7kp4Je9cp1okPr530kOnhCXin7jwMz0y4um
 H96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+nUevLMuBuE4Dr6kJQfCYMRUdDVbF2xnXlT/aw5G85c=;
 b=KbBn6nQhWy1mKT/KfWHxvR30BnltZoE3hAeypOFqiymxV3FDm9YVRgj/d6FkSXoZJy
 oqUPx9uFBz+xhcGdrue2YpSWXzGFlcZHULX1TEEeAqMW0bjiiBv+EDfcCtQLeY0Zy9BY
 NXZ7S3TOxlTzGFuApk7v5SQ5UvWdiXdUmONEvtd09bqWiMU5Ztw7hRgJj34FUnSRb/o6
 4SgQAAGgFXOxSWHIm7KNY0d7P5RkzfLwt3EPNJybSWydbfoBIESguvWQ1hM2Y1js4K3H
 Nl12E556ExKhCgcCcJh8Gf1Co8giOjU00HBmZ7l9RqCNwAjPKzpdivbUSlrtFgcZoxo3
 y5zA==
X-Gm-Message-State: AOAM530L7fV5BXB2jFe+RZVEvu66w/e+aBaN+htuVB53DvYjukp3V/Ex
 fEVmnualIAPZpCd4N7jH3AHcDmm0xzUwZ+hAwjc=
X-Google-Smtp-Source: ABdhPJwuX552Gd9JQ6Ps7ZNZAYLy/EvimfP0gs5A5jxS1wtLL/jBvqdwUFssZxew1g05tMdyPDCoo76drvAd5wfjs14=
X-Received: by 2002:aa7:dd42:: with SMTP id o2mr3421362edw.53.1604077165408;
 Fri, 30 Oct 2020 09:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-29-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-29-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 20:59:13 +0400
Message-ID: <CAJ+F1CKOGctJEypW=SDNeJFgXHhdHRbkbYi3b6U3zTSSazViKg@mail.gmail.com>
Subject: Re: [PATCH 28/36] qdev: Move core static property code to QOM
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a2fa2605b2e6515b"
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

--000000000000a2fa2605b2e6515b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:17 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Move the core of the static property code to qom/static-property.c.
>
> The actual property type implementations are still in
> qdev-properties.c, they will be moved later.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>
>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>




--=20
Marc-Andr=C3=A9 Lureau

--000000000000a2fa2605b2e6515b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:17 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Mo=
ve the core of the static property code to qom/static-property.c.<br>
<br>
The actual property type implementations are still in<br>
qdev-properties.c, they will be moved later.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br><br></blockquote><div><br><=
/div><div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:ma=
rcandre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a=
>&gt;</div>=C2=A0</div><div>=C2=A0</div></div><br clear=3D"all"><br>-- <br>=
<div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div>=
</div>

--000000000000a2fa2605b2e6515b--

