Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBEBC04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC39F20675
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 12:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLaIcoGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC39F20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36302 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQsoL-0007tp-OC
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 08:15:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQsnX-0007d0-Cq
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hQsnW-0007cT-GK
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:14:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hQsnW-0007a7-90
	for qemu-devel@nongnu.org; Wed, 15 May 2019 08:14:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id h4so2409671wre.7
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 05:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=5qqzesvhojC9k1bGAx7x8W1aIl0HcNhubzzZmLO+gB8=;
	b=vLaIcoGSh6Yl2XScWhw8bJ0VE5HSlFKd8rsxTiIwprWlD6vPB6gDX0ZLcEJsdQyunc
	VsLgICfb2Qy29wwVNYmWrY8Q21c9Fs2IerGQiElOGUqCNVoTduipmke0HROgjRsooFg/
	Noizf9UZoBXo4hIXTpSSPimGs5CEdbivB8MWcU9CA26LmDsI1iFlnEmo5cynKjTH7RsJ
	3GdOoEPwCuNtZFxqzolc7z3D9hlzpE/0J3HqDJNTIq8nbEfgKWtWyzWSqS58SgUQqQtb
	m4tARb6znY6W0jf4ttChal8WBeNStC+wyPmpSBva6ZdW9H/rc+v4xw7Xw1DZfn+Rxmvd
	S00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=5qqzesvhojC9k1bGAx7x8W1aIl0HcNhubzzZmLO+gB8=;
	b=FHwWV/weFgU5BXBR/7sq5LE/HDjyZSOrl0H2VgPBjBfPjkMd7/HYIOrdrj/pyqNrsW
	D1mIgdEvdEYuINLcHKnG819FIoDcpnKp+LWCvr+/SoaXaV117rdIFCSiT4qZnEOWFCF1
	InhivBmMCq7ebmolPyzDG2rLgDWvLUWCkd8RS+mX9jvatiHmPw2DzYJvGrTCTEKdBDcA
	FB9yWKtR030Vbv+3T6qdBpxlFPkKfFlsJcEsFb2ZzLyISn55VGKgGhfkLPp+RLzk2Eyw
	kioDHgMqtKTx8fPhKcJYVibKg3hQdysf/rlxfyyGN97fQPM3VRFYe2YD0nHsAahKIVMt
	kCUw==
X-Gm-Message-State: APjAAAXv9riRcKxQ2xlFXbUIIUZPD5YwtsBG6Ddn3hI40n3N7tFuT5/1
	QAtotqbSt6jBvq9xe2BJUfhRJw==
X-Google-Smtp-Source: APXvYqxokQh0Rlpm9JMxTR8wEVV+z0gdqhR5vLrCIVEWXu0mF+jfGg1YBjuLDyL449/bDXHg8PCvtg==
X-Received: by 2002:adf:cd09:: with SMTP id w9mr10093904wrm.242.1557922452307; 
	Wed, 15 May 2019 05:14:12 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	h188sm3275671wmf.48.2019.05.15.05.14.11
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 15 May 2019 05:14:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id D3A351FF87;
	Wed, 15 May 2019 13:14:10 +0100 (BST)
References: <20190502081554.5521-1-arilou@gmail.com>
	<20190502081554.5521-10-arilou@gmail.com>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jon Doron <arilou@gmail.com>
In-reply-to: <20190502081554.5521-10-arilou@gmail.com>
Date: Wed, 15 May 2019 13:14:10 +0100
Message-ID: <87v9ybncdp.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v9 09/27] gdbstub: Implement set register
 (P pkt) with new infra
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
>  gdbstub.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/gdbstub.c b/gdbstub.c
> index b42425b24c..10e3f12a68 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -1634,6 +1634,27 @@ static void handle_remove_bp(GdbCmdContext *gdb_ct=
x, void *user_ctx)
>      put_packet(gdb_ctx->s, "E22");
>  }
>
> +static void handle_set_reg(GdbCmdContext *gdb_ctx, void *user_ctx)
> +{
> +    int reg_size;
> +
> +    if (!gdb_has_xml) {
> +        put_packet(gdb_ctx->s, "");
> +        return;
> +    }
> +
> +    if (gdb_ctx->num_params < 2) {

!=3D 2?

> +        put_packet(gdb_ctx->s, "");
> +        return;
> +    }

I don't understand what these null put_packets have been added for.
Should we not report an E code on failure?

> +
> +    reg_size =3D strlen(gdb_ctx->params[1].data) / 2;
> +    hextomem(gdb_ctx->mem_buf, gdb_ctx->params[1].data, reg_size);
> +    gdb_write_register(gdb_ctx->s->g_cpu, gdb_ctx->mem_buf,
> +                       gdb_ctx->params[0].val_ull);
> +    put_packet(gdb_ctx->s, "OK");
> +}
> +
>  static int gdb_handle_packet(GDBState *s, const char *line_buf)
>  {
>      CPUState *cpu;
> @@ -1878,15 +1899,15 @@ static int gdb_handle_packet(GDBState *s, const c=
har *line_buf)
>          }
>          break;
>      case 'P':
> -        if (!gdb_has_xml)
> -            goto unknown_command;
> -        addr =3D strtoull(p, (char **)&p, 16);
> -        if (*p =3D=3D '=3D')
> -            p++;
> -        reg_size =3D strlen(p) / 2;
> -        hextomem(mem_buf, p, reg_size);
> -        gdb_write_register(s->g_cpu, mem_buf, addr);
> -        put_packet(s, "OK");
> +        {
> +            static const GdbCmdParseEntry set_reg_cmd_desc =3D {
> +                .handler =3D handle_set_reg,
> +                .cmd =3D "P",
> +                .cmd_startswith =3D 1,
> +                .schema =3D "L?s0"
> +            };
> +            cmd_parser =3D &set_reg_cmd_desc;
> +        }
>          break;
>      case 'Z':
>          {


--
Alex Benn=C3=A9e

