Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF509C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A04CA2454D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i9GXTnOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04CA2454D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhnf-0006Ji-Ql
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:42:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhkB-0003gR-D6
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:38:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhk9-0003Mx-Ma
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:38:50 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhk9-0003Jz-GH
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:38:49 -0400
Received: by mail-wm1-x342.google.com with SMTP id f10so6103705wmb.1
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=VfNoAd2cBbExF85Rqe49EkPI1f+Cpem8QpiDm1cqEo4=;
	b=i9GXTnOoGOIiAxffiTxQ2V4Yhdk2DWXRhe0IllobIqVsHvaenfoFkiMobZO4mU0NJR
	uQesFax2N/hg90IZ3ZhTh/2D9HaLbT09CnE7Nd+DLrHwYH/+U8KFE/0ndpEu34FF2ZIk
	lFzAfIdwFr4iwdsewm8cwvFcvQUxafg+e9eziv4xJ9WReZJ622MFprwrtjQBpTM0lSrZ
	BvkqE+wgLG3lmfcpA4yZpfQcvan2LQgkiBRD9jqAiwvGhwydqvknPdtDT5ZqVsxD+5mS
	91kAhDWa+hags3UAGuXcyTvNO9QdzGpPaXFBipbdlICW3f084o7eEEp4ETFuXM38r0Id
	rWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=VfNoAd2cBbExF85Rqe49EkPI1f+Cpem8QpiDm1cqEo4=;
	b=ufdJA3yKa5vUL7pTAAnaDNpS5uCkjO8fFhp/l44tztk9pdHancZPyWXxqQPcKnjm5G
	QyVoWawGTeaAHW+QmvLaSWFYSm/tqRhgomDfyTqIr7XhuJEaCQdfdrSmr7B2mSoSbcxt
	rVjT0Gdzk1/BSNVqg0iZD1aUXH71RMFzVELoBzbFgGciJJGx19q373Hn5Wf8C9V/ozNS
	l6sIRitavMPqehIPe/i9wDpxQhMZjteFTvGs/GhgCg6maIg2KQraEqu/+yT+lskWCC6p
	ZP/gV3EPzvc+Vj8pU/WEm6CWfWbfrjjPCpxlugQ9sl9QWn1lAM9GfSc8e7r3t8trDQv3
	klYA==
X-Gm-Message-State: APjAAAU91IgSg7bdYrOSytEeGHKVY/UPykrI7cITq1lesCq/O4Hw3dAR
	rjt8Nqpb0NvGaOhlhWKUQaaizw==
X-Google-Smtp-Source: APXvYqyQiD8jCvT8iv1l4VSJBLf2tBnopQ6ahUFPgoS/1T+2hMA8Su8uVl9ruV2+JgJ2PzAlgFOfgg==
X-Received: by 2002:a1c:d182:: with SMTP id i124mr5926481wmg.102.1559309926456;
	Fri, 31 May 2019 06:38:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z17sm748674wru.21.2019.05.31.06.38.44
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:38:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id DC7431FF87;
	Fri, 31 May 2019 14:38:43 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-10-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-10-arilou@gmail.com>
Date: Fri, 31 May 2019 14:38:43 +0100
Message-ID: <87y32m921o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v12 09/20] gdbstub: Implement get register
 (p pkt) with new infra
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
>  gdbstub.c | 50 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 38 insertions(+), 12 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index fc9526b3f5..07740ec0af 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1672,6 +1672,36 @@ static void handle_set_reg(GdbCmdContext *gdb_ctx,=
 void *user_ctx)
>      put_packet(gdb_ctx->s, "OK");
>  }
>
> +static void handle_get_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int reg_size;
> +
> +    /*
> +     * Older gdb are really dumb, and don't use 'g' if 'p' is avaialable.
> +     * This works, but can be very slow.  Anything new enough to
> +     * understand XML also knows how to use this properly.
> +     */
> +    if (!gdb_has_xml) {
> +        put_packet(gdb_ctx->s, "");
> +        return;
> +    }
> +
> +    if (!gdb_ctx->num_params) {
> +        put_packet(gdb_ctx->s, "E14");
> +        return;
> +    }
> +
> +    reg_size =3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
> +                                 gdb_ctx->params[0].val_ull);
> +    if (!reg_size) {
> +        put_packet(gdb_ctx->s, "E14");
> +        return;
> +    }
> +
> +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, reg_size);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1901,18 +1931,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'p':
> -        /* Older gdb are really dumb, and don't use 'g' if 'p' is avaial=
able.
> -           This works, but can be very slow.  Anything new enough to
> -           understand XML also knows how to use this properly.  */
> -        if (!gdb_has_xml)
> -            goto unknown_command;
> -        addr =3D strtoull(p, (char **)&p, 16);
> -        reg_size =3D gdb_read_register(s->g_cpu, mem_buf, addr);
> -        if (reg_size) {
> -            memtohex(buf, mem_buf, reg_size);
> -            put_packet(s, buf);
> -        } else {
> -            put_packet(s, "E14");
> +        {
> +            static const GdbCmdParseEntry get_reg_cmd_desc =3D {
> +                .handler =3D handle_get_reg,
> +                .cmd =3D "p",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L0"
> +            };
> +            cmd_parser =3D &get_reg_cmd_desc;
>          }
>          break;
>      case 'P':


--
Alex Benn=C3=A9e

