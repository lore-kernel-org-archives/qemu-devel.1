Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD12C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187EF20815
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJSS9COt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187EF20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSahF-0007UQ-8U
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 01:18:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSag8-0006yG-4V
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSag7-0006xI-3C
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:17:39 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:35639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSag6-0006wo-P4
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:17:39 -0400
Received: by mail-ed1-x542.google.com with SMTP id p26so21904469edr.2
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 22:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=x5GADujxRpgQ73DvTqq4ORcDfulnv8qD/sjNb2QxAoE=;
	b=DJSS9COtrfa1WskF7Qm4Nvue6ppVofyTRc9eYOtosut/7GWWPbgCx5SbP24YSH0d1E
	eLp8ZIKFWJ3Rh3xPPIcRLcyZVVpWlGWUq+DTFLed3zZDDBYEMa/xuuk8DmZf3UsC08eI
	iYK1yF8UVCdcuXwHJ2P0EGMWxF4Q9cRuiX2YEs2/lY1YJ68538xlTwv9xYh2os3SDJOq
	kztYXhsSDz1/PbGVdg/Od5Pq3uRyYaOyxs+7SEabVqgenrZfwqcsrBu22e/XVJw9Vjty
	rV5DrqEFlNJZ1qPhs8lgUgkqedN+HgT3l0z9MDk6CGvp/2AUO0a0TPTLiy3JkliI5tvC
	eLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=x5GADujxRpgQ73DvTqq4ORcDfulnv8qD/sjNb2QxAoE=;
	b=oi192LKndGmQJ3SIjvoFjA3B6+4BI9qSb1iT54NQhdfjLBccPrUknpClWP8ACznOZ1
	M8h1xCdxLfcuydcDg84JKSXVW2LfgT9cPJCiJQA8t5/3KR2C8g9ruqqfUziHuHVu0x6j
	WdhdlEtfV0mXRPYdorqXO6yqQ2/tav1DrBhkjAv1cmP2soDzdvGnNlgs2FSgk38qZgoQ
	csXV5nFkKBhT/umS9LfMhGTuS8nCfoWYbF9d/gitonYDdvhTma3lctSK23JXJii+JzYF
	VcHdGEzN7iP9dPcWdQZgfq8LaBDkQn/TEc4ASfabyzU2e0hfBjwlW/eSoKekFy1vruA4
	b4rQ==
X-Gm-Message-State: APjAAAWOcIKX79IctwjGBTmLs3GbBrJSWsdQRwsqg/uo8hhCEyzKfXC9
	JmnTIzw19MhOcupjwQcNd5Qm14N1HGE8raQlu71rEw2c
X-Google-Smtp-Source: APXvYqzxbNELuBZHq7Ur9TrwHAXQAwQoFisNZzrbW61j48+NyssVSYvu9IVnLvhz1S7/j1FIJ2Vsy3/v6ArRXAuRTlc=
X-Received: by 2002:a50:ae84:: with SMTP id e4mr74065667edd.33.1558329457404; 
	Sun, 19 May 2019 22:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-25-arilou@gmail.com>
	<87a7fnmx2t.fsf@zen.linaroharston>
In-Reply-To: <87a7fnmx2t.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 20 May 2019 08:17:26 +0300
Message-ID: <CAP7QCohe8gHEUhSed+yVi4gkYmJx+KoYzAikOs4uFNAWHxQgwg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v9 24/27] gdbstub: Add another handler for
 setting qemu.sstep
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 15, 2019 at 8:44 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Follow GDB general query/set packet conventions, qemu.sstep can now
> > be set with the following command as well:
> > gdb> maint packet Qqemu.sstep:Value
>
> I;m not sure about exposing internal values to a protocol like this.
> Maybe text based flags would be better?
>

We kinda have to at this point as this was the original implementation
or we might end up breaking up the "API"
see commit: 60897d369f10b464720d8a6de4553c47943ea927

> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 88ff6224e6..34da10260d 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -2260,6 +2260,12 @@ static GdbCmdParseEntry gdb_gen_set_table[] =3D =
{
> >          .cmd_startswith =3D 1,
> >          .schema =3D "l0"
> >      },
> > +    {
> > +        .handler =3D handle_set_qemu_sstep,
> > +        .cmd =3D "qemu.sstep:",
> > +        .cmd_startswith =3D 1,
> > +        .schema =3D "l0"
> > +    },
>
> Hmm the implementation seems to have gone in earlier. These should be
> together as a feature patch (along with changing the query/probe
> responses).
>
Done
> >  };
> >
> >  static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
>
>
> --
> Alex Benn=C3=A9e

