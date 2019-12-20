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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BC9C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:43:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3E620866
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 21:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfN3MXIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3E620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiQ3S-0002po-7n
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 16:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiQ1W-0000rr-0t
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:41:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iiQ1U-0000mT-Fx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 16:41:25 -0500
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:34966)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iiQ1U-0000ht-7d; Fri, 20 Dec 2019 16:41:24 -0500
Received: by mail-il1-x142.google.com with SMTP id g12so9200578ild.2;
 Fri, 20 Dec 2019 13:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VtAkNhpFNr5u4e9iNM3vzKqzfaaIUqBY0YwX3FjL5BU=;
 b=PfN3MXIn0z5Yc1TBM+3+QBtfIdPRRDO64ligJREStb4AaqhatrSqTImziSM+WYVzE/
 J62ebPPCUQx3B41n25SH0SAEX+C59gI5MDI/31apjjK1rudCjG5Zf5mtUxUX1BUSE5LV
 W8gTjxT7aGk/L9EdzE4BwIOu6+UCADisAUDS/rrXvFBaSoMP6uNAarDqmP0Ojz58TFmu
 mhqcMI2+lOEXcB6aZpdj6rjKpAXDGbbKDQ7aRH6E9H91pSK6Xelr90hmKdrtHceP1FWS
 FOTTAPpcxc15bn4LNwycua9bBuTlsA0H+wT0hM/BkhgqhFPTwTJT6k6lz94RW4zCozSw
 E/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VtAkNhpFNr5u4e9iNM3vzKqzfaaIUqBY0YwX3FjL5BU=;
 b=G2qUB470vTwNbqt14rshBVM+KPGmgToc5lLQQR2NIy46kG4CSAB/LoNsByxG0wt7vr
 RhuRzkHyYf5Yx3tQ0uGn3SQBnuoilvpLXyhUZKEeO3kmqcf6WmmadYnFM8WYVBs242H4
 db59bhKCemdwoaxZwZvGGkFPPlyFFZpEiFzl1uNZDkfvfrp65IjA2TZA1ma6dcdypazv
 Fk0LNV3e1HnJ04fj/0tHnU9eYddygaiMF7do4rSTS8oAaM40JMryOTzyiwCPVjfaCGcq
 2iL0o76plhdq03A9YpR+xyoH8SoMbDaNzubUhn2ZR7gykHRAF1xpq4EQjmF8XijJ0A2t
 niKA==
X-Gm-Message-State: APjAAAW7AaSYciG1Pc6sijFT8v2JiAGJPvpIkEXUdm73wIU3Ka6FscHE
 cIirf5LYIuSG4JQjNbPVYocgpXiQY7xRYtEUcW4=
X-Google-Smtp-Source: APXvYqw6SqoUT02xxtVUGNHoDjlzuZ8yfYjIe2K6IGSMAaqB74Twn/qJqchKHgQ2XXLJljRbH/fkrPAkVWGTX8ktmjc=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr13820251ilq.306.1576878083021; 
 Fri, 20 Dec 2019 13:41:23 -0800 (PST)
MIME-Version: 1.0
References: <20191219185127.24388-1-f4bug@amsat.org>
 <20191219185127.24388-5-f4bug@amsat.org>
In-Reply-To: <20191219185127.24388-5-f4bug@amsat.org>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Fri, 20 Dec 2019 22:41:12 +0100
Message-ID: <CAPan3Wqhyqe3ZyXGuQsxaZS_=U5vT6_PPEr1aL-xShJzhVCPgA@mail.gmail.com>
Subject: Re: [PATCH 04/13] hw/timer/allwinner: Move definitions from header to
 source
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000fe217a059a2989ed"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

--000000000000fe217a059a2989ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 7:51 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> These definitions are only used in the implementation, thus don't
> need to be exported. Move them in the source file.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/timer/allwinner-a10-pit.h | 28 --------------------------
>  hw/timer/allwinner-a10-pit.c         | 30 ++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 28 deletions(-)
>
> diff --git a/include/hw/timer/allwinner-a10-pit.h
> b/include/hw/timer/allwinner-a10-pit.h
> index e4a644add9..c28ee5ca47 100644
> --- a/include/hw/timer/allwinner-a10-pit.h
> +++ b/include/hw/timer/allwinner-a10-pit.h
> @@ -5,37 +5,9 @@
>  #include "hw/sysbus.h"
>
>  #define TYPE_AW_A10_PIT "allwinner-A10-timer"
> -#define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj),
> TYPE_AW_A10_PIT)
>
>  #define AW_PIT_TIMER_MAX        6
>
> -#define AW_A10_PIT_TIMER_NR    6
> -
> -#define AW_A10_PIT_TIMER_IRQ_EN    0
> -#define AW_A10_PIT_TIMER_IRQ_ST    0x4
> -
> -#define AW_A10_PIT_TIMER_CONTROL   0x0
> -#define AW_A10_PIT_TIMER_EN        0x1
> -#define AW_A10_PIT_TIMER_RELOAD    0x2
> -#define AW_A10_PIT_TIMER_MODE      0x80
> -
> -#define AW_A10_PIT_TIMER_INTERVAL  0x4
> -#define AW_A10_PIT_TIMER_COUNT     0x8
> -#define AW_A10_PIT_WDOG_CONTROL    0x90
> -#define AW_A10_PIT_WDOG_MODE       0x94
> -
> -#define AW_A10_PIT_COUNT_CTL       0xa0
> -#define AW_A10_PIT_COUNT_RL_EN     0x2
> -#define AW_A10_PIT_COUNT_CLR_EN    0x1
> -#define AW_A10_PIT_COUNT_LO        0xa4
> -#define AW_A10_PIT_COUNT_HI        0xa8
> -
> -#define AW_A10_PIT_TIMER_BASE      0x10
> -#define AW_A10_PIT_TIMER_BASE_END  \
> -    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUN=
T)
> -
> -#define AW_A10_PIT_DEFAULT_CLOCK   0x4
> -
>  typedef struct AwA10PITState AwA10PITState;
>
>  typedef struct AwA10TimerContext {
> diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
> index b31a0bcd43..00f7cc492d 100644
> --- a/hw/timer/allwinner-a10-pit.c
> +++ b/hw/timer/allwinner-a10-pit.c
> @@ -24,6 +24,36 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>
> +#define AW_A10_PIT_TIMER_NR         6
> +
> +#define AW_A10_PIT_TIMER_IRQ_EN     0
> +#define AW_A10_PIT_TIMER_IRQ_ST     0x4
> +
> +#define AW_A10_PIT_TIMER_CONTROL    0x0
> +#define AW_A10_PIT_TIMER_EN         0x1
> +#define AW_A10_PIT_TIMER_RELOAD     0x2
> +#define AW_A10_PIT_TIMER_MODE       0x80
> +
> +#define AW_A10_PIT_TIMER_INTERVAL   0x4
> +#define AW_A10_PIT_TIMER_COUNT      0x8
> +#define AW_A10_PIT_WDOG_CONTROL     0x90
> +#define AW_A10_PIT_WDOG_MODE        0x94
> +
> +#define AW_A10_PIT_COUNT_CTL        0xa0
> +#define AW_A10_PIT_COUNT_RL_EN      0x2
> +#define AW_A10_PIT_COUNT_CLR_EN     0x1
> +#define AW_A10_PIT_COUNT_LO         0xa4
> +#define AW_A10_PIT_COUNT_HI         0xa8
> +
> +#define AW_A10_PIT_TIMER_BASE       0x10
> +#define AW_A10_PIT_TIMER_BASE_END   \
> +    (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TIMER_COUN=
T)
> +
> +#define AW_A10_PIT_DEFAULT_CLOCK    0x4
> +
> +#define AW_A10_PIT(obj) \
> +    OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)
> +
>  static void a10_pit_update_irq(AwA10PITState *s)
>  {
>      int i;
> --
> 2.21.0
>
>
Looks fine and tested on -M orangepi-pc, -M cubieboard:
   Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
   Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

--=20
Niek Linnenbank

--000000000000fe217a059a2989ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Dec 19, 2019 at 7:51 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">These definitions are only used in the implementation, thus don&#39;t<br>
need to be exported. Move them in the source file.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0include/hw/timer/allwinner-a10-pit.h | 28 --------------------------<=
br>
=C2=A0hw/timer/allwinner-a10-pit.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 30 ++=
++++++++++++++++++++++++++<br>
=C2=A02 files changed, 30 insertions(+), 28 deletions(-)<br>
<br>
diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwin=
ner-a10-pit.h<br>
index e4a644add9..c28ee5ca47 100644<br>
--- a/include/hw/timer/allwinner-a10-pit.h<br>
+++ b/include/hw/timer/allwinner-a10-pit.h<br>
@@ -5,37 +5,9 @@<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
<br>
=C2=A0#define TYPE_AW_A10_PIT &quot;allwinner-A10-timer&quot;<br>
-#define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT=
)<br>
<br>
=C2=A0#define AW_PIT_TIMER_MAX=C2=A0 =C2=A0 =C2=A0 =C2=A0 6<br>
<br>
-#define AW_A10_PIT_TIMER_NR=C2=A0 =C2=A0 6<br>
-<br>
-#define AW_A10_PIT_TIMER_IRQ_EN=C2=A0 =C2=A0 0<br>
-#define AW_A10_PIT_TIMER_IRQ_ST=C2=A0 =C2=A0 0x4<br>
-<br>
-#define AW_A10_PIT_TIMER_CONTROL=C2=A0 =C2=A00x0<br>
-#define AW_A10_PIT_TIMER_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1<br>
-#define AW_A10_PIT_TIMER_RELOAD=C2=A0 =C2=A0 0x2<br>
-#define AW_A10_PIT_TIMER_MODE=C2=A0 =C2=A0 =C2=A0 0x80<br>
-<br>
-#define AW_A10_PIT_TIMER_INTERVAL=C2=A0 0x4<br>
-#define AW_A10_PIT_TIMER_COUNT=C2=A0 =C2=A0 =C2=A00x8<br>
-#define AW_A10_PIT_WDOG_CONTROL=C2=A0 =C2=A0 0x90<br>
-#define AW_A10_PIT_WDOG_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A00x94<br>
-<br>
-#define AW_A10_PIT_COUNT_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A00xa0<br>
-#define AW_A10_PIT_COUNT_RL_EN=C2=A0 =C2=A0 =C2=A00x2<br>
-#define AW_A10_PIT_COUNT_CLR_EN=C2=A0 =C2=A0 0x1<br>
-#define AW_A10_PIT_COUNT_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xa4<br>
-#define AW_A10_PIT_COUNT_HI=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xa8<br>
-<br>
-#define AW_A10_PIT_TIMER_BASE=C2=A0 =C2=A0 =C2=A0 0x10<br>
-#define AW_A10_PIT_TIMER_BASE_END=C2=A0 \<br>
-=C2=A0 =C2=A0 (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TI=
MER_COUNT)<br>
-<br>
-#define AW_A10_PIT_DEFAULT_CLOCK=C2=A0 =C2=A00x4<br>
-<br>
=C2=A0typedef struct AwA10PITState AwA10PITState;<br>
<br>
=C2=A0typedef struct AwA10TimerContext {<br>
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c<br=
>
index b31a0bcd43..00f7cc492d 100644<br>
--- a/hw/timer/allwinner-a10-pit.c<br>
+++ b/hw/timer/allwinner-a10-pit.c<br>
@@ -24,6 +24,36 @@<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;qemu/module.h&quot;<br>
<br>
+#define AW_A10_PIT_TIMER_NR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>
+<br>
+#define AW_A10_PIT_TIMER_IRQ_EN=C2=A0 =C2=A0 =C2=A00<br>
+#define AW_A10_PIT_TIMER_IRQ_ST=C2=A0 =C2=A0 =C2=A00x4<br>
+<br>
+#define AW_A10_PIT_TIMER_CONTROL=C2=A0 =C2=A0 0x0<br>
+#define AW_A10_PIT_TIMER_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1<br>
+#define AW_A10_PIT_TIMER_RELOAD=C2=A0 =C2=A0 =C2=A00x2<br>
+#define AW_A10_PIT_TIMER_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A00x80<br>
+<br>
+#define AW_A10_PIT_TIMER_INTERVAL=C2=A0 =C2=A00x4<br>
+#define AW_A10_PIT_TIMER_COUNT=C2=A0 =C2=A0 =C2=A0 0x8<br>
+#define AW_A10_PIT_WDOG_CONTROL=C2=A0 =C2=A0 =C2=A00x90<br>
+#define AW_A10_PIT_WDOG_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x94<br>
+<br>
+#define AW_A10_PIT_COUNT_CTL=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xa0<br>
+#define AW_A10_PIT_COUNT_RL_EN=C2=A0 =C2=A0 =C2=A0 0x2<br>
+#define AW_A10_PIT_COUNT_CLR_EN=C2=A0 =C2=A0 =C2=A00x1<br>
+#define AW_A10_PIT_COUNT_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xa4<br>
+#define AW_A10_PIT_COUNT_HI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xa8<br>
+<br>
+#define AW_A10_PIT_TIMER_BASE=C2=A0 =C2=A0 =C2=A0 =C2=A00x10<br>
+#define AW_A10_PIT_TIMER_BASE_END=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 (AW_A10_PIT_TIMER_BASE * AW_A10_PIT_TIMER_NR + AW_A10_PIT_TI=
MER_COUNT)<br>
+<br>
+#define AW_A10_PIT_DEFAULT_CLOCK=C2=A0 =C2=A0 0x4<br>
+<br>
+#define AW_A10_PIT(obj) \<br>
+=C2=A0 =C2=A0 OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)<br>
+<br>
=C2=A0static void a10_pit_update_irq(AwA10PITState *s)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
-- <br>
2.21.0<br>
<br>
</blockquote></div><div><br></div><div>Looks fine and tested on -M orangepi=
-pc, -M cubieboard:</div><div>=C2=A0=C2=A0 Tested-by: Niek Linnenbank &lt;<=
a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;=
</div><div>=C2=A0=C2=A0 Reviewed-by: Niek Linnenbank &lt;<a href=3D"mailto:=
nieklinnenbank@gmail.com">nieklinnenbank@gmail.com</a>&gt;<br></div><br>-- =
<br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek L=
innenbank<br><br></div></div></div></div>

--000000000000fe217a059a2989ed--

