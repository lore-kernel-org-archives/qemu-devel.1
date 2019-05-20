Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BF1C04AAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5E720657
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 05:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYGbGkp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5E720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSavW-00055X-TT
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 01:33:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSauc-0004m2-Tg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arilou@gmail.com>) id 1hSaub-0000FG-S8
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:32:38 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <arilou@gmail.com>) id 1hSaua-0000CI-OY
	for qemu-devel@nongnu.org; Mon, 20 May 2019 01:32:37 -0400
Received: by mail-ed1-x543.google.com with SMTP id w11so21886067edl.5
	for <qemu-devel@nongnu.org>; Sun, 19 May 2019 22:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=1rCbEbxNrWTYExrlZzXoKaFCuPkcn93yqVGXLgOpGTI=;
	b=pYGbGkp67QwXu0Z9RqIEDSt7NywoxkuNpsQu8viM7qhtprGqrBOALXPew7fMUlvskX
	CJTnfp8qbhkDZaxiQfxPlO8708ariQo3N3iZUK/UrDa2Rbhaj376tdsE5jTx7gg9R8zP
	fuHNSNBVDNglHZKcyOL9BwXijFS1b9h5SGWPURmD4OYIkg6K+lBC+GBxkEWg9fhi8Or5
	MrM/zJgJqYiqAElych7FfKlarFb660XCRNqlnCqp057vSM/lANT80I4bxmNxp1JEdkUX
	rVyGFG92opSZ1C45Z1Qddy+9jKEbFwtM2iVWvniBp5vOoBFYFS9EOheVAxLNODs+/4R+
	vzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=1rCbEbxNrWTYExrlZzXoKaFCuPkcn93yqVGXLgOpGTI=;
	b=T5kxG+45CM7jY8bBDsu11topF1/I2l+5EidcQZWwrBwGKWjpJHwXONw9qs4LMKhWVX
	H5VILpZZEw7u1tvR2B6Hq0GJf4EFzyu9opZib4+R08v3WR2XB/fY8IzaFIFrqXUSFmse
	kbfs6tOXyihRhRxVglAseVBjQC5J11E04XUhaPk72g83Rjv4zwGqCMMrdH0K7ibSOQtZ
	Tjgmpm5pl0L5IHsw8v/1kUUY/u0mpcRvglZEgsOWud2nGzWPFVBj2QeR5D9Pps+tD+1b
	Z0KEUgLtkaf7iGY0LffUFnWYcQkB6P79h2Vetop6AXE6DVhLb4eB69QxbJQlJNVPpTMR
	zjyw==
X-Gm-Message-State: APjAAAXumxGX/lb4VobyNTmEVqU8B2ogTYL6vsytXxOTZ6c/7nCxAWKG
	oPxf7TLLz2VS7jz4SyDn9FW4CnVxhSTfWYFq4OI=
X-Google-Smtp-Source: APXvYqxEdUmed+ud6YhE2tyQYZ7lNjW+6Et+HcUS8TSsXTgwVn7pcosiX/Vjs7eeBTmeh7EvSlf3VAocKVinYrQy4kY=
X-Received: by 2002:a17:907:20cd:: with SMTP id
	qq13mr31690070ejb.170.1558330354254; 
	Sun, 19 May 2019 22:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-21-arilou@gmail.com>
	<87ef4zmy7b.fsf@zen.linaroharston>
In-Reply-To: <87ef4zmy7b.fsf@zen.linaroharston>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 20 May 2019 08:32:23 +0300
Message-ID: <CAP7QCohHS+VvbvZENPeuvfVc=TNtvwoiA+6dgZO4XoZs4skXuw@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v9 20/27] gdbstub: Implement target halted
 (? pkt) with new infra
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

On Wed, May 15, 2019 at 8:20 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
>
> Jon Doron <arilou@gmail.com> writes:
>
> > Signed-off-by: Jon Doron <arilou@gmail.com>
> > ---
> >  gdbstub.c | 36 ++++++++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/gdbstub.c b/gdbstub.c
> > index 2fd0d66f4d..d678191705 100644
> > --- a/gdbstub.c
> > +++ b/gdbstub.c
> > @@ -2239,13 +2239,30 @@ static void handle_gen_set(GdbCmdContext *gdb_c=
tx, void *user_ctx)
> >      put_packet(gdb_ctx->s, "");
> >  }
> >
> > +static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
> > +{
> > +    char thread_id[16];
> > +
> > +    /* TODO: Make this return the correct value for user-mode.  */
>
> Can this be cleaned up as we convert?
>

To be honest i have no idea what the "correct value" is or how to get
it, can you tell me what it should be and ill add it to the patch?

> > +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
> > +                      sizeof(thread_id));
> > +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:=
%s;",
> > +             GDB_SIGNAL_TRAP, thread_id);
> > +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> > +    /*
> > +     * Remove all the breakpoints when this query is issued,
> > +     * because gdb is doing and initial connect and the state
>
> s/and/an/
>
> > +     * should be cleaned up.
> > +     */
> > +    gdb_breakpoint_remove_all();
> > +}
> > +
> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
> >  {
> >      const char *p;
> >      int ch;
> >      uint8_t mem_buf[MAX_PACKET_LENGTH];
> >      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> > -    char thread_id[16];
> >      const GdbCmdParseEntry *cmd_parser =3D NULL;
> >
> >      trace_gdbstub_io_command(line_buf);
> > @@ -2257,15 +2274,14 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
> >          put_packet(s, "OK");
> >          break;
> >      case '?':
> > -        /* TODO: Make this return the correct value for user-mode.  */
> > -        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> > -                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thre=
ad_id)));
> > -        put_packet(s, buf);
> > -        /* Remove all the breakpoints when this query is issued,
> > -         * because gdb is doing and initial connect and the state
> > -         * should be cleaned up.
> > -         */
> > -        gdb_breakpoint_remove_all();
> > +        {
> > +            static const GdbCmdParseEntry target_halted_cmd_desc =3D {
> > +                .handler =3D handle_target_halt,
> > +                .cmd =3D "?",
> > +                .cmd_startswith =3D 1
> > +            };
> > +            cmd_parser =3D &target_halted_cmd_desc;
> > +        }
> >          break;
> >      case 'c':
> >          {
>
>
> --
> Alex Benn=C3=A9e

