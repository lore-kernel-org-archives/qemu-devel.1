Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B53C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9ACF2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/6QZuVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9ACF2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58805 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfei-0003nv-UX
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:47:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfdp-0003LO-NT
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfdk-0004ct-4f
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfdi-0004bM-0N
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:46:18 -0400
Received: by mail-wm1-x342.google.com with SMTP id y197so11002857wmd.0
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=mJqn/d5OLc1Vj/L74DF4HB9H9+EuSn8gb/v6sVjp/HY=;
	b=s/6QZuVMbyczBFvntxfJtxClOn3SFGhu8/IACOIugwJkoHiT8660dhOcURO1qXCnoj
	o2tBWn7Hskqxd57MxJlcWDpITQs0DC1BdwwNnr9lT/aDfVwdDBqlK6mUi4uN9M5MRfQe
	82HOiNj2DaLsOT7ceAzG5wD+5Jdyw8Z3EIPbVg04KDxRl3RZwwlPieQCPcsZB5xJNWii
	bgsiBoKZe4tND5N9jvoFmsfFdI2ywVEMp/Uf9bIXovF8bWHFP070tJU4JbVVC42wZNRd
	NvNKDVft+NTBG8Ro/b3IM0wF1K1aZ7eZdbyLFIVtPWaOI7PL2dSBQRMTUR6yrrHdU9Qq
	lCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=mJqn/d5OLc1Vj/L74DF4HB9H9+EuSn8gb/v6sVjp/HY=;
	b=XM4KRr/Mg0QihOlUSWO+aMXjhs42LaUyTizxlt9oE20wbmliPyj7bRa/z0EBb4ldDG
	KJX9ebr3Mczoe1E12kwyrWy76wNjN9N3E+iNtoZxWe1GJ+QqOLtIGKzbmOP4uzI5nKFL
	w0DctWl7PjhJe+jHbiKcLAATo5lcadh6JI83Wl4T/Ci4uLbSoTlNRrPSOYJPelrgVPUm
	TXAhrve3mHZaxTj9Z1p9cOVKPDSjfyagefwNqhp75MgIYuVP7NBJmO1D4EwcQ2CvDOmi
	JuSMJUiNdwcN8+v4bCe4rHHv5kBY0uUNekYiaDbSbq+LeLO+AF95me21DrTPAKNx244j
	1n3g==
X-Gm-Message-State: APjAAAWvv+KSkbCshmbU9Hz1xtOiaKwAH+aP6ecQIMNZZyI16G//9EZD
	JNetpN6YKXheY5z9viInc9ffvA==
X-Google-Smtp-Source: APXvYqwxAkCfYdNLt8LUAcAGNj7UUCerCIX/pwjLmHW39I9FDXEvuazKPd72Jfqk1gYzqIfydeiPqA==
X-Received: by 2002:a05:600c:2294:: with SMTP id
	20mr3705344wmf.56.1556203576134; 
	Thu, 25 Apr 2019 07:46:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	r9sm27588281wrv.82.2019.04.25.07.46.15
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 07:46:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 031571FF87;
	Thu, 25 Apr 2019 15:46:15 +0100 (BST)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-2-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424142714.28460-2-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:46:14 +0100
Message-ID: <87v9z2uoqx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 02/20] gdbstub: Implement deatch (D pkt)
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425144614.JxEcl1f-9bLS7aOTYnz0jkOSSQVks0esHZd0dkIx49U@z>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-otff-by: Jon Doron <arilou@gmail.com>

mini typo...

(btw you can either create a editor shortcut for adding s-o-b tags or
use --signoff while re-basing)

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 82 +++++++++++++++++++++++++++++--------------------------
>  1 file changed, 43 insertions(+), 39 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b5bd01b913..34e6722a8c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1435,10 +1435,6 @@ static inline int startswith(const char *string, c=
onst char *pattern)
>    return !strncmp(string, pattern, strlen(pattern));
>  }
>
> -__attribute__((unused)) static int process_string_cmd(
> -        GDBState *s, void *user_ctx, const char *data,
> -        GdbCmdParseEntry *cmds, int num_cmds);
> -
>  static int process_string_cmd(GDBState *s, void *user_ctx, const char *d=
ata,
>                                GdbCmdParseEntry *cmds, int num_cmds)
>  {
> @@ -1483,6 +1479,41 @@ static int process_string_cmd(GDBState *s, void *u=
ser_ctx, const char *data,
>      return -1;
>  }
>
> +static void handle_detach(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    GDBProcess *process;
> +    GDBState *s =3D gdb_ctx->s;
> +    uint32_t pid =3D 1;
> +
> +    if (s->multiprocess) {
> +        if (!gdb_ctx->num_params) {
> +            put_packet(s, "E22");
> +            return;
> +        }
> +
> +        pid =3D gdb_ctx->params[0].val_ul;
> +    }
> +
> +    process =3D gdb_get_process(s, pid);
> +    gdb_process_breakpoint_remove_all(s, process);
> +    process->attached =3D false;
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> +        s->c_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> +        s->g_cpu =3D gdb_first_attached_cpu(s);
> +    }
> +
> +    if (!s->c_cpu) {
> +        /* No more process attached */
> +        gdb_syscall_mode =3D GDB_SYS_DISABLED;
> +        gdb_continue(s);
> +    }
> +    put_packet(s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1597,42 +1628,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          error_report("QEMU: Terminated via GDBstub");
>          exit(0);
>      case 'D':
> -        /* Detach packet */
> -        pid =3D 1;
> -
> -        if (s->multiprocess) {
> -            unsigned long lpid;
> -            if (*p !=3D ';') {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            if (qemu_strtoul(p + 1, &p, 16, &lpid)) {
> -                put_packet(s, "E22");
> -                break;
> -            }
> -
> -            pid =3D lpid;
> -        }
> -
> -        process =3D gdb_get_process(s, pid);
> -        gdb_process_breakpoint_remove_all(s, process);
> -        process->attached =3D false;
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->c_cpu)) {
> -            s->c_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (pid =3D=3D gdb_get_cpu_pid(s, s->g_cpu)) {
> -            s->g_cpu =3D gdb_first_attached_cpu(s);
> -        }
> -
> -        if (s->c_cpu =3D=3D NULL) {
> -            /* No more process attached */
> -            gdb_syscall_mode =3D GDB_SYS_DISABLED;
> -            gdb_continue(s);
> +        {
> +            static GdbCmdParseEntry deatch_cmd_desc =3D {
> +                .handler =3D handle_detach,
> +                .cmd =3D "D",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "?.l0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &deatch_cmd_desc, 1);
>          }
> -        put_packet(s, "OK");
>          break;
>      case 's':
>          if (*p !=3D '\0') {


--
Alex Benn=C3=A9e

