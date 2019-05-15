Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584DAC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BFB2084E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 17:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4G9sW5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BFB2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQxb8-0006s1-6c
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 13:21:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxZt-00063m-4f
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:20:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQxZs-0002ml-56
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:20:29 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQxZr-0002h8-SQ
	for qemu-devel@nongnu.org; Wed, 15 May 2019 13:20:28 -0400
Received: by mail-wm1-x342.google.com with SMTP id j187so5188281wma.1
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 10:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=Dea4OAOkF55KYhGvk4qpPynPWmT9l20xj5qurf9EbGQ=;
	b=A4G9sW5jK90NOjpbOxR5NeAbAGcY9W+GeFLJld7fEtdmgAxFQtO0uYjYKYGyn6AZIv
	LN6qia7vL/Br0xqCy6KkOfdUheGmGHq6yHkGlfGJs+QQyeUqJoGxCCYOuvv/d8kKs7A6
	c1a2GUcpVL8zGrD0QUJ532eMiDTEgEAX2FPd1/0hlfYBr8icxv0+JpYdlDDi0pIrUh2I
	6+txM6iycubi9NgDe/LWP1hxBf2D0ZbRvFoiGBa8Q0bkGD4eiE3D8GwAu4V+17ZhGmM8
	2sT2JdvFAH3CbY01x3CfzCy/OBM9hYC1gKCvQwnxgm0Cyi/3eWd2exYJLaQgbCXZ7Mda
	K7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=Dea4OAOkF55KYhGvk4qpPynPWmT9l20xj5qurf9EbGQ=;
	b=i92Uyn03oOUMClj2fm2sAgkzrSa/qbqn0Bp89YnU9aOK45SB+BoimuivkhGw0XwhIf
	Nr/NTI/KDTAIYoxBZ7plvGNeNPTFBrsjZsW/vBYhjM/0YVSGu44pwWT5J2+JA/7bmCCX
	F9xCzFSyVRBVzlkHWiNnnNEKbOr2VDMqiVWBD24yW0R8taVsDEl2VMh12UC9QpZ9C6+e
	tuSwU3hxl6qt3DaO2gK9kiBgHYpO2rv02oH8mBybSGjvUbAyZbs+v5zM0nxYkAMzR8B5
	PxtJNyMiq4mP9bvF58BnebiLG9G9GPb6Yy9l795ndGktwFCgVEHMAqQodVomLjLfeptm
	fIKw==
X-Gm-Message-State: APjAAAXuwdW57WY+iFxQnqugroMgXRyCDdcyZVYtfBUwaz+NGaXSe543
	CAA2cSL7+idOH8S9dPHgT4+hIA==
X-Google-Smtp-Source: APXvYqzWhSNud4Ou6i1/ceP9eHH/jp+3buuo57KfCNkV8adz/33SDHjB8YeIaAg23k1JAtaSBrCeLg==
X-Received: by 2002:a1c:c8:: with SMTP id 191mr17042626wma.6.1557940826220;
	Wed, 15 May 2019 10:20:26 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	q16sm3050089wmj.17.2019.05.15.10.20.25
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 10:20:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id BCAAF1FF87;
	Wed, 15 May 2019 18:20:24 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-21-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-21-arilou@gmail.com>
Date: Wed, 15 May 2019 18:20:24 +0100
Message-ID: <87ef4zmy7b.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v9 20/27] gdbstub: Implement target halted
 (? pkt) with new infra
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
>  gdbstub.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 2fd0d66f4d..d678191705 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2239,13 +2239,30 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx=
, void *user_ctx)
>      put_packet(gdb_ctx->s, "");
>  }
>
> +static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    char thread_id[16];
> +
> +    /* TODO: Make this return the correct value for user-mode.  */

Can this be cleaned up as we convert?

> +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
> +                      sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s=
;",
> +             GDB_SIGNAL_TRAP, thread_id);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +    /*
> +     * Remove all the breakpoints when this query is issued,
> +     * because gdb is doing and initial connect and the state

s/and/an/

> +     * should be cleaned up.
> +     */
> +    gdb_breakpoint_remove_all();
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      const char *p;
>      int ch;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
> -    char thread_id[16];
>      const GdbCmdParseEntry *cmd_parser =3D NULL;
>
>      trace_gdbstub_io_command(line_buf);
> @@ -2257,15 +2274,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          put_packet(s, "OK");
>          break;
>      case '?':
> -        /* TODO: Make this return the correct value for user-mode.  */
> -        snprintf(buf, sizeof(buf), "T%02xthread:%s;", GDB_SIGNAL_TRAP,
> -                 gdb_fmt_thread_id(s, s->c_cpu, thread_id, sizeof(thread=
_id)));
> -        put_packet(s, buf);
> -        /* Remove all the breakpoints when this query is issued,
> -         * because gdb is doing and initial connect and the state
> -         * should be cleaned up.
> -         */
> -        gdb_breakpoint_remove_all();
> +        {
> +            static const GdbCmdParseEntry target_halted_cmd_desc =3D {
> +                .handler =3D handle_target_halt,
> +                .cmd =3D "?",
> +                .cmd_startswith =3D 1
> +            };
> +            cmd_parser =3D &target_halted_cmd_desc;
> +        }
>          break;
>      case 'c':
>          {


--
Alex Benn=C3=A9e

