Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385ACC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA18F269C1
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRBB8zxC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA18F269C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43831 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhsG-0001qr-5D
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:47:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhnk-0006fQ-Te
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhnj-0007Qi-JX
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:42:32 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40661)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhnj-0007Pc-CQ
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:42:31 -0400
Received: by mail-wr1-x441.google.com with SMTP id p11so1737435wre.7
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=062yvBP43SlJ/7au0KOthvqCDGNnNfcrbhh3ieL3gbI=;
	b=WRBB8zxCFlUHCW4KlX/gzEZYUqzTVmz9Xd1hVniDqZE1gcy+oPvqOwfufgPOF18iYO
	yg+yPwVo+NHy38POxYyZT9lFQXFanRX2BX5ytpRKyuJaEFR7Y8hBCGU8BAbk0RfnnDtN
	ZeWCtPhHyv2tLh55Ry6RNE3FuR6liQ+Xl1MehtmllAdBiVjZXjpyteLd8px/y6fiFnpI
	VpE9LaAfwhEhVhwONrMHWoR7+IFKzyv/ymAJH3YQz/PidruPCu2v6sp2Yevq97vNjtr5
	D0QMhn1tANfcYeQreh/qunA7X9OMV3N+g8uf4A7/oeX/MssqaAT2yRiWCnGuTf7OMyUn
	tDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=062yvBP43SlJ/7au0KOthvqCDGNnNfcrbhh3ieL3gbI=;
	b=cS1zUpej6VeIWCnkLOeak1jPadSFsBoTN1UU0DuCBmC7x1pkpXYzs6PYSnO71ZRn5t
	Tgq17TU7wzHfGOEmUJXjXaeVbFAM8FdiW64blOviqx20xAg1QQuEKohZ2vX8iOHNR4bN
	RnPO2fsEzFElO+o/CiqYR8UM0wNCOKl6tZZ9vT9IpjBkSNLt7foyKCxTCD/N6+mkeb1O
	D0fdYyJTiA2j3TlNhPDjbIiYLJewN30o8xozMCk8s2NgUnsveBit1p98caVE2tnhJvqk
	jX7DOqf0FcilnMHjlo31iJ06iAyRbv751eq9QI7ExR95M9qWuZxd0uhhZ0f3O771TTRn
	Fn9g==
X-Gm-Message-State: APjAAAXNr9MFElrUB8ZyRrhFIN4kpdPC2E75u5vzv0jc2oxBO/6Ksovx
	hoLKyx6PJhvITquub29K8cURPg==
X-Google-Smtp-Source: APXvYqyFWnRWvbL8lcctaxa3QpWBJ8ZvpWQj8K8vxAA1UN4Pj9r653/hZRKbsSnfsltxRj5ZDqAkOA==
X-Received: by 2002:a5d:56c1:: with SMTP id m1mr7032043wrw.26.1559310150203;
	Fri, 31 May 2019 06:42:30 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	t123sm11606447wmt.0.2019.05.31.06.42.28
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:42:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 6C0A01FF87;
	Fri, 31 May 2019 14:42:28 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-17-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-17-arilou@gmail.com>
Date: Fri, 31 May 2019 14:42:28 +0100
Message-ID: <87tvda91vf.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v12 16/20] gdbstub: Implement v commands
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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 170 +++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 110 insertions(+), 60 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 3fd1a1cddb..648191a3b0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1818,6 +1818,106 @@ static void handle_step(GdbCmdContext *gdb_ctx, v=
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
> +        put_packet(gdb_ctx->s, "");
> +    }
> +}
> +
> +static void handle_v_attach(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    GDBProcess *process;
> +    CPUState *cpu;
> +    char thread_id[16];
> +
> +    pstrcpy(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "E22");
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
> @@ -1825,7 +1925,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      CPUClass *cc;
>      const char *p;
>      uint32_t pid, tid;
> -    int ch, type, res;
> +    int ch, type;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> @@ -1874,66 +1974,16 @@ static int gdb_handle_packet(GDBState *s, const c=
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

