Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B12FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADABE26A1B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdV0+jlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADABE26A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiGX-0003rt-UF
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:12:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiEl-0002TZ-PF
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiEj-0008Sq-Bm
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:10:27 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWiEh-0008KR-Gc
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:10:25 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so6606371wru.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=341oJjjogNBQm64+lG5RZlCgRmzd2Lvtz2AGSxC0DS4=;
	b=fdV0+jlGEscP5zenaMsVYWwpQv0p2OQbWmn4LmVApivnUbHw7RpwZd7lv4mwfAjTFv
	BAoMqe24zn8d+QGukhZ6Ho9qATPZ/TDH4wSVEh+eof62Il/54fRWjEISlzRlq/UmwTRo
	/Q0TZcFCpjp7XkTSIO2a7eS6XJ1b2MmLM/KdsZK7cXqmeWGKZrhVb2vKcboDQll77zUw
	mrIWF184dyaYxwILiUmQmMd8LNJVPpYR8ZnNtSgGCq+AafYmJ5qE2PNw21fBJgOQa9ft
	6n0mEURzLKOs2AVZzZz0P0XfaK4l33wQS5hKkd0pUMUqgBI5rD1/0F2Lq6h1emjdinc7
	EKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=341oJjjogNBQm64+lG5RZlCgRmzd2Lvtz2AGSxC0DS4=;
	b=E4pjbkpnDp7HTRmMDayVoF0N2O9EWfOoZ0WtrUJlFeGCE3GMkHHjcJOKUSY4AxKrEM
	6r052aURj+OBX6ScJlyjfJk4Z7oT8vBPXYs6Pv3WODiwdPPAmJlyenA7vv6f1Gf9gIfo
	VxOGv68B9P0st5DNCTIbkkmrmpzG7Y0zxUoDaOExRWTzN5gJfgPJDl1PNVsIyM+G5QaC
	AL8247wIDzhtq1ie6C7y823+WCM7pH2pRYpPMyg5J1PVd/WPoyYRl7b4JWmOJjvO+TNN
	awqXnSz7JsUtLjUiFZCsLAR6uDvGGL2iF0gFx4OPOiRroovaJhkkpEMUV/aNab0bnJft
	HoSg==
X-Gm-Message-State: APjAAAVRnl6/h3u6HzKLHwS0+jNiZ2+jp+jByjsvIUolgVeMcz3xWjGx
	VMrWxzYN6SIQS7eaNrG5NCwfzQ==
X-Google-Smtp-Source: APXvYqyfKzXy4QLU7xRsfqiADmzHAomwWGZvuxQQOLZz2cExzGUGI1UNfy5XbPAr1ziAowFd2gWhJA==
X-Received: by 2002:a5d:54cc:: with SMTP id x12mr6351089wrv.303.1559311821507; 
	Fri, 31 May 2019 07:10:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a17sm3809407wrr.80.2019.05.31.07.10.20
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 07:10:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 0F5E01FF87;
	Fri, 31 May 2019 15:10:20 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-18-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-18-arilou@gmail.com>
Date: Fri, 31 May 2019 15:10:20 +0100
Message-ID: <87sgsu90kz.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v12 17/20] gdbstub: Implement generic
 set/query (Q/q pkt) with new infra
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

> The generic set/query packets contains implementation for varioius
> sub-commands which are required for GDB and also additional commands
> which are QEMU specific.
>
> To see which QEMU specific commands are available use the command
> gdb> maintenance packet qqemu.Supported
>
> Currently the only implemented QEMU specific command is the command
> that sets the single step behavior.
>
> gdb> maintenance packet qqemu.sstepbits
> Will display the MASK bits used to control the single stepping.
>
> gdb> maintenance packet qqemu.sstep
> Will display the current value of the mask used when single stepping.
>
> gdb> maintenance packet Qqemu.sstep:HEX_VALUE
> Will change the single step mask.
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  gdbstub.c | 559 ++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 373 insertions(+), 186 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 648191a3b0..80fe5b2d0c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1130,14 +1130,6 @@ static GDBThreadIdKind read_thread_id(const char *=
buf, const char **end_buf,
>      return GDB_ONE_THREAD;
>  }
>
> -static int is_query_packet(const char *p, const char *query, char separa=
tor)
> -{
> -    unsigned int query_len =3D strlen(query);
> -
> -    return strncmp(p, query, query_len) =3D=3D 0 &&
> -        (p[query_len] =3D=3D '\0' || p[query_len] =3D=3D separator);
> -}
> -
>  /**
>   * gdb_handle_vcont - Parses and handles a vCont packet.
>   * returns -ENOTSUP if a command is unsupported, -EINVAL or -ERANGE if t=
here is
> @@ -1918,18 +1910,368 @@ static void handle_v_commands(GdbCmdContext *gdb=
_ctx, void *user_ctx)
>      }
>  }
>
> -static int gdb_handle_packet(GDBState *s, const char *line_buf)
> +static void handle_query_qemu_sstepbits(GdbCmdContext *gdb_ctx, void *us=
er_ctx)
> +{
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> +             "ENABLE=3D%x,NOIRQ=3D%x,NOTIMER=3D%x", SSTEP_ENABLE,
> +             SSTEP_NOIRQ, SSTEP_NOTIMER);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_set_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    sstep_flags =3D gdb_ctx->params[0].val_ul;
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
> +static void handle_query_qemu_sstep(GdbCmdContext *gdb_ctx, void *user_c=
tx)
> +{
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "0x%x", sstep_f=
lags);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_query_curr_tid(GdbCmdContext *gdb_ctx, void *user_ctx)
>  {
>      CPUState *cpu;
>      GDBProcess *process;
> +    char thread_id[16];
> +
> +    /*
> +     * "Current thread" remains vague in the spec, so always return
> +     * the first thread of the current process (gdb returns the
> +     * first thread).
> +     */
> +    process =3D gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
> +    cpu =3D get_first_cpu_in_process(gdb_ctx->s, process);
> +    gdb_fmt_thread_id(gdb_ctx->s, cpu, thread_id, sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "QC%s", thread_=
id);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_query_threads(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    char thread_id[16];
> +
> +    if (!gdb_ctx->s->query_cpu) {
> +        put_packet(gdb_ctx->s, "l");
> +        return;
> +    }
> +
> +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->query_cpu, thread_id,
> +                      sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "m%s", thread_i=
d);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +    gdb_ctx->s->query_cpu =3D
> +        gdb_next_attached_cpu(gdb_ctx->s, gdb_ctx->s->query_cpu);
> +}
> +
> +static void handle_query_first_threads(GdbCmdContext *gdb_ctx, void *use=
r_ctx)
> +{
> +    gdb_ctx->s->query_cpu =3D gdb_first_attached_cpu(gdb_ctx->s);
> +    handle_query_threads(gdb_ctx, user_ctx);
> +}
> +
> +static void handle_query_thread_extra(GdbCmdContext *gdb_ctx, void *user=
_ctx)
> +{
> +    CPUState *cpu;
> +    int len;
> +
> +    if (!gdb_ctx->num_params ||
> +        gdb_ctx->params[0].thread_id.kind =3D=3D GDB_READ_THREAD_ERR) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    cpu =3D gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
> +                      gdb_ctx->params[0].thread_id.tid);
> +    if (!cpu) {
> +        return;
> +    }
> +
> +    cpu_synchronize_state(cpu);
> +
> +    if (gdb_ctx->s->multiprocess && (gdb_ctx->s->process_num > 1)) {
> +        /* Print the CPU model and name in multiprocess mode */
> +        ObjectClass *oc =3D object_get_class(OBJECT(cpu));
> +        const char *cpu_model =3D object_class_get_name(oc);
> +        char *cpu_name =3D object_get_canonical_path_component(OBJECT(cp=
u));
> +        len =3D snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_b=
uf) / 2,
> +                       "%s %s [%s]", cpu_model, cpu_name,
> +                       cpu->halted ? "halted " : "running");
> +        g_free(cpu_name);
> +    } else {
> +        /* memtohex() doubles the required space */
> +        len =3D snprintf((char *)gdb_ctx->mem_buf, sizeof(gdb_ctx->str_b=
uf) / 2,
> +                        "CPU#%d [%s]", cpu->cpu_index,
> +                        cpu->halted ? "halted " : "running");
> +    }
> +    trace_gdbstub_op_extra_info((char *)gdb_ctx->mem_buf);
> +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +#ifdef CONFIG_USER_ONLY
> +static void handle_query_offsets(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    TaskState *ts;
> +
> +    ts =3D gdb_ctx->s->c_cpu->opaque;
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> +             "Text=3D" TARGET_ABI_FMT_lx ";Data=3D" TARGET_ABI_FMT_lx
> +             ";Bss=3D" TARGET_ABI_FMT_lx,
> +             ts->info->code_offset,
> +             ts->info->data_offset,
> +             ts->info->data_offset);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +#else
> +static void handle_query_rcmd(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int len;
> +
> +    if (!gdb_ctx->num_params) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    len =3D strlen(gdb_ctx->params[0].data);
> +    if (len % 2) {
> +        put_packet(gdb_ctx->s, "E01");
> +        return;
> +    }
> +
> +    len =3D len / 2;
> +    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[0].data, len);
> +    gdb_ctx->mem_buf[len++] =3D 0;
> +    qemu_chr_be_write(gdb_ctx->s->mon_chr, gdb_ctx->mem_buf, len);
> +    put_packet(gdb_ctx->s, "OK");
> +
> +}
> +#endif
> +
> +static void handle_query_supported(GdbCmdContext *gdb_ctx, void *user_ct=
x)
> +{
>      CPUClass *cc;
> +
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "PacketSize=3D%=
x",
> +             MAX_PACKET_LENGTH);
> +    cc =3D CPU_GET_CLASS(first_cpu);
> +    if (cc->gdb_core_xml_file) {
> +        pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf),
> +                ";qXfer:features:read+");
> +    }
> +
> +    if (gdb_ctx->num_params &&
> +        strstr(gdb_ctx->params[0].data, "multiprocess+")) {
> +        gdb_ctx->s->multiprocess =3D true;
> +    }
> +
> +    pstrcat(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), ";multiprocess+"=
);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
> +static void handle_query_xfer_features(GdbCmdContext *gdb_ctx, void *use=
r_ctx)
> +{
> +    GDBProcess *process;
> +    CPUClass *cc;
> +    unsigned long len, total_len, addr;
> +    const char *xml;
>      const char *p;
> -    uint32_t pid, tid;
> -    int ch, type;
> +
> +    if (gdb_ctx->num_params < 3) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    process =3D gdb_get_cpu_process(gdb_ctx->s, gdb_ctx->s->g_cpu);
> +    cc =3D CPU_GET_CLASS(gdb_ctx->s->g_cpu);
> +    if (!cc->gdb_core_xml_file) {
> +        put_packet(gdb_ctx->s, "");
> +        return;
> +    }
> +
> +    gdb_has_xml =3D true;
> +    p =3D gdb_ctx->params[0].data;
> +    xml =3D get_feature_xml(gdb_ctx->s, p, &p, process);
> +    if (!xml) {
> +        put_packet(gdb_ctx->s, "E00");
> +        return;
> +    }
> +
> +    addr =3D gdb_ctx->params[1].val_ul;
> +    len =3D gdb_ctx->params[2].val_ul;
> +    total_len =3D strlen(xml);
> +    if (addr > total_len) {
> +        put_packet(gdb_ctx->s, "E00");
> +        return;
> +    }
> +
> +    if (len > (MAX_PACKET_LENGTH - 5) / 2) {
> +        len =3D (MAX_PACKET_LENGTH - 5) / 2;
> +    }
> +
> +    if (len < total_len - addr) {
> +        gdb_ctx->str_buf[0] =3D 'm';
> +        len =3D memtox(gdb_ctx->str_buf + 1, xml + addr, len);
> +    } else {
> +        gdb_ctx->str_buf[0] =3D 'l';
> +        len =3D memtox(gdb_ctx->str_buf + 1, xml + addr, total_len - add=
r);
> +    }
> +
> +    put_packet_binary(gdb_ctx->s, gdb_ctx->str_buf, len + 1, true);
> +}
> +
> +static void handle_query_attached(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    put_packet(gdb_ctx->s, GDB_ATTACHED);
> +}
> +
> +static void handle_query_qemu_supported(GdbCmdContext *gdb_ctx, void *us=
er_ctx)
> +{
> +    put_packet(gdb_ctx->s, "sstepbits;sstep");
> +}
> +
> +static GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
> +    /* Order is important if has same prefix */
> +    {
> +        .handler =3D handle_query_qemu_sstepbits,
> +        .cmd =3D "qemu.sstepbits",
> +    },
> +    {
> +        .handler =3D handle_query_qemu_sstep,
> +        .cmd =3D "qemu.sstep",
> +    },
> +    {
> +        .handler =3D handle_set_qemu_sstep,
> +        .cmd =3D "qemu.sstep=3D",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
> +};
> +
> +static GdbCmdParseEntry gdb_gen_query_table[] =3D {
> +    {
> +        .handler =3D handle_query_curr_tid,
> +        .cmd =3D "C",
> +    },
> +    {
> +        .handler =3D handle_query_threads,
> +        .cmd =3D "sThreadInfo",
> +    },
> +    {
> +        .handler =3D handle_query_first_threads,
> +        .cmd =3D "fThreadInfo",
> +    },
> +    {
> +        .handler =3D handle_query_thread_extra,
> +        .cmd =3D "ThreadExtraInfo,",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "t0"
> +    },
> +#ifdef CONFIG_USER_ONLY
> +    {
> +        .handler =3D handle_query_offsets,
> +        .cmd =3D "Offsets",
> +    },
> +#else
> +    {
> +        .handler =3D handle_query_rcmd,
> +        .cmd =3D "Rcmd,",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +#endif
> +    {
> +        .handler =3D handle_query_supported,
> +        .cmd =3D "Supported:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0"
> +    },
> +    {
> +        .handler =3D handle_query_supported,
> +        .cmd =3D "Supported",
> +        .schema =3D "s0"
> +    },
> +    {
> +        .handler =3D handle_query_xfer_features,
> +        .cmd =3D "Xfer:features:read:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s:l,l0"
> +    },
> +    {
> +        .handler =3D handle_query_attached,
> +        .cmd =3D "Attached:",
> +        .cmd_startswith =3D 1
> +    },
> +    {
> +        .handler =3D handle_query_attached,
> +        .cmd =3D "Attached",
> +    },
> +    {
> +        .handler =3D handle_query_qemu_supported,
> +        .cmd =3D "qemu.Supported",
> +    },
> +};
> +
> +static GdbCmdParseEntry gdb_gen_set_table[] =3D {
> +    /* Order is important if has same prefix */
> +    {
> +        .handler =3D handle_set_qemu_sstep,
> +        .cmd =3D "qemu.sstep:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "l0"
> +    },
> +};
> +
> +static void handle_gen_query(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                            gdb_gen_query_set_common_table,
> +                            ARRAY_SIZE(gdb_gen_query_set_common_table)))=
 {
> +        return;
> +    }
> +
> +    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                           gdb_gen_query_table,
> +                           ARRAY_SIZE(gdb_gen_query_table))) {
> +        put_packet(gdb_ctx->s, "");
> +    }
> +}
> +
> +static void handle_gen_set(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    if (!process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                            gdb_gen_query_set_common_table,
> +                            ARRAY_SIZE(gdb_gen_query_set_common_table)))=
 {
> +        return;
> +    }
> +
> +    if (process_string_cmd(gdb_ctx->s, NULL, gdb_ctx->params[0].data,
> +                           gdb_gen_set_table,
> +                           ARRAY_SIZE(gdb_gen_set_table))) {
> +        put_packet(gdb_ctx->s, "");
> +    }
> +}
> +
> +static int gdb_handle_packet(GDBState *s, const char *line_buf)
> +{
> +    const char *p;
> +    int ch;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> -    target_ulong addr, len;
>      const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
> @@ -2131,183 +2473,28 @@ static int gdb_handle_packet(GDBState *s, const =
char *line_buf)
>          }
>          break;
>      case 'q':
> -    case 'Q':
> -        /* parse any 'q' packets here */
> -        if (!strcmp(p,"qemu.sstepbits")) {
> -            /* Query Breakpoint bit definitions */
> -            snprintf(buf, sizeof(buf), "ENABLE=3D%x,NOIRQ=3D%x,NOTIMER=
=3D%x",
> -                     SSTEP_ENABLE,
> -                     SSTEP_NOIRQ,
> -                     SSTEP_NOTIMER);
> -            put_packet(s, buf);
> -            break;
> -        } else if (is_query_packet(p, "qemu.sstep", '=3D')) {
> -            /* Display or change the sstep_flags */
> -            p +=3D 10;
> -            if (*p !=3D '=3D') {
> -                /* Display current setting */
> -                snprintf(buf, sizeof(buf), "0x%x", sstep_flags);
> -                put_packet(s, buf);
> -                break;
> -            }
> -            p++;
> -            type =3D strtoul(p, (char **)&p, 16);
> -            sstep_flags =3D type;
> -            put_packet(s, "OK");
> -            break;
> -        } else if (strcmp(p,"C") =3D=3D 0) {
> -            /*
> -             * "Current thread" remains vague in the spec, so always ret=
urn
> -             * the first thread of the current process (gdb returns the
> -             * first thread).
> -             */
> -            cpu =3D get_first_cpu_in_process(s, gdb_get_cpu_process(s, s=
->g_cpu));
> -            snprintf(buf, sizeof(buf), "QC%s",
> -                     gdb_fmt_thread_id(s, cpu, thread_id, sizeof(thread_=
id)));
> -            put_packet(s, buf);
> -            break;
> -        } else if (strcmp(p,"fThreadInfo") =3D=3D 0) {
> -            s->query_cpu =3D gdb_first_attached_cpu(s);
> -            goto report_cpuinfo;
> -        } else if (strcmp(p,"sThreadInfo") =3D=3D 0) {
> -        report_cpuinfo:
> -            if (s->query_cpu) {
> -                snprintf(buf, sizeof(buf), "m%s",
> -                         gdb_fmt_thread_id(s, s->query_cpu,
> -                                       thread_id, sizeof(thread_id)));
> -                put_packet(s, buf);
> -                s->query_cpu =3D gdb_next_attached_cpu(s, s->query_cpu);
> -            } else
> -                put_packet(s, "l");
> -            break;
> -        } else if (strncmp(p,"ThreadExtraInfo,", 16) =3D=3D 0) {
> -            if (read_thread_id(p + 16, &p, &pid, &tid) =3D=3D GDB_READ_T=
HREAD_ERR) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -            cpu =3D gdb_get_cpu(s, pid, tid);
> -            if (cpu !=3D NULL) {
> -                cpu_synchronize_state(cpu);
> -
> -                if (s->multiprocess && (s->process_num > 1)) {
> -                    /* Print the CPU model and name in multiprocess mode=
 */
> -                    ObjectClass *oc =3D object_get_class(OBJECT(cpu));
> -                    const char *cpu_model =3D object_class_get_name(oc);
> -                    char *cpu_name =3D
> -                        object_get_canonical_path_component(OBJECT(cpu));
> -                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> -                                   "%s %s [%s]", cpu_model, cpu_name,
> -                                   cpu->halted ? "halted " : "running");
> -                    g_free(cpu_name);
> -                } else {
> -                    /* memtohex() doubles the required space */
> -                    len =3D snprintf((char *)mem_buf, sizeof(buf) / 2,
> -                                   "CPU#%d [%s]", cpu->cpu_index,
> -                                   cpu->halted ? "halted " : "running");
> -                }
> -                trace_gdbstub_op_extra_info((char *)mem_buf);
> -                memtohex(buf, mem_buf, len);
> -                put_packet(s, buf);
> -            }
> -            break;
> -        }
> -#ifdef CONFIG_USER_ONLY
> -        else if (strcmp(p, "Offsets") =3D=3D 0) {
> -            TaskState *ts =3D s->c_cpu->opaque;
> -
> -            snprintf(buf, sizeof(buf),
> -                     "Text=3D" TARGET_ABI_FMT_lx ";Data=3D" TARGET_ABI_F=
MT_lx
> -                     ";Bss=3D" TARGET_ABI_FMT_lx,
> -                     ts->info->code_offset,
> -                     ts->info->data_offset,
> -                     ts->info->data_offset);
> -            put_packet(s, buf);
> -            break;
> -        }
> -#else /* !CONFIG_USER_ONLY */
> -        else if (strncmp(p, "Rcmd,", 5) =3D=3D 0) {
> -            int len =3D strlen(p + 5);
> -
> -            if ((len % 2) !=3D 0) {
> -                put_packet(s, "E01");
> -                break;
> -            }
> -            len =3D len / 2;
> -            hextomem(mem_buf, p + 5, len);
> -            mem_buf[len++] =3D 0;
> -            qemu_chr_be_write(s->mon_chr, mem_buf, len);
> -            put_packet(s, "OK");
> -            break;
> -        }
> -#endif /* !CONFIG_USER_ONLY */
> -        if (is_query_packet(p, "Supported", ':')) {
> -            snprintf(buf, sizeof(buf), "PacketSize=3D%x", MAX_PACKET_LEN=
GTH);
> -            cc =3D CPU_GET_CLASS(first_cpu);
> -            if (cc->gdb_core_xml_file !=3D NULL) {
> -                pstrcat(buf, sizeof(buf), ";qXfer:features:read+");
> -            }
> -
> -            if (strstr(p, "multiprocess+")) {
> -                s->multiprocess =3D true;
> -            }
> -            pstrcat(buf, sizeof(buf), ";multiprocess+");
> -
> -            put_packet(s, buf);
> -            break;
> -        }
> -        if (strncmp(p, "Xfer:features:read:", 19) =3D=3D 0) {
> -            const char *xml;
> -            target_ulong total_len;
> -
> -            process =3D gdb_get_cpu_process(s, s->g_cpu);
> -            cc =3D CPU_GET_CLASS(s->g_cpu);
> -            if (cc->gdb_core_xml_file =3D=3D NULL) {
> -                goto unknown_command;
> -            }
> -
> -            gdb_has_xml =3D true;
> -            p +=3D 19;
> -            xml =3D get_feature_xml(s, p, &p, process);
> -            if (!xml) {
> -                snprintf(buf, sizeof(buf), "E00");
> -                put_packet(s, buf);
> -                break;
> -            }
> -
> -            if (*p =3D=3D ':')
> -                p++;
> -            addr =3D strtoul(p, (char **)&p, 16);
> -            if (*p =3D=3D ',')
> -                p++;
> -            len =3D strtoul(p, (char **)&p, 16);
> -
> -            total_len =3D strlen(xml);
> -            if (addr > total_len) {
> -                snprintf(buf, sizeof(buf), "E00");
> -                put_packet(s, buf);
> -                break;
> -            }
> -            if (len > (MAX_PACKET_LENGTH - 5) / 2)
> -                len =3D (MAX_PACKET_LENGTH - 5) / 2;
> -            if (len < total_len - addr) {
> -                buf[0] =3D 'm';
> -                len =3D memtox(buf + 1, xml + addr, len);
> -            } else {
> -                buf[0] =3D 'l';
> -                len =3D memtox(buf + 1, xml + addr, total_len - addr);
> -            }
> -            put_packet_binary(s, buf, len + 1, true);
> -            break;
> +        {
> +            static const GdbCmdParseEntry gen_query_cmd_desc =3D {
> +                .handler =3D handle_gen_query,
> +                .cmd =3D "q",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &gen_query_cmd_desc;
>          }
> -        if (is_query_packet(p, "Attached", ':')) {
> -            put_packet(s, GDB_ATTACHED);
> -            break;
> +        break;
> +    case 'Q':
> +        {
> +            static const GdbCmdParseEntry gen_set_cmd_desc =3D {
> +                .handler =3D handle_gen_set,
> +                .cmd =3D "Q",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &gen_set_cmd_desc;
>          }
> -        /* Unrecognised 'q' command.  */
> -        goto unknown_command;
> -
> +        break;
>      default:
> -    unknown_command:
>          /* put empty packet */
>          buf[0] =3D '\0';
>          put_packet(s, buf);


--
Alex Benn=C3=A9e

