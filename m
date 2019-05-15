Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBA1C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA20021473
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 15:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="emJEbeW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA20021473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38744 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQvsb-0005Yn-Qq
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 11:31:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvre-0005DT-SJ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQvrd-00065b-Sr
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:30:42 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42733)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQvrd-00063H-Ka
	for qemu-devel@nongnu.org; Wed, 15 May 2019 11:30:41 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so3163347wrb.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 08:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=/3OTQhULOypQg9ce2cHfoZAGg3InEfTV3xvSDNiQ/pA=;
	b=emJEbeW/GmdcwTU0OHU+YrUQ3PbWM/bkJ0co6PpOIdKIeCG0lOp6s9kI0pXWymG0ML
	KZQgiHfpyD6e6e+kwgPW5rLFf9c3qZvPyldxPl3hUVNqJFzdpddl54l0X8A2GSSFBf8w
	XBU4i0BNWiqRk5zPKoq8l8Dka4iVqTkwMjkmK/97EcT6WQuUP/jEwcbwUZ1kS3jb8zQw
	CvIt9iNLUPjEpm3aaVt/utwf4UaheKwenf+kh2z2xDiW/lYScPwUfJUFHlykmIVaJMym
	QWgKAQI/mfmbr+OPRe7tX0sBP7NlIiUGyo1NyPrYM3JcClcSsj5WwndCfIJmTXKEhCm9
	e4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=/3OTQhULOypQg9ce2cHfoZAGg3InEfTV3xvSDNiQ/pA=;
	b=fSXAkN0mBTyrJb+25zK0l3SvsAz+uJiQn61G4ByyVddOTm0IYuEPzab5Jt6lm0RwG9
	1FZWXM4Yi/MKGajqKE8UVv6MkwufkCkUwj95IjDmuP9pNgoHahhhhT8LFqSG/fWBzhGp
	rAXCrntFS4b/vjB6pSxu8T1kRJ5JGl7unauCE/hqTJ6xuUeDLoPPV7JGiyjxuFftXDJ1
	+o/73eBTuloafkbbIcRrxGNW9JT2AKKx6Nc37YWiSHTj0Gua4ueToKbArhQ/BlLQjMon
	gbIW6h1ulTopvV7USIiE7IOvyfUliAMxnOuC+mafP7SoRTVJARqPID3e4IHP6r+p4Auo
	pyNw==
X-Gm-Message-State: APjAAAUGlijx9qyMUpXNc2phVCRvTc+5jCV/6ncRsCrG03lKq1o14gso
	M0CP/mMxBn9S72V2KtzxTp+fUw==
X-Google-Smtp-Source: APXvYqws8+5yLNeX2SoAESM6mRhZMB3gGNh/Z3eT/Eyb6479gWTK4GeDuwh+jdYXqC1s+LxVL123dw==
X-Received: by 2002:a5d:458e:: with SMTP id p14mr17120045wrq.318.1557934239901;
	Wed, 15 May 2019 08:30:39 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	n15sm2755708wru.67.2019.05.15.08.30.39
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 08:30:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EEC4F1FF87;
	Wed, 15 May 2019 16:30:38 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-13-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-13-arilou@gmail.com>
Date: Wed, 15 May 2019 16:30:38 +0100
Message-ID: <87o943n3a9.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v9 12/27] gdbstub: Implement read memory (m
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
> ---
>  gdbstub.c | 48 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 8dc2e1d507..daa602edc3 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1710,6 +1710,30 @@ static void handle_write_mem(GdbCmdContext *gdb_ct=
x, void *user_ctx)
>      put_packet(gdb_ctx->s, "OK");
>  }
>
> +static void handle_read_mem(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params < 2) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }

!=3D2?

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +
> +    /* memtohex() doubles the required space */
> +    if (gdb_ctx->params[1].val_ull > MAX_PACKET_LENGTH / 2) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (target_memory_rw_debug(gdb_ctx->s->g_cpu, gdb_ctx->params[0].val=
_ull,
> +                               gdb_ctx->mem_buf,
> +                               gdb_ctx->params[1].val_ull, false)) {
> +        put_packet(gdb_ctx->s, "E14");
> +        return;
> +    }
> +
> +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, gdb_ctx->params[1].val_=
ull);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1899,22 +1923,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          put_packet(s, "OK");
>          break;
>      case 'm':
> -        addr =3D strtoull(p, (char **)&p, 16);
> -        if (*p =3D=3D ',')
> -            p++;
> -        len =3D strtoull(p, NULL, 16);
> -
> -        /* memtohex() doubles the required space */
> -        if (len > MAX_PACKET_LENGTH / 2) {
> -            put_packet (s, "E22");
> -            break;
> -        }
> -
> -        if (target_memory_rw_debug(s->g_cpu, addr, mem_buf, len, false) =
!=3D 0) {
> -            put_packet (s, "E14");
> -        } else {
> -            memtohex(buf, mem_buf, len);
> -            put_packet(s, buf);
> +        {
> +            static const GdbCmdParseEntry read_mem_cmd_desc =3D {
> +                .handler =3D handle_read_mem,
> +                .cmd =3D "m",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L,L0"
> +            };
> +            cmd_parser =3D &read_mem_cmd_desc;
>          }
>          break;
>      case 'M':


--
Alex Benn=C3=A9e

