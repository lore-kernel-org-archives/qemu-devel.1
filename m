Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651DCC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A8D2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXCAu8Qr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A8D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxTQ-0003tV-EC
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:13:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxSa-0003YZ-9n
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:12:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxSY-0008Rk-Iu
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:12:56 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:56024)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxSY-0008Qa-9q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:12:54 -0400
Received: by mail-wm1-x341.google.com with SMTP id x64so789968wmb.5
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=kiRjHJj6XWvXcK7XGAYWvmG7WZMBX4fTXeq7l6yKsMM=;
	b=PXCAu8QrjGLbdO1xo1W5JNrsBKNeyjn0hD2FukLB4LVST1eHS4H6lyiFterDpWLjS6
	Yg8briagexJl4hqY5xJg3BpQS/DWj2I5zhRvFhWo+Q2wVjttrOmo5jIL7coOvLqYpGH9
	tzCsq5t7vhFN4VIWlL26AebbE/a1H43j8zY2thvi3ib596kapyou8gyDFNAH9WM5kCNx
	vC9pu27ZmL2v6iFbP/i+l0+hCE6YNfz/jR2106dHmSRGmnrpEywzYpXfJSAgVJb2u/p9
	/0mMrEBgWmBeNU9lR5g8cCyUvUUc3MOE79fQvIPHiEUjJztKoxmA74uTCTBhwqq5z+OF
	IAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=kiRjHJj6XWvXcK7XGAYWvmG7WZMBX4fTXeq7l6yKsMM=;
	b=P1DgDxdmZRZzD6wz985qkHMznufRQGaM5NvOgpAJMtUosnWFYZpKMBd8nrmqZR9chZ
	+G25CE5Q3Z0f24m9gbSmC7LVwDIPrAGt53SsrxhQjdWd8heoJ2+AApoKCcyRZbAzRHsF
	zGauzR1J+2tnW0SJHEqIQIvlWLvAbB90MvlPFExIxSlUmhN84zajbn3xAeg25gSUCrXh
	uZ07DpsHqEZIHQgOWckAaHwQXGqzhjlYyJmhVDFj+fygP922XL8FnhbAdfOu9pd0rQ6e
	3MC/btSiIFwXrQDiVb5Hvu6o29tXVz2WbSnk+kBUKd51r7i56jXOmOMnLhp4QEDMstTN
	1VdQ==
X-Gm-Message-State: APjAAAV3v84Q63vLLH9b9r+U3c6S+dRlQ++43i22KiGnzJZ8O6AhEtMd
	vMnzRolgQ0BfRc7AHibZYaExFg==
X-Google-Smtp-Source: APXvYqxiAuOoKeCUFA3/S/8vA0hzwnwWMOJ0QSo7fo5ldg0etV7NKM5MDCIGSIgmnS9/xfyP0MoU6g==
X-Received: by 2002:a1c:7005:: with SMTP id l5mr24075642wmc.149.1557940371832; 
	Wed, 15 May 2019 10:12:51 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id x22sm3399680wmi.4.2019.05.15.10.12.51
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:12:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id CE4A51FF87;
	Wed, 15 May 2019 18:12:50 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-19-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-19-arilou@gmail.com>
Date: Wed, 15 May 2019 18:12:50 +0100
Message-ID: <87ftpfmyjx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v9 18/27] gdbstub: Implement generic query
 (q pkt) with new infra
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

A bit more for the commit message here as there seems to be a fair
amount going on.

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 327 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 327 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index d56d0fd235..83ae8738cc 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1915,6 +1915,323 @@ static void handle_v_commands(GdbCmdContext *gdb_=
ctx, void *user_ctx)
>      }
>  }
>
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
> +{
> +    CPUState *cpu;
> +    GDBProcess *process;
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
> +    CPUClass *cc;
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
> +    const char *p;
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
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -2128,6 +2445,16 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
>          }
>          break;
>      case 'q':
> +        {
> +            static const GdbCmdParseEntry gen_query_cmd_desc =3D {
> +                .handler =3D handle_gen_query,
> +                .cmd =3D "q",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &gen_query_cmd_desc;
> +        }
> +        break;

The fact we haven't delete any code bellow makes me think you probably
want to merge the two q patch commits.

>      case 'Q':
>          /* parse any 'q' packets here */
>          if (!strcmp(p,"qemu.sstepbits")) {


--
Alex Benn=C3=A9e

