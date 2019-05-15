Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC2CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C62E2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycFF3KR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C62E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40026 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxNp-0002Z1-Lf
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:08:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxMm-000235-MR
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxMl-000358-DB
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:06:56 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxMl-000338-5p
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:06:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id b18so279152wrq.12
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=X15hyvndQ6S5DZGqG1gigFqXBO6g+EXWPbBa+S0gP2I=;
	b=ycFF3KR2dYDm23kHEMHkTP75eeWHMN1SqWgr0YsN2hP+V+ZmTAiFfHdyckGb0ua6NF
	LzKrswgS1GXAmavHGyK3RpE85QVt/p4IAbiKcqROmX4jqXALhCnYC47r1ZYSHsG8D+Sq
	k3NEIG3vQh/1RIGpycxIJKdZNwR3ZYOweahEuc1IiA8QrSoB2r+v/ELHpqDkc8rcdWet
	2TQnDrslRqAPcmJTtkuynb2KyeC9qakcSoZCpox9BVSQvw5HUExYl/TaRXR8vIeDVQdC
	CLy4RO1Ra7iQHh2TXGOAj7DkIhKipb1XKp4dtW8bMupPvOjjwO6n9Yq86bP46XBLybKA
	CzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=X15hyvndQ6S5DZGqG1gigFqXBO6g+EXWPbBa+S0gP2I=;
	b=HCk5p0vz1k8XLm0EcFXDys+31MBJUV977+tVfSJacGrSt3UdFPayO8Jb85PzMGLQDZ
	tStJNkt6hGJMyyvHfS6IYNMOqUbujUzM+qeTlsqADsSte0F+P2PY264N/ymx7bBusJWQ
	+6tt5SzyWUh/TcGoLi8iMI0wW39xa2WPwFaNm0LwJh+ZKXZxAxTuJkblPaPp8t7bNEe0
	P/ZRVd6P0MrqVXZaFXBnHb6aZZ/zwp9+wERETDQnG5lrl1ZweEqf69J0HFhj/Ns2a+MX
	fh7ld8sDY0zh5RpGe7cA3UFYPxkWR00GokKldo9CshGZ5h9Ft+NafL1w6GoTRbTkto5S
	kAlw==
X-Gm-Message-State: APjAAAUtYrjDm5Ify+QaKaW/djmf+k8berAbCcZ2IL3Pr+WbOq0Ec367
	gAEt/phmrWHf80FhQvGEmwO/fw==
X-Google-Smtp-Source: APXvYqxnulQsSltZRnCiKJyPN0hsHw8qqkuTdN3VX3jBzdgMqQVOwXG/ryvtvBWObQOLNvoTXCUZuA==
X-Received: by 2002:a5d:618b:: with SMTP id j11mr27204838wru.36.1557940013486; 
	Wed, 15 May 2019 10:06:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id e8sm5286639wrc.34.2019.05.15.10.06.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:06:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 8A40F1FF87;
	Wed, 15 May 2019 18:06:52 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-18-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-18-arilou@gmail.com>
Date: Wed, 15 May 2019 18:06:52 +0100
Message-ID: <87h89vmytv.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 170 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 110 insertions(+), 60 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 9b0556f8be..d56d0fd235 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1815,6 +1815,106 @@ static void handle_step(GdbCmdContext *gdb_ctx, v=
oid *user_ctx)
>      gdb_continue(gdb_ctx->s);
>  }
>
> +static void handle_v_cont_query(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    put_packet(gdb_ctx->s, "vCont;c;C;s;S");
> +}
> +
> +static void handle_v_cont(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int res;
> +
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    res =3D gdb_handle_vcont(gdb_ctx->s, gdb_ctx->params[0].data);
> +    if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
> +        put_packet(gdb_ctx->s, "E22");
> +    } else if (res) {
> +        put_packet(gdb_ctx->s, "\0");

Isn't this just ""?

Either way my reading of the spec say the response needs to be a "Stop
Reply Packet" which I don't think includes empty or E codes.

> +    }
> +}
> +
> +static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    GDBProcess *process;
> +    CPUState *cpu;
> +    char thread_id[16];
> +
> +    strcpy(gdb_ctx->str_buf, "E22");

pstrcpy (see HACKING about strncpy) but...

> +    if (!gdb_ctx->num_params) {
> +        goto cleanup;
> +    }
> +
> +    process =3D gdb_get_process(gdb_ctx->s, gdb_ctx->params[0].val_ul);
> +    if (!process) {
> +        goto cleanup;
> +    }
> +
> +    cpu =3D get_first_cpu_in_process(gdb_ctx->s, process);
> +    if (!cpu) {
> +        goto cleanup;
> +    }
> +
> +    process->attached =3D true;
> +    gdb_ctx->s->g_cpu =3D cpu;
> +    gdb_ctx->s->c_cpu =3D cpu;
> +
> +    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s=
;",
> +             GDB_SIGNAL_TRAP, thread_id);

again this would be an argument for using GString to build-up our reply pac=
kets.

> +cleanup:
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_v_kill(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    /* Kill the target */
> +    put_packet(gdb_ctx->s, "OK");
> +    error_report("QEMU: Terminated via GDBstub");
> +    exit(0);
> +}
> +
> +static GdbCmdParseEntry gdb_v_commands_table[] =3D {
> +    /* Order is important if has same prefix */
> +    {
> +        .handler =3D handle_v_cont_query,
> +        .cmd =3D "Cont?",
> +        .cmd_startswith =3D 1
> +    },
> +    {
> +        .handler =3D handle_v_cont,
> +        .cmd =3D "Cont",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    {
> +        .handler =3D handle_v_attach,
> +        .cmd =3D "Attach;",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
> +    {
> +        .handler =3D handle_v_kill,
> +        .cmd =3D "Kill;",
> +        .cmd_startswith =3D 1
> +    },
> +};
> +
> +static void handle_v_commands(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                           gdb_v_commands_table,
> +                           ARRAY_SIZE(gdb_v_commands_table))) {
> +        put_packet(gdb_ctx->s, "");
> +    }
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1822,7 +1922,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      CPUClass *cc;
>      const char *p;
>      uint32_t pid, tid;
> -    int ch, type, res;
> +    int ch, type;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> @@ -1871,66 +1971,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'v':
> -        if (strncmp(p, "Cont", 4) =3D=3D 0) {
> -            p +=3D 4;
> -            if (*p =3D=3D '?') {
> -                put_packet(s, "vCont;c;C;s;S");
> -                break;
> -            }
> -
> -            res =3D gdb_handle_vcont(s, p);
> -
> -            if (res) {
> -                if ((res =3D=3D -EINVAL) || (res =3D=3D -ERANGE)) {
> -                    put_packet(s, "E22");
> -                    break;
> -                }
> -                goto unknown_command;
> -            }
> -            break;
> -        } else if (strncmp(p, "Attach;", 7) =3D=3D 0) {
> -            unsigned long pid;
> -
> -            p +=3D 7;
> -
> -            if (qemu_strtoul(p, &p, 16, &pid)) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            process =3D gdb_get_process(s, pid);
> -
> -            if (process =3D=3D NULL) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            cpu =3D get_first_cpu_in_process(s, process);
> -
> -            if (cpu =3D=3D NULL) {
> -                /* Refuse to attach an empty process */
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            process->attached =3D true;
> -
> -            s->g_cpu =3D cpu;
> -            s->c_cpu =3D cpu;
> -
> -            snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRA=
P,
> -                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_=
id)));
> -
> -            put_packet(s, buf);
> -            break;
> -        } else if (strncmp(p, "Kill;", 5) =3D=3D 0) {
> -            /* Kill the target */
> -            put_packet(s, "OK");
> -            error_report("QEMU: Terminated via GDBstub");
> -            exit(0);
> -        } else {
> -            goto unknown_command;
> +        {
> +            static const GdbCmdParseEntry v_cmd_desc =3D {
> +                .handler =3D handle_v_commands,
> +                .cmd =3D "v",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &v_cmd_desc;
>          }
> +        break;
>      case 'k':
>          /* Kill the target */
>          error_report("QEMU: Terminated via GDBstub");


--
Alex Benn=C3=A9e

