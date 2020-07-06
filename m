Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF39C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F0F20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV175Ip4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F0F20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaXf-0001Bx-Qt
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaWy-000079-MG; Mon, 06 Jul 2020 19:28:12 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:42438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaWw-0006Ft-Rs; Mon, 06 Jul 2020 19:28:12 -0400
Received: by mail-io1-xd41.google.com with SMTP id c16so41224221ioi.9;
 Mon, 06 Jul 2020 16:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o2au+JJF3iFRx8/wMwMY9hqc8NDSgxZJ6W8bmJa6B3w=;
 b=UV175Ip46nlRSvIuHO9aabEhDAhS8PyIj2iRmpR6xqQ+kARmhfpHBtcbb4upNUIVED
 w5COe3pxivzOL5jcL2J6NewBUCoVXUl+Yk7+OvfUBSS+NnrArY64Q0rk8TgKL+7nngM/
 93LBL/adIxwmHtjZwApU05ehx7cWUU90hu9tzxmD1gF9QVNRPi7ljqae5aSh1pybr1qu
 HS9EBrcs8sD4WJ2XiM68eZqI8djubBpP1SsWGRTaNd///6tg//TxTkt6Hhexrze39Dcu
 qHO+nTI/RS9987CX3EVmGPh1Ealpci/8M576p/Lx0DKzavHAfVxg9CsNV43GFb/la/sX
 QYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o2au+JJF3iFRx8/wMwMY9hqc8NDSgxZJ6W8bmJa6B3w=;
 b=o92brC7KwOWaKihjg/aG9sDHyOdi9EZqe0apfwkGPz1/fVRCZ5fwdrMkE1IL5lMzyx
 QYLdz8OX4whAuXRdT+2oy2wgV8f4h//iHybng1V5rYfz87R0BFiHx2FRpf3FOE6rrfTo
 w+Br3h+dfoYCCY0LLkSg0nLlqTgW/8VCY3SVRdnqRJA8wFOZgG30W/Ogo28PZsznZsOj
 EXBpUgQG7vvqAPIzVIwuO1wbsDlOVXEJ6Bb9/psd/n3UaW9FoJXZf5+e8Lp5jsyKmlOm
 n4P79zQ5A1qglJEjIltDsFIx5JUhvUN7Tu3P2PKHw3eNr6ddmoVuM7f6DYo3++xHMqPg
 DtPg==
X-Gm-Message-State: AOAM533oFy3uXvR+ix4Jd3v5QjU90GWAt9bPObhkW5oxbksjt/PBqdED
 Mju4OPeKTiMnHILi9MMUShLjQE66R+Q5eOEd5Q0=
X-Google-Smtp-Source: ABdhPJxiX7qsyPhPsM9b6aXZ6jrmsQJOHwK5JNaERwfHbIHo+HluncpsULlPeV6Fxuk7XqAu85zdwY+jX06UBRQ27X8=
X-Received: by 2002:a02:ac8e:: with SMTP id x14mr55270700jan.57.1594078088926; 
 Mon, 06 Jul 2020 16:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-8-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-8-f4bug@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 6 Jul 2020 16:27:42 -0700
Message-ID: <CADBGO79yDBVagNRfvKLG7LwVUX_4DK7v6DA5p1CEHboP3wOH7Q@mail.gmail.com>
Subject: Re: [PATCH 07/26] hw/usb/hcd-dwc2: Restrict some headers to source
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000003c1f1505a9ce3ab0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Durrant <paul@xen.org>, Magnus Damm <magnus.damm@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Leif Lindholm <leif@nuviainc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000003c1f1505a9ce3ab0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> The header "usb/hcd-dwc2.h" doesn't need to include "qemu/timer.h",
> "sysemu/dma.h", "hw/irq.h" (the types required are forward declared).
> Include them in the source file which is the only one requiring the
> function declarations.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/usb/hcd-dwc2.h | 3 ---
>  hw/usb/hcd-dwc2.c | 3 +++
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h
> index 4ba809a07b..2adf0f53c7 100644
> --- a/hw/usb/hcd-dwc2.h
> +++ b/hw/usb/hcd-dwc2.h
> @@ -19,11 +19,8 @@
>  #ifndef HW_USB_DWC2_H
>  #define HW_USB_DWC2_H
>
> -#include "qemu/timer.h"
> -#include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "hw/usb.h"
> -#include "sysemu/dma.h"
>
>  #define DWC2_MMIO_SIZE      0x11000
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 590e75b455..ccf05d0823 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -36,8 +36,11 @@
>  #include "qapi/error.h"
>  #include "hw/usb/dwc2-regs.h"
>  #include "hw/usb/hcd-dwc2.h"
> +#include "hw/irq.h"
> +#include "sysemu/dma.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
> +#include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/qdev-properties.h"
>
> --
> 2.21.3
>
>
Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>

--0000000000003c1f1505a9ce3ab0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The hea=
der &quot;usb/hcd-dwc2.h&quot; doesn&#39;t need to include &quot;qemu/timer=
.h&quot;,<br>
&quot;sysemu/dma.h&quot;, &quot;hw/irq.h&quot; (the types required are forw=
ard declared).<br>
Include them in the source file which is the only one requiring the<br>
function declarations.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-dwc2.h | 3 ---<br>
=C2=A0hw/usb/hcd-dwc2.c | 3 +++<br>
=C2=A02 files changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/usb/hcd-dwc2.h b/hw/usb/hcd-dwc2.h<br>
index 4ba809a07b..2adf0f53c7 100644<br>
--- a/hw/usb/hcd-dwc2.h<br>
+++ b/hw/usb/hcd-dwc2.h<br>
@@ -19,11 +19,8 @@<br>
=C2=A0#ifndef HW_USB_DWC2_H<br>
=C2=A0#define HW_USB_DWC2_H<br>
<br>
-#include &quot;qemu/timer.h&quot;<br>
-#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;hw/sysbus.h&quot;<br>
=C2=A0#include &quot;hw/usb.h&quot;<br>
-#include &quot;sysemu/dma.h&quot;<br>
<br>
=C2=A0#define DWC2_MMIO_SIZE=C2=A0 =C2=A0 =C2=A0 0x11000<br>
<br>
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>
index 590e75b455..ccf05d0823 100644<br>
--- a/hw/usb/hcd-dwc2.c<br>
+++ b/hw/usb/hcd-dwc2.c<br>
@@ -36,8 +36,11 @@<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;hw/usb/dwc2-regs.h&quot;<br>
=C2=A0#include &quot;hw/usb/hcd-dwc2.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;sysemu/dma.h&quot;<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
+#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
<br>
-- <br>
2.21.3<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">Re=
viewed-by:</span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=
=A0Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldzim@gmail.=
com</a>&gt;</span></div></div></div>

--0000000000003c1f1505a9ce3ab0--

