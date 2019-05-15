Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D4BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:24:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF5620862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYa0pMy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF5620862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvlt-00034K-KS
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:24:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvkS-0002GW-UY
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvjV-0005Kf-A5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:22:20 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQvjT-0005GF-46
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:22:15 -0400
Received: by mail-wm1-x343.google.com with SMTP id f2so441729wmj.3
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=zn08J2ZicgXsvPPHPeb0hDqpQW2rlLQB6utuXdutmLQ=;
	b=IYa0pMy4rwBfgradf+GCVFy0l5OAIu141Y8QQYdGJarY86bhcmxGzWvFkC0XWEr/wx
	A5asZQgW5BUhP9jLIYO897LfQC3uMsy0jrci7DE2hoPsHvz/71QhDYtCgIYHVggRvr/+
	1lEdyk5cACG2QOw3tIBY37DzEQ3YwY7b1JK8H50GSQWuHii2S/SfaVkELNLWREID+VJX
	pX7zEdW1CR2nyhfp8uBU4qYuJ6XfH3wyHlAcx4ggVec3EByujd0il/tmAk3ZKlVvNRrm
	8qsZE1NllZobKqfTo02yU/mrXF4SNd+qrVY3and1+dBzDrK7jU0RyZ03EEb/aSZvxVtx
	WBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=zn08J2ZicgXsvPPHPeb0hDqpQW2rlLQB6utuXdutmLQ=;
	b=JLt8uKiJURdhScxAML6wZIqlMF4VJw82tf26jkZwjU9w2QeKxBwp604U3mEvRly2Yy
	PIGRfO+3siUUUPoVkf5LCQWN8fCKurR8oU0Ekk8nL5OPeptR15eoR62dDpcZ4dhfLtgB
	pJWqIjDmeYu6g9SsFUDil/NcEUBCQw9136+0EKUC1t8DoTfapqymqa0/ZhFf/Ybgmw1Z
	XhGLuBgpLXYsZEfoV1LswbNvowLGaHQUq7dX8L12E8hnOf5KmTUz0HKSkWqe+boCky0w
	Lifu6D8B3JplgGHMDijbttBUeS//azrYZT19JKaHQAUUw8/taLuzxTsV6gOT4A72Q51D
	JpDg==
X-Gm-Message-State: APjAAAVEXenAqGFsGH6UmJdAYQCAlOu7/O5VofM5sDaw3l9WfrUHIc3N
	N2iazh919mG2OlKVX5bHxBJ9pQ==
X-Google-Smtp-Source: APXvYqx4476j8F6b8Xoe5dMJJyNDov9kn9pNUcbcUIQkJa9iDsmierQbrvg4MlTP9RGabOhAOs/c+A==
X-Received: by 2002:a1c:a684:: with SMTP id
	p126mr18880343wme.101.1557933732149; 
	Wed, 15 May 2019 08:22:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	l18sm2432952wrv.38.2019.05.15.08.22.10
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 15 May 2019 08:22:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 928F71FF87;
	Wed, 15 May 2019 16:22:10 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-12-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-12-arilou@gmail.com>
Date: Wed, 15 May 2019 16:22:10 +0100
Message-ID: <87pnojn3od.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v9 11/27] gdbstub: Implement write memory
 (M pkt) with new infra
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
>  gdbstub.c | 51 +++++++++++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index e9a3d0c2bc..8dc2e1d507 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1685,6 +1685,31 @@ static void handle_get_reg(GdbCmdContext *gdb_ctx,=
 void *user_ctx)
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
>
> +static void handle_write_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params < 3) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    /* hextomem() reads 2*len bytes */
> +    if (gdb_ctx->params[1].val_ull > strlen(gdb_ctx->params[2].data) / 2=
) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[2].data,
> +             gdb_ctx->params[1].val_ull);
> +    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val=
_ull,
> +                               gdb_ctx->mem_buf,
> +                               gdb_ctx->params[1].val_ull, true)) {
> +        put_packet(gdb_ctx->s, "E14");
> +        return;
> +    }
> +
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1893,24 +1918,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'M':
> -        addr =3D strtoull(p, (char **)&p, 16);
> -        if (*p =3D=3D ',')
> -            p++;
> -        len =3D strtoull(p, (char **)&p, 16);
> -        if (*p =3D=3D ':')
> -            p++;
> -
> -        /* hextomem() reads 2*len bytes */
> -        if (len > strlen(p) / 2) {
> -            put_packet (s, "E22");
> -            break;
> -        }
> -        hextomem(mem_buf, p, len);
> -        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len,
> -                                   true) !=3D 0) {
> -            put_packet(s, "E14");
> -        } else {
> -            put_packet(s, "OK");
> +        {
> +            static const GdbCmdParseEntry write_mem_cmd_desc =3D {
> +                .handler =3D handle_write_mem,
> +                .cmd =3D "M",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L,L:s0"
> +            };
> +            cmd_parser =3D &write_mem_cmd_desc;
>          }
>          break;
>      case 'p':


--
Alex Benn=C3=A9e

