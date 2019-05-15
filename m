Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C07C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E432084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRoMBjo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E432084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34817 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQrAM-0006GJ-AL
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:29:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQr7q-0004be-RA
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQr7p-0006wB-Hq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:27:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQr7p-0006vX-9Q
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:27:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so2013754wrs.11
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nek2yc66oPkliVoy0vVqW3tLUdTEffY5mOcU44NEznI=;
	b=vRoMBjo9mnRwGzxJCSPPR3ZOdZUEYhiuWDs8ZBYU5GQ+ndkOMsFlBqVFGSIZi3B6Sg
	48yKI+0nMxfeo8WmfdcSD/9D4fOHo3uBshSLkfrYwB7ajPmvPSJc/6McSit5TYDziYeI
	Bp75oDn4JCfCdfw5tGZDplkbTi5JgBRAMAt2xjfHp/wiezLIFMZHxDX6juL++yPjk0X7
	dAY+djcRcMCdS8egekkaY+5HxDHtC/rD0UAgtgYA78e3Io77VlFlvJ2YnQpwNZdL6H+A
	XRMG6ONzYfJbFQQdl79Fl6rIJa9AGXxRaOWrkveAxRs7mAZyIY1e012JbHPkFZbXd8Cl
	EWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nek2yc66oPkliVoy0vVqW3tLUdTEffY5mOcU44NEznI=;
	b=D22JwRVbKeMfMmwR2HLFAlTU63FbZNuyD4DHR6hZxQ9jV2LDApvSR6/n3JAxueJQfu
	aElgkhkhC6F+IgGFXNAR8O5toHKcXtVKjoTEjMo4MZ00Ya1uK8WzT5o9zeUhwtTEKm2d
	GNtocYfUDp8TM5NhWTpTzuVsT+E/zNE06tfyqPCqYDFHPstabHxt7/Ce6RF0OIZeY550
	IkFW2mPXVXflnKLv3tvAGjN8EOujM8JyDjdP9IOABkeGL8ioGzJLtm54waVROZrsECP9
	NRQabSxTKIAuBsWOzRSe8wAsWcXq73P8fI034AZaESp2/FkG/ppWx4rtVkh5omyLWFw6
	xGVw==
X-Gm-Message-State: APjAAAWX8CxA1YXLyWDx29UtQ0U+F6wrY3tNsd6K9wutxrwXGs5WrGXj
	gFcaMcO0xnfiPIdXrdErDzKncg==
X-Google-Smtp-Source: APXvYqw86w9qxUzQ0fQgL66/ce62XeuDe6IqJgsQkyExx73QaprRDMouPNtmavQv29upuTQC7NJ22Q==
X-Received: by 2002:adf:b243:: with SMTP id y3mr24423438wra.21.1557916024236; 
	Wed, 15 May 2019 03:27:04 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	b194sm794876wmb.23.2019.05.15.03.27.03
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 15 May 2019 03:27:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4B63A1FF87;
	Wed, 15 May 2019 11:27:03 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-9-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-9-arilou@gmail.com>
Date: Wed, 15 May 2019 11:27:03 +0100
Message-ID: <87woism2rs.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 08/27] gdbstub: Implement remove
 breakpoint (z pkt) with new infra
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

Merge with previous patch as per comments there.

> ---
>  gdbstub.c | 49 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 36c7353a22..b42425b24c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1611,6 +1611,29 @@ static void handle_insert_bp(GdbCmdContext *gdb_ct=
x, void *user_ctx)
>      put_packet(gdb_ctx->s, "E22");
>  }
>
> +static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int res;
> +
> +    if (gdb_ctx->num_params < 3) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    res =3D gdb_breakpoint_remove(gdb_ctx->params[1].val_ull,
> +                                gdb_ctx->params[2].val_ull,
> +                                gdb_ctx->params[0].val_ul);
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
> @@ -1877,23 +1900,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'z':
> -        type =3D strtoul(p, (char **)&p, 16);
> -        if (*p =3D=3D ',')
> -            p++;
> -        addr =3D strtoull(p, (char **)&p, 16);
> -        if (*p =3D=3D ',')
> -            p++;
> -        len =3D strtoull(p, (char **)&p, 16);
> -        if (ch =3D=3D 'Z')
> -            res =3D gdb_breakpoint_insert(addr, len, type);
> -        else
> -            res =3D gdb_breakpoint_remove(addr, len, type);
> -        if (res >=3D 0)
> -             put_packet(s, "OK");
> -        else if (res =3D=3D -ENOSYS)
> -            put_packet(s, "");
> -        else
> -            put_packet(s, "E22");
> +        {
> +            static const GdbCmdParseEntry remove_bp_cmd_desc =3D {
> +                .handler =3D handle_remove_bp,
> +                .cmd =3D "z",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "l?L?L0"
> +            };
> +            cmd_parser =3D &remove_bp_cmd_desc;
> +        }
>          break;
>      case 'H':
>          {


--
Alex Benn=C3=A9e

