Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63981C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216DD2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 07:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AM1J7sRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216DD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47965 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSysy-00062t-Ct
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 03:08:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSyUR-0000uR-JI
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:43:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hSyUQ-0000jZ-8s
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:43:11 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hSyUP-0000iX-Uc
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:43:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id g12so16853539wro.8
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=DGnw+X0qgmTX2ZZDdRi8N0Jy0VN2NNOy3Y0n7J1VRcc=;
	b=AM1J7sRMhheXV5EKKeTLgLM/DC9L7jzGHROboD4rSGa4zYkdEhWkEguvwpXW003JZ5
	UwhL1608SRpsK6uF2lc9+4RkVbIY6o8UwW0Af7fTJ3rLpxKhFrvcJ1QXph4zQgnNtucp
	lnZRUKXvyvLT+5JX8RdvdHeI1M8Fu48WvTOHlogg9CWkqq5mVHuHAP3NZKDGjop0a+MA
	kGFpJ+U1L7guA8vanheViCg/5KpvWZKqODaOFgEr2u6scfa9zdfwZ63WkdJLhGBApxtW
	bp2tqPW2vAg0mgY3AD9GuN+CuQ1Z1dX6e4DB2fUm/CJrwEuCM4lCD737bfP2v0oCts4f
	0RKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=DGnw+X0qgmTX2ZZDdRi8N0Jy0VN2NNOy3Y0n7J1VRcc=;
	b=VP4BzG5yJfm+83V2OFc6JCsZdmQYERk8EbcoVG3t/oH9rP8DwEwf2DvN09W1qtMurH
	9a8z1C2zghnz/gZAq9Mm59VNO4pCMxHXpxvr8jo4BJc1y1ils7Q9xc+eszmzoKkhwRbH
	gopP6CPeI/Y5x6iA52nYGsFEHyf55CPkyXm9/QvpGyahevbdQBQFHrqrLAGmGhoT3K/I
	Kt8gVv8jiM5HlkbT6Ezg+9QQaz34VpfbTVvJq+x54+eamqccLJs1L0I3gmT8JPhRQMdd
	3RCIxkbH4pZ/0SNFzEKqNaK+2NCp5vXjBK1KwtAMm8RBh1Ekal/N5sFyaFXZXXtDjCjG
	buow==
X-Gm-Message-State: APjAAAXfMQOlbWvcE81TNCyOciH5xLTXj+eMdzLEoDDA2lSBfrBSBXhr
	Q72N3R43CpaZVFQ2scoGlpOuPw==
X-Google-Smtp-Source: APXvYqwZO+vD3doNtV2hwlplIxiI7WomZsN6cxxdnbsuxDJoCYG9dlsdkd7z6z+T5n1KxANMYz9c4A==
X-Received: by 2002:adf:b447:: with SMTP id v7mr47806822wrd.267.1558420987479; 
	Mon, 20 May 2019 23:43:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w18sm16035305wru.15.2019.05.20.23.43.06
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 20 May 2019 23:43:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 76BEE1FF87;
	Tue, 21 May 2019 07:43:06 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-3-arilou@gmail.com>
	<877easooi3.fsf@zen.linaroharston>
	<CAP7QCoha=nGJQGGDVkdVtrKNxmP9gyCEekHFH37O5yj6QYHz6Q@mail.gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <CAP7QCoha=nGJQGGDVkdVtrKNxmP9gyCEekHFH37O5yj6QYHz6Q@mail.gmail.com>
Date: Tue, 21 May 2019 07:43:06 +0100
Message-ID: <87imu4gvet.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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


Jon Doron <arilou@gmail.com> writes:

> Hi Alex, I implemented this change but i'm having second guesses on
> this, basically a NULL packet means the command is not supported (as
> far as i understand from the protocol documentation and implementation
> of GDB)
> That being said I think it's correct to send back a NULL packet if
> process_string_cmd fails for any reason, or you would prefer ill just
> omit it?
>
> Snippet of the change I did according to your review:
> -    if (cmd_parser &&
> -        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
> -        put_packet(s, "");
> +    if (!cmd_parser) {
> +        return RS_IDLE;
>      }
>
> +    process_string_cmd(s, NULL, line_buf, cmd_parser, 1);

OK I see your reasoning. So perhaps:

   if (cmd_parser) {
      /* helper will respond */
      process_string_cmd(s, NULL, line_buf, cmd_parser, 1)
   } else {
      /* unknown command, empty response */
      put_packet(s, "");
   }

   return RS_IDLE;
>
> -- Jon.
>
> On Tue, May 14, 2019 at 9:54 PM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>>
>> Jon Doron <arilou@gmail.com> writes:
>>
>> > Signed-off-by: Jon Doron <arilou@gmail.com>
>> > ---
>> >  gdbstub.c | 90 ++++++++++++++++++++++++++++++-------------------------
>> >  1 file changed, 50 insertions(+), 40 deletions(-)
>> >
>> > diff --git a/gdbstub.c b/gdbstub.c
>> > index d5e0f3878a..621d689868 100644
>> > --- a/gdbstub.c
>> > +++ b/gdbstub.c
>> > @@ -1418,11 +1418,6 @@ static inline int startswith(const char *string=
, const char *pattern)
>> >    return !strncmp(string, pattern, strlen(pattern));
>> >  }
>> >
>> > -static int process_string_cmd(
>> > -        GDBState *s, void *user_ctx, const char *data,
>> > -        const GdbCmdParseEntry *cmds, int num_cmds)
>> > -        __attribute__((unused));
>> > -
>> >  static int process_string_cmd(GDBState *s, void *user_ctx, const char=
 *data,
>> >                                const GdbCmdParseEntry *cmds, int num_c=
mds)
>> >  {
>> > @@ -1468,6 +1463,41 @@ static int process_string_cmd(GDBState *s, void=
 *user_ctx, const char *data,
>> >      return -1;
>> >  }
>> >
>> > +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
>> > +{
>> > +    GDBProcess *process;
>> > +    GDBState *s =3D gdb_ctx->s;
>> > +    uint32_t pid =3D 1;
>> > +
>> > +    if (s->multiprocess) {
>> > +        if (!gdb_ctx->num_params) {
>> > +            put_packet(s, "E22");
>> > +            return;
>> > +        }
>> > +
>> > +        pid =3D gdb_ctx->params[0].val_ul;
>> > +    }
>> > +
>> > +    process =3D gdb_get_process(s, pid);
>> > +    gdb_process_breakpoint_remove_all(s, process);
>> > +    process->attached =3D false;
>> > +
>> > +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
>> > +        s->c_cpu =3D gdb_first_attached_cpu(s);
>> > +    }
>> > +
>> > +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
>> > +        s->g_cpu =3D gdb_first_attached_cpu(s);
>> > +    }
>> > +
>> > +    if (!s->c_cpu) {
>> > +        /* No more process attached */
>> > +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
>> > +        gdb_continue(s);
>> > +    }
>> > +    put_packet(s, "OK");
>> > +}
>> > +
>> >  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>> >  {
>> >      CPUState *cpu;
>> > @@ -1482,6 +1512,7 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>> >      uint8_t *registers;
>> >      target_ulong addr, len;
>> >      GDBThreadIdKind thread_kind;
>> > +    const GdbCmdParseEntry *cmd_parser =3D NULL;
>> >
>> >      trace_gdbstub_io_command(line_buf);
>> >
>> > @@ -1582,42 +1613,15 @@ static int gdb_handle_packet(GDBState *s, cons=
t char *line_buf)
>> >          error_report("QEMU: Terminated via GDBstub");
>> >          exit(0);
>> >      case 'D':
>> > -        /* Detach packet */
>> > -        pid =3D 1;
>> > -
>> > -        if (s->multiprocess) {
>> > -            unsigned long lpid;
>> > -            if (*p !=3D ';') {
>> > -                put_packet(s, "E22");
>> > -                break;
>> > -            }
>> > -
>> > -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
>> > -                put_packet(s, "E22");
>> > -                break;
>> > -            }
>> > -
>> > -            pid =3D lpid;
>> > -        }
>> > -
>> > -        process =3D gdb_get_process(s, pid);
>> > -        gdb_process_breakpoint_remove_all(s, process);
>> > -        process->attached =3D false;
>> > -
>> > -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
>> > -            s->c_cpu =3D gdb_first_attached_cpu(s);
>> > -        }
>> > -
>> > -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
>> > -            s->g_cpu =3D gdb_first_attached_cpu(s);
>> > -        }
>> > -
>> > -        if (s->c_cpu =3D=3D NULL) {
>> > -            /* No more process attached */
>> > -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
>> > -            gdb_continue(s);
>> > +        {
>> > +            static const GdbCmdParseEntry detach_cmd_desc =3D {
>> > +                .handler =3D handle_detach,
>> > +                .cmd =3D "D",
>> > +                .cmd_startswith =3D 1,
>> > +                .schema =3D "?.l0"
>> > +            };
>> > +            cmd_parser =3D &detach_cmd_desc;
>> >          }
>> > -        put_packet(s, "OK");
>> >          break;
>> >      case 's':
>> >          if (*p !=3D '\0') {
>> > @@ -1990,6 +1994,12 @@ static int gdb_handle_packet(GDBState *s, const=
 char *line_buf)
>> >          put_packet(s, buf);
>> >          break;
>> >      }
>> > +
>> > +    if (cmd_parser &&
>> > +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1)) {
>> > +        put_packet(s, "");
>>
>> Why this null put_packet at the end? You've passed the handling of the
>> OK reply back to your handler so this seems superfluous.
>>
>> --
>> Alex Benn=C3=A9e


--
Alex Benn=C3=A9e

