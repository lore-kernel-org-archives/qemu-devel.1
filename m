Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E55C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AC520866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ts5KbL8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AC520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiPxt-0007Ar-4K
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:37:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPx3-0006jw-7R
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiPx1-0000Vv-W9
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:36:49 -0500
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:33708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiPx1-0000Sf-MH; Fri, 20 Dec 2019 16:36:47 -0500
Received: by mail-il1-x144.google.com with SMTP id v15so9189604iln.0;
 Fri, 20 Dec 2019 13:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qaNduU8pI7n8V/CKKVcoUQRc3In0xX5bjD7Gmv/Y+hc=;
 b=ts5KbL8gyyQ/p5//AlI3tqSjROTPVziRDg2LpRLvJ0cF/ZZ/YsEInO9QpS3Y8gSZWT
 MSFrM7ic5tyXr/Zh2K36PRr1ZXbSrKkxeJOymhVuARIIFCLwi3lyJNV2M5pvkfzti9Jx
 6W1OOthh5u6HCUqFfnRdAbO30u5L5PkE3mkiGj/r+Bvn/RMeHtkZg9rDa2QCBH6Uc/eV
 jELaXUCnrxmKglNhFV4TwL+alSTV0XW9sdWNmxIxQiTWLuwSoogZ6qQhKX74iZ9lCtpa
 FTHkWcN/lIIavRhoznr/xYl9qOCZ0zHw4Dvouo9SGkFlcIFMTdxplym3H1HM/fDymVFD
 Y4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qaNduU8pI7n8V/CKKVcoUQRc3In0xX5bjD7Gmv/Y+hc=;
 b=sDK0gy5tpFiL1TacigLwHVfrEnDIe4Dyge2kmye1Us0vzMNrCpeXsf76z0jGxcJSfN
 jS4+tPWM74fUgRnlRfoe0QSrDQ33U6HMKiy8iOxqCb2DpzmnaluN8e4QHkqyUNnWkhWw
 Fq10wIEZmHYNwRgE2nxzIL2Uz2FcwzcXRnJNj+KETeOFjz3CA0yqF+nZ/hPV0y344DLB
 hXzZcXiVBcNt239zQ+VigA13XR7ZFbx05PMOTJ7anDJNQGT0ESGpy5WWyy9gNkZdggfm
 9eS7BLuiv9DkrWLzcXisJMHtRCZ5FgOJknWKJEd3fRwxFbFZ3IexqMxGMVDaIIHoc34G
 LWDg==
X-Gm-Message-State: APjAAAUwt/pm0VS17Duqn5QZtXw5J7rf3xsxB9rcb99fB9MBvas1iFGL
 CljQsJ8HCdmjSVJTg3kRzlFaziUWTH0XoWtpgBQ=
X-Google-Smtp-Source: APXvYqy0ejjKb+evxfxYiekibHgX3aK03HXa1usu+LcJM6GlM32fOk4eGuolB2K98JotFfFJJ9oOPHwDaKsmczJP8Bs=
X-Received: by 2002:a92:af08:: with SMTP id n8mr13914978ili.217.1576877803146; 
 Fri, 20 Dec 2019 13:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
 <20191219185127.24388-4-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-4-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 22:36:32 +0100
Message-ID: <CAPan3WqzABfVmopUaCNkBxftZsZ=GR=Vts0qE_o7y81mP56EaQ@mail.gmail.com>
Subject: Re: [PATCH 03/13] hw/timer/allwinner: Remove unused definitions
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000004f9359059a297968"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000004f9359059a297968
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> Keeping unused definition is rather confusing when reviewing.
> Remove them.
>
Perhaps make it more clear that the definitions are unused IRQ defines?


>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/timer/allwinner-a10-pit.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/hw/timer/allwinner-a10-pit.h
> b/include/hw/timer/allwinner-a10-pit.h
> index 54c40c7db6..e4a644add9 100644
> --- a/include/hw/timer/allwinner-a10-pit.h
> +++ b/include/hw/timer/allwinner-a10-pit.h
> @@ -10,8 +10,6 @@
>  #define AW_PIT_TIMER_MAX        6
>
>  #define AW_A10_PIT_TIMER_NR    6
> -#define AW_A10_PIT_TIMER_IRQ   0x1
> -#define AW_A10_PIT_WDOG_IRQ    0x100
>
>  #define AW_A10_PIT_TIMER_IRQ_EN    0
>  #define AW_A10_PIT_TIMER_IRQ_ST    0x4
> --
> 2.21.0
>
> Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>


--=20
Niek Linnenbank

--0000000000004f9359059a297968
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">Keeping unused definition is rather confusing when reviewing.<br>
Remove them.<br></blockquote><div>Perhaps make it more clear that the defin=
itions are unused IRQ defines?<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwin=
ner-a10-pit.h<br>
index 54c40c7db6..e4a644add9 100644<br>
--- a/include/hw/timer/allwinner-a10-pit.h<br>
+++ b/include/hw/timer/allwinner-a10-pit.h<br>
@@ -10,8 +10,6 @@<br>
=C2=A0#define AW_PIT_TIMER_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
<br>
=C2=A0#define AW_A10_PIT_TIMER_NR=C2=A0 =C2=A0 6<br>
-#define AW_A10_PIT_TIMER_IRQ=C2=A0 =C2=A00x1<br>
-#define AW_A10_PIT_WDOG_IRQ=C2=A0 =C2=A0 0x100<br>
<br>
=C2=A0#define AW_A10_PIT_TIMER_IRQ_EN=C2=A0 =C2=A0 0<br>
=C2=A0#define AW_A10_PIT_TIMER_IRQ_ST=C2=A0 =C2=A0 0x4<br>
-- <br>
2.21.0<br>
<br></blockquote><div>Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:ni=
eklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;</div><div>Tested-b=
y: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinn=
enbank@gmail.com</a>&gt;<br></div></div><br clear=3D"all"><br>-- <br><div d=
ir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<=
br><br></div></div></div></div>

--0000000000004f9359059a297968--

