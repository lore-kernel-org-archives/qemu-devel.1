Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D865DC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:45:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28CD20843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 09:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/NQh+wS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28CD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34273 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqTL-0000Lt-Vf
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 05:45:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQqSB-0008B6-B7
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQqSA-0007Ed-Bx
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:44:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQqSA-0007Ds-4U
	for qemu-devel@nongnu.org; Wed, 15 May 2019 05:44:02 -0400
Received: by mail-wr1-x442.google.com with SMTP id l2so1878033wrb.9
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 02:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Ws1jsapOhwFFLOlfkuw4/cavxv990eGOCD2h+rqzgog=;
	b=x/NQh+wSLytYk5bij2gaJdbSs7CWnbHIenUL7Sv7eVw11QHvD/kPhxLAXq8c8nPq7P
	zLbAOsEdbTbJvRF0xUGMvNvwBWlEzdHYFlusHYLlBex2yD8iEtW9z8nbIBaw0tIPCaq1
	G0+KXlhjbhUcLKxwJrCLlwOWLNtCX4DeaDwLjEu0eT/+Q3q+9/NZTR8lrQ7OBhaLNhGb
	U3iTq5WToZIgv61lqMvDQ+SzXlhWch2bY32S3tlFyAfPIp3YKlfz2AVWXce9eWnyKvPM
	apkJrLC7NXGrnMjuyfNB2YmTu/MfAPYcNhNCtP3Q5Qw8+bKQ1nFL/i9cvMGPNQQX6TQ9
	1GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Ws1jsapOhwFFLOlfkuw4/cavxv990eGOCD2h+rqzgog=;
	b=eR7UeafIH5Y4D0BRgisFA1/NzcGD4Sil5sMYMiZ+29BWTIut4AtSeje1gObJ+jsIga
	pNSCF7LUKo9DbDPjBi8256VHu0bOiWld9PcpkhN0BclXaxH1/9h2coXIR6m8BlX89ja2
	7tMo0zchgQ5FDChakpI4+1Gn4I+WmQgAzUVt5fcg+DHJegkyPcRAqwHI9kkD5tsfDk5o
	OnwLMOW2A5qG4WE+BzjM1g57SmxMRJY1e/vwkck4bwE5MLRGEBPb3H5CIpEQBI4UbK8d
	TgsyWlFrA798AVe9EIGCVDRLTqOP0wM1oiisNB0/hIzm7aoGfWXi75tjZU8XWfablFeq
	6QIA==
X-Gm-Message-State: APjAAAXdLzyoPL3C9pGNhDbKI29XZ5K32nOcxaEranx2oTMBKHaTLF28
	7SzYjjBh2G0x0qWGTCXeWLujS925Is4=
X-Google-Smtp-Source: APXvYqxY6NjqQizU2IUORX5eCOcXz6mllQla+/SOvlVq+6Rvo8tDN4Tqo27QcqEu+Dx+94mkda6mTQ==
X-Received: by 2002:a05:6000:10c4:: with SMTP id
	b4mr12580882wrx.145.1557913440881; 
	Wed, 15 May 2019 02:44:00 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	v192sm1739372wme.24.2019.05.15.02.43.49
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 02:43:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id F29071FF87;
	Wed, 15 May 2019 10:43:48 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-6-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-6-arilou@gmail.com>
Date: Wed, 15 May 2019 10:43:48 +0100
Message-ID: <871s10njcb.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH v9 05/27] gdbstub: Implement continue with
 signal (C pkt) with new infra
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
>  gdbstub.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 89f1ab6524..469aaeb875 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1532,6 +1532,21 @@ static void handle_continue(GdbCmdContext *gdb_ctx=
, void *user_ctx)
>      gdb_continue(gdb_ctx->s);
>  }

It might be worth adding a comment that we don't currently support the:

  C sig;[addr]

form of continue packet here, which we didn't before so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> +static void handle_cont_with_sig(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    unsigned long signal =3D 0;
> +
> +    if (gdb_ctx->num_params) {
> +        signal =3D gdb_ctx->params[0].val_ul;
> +    }
> +
> +    gdb_ctx->s->signal =3D gdb_signal_to_target(signal);
> +    if (gdb_ctx->s->signal =3D=3D -1) {
> +        gdb_ctx->s->signal =3D 0;
> +    }
> +    gdb_continue(gdb_ctx->s);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1579,11 +1594,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'C':
> -        s->signal =3D gdb_signal_to_target (strtoul(p, (char **)&p, 16));
> -        if (s->signal =3D=3D -1)
> -            s->signal =3D 0;
> -        gdb_continue(s);
> -        return RS_IDLE;
> +        {
> +            static const GdbCmdParseEntry cont_with_sig_cmd_desc =3D {
> +                .handler =3D handle_cont_with_sig,
> +                .cmd =3D "C",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "l0"
> +            };
> +            cmd_parser =3D &cont_with_sig_cmd_desc;
> +        }
> +        break;
>      case 'v':
>          if (strncmp(p, "Cont", 4) =3D=3D 0) {
>              p +=3D 4;


--
Alex Benn=C3=A9e

