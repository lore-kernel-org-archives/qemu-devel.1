Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94584C28CC2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:14:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655EA26A2D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 14:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tifwS1tj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655EA26A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44304 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWiIm-0005WW-H8
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 10:14:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiFR-00034V-LY
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:11:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hWiFQ-000235-KG
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:11:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33093)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hWiFQ-00020G-CT
	for qemu-devel@nongnu.org; Fri, 31 May 2019 10:11:08 -0400
Received: by mail-wr1-x441.google.com with SMTP id d9so6670705wrx.0
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=nR0Fsd5lcFxshF9x99tgdF4xX215jpME3sQAn3FOKWk=;
	b=tifwS1tj410hVtbRKDDw+g3AFbinEgEbHOKebH2dZH4Qss08Vub4fQK4fn3Gqn68w/
	JWZXoXMDPIDbVe9mhoKTdlaIT84soHUHb9nuyrtGWTOq2exGPWCuI+o2ac5chx4H9YOD
	G/WQYzXXKzX1USNDUN3bXeMVSbwmjKE9eMn6xFcxxJuHbQukJ6jv5Ol8YO5ZETLNAspX
	kcI4oHvV6dFjntLXTtBJcEtU7YmPbY7dQ3cpXf0HmEHV99lPDqDXEWOEf/0a+q/giuVz
	hxLFNxIjG5AgTeVim4kKxPvUkpAdoP238JUQCF1Oppj9ZJJSvKb8AtKh1shU+NkkkUOd
	TnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=nR0Fsd5lcFxshF9x99tgdF4xX215jpME3sQAn3FOKWk=;
	b=Xd9zxkuNwho0Wihb7HbavEwQyPyFFiU4DhDOvClJhMthliE7ilyyL/5+R8lN56t/rM
	v912a1Q8QQaC4COvWkP+d+khoVm9h2hTVMQIjYd3DSJYKuiP0rXq3x5COM0JwbVnYZto
	xY0XfySv3PKRMkCm+hvMWZTRzMRvKzStnmB2UGrtTlN/qd9tAVN/wstNvg1PqPb+PBa2
	p0sruPX9Cygprd/Axoo396E/xF7JzSzeSOToKPiJmd69BplIuLOTyeVySY39BEsWO3q0
	ikPXVJlimnm8bIqJrHDQleGWEcZ9ZlWAUAVghfjCk3Uz42YR9aQzDxnIaVfe/rO5xTAY
	pbGA==
X-Gm-Message-State: APjAAAUIAWHM6l5SWeNoGdE1137WnorUuSd9IzjbiRmdF2Ajqo2TQTtd
	/+f12DfF8GA8ijRkqDC+bW04w+152WY=
X-Google-Smtp-Source: APXvYqzASJe3k6Uey0+kvDnBSUszN1dxqOmgD9hiCPByBnwR4IJzEmBCokq2hmOaf8s+1GLcGicIwQ==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr7010523wrj.103.1559311867318; 
	Fri, 31 May 2019 07:11:07 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	c14sm6145770wrt.45.2019.05.31.07.11.06
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Fri, 31 May 2019 07:11:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id EEABA1FF87;
	Fri, 31 May 2019 15:11:05 +0100 (BST)
References: <20190529064148.19856-1-arilou@gmail.com>
	<20190529064148.19856-19-arilou@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190529064148.19856-19-arilou@gmail.com>
Date: Fri, 31 May 2019 15:11:05 +0100
Message-ID: <87r28e90jq.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: Re: [Qemu-devel] [PATCH v12 18/20] gdbstub: Implement target halted
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

> Note: The user-mode thread-id has been correctly reported since bd88c780e6
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 80fe5b2d0c..a474f2c755 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -2265,13 +2265,29 @@ static void handle_gen_set(GdbCmdContext *gdb_ctx=
, void *user_ctx)
>      }
>  }
>
> +static void handle_target_halt(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    char thread_id[16];
> +
> +    gdb_fmt_thread_id(gdb_ctx->s, gdb_ctx->s->c_cpu, thread_id,
> +                      sizeof(thread_id));
> +    snprintf(gdb_ctx->str_buf, sizeof(gdb_ctx->str_buf), "T%02xthread:%s=
;",
> +             GDB_SIGNAL_TRAP, thread_id);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +    /*
> +     * Remove all the breakpoints when this query is issued,
> +     * because gdb is doing an initial connect and the state
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
> @@ -2283,15 +2299,14 @@ static int gdb_handle_packet(GDBState *s, const c=
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

