Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A4BC07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:37:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A9820815
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 08:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIe7W06u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A9820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42064 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVB8n-0007Kj-UI
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 04:37:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVB80-0006yk-KY
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hVB7z-0001LC-HS
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:37:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hVB7z-0001KU-2u
	for qemu-devel@nongnu.org; Mon, 27 May 2019 04:37:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id f10so7816340wmb.1
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 01:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=fxA0mrc3dKy+GshdWHQku7yrWCCaqs0h67lnbLZuxMc=;
	b=oIe7W06u8IuxWL0qH5JKltmcaVu0AJm0u9cQn5VEVf7WyyHA1KJAl71HxmBGqILCnT
	+1Hxzu4MgY1laOOspPD7cLjKgOAfHjqOBfKZF/TdDp2HoX9lBMYESaVX5eBBnCvNcw+8
	dSzm1QZiHfcFfGzp0W2Dg8Ggj7hcHhLgWkThY/8JBcgWIQ46l9sB0cmAptIlzdH0HZSu
	kZnyWKEedCkt355KESxSgL4lElYMS/Tf5A0+5U+hMSh2vG97dVXDnUmUvFyIFbSlCGi5
	5ZX4oJX3H1L+f9fjezqQsvnUcFwsJIcJndI/C8qkWc7xJ0tngeUSNRlN+xPPngsUqoEn
	cQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=fxA0mrc3dKy+GshdWHQku7yrWCCaqs0h67lnbLZuxMc=;
	b=DRa9TI3Bf4KI/dZCttRulxRzXx0Dj5S6NmbOlSLdvPhyMRT9C7XQMVCJMwgExpmTW2
	/+rGukcCqVf86Y7HoB4JjL+aSZrpN4H/UgOQaoI5WyRD79U6e/K+K2bJSJw6+36yZ4s6
	l3GhJshamLVh37QhkM8LbfE5bnUjSlwAsPfLBbt1VWMRyiatlIU9K98DsGFoiiaGNgP2
	+f7UMck2uLkG5edJulZBXgZaDc+dbor9Aa0EaqrUXr6mZmviGbGB1GXplY2mv1aYw3qB
	GEl8zUkuSyFFIJ0pdsz7o2/ywmaQWOYg30KwDMm63BBo6wZt6ap3zoJAw0wm2NhWb/cQ
	azmg==
X-Gm-Message-State: APjAAAWD5Fu2aZafPiFm3CEqtuqEYNjWJ3T7gTnsw86+GPKfT2FoRu9X
	PxOf+YGXVFmjJ+J3GlCKJqBeaQ==
X-Google-Smtp-Source: APXvYqz4dkib/MuKemo/vruRhDhyrLxcVVqzLrzxITuzCSUwARMaPUOu/xWNaPIgvkGhDGlvQWJbPA==
X-Received: by 2002:a1c:f111:: with SMTP id p17mr25189032wmh.62.1558946225471; 
	Mon, 27 May 2019 01:37:05 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	o6sm29223346wrh.55.2019.05.27.01.37.04
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 27 May 2019 01:37:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 9CA481FF87;
	Mon, 27 May 2019 09:37:03 +0100 (BST)
References: <20190524160118.31134-1-arilou@gmail.com>
	<20190524160118.31134-3-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190524160118.31134-3-arilou@gmail.com>
Date: Mon, 27 May 2019 09:37:03 +0100
Message-ID: <87o93oqonk.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v11 02/20] gdbstub: Implement deatch (D
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 93 +++++++++++++++++++++++++++++++------------------------
>  1 file changed, 53 insertions(+), 40 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index e6d895177b..307366b250 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1413,11 +1413,6 @@ static inline int startswith(const char *string, c=
onst char *pattern)
>    return !strncmp(string, pattern, strlen(pattern));
>  }
>
> -static int process_string_cmd(
> -        GDBState *s, void *user_ctx, const char *data,
> -        const GdbCmdParseEntry *cmds, int num_cmds)
> -        __attribute__((unused));
> -
>  static int process_string_cmd(GDBState *s, void *user_ctx, const char *d=
ata,
>                                const GdbCmdParseEntry *cmds, int num_cmds)
>  {
> @@ -1463,6 +1458,41 @@ static int process_string_cmd(GDBState *s, void *u=
ser_ctx, const char *data,
>      return -1;
>  }
>
> +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    GDBProcess *process;
> +    GDBState *s =3D gdb_ctx->s;
> +    uint32_t pid =3D 1;
> +
> +    if (s->multiprocess) {
> +        if (!gdb_ctx->num_params) {
> +            put_packet(s, "E22");
> +            return;
> +        }
> +
> +        pid =3D gdb_ctx->params[0].val_ul;
> +    }
> +
> +    process =3D gdb_get_process(s, pid);
> +    gdb_process_breakpoint_remove_all(s, process);
> +    process->attached =3D false;
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> +        s->c_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> +        s->g_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (!s->c_cpu) {
> +        /* No more process attached */
> +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
> +        gdb_continue(s);
> +    }
> +    put_packet(s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1477,6 +1507,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      uint8_t *registers;
>      target_ulong addr, len;
>      GDBThreadIdKind thread_kind;
> +    const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
>
> @@ -1577,42 +1608,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          error_report("QEMU: Terminated via GDBstub");
>          exit(0);
>      case 'D':
> -        /* Detach packet */
> -        pid =3D 1;
> -
> -        if (s->multiprocess) {
> -            unsigned long lpid;
> -            if (*p !=3D ';') {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            pid =3D lpid;
> -        }
> -
> -        process =3D gdb_get_process(s, pid);
> -        gdb_process_breakpoint_remove_all(s, process);
> -        process->attached =3D false;
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> -            s->c_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> -            s->g_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (s->c_cpu =3D=3D NULL) {
> -            /* No more process attached */
> -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
> -            gdb_continue(s);
> +        {
> +            static const GdbCmdParseEntry detach_cmd_desc =3D {
> +                .handler =3D handle_detach,
> +                .cmd =3D "D",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "?.l0"
> +            };
> +            cmd_parser =3D &detach_cmd_desc;
>          }
> -        put_packet(s, "OK");
>          break;
>      case 's':
>          if (*p !=3D '\0') {
> @@ -1985,6 +1989,15 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
>          put_packet(s, buf);
>          break;
>      }
> +
> +    if (cmd_parser) {
> +        /* helper will respond */
> +        process_string_cmd(s, NULL, line_buf, cmd_parser, 1);
> +    } else {
> +        /* unknown command, empty respone */
> +        put_packet(s, "");
> +    }
> +
>      return RS_IDLE;
>  }


--
Alex Benn=C3=A9e

