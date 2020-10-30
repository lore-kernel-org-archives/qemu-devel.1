Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF8AC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8957922203
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eklf+1Sv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8957922203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYP9z-0003YQ-BE
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3r-0007P4-Af
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:59 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f]:46732)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP3o-0000Rd-SM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:42:58 -0400
Received: by mail-ed1-x52f.google.com with SMTP id t11so5550665edj.13
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p4myVGXuMAjJjzFCdX9E7RxvVmJX2D+/FE8AVOvevtw=;
 b=eklf+1Svz8V6zyWx5z4lvCqhIKHExwB8Mwz+X9BDqq9Xy3PEan59wQihYGmI8U4dBr
 A5J4AeBI7VFx4IaxzikBPmqIzyMM+Eqzu09BBhg3MEqYjIKo+U9WNpszY5HN5O/dmeIp
 /vQk2Xopj2Rxrlfs8y9fBP8pEybnH33GGp+TaDnK2OeJWgxuTz4DGeTh1U3BpJ0y+1IC
 nhVfByNZP3/eR+0LwEgCWE0etNRYAmKChmz4CWlrEuKt898pzBCSLJjQHZsF1dpUAIgg
 5+5EAYjwLXnRnLVO4hGIeK/2ZUCQPk5dIfC87VZg4u2qHXkKvcZo2IHng6t0U3OHzPf1
 Q9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p4myVGXuMAjJjzFCdX9E7RxvVmJX2D+/FE8AVOvevtw=;
 b=lIpqu4eAVu4TrKWXE7SPganW/r1oSvRAoevVXOD25inSH7kgMQn+tiUFDUqWR44N+V
 WXrqNjmNcjaBP6Zo5Y2emWiieKs3/Lh6CobnlQV/TGX0X/EMOnPb7BslGmeO+BpdPl1r
 j9Qtc8wpXjY56xIbC03cN4xMy0SHt5e9daxd0z6cuINucrfjWYL3g1BAIRs2FQI0h0a9
 ZqyZPGzu6xYcm2jbUClz26Yev+dBZANFff/xM8KJAmTbsNx0Uo7vBODF0FJbm+Q+NWvD
 C5NDtTD58o40l+kdn4n3JgOaIoZUWgQj1BCFXujI85horvy1TW8dPWInIdfx8v5d3eRV
 B1Ew==
X-Gm-Message-State: AOAM533qKSYdvOv0j1/EWdeyULeNYO806iLX+wbL4SKCn9Fd81QSz2yk
 sMDTGTg2d4qc6jM1oPoy3RqqQA5W+rgeVNbcpKZYd0AOrnU=
X-Google-Smtp-Source: ABdhPJyBWAHVciRyqjfvU9kEHgbQRQLpGoH/B1TAo13pWCDMyursen+xWoUty+/HQew6mNTZrtNSC88MfCqiodmuUx8=
X-Received: by 2002:aa7:dd42:: with SMTP id o2mr927549edw.53.1604043775100;
 Fri, 30 Oct 2020 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-7-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-7-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:42:42 +0400
Message-ID: <CAJ+F1CJJ=87U-zqScZdc=t+kdmckb5mhNT37OwZhnuho1SLjQg@mail.gmail.com>
Subject: Re: [PATCH 06/36] qdev: Don't use dev->id on set_size32() error
 message
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006b4d1705b2de8b19"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x52f.google.com
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

--0000000000006b4d1705b2de8b19
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:05 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> All other qdev property error messages use "<type>.<property>"
> instead of "<id>.<property>".  Change set_size32() for consistency,
> and to make the code not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

--0000000000006b4d1705b2de8b19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:05 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">All other qdev property error messages use &quot;&lt;type&g=
t;.&lt;property&gt;&quot;<br>
instead of &quot;&lt;id&gt;.&lt;property&gt;&quot;.=C2=A0 Change set_size32=
() for consistency,<br>
and to make the code not specific to TYPE_DEVICE.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 L=
ureau<br></div></div>

--0000000000006b4d1705b2de8b19--

