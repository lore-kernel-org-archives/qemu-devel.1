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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2528CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E06CB20663
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugeotnce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E06CB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaYr-0002mV-4w
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaXr-0001sA-Fp; Mon, 06 Jul 2020 19:29:07 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:41131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaXp-0006Qh-Ca; Mon, 06 Jul 2020 19:29:07 -0400
Received: by mail-il1-x143.google.com with SMTP id q3so23725249ilt.8;
 Mon, 06 Jul 2020 16:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EqpTLnds0cQjQhPTtDXOEbWvKqfHq/uTNO2RA9Yz7QI=;
 b=UgeotncesG4zQVHNWYePkXPakT+0WIklkaH3zTOngjzTCBnpbdZIBJTHbfi0UmEFS+
 Vcm5+RldKaAmXqg95SgC2MIyumI1qeN9VPKNXGncr1QeMzipgKo4DSt+g3fZ8VHzMSef
 /64emOo0HYBwwnK3UZvcG7ZP73fb9yjItIWt4jFbJG9YOYm8UaCknaRZcVr2FyAL2pFr
 0UeJvx1+inWoRFPAziZTAvU3SCT7J1FIW5pB2PApAWcHLv6eK5KGkNJwOnXx0rqFxs+h
 JqwOFDCq92Wzf+D0PGoqUxr9dFtcFKHAbMbdUPdddOWgcCZRQ8wbcef5+FD8tg64+JhH
 BNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EqpTLnds0cQjQhPTtDXOEbWvKqfHq/uTNO2RA9Yz7QI=;
 b=HQDo6EFO5VF0VcC0UgUobKYZsmzh0nMx4wOnpF7RG3ml3ZShsk4+lt7tv849PSRC81
 W0Qd5KxP5HVvS4nYyXAjTYO0WTTYd4e6tNiksVK5qEq1w7WjTL/EQ9ir1EHKYJSpN84r
 pSgajkDe2CFuTLRqi7JexfSGA9Ti2RZRC/UB0fp+W0uQAvfSYRFFKNFCuFKuqiiD/hl4
 qsSReTKkz8ZQu25J5kzNOD3IqYgR6v142urqs9ZLvhKIM/wEQsqYft2oNTj02uoLc44z
 TDH1Xof91TfSIwuvng/en5z6jPs/ra6qaQ6iWftxWc/qyVrkyketAPKyTwWmCKxbb7ug
 OSog==
X-Gm-Message-State: AOAM533Zree3ZvXGtL+BG36ee7HL04o9y5hpLq8DQ48Ke6p6xuDK2hqg
 J0AQNVT2G/KfMSsBixH0iXLxbim982r5USJI+G8=
X-Google-Smtp-Source: ABdhPJw3JUW4GbL95AweZL605ZuGn+6rCK3ngUlA6e50fJsVbbkH5ckFabJvO/a6lXcUvM+d3wfLRaCN/a9ELGQNiVI=
X-Received: by 2002:a92:58d1:: with SMTP id z78mr32232484ilf.276.1594078143637; 
 Mon, 06 Jul 2020 16:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-7-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-7-f4bug@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 6 Jul 2020 16:28:37 -0700
Message-ID: <CADBGO78wa9Rth0=cszD6ZNo_y5ZtLQRyjvZLr-D45tuoEe_A8g@mail.gmail.com>
Subject: Re: [PATCH 06/26] hw/usb/hcd-dwc2: Remove unnecessary includes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000007eeff905a9ce3d8d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=pauldzim@gmail.com; helo=mail-il1-x143.google.com
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

--0000000000007eeff905a9ce3d8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> "qemu/error-report.h" and "qemu/main-loop.h" are not used.
> Remove them.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/usb/hcd-dwc2.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index 72cbd051f3..590e75b455 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -39,8 +39,6 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "qemu/log.h"
> -#include "qemu/error-report.h"
> -#include "qemu/main-loop.h"
>  #include "hw/qdev-properties.h"
>
>  #define USB_HZ_FS       12000000
> --
> 2.21.3
>
>
Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>

--0000000000007eeff905a9ce3d8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&quot;q=
emu/error-report.h&quot; and &quot;qemu/main-loop.h&quot; are not used.<br>
Remove them.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-dwc2.c | 2 --<br>
=C2=A01 file changed, 2 deletions(-)<br>
<br>
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>
index 72cbd051f3..590e75b455 100644<br>
--- a/hw/usb/hcd-dwc2.c<br>
+++ b/hw/usb/hcd-dwc2.c<br>
@@ -39,8 +39,6 @@<br>
=C2=A0#include &quot;migration/vmstate.h&quot;<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
-#include &quot;qemu/error-report.h&quot;<br>
-#include &quot;qemu/main-loop.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
<br>
=C2=A0#define USB_HZ_FS=C2=A0 =C2=A0 =C2=A0 =C2=A012000000<br>
-- <br>
2.21.3<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">Re=
viewed-by:</span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=
=A0Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldzim@gmail.=
com</a>&gt;</span><span style=3D"font-family:Arial,Helvetica,sans-serif"></=
span></div><div class=3D"gmail_default" style=3D"font-family:monospace"></d=
iv></div></div>

--0000000000007eeff905a9ce3d8d--

