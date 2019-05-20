Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7371BC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423DA2171F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 15:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrP5WOGl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423DA2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37516 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSkcP-0008Cu-HL
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 11:54:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSkbO-0007ga-8G
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hSkbM-0001JD-Gr
	for qemu-devel@nongnu.org; Mon, 20 May 2019 11:53:26 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hSkbM-0001IS-BW; Mon, 20 May 2019 11:53:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id i8so13395890oth.10;
	Mon, 20 May 2019 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=ADnEJ+RAf77BFuIoavz9FxqwTbRXPfb1+l/Atje8Xn4=;
	b=KrP5WOGluB2AotWwHPVnc4M2SRORPz4cZdq6eX/N0wLkQhY+5YX8k4p8PsWJR6vfSK
	r0AXUcsRoUTtKfQo2MWMUFnrwbYpKX+PU1ooy5JxWxYslS/h5YUoRh9vv4ZXKQMMZRls
	WQU5GyEGVniBz6IG05gos0+Fyi0nRK+0fmSs8orff2ndF28nj66EOswSiS1fmIxiZq4y
	1lJjHVgoqXryFbpTKRh7jHtdGtPrtCzMmTzFLnKqaQyFb3DEPNrqB0NPrT4htC6iQdmv
	cRMDws7yn0j3in4llyNnSOwAdQgdT29ACo+wcCxDgGsVz8zRPMOL81TrDpEzdSh/6O5D
	547A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=ADnEJ+RAf77BFuIoavz9FxqwTbRXPfb1+l/Atje8Xn4=;
	b=MhXnbeplt8xLh1BoESjdaXSRNaLCCSeRa0QhxszM5wyYAdYUgFO+vzUqaPmRApd91V
	1PZ1brKmzKUwkZLG10G5BcPrPrwqCAOCanWI849fWiwosSZm1VrowC7jc8p0vDzuIm1T
	kVSveJBb6C4f+appEp4KKeSK/9WE84QsvrFV4SZ4ZWtT0OKXn4EV1ZKws2Gp3L5rBNFu
	GUQsG3luc2d4hhgfVi8QucmHrtW7JZ64q6JzzBi6Ty5H+Ns/ACwGhmavPydofNpzK/tu
	yqhGODTfqBrPdwZaI44hIHNglQNy3dBL7z6amLHQ1HMpMEQ4u3ThH9sD2B+xBmUifIeT
	d4zQ==
X-Gm-Message-State: APjAAAXGvDmmH8FhpvmIEwArxAK8p2ticezOmG+nJhj3bubjrXgstPwN
	2FOO9q6oDq9nk0o0hjeDhJ0vaptyyifkTMLom1A=
X-Google-Smtp-Source: APXvYqwGePBfC82FzgKDUQJuY7XGTQB79jEbIIIQEhEucdotmRq832Pb5CMsJvlBl8d+d0rALkoEinjMeol23Mve04U=
X-Received: by 2002:a05:6830:160a:: with SMTP id
	g10mr12353otr.121.1558367601478; 
	Mon, 20 May 2019 08:53:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 08:53:20
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 20 May 2019 08:53:20
	-0700 (PDT)
In-Reply-To: <20190514155301.16123-11-alex.bennee@linaro.org>
References: <20190514155301.16123-1-alex.bennee@linaro.org>
	<20190514155301.16123-11-alex.bennee@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 20 May 2019 17:53:20 +0200
Message-ID: <CAL1e-=gGT3kFnc1JCiDne3EFDJMy_7nraMc=Pov=fE1ePK_AWg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RFC PATCH 10/11] target/mips: convert UHI_plog to
 use common semihosting code
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 14, 2019 6:02 PM, "Alex Benn=C3=A9e" <alex.bennee@linaro.org> wrote:
>
> Rather than printing directly to stdout lets use our common
> semihosting code. There is one minor difference in that the output
> currently defaults to stderr instead of stdout however this can be
> controlled by connecting semihosting to a chardev.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  target/mips/mips-semi.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/mips/mips-semi.c b/target/mips/mips-semi.c
> index eac8374fb34..35bdfd7c77e 100644
> --- a/target/mips/mips-semi.c
> +++ b/target/mips/mips-semi.c
> @@ -23,6 +23,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/softmmu-semi.h"
>  #include "hw/semihosting/semihost.h"
> +#include "hw/semihosting/console.h"
>
>  typedef enum UHIOp {
>      UHI_exit =3D 1,
> @@ -329,13 +330,12 @@ void helper_do_semihosting(CPUMIPSState *env)
>          p2 =3D strstr(p, "%d");
>          if (p2) {
>              int char_num =3D p2 - p;
> -            char *buf =3D g_malloc(char_num + 1);
> -            strncpy(buf, p, char_num);
> -            buf[char_num] =3D '\0';
> -            gpr[2] =3D printf("%s%d%s", buf, (int)gpr[5], p2 + 2);
> -            g_free(buf);
> +            GString *s =3D g_string_new_len(p, char_num);
> +            g_string_append_printf(s, "%d%s", (int)gpr[5], p2 + 2);
> +            gpr[2] =3D qemu_semihosting_log_out(s->str, s->len);
> +            g_string_free(s, true);
>          } else {
> -            gpr[2] =3D printf("%s", p);
> +            gpr[2] =3D qemu_semihosting_log_out(p, strlen(p));
>          }
>          FREE_TARGET_STRING(p, gpr[4]);
>          break;
> --
> 2.20.1
>
>
