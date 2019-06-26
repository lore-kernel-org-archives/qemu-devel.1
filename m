Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3987C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91BF52080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 18:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvW0WKPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91BF52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgCKP-0000Il-P5
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 14:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38207)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgCHP-0006yR-1v
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:04:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgCHL-00083s-Kb
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 14:04:21 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36]:45071)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hgCHK-0007zt-A2; Wed, 26 Jun 2019 14:04:19 -0400
Received: by mail-io1-xd36.google.com with SMTP id e3so6988552ioc.12;
 Wed, 26 Jun 2019 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ov4PdTxMGoTpFE3f8bXEYa2hKdkYMV2/jyq6nZ6Ckqw=;
 b=jvW0WKPujqrD+o6NhWZKsCd7elc1KJB6RwxQTTj7NuqIjJC1c4cy+LZzuVKLWW5qqt
 AMxe5R23v9Jr7nca//RyAPfUegzi3ZQKwFhMd50DRQIDRqWTFg1SnIyO99M7xmzBhSNY
 LVK9GCOcWBX1LgcxUY4O5rF0i0jbxzB1ZoLvPqEtLbNLE2iS98R48+1uC76vL7oTHUDF
 i9cie6Nfc/GDAmUOhJNy9C/T98QmoN+8dmbRHBzE+xZg/0FpXlnd5gnS4yFZFnCCwnCX
 fbN5KFzUYLfGlVLXsY4psDlh56FAXvJxAy0K+SEqC8rkU0rpbu6mOZS3IRhiZUk+0V/U
 3vBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ov4PdTxMGoTpFE3f8bXEYa2hKdkYMV2/jyq6nZ6Ckqw=;
 b=FiMHOJDoh0kKxk+PDC2dNS0vBvkxwrKHbEcpqcGmi7cVjyHWjX4NCT+XPobAT2DJr1
 PCBBLEbkWEtSqJkXG3Oz4krfDMx7hc4boVh5AKASHztucabeoHLJ/VyQmUEkdnKzzjFw
 wNy9C4Pu0gg/Gbefn6yryrc5U5Y/vNtpHDy7q7ded4iiQzLpslk4ScD1pdi0OYqSyaz8
 hucqcM0Uv8Ks1wPEgepNgLmY4j26TH4F+MkmxQH2JUQB8r2JmGOVtNGbgREM1wBT+7hU
 57U8VTspepXZK6VLwcLz0+vPT1N1tLxmQgpQbvO8iFWiarXQLcY7c6Cb//7omgcIM/du
 cbGg==
X-Gm-Message-State: APjAAAUo6reGcA3MkC4/zvPqWnTONaIvJch1GQkd4Kpo6TxSRT11ebg3
 nJyQq7USiE9TZN69QCwyux0=
X-Google-Smtp-Source: APXvYqwgGcf8U+g55sQnmvLoZZ/hHWGf/A8QuSsyRAFtfoCFbwXviLvKn1W7Xp8D5ywKae+VGtk8JA==
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr6585842iok.75.1561572257169;
 Wed, 26 Jun 2019 11:04:17 -0700 (PDT)
Received: from titan.knownspace (173-25-245-129.client.mchsi.com.
 [173.25.245.129])
 by smtp.gmail.com with ESMTPSA id x22sm16184720ioh.87.2019.06.26.11.04.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 26 Jun 2019 11:04:16 -0700 (PDT)
Date: Wed, 26 Jun 2019 13:04:14 -0500
From: Justin Hibbits <chmeeedalf@gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20190626130414.08940342@titan.knownspace>
In-Reply-To: <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; powerpc64-portbld-freebsd13.0)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d36
Subject: Re: [Qemu-devel] [Qemu-trivial] Fix cacheline size retrieval on
 FreeBSD/PowerPC(64)
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
Cc: qemu-trivial@nongnu.org, "Emilio G. Cota" <cota@braap.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 18:47:42 +0200
Laurent Vivier <laurent@vivier.eu> wrote:

> Le 26/06/2019 =C3=A0 18:37, Justin Hibbits a =C3=A9crit=C2=A0:
> > On Wed, 26 Jun 2019 18:16:36 +0200
> > Laurent Vivier <laurent@vivier.eu> wrote:
> >  =20
> >> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit=C2=A0: =20
> >>> Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit=C2=A0:   =20
> >>>> The attached very trivial patch fixes a startup bug that prevents
> >>>> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
> >>>>
> >>>> - Justin
> >>>>   =20
> >>>
> >>> Please don't send a patch in attachment but inlined in the message
> >>> (you may use "git send-email" for that).
> >>>
> >>> This patch fixes "util: add cacheinfo" that has changed the type
> >>> from unsigned to long.
> >>>
> >>> You can add the following line in the commit message:
> >>>
> >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
> >>>
> >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> >>>    =20
> >>
> >> CC: author of b255b2c8a548 ("util: add cacheinfo")
> >>
> >> Thanks,
> >> Laurent =20
> >=20
> > Hi Laurent,
> >=20
> > Sorry.  I had never used git send-email before, so wasn't
> > comfortable with it.  I just updated the commit message with your
> > feedback and used git send-email to submit the patch.  I hope
> > everything went well. =20
>=20
> It seems not. I didn't receive it.
>=20
> Did you configure the SMTP server. See git-send-email(1):
>=20
>    Use gmail as the smtp server
>=20
>        To use git send-email to send your patches through the GMail
> SMTP server, edit ~/.gitconfig to specify your account settings:
>=20
>            [sendemail]
>                    smtpEncryption =3D tls
>                    smtpServer =3D smtp.gmail.com
>                    smtpUser =3D yourname@gmail.com
>                    smtpServerPort =3D 587
>=20
>        If you have multifactor authentication setup on your gmail
> account, you will need to generate an app-specific password for use
> with git send-email. Visit
>        https://security.google.com/settings/security/apppasswords to
> create it.
>=20
>        Once your commits are ready to be sent to the mailing list,
> run the following commands:
>=20
>            $ git format-patch --cover-letter -M origin/master -o
> outgoing/ $ edit outgoing/0000-*
>            $ git send-email outgoing/*
>=20
>        The first time you run it, you will be prompted for your
> credentials. Enter the app-specific or your regular password as
> appropriate. If you have credential helper configured (see
> git-credential(1)), the password will be saved in the credential
> store so you won=E2=80=99t have to type it the next time.
>=20
>        Note: the following perl modules are required Net::SMTP::SSL,
>        MIME::Base64 and Authen::SASL
>=20
> Thanks,
> Laurent
>=20
> =20

Hm, you're right.  Even after making the config changes and installing
the necessary packages, I still have no luck with git send-email.  Might
take a bit to debug this.

- Justin

