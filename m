Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDCC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 04:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47A4216B7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 04:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4B89qhW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47A4216B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46443 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSwhr-00050N-I8
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 00:48:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSwh2-0004hL-T0
	for qemu-devel@nongnu.org; Tue, 21 May 2019 00:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSwh1-0008KD-Ll
	for qemu-devel@nongnu.org; Tue, 21 May 2019 00:48:04 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34422)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSwh1-0008IG-CU
	for qemu-devel@nongnu.org; Tue, 21 May 2019 00:48:03 -0400
Received: by mail-ed1-x541.google.com with SMTP id p27so27319099eda.1
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 21:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=1zCVgd5kypxgGbVAIP+vwPM2UHntr6IerTr49YGyuc8=;
	b=C4B89qhWLOvQQYJajAMrItcv/gIKO50QHnU+t+hkHEyvjIEnVE0T9OSl5p/T4OTKuH
	msnZ15wnaJoq327JXjk72tJjjC+zPLWBL+zRWRbc2MkG62zyifVyMcuMtz10f0BdOjNH
	5oaBqCWJrItmJ69X+LZHOVZxl38++DiIdIf7FsyIV39Ug84c5ruxBQyNXB8ME3as7GyL
	ljJiBttk39VeoROPCceykV/6SyYh8rTYY3rYIdzD0CU+vq0o6jk1Nok8qNIcYWpV13CI
	f4H1zPGSfXR5JPXlTKul1viPabJBrkjEA2+hQ1Qbl/axFHlscoMpWepT02CdHI2kffnt
	wpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=1zCVgd5kypxgGbVAIP+vwPM2UHntr6IerTr49YGyuc8=;
	b=RdU0VPmK0BMTH57/yoCsrWY/F7S7yOkkCuQaaV98Ej7xX/ME/utxkBzRTz/vZFLe9z
	r5Y3gMUoGEcb0uU/nPuCgjsOvO0FsV30Te7qHr8okysMSsaJHHN/vUi5n5L9JcEWjEnq
	+ojqh1M6oK3FnR9rsA2V9/4tXXJjAFQbrZlY2zhy0kCxGq+zaYKhWDl8DrrNFJACGbkW
	1hC9tX1GBZiW8mG71Dy2yvTfb9Us4BA6nDkIqUVP6EqAA8UEFm4hGGL8tqQIEMEAkOml
	77T6XSPK0HTa8GuCOAfW7CDl95YFE9xO4OucJ1Jqvo41JEskUnBmJeD6Mn28AJ8RCEA3
	i/Ig==
X-Gm-Message-State: APjAAAVSt00ql4i3oRHE2d/ucjp/5UTDUNprHD6muk9lgtgzHCgxS1H8
	+xfI8hfVDtm7q9EfFppGydfzSgv5zcw+7kYdZzY=
X-Google-Smtp-Source: APXvYqwrEzq+8rXgVjVwKJHDm4FEIi/3+Y+KeOdX6SRJIOHapK25h2SvrN4kjNG+zGYfZtdhw2VSY87E93e0UZU9NAs=
X-Received: by 2002:a50:9184:: with SMTP id g4mr69263269eda.65.1558414081455; 
	Mon, 20 May 2019 21:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-3-arilou@gmail.com>
	<877easooi3.fsf@zen.linaroharston>
In-Reply-To: <877easooi3.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Tue, 21 May 2019 07:47:50 +0300
Message-ID: <CAP7QCoha=nGJQGGDVkdVtrKNxmP9gyCEekHFH37O5yj6QYHz6Q@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::541
Subject: Re: [Qemu-devel] [PATCH v9 02/27] gdbstub: Implement deatch (D pkt)
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

Hi Alex, I implemented this change but i'm having second guesses on
this, basically a NULL packet means the command is not supported (as
far as i understand from the protocol documentation and implementation
of GDB)
That being said I think it's correct to send back a NULL packet if
process_string_cmd fails for any reason, or you would prefer ill just
omit it?

Snippet of the change I did according to your review:
-    if (cmd_parser &&
-        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
-        put_packet(s, "");
+    if (!cmd_parser) {
+        return RS_IDLE;
     }

+    process_string_cmd(s, NULL, line_buf, cmd_parser, 1);

-- Jon.

On Tue, May 14, 2019 at 9:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 90 ++++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 50 insertions(+), 40 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index d5e0f3878a..621d689868 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -1418,11 +1418,6 @@ static inline int startswith(const char *string,=
 const char *pattern)
> >    return !strncmp(string, pattern, strlen(pattern));
> >  }
> >
> > -static int process_string_cmd(
> > -        GDBState *s, void *user_ctx, const char *data,
> > -        const GdbCmdParseEntry *cmds, int num_cmds)
> > -        __attribute__((unused));
> > -
> >  static int process_string_cmd(GDBState *s, void *user_ctx, const char =
*data,
> >                                const GdbCmdParseEntry *cmds, int num_cm=
ds)
> >  {
> > @@ -1468,6 +1463,41 @@ static int process_string_cmd(GDBState *s, void =
*user_ctx, const char *data,
> >      return -1;
> >  }
> >
> > +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    GDBProcess *process;
> > +    GDBState *s =3D gdb_ctx->s;
> > +    uint32_t pid =3D 1;
> > +
> > +    if (s->multiprocess) {
> > +        if (!gdb_ctx->num_params) {
> > +            put_packet(s, "E22");
> > +            return;
> > +        }
> > +
> > +        pid =3D gdb_ctx->params[0].val_ul;
> > +    }
> > +
> > +    process =3D gdb_get_process(s, pid);
> > +    gdb_process_breakpoint_remove_all(s, process);
> > +    process->attached =3D false;
> > +
> > +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> > +        s->c_cpu =3D gdb_first_attached_cpu(s);
> > +    }
> > +
> > +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> > +        s->g_cpu =3D gdb_first_attached_cpu(s);
> > +    }
> > +
> > +    if (!s->c_cpu) {
> > +        /* No more process attached */
> > +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
> > +        gdb_continue(s);
> > +    }
> > +    put_packet(s, "OK");
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      CPUState *cpu;
> > @@ -1482,6 +1512,7 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
> >      uint8_t *registers;
> >      target_ulong addr, len;
> >      GDBThreadIdKind thread_kind;
> > +    const GdbCmdParseEntry *cmd_parser =3D NULL;
> >
> >      trace_gdbstub_io_command(line_buf);
> >
> > @@ -1582,42 +1613,15 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          error_report("QEMU: Terminated via GDBstub");
> >          exit(0);
> >      case 'D':
> > -        /* Detach packet */
> > -        pid =3D 1;
> > -
> > -        if (s->multiprocess) {
> > -            unsigned long lpid;
> > -            if (*p !=3D ';') {
> > -                put_packet(s, "E22");
> > -                break;
> > -            }
> > -
> > -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
> > -                put_packet(s, "E22");
> > -                break;
> > -            }
> > -
> > -            pid =3D lpid;
> > -        }
> > -
> > -        process =3D gdb_get_process(s, pid);
> > -        gdb_process_breakpoint_remove_all(s, process);
> > -        process->attached =3D false;
> > -
> > -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> > -            s->c_cpu =3D gdb_first_attached_cpu(s);
> > -        }
> > -
> > -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> > -            s->g_cpu =3D gdb_first_attached_cpu(s);
> > -        }
> > -
> > -        if (s->c_cpu =3D=3D NULL) {
> > -            /* No more process attached */
> > -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
> > -            gdb_continue(s);
> > +        {
> > +            static const GdbCmdParseEntry detach_cmd_desc =3D {
> > +                .handler =3D handle_detach,
> > +                .cmd =3D "D",
> > +                .cmd_startswith =3D 1,
> > +                .schema =3D "?.l0"
> > +            };
> > +            cmd_parser =3D &detach_cmd_desc;
> >          }
> > -        put_packet(s, "OK");
> >          break;
> >      case 's':
> >          if (*p !=3D '\0') {
> > @@ -1990,6 +1994,12 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
> >          put_packet(s, buf);
> >          break;
> >      }
> > +
> > +    if (cmd_parser &&
> > +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
> > +        put_packet(s, "");
>
> Why this null put_packet at the end? You've passed the handling of the
> OK reply back to your handler so this seems superfluous.
>
> --
> Alex Benn=C3=A9e

