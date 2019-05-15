Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C321C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5762A20843
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAp4KApj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5762A20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQpHd-0005vA-78
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 04:29:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpFt-0005AO-KI
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQpFs-00089m-Fn
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:27:17 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQpFs-00087k-8V
	for qemu-devel@nongnu.org; Wed, 15 May 2019 04:27:16 -0400
Received: by mail-wm1-x344.google.com with SMTP id j187so1551019wmj.1
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 01:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=bdY0P6ZgVJQfOhGOj72uiQUJ1QzQTauNRouRQdHptUY=;
	b=hAp4KApjg1B9QI3aQw+tRRGR+A18CglS+WgGPw9QA/z5PDeInwtp5rudybQTVkLsCW
	FrD9CUOGmp8bZM1IR6oh3K1u9g8xyixjed2DOuoRE3tGHsPT0krhPeZYabpKkl4D2uJG
	eKL/PB2MLfrGg1iERSmoM6WQckuHVD7JMnII7kwmmO2VlrG1la+3ZYI/B4L7kByLWV3x
	im45TDWDG6yxEE5A7SCpraqKXbc4klD55gbZx1ww5VS6WqA++g7gUOsknmRzk6EYoFnK
	MROmQLJ4qq4uszEeSDcSAHYokdbSqkFe0rX84O7tFuM3yHkJcePuOm+RrEG3UeDYZZn9
	hOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=bdY0P6ZgVJQfOhGOj72uiQUJ1QzQTauNRouRQdHptUY=;
	b=P9/oeC9gz4aDepq2LNkdQsIJlvU4OnwTM8xUW/PG8VyNxEo0/iQ76gi/xP6pB/8YjB
	4eOTGOLZ+cN1v5We/eAe+X3HLL/wIO0fQ9jNvfI2DEv28JwYdaAIVr5QyuzOmE3RPVqi
	tWV0iMyGYcmHStMG8cRQIIytE+J/Iy77GUDMAUaUSBQQEULK/DxgjS+nsWwAJYvEHVy8
	qHS8EM9P9XjIYbLrntTqlisyd0rYJL+eUUPJYsVDYRrey28Nrbjs9YzUAihE9WJcmZ52
	HmBJsiXtyDx0YuBYuezQeTczjWK152wGQBDFcGKs04uWKXVB9yCLfSlJ8vOOtq/8S1NK
	3Vkw==
X-Gm-Message-State: APjAAAWzkZnRoWqmYFb0tQ4XLIVoX6R+4erZUMPodo4zfkJKBmonjGiI
	j0rPxypRX3BWO8tkGkqkVRt8iA==
X-Google-Smtp-Source: APXvYqxhgJqHOLzKMgfeOhBQ3s4GpFeCcgryCgif+ghsf0BweLJSevs7DJ/bEBKf/BAat238sJTwEQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr5867971wmb.110.1557908834521; 
	Wed, 15 May 2019 01:27:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id v1sm1130161wrd.47.2019.05.15.01.27.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 01:27:13 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 759301FF87;
	Wed, 15 May 2019 09:27:13 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-4-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-4-arilou@gmail.com>
Date: Wed, 15 May 2019 09:27:13 +0100
Message-ID: <875zqcnmvy.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v9 03/27] gdbstub: Implement thread_alive
 (T pkt) with new infra
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
>  gdbstub.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 621d689868..c47ef7dd9c 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1498,6 +1498,30 @@ static void handle_detach(GdbCmdContext *gdb_ctx, =
void *user_ctx)
>      put_packet(s, "OK");
>  }
>
> +static void handle_thread_alive(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    CPUState *cpu;
> +
> +    if (!gdb_ctx->num_params) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (gdb_ctx->params[0].thread_id.kind =3D=3D GDB_READ_THREAD_ERR) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    cpu =3D gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[0].thread_id.pid,
> +                      gdb_ctx->params[0].thread_id.tid);
> +    if (!cpu) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1798,17 +1822,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'T':
> -        thread_kind =3D read_thread_id(p, &p, &pid, &tid);
> -        if (thread_kind =3D=3D GDB_READ_THREAD_ERR) {
> -            put_packet(s, "E22");
> -            break;
> -        }
> -        cpu =3D gdb_get_cpu(s, pid, tid);
> -
> -        if (cpu !=3D NULL) {
> -            put_packet(s, "OK");
> -        } else {
> -            put_packet(s, "E22");
> +        {
> +            static const GdbCmdParseEntry thread_alive_cmd_desc =3D {
> +                .handler =3D handle_thread_alive,
> +                .cmd =3D "T",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "t0"
> +            };
> +            cmd_parser =3D &thread_alive_cmd_desc;
>          }
>          break;
>      case 'q':


--
Alex Benn=C3=A9e

