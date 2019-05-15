Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5346CC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CFE420862
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xKDLnvhF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CFE420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39363 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQwVa-0001dR-5c
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQwUk-0001MN-Ox
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:11:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQwUi-00041U-2b
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:11:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQwUf-0003r2-JL
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:11:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id i3so611336wml.4
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5UZ0MlRKqle2hmtTs6beMk0fpe+fn2n5zvXxyj+X1hg=;
	b=xKDLnvhFg+00UP6KsDB0kiH6IkCq8szeZZeuAHvwzR1thOKk4mgdyTSKS1M7tm0Tqp
	dvFsUGzra+6InhxhYsY9BHQSnaq4YE3s86UP/BRJPA6I3m4q3MqhSTqr/TFGtOEV0h15
	iEt7L6p4NolE0y6vAIM1KjTrFlio+VkbvOH59sFidu7t+gomEB2wQe83Je/OQ9mAAM9Y
	ZaIMLfsZJ9kfwJEb1BlB8qR0HboBNIYKWjB6gktI1qb5ACfrjmiYSDrdR2POyvm3NGCs
	LNhdhcvzbl+nlnM1DgiwH9Y/QVjn6Qo/OMszg0F6ebGsqlMdFEvRXyqWagX54j9YGqFh
	hszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5UZ0MlRKqle2hmtTs6beMk0fpe+fn2n5zvXxyj+X1hg=;
	b=pleF25HyoIzk5dxMGyDHQzJlLqWK7x9Hzvkbljg9AFTLN6w41cROcHP4cJV99Y6xDN
	/nIczY4jO7Ez9rTmIXhHAq6O6TRNjHVWK11xFNyC+iVl012sKpP4cbyW/r7+9d/oUqlR
	P6ddIA1W/VOUEUEaHfvymvX9eCPplBI2Qgd9yYng1wXarEewb9gQuMXViUgWWyEdYb+P
	zbWfPuvpFpiD3AHFPG629MaTWL9WKOCMTG3gjQbH32ZxPW5yAdfYdhCnXkXs3rWlHYPa
	vm3JZYiVGiaom3sb2HFDHzUOxmhXwy8G5DRtZxjTlIflAlQHhhfyBTM5yKALlwe44mdR
	BT8Q==
X-Gm-Message-State: APjAAAVoX+9fL6UQl3whXuRQR9bDg5w/Woo9nJdIYKT2Bi/P7IsQ7NlD
	Vn83477Q+XVrZNQqC6XD1QklWQ==
X-Google-Smtp-Source: APXvYqzfx0xK6aLfpPE8gvEo2CLcRBh3aU701RdClHalcwVkbviqTEpP2DvMugYOkGayPD++JmFolw==
X-Received: by 2002:a1c:486:: with SMTP id 128mr22547020wme.83.1557936655310; 
	Wed, 15 May 2019 09:10:55 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	y184sm2989770wmg.7.2019.05.15.09.10.54
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 09:10:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 260791FF87;
	Wed, 15 May 2019 17:10:54 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-15-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-15-arilou@gmail.com>
Date: Wed, 15 May 2019 17:10:54 +0100
Message-ID: <87lfz7n1f5.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v9 14/27] gdbstub: Implement read all
 registers (g pkt) with new infra
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
>  gdbstub.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index adfe39b3a3..3478ac778d 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1757,6 +1757,21 @@ static void handle_write_all_regs(GdbCmdContext *g=
db_ctx, void *user_ctx)
>      put_packet(gdb_ctx->s, "OK");
>  }
>
> +static void handle_read_all_regs(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    target_ulong addr, len;
> +
> +    cpu_synchronize_state(gdb_ctx->s->g_cpu);
> +    len =3D 0;
> +    for (addr =3D 0; addr < gdb_ctx->s->g_cpu->gdb_num_g_regs; addr++) {
> +        len +=3D gdb_read_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf +=
 len,
> +                                 addr);
> +    }

Again no bounds checking - we get away with it because for hppa:

  (* 8 128 2) =3D 2048

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> +
> +    memtohex(gdb_ctx->str_buf, gdb_ctx->mem_buf, len);
> +    put_packet(gdb_ctx->s, gdb_ctx->str_buf);
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1764,7 +1779,7 @@ static int gdb_handle_packet(GDBState *s, const cha=
r *line_buf)
>      CPUClass *cc;
>      const char *p;
>      uint32_t pid, tid;
> -    int ch, reg_size, type, res;
> +    int ch, type, res;
>      uint8_t mem_buf[MAX_PACKET_LENGTH];
>      char buf[sizeof(mem_buf) + 1 /* trailing NUL */];
>      char thread_id[16];
> @@ -1923,14 +1938,14 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'g':
> -        cpu_synchronize_state(s->g_cpu);
> -        len =3D 0;
> -        for (addr =3D 0; addr < s->g_cpu->gdb_num_g_regs; addr++) {
> -            reg_size =3D gdb_read_register(s->g_cpu, mem_buf + len, addr=
);
> -            len +=3D reg_size;
> +        {
> +            static const GdbCmdParseEntry read_all_regs_cmd_desc =3D {
> +                .handler =3D handle_read_all_regs,
> +                .cmd =3D "g",
> +                .cmd_startswith =3D 1
> +            };
> +            cmd_parser =3D &read_all_regs_cmd_desc;
>          }
> -        memtohex(buf, mem_buf, len);
> -        put_packet(s, buf);
>          break;
>      case 'G':
>          {


--
Alex Benn=C3=A9e

