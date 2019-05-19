Return-Path: <SRS0=v56/=TT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F823C04AB4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 11:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15FB621872
	for <qemu-devel@archiver.kernel.org>; Sun, 19 May 2019 11:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKE7Xej2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15FB621872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47297 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSK7j-0007KW-Bt
	for qemu-devel@archiver.kernel.org; Sun, 19 May 2019 07:37:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSK6x-0006oW-Ox
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSK6v-0006x2-Rz
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:36:15 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:37053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSK6s-0006rf-3L
	for qemu-devel@nongnu.org; Sun, 19 May 2019 07:36:11 -0400
Received: by mail-ed1-x542.google.com with SMTP id w37so18894113edw.4
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=WYlV8yWQuz2UohGoSQMZe62r0D/t4wRPnpzrwuFh5GE=;
	b=gKE7Xej2UlVW5ZWJ67yaObNfR4+p8x4jAXx4VCsr0ZXNGMFyAJbM5cjp10bGcwRE7j
	WLduSgIWUo9oxzy9q4jpuhNb5KEn5Hr29KUfZfWDeRi5KqY35R4xGwtRh9UHDw5dYfl4
	ik9E065n2hPtamM7PWPB+A0Kf8fxHbKw+TleeD/gzq23nH6IPd1ipW9qo6Bfy6ZDEPY3
	mBFVRRKCxmNWXk9SXQh8gVtHH5XF93xOzklnJFQNC7hmldAae3APP2FialnwAEZlQlM3
	a+CgB57N6iLP/2DlU7DPUHNPTVLs5BAhpcLpHHcxFsfuEd1u/DmvBEES10Nxb60lSsZq
	OWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=WYlV8yWQuz2UohGoSQMZe62r0D/t4wRPnpzrwuFh5GE=;
	b=D/wDxIMFXy1EewwOajCESKyZ7Vu7mZ2NZ77Jy+UJtA9MN/HLo01iPuAeGdf5Daoanf
	j3ON/kO63mmkAiHboYacgqmczxvIZwxhQqRNiRHMoQlm0ig0U8myCgn6DDobJaNKHI6d
	I/msvEsGNmu8bHv/XWOSS5l7Ovkn7uVj/uFnjtpKz2gmBFkZkiwLhpr5vqSX4i8eawbb
	x8PblybD69y94PO1YETKlRe9F56vzsRSx9hBwMY/6FJg6ryzpAkudagYQfE54HYfKPde
	SaV8DFqtyKNguf7vofqjsEWtxoOPg/dq51XAH5E+uX1K01cYbILwfAUhQxb1GTK0kqKG
	FVsg==
X-Gm-Message-State: APjAAAWFIE1ZBRMjGa3lFwysp1dpTIjS7yHjKnQaNy1wbx6m0gjClPTM
	bnkASxaiH71IO/lH+bQVpOnGGvcTve7ixmZkqfodN0o4
X-Google-Smtp-Source: APXvYqysfH88rl0LNd+rBvMP+hEhN7CCvXuag76UuPROFmNhRGAcYk8dwJ1Qz+JpvqKjRh0KztbWervQJwQMpjjbVYA=
X-Received: by 2002:a17:906:a950:: with SMTP id
	hh16mr16713787ejb.136.1558265767580; 
	Sun, 19 May 2019 04:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-16-arilou@gmail.com>
	<87k1ermzec.fsf@zen.linaroharston>
In-Reply-To: <87k1ermzec.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Sun, 19 May 2019 14:35:56 +0300
Message-ID: <CAP7QCoiqc+CAUiS0gNQbxKXOoAk7MvDvWpUkoMZxVK04NjBevg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v9 15/27] gdbstub: Implement file io (F
 pkt) with new infra
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

Hi Alex, I did have some issues with the 'F' packet as it's not really
well documented, I suggest changing the schema to:
"L,L,o0"
so basically no support for anything after the first C in the Ctrl-C,
if you have a sample or a documentation that really implements
the F packet fully ill take a look at it and see how the schema should
really look like.

-- Jon.

On Wed, May 15, 2019 at 7:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> There is a bit more going on here than a simple conversion. I think we
> need some additional commentary about the format of the data coming
> back.
>
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
> >  1 file changed, 40 insertions(+), 22 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 3478ac778d..9fe130f30d 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1772,6 +1772,39 @@ static void handle_read_all_regs(GdbCmdContext *=
gdb_ctx, void *user_ctx)
> >      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> >  }
> >
> > +static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    int num_syscall_params;
> > +    GdbCmdVariant syscall_params[3] =3D {};
> > +
> > +    if (!gdb_ctx->num_params) {
> > +        return;
> > +    }
> > +
> > +    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_pa=
rams,
> > +                         &num_syscall_params)) {
> > +        return;
> > +    }
>
> What's going on here? I thought the schema was meant to handle the
> parsing of data. I see bellow we originally parse the command as a null
> terminated string but we actually should handle:
>
>   =E2=80=98Fretcode,errno,Ctrl-C flag;call-specific attachment=E2=80=99
>
> I see the argument for dealing with the call-specific attachment here
> but shouldn't the generic parsing code be able to split everything
> apart?
>
> > +
> > +    if (!num_syscall_params) {
> > +        return;
> > +    }
> > +
> > +    if (gdb_ctx->s->current_syscall_cb) {
> > +        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
> > +                                       (target_ulong)syscall_params[0]=
.val_ull,
> > +                                       (target_ulong)syscall_params[1]=
.val_ull);
> > +        gdb_ctx->s->current_syscall_cb =3D NULL;
> > +    }
>
>
>
> > +
> > +    if (syscall_params[2].opcode =3D=3D (uint8_t)'C') {
> > +        put_packet(gdb_ctx->s, "T02");
> > +        return;
> > +    }
> > +
> > +    gdb_continue(gdb_ctx->s);
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
> > @@ -1913,28 +1946,13 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          return RS_IDLE;
> >      case 'F':
> >          {
> > -            target_ulong ret;
> > -            target_ulong err;
> > -
> > -            ret =3D strtoull(p, (char **)&p, 16);
> > -            if (*p =3D=3D ',') {
> > -                p++;
> > -                err =3D strtoull(p, (char **)&p, 16);
> > -            } else {
> > -                err =3D 0;
> > -            }
> > -            if (*p =3D=3D ',')
> > -                p++;
> > -            type =3D *p;
> > -            if (s->current_syscall_cb) {
> > -                s->current_syscall_cb(s->c_cpu, ret, err);
> > -                s->current_syscall_cb =3D NULL;
> > -            }
> > -            if (type =3D=3D 'C') {
> > -                put_packet(s, "T02");
> > -            } else {
> > -                gdb_continue(s);
> > -            }
> > +            static const GdbCmdParseEntry file_io_cmd_desc =3D {
> > +                .handler =3D handle_file_io,
> > +                .cmd =3D "F",
> > +                .cmd_startswith =3D 1,
> > +                .schema =3D "s0"
> > +            };
> > +            cmd_parser =3D &file_io_cmd_desc;
> >          }
> >          break;
> >      case 'g':
>
>
> --
> Alex Benn=C3=A9e

