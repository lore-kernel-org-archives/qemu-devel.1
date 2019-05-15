Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7100B20862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qiiNgzCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7100B20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39897 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxCp-0007Rs-Pu
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:56:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxBo-0006Yv-Qk
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxBn-0001TQ-Uy
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:55:36 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxBn-0001SB-P0
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:55:35 -0400
Received: by mail-wr1-x444.google.com with SMTP id b18so240595wrq.12
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=uGQV0rLa9nDPOp0vsfNEJfFq6zxVZdqKadKhFcORWII=;
	b=qiiNgzCNSmlpNLCm0IBCT0nGj6J/CdH9ZZthYgbP9NuPAGMz9cJFpTY6C8kZrTwn+5
	rM4UBDCmViDHEZCR3jKehOxPubDxcTWtylryWU6VdjiSC9V/onUZdpULTceepjI+v/N5
	s3ZlC036Kdxm7OmnMW4bKZkQ3F4cOZZKhuJrnlFPJe3mSUm1F9iNG6wpTCFGd2A419/h
	PELQ/SdBo+YhTPa2S89xAaWNJTmstDPpLonSMCcQMftS0C9lyuVcYlRrPndKmxKTF1f9
	yPtliWPjxNFAA8Mim7DSmEB1A/aIDUeeA1MyPNdiWwG9HBMmJVvJb36W9NoezdRs0A6l
	0vXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=uGQV0rLa9nDPOp0vsfNEJfFq6zxVZdqKadKhFcORWII=;
	b=A4iZPn5au+W//2RK7+lR/AzDdljGnmjgW+99rALeL2ij4GYksYfULfc9I31U7JWnS6
	MJ4pZi25NzeSf4PxoS8absRc78s8s6LORhPdFvdDzv4xY3DTZOKgN4KNNpI50mevlT9C
	18npMl+LgKfY6XUsZy+DiopLt+XPYpyr2Z8T5Oe69MKgO4DWY5yJn0ymW3kBVJRtJBuu
	2cVbbeOQE1sOD/iLyLGdsZdL/wPfLmHufPRISZnJfE5UxVPVgC+sq+A4JRbIwkSR6j+R
	878VenSUgN7rUiEV0kCJRn+sTPpVO1w12FR/Mato1X44scstFq8gommzNwkeeyiUSMYq
	GGvg==
X-Gm-Message-State: APjAAAXdLJD0G36PS8uTuOrjiEFEutU3FrfT+N0ix7cI6Gi6WqRqAE59
	PsOkH34daw26p+feM7hebSpumUzXJoo=
X-Google-Smtp-Source: APXvYqzdDUf4wTjwneLcI1t4bReLTb1gMzEwgKjnxA4uB2r+iD+9yNwHDRxjoyHIGorqZ7GTcBNymQ==
X-Received: by 2002:a5d:54d2:: with SMTP id x18mr27571450wrv.186.1557939334519;
	Wed, 15 May 2019 09:55:34 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id x5sm3051362wrt.72.2019.05.15.09.55.33
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 09:55:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 735D71FF87;
	Wed, 15 May 2019 17:55:33 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-17-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-17-arilou@gmail.com>
Date: Wed, 15 May 2019 17:55:33 +0100
Message-ID: <87imubmzcq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 16/27] gdbstub: Implement step (s pkt)
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
>  gdbstub.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 9fe130f30d..9b0556f8be 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1805,6 +1805,16 @@ static void handle_file_io(GdbCmdContext *gdb_ctx,=
 void *user_ctx)
>      gdb_continue(gdb_ctx->s);
>  }
>
> +static void handle_step(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    if (gdb_ctx->num_params) {
> +        gdb_set_cpu_pc(gdb_ctx->s, (target_ulong)gdb_ctx->params[0].val_=
ull);
> +    }
> +
> +    cpu_single_step(gdb_ctx->s->c_cpu, sstep_flags);
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1937,13 +1947,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 's':
> -        if (*p !=3D '\0') {
> -            addr =3D strtoull(p, (char **)&p, 16);
> -            gdb_set_cpu_pc(s, addr);
> +        {
> +            static const GdbCmdParseEntry step_cmd_desc =3D {
> +                .handler =3D handle_step,
> +                .cmd =3D "s",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L0"
> +            };
> +            cmd_parser =3D &step_cmd_desc;
>          }
> -        cpu_single_step(s->c_cpu, sstep_flags);
> -        gdb_continue(s);
> -        return RS_IDLE;
> +        break;
>      case 'F':
>          {
>              static const GdbCmdParseEntry file_io_cmd_desc =3D {


--
Alex Benn=C3=A9e

