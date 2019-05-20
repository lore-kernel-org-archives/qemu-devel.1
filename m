Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A58DC04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 04:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39AE204FD
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 04:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv6BzB21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39AE204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSa5E-0000hV-5C
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 00:39:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSa4M-0000K9-VP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSa4L-00077O-9L
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:38:38 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSa4K-0006zm-45
	for qemu-devel@nongnu.org; Mon, 20 May 2019 00:38:36 -0400
Received: by mail-ed1-x544.google.com with SMTP id a8so21766697edx.3
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 21:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=5LC74d92z21iJoEb1y4gcGzYNS8SctOPUfuAcpViwnE=;
	b=Nv6BzB21Jhjn2G+NPJjgSZFve38W9EIl2z30X2mcheCaBs4sIBAHhZxfWPAu/4cnWv
	+mGoHq+vqHCd+1tCZ3wl1/QLqh+B6yeR5nK0rDXzVchgbNJf80rZdoHm5vPLNXGnn6CZ
	0Lhl+VjJU7Xj8MnNem99gwI1jXSZ1JFNoVSHeRKO9oSXJIW1Mw39j8dNCpRPaiDLnYzI
	dU7EGKnsrv26I6ZC/mUUg44ierMCKtj/Q5mGT3NAiYl5dZboggFERCgi4zCBHnOtwvLb
	AOhIDjlIKtR6/5xVAAoDjEUyNYmswB9U4OI1QbAGK/3G/gbD40Q7tzw4XAqlq0fxsCmT
	iWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=5LC74d92z21iJoEb1y4gcGzYNS8SctOPUfuAcpViwnE=;
	b=cNBYw5zaQYOUlf3QtVk2Q25Ngyrj2X0iAGb9rPe7RV76K7Xg8TWwV6wE/epqYJU73D
	M+bKZjZ2ypyu69tn8JQ7krb2Hrmvakm9EYa0PrOS9GrxFTE5AemUshJ0jjuVjYG/AOFj
	Fl8N9qEaERz9NxIjJaYQ+bWHQSvHj1bmaIotu63/Mvz+37hgftUAApOqYygvBpsxsTvg
	r1GXQ2QDBzR8x+UeA9Xn9eVkOWkkxoA4o+070UkPdrFhPCcuKvkzfYTjzBX6w46cIFzU
	g4/VNuFk0kjIrxqOs/l7fUwjrRMOKRe8yEOwMRrKAL61TqqhDRn5aS4DsGO6TwyP/qVr
	q3uQ==
X-Gm-Message-State: APjAAAWye+9A2LdZXv6zcEeMWkUttXkgdChmGkq8Swlm86iirXT783k7
	MXZSeAnid4760NY2nkG5Ek90JFD+hSf/bat/UAI=
X-Google-Smtp-Source: APXvYqy5leowMRFX3ydktGRUEky1ct0H5Dya7y1M4NgqSy1KMKQMNoYRaMOGa7sY4iIFMGfEZ9L2gif9knmb6eJF5sE=
X-Received: by 2002:a50:86a2:: with SMTP id r31mr72121329eda.259.1558327110841;
	Sun, 19 May 2019 21:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-18-arilou@gmail.com>
	<87h89vmytv.fsf@zen.linaroharston>
In-Reply-To: <87h89vmytv.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 20 May 2019 07:38:19 +0300
Message-ID: <CAP7QCojRi77yPMsB2aLYSszz_QrMNzsN-wYLiTSBhW18Ggyd1A@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH v9 17/27] gdbstub: Implement v commands
 with new infra
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

On Wed, May 15, 2019 at 8:06 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 170 +++++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 110 insertions(+), 60 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 9b0556f8be..d56d0fd235 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1815,6 +1815,106 @@ static void handle_step(GdbCmdContext *gdb_ctx,=
 void *user_ctx)
> >      gdb_continue(gdb_ctx->s);
> >  }
> >
> > +static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx=
)
> > +{
> > +    put_packet(gdb_ctx->s, "vCont;c;C;s;S");
> > +}
> > +
> > +static void handle_v_cont(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    int res;
> > +
> > +    if (!gdb_ctx->num_params) {
> > +        return;
> > +    }
> > +
> > +    res =3D gdb_handle_vcont(gdb_ctx->s, gdb_ctx->params[0].data);
> > +    if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
> > +        put_packet(gdb_ctx->s, "E22");
> > +    } else if (res) {
> > +        put_packet(gdb_ctx->s, "\0");
>
> Isn't this just ""?
>
> Either way my reading of the spec say the response needs to be a "Stop
> Reply Packet" which I don't think includes empty or E codes.
>

From my understanding reading the spec and the gdbserver
implementation in binutils a null packet tells the client
the command is unsupported, so it makes sense to reply with this null
packet if handle_vcont replied with something
we dont know (i.e -ENOTSUP)

> > +    }
> > +}
> > +
> > +static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    GDBProcess *process;
> > +    CPUState *cpu;
> > +    char thread_id[16];
> > +
> > +    strcpy(gdb_ctx->str_buf, "E22");
>
> pstrcpy (see HACKING about strncpy) but...
>
> > +    if (!gdb_ctx->num_params) {
> > +        goto cleanup;
> > +    }
> > +
> > +    process =3D gdb_get_process(gdb_ctx->s, gdb_ctx->params[0].val_ul)=
;
> > +    if (!process) {
> > +        goto cleanup;
> > +    }
> > +
> > +    cpu =3D get_first_cpu_in_process(gdb_ctx->s, process);
> > +    if (!cpu) {
> > +        goto cleanup;
> > +    }
> > +
> > +    process->attached =3D true;
> > +    gdb_ctx->s->g_cpu =3D cpu;
> > +    gdb_ctx->s->c_cpu =3D cpu;
> > +
> > +    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
> > +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:=
%s;",
> > +             GDB_SIGNAL_TRAP, thread_id);
>
> again this would be an argument for using GString to build-up our reply p=
ackets.
>
Perhaps we will need to make another patchset which fixes all the
strings/buffers stuff and move to Glib
but like you said probably too much for this patchset
> > +cleanup:
> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> > +}
> > +
> > +static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    /* Kill the target */
> > +    put_packet(gdb_ctx->s, "OK");
> > +    error_report("QEMU: Terminated via GDBstub");
> > +    exit(0);
> > +}
> > +
> > +static GdbCmdParseEntry gdb_v_commands_table[] =3D {
> > +    /* Order is important if has same prefix */
> > +    {
> > +        .handler =3D handle_v_cont_query,
> > +        .cmd =3D "Cont?",
> > +        .cmd_startswith =3D 1
> > +    },
> > +    {
> > +        .handler =3D handle_v_cont,
> > +        .cmd =3D "Cont",
> > +        .cmd_startswith =3D 1,
> > +        .schema =3D "s0"
> > +    },
> > +    {
> > +        .handler =3D handle_v_attach,
> > +        .cmd =3D "Attach;",
> > +        .cmd_startswith =3D 1,
> > +        .schema =3D "l0"
> > +    },
> > +    {
> > +        .handler =3D handle_v_kill,
> > +        .cmd =3D "Kill;",
> > +        .cmd_startswith =3D 1
> > +    },
> > +};
> > +
> > +static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    if (!gdb_ctx->num_params) {
> > +        return;
> > +    }
> > +
> > +    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> > +                           gdb_v_commands_table,
> > +                           ARRAY_SIZE(gdb_v_commands_table))) {
> > +        put_packet(gdb_ctx->s, "");
> > +    }
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
> > @@ -1822,7 +1922,7 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
> >      CPUClass *cc;
> >      const char *p;
> >      uint32_t pid, tid;
> > -    int ch, type, res;
> > +    int ch, type;
> >      uint8_t mem_buf[MAX_PACKET_LENGTH];
> >      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> >      char thread_id[16];
> > @@ -1871,66 +1971,16 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          }
> >          break;
> >      case 'v':
> > -        if (strncmp(p, "Cont", 4) =3D=3D 0) {
> > -            p +=3D 4;
> > -            if (*p =3D=3D '?') {
> > -                put_packet(s, "vCont;c;C;s;S");
> > -                break;
> > -            }
> > -
> > -            res =3D gdb_handle_vcont(s, p);
> > -
> > -            if (res) {
> > -                if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
> > -                    put_packet(s, "E22");
> > -                    break;
> > -                }
> > -                goto unknown_command;
> > -            }
> > -            break;
> > -        } else if (strncmp(p, "Attach;", 7) =3D=3D 0) {
> > -            unsigned long pid;
> > -
> > -            p +=3D 7;
> > -
> > -            if (qemu_strtoul(p, &p, 16, &pid)) {
> > -                put_packet(s, "E22");
> > -                break;
> > -            }
> > -
> > -            process =3D gdb_get_process(s, pid);
> > -
> > -            if (process =3D=3D NULL) {
> > -                put_packet(s, "E22");
> > -                break;
> > -            }
> > -
> > -            cpu =3D get_first_cpu_in_process(s, process);
> > -
> > -            if (cpu =3D=3D NULL) {
> > -                /* Refuse to attach an empty process */
> > -                put_packet(s, "E22");
> > -                break;
> > -            }
> > -
> > -            process->attached =3D true;
> > -
> > -            s->g_cpu =3D cpu;
> > -            s->c_cpu =3D cpu;
> > -
> > -            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_T=
RAP,
> > -                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(threa=
d_id)));
> > -
> > -            put_packet(s, buf);
> > -            break;
> > -        } else if (strncmp(p, "Kill;", 5) =3D=3D 0) {
> > -            /* Kill the target */
> > -            put_packet(s, "OK");
> > -            error_report("QEMU: Terminated via GDBstub");
> > -            exit(0);
> > -        } else {
> > -            goto unknown_command;
> > +        {
> > +            static const GdbCmdParseEntry v_cmd_desc =3D {
> > +                .handler =3D handle_v_commands,
> > +                .cmd =3D "v",
> > +                .cmd_startswith =3D 1,
> > +                .schema =3D "s0"
> > +            };
> > +            cmd_parser =3D &v_cmd_desc;
> >          }
> > +        break;
> >      case 'k':
> >          /* Kill the target */
> >          error_report("QEMU: Terminated via GDBstub");
>
>
> --
> Alex Benn=C3=A9e

