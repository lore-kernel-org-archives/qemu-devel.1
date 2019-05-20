Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3728DC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05CCD20644
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av4ZsOcY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CCD20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58115 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSao5-00026O-1i
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 01:25:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSan9-0001VO-7t
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSan8-0001fX-8B
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:24:55 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36625)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSan8-0001dp-22
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:24:54 -0400
Received: by mail-ed1-x541.google.com with SMTP id a8so21902375edx.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 22:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=mOd3wFFBwM4NFxORq6fo9VWhiXs4GuFt699lpskvpeI=;
	b=Av4ZsOcYtTtVuRggXxGa8rXld7XXZJHbl5NOJcrynk3/i7/Pf/EDThLEMQznxYSf08
	j0k35XikJGkmKnlmoDHY4xeBThb2P/LzerjdzMJrQYt4/p5q7f5cepiRjOp+0zf8dxj7
	wQEuTPJUSQPxWQ9JbuDtvo5fjh4iuFGWTyiadHjh6Lq20GbqMDC87lJRgx3LVq6Qq9hQ
	PyrJQA3gVC7hraLGqQNkLfHnKlJEaeMbAk0TQ2gHx1m0q1ursSM22EWZ8cGWFaPOuvEE
	m1CdPoh3FCDE/r7vDE2KhbPJdDrA7YZV1wsnxHHcDRIV8YHLoQ5F85gTQzzaGPTeUuRo
	Fzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=mOd3wFFBwM4NFxORq6fo9VWhiXs4GuFt699lpskvpeI=;
	b=jinj8YBuUfyCbF2dJ0Q3/NnNXPX7/ryzneSB8g4Y+Ksmc913nEZUsJFGeQb1G3nxd1
	noONAjEGc/MHR+VMNTlMGiPUQIHp70LAvalxYVwTStVZgVezT2kw4ftR8oGCBzDP+d8S
	b6vr7FujodUpQp831xiV68OmsCz4rd+j6nSeQ/6wGjec7w9tI6ubY4uMNJTbcAGrpLP7
	bgjaNREVovRTJTIvBpcDIbGmRgQIMg2W6G4k378V5fMr7mTrcy0+02fSIMF5gtqlU96E
	VCAlbL6/RriO+bNXt1ccfYfH803uX1j4YFNn0w3TviczMsB2osnX9KQLNcYMX3PQTnsb
	v8Ng==
X-Gm-Message-State: APjAAAWj1GPBeTFSWGgdEGuCni25QBNIGPFZbNpYzvU5jJO7zyt5zHHi
	A6vxI8GrVru+jBASaud4FTbQpA7cu9OgJA4oH7o=
X-Google-Smtp-Source: APXvYqypiHCBv0UObKX3FMTAmIbFEyXyT1aqdifKpMmCDY9SrgRd4K+2QarvYK8yyPPrVNB3mJyx3Lolk2KG4ASEo8M=
X-Received: by 2002:a50:ae84:: with SMTP id e4mr74090393edd.33.1558329893008; 
	Sun, 19 May 2019 22:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-27-arilou@gmail.com>
	<878sv7mwvs.fsf@zen.linaroharston>
In-Reply-To: <878sv7mwvs.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 20 May 2019 08:24:42 +0300
Message-ID: <CAP7QCojewXLDddbxLQ8qEM4WYGsN--7Axq8Sh5ShFecoecNO0Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v9 26/27] gdbstub: Add support to read a
 MSR for KVM target
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

Ah cool did not know about that I will look into it and perhaps can do
a different patchset just for this no need to add it on top of this
patchset

On Wed, May 15, 2019 at 8:48 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > gdb> maint packet qqemu.kvm.Rdmsr:MsrIndex
>
> gdbserver already has a mechanism for exposing system registers see:
>
>   commit 200bf5b7ffea635079cc05fdfb363372b9544ce7
>   Author: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
>   Date:   Fri May 18 17:48:07 2018 +0100
>
> for an example. As MSR's are very specific to x86 all this should be
> handled via target/i386/gdbstub and kept out of the generic code.
>
> >
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 37 insertions(+), 1 deletion(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 34da10260d..f48c3a2b5f 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -2141,7 +2141,14 @@ static void handle_query_attached(GdbCmdContext =
*gdb_ctx, void *user_ctx)
> >
> >  static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *=
user_ctx)
> >  {
> > -    put_packet(gdb_ctx->s, "sstepbits;sstep;PhyMemMode");
> > +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> > +             "sstepbits;sstep;PhyMemMode");
> > +
> > +    if (kvm_enabled()) {
> > +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";kvm.Rdms=
r");
> > +    }
> > +
> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> >  }
> >
> >  static void handle_query_qemu_phy_mem_mode(GdbCmdContext *gdb_ctx,
> > @@ -2166,6 +2173,29 @@ static void handle_set_qemu_phy_mem_mode(GdbCmdC=
ontext *gdb_ctx, void *user_ctx)
> >      put_packet(gdb_ctx->s, "OK");
> >  }
> >
> > +static void handle_query_kvm_read_msr(GdbCmdContext *gdb_ctx, void *us=
er_ctx)
> > +{
> > +    uint64_t msr_val;
> > +
> > +    if (!kvm_enabled()) {
> > +        return;
> > +    }
> > +
> > +    if (!gdb_ctx->num_params) {
> > +        put_packet(gdb_ctx->s, "E22");
> > +        return;
> > +    }
> > +
> > +    if (kvm_arch_read_msr(gdbserver_state->c_cpu, gdb_ctx->params[0].v=
al_ul,
> > +                          &msr_val)) {
> > +        put_packet(gdb_ctx->s, "E00");
> > +        return;
> > +    }
> > +
> > +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%" PRIx64,=
 msr_val);
> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> > +}
> > +
> >  static GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
> >      /* Order is important if has same prefix */
> >      {
> > @@ -2250,6 +2280,12 @@ static GdbCmdParseEntry gdb_gen_query_table[] =
=3D {
> >          .handler =3D handle_query_qemu_phy_mem_mode,
> >          .cmd =3D "qemu.PhyMemMode",
> >      },
> > +    {
> > +        .handler =3D handle_query_kvm_read_msr,
> > +        .cmd =3D "qemu.kvm.Rdmsr:",
> > +        .cmd_startswith =3D 1,
> > +        .schema =3D "l0"
> > +    },
> >  };
> >
> >  static GdbCmdParseEntry gdb_gen_set_table[] =3D {
>
>
> --
> Alex Benn=C3=A9e

