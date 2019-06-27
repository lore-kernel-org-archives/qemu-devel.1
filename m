Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140C48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:03:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503EF20815
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 00:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPasXv6Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503EF20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgHsw-0004oy-Eb
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 20:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58233)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgHs9-0004Ni-4B
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hgHs7-0001jA-FO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 20:02:41 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135]:38983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hgHs7-0001hs-3m; Wed, 26 Jun 2019 20:02:39 -0400
Received: by mail-lf1-x135.google.com with SMTP id p24so296204lfo.6;
 Wed, 26 Jun 2019 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0bD4eEcaMXQo24YPh3YpBiz6BxI/iotWsEY5N08Vs4E=;
 b=HPasXv6YmgH+VN1Xab72GajIyaMn6QCeQw4ZL2x/8JdqZT8hSz6hvfKM7YD8uq8FtP
 sHlVvYtXywl9T/OFBicVKAjPVlq6F5kGJlE4IUurHPyiQSFyN9qWVAu4fthdH0FjDbcg
 el5JaQRSvMpISqLSAU0023A/qTSPpI1tq5h8zpPH80sm/uvgxR0v0+gKAuJisfZg4Xss
 snpM/w4tefwKT929Do/8oUuvnZ/Y9M1deZKH2idcG+1/Se5JsJ/1MRVqCWb6QLm3M1hV
 9Bx+OcIxyNaIbbM2+D21xiADAnsO0A98mJs7Ntd9fb6/6b8Ps0jg4y9o1/VavBKMB1g4
 veJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0bD4eEcaMXQo24YPh3YpBiz6BxI/iotWsEY5N08Vs4E=;
 b=NpUfqZcz/2SMWlxIIgYIBcy4DNQ5+s3bGkhbQUW4bnUOpGUJjl5HEiWcqIt7fAWs68
 tS3xdMlHgrwN95RuHiCvGcwGsiOTWrz7jNpRp5rLmvHCzewqErxhVToszhasA9f3icl5
 NGI3wWs28P7HF5Xry+nPJCLxBfzhpyMOJuMmYo8Zg52DDvtIEgKV4rU+P5U5UhDHuHBH
 74Df25vCfxw9PLRE4jynHXqt3kvukZB44YPm+jd0vAokIzLTNgcb4LeKLvOsAXqJzQ2Q
 x4xj7ruJkRDlAWL7MlqrM+apiIn98meqJxsXRCgom6laLJ3tky7WIJwpi058PA6i3gh+
 LOAg==
X-Gm-Message-State: APjAAAV2dtjG4ec3kyeK5sVOsUFqcoU5IOatmuVPXcNjHBEnH5eBdd7P
 mzkdo2yUFNGhqWHOlHlkbOoEwd/T2koQ5kNDkUE=
X-Google-Smtp-Source: APXvYqyjaotHpgJO77QWwMiM5xzlO0cv/MpB076PmptxzJ5OGfA+s2vWvl+329LIyqoygFdalbSQf2xI5T/HyPsM60g=
X-Received: by 2002:a05:6512:48e:: with SMTP id
 v14mr415861lfq.130.1561593757311; 
 Wed, 26 Jun 2019 17:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
In-Reply-To: <20190626130414.08940342@titan.knownspace>
From: Justin Hibbits <chmeeedalf@gmail.com>
Date: Wed, 26 Jun 2019 19:02:25 -0500
Message-ID: <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::135
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

On Wed, Jun 26, 2019, 13:04 Justin Hibbits <chmeeedalf@gmail.com> wrote:

> On Wed, 26 Jun 2019 18:47:42 +0200
> Laurent Vivier <laurent@vivier.eu> wrote:
>
> > Le 26/06/2019 =C3=A0 18:37, Justin Hibbits a =C3=A9crit :
> > > On Wed, 26 Jun 2019 18:16:36 +0200
> > > Laurent Vivier <laurent@vivier.eu> wrote:
> > >
> > >> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit :
> > >>> Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit :
> > >>>> The attached very trivial patch fixes a startup bug that prevents
> > >>>> at least Qemu 3.1 and later from working on FreeBSD/powerpc64.
> > >>>>
> > >>>> - Justin
> > >>>>
> > >>>
> > >>> Please don't send a patch in attachment but inlined in the message
> > >>> (you may use "git send-email" for that).
> > >>>
> > >>> This patch fixes "util: add cacheinfo" that has changed the type
> > >>> from unsigned to long.
> > >>>
> > >>> You can add the following line in the commit message:
> > >>>
> > >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
> > >>>
> > >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> > >>>
> > >>
> > >> CC: author of b255b2c8a548 ("util: add cacheinfo")
> > >>
> > >> Thanks,
> > >> Laurent
> > >
> > > Hi Laurent,
> > >
> > > Sorry.  I had never used git send-email before, so wasn't
> > > comfortable with it.  I just updated the commit message with your
> > > feedback and used git send-email to submit the patch.  I hope
> > > everything went well.
> >
> > It seems not. I didn't receive it.
> >
> > Did you configure the SMTP server. See git-send-email(1):
> >
> >    Use gmail as the smtp server
> >
> >        To use git send-email to send your patches through the GMail
> > SMTP server, edit ~/.gitconfig to specify your account settings:
> >
> >            [sendemail]
> >                    smtpEncryption =3D tls
> >                    smtpServer =3D smtp.gmail.com
> >                    smtpUser =3D yourname@gmail.com
> >                    smtpServerPort =3D 587
> >
> >        If you have multifactor authentication setup on your gmail
> > account, you will need to generate an app-specific password for use
> > with git send-email. Visit
> >        https://security.google.com/settings/security/apppasswords to
> > create it.
> >
> >        Once your commits are ready to be sent to the mailing list,
> > run the following commands:
> >
> >            $ git format-patch --cover-letter -M origin/master -o
> > outgoing/ $ edit outgoing/0000-*
> >            $ git send-email outgoing/*
> >
> >        The first time you run it, you will be prompted for your
> > credentials. Enter the app-specific or your regular password as
> > appropriate. If you have credential helper configured (see
> > git-credential(1)), the password will be saved in the credential
> > store so you won=E2=80=99t have to type it the next time.
> >
> >        Note: the following perl modules are required Net::SMTP::SSL,
> >        MIME::Base64 and Authen::SASL
> >
> > Thanks,
> > Laurent
> >
> >
>
> Hm, you're right.  Even after making the config changes and installing
> the necessary packages, I still have no luck with git send-email.  Might
> take a bit to debug this.
>
> - Justin
>

Sorry for the multiplicity, looks like Gmail forwarded it eventually, but
not until I tried several times debugging it.

- Justin

>
