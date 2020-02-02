Return-Path: <SRS0=8j4I=3W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C36C35249
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 21:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D686D20679
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Feb 2020 21:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6w53i5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D686D20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyN2t-00059c-2p
	for qemu-devel@archiver.kernel.org; Sun, 02 Feb 2020 16:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyN21-0004dy-6E
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 16:43:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nieklinnenbank@gmail.com>) id 1iyN1z-00074U-Cc
 for qemu-devel@nongnu.org; Sun, 02 Feb 2020 16:43:53 -0500
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41996)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nieklinnenbank@gmail.com>)
 id 1iyN1z-00073c-4o; Sun, 02 Feb 2020 16:43:51 -0500
Received: by mail-il1-x143.google.com with SMTP id x2so10930344ila.9;
 Sun, 02 Feb 2020 13:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pQAOyvZCxX2t+S3wlFpJjQKG21Xr2E/8UGs0vZsuCvE=;
 b=o6w53i5U1L9X4kyyxzee+szMiRPTJq09MXZTKGRwjiFUkGlpvMVGYwxfayTBxtAfwv
 2thAcOhnXxa/PphIjZJDjIvUi3GY2S6faphUjFuYrKVgVdATqddUUtTCRxT5qn1SFGYG
 tEaaQFZKCCX8atTVyJBu1XOuyQS2XwFxWUeeb2fu1PVY53Q7OmxdlY8qd3ERfY9Ecw3N
 AjjDT8YAzQLRxQAEcKJPEgnDsB1trZ+Wmyo2M4f4fy+8KJCJ3mZEk3HK1a7xMJTEtX2p
 JNeka+f8SMSYPcLzNXVnajIMJiuYxDxwNxfF6qopfkCXkCXUwaFeNNDUBL82q6e1t5SQ
 jptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pQAOyvZCxX2t+S3wlFpJjQKG21Xr2E/8UGs0vZsuCvE=;
 b=jm5C6u3OysKqu7FCGl84oFVAlQblHdCk106lkJu7RfBUkmBTIY5L7pOJIZDtoiTcaG
 McUXzw5EVO/AFZDx4/zOCzWkqOTeBXu+vxC2HNpvl9712l8Pj+EZbbvg4WAwWR8i/rLO
 jBdK7bwPsLPt8iTTk3WNIysZ+zt/3jyfRQSterKCeMj6JbNYmGAaSLDjijLlkhAAh+Om
 c8yjYGyo1tIu+uATmgNP1i0puiVWoUC9slZ1NsSALN/8vTYjnCNhQZQkLRkB5dnJioOS
 gen/YWPpULZEA0DJGOvUO5jhll0omwse7QUtizp1ZFh26f7aPcOtfxi7BL1Hu82dt7qp
 Km7Q==
X-Gm-Message-State: APjAAAWq7AVIy0HwUdmLoFArQ5x5a/5ZYOr3RyolIUXJQBmix2z9KcAj
 5pmrV6OghyzZcahphRDkvrZbHGgjwA15SsRtbBk=
X-Google-Smtp-Source: APXvYqz46jya3SDG1xYPFoIkwOwpJr7sJUNBGN2mG+/0W+poPZeNrkLO11JFgBJnqUgWlHzvXvPQ44RkYv4o0CafG3g=
X-Received: by 2002:a92:88dc:: with SMTP id m89mr12737000ilh.265.1580679830409; 
 Sun, 02 Feb 2020 13:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <20200119005102.3847-9-nieklinnenbank@gmail.com>
 <e9c31386-d471-159a-6cb0-7e621cb3bc83@redhat.com>
In-Reply-To: <e9c31386-d471-159a-6cb0-7e621cb3bc83@redhat.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Sun, 2 Feb 2020 22:43:39 +0100
Message-ID: <CAPan3WpJnd4YPa1DT_5Z6+i5yVahAE7sFHZ6JXqC69KstFG+Mg@mail.gmail.com>
Subject: Re: [PATCH v4 08/20] hw/arm/allwinner: add SD/MMC host controller
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000cb9547059d9eb341"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::143
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 imammedo@redhat.com, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000cb9547059d9eb341
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On Sun, Jan 19, 2020 at 8:02 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com>
wrote:

> On 1/19/20 1:50 AM, Niek Linnenbank wrote:
> > The Allwinner System on Chip families sun4i and above contain
> > an integrated storage controller for Secure Digital (SD) and
> > Multi Media Card (MMC) interfaces. This commit adds support
> > for the Allwinner SD/MMC storage controller with the following
> > emulated features:
> >
> >   * DMA transfers
> >   * Direct FIFO I/O
> >   * Short/Long format command responses
> >   * Auto-Stop command (CMD12)
> >   * Insert & remove card detection
> >
> > The following boards are extended with the SD host controller:
> >
> >   * Cubieboard (hw/arm/cubieboard.c)
> >   * Orange Pi PC (hw/arm/orangepi.c)
> >
> > Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > ---
> >   include/hw/arm/allwinner-a10.h   |   2 +
> >   include/hw/arm/allwinner-h3.h    |   3 +
> >   include/hw/sd/allwinner-sdhost.h | 135 +++++
> >   hw/arm/allwinner-a10.c           |  11 +
> >   hw/arm/allwinner-h3.c            |  15 +-
> >   hw/arm/cubieboard.c              |  15 +
> >   hw/arm/orangepi.c                |  16 +
> >   hw/sd/allwinner-sdhost.c         | 848 ++++++++++++++++++++++++++++++=
+
> >   hw/sd/Makefile.objs              |   1 +
> >   hw/sd/trace-events               |   7 +
> >   10 files changed, 1052 insertions(+), 1 deletion(-)
> >   create mode 100644 include/hw/sd/allwinner-sdhost.h
> >   create mode 100644 hw/sd/allwinner-sdhost.c
>
> Failure at build if configured with --without-default-devices:
>
>    CC      arm-softmmu/hw/sd/allwinner-sdhost.o
>    CC      arm-softmmu/hw/arm/orangepi.o
>    CC      arm-softmmu/hw/arm/allwinner-h3.o
>    LINK    arm-softmmu/qemu-system-arm
> /usr/bin/ld: hw/sd/allwinner-sdhost.o: in function
> `allwinner_sdhost_send_command':
> hw/sd/allwinner-sdhost.c:239: undefined reference to `sdbus_do_command'
> /usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_read=
':
> hw/sd/allwinner-sdhost.c:517: undefined reference to `sdbus_data_ready'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:518: undefined reference to
> `sdbus_read_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:519: undefined reference to
> `sdbus_read_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:520: undefined reference to
> `sdbus_read_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:521: undefined reference to
> `sdbus_read_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.o: in function
> `allwinner_sdhost_process_desc':
> hw/sd/allwinner-sdhost.c:340: undefined reference to `sdbus_read_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:334: undefined reference to
> `sdbus_write_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.o: in function
> `allwinner_sdhost_write':
> hw/sd/allwinner-sdhost.c:651: undefined reference to `sdbus_write_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:652: undefined reference to
> `sdbus_write_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:653: undefined reference to
> `sdbus_write_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.c:654: undefined reference to
> `sdbus_write_data'
> /usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_dma'=
:
> hw/sd/allwinner-sdhost.c:372: undefined reference to `sdbus_data_ready'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:206: qemu-system-arm] Error 1
>
>
Thanks for reporting this Philippe. As you pointed out, I also made the
same mistake in patch #4 for USB support [1].
Here I also tried to re-produce the error here with:

$ ./configure --target-list=3Darm-softmmu --without-default-devices; make -=
j5

But again no error. I also see that CONFIG_SD=3Dy is set in
arm-softmmu/config-devices.mak.
Maybe on my laptop  --without-default-devices has no effect or is overriden
somehow, I'll try to debug it further.

[1] https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00125.html


> Fixed by:
>
> -- >8 --
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index bb75c1de17..086241354c 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -302,6 +302,9 @@ config ALLWINNER_H3
>       select ARM_TIMER
>       select ARM_GIC
>       select UNIMP
>       select USB_OHCI
>       select USB_EHCI_SYSBUS
> +    select SD
>
> Thanks, I'll add this fix.

Regards,
Niek


>   config RASPI
>       bool
> ---
>
>

--=20
Niek Linnenbank

--000000000000cb9547059d9eb341
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Philippe,<br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Jan 19, 2020 at 8:02 PM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com">philmd@redh=
at.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 1/19/20 1:50 AM, Niek Linnenbank wrote:<br>
&gt; The Allwinner System on Chip families sun4i and above contain<br>
&gt; an integrated storage controller for Secure Digital (SD) and<br>
&gt; Multi Media Card (MMC) interfaces. This commit adds support<br>
&gt; for the Allwinner SD/MMC storage controller with the following<br>
&gt; emulated features:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* DMA transfers<br>
&gt;=C2=A0 =C2=A0* Direct FIFO I/O<br>
&gt;=C2=A0 =C2=A0* Short/Long format command responses<br>
&gt;=C2=A0 =C2=A0* Auto-Stop command (CMD12)<br>
&gt;=C2=A0 =C2=A0* Insert &amp; remove card detection<br>
&gt; <br>
&gt; The following boards are extended with the SD host controller:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0* Cubieboard (hw/arm/cubieboard.c)<br>
&gt;=C2=A0 =C2=A0* Orange Pi PC (hw/arm/orangepi.c)<br>
&gt; <br>
&gt; Signed-off-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gm=
ail.com" target=3D"_blank">nieklinnenbank@gmail.com</a>&gt;<br>
&gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@re=
dhat.com" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-a10.h=C2=A0 =C2=A0|=C2=A0 =C2=A02=
 +<br>
&gt;=C2=A0 =C2=A0include/hw/arm/allwinner-h3.h=C2=A0 =C2=A0 |=C2=A0 =C2=A03=
 +<br>
&gt;=C2=A0 =C2=A0include/hw/sd/allwinner-sdhost.h | 135 +++++<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-a10.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 11 +<br>
&gt;=C2=A0 =C2=A0hw/arm/allwinner-h3.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 15 +-<br>
&gt;=C2=A0 =C2=A0hw/arm/cubieboard.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 15 +<br>
&gt;=C2=A0 =C2=A0hw/arm/orangepi.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 |=C2=A0 16 +<br>
&gt;=C2=A0 =C2=A0hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| 848 +++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/sd/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 =C2=A0hw/sd/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A07 +<br>
&gt;=C2=A0 =C2=A010 files changed, 1052 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 =C2=A0create mode 100644 include/hw/sd/allwinner-sdhost.h<br>
&gt;=C2=A0 =C2=A0create mode 100644 hw/sd/allwinner-sdhost.c<br>
<br>
Failure at build if configured with --without-default-devices:<br>
<br>
=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 arm-softmmu/hw/sd/allwinner-sdhost.o<br=
>
=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 arm-softmmu/hw/arm/orangepi.o<br>
=C2=A0 =C2=A0CC=C2=A0 =C2=A0 =C2=A0 arm-softmmu/hw/arm/allwinner-h3.o<br>
=C2=A0 =C2=A0LINK=C2=A0 =C2=A0 arm-softmmu/qemu-system-arm<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function <br>
`allwinner_sdhost_send_command&#39;:<br>
hw/sd/allwinner-sdhost.c:239: undefined reference to `sdbus_do_command&#39;=
<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_read&#=
39;:<br>
hw/sd/allwinner-sdhost.c:517: undefined reference to `sdbus_data_ready&#39;=
<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:518: undefined reference to <br>
`sdbus_read_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:519: undefined reference to <br>
`sdbus_read_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:520: undefined reference to <br>
`sdbus_read_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:521: undefined reference to <br>
`sdbus_read_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function <br>
`allwinner_sdhost_process_desc&#39;:<br>
hw/sd/allwinner-sdhost.c:340: undefined reference to `sdbus_read_data&#39;<=
br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:334: undefined reference to <br>
`sdbus_write_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_write&=
#39;:<br>
hw/sd/allwinner-sdhost.c:651: undefined reference to `sdbus_write_data&#39;=
<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:652: undefined reference to <br>
`sdbus_write_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:653: undefined reference to <br>
`sdbus_write_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.c:654: undefined reference to <br>
`sdbus_write_data&#39;<br>
/usr/bin/ld: hw/sd/allwinner-sdhost.o: in function `allwinner_sdhost_dma&#3=
9;:<br>
hw/sd/allwinner-sdhost.c:372: undefined reference to `sdbus_data_ready&#39;=
<br>
collect2: error: ld returned 1 exit status<br>
make[1]: *** [Makefile:206: qemu-system-arm] Error 1<br>
<br></blockquote><div><br></div><div>Thanks for reporting this Philippe. As=
 you pointed out, I also made the same mistake in patch #4 for USB support =
[1].</div><div>Here I also tried to re-produce the error here with:</div><d=
iv><br></div><div>$ ./configure --target-list=3Darm-softmmu --without-defau=
lt-devices; make -j5</div><div><br></div><div>But again no error. I also se=
e that CONFIG_SD=3Dy is set in arm-softmmu/config-devices.mak.</div><div>Ma=
ybe on my laptop=C2=A0 --without-default-devices has no effect or is overri=
den somehow, I&#39;ll try to debug it further.</div><div><br></div><div>[1]=
 <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00125.=
html">https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00125.html</=
a></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Fixed by:<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig<br>
index bb75c1de17..086241354c 100644<br>
--- a/hw/arm/Kconfig<br>
+++ b/hw/arm/Kconfig<br>
@@ -302,6 +302,9 @@ config ALLWINNER_H3<br>
=C2=A0 =C2=A0 =C2=A0 select ARM_TIMER<br>
=C2=A0 =C2=A0 =C2=A0 select ARM_GIC<br>
=C2=A0 =C2=A0 =C2=A0 select UNIMP<br>
=C2=A0 =C2=A0 =C2=A0 select USB_OHCI<br>
=C2=A0 =C2=A0 =C2=A0 select USB_EHCI_SYSBUS<br>
+=C2=A0 =C2=A0 select SD<br>
<br></blockquote><div>Thanks, I&#39;ll add this fix.</div><div><br></div><d=
iv>Regards,</div><div>Niek<br></div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
=C2=A0 config RASPI<br>
=C2=A0 =C2=A0 =C2=A0 bool<br>
---<br>
<br>
</blockquote></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr" class=3D"g=
mail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><br></div></div></=
div></div>

--000000000000cb9547059d9eb341--

