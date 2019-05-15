Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6836BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3389B20873
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZaiqSe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3389B20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39301 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQwPP-0008R7-8V
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:05:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQwLb-0006WF-2S
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQwLV-0007DA-O9
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:01:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQwLV-00071L-Cf
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:01:33 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so79189wrb.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=F4X7OUYgrPIAx7m8tiEPn2A0jIWPS2IieBRBcThWfI4=;
	b=AZaiqSe0+QizmshUDYDV/vPOkEt/KfxQowr69qxLkBEvbstpqJZr4dUp2IKgFJYW2j
	S0BePZMNymU7S7KHK29TXSGm0nxo8IXfPILFtAM95ACombGmEsHm11Z+cypeWd3NyX8+
	FCZft/yOG59W1YAtE7xADINbBICJtBazsl6y9UHio1zCAeMZ5fa7Mkt3ItMKzVvMze/K
	5LRlCPqns/8513b/q7pP6nkwzc2NM26Px8u3YuCAFW9+6GAwJU2TNzwem6kFtMfCP4Lt
	uc/iHwUjWnoDZ6dwhfS5gxItTjZshauoAvFahuCoXyaP4dgDi+HMe/XatKs/ofiNOxd1
	P6aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=F4X7OUYgrPIAx7m8tiEPn2A0jIWPS2IieBRBcThWfI4=;
	b=XB0OuA8Gl4uduJT9v5UiLEkjszJGSPxXy45vhOF7EtyGGoe2xVgYBq1es+qAn988ed
	qOjoIID8rtmIp8jNnVRHv32yEyFoZANbhQOYOpuM06mPgr6vOgAMW/dWm5CZB4rAg6d/
	4XbOLvMc/FUKr5nHJGklJ2+VWnhDELQgRPTd3+0xwURVOL1eU0JbV0UdApMOsMVeMZQO
	CS+kvpXrmWoO4IKjX1j5WAjnidwmfwnnI7fCDvvx8GqYsjprxm89SjSwCtQJu0Q9g64L
	DwPtQqPAmO5ahH7YanCwRaak8kgRISHR8IsG5Qtr8zXXGAzVRmgO1Y9K+msresNa2X6k
	i/XA==
X-Gm-Message-State: APjAAAUDfb3AjRpaEcOiBwkoE5pDpV5KJLYaa+YBpvdGWBneeQUigjCr
	c53zBVDk/dCqxmrHOmruMKV57w==
X-Google-Smtp-Source: APXvYqyhWcV616I2XdEVlitITXlBhKZU5LJFuWBT6ZUm+69sdwpHLVgKS61it80DDfvgYz2vkHLBDg==
X-Received: by 2002:adf:f208:: with SMTP id p8mr7405288wro.160.1557936088394; 
	Wed, 15 May 2019 09:01:28 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	a11sm2728326wrx.31.2019.05.15.09.01.27
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 09:01:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 515CD1FF87;
	Wed, 15 May 2019 17:01:27 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-14-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-14-arilou@gmail.com>
Date: Wed, 15 May 2019 17:01:27 +0100
Message-ID: <87mujnn1uw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v9 13/27] gdbstub: Implement write all
 registers (G pkt) with new infra
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
>  gdbstub.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index daa602edc3..adfe39b3a3 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1734,6 +1734,29 @@ static void handle_read_mem(GdbCmdContext *gdb_ctx=
, void *user_ctx)
>      put_packet(gdb_ctx->s, gdb_ctx->str_buf);
>  }
>
> +static void handle_write_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    target_ulong addr, len;
> +    uint8_t *registers;
> +    int reg_size;
> +
> +    if (!gdb_ctx->num_params) {
> +        return;
> +    }
> +
> +    cpu_synchronize_state(gdb_ctx->s->g_cpu);
> +    registers =3D gdb_ctx->mem_buf;
> +    len =3D strlen(gdb_ctx->params[0].data) / 2;
> +    hextomem(registers, gdb_ctx->params[0].data, len);

Admittedly the legacy code didn't check either but we are assuming that
registers (i.e. gdb_ctx->mem_buf) won't overflow. It's probably still
safe as the incoming packets are limited in size. I was trying to find
where MAX_PACKET_LENGTH came from and AFAICT it's an arbitrary number we
made up.

I wonder if it would make sense in another series to convert the various
buffers to GString and GBytes so we can dynamically handle longer
packets without all this inconsistent application of bounds checking.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +    for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs && len > 0;
> +         addr++) {
> +        reg_size =3D gdb_write_register(gdb_ctx->s->g_cpu, registers, ad=
dr);
> +        len -=3D reg_size;
> +        registers +=3D reg_size;
> +    }
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1745,7 +1768,6 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> -    uint8_t *registers;
>      target_ulong addr, len;
>      const GdbCmdParseEntry *cmd_parser =3D NULL;
>
> @@ -1911,16 +1933,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          put_packet(s, buf);
>          break;
>      case 'G':
> -        cpu_synchronize_state(s->g_cpu);
> -        registers =3D mem_buf;
> -        len =3D strlen(p) / 2;
> -        hextomem((uint8_t *)registers, p, len);
> -        for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs && len > 0; add=
r++) {
> -            reg_size =3D gdb_write_register(s->g_cpu, registers, addr);
> -            len -=3D reg_size;
> -            registers +=3D reg_size;
> +        {
> +            static const GdbCmdParseEntry write_all_regs_cmd_desc =3D {
> +                .handler =3D handle_write_all_regs,
> +                .cmd =3D "G",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "s0"
> +            };
> +            cmd_parser =3D &write_all_regs_cmd_desc;
>          }
> -        put_packet(s, "OK");
>          break;
>      case 'm':
>          {


--
Alex Benn=C3=A9e

