Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646E6C43219
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE5F2067C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 14:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV7XKi0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE5F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58883 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJfju-0005TQ-Bo
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 10:52:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfii-0004xi-Nr
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hJfih-0000XP-8d
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hJfif-0000Sn-Sa
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 10:51:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id a9so13145672wrp.6
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=L7wTMs2VQZstt1KQ329Lya6iKE5rUCAeQd64/kXP/xg=;
	b=oV7XKi0c/bQHB/Mw4yM87+aY5yJn/NicHeu8lLrdUZf+67lgGAXlm6AYub48zHXaab
	0XUX5rrwSZSNM9H/uVMNPzCUrSeC90jlHjEqN8V3qpltMqnKm5PnEKlNgsNdWm1rlsNi
	U3Ct7rrsN78XvZ+zv05PI3M5O5IqwI0B4hZNHWGAbt2J+hQiUPAsiCgJAbrKZILPm6bg
	YcBvQsC+8ZpHpKQbAyHVAWgreoqlftp9vhr58U1TfRdoMrPGk3XdgKm1K12/nAn6A+Hd
	wCm5L48kyBmHHp7fmvZa8y1bEehTKX+9iQs4acPuyjMOZ41GPF4QE+zOxCwgHUwMN4Yc
	c+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=L7wTMs2VQZstt1KQ329Lya6iKE5rUCAeQd64/kXP/xg=;
	b=H2VrONPOfgQKhBO0HcvLbylC5T0jba36uUI57N6E6oYEjpV80uTOXnd4OHpLxwFbkc
	El0wgk75MgNTLj0MCp+kayuDTkGqNhV6XLC9ezBbp4GA4dH5yuOPc7PPrE2VgsnOcYgn
	AVCLZpYn0kQ/LGEjyFSoBtjoDLfT35nxfdqbOZurUKz0dg5cGjJaqxKsw0toMrPytNM5
	S1Ro55l+oyR6hVNqSooGPhTeNBy/jWdZnegGdfxZ6OkV6yZwLpgLJlrcM4zXo/VBiDRJ
	AXOKDCivUkCOWe79uZWAFq/vmC1grVFyAQ/whrsFFDz553xnDKmktly0a0ljrb++j77t
	aAlw==
X-Gm-Message-State: APjAAAXlnLd6/yZF9/onkcok/w+/cL+yXEl/neRULhZn+6Ec/XWXq0R0
	FtG2qvG5jVTeJXbRrnbz0aZQJg==
X-Google-Smtp-Source: APXvYqzo+YxKHyLQSneQSG+2HA7/5p+ziskElJPSSOPrMTNBN+6/ZkFwWhn/Exg5DCZcVFkMUkr51g==
X-Received: by 2002:a5d:528d:: with SMTP id c13mr6228842wrv.264.1556203882730; 
	Thu, 25 Apr 2019 07:51:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	w12sm53808244wrg.29.2019.04.25.07.51.21
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 25 Apr 2019 07:51:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 787C01FF87;
	Thu, 25 Apr 2019 15:51:21 +0100 (BST)
References: <20190424142714.28460-1-arilou@gmail.com>
	<20190424142714.28460-4-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190424142714.28460-4-arilou@gmail.com>
Date: Thu, 25 Apr 2019 15:51:21 +0100
Message-ID: <87tvemuoie.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v3 04/20] gdbstub: Implement continue (c
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
Cc: Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425145121.XdLppGVcLLpx_UZ4k1KWYHJZblQKZd486a8cDuHuOEY@z>


arilou@gmail.com writes:

> From: Jon Doron <arilou@gmail.com>
>
> Signed-off-by: Jon Doron <arilou@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  gdbstub.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 435b492b4f..a6d5acd6f0 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1538,6 +1538,16 @@ static void handle_thread_alive(GdbCmdContext *gdb=
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
> @@ -1573,13 +1583,16 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          gdb_breakpoint_remove_all();
>          break;
>      case 'c':
> -        if (*p !=3D '\0') {
> -            addr =3D strtoull(p, (char **)&p, 16);
> -            gdb_set_cpu_pc(s, addr);
> +        {
> +            static GdbCmdParseEntry continue_cmd_desc =3D {
> +                .handler =3D handle_continue,
> +                .cmd =3D "c",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L0"
> +            };
> +            process_string_cmd(s, NULL, line_buf, &continue_cmd_desc, 1);
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

