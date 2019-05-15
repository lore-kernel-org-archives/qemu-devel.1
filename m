Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC23C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:27:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C722084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wih/5+yv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C722084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQr88-0004ZT-Ns
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:27:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQr71-00045A-Nd
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQr6z-0006U0-Pc
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQr6x-0006IO-QS
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:26:13 -0400
Received: by mail-wr1-x443.google.com with SMTP id w8so2045018wrl.6
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=8COhqbaNSo/kEE51ptGZPKJUZy90z07rOi6/SaibSog=;
	b=wih/5+yv9U5gVGv/UcoGCErjAUxGp7G/IaB4N4petS7t3wusQzAOOcCXXdeCz3fVoN
	SpG8ZQohBQA7ohNRH0V22uE0C/ciDxHTFtAeVPfnLbWCmG5XUflkzyPHk1ZaH5uq22Sp
	/f2NrOW759JxxuLc4ge317BA0pjlviEvO4JaJ0qT2ZLf4qUi9/3MCpcTgFTdAKRHsTAz
	XTPqpQ9rI0BWdTZQDfsw69heubwZ235Z4L0jErwLyk7QtB1sGC5aEenISpPvg+OrbFa5
	Tb2fg+p2I6IcMgULP9vwGSFaaLRlBQzdnnVaq99Y3SGTT0TLHgd/+j0BQ/+mL4OHqr2K
	cOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=8COhqbaNSo/kEE51ptGZPKJUZy90z07rOi6/SaibSog=;
	b=fB5NnIgm68nDlfgpFh3uoak0AIMJI15Nvtg9YQQA6vYjdphK4L3llnjoTlRUdOV4EO
	bxeTzyLvNDeHEPeChyFFcchfguPnhe3Wo4KIL+74dvbvgcHztDh7VcOoQfjRff0hfGRk
	noFeUW7hBvB4oTybBLaJK+H3fH0K+eosi8WM2SHCQRKUhOyflLVksmwrrXcUcyrPztxU
	IKwmuD9iWEGpfb8JZY4sN43UoTCE+buYK1Ke9FHgvXU/3UZmmJ9IwoMwvpRrv1YNsoG+
	MvZ8rMEqAlAVllyGwKuhYa/rxB/Npl6kdBCL3AZIVPtf5+FjI7O+N0h7+vmUcPFjjYzh
	D/Jw==
X-Gm-Message-State: APjAAAXTAz9U0k3GVtAMTE3RSuBq3U/mjkcK3NW4GgGvROaS0106+J+z
	buwwNinCJqyU6jdv8PTA2AD2BA==
X-Google-Smtp-Source: APXvYqyRE2bpVqMmX/cKqXcmv/lprUEAdCt+Z9ua+hZMTm/6b/J/+mMD1HGCuOuV3BfoeeL+dq9X6A==
X-Received: by 2002:adf:f487:: with SMTP id l7mr26184554wro.127.1557915964268; 
	Wed, 15 May 2019 03:26:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id a8sm1797533wmf.33.2019.05.15.03.26.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 03:26:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EDF611FF87;
	Wed, 15 May 2019 11:26:02 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-8-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-8-arilou@gmail.com>
Date: Wed, 15 May 2019 11:26:02 +0100
Message-ID: <87y338m2th.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v9 07/27] gdbstub: Implement insert
 breakpoint (Z pkt) with new infra
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
>  gdbstub.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 21cdaf4678..36c7353a22 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1588,6 +1588,29 @@ static void handle_set_thread(GdbCmdContext *gdb_c=
tx, void *user_ctx)
>      }
>  }
>
> +static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int res;
> +
> +    if (gdb_ctx->num_params < 3) {

!=3D 3?

> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    res =3D gdb_breakpoint_insert(gdb_ctx->params[1].val_ull,
> +                                gdb_ctx->params[2].val_ull,
> +                                gdb_ctx->params[0].val_ul);

I would be tempted to fix the prototype of gdb_breakpoint_insert to
match the order of the packet parameters for cleanliness.

> +    if (res >=3D 0) {
> +        put_packet(gdb_ctx->s, "OK");
> +        return;
> +    } else if (res =3D=3D -ENOSYS) {
> +        put_packet(gdb_ctx->s, "");
> +        return;
> +    }
> +
> +    put_packet(gdb_ctx->s, "E22");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1843,6 +1866,16 @@ static int gdb_handle_packet(GDBState *s, const ch=
ar *line_buf)
>          put_packet(s, "OK");
>          break;
>      case 'Z':
> +        {
> +            static const GdbCmdParseEntry insert_bp_cmd_desc =3D {
> +                .handler =3D handle_insert_bp,
> +                .cmd =3D "Z",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "l?L?L0"
> +            };
> +            cmd_parser =3D &insert_bp_cmd_desc;
> +        }
> +        break;
>      case 'z':
>          type =3D strtoul(p, (char **)&p, 16);
>          if (*p =3D=3D ',')

You should also delete the:

        if (ch =3D=3D 'Z')
            res =3D gdb_breakpoint_insert(addr, len, type);
case.

In fact I think there is probably a good case just to merge with the
next patch as the two functions are very much related.

--
Alex Benn=C3=A9e

