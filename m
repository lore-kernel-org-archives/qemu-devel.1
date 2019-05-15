Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92AC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:07:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81012070D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 10:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkspcLQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81012070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34539 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQqp2-0006BU-B8
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 06:07:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQqoC-0005ka-4W
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQqoB-0005fW-5g
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:06:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQqoA-0005eZ-UY
	for qemu-devel@nongnu.org; Wed, 15 May 2019 06:06:47 -0400
Received: by mail-wr1-x444.google.com with SMTP id c5so1941939wrs.11
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 03:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=tar7J8umpdxL+8RfreXMe7ooxeh0RMCxv9r5wwamxsU=;
	b=UkspcLQSx0AaNomXNnJvHPh+am/MylHaixhvXkpSbmAVRwizyOxyhYW/LHs4DdqAwL
	qB2jOswAeaR0aXUHCALE+Lyy2I+D/1acYpQGeuYwFpJZ04KNLOi54yL7ci9n+BsdTEBR
	myzTksJnxxfmpymBA0tWn855zXKiEvZscTe7Ri1m/eVVV0XmFQxk2pE+R2z9epz1h1yN
	4x0Ms/SBEHVlcB/i0gYic/gyGWuWeQtDW9Ffb97dmVwhAN3WDAPKXTF45YbAoI3NTtee
	5URwdjFmJq/HtfoMWJ4ZSENpADexmdNtJfSgItygzG7vV9AiNo02lXyGWobHWjfYN3TU
	y5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=tar7J8umpdxL+8RfreXMe7ooxeh0RMCxv9r5wwamxsU=;
	b=oW2mnk22uNN8e36BWVDIzPef648HOHFt34h2IAuGS8W5L9fNVu8xZPh6x2w9cf4Oqc
	3xOaNReBpYJ7MjGvRZ23rEq5Smn8tVaps7UA/AFpOnJs6LRMJbCPL1dCUmGSYzM2WE0P
	9KDFuV3cZ+WGtpKB0g+jAIMAmTZBFBiNEJ+LFQSc2vSiwgM/xbDXdeXGjH2qvndJQiB7
	5bNJPvWYZ5UgkQuma5ZA8MRy2VvrkniDlYeBLyYJQS7SwMbxUElz/rARp3IZri4g2CNA
	142e2ot7Co5W330CA1uOMQJusqadK1U2hMFfpGU5sLweoKamYDDoGzMAwMzjGfe0w1ZR
	iCvg==
X-Gm-Message-State: APjAAAX2BcJFZqc3snT75fzW+ijyB/125M7URSvQWnD9xNdZG4V/TWle
	X5nfAJyBe53XaiNJa37eQGlNUg==
X-Google-Smtp-Source: APXvYqz4I4Q2pMam6gIPWF0y+WC3pQs+QP3P9mzbRRdDUjoABuQaMPTP68aUX2Hb7EQgcyuZVw6PBw==
X-Received: by 2002:a5d:4b81:: with SMTP id b1mr1310368wrt.217.1557914805413; 
	Wed, 15 May 2019 03:06:45 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id f2sm1889738wme.12.2019.05.15.03.06.44
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 03:06:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 755921FF87;
	Wed, 15 May 2019 11:06:44 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-7-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-7-arilou@gmail.com>
Date: Wed, 15 May 2019 11:06:44 +0100
Message-ID: <87zhnom3pn.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 06/27] gdbstub: Implement set_thread (H
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jon Doron <arilou@gmail.com> writes:

> Signed-off-by: Jon Doron <arilou@gmail.com>
> ---
>  gdbstub.c | 79 ++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 30 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index 469aaeb875..21cdaf4678 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1547,6 +1547,47 @@ static void handle_cont_with_sig(GdbCmdContext *gd=
b_ctx, void *user_ctx)
>      gdb_continue(gdb_ctx->s);
>  }
>
> +static void handle_set_thread(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    CPUState *cpu;
> +
> +    if (gdb_ctx->num_params < 2) {

Given we should have a fixed number of parameters !=3D 2 perhaps?

> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (gdb_ctx->params[1].thread_id.kind =3D=3D GDB_READ_THREAD_ERR) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    if (gdb_ctx->params[1].thread_id.kind !=3D GDB_ONE_THREAD) {
> +        put_packet(gdb_ctx->s, "OK");
> +        return;
> +    }
> +
> +    cpu =3D gdb_get_cpu(gdb_ctx->s, gdb_ctx->params[1].thread_id.pid,
> +                      gdb_ctx->params[1].thread_id.tid);
> +    if (!cpu) {
> +        put_packet(gdb_ctx->s, "E22");
> +        return;
> +    }
> +
> +    switch (gdb_ctx->params[0].opcode) {


Perhaps a comment here to say this is a legacy command and modern gdb's
should be using vCont?

> +    case 'c':
> +        gdb_ctx->s->c_cpu =3D cpu;
> +        put_packet(gdb_ctx->s, "OK");
> +        break;
> +    case 'g':
> +        gdb_ctx->s->g_cpu =3D cpu;
> +        put_packet(gdb_ctx->s, "OK");
> +        break;
> +    default:
> +        put_packet(gdb_ctx->s, "E22");
> +        break;
> +    }
> +}
<snip>

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e

