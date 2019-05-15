Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C82C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD7220862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYsNwD8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD7220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxBs-0006RR-5I
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:55:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxAt-0005yf-0u
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxAs-0000Z4-09
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:54:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxAr-0000YB-O3
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:54:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id m3so115053wrv.2
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=3LmeWPqDAW9frNXQjNpnuHgG59paFFSFHm4ol9AhRMQ=;
	b=TYsNwD8iIa7ens/QtGsBT4OMxRoH1wxP5H9hoAsYMuaEv+c567d/S6c9XoaINjJ9Qi
	ZY/FXTPw82eNiUzXUu5cYIblpcknK03N3q7hcBx9UmuoO0XyDa8r1U0sgevC3UenOyeW
	yC6+Bhdb/4ZLiOcdQ735CK3Yo/fAcRVnHWBdjfENrwAS8YkBPMT7rIGWkosPCXeITQ8s
	ISnoV7srz/BZKHQjbRxZh6RuESPGqllJpWHHgeVcXS30yJ6wQTCWTxjhXaAZNIm22Cj7
	6zy4Cbgs6omg+tDE4/Z732rDFKDCXv29kEDCHwxGKMGvzCB77yRdOCJp5RGCxItQYRPs
	keYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=3LmeWPqDAW9frNXQjNpnuHgG59paFFSFHm4ol9AhRMQ=;
	b=rKsq3ZBKo7oC6IT48xHDc6uOEpdIeimuKQyAN21npH8BrVJXRn1VtpWqWt+huJP1dq
	Ity1B0T+iQv+z4ByG8dLibGKN+F8rEKS2fsEjNuDMT0ybsUsWMRRFVPWq9pUQO7YDUrx
	F81K1KICEc4bPZwN86dWVmkTFnNPXcwG9R+JXM71t2muzS/M2hrLwGKXedXzd9B7lvKg
	yXqei5X+hqDzMt2RBXAbKT4O4kX/ZtnuRk6MZyD5kX/b6Dl3k0C98VJYaxKpXHFlWFoF
	Z8n3icrSqh2zmkoKtQEr1dKuEYez4xYMI9v6TP7ECxAeG6vg8gU/KnWLokFdK1OiJdl5
	4pvA==
X-Gm-Message-State: APjAAAWRml1yW8SfZ1AZIrtFdxAZyglE5W3rw+ZM3ETaA0Thn65BAwa5
	OLV0nQjOEO5DpRGOCwalQeJW0w==
X-Google-Smtp-Source: APXvYqwqShEsCjkra2BPzNjp9gW5bOMxFz8jCEmThtYkZ0deVZow//5DB5WhtrhkpcKeZ0nHRuSDvA==
X-Received: by 2002:adf:eb87:: with SMTP id t7mr25074257wrn.39.1557939276295; 
	Wed, 15 May 2019 09:54:36 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	s124sm3258128wmf.42.2019.05.15.09.54.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 09:54:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2589A1FF87;
	Wed, 15 May 2019 17:54:35 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-16-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-16-arilou@gmail.com>
Date: Wed, 15 May 2019 17:54:35 +0100
Message-ID: <87k1ermzec.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

There is a bit more going on here than a simple conversion. I think we
need some additional commentary about the format of the data coming
back.


> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 62 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 40 insertions(+), 22 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 3478ac778d..9fe130f30d 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1772,6 +1772,39 @@ static void handle_read_all_regs(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
>
> +static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int num_syscall_params;
> +    GdbCmdVariant syscall_params[3] =3D {};
> +
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    if (cmd_parse_params(gdb_ctx->params[0].data, "L,L,o0", syscall_para=
ms,
> +                         &num_syscall_params)) {
> +        return;
> +    }

What's going on here? I thought the schema was meant to handle the
parsing of data. I see bellow we originally parse the command as a null
terminated string but we actually should handle:

  =E2=80=98Fretcode,errno,Ctrl-C flag;call-specific attachment=E2=80=99

I see the argument for dealing with the call-specific attachment here
but shouldn't the generic parsing code be able to split everything
apart?

> +
> +    if (!num_syscall_params) {
> +        return;
> +    }
> +
> +    if (gdb_ctx->s->current_syscall_cb) {
> +        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu,
> +                                       (target_ulong)syscall_params[0].v=
al_ull,
> +                                       (target_ulong)syscall_params[1].v=
al_ull);
> +        gdb_ctx->s->current_syscall_cb =3D NULL;
> +    }



> +
> +    if (syscall_params[2].opcode =3D=3D (uint8_t)'C') {
> +        put_packet(gdb_ctx->s, "T02");
> +        return;
> +    }
> +
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1913,28 +1946,13 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          return RS_IDLE;
>      case 'F':
>          {
> -            target_ulong ret;
> -            target_ulong err;
> -
> -            ret =3D strtoull(p, (char **)&p, 16);
> -            if (*p =3D=3D ',') {
> -                p++;
> -                err =3D strtoull(p, (char **)&p, 16);
> -            } else {
> -                err =3D 0;
> -            }
> -            if (*p =3D=3D ',')
> -                p++;
> -            type =3D *p;
> -            if (s->current_syscall_cb) {
> -                s->current_syscall_cb(s->c_cpu, ret, err);
> -                s->current_syscall_cb =3D NULL;
> -            }
> -            if (type =3D=3D 'C') {
> -                put_packet(s, "T02");
> -            } else {
> -                gdb_continue(s);
> -            }
> +            static const GdbCmdParseEntry file_io_cmd_desc =3D {
> +                .handler =3D handle_file_io,
> +                .cmd =3D "F",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &file_io_cmd_desc;
>          }
>          break;
>      case 'g':


--
Alex Benn=C3=A9e

