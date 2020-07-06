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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9677DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF61206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mgg1+R1w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF61206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsaZR-0003tN-LP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 19:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaYd-0002lY-EV; Mon, 06 Jul 2020 19:29:55 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33034)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1jsaYb-0006VX-On; Mon, 06 Jul 2020 19:29:55 -0400
Received: by mail-io1-xd42.google.com with SMTP id i25so41344312iog.0;
 Mon, 06 Jul 2020 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=guo4Cz0saHkzfASqoW+5Vfcn07JMdPw0vLJcHYngdVg=;
 b=Mgg1+R1wgP3yxWPoxwWzVSxY2DBC9uea+PFILvRzMeodl7CDSW6RFuIaULNGjbl5Wm
 e+hCc1T3Xll8LfByGqK3TY3w+7eAb71d7Ae0R0447AX36sCNNoaUbvfaW3MjOyeRnMve
 s+nQuLbys2Cq6ZKBNVYoyxUZYEAcwfG4E1nUQkp22Dcn+sEZ6SgV+248afpNz2u0S6YB
 DeqGJkSGAO5axe7LmsN1L9ov27T4ZifdZ/+d5Qwvyv7PifaQb7LkaWs8K+/MJCfwnF2U
 OM/aWXU/Cp7UwxJaN304YU1X6zGqzj9Ed2BvtxVv3622J/wOVdGJLZ5TIYdbStGq2jRR
 0dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=guo4Cz0saHkzfASqoW+5Vfcn07JMdPw0vLJcHYngdVg=;
 b=ck5Gx3mnSh8ejGXXKb/ryETte7/RI85yONMnlHTb/wRWWvs2EV1Jh5mneCGSojAN+2
 EgYFpFaUUW1zb7NW4Lv+SbHw7GfFsInDYMmMnldjbru8Zfyh7KGZOOQWUYtGaZSGNK5/
 YGMP5tNdfssixcy/F0JNhFqZEtQemZiSTmpS5JSkWHoBpcy7NHdQFyUvIPzL+ntsLPV+
 cFGZGDIMuUXtHt8fxYgT3M2HVkkIe6q6dBt8FfOCfhhmZqwfIDzYlFa51x629PrBnSvY
 qcKgRoCDYIl1vs8WBgcgfmcWFU06wRzwjNEsGdV+u61JmEZ5cLwCqme88iyKN82/hKrU
 ZPLg==
X-Gm-Message-State: AOAM532025LKFz2h97Nc1aIj8R7sgdEnnUyPT7rYNtKkiIG12Ofu+kyv
 HaKzrw0hjJPWbgdt2ZDW3pbL6hJrgS4+Ta53vLk=
X-Google-Smtp-Source: ABdhPJxccJUFvrRtMWh3+owZpgS6w9Fdz4b7CnGGaHawyuF5NA7yGHARPV7RXQDl8sKlO2zqMYBeBAVye8DBVl2kztM=
X-Received: by 2002:a5e:dc03:: with SMTP id b3mr26345208iok.97.1594078191753; 
 Mon, 06 Jul 2020 16:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200704144943.18292-1-f4bug@amsat.org>
 <20200704144943.18292-9-f4bug@amsat.org>
In-Reply-To: <20200704144943.18292-9-f4bug@amsat.org>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 6 Jul 2020 16:29:25 -0700
Message-ID: <CADBGO7__svJLvtHjyrn_BhqTnWxJWLbv0i0oK4rjmFLiFb82Aw@mail.gmail.com>
Subject: Re: [PATCH 08/26] hw/usb/hcd-dwc2: Restrict 'dwc2-regs.h' scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="0000000000005d234a05a9ce40b4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd42.google.com
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

--0000000000005d234a05a9ce40b4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
>
wrote:

> We only use these register definitions in files under the
> hw/usb/ directory. Keep that header local by moving it there.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  {include/hw =3D> hw}/usb/dwc2-regs.h | 0
>  hw/usb/hcd-dwc2.c                  | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename {include/hw =3D> hw}/usb/dwc2-regs.h (100%)
>
> diff --git a/include/hw/usb/dwc2-regs.h b/hw/usb/dwc2-regs.h
> similarity index 100%
> rename from include/hw/usb/dwc2-regs.h
> rename to hw/usb/dwc2-regs.h
> diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c
> index ccf05d0823..252b60ef65 100644
> --- a/hw/usb/hcd-dwc2.c
> +++ b/hw/usb/hcd-dwc2.c
> @@ -34,7 +34,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> -#include "hw/usb/dwc2-regs.h"
>  #include "hw/usb/hcd-dwc2.h"
>  #include "hw/irq.h"
>  #include "sysemu/dma.h"
> @@ -43,6 +42,7 @@
>  #include "qemu/timer.h"
>  #include "qemu/log.h"
>  #include "hw/qdev-properties.h"
> +#include "dwc2-regs.h"
>
>  #define USB_HZ_FS       12000000
>  #define USB_HZ_HS       96000000
> --
> 2.21.3
>
>
Reviewed-by: Paul Zimmerman <pauldzim@gmail.com>

--0000000000005d234a05a9ce40b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Jul 4, 2020 at 7:50 AM Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org">f4bug@amsat.org</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We only=
 use these register definitions in files under the<br>
hw/usb/ directory. Keep that header local by moving it there.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0{include/hw =3D&gt; hw}/usb/dwc2-regs.h | 0<br>
=C2=A0hw/usb/hcd-dwc2.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 2 +-<br>
=C2=A02 files changed, 1 insertion(+), 1 deletion(-)<br>
=C2=A0rename {include/hw =3D&gt; hw}/usb/dwc2-regs.h (100%)<br>
<br>
diff --git a/include/hw/usb/dwc2-regs.h b/hw/usb/dwc2-regs.h<br>
similarity index 100%<br>
rename from include/hw/usb/dwc2-regs.h<br>
rename to hw/usb/dwc2-regs.h<br>
diff --git a/hw/usb/hcd-dwc2.c b/hw/usb/hcd-dwc2.c<br>
index ccf05d0823..252b60ef65 100644<br>
--- a/hw/usb/hcd-dwc2.c<br>
+++ b/hw/usb/hcd-dwc2.c<br>
@@ -34,7 +34,6 @@<br>
=C2=A0#include &quot;qemu/osdep.h&quot;<br>
=C2=A0#include &quot;qemu/units.h&quot;<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
-#include &quot;hw/usb/dwc2-regs.h&quot;<br>
=C2=A0#include &quot;hw/usb/hcd-dwc2.h&quot;<br>
=C2=A0#include &quot;hw/irq.h&quot;<br>
=C2=A0#include &quot;sysemu/dma.h&quot;<br>
@@ -43,6 +42,7 @@<br>
=C2=A0#include &quot;qemu/timer.h&quot;<br>
=C2=A0#include &quot;qemu/log.h&quot;<br>
=C2=A0#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;dwc2-regs.h&quot;<br>
<br>
=C2=A0#define USB_HZ_FS=C2=A0 =C2=A0 =C2=A0 =C2=A012000000<br>
=C2=A0#define USB_HZ_HS=C2=A0 =C2=A0 =C2=A0 =C2=A096000000<br>
-- <br>
2.21.3<br>
<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"font-=
family:monospace"><span style=3D"font-family:Arial,Helvetica,sans-serif">Re=
viewed-by:</span><span style=3D"font-family:Arial,Helvetica,sans-serif">=C2=
=A0Paul Zimmerman &lt;<a href=3D"mailto:pauldzim@gmail.com">pauldzim@gmail.=
com</a>&gt;</span><span style=3D"font-family:Arial,Helvetica,sans-serif"></=
span></div><div class=3D"gmail_default" style=3D"font-family:monospace"></d=
iv></div></div>

--0000000000005d234a05a9ce40b4--

