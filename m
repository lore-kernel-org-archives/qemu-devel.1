Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA64C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D22206D3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 08:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1bnk1+Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D22206D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijJW7-0004c0-Uc
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 03:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJVU-0004Cb-D5
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:56:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1ijJVT-0007a4-8i
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:56:04 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40237)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1ijJVT-0007Wf-1r
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 03:56:03 -0500
Received: by mail-ot1-x344.google.com with SMTP id w21so13484971otj.7
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 00:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=0pZWmTrzRkYhemir2xCREJGbM7fh5wdv6cE9Kp9V+XM=;
 b=P1bnk1+YGYkWsSHE9lkq6L9SFR0vhOb48pPLL8KVQ/fsXdkPR5iX0Xavl7pfUP/NOK
 sUNiePQtNgyOtrU/kG0Uq9VSEo2AFSBO8aTI3WJdEucCgUqw5R/UBeu0oscHqTySTFUF
 x6sre1W4UtYaDwEAssJbe0sIYOzOT6Vit/87O+koIPVjQ8YSaho7wl2N0gQKX0yaIZx3
 T9jvcDzI/BZk/zIAXt0rHZciwJZmIfUNNoh9m0attqF1BTvzVGXS+L022LETfsypV8HT
 X/b4pkQesijaGLo/G6n7rpa1eOsCpeAXmsT7GKuSxgZGg1kND00AgA3rpXBmVJsc317n
 790w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=0pZWmTrzRkYhemir2xCREJGbM7fh5wdv6cE9Kp9V+XM=;
 b=LckFvLUb5U9oDLBedZOUhHhayq9IarETzTi1s2ESRLNFTbjeEWlnldhRiVl9o5pRMW
 vkVgJWtR+bfx3CC/g1iMVWpa/JYiHZkwvtowtcJHKTu6I2XbJGf5ej+ofv1K0JGeB1Ue
 lD3mPf3xnIG0N6NrQ6o6+CxZ33yEfljxHUqWGErWptfOorn+RNy4OQA003UlKRTO0dO9
 KflDhoDt/Ej1H3wmFpltMRpHaXAY5B669VL38OTGapZvpzBwIYitX42Yc/r6VsmelJ9i
 0FGb6CBYOkR2uDCMiZ3h3I4O02p+wNkDqbBzR291HQ5KBEMXekMuOY8Gc5QA82nyrFeq
 gZEQ==
X-Gm-Message-State: APjAAAVN72VpK07VpXyKoYJbcQzpdqQJ6QW1DQ1LwwjBbg782yTfmspW
 xaqCo6gEt1CyvdIXLtrKkYgwhEnUTFPkjXltysg=
X-Google-Smtp-Source: APXvYqwsLLBaHYbWKTPr2+Bng0HOG6I6zsqkkNO29w5trUbQXt3na3B1TI0utC8zKm2HyMOUmpVu8uZLrk1qAQ5/7rc=
X-Received: by 2002:a9d:4c94:: with SMTP id m20mr27265672otf.341.1577091362322; 
 Mon, 23 Dec 2019 00:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:d21:0:0:0:0:0 with HTTP;
 Mon, 23 Dec 2019 00:56:01 -0800 (PST)
In-Reply-To: <20191218210329.1960-23-mrolnik@gmail.com>
References: <20191218210329.1960-1-mrolnik@gmail.com>
 <20191218210329.1960-23-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 23 Dec 2019 09:56:01 +0100
Message-ID: <CAL1e-=ip9gDy2VjJBAmTfaWixkvMNCzB=wNF53gvxNBxnM+1Mw@mail.gmail.com>
Subject: Re: [PATCH v39 22/22] target/avr: Update MAINTAINERS file
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006dfbf3059a5b32a0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 "me@xcancerberox.com.ar" <me@xcancerberox.com.ar>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006dfbf3059a5b32a0
Content-Type: text/plain; charset="UTF-8"

On Wednesday, December 18, 2019, Michael Rolnik <mrolnik@gmail.com> wrote:

> Include AVR maintaners in MAINTAINERS file
>
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> ---
>  MAINTAINERS | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 740401bcbb..9ed886106a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -163,6 +163,27 @@ S: Maintained
>  F: hw/arm/smmu*
>  F: include/hw/arm/smmu*
>
> +AVR TCG CPUs
> +M: Michael Rolnik <mrolnik@gmail.com>
> +R: Sarah Harris <S.E.Harris@kent.ac.uk>
> +S: Maintained
> +F: target/avr/
> +F: tests/acceptance/machine_avr6.py
> +F: default-configs/avr-softmmu.mak
> +F: gdb-xml/avr-cpu.xml
> +
> +AVR Machines
> +M: Michael Rolnik <mrolnik@gmail.com>
> +R: Sarah Harris <S.E.Harris@kent.ac.uk>
> +S: Maintained
> +F: hw/avr/
> +F: hw/char/avr_usart.c
> +F: include/hw/char/avr_usart.h
> +F: hw/timer/avr_timer16.c
> +F: include/hw/timer/avr_timer16.h
> +F: hw/misc/avr_mask.c
> +F: include/hw/misc/avr_mask.h
> +


This second section "AVR Machines" is in the wrong place. (Philippe already
brought this to your attention, but it looks you did not understand his
point.) Please move this section further down the MAINTAINERS file, after
"Alpha machines" and "Arm machines". Also, header file and source files are
in the wrong order in your list. Headrrs should always preceede source files

Yours,
Aleksandar




>  CRIS TCG CPUs
>  M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>  S: Maintained
> --
> 2.17.2 (Apple Git-113)
>
>

--0000000000006dfbf3059a5b32a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Wednesday, December 18, 2019, Michael Rolnik &lt;<a href=3D"mail=
to:mrolnik@gmail.com">mrolnik@gmail.com</a>&gt; wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Include AVR maintaners in MAINTAINERS file<br>
<br>
Signed-off-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrol=
nik@gmail.com</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 21 +++++++++++++++++++++<br>
=C2=A01 file changed, 21 insertions(+)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 740401bcbb..9ed886106a 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -163,6 +163,27 @@ S: Maintained<br>
=C2=A0F: hw/arm/smmu*<br>
=C2=A0F: include/hw/arm/smmu*<br>
<br>
+AVR TCG CPUs<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.c=
om</a>&gt;<br>
+R: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.E.Harris@ke=
nt.ac.uk</a>&gt;<br>
+S: Maintained<br>
+F: target/avr/<br>
+F: tests/acceptance/machine_avr6.<wbr>py<br>
+F: default-configs/avr-softmmu.<wbr>mak<br>
+F: gdb-xml/avr-cpu.xml<br>
+<br>
+AVR Machines<br>
+M: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com">mrolnik@gmail.c=
om</a>&gt;<br>
+R: Sarah Harris &lt;<a href=3D"mailto:S.E.Harris@kent.ac.uk">S.E.Harris@ke=
nt.ac.uk</a>&gt;<br>
+S: Maintained<br>
+F: hw/avr/<br>
+F: hw/char/avr_usart.c<br>
+F: include/hw/char/avr_usart.h<br>
+F: hw/timer/avr_timer16.c<br>
+F: include/hw/timer/avr_timer16.h<br>
+F: hw/misc/avr_mask.c<br>
+F: include/hw/misc/avr_mask.h<br>
+</blockquote><div><br></div><div>This second section &quot;AVR Machines&qu=
ot; is in the wrong place. (Philippe already brought this to your attention=
, but it looks you did not understand his point.) Please move this section =
further down the MAINTAINERS file, after &quot;Alpha machines&quot; and &qu=
ot;Arm machines&quot;. Also, header file and source files are in the wrong =
order in your list. Headrrs should always preceede source files</div><div><=
br></div><div>Yours,</div><div>Aleksandar</div><div><br></div><div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0CRIS TCG CPUs<br>
=C2=A0M: Edgar E. Iglesias &lt;<a href=3D"mailto:edgar.iglesias@gmail.com">=
edgar.iglesias@gmail.com</a>&gt;<br>
=C2=A0S: Maintained<br>
-- <br>
2.17.2 (Apple Git-113)<br>
<br>
</blockquote>

--0000000000006dfbf3059a5b32a0--

