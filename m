Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E8DECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:07:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C40B20640
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 16:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRnSB184"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C40B20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL8Ip-0000HE-Bo
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 12:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Vs-0003qD-Nb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:16:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iL7Vn-00056Y-Mq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:16:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34228)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iL7Vn-00056P-ID
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 11:16:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id 83so2493437oii.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=AyW8NM6SJoGlUUn/caesoONpoZFYdqbED9wtAipUY7Q=;
 b=LRnSB184BsuH9LrV/bwFshWgP2XeAAUH44yEASK7+n3o/THTEY8W/7incOAx2V/GjU
 4qAt8d6oUwfPefR0gITGLKjTUnalbjKED/56rYlVo6ycBjq6hjHhUa/goMJotZYS5+aj
 5ro9nrjVMhogoJRPwY7aldvdb3Urf6a/FhANETyOinuxiHUWPyVzMVrlr6ugVGvlmee+
 F+3hNk3jPQwtGPVYnLIa2bxL+0wUglY3oCxCrR0qpL6NLAJLK4ZR6m1gKYdnA7t33j/Q
 HFwx8SfyzL+uZkBRotKzVJm+frxNfdbPd25QlLy0q0Enf1ELYAe7aLyOeilLrwrRlJPB
 mIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=AyW8NM6SJoGlUUn/caesoONpoZFYdqbED9wtAipUY7Q=;
 b=DWKvHhM/G78+Okj0n8AS9j1ECSNjcKubfWn+1a5EVyXam9EFZ8MTMewU6q7UzfJll1
 eTZ1QrGOkZcSRQqDMR7bQl1ffpcwKzRtq2kG92YEbNweolwLfsx6bjJS7ZHyl9ARg5QS
 dEEddmOAXvpjzq2AdjuYPjQ/5coQ8KKlNhfuTtDy+ks7UFj0Hkoy6IdJW2Y3F+u6h/4r
 yNvEwwnHK4ZHBaoVzpGtkiCGcw9jgYItxMhm3eekiQTq3mL9Ei39L40RCqSEE/X78tmN
 oONjt+GOpn8dhfVr7yUeciLbj6vNtEhC9/BHQU6l+SDIf/euCvrd2P60X2g+L183QeMy
 fOXg==
X-Gm-Message-State: APjAAAVMPFyivYt1B/ZzKsbRtpDpMafJ0ZEcBnhr712cfSTXBojY1nhs
 W1FF4cUeHmIq+dRTt2I0ufztfK9dcm6URMKLIq4=
X-Google-Smtp-Source: APXvYqw07qJjPokcVhwk/D87QvKmD4UjYp48DXnEdjIzgiiW8ZjoAHftG/wPAwoPFRE9z8BKjwAVnW0sE6vYehgJDDk=
X-Received: by 2002:aca:4e56:: with SMTP id c83mr3701878oib.53.1571325382899; 
 Thu, 17 Oct 2019 08:16:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Thu, 17 Oct 2019 08:16:22
 -0700 (PDT)
In-Reply-To: <20191015162705.28087-22-philmd@redhat.com>
References: <20191015162705.28087-1-philmd@redhat.com>
 <20191015162705.28087-22-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 17 Oct 2019 17:16:22 +0200
Message-ID: <CAL1e-=hLUDDqFiV8W1f2PFGYJMomvmZUXmjA55X7WEEYMykjHQ@mail.gmail.com>
Subject: Re: [PATCH 21/32] hw/i386/pc: Reduce gsi_handler scope
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000463b3505951cb36b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000463b3505951cb36b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m>
wrote:

> pc_gsi_create() is the single function that uses gsi_handler.
> Make it a static variable.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/i386/pc.c         | 2 +-
>  include/hw/i386/pc.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index a7597c6c44..59de0c8a1f 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {
>  };
>  const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
>
> -void gsi_handler(void *opaque, int n, int level)
> +static void gsi_handler(void *opaque, int n, int level)
>  {
>      GSIState *s =3D opaque;
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index d0c6b9d469..75b44e156c 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -172,8 +172,6 @@ typedef struct GSIState {
>      qemu_irq ioapic_irq[IOAPIC_NUM_PINS];
>  } GSIState;
>
> -void gsi_handler(void *opaque, int n, int level);
> -
>  GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);
>
>
Philippe, this 2-line deletion seems not to belong to this patch. If true,
please place it in another or a separate patch.

A.



>  /* vmport.c */
> --
> 2.21.0
>
>
>

--000000000000463b3505951cb36b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Tuesday, October 15, 2019, Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">pc_gsi_create() is the single function that uses gs=
i_handler.<br>
Make it a static variable.<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@red=
hat.com">philmd@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/i386/pc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
=C2=A0include/hw/i386/pc.h | 2 --<br>
=C2=A02 files changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/hw/i386/pc.c b/hw/i386/pc.c<br>
index a7597c6c44..59de0c8a1f 100644<br>
--- a/hw/i386/pc.c<br>
+++ b/hw/i386/pc.c<br>
@@ -346,7 +346,7 @@ GlobalProperty pc_compat_1_4[] =3D {<br>
=C2=A0};<br>
=C2=A0const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);<br>
<br>
-void gsi_handler(void *opaque, int n, int level)<br>
+static void gsi_handler(void *opaque, int n, int level)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0GSIState *s =3D opaque;<br>
<br>
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h<br>
index d0c6b9d469..75b44e156c 100644<br>
--- a/include/hw/i386/pc.h<br>
+++ b/include/hw/i386/pc.h<br>
@@ -172,8 +172,6 @@ typedef struct GSIState {<br>
=C2=A0 =C2=A0 =C2=A0qemu_irq ioapic_irq[IOAPIC_NUM_PINS];<br>
=C2=A0} GSIState;<br>
<br>
-void gsi_handler(void *opaque, int n, int level);<br>
-<br>
=C2=A0GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled);<br>
<br></blockquote><div><br></div><div>Philippe, this 2-line deletion seems n=
ot to belong to this patch. If true, please place it in another or a separa=
te patch.</div><div><br></div><div>A.</div><div><br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
=C2=A0/* vmport.c */<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote>

--000000000000463b3505951cb36b--

