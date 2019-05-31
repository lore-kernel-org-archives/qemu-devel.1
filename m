Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB97C46470
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F29292696F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="soGd7Bci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29292696F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43657 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWhkL-0003V6-6w
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:39:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhim-0002Ps-Bo
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWhfr-0005eq-S4
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:34:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38605)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWhfq-0005cF-U1
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:34:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id t5so5967769wmh.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nFiE69lZ9pwfYkotNf6qB2Z6aLCbDFzzJBlfgOhvMbM=;
	b=soGd7Bcil/hwKcss4MzEf07WT9l2xQCUJ+TZMzMmbc1DExzkFcI6Hr9GKIOyMSzJtC
	T7oaeFl9DzMKGDp8OmiwGLh/PAT0FILKtnrnsmWiXDtlB2P0P7IoogvM7AH7RSAKgwm8
	PEThrYyNr0BzXXv3DT8Rwr3UKFTtrCeNcKbrjpEQZdrw/8y/893lWtsAgDQIZmiJgupB
	CBunVNZsgwgBm7dfb4BfesaF97oEBQvyp2Eyx3pJ2Yz7LEPvWEMsxNOFp4jRCIFG4GBy
	KHqwDY5fyouWX5CF9DJ8vA9o49PNfAF8X0L0s5qIHRzz8YpMXRwmVyIy78EzXU9vWBu5
	OXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nFiE69lZ9pwfYkotNf6qB2Z6aLCbDFzzJBlfgOhvMbM=;
	b=Gy/HDejpm0FYnp5lnaBbyMrj3NdbO//gm+tFrdw7lmXx+rpouJtSpnt1pGRY9UNhAf
	EmfZ7ArOcDEUka0tkOWoZZlARsyl3XJc3hLRXPgoGik82cQFXaoXub597v6u95BgTSID
	lJDQ17bmI35RfVhl5L78Sbe0L782HPXrfn26ReUe/D0SYKgzNxu9f2hLjQySkhLNsk8q
	bDHDPMKv0rmex76oI8jU2jUjr3jfUeW3kq521wKrBNkSJuJRFn6/10yAkYA0Aaz884UF
	fkL4dkZ8FcuvhWkyGC3TRgfcyIsmM76HR35KLG/QdnSdc9gBpX+XzFANAcptobCFJzqX
	SXgQ==
X-Gm-Message-State: APjAAAUd30mjTeun3P8GEQuvn69gDnZZzorBa7NvVlDxI6yhh8ZrN8P1
	SrysgtL6e8Hr9H2lpEDea+hfOg==
X-Google-Smtp-Source: APXvYqxwIwZQb2w6y1/Z9xj/TQvyPj8iy9pU+ktwzYTWCRPaGyXP5s+P05a4+n95/JaQgq4DxHIR5g==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr4233232wmk.40.1559309661428;
	Fri, 31 May 2019 06:34:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id z4sm1693851wrm.12.2019.05.31.06.34.20
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 06:34:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id AC3011FF87;
	Fri, 31 May 2019 14:34:19 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-8-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-8-arilou@gmail.com>
Date: Fri, 31 May 2019 14:34:19 +0100
Message-ID: <871s0eagtg.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v12 07/20] gdbstub: Implement breakpoint
 commands (Z/z pkt) with new infra
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
>  gdbstub.c | 86 +++++++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 67 insertions(+), 19 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index db213cf173..572222bfa4 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -950,7 +950,7 @@ static inline int xlat_gdb_type(CPUState *cpu, int gd=
btype)
>  }
>  #endif
>
> -static int gdb_breakpoint_insert(target_ulong addr, target_ulong len, in=
t type)
> +static int gdb_breakpoint_insert(int type, target_ulong addr, target_ulo=
ng len)
>  {
>      CPUState *cpu;
>      int err =3D 0;
> @@ -987,7 +987,7 @@ static int gdb_breakpoint_insert(target_ulong addr, t=
arget_ulong len, int type)
>      }
>  }
>
> -static int gdb_breakpoint_remove(target_ulong addr, target_ulong len, in=
t type)
> +static int gdb_breakpoint_remove(int type, target_ulong addr, target_ulo=
ng len)
>  {
>      CPUState *cpu;
>      int err =3D 0;
> @@ -1605,6 +1605,52 @@ static void handle_set_thread(GdbCmdContext *gdb_c=
tx, void *user_ctx)
>      }
>  }
>
> +static void handle_insert_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int res;
> +
> +    if (gdb_ctx->num_params !=3D 3) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    res =3D gdb_breakpoint_insert(gdb_ctx->params[0].val_ul,
> +                                gdb_ctx->params[1].val_ull,
> +                                gdb_ctx->params[2].val_ull);
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
> +static void handle_remove_bp(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int res;
> +
> +    if (gdb_ctx->num_params !=3D 3) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    res =3D gdb_breakpoint_remove(gdb_ctx->params[0].val_ul,
> +                                gdb_ctx->params[1].val_ull,
> +                                gdb_ctx->params[2].val_ull);
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
> @@ -1860,24 +1906,26 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
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

