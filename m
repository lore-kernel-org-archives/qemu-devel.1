Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73BAC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:13:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B396A205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 13:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM4ml4tA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B396A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhw7O-0000LL-AZ
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 09:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35928)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chmeeedalf@gmail.com>) id 1hhvy0-0000YL-H7
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chmeeedalf@gmail.com>) id 1hhvxw-0003jQ-6a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 09:03:32 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:42766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chmeeedalf@gmail.com>)
 id 1hhvxr-00035L-6k; Mon, 01 Jul 2019 09:03:23 -0400
Received: by mail-lf1-x12d.google.com with SMTP id x144so8741269lfa.9;
 Mon, 01 Jul 2019 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gYGEWTf/SWiucXWkQ4hNUOwq3//Nu83USjjeDpKHhdI=;
 b=RM4ml4tAIYaZlcZgE8Cbaj+GGfaW2HruV4wBOJZqvKUdpDur6IEnTIy0EoeubAO2q9
 Gw3guxKbqqP7biH6vfA3owqW9McPsq39BgpbYJLMzx60bd8VgZjQsLp8naKLFuJsrdCm
 gLv0DER4xjJSlE7Zl6Tq/gBsiadvwEg+KNDCEntYFMnZ2WMnlNG3RNQnenBeG9vRVUZe
 PV3L8BtUofdu98CvbwxwUCwRoHInuTTWmoqLJQISA7xGVq3LgoAbCu6uuponTmAbZte7
 YVolWqdA9jt89g7yb9GRtIpyLT988bLEsH01FkbU70zl8hBKnb+ZE9OWiifUOxqCuCwN
 2FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gYGEWTf/SWiucXWkQ4hNUOwq3//Nu83USjjeDpKHhdI=;
 b=AYPu5WyGmDZOrXOfrZXgvApxZMBX1sFGGLGixriHs/tg3DJGcpAv70PZXPK8w2/UCE
 o0JFsivNWzRtKrr+kwdHKCedzVRsQN+55m0WVYsF1UPsi7PcW1/4/Ly2rRfWP9F6RE4K
 L2fJXkvC1Lov7Hh4feLtAXzoVuClFsN63LH+YbiUlTK7ANyyzXnRJXLpCGMWtZ+GGTuI
 srRIKXVEh8BB27aYgQfG1SBYBw5Oo+rAcBewAeCfyNwAAn6sJJcnQW4ZF4g25+aVFcE/
 x3qkv3mbQkMPMUX/t7K9Pzj41OYUbJf4kKrfZ7oCNwlGS4UddpMnhjVEHxvQN656Wpzn
 H4mw==
X-Gm-Message-State: APjAAAXmNj0Kz61qQLu1DdVhaa6xtHaG8pllJcPaOqkLmEY8Emwqgrvr
 BxLnXiOuAOE8YpLgDKSwi91XZLG0uwHvUHRFcHY=
X-Google-Smtp-Source: APXvYqwsGiKDafTLQUGTBEfeNEAtjkI6FhkirpNjYRB/KPxZ8HkSdCfUuFSniiBB/eE+THPIMJadgPEWAQeBK3Gv4sY=
X-Received: by 2002:ac2:50c4:: with SMTP id h4mr11927970lfm.61.1561986165385; 
 Mon, 01 Jul 2019 06:02:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190607135653.6ece685d@titan.knownspace>
 <8676232e-917d-44e2-1149-b25f26698a73@vivier.eu>
 <92053c9c-e7bf-76cb-9399-987f4ab31bfb@vivier.eu>
 <20190626113742.6bcd8a26@titan.knownspace>
 <d60f142d-27ef-bfe5-1eb6-cefb22640625@vivier.eu>
 <20190626130414.08940342@titan.knownspace>
 <CAHSQbTCxP09J9NtFiN4UpdXHJZHtTw_F66hfdAS2sM4=E5GHyQ@mail.gmail.com>
 <477ebe22-eddb-41ba-5811-4a70e639a89a@vivier.eu>
 <CAHSQbTCUzR5WiykWGZOH1bvBPWx15_ZA-=7b17c6AnRK4kn3yA@mail.gmail.com>
 <cd0a35ce-1f8c-6718-13d9-7a481e1eeb31@vivier.eu>
In-Reply-To: <cd0a35ce-1f8c-6718-13d9-7a481e1eeb31@vivier.eu>
From: Justin Hibbits <chmeeedalf@gmail.com>
Date: Mon, 1 Jul 2019 08:02:33 -0500
Message-ID: <CAHSQbTDMWXX978oWBvYhh1Uz7CeA1KQGz6+11rqwYv+ZOWyVOw@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::12d
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

On Mon, Jul 1, 2019, 03:54 Laurent Vivier <laurent@vivier.eu> wrote:

> Le 27/06/2019 =C3=A0 02:15, Justin Hibbits a =C3=A9crit :
> >
> >
> > On Wed, Jun 26, 2019, 19:08 Laurent Vivier <laurent@vivier.eu
> > <mailto:laurent@vivier.eu>> wrote:
> >
> >     Le 27/06/2019 =C3=A0 02:02, Justin Hibbits a =C3=A9crit :
> >     >
> >     >
> >     > On Wed, Jun 26, 2019, 13:04 Justin Hibbits <chmeeedalf@gmail.com
> >     <mailto:chmeeedalf@gmail.com>
> >     > <mailto:chmeeedalf@gmail.com <mailto:chmeeedalf@gmail.com>>>
> wrote:
> >     >
> >     >     On Wed, 26 Jun 2019 18:47:42 +0200
> >     >     Laurent Vivier <laurent@vivier.eu <mailto:laurent@vivier.eu>
> >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>> wrote:
> >     >
> >     >     > Le 26/06/2019 =C3=A0 18:37, Justin Hibbits a =C3=A9crit :
> >     >     > > On Wed, 26 Jun 2019 18:16:36 +0200
> >     >     > > Laurent Vivier <laurent@vivier.eu
> >     <mailto:laurent@vivier.eu> <mailto:laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>>> wrote:
> >     >     > >
> >     >     > >> Le 26/06/2019 =C3=A0 18:14, Laurent Vivier a =C3=A9crit =
:
> >     >     > >>> Le 07/06/2019 =C3=A0 20:56, Justin Hibbits a =C3=A9crit=
 :
> >     >     > >>>> The attached very trivial patch fixes a startup bug
> >     that prevents
> >     >     > >>>> at least Qemu 3.1 and later from working on
> >     FreeBSD/powerpc64.
> >     >     > >>>>
> >     >     > >>>> - Justin
> >     >     > >>>>
> >     >     > >>>
> >     >     > >>> Please don't send a patch in attachment but inlined in
> >     the message
> >     >     > >>> (you may use "git send-email" for that).
> >     >     > >>>
> >     >     > >>> This patch fixes "util: add cacheinfo" that has changed
> >     the type
> >     >     > >>> from unsigned to long.
> >     >     > >>>
> >     >     > >>> You can add the following line in the commit message:
> >     >     > >>>
> >     >     > >>> Fixes: b255b2c8a548 ("util: add cacheinfo")
> >     >     > >>>
> >     >     > >>> Reviewed-by: Laurent Vivier <laurent@vivier.eu
> >     <mailto:laurent@vivier.eu>
> >     >     <mailto:laurent@vivier.eu <mailto:laurent@vivier.eu>>>
> >     >     > >>>
> >     >     > >>
> >     >     > >> CC: author of b255b2c8a548 ("util: add cacheinfo")
> >     >     > >>
> >     >     > >> Thanks,
> >     >     > >> Laurent
> >     >     > >
> >     >     > > Hi Laurent,
> >     >     > >
> >     >     > > Sorry.  I had never used git send-email before, so wasn't
> >     >     > > comfortable with it.  I just updated the commit message
> >     with your
> >     >     > > feedback and used git send-email to submit the patch.  I
> hope
> >     >     > > everything went well.
> >     >     >
> >     >     > It seems not. I didn't receive it.
> >     >     >
> >     >     > Did you configure the SMTP server. See git-send-email(1):
> >     >     >
> >     >     >    Use gmail as the smtp server
> >     >     >
> >     >     >        To use git send-email to send your patches through
> >     the GMail
> >     >     > SMTP server, edit ~/.gitconfig to specify your account
> settings:
> >     >     >
> >     >     >            [sendemail]
> >     >     >                    smtpEncryption =3D tls
> >     >     >                    smtpServer =3D smtp.gmail.com
> >     <http://smtp.gmail.com> <http://smtp.gmail.com>
> >     >     >                    smtpUser =3D yourname@gmail.com
> >     <mailto:yourname@gmail.com>
> >     >     <mailto:yourname@gmail.com <mailto:yourname@gmail.com>>
> >     >     >                    smtpServerPort =3D 587
> >     >     >
> >     >     >        If you have multifactor authentication setup on your
> >     gmail
> >     >     > account, you will need to generate an app-specific password
> >     for use
> >     >     > with git send-email. Visit
> >     >     >
> >     https://security.google.com/settings/security/apppasswords to
> >     >     > create it.
> >     >     >
> >     >     >        Once your commits are ready to be sent to the mailin=
g
> >     list,
> >     >     > run the following commands:
> >     >     >
> >     >     >            $ git format-patch --cover-letter -M
> origin/master -o
> >     >     > outgoing/ $ edit outgoing/0000-*
> >     >     >            $ git send-email outgoing/*
> >     >     >
> >     >     >        The first time you run it, you will be prompted for
> your
> >     >     > credentials. Enter the app-specific or your regular passwor=
d
> as
> >     >     > appropriate. If you have credential helper configured (see
> >     >     > git-credential(1)), the password will be saved in the
> credential
> >     >     > store so you won=E2=80=99t have to type it the next time.
> >     >     >
> >     >     >        Note: the following perl modules are required
> >     Net::SMTP::SSL,
> >     >     >        MIME::Base64 and Authen::SASL
> >     >     >
> >     >     > Thanks,
> >     >     > Laurent
> >     >     >
> >     >     >
> >     >
> >     >     Hm, you're right.  Even after making the config changes and
> >     installing
> >     >     the necessary packages, I still have no luck with git
> >     send-email.  Might
> >     >     take a bit to debug this.
> >     >
> >     >     - Justin
> >     >
> >     >
> >     > Sorry for the multiplicity, looks like Gmail forwarded it
> eventually,
> >     > but not until I tried several times debugging it.
> >
> >     Not sure, I didn't receive any of them.
> >
> >     Thanks,
> >     Laurent
> >
> >
> > Sigh, 4 copies ended up in my Gmail spam folder, so I thought it made i=
t
> > through.
> >
>
> Any news? Freeze is coming.
>
> Thanks,
> Laurent
>

I'll manually do it when I get home tomorrow.  Fixing git send-email will
have to wait.
