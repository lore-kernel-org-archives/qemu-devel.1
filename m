Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A6AC48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07378216C8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao8neZp3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07378216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgI6i-0000ye-1i
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 20:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60666)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgI4i-0008Pw-0x
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgI4g-0006sn-8I
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:15:39 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:39379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hgI4f-0006rk-SA; Wed, 26 Jun 2019 20:15:38 -0400
Received: by mail-lj1-x241.google.com with SMTP id v18so410408ljh.6;
 Wed, 26 Jun 2019 17:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IaKHMsjWD5ArDiMo3LTLBS3S/RnZjLd9z0nGw8nibRA=;
 b=Ao8neZp3KNdrWuKM6Kkqqlq7eoF+qDqzg4yA3ZZWqCGrd4q5kM5Ge2RQfruQsH4vMo
 21bdjUsTVjfUf0nvRuQ2oKIriSjh4vN0S88VrDtWTmECQmP9v1AWbhwlEwWe7sMCEMXG
 Nvffx0FTsJSxiOHiu5efbzmZ4pQdGfeNRLigUH+Zv3YVDSjOjPwE0diQcT08/Dp+JjHV
 qTXjAFc2MX+bDLRN+g4gTntKHGDHszZw9w57QWJ0pMiDQ9dzaAq4Empr2s1kAyRtEhSR
 s1UEBTpZIV9zJJqORNwxQ4AID20X7BPAVxnRKTY27RrzOgmnB/NmPhXtsXunL7zEOgFq
 Su3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IaKHMsjWD5ArDiMo3LTLBS3S/RnZjLd9z0nGw8nibRA=;
 b=GiTIIeGe5c1Js3YAIxoCNzwz8R6fUXrs7xn0cIWOqDvgZonLWlzsgPpr6Rt6m5ayb7
 NvT6JT15pr+P7EnbNavBvWtWccEXJaoSAWOcW6FMKaiSY9hlE8tNbLq2kuljiY0taHpD
 LMw0n4cucKx55dbZUKeLg/CjGu3LB5GYrftd9j2csh4B6kfpJpxUKmmlmMmfQtQdvxwf
 D9vZgso6FuTcDaKAY+/ufBKIowA8s2S3ZNRwNIkf4Vw1Uc9NYRpNz54pOXE7Awxs/WqX
 Wtn1uxOIulu69RCGqj3fCKqxw6osF62sWbVWR1vdU7dGDyTcDUQHfnECg1M3BCLTcrc+
 kPKw==
X-Gm-Message-State: APjAAAVxVB4iiTI3UoL7Rg7JiYicFZhFb3dM7lC1miUKRXx+HAmAMtiz
 R6JrKtLA3mvK14uYK3AMyfsHvqCkPAxfUykt5qU=
X-Google-Smtp-Source: APXvYqz93xSwRqkU7GJocgN10nIceaqryRNT7FroI2iVUTgteDrbRnM/rfeNqLLGFyQlLMKpyeglZULZ9O69zZSsZ1k=
X-Received: by 2002:a2e:970d:: with SMTP id r13mr602143lji.126.1561594536335; 
 Wed, 26 Jun 2019 17:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
 <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
 <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
In-Reply-To: <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
From: Justin Hibbits <chmeeedalf@gmail.com>
Date: Wed, 26 Jun 2019 19:15:25 -0500
Message-ID: <CAHSQbTCUzR5WiykWGZOH1bvBPWx15_ZA-=7b17c6AnRK4kn3yA@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
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

On Wed, Jun 26, 2019, 19:08 Laurent Vivier <laurent@vivier.eu> wrote:

> Le 27/06/2019 =C3=A0 02:02, Justin Hibbits a =C3=A9crit :
> >
> >
> > On Wed, Jun 26, 2019, 13:04 Justin Hibbits <chmeeedalf@gmail.com
> > <mailto:chmeeedalf@gmail.com>> wrote:
> >
> >     On Wed, 26 Jun 2019 18:47:42 +0200
> >     Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>> wrote=
:
> >
> >     > Le 26/06/2019 =C3=A0 18:37, Justin Hibbits a =C3=A9crit :
> >     > > On Wed, 26 Jun 2019 18:16:36 +0200
> >     > > Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>>
> wrote:
> >     > >
> >     > >> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit :
> >     > >>> Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit :
> >     > >>>> The attached very trivial patch fixes a startup bug that
> prevents
> >     > >>>> at least Qemu 3.1 and later from working on FreeBSD/powerpc6=
4.
> >     > >>>>
> >     > >>>> - Justin
> >     > >>>>
> >     > >>>
> >     > >>> Please don't send a patch in attachment but inlined in the
> message
> >     > >>> (you may use "git send-email" for that).
> >     > >>>
> >     > >>> This patch fixes "util: add cacheinfo" that has changed the
> type
> >     > >>> from unsigned to long.
> >     > >>>
> >     > >>> You can add the following line in the commit message:
> >     > >>>
> >     > >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
> >     > >>>
> >     > >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>>
> >     > >>>
> >     > >>
> >     > >> CC: author of b255b2c8a548 ("util: add cacheinfo")
> >     > >>
> >     > >> Thanks,
> >     > >> Laurent
> >     > >
> >     > > Hi Laurent,
> >     > >
> >     > > Sorry.  I had never used git send-email before, so wasn't
> >     > > comfortable with it.  I just updated the commit message with yo=
ur
> >     > > feedback and used git send-email to submit the patch.  I hope
> >     > > everything went well.
> >     >
> >     > It seems not. I didn't receive it.
> >     >
> >     > Did you configure the SMTP server. See git-send-email(1):
> >     >
> >     >    Use gmail as the smtp server
> >     >
> >     >        To use git send-email to send your patches through the GMa=
il
> >     > SMTP server, edit ~/.gitconfig to specify your account settings:
> >     >
> >     >            [sendemail]
> >     >                    smtpEncryption =3D tls
> >     >                    smtpServer =3D smtp.gmail.com <
> http://smtp.gmail.com>
> >     >                    smtpUser =3D yourname@gmail.com
> >     <mailto:yourname@gmail.com>
> >     >                    smtpServerPort =3D 587
> >     >
> >     >        If you have multifactor authentication setup on your gmail
> >     > account, you will need to generate an app-specific password for u=
se
> >     > with git send-email. Visit
> >     >        https://security.google.com/settings/security/apppasswords
> to
> >     > create it.
> >     >
> >     >        Once your commits are ready to be sent to the mailing list=
,
> >     > run the following commands:
> >     >
> >     >            $ git format-patch --cover-letter -M origin/master -o
> >     > outgoing/ $ edit outgoing/0000-*
> >     >            $ git send-email outgoing/*
> >     >
> >     >        The first time you run it, you will be prompted for your
> >     > credentials. Enter the app-specific or your regular password as
> >     > appropriate. If you have credential helper configured (see
> >     > git-credential(1)), the password will be saved in the credential
> >     > store so you won=E2=80=99t have to type it the next time.
> >     >
> >     >        Note: the following perl modules are required
> Net::SMTP::SSL,
> >     >        MIME::Base64 and Authen::SASL
> >     >
> >     > Thanks,
> >     > Laurent
> >     >
> >     >
> >
> >     Hm, you're right.  Even after making the config changes and
> installing
> >     the necessary packages, I still have no luck with git send-email.
> Might
> >     take a bit to debug this.
> >
> >     - Justin
> >
> >
> > Sorry for the multiplicity, looks like Gmail forwarded it eventually,
> > but not until I tried several times debugging it.
>
> Not sure, I didn't receive any of them.
>
> Thanks,
> Laurent
>

Sigh, 4 copies ended up in my Gmail spam folder, so I thought it made it
through.

- Justin

>
