Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC1DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52A72081C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ju8Z2rKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52A72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53413 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLZwY-00046e-OH
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:05:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuV-0002ix-R0
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLZuU-0001tK-B3
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:03:31 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:33292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLZuT-0001rz-Uw; Tue, 30 Apr 2019 17:03:30 -0400
Received: by mail-lf1-x141.google.com with SMTP id j11so11965604lfm.0;
	Tue, 30 Apr 2019 14:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Uz2HnqzsfMYSzCruClG78wktLuutjoRm8r0Nw9+5Gfs=;
	b=Ju8Z2rKkAuS54kZbtGZqjTE0p1pln4WPSzPCajwL8zA/ARQY1U6XcZbDNDIaAZAqit
	YO57za1EaYATGvoWlGJkALjRG/k3HWWqBzdLps1RxHdA1koxOlCtqi01RMH/LIQGoDdS
	J9QUj1cdL/wvTb7m0A1/RqAkn2D9zGpWEzTv4z5tUAJTMYDRF6qWIzfo/c33pjJQWIVS
	KHOvpRKK+bYgvhUhXSI0Ly31kygnu9E5086xlmLGpWShGvxWHvd0Gm7EJbmxJvSoopih
	AuVZfWCjnjA757InKHMo8tQEhEe/rnQFMe4lHmK0suCBhQXD8QgmwHD3PulJFX02EUCu
	regw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=Uz2HnqzsfMYSzCruClG78wktLuutjoRm8r0Nw9+5Gfs=;
	b=OrKipJtj3/R2mdM7NQNjfp8Uln3oaQNhg9HXFIBNjTJEU1Inewfo6ww73123L6xNb4
	8Bho49b143H4g5B7pF9zBhljMD+vgBei6T7XKhccy+jv/OISGV8nWWpU/N+2zWsHMtxG
	jUr5gQtUxy6tnbkiTcD9PgzUUAwj4dEUNT7kIbLIYteqK9O8+NF9zTZ5O+5wNtt4Z8Rx
	8w+JKEFzSxdogr5bOCpg+HrprEOlNibONFGn6mQZtfshiGqSivfBdSwHTueIQgDS820c
	mGuWmcu4UxfPxgp4libpAnTZ9DbXHNuhIf6Vv4VxjKZGsJ+ZNBcatmbLz6D+YDVOiXw9
	Ek+w==
X-Gm-Message-State: APjAAAUxhH5Xv0bWpeiydKqP/kIVqUSQ2K0BSF1XzQ/bqzhSGIH4AyTy
	tKJMMVdzHc5zKcn4cZ2Ag1B27WiJxLsChWVQEok=
X-Google-Smtp-Source: APXvYqwvi4tgNYTFY8RDwuk2Vo+Xfn8V8rmlHs/7ijQzeOQPis4+svRO+zEWpy65styUAmVWWXLKet2Gsw+kMRItHTs=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr32047730lfl.118.1556658208840;
	Tue, 30 Apr 2019 14:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<6bfa446eb7c351b5d867eb4158198231af724b11.1556650594.git.alistair.francis@wdc.com>
	<d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
In-Reply-To: <d4dd0758-64af-e249-1f1b-b52af014b404@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:01:35 -0700
Message-ID:
 <CAKmqyKNx2r93-ASC0dAZJvu_36dV69sRj92-m6G9zXqLdc2sag@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v1 5/5] linux-user/elfload: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430210135.aPoO3ydrg-5ot-H6kEBUzoosk4YiuxqjC4h0HVyI1Zs@z>

On Tue, Apr 30, 2019 at 1:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 30/04/2019 =C3=A0 22:09, Alistair Francis a =C3=A9crit :
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98fill_psinfo=E2=80=99 at /home/alistair/qemu/l=
inux-user/elfload.c:3208:12,
> >     inlined from =E2=80=98fill_note_info=E2=80=99 at /home/alistair/qem=
u/linux-user/elfload.c:3390:5,
> >     inlined from =E2=80=98elf_core_dump=E2=80=99 at /home/alistair/qemu=
/linux-user/elfload.c:3539:9:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_=
strncpy=E2=80=99 specified bound 16 equals destination size [-Werror=3Dstri=
ngop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (=
__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/elfload.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> > index c1a26021f8..cbb7fc10fa 100644
> > --- a/linux-user/elfload.c
> > +++ b/linux-user/elfload.c
> > @@ -3206,7 +3206,7 @@ static int fill_psinfo(struct target_elf_prpsinfo=
 *psinfo, const TaskState *ts)
>
>        /*
>         * Using strncpy here is fine: at max-length,
> >       * this field is not NUL-terminated.
> >       */>      (void) strncpy(psinfo->pr_fname, base_filename,
> > -                   sizeof(psinfo->pr_fname));
> > +                   sizeof(psinfo->pr_fname) - 1);
>
> Read the comment above :)

GCC can't read the comment though. The only other option I can think
of is using a pragma, which I avoided using unless I had to. Would you
prefer a pragma here? Or do you have a better solution?

>
> >
> >      g_free(base_filename);
> >      bswap_psinfo(psinfo);
> > @@ -3389,7 +3389,7 @@ static int fill_note_info(struct elf_note_info *i=
nfo,
> >                sizeof (*info->prstatus), info->prstatus);
> >      fill_psinfo(info->psinfo, ts);
> >      fill_note(&info->notes[1], "CORE", NT_PRPSINFO,
> > -              sizeof (*info->psinfo), info->psinfo);
> > +              sizeof(*info->psinfo) - 1, info->psinfo);
>
> Why?

Same issue as above.

Alistair

>
> >      fill_auxv_note(&info->notes[2], ts);
> >      info->numnote =3D 3;
> >
> >
>
> Thanks,
> Laurent

