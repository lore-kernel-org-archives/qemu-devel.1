Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20495C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607DA22203
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GllMPY4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607DA22203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPAp-0004uZ-9n
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:50:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP4K-0007fA-D1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:43:28 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:43867)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP4I-0000d6-27
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:43:27 -0400
Received: by mail-ej1-x631.google.com with SMTP id k3so7239394ejj.10
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GSUmSuJ8jwSFu6C25+i7zFauwOA0PmlgaUYnnAEihi8=;
 b=GllMPY4fXTsdCe4SHM+8Ll3HfndQd+Tfr7ihT53m47DuvpFVsF4L5vJNeJTVZpE0MW
 p2PggC2YksYvzKbM2MeWoIEvFj8lOMPgcJ0q4zs7oOwUceiUncydVIhRKXX26U0O1GvN
 F11E0wICHvCOV2brntgVXzK+A49XhNl/HaLsDPY4EkYreKrVNcfi2iMoLcdduchDacTE
 l1ekI63fQrfl9LUoDJy1IHKYBsdMsjGTcuYRrgi6V7iCu0c2e9uhkxF2/G+6ksLjYlMY
 HQPEzPWIuU6NnKXP9GRJKawNBM8oprs/lOj7JvBvRQ8MfL71s2UiT2lzP5Ey7zN8A/rY
 Ig3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GSUmSuJ8jwSFu6C25+i7zFauwOA0PmlgaUYnnAEihi8=;
 b=WqrQYAVybEoVFkQX0NWFGlmwaO3PCQdOvhSFJ8JAFiujUOCldiJMHbpZ8uq+7v9OTp
 CbSfSzPJpa+ivDG61sqCo+fjrvhhLEblUrvKxNpCxBFewxauMq9Vv8e5LiQ92wFiqTPA
 hFLyGp3lPAwRZRyVVy34+nAVNDbiJoUr8dWVdnxG3y1Y7nfKJXy97FXhWsbjzIGx9JMg
 PMcbUSevpr8HBqueF+T0tndcqBGz1y7dvupax9K7ZWSq/yNAJdAzt9BsuuTlONeMu+6a
 KAyfAlXn6R0ILiNYggqmFK9AZksXFl2Lzfqye0Q1AtvTnNB1mt4htey2qbZVh3Vm64hY
 Caig==
X-Gm-Message-State: AOAM530REpjGNYBXdOgY2y4HEUFMb+hJzqNDcVTlS8pNqyUfA9MvbRAE
 tbXWCj88BpECDNUbqkaSXqNxZbsREJmOnXQZLWWBCbHu6v4=
X-Google-Smtp-Source: ABdhPJzgSL+qV12VzQKfVr0uTpmd5MPYvzwQlhdYHZT5SpIZMgY6qp6ckYiXh1DTvdJHq+MBdBo0wZlYcSrJ0vncwk4=
X-Received: by 2002:a17:906:af47:: with SMTP id
 ly7mr1277068ejb.532.1604043804775; 
 Fri, 30 Oct 2020 00:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-8-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-8-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:43:12 +0400
Message-ID: <CAJ+F1C+3eY7smh1N2mC+UqEfZ2=eyK-Q_fLVGRSOxowuQsT-VQ@mail.gmail.com>
Subject: Re: [PATCH 07/36] qdev: Make PropertyInfo.print method get Object*
 argument
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000003017e405b2de8de0"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x631.google.com
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

--0000000000003017e405b2de8de0
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

--0000000000003017e405b2de8de0
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
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br clear=3D"all"></div><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lurea=
u<br></div></div>

--0000000000003017e405b2de8de0--

