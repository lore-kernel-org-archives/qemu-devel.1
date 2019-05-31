Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A12FC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:44:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAA0269B3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1HcmAMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAA0269B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhpM-0007ca-9Y
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:44:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhlB-0004R4-LH
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:39:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhlA-0004Xf-IO
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:39:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhlA-0004WN-Ac
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:39:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id w13so6538236wru.11
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Lzlpq1HkhnpaPvn6nX8cdPTXodg+GdTp1awQk0BxCng=;
	b=Z1HcmAMik6P5U1MSXROUkSXA30bY5iJ1rM9UeMKCzQ+fFLnZMfpSv9HMb+mTynhYVP
	8kKEQjAmlScT2ffwV2f0jt9QYmmgLVcVXERDqCwonwPFW5NDbee4i7tn8sTUkp/76QV2
	AMOfA+XtNlMapOwCZoHO3yQfpLBaMcrtp4S+KtAee1vPy/y8wFqVuA3bq8Gg3Gk8uyFh
	XsHGgQ2TlU1AIkabrXesnN2H00yHYuI7TRPR/PJrXYopcoSX5mEyhfV5gDx2jaV2+ypy
	DIfgB4ELTMUOQiK0yvaEabOD7YSfng7WrQWGxp4DBHjTq22ISJ1kUL72XfVrJCrlwxLG
	VyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Lzlpq1HkhnpaPvn6nX8cdPTXodg+GdTp1awQk0BxCng=;
	b=FvwNY1T0BDAgUj2mv/o/eWtWd96TXQbo8V83nOpq+GNbKMuL9wHumo96F+IWojdZ7y
	IkAeTuvjWqXf+c66xlUqnShd6MbBJ54yqjBzvhSY2UthKF0gDfcJ06KEfa1b++be4qrM
	Fpasev7qsf5zVkHQWEmwpMkhArNfYqe3X+vMBSTwpqfvx8k1bHxbr16cL3zWNABUhyYH
	Sd9JiwKRyAqOxZ0/XvJHlHoy5HGN4bAYMxu406Uy5Jl31Zzaavv4D8O60Ed9GdRprmzE
	vhgp6oVOchg+ZELrxJvGT8vf+YXRKmWcqbgGFxwEF/auaI8lf4FShjjEeaCfRJNJXW0W
	oTHw==
X-Gm-Message-State: APjAAAX9HjyoK/xINPyR09rbb7wvj0izjHoc67ucIOoYVTGok2wIgyeK
	atKTTT6AdJnbvdiKTRle7dbl1A==
X-Google-Smtp-Source: APXvYqztuH5LNJs1iDK+Zh1lxw4yvAGTLpzjyP1cQXge2xnL7yaCaC+Jk6809cfHgGgImuuyfjuIBw==
X-Received: by 2002:a5d:6709:: with SMTP id o9mr6609633wru.301.1559309990941; 
	Fri, 31 May 2019 06:39:50 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f2sm7497892wme.12.2019.05.31.06.39.49
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:39:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 2EC1E1FF87;
	Fri, 31 May 2019 14:39:49 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-15-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-15-arilou@gmail.com>
Date: Fri, 31 May 2019 14:39:49 +0100
Message-ID: <87woi691zu.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v12 14/20] gdbstub: Implement file io (F
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
>  gdbstub.c | 48 ++++++++++++++++++++++++++----------------------
>  1 file changed, 26 insertions(+), 22 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 8a401e6527..ea85966b27 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1789,6 +1789,25 @@ static void handle_read_all_regs(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
>
> +static void handle_file_io(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params >=3D 2 && gdb_ctx->s->current_syscall_cb) {
> +        target_ulong ret, err;
> +
> +        ret =3D (target_ulong)gdb_ctx->params[0].val_ull;
> +        err =3D (target_ulong)gdb_ctx->params[1].val_ull;
> +        gdb_ctx->s->current_syscall_cb(gdb_ctx->s->c_cpu, ret, err);
> +        gdb_ctx->s->current_syscall_cb =3D NULL;
> +    }
> +
> +    if (gdb_ctx->num_params >=3D 3 && gdb_ctx->params[2].opcode =3D=3D (=
uint8_t)'C') {
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
> @@ -1930,28 +1949,13 @@ static int gdb_handle_packet(GDBState *s, const c=
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
> +                .schema =3D "L,L,o0"
> +            };
> +            cmd_parser =3D &file_io_cmd_desc;
>          }
>          break;
>      case 'g':


--
Alex Benn=C3=A9e

