Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA1BC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:35:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C24C2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSYBBFKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C24C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33451 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQpOH-0007xb-Ie
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:35:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpNH-0007NN-D7
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpNG-0006Mv-G5
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:55 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQpNG-0006MS-9O
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:34:54 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so1632313wre.7
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 01:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5hYifAOAhC9fV1g0raTvChuGOyIyBGyYdKSPiEoFlZ0=;
	b=hSYBBFKkpSBE3r+jVBCkFyiNTT8GYyjnEa9FEkmUpr0vcw1mySYQ622/dEG/PESO76
	PEvGOwkFmknULLOZSlA7g5RfS7iW442DsoQlAmSOhjG/DR9PthZUwQzuHCG6B9dOKwmr
	HgclJq6ovJD3RiWFtRPiQBZG+H08oWBceVd/ZvpYf+rx14FQ1v8ErD9MrDuSt7Q8VMQJ
	OCtc5vmZEcIfBv7xdW7iDAJO1YIbxpHO47HA+kRpfBcTIHLsMLoTE55e7Dt/HL0lILql
	5Ff9gB6yT2in81tsWdFMAi/681bVzjI4zlPtNyKT8lDVMjDyrf3fGT/q/t8bfxifC8Ma
	wueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5hYifAOAhC9fV1g0raTvChuGOyIyBGyYdKSPiEoFlZ0=;
	b=EUEZOhFZaJ/q8+a4dgDgOnS0hPyIpA9FVu1KEoV9AyojyrJ5b/CdHtlnFxdxUOUgjq
	aV7w1qrWzXV6nCQWtv2aFGnjMTgczyuCaush33bM1YVHtwaKW8FG9WaF9zcycIj5LL8i
	m3nNwlyJlvcJbBJKnySQcNCd3pd3ncRTvCu8DGSCOI0YT7HQ5hZ9+xPeWrkyfgHHxOp0
	uad9lPa8R30mICHsLSRIIg31Rt4bQxCXyyP7phBWjuvrDu3MRYCEah9Ondrfd7ZNbIxm
	vSovaq5OuDm9CXb47Z/PlizpjoOeQ3Qtv26rA3kk2S9aAwBJ+4UinFA0/6dqoGfZvFvt
	0Pcg==
X-Gm-Message-State: APjAAAXmG4/2L/HNHd13AbFuBQfAE4BAGDCVAUSsdXaQyjnl+Xy2GwSH
	+fk9mils9lm/ZyrGtm69YdDI3+H5UOA=
X-Google-Smtp-Source: APXvYqxs7IedNH+rUfV27h5myvpCURpwoC0eFPrqGDmH8EKfaatZgG11SeURQGLhWx6l/ZNVt566sg==
X-Received: by 2002:adf:eb44:: with SMTP id u4mr25132764wrn.83.1557909293150; 
	Wed, 15 May 2019 01:34:53 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	x187sm1205863wmb.33.2019.05.15.01.34.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 01:34:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 27F3C1FF87;
	Wed, 15 May 2019 09:34:52 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-5-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-5-arilou@gmail.com>
Date: Wed, 15 May 2019 09:34:52 +0100
Message-ID: <8736lgnmj7.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 04/27] gdbstub: Implement continue (c
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
>  gdbstub.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index c47ef7dd9c..89f1ab6524 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1522,6 +1522,16 @@ static void handle_thread_alive(GdbCmdContext *gdb=
_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, "OK");
>  }
>
> +static void handle_continue(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params) {
> +        gdb_set_cpu_pc(gdb_ctx->s, gdb_ctx->params[0].val_ull);
> +    }
> +
> +    gdb_ctx->s->signal =3D 0;
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1558,13 +1568,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          gdb_breakpoint_remove_all();
>          break;
>      case 'c':
> -        if (*p !=3D '\0') {
> -            addr =3D strtoull(p, (char **)&p, 16);
> -            gdb_set_cpu_pc(s, addr);
> +        {
> +            static const GdbCmdParseEntry continue_cmd_desc =3D {
> +                .handler =3D handle_continue,
> +                .cmd =3D "c",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L0"
> +            };
> +            cmd_parser =3D &continue_cmd_desc;
>          }
> -        s->signal =3D 0;
> -        gdb_continue(s);
> -        return RS_IDLE;
> +        break;
>      case 'C':
>          s->signal =3D gdb_signal_to_target (strtoul(p, (char **)&p, 16));
>          if (s->signal =3D=3D -1)


--
Alex Benn=C3=A9e

