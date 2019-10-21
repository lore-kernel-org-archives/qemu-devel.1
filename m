Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 00:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A9120663
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 00:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlyOPFM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A9120663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMLzh-00047h-6y
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 20:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iMLyx-0003hv-Ld
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 20:55:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iMLyw-000358-BB
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 20:55:35 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46205)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iMLyw-00034m-4J
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 20:55:34 -0400
Received: by mail-oi1-x244.google.com with SMTP id k25so9589838oiw.13
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2019 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Px+dFPcwELRuXJvQgwLp4nDQ4IO/i1z6c3QaH8sRTMk=;
 b=IlyOPFM+cffb/t4/WyKQo+ToXKvEs61aANkYZ6FJB1TBiQBZQIbGPRyHOke7tW9NAE
 j59xhPjvSiprIkl0tNATiDuUTy9oFcgwNV/GzKYCVunV46ZQ5OrWQfj/mpBfrBfbPppj
 rp3gS2jOLILeizXDlhc+m9RkOMvRn/X64LDPkc4S5k2W9YHIGg7UqwZo87hqYvN+RT9s
 VUB3IicIuRbpn0Xj+6mBGKCVqTbGC3TeYW+tmg6b1YtQ64ra5E4PpHpKFHwjYmK1CcMO
 DBrxAS+9/fOUjM3xxLYdgEv+7d9g4Uj7KHIwZ4ncdfaL2fEV8do4WCVbH7gwVIr8gMDV
 4Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Px+dFPcwELRuXJvQgwLp4nDQ4IO/i1z6c3QaH8sRTMk=;
 b=BJ8qlDJ9Y766mYEN8Po+v9m3G9gz20c0gJWDy16PpFu3nopoHOUY/A51poXNaknPLa
 U9N7HNDmY/Gw514j4zUWZTNcmqkc0jtNEAeyrikRW5jl2NMxicFe5MOWviscF4Wm5Fxj
 HvrpAUjIGIFah1fpTewYWZ9mhp37cGng0/t31SiWvjbSAbd29F+3MYgpYJY/L4sAPyeK
 S9x+C7DeFL36NilvG1FW0nQEbLe7s2ylNElakUj15wtTePMz2R1lCXONe/Q+Foq7LHM+
 qkxwWfu0vCM2r7cicYRfc7dSYTTo+peOWCf40Ci3hPX0apz0DCmbb3bhmvug3LAZYfXZ
 gnqg==
X-Gm-Message-State: APjAAAVUcyg5ThjnM0Nn/JqRDae/blFI6DTQkVe3tTlHryVXnDji1mj7
 wfLKNFC/Ci9qOxU6kGro/wYvSRQOa2saBdyNIrg=
X-Google-Smtp-Source: APXvYqzCXkWP7wOeHO66a0D3ZD2TyEEIN4dX82WdcLESzy5DfLyI5AVxJvb0zf8PQaqGqHI5yAd7wFS3j47uVIBWseQ=
X-Received: by 2002:aca:280e:: with SMTP id 14mr16953796oix.129.1571619333032; 
 Sun, 20 Oct 2019 17:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018134754.16362-1-philmd@redhat.com>
 <20191018134754.16362-2-philmd@redhat.com>
In-Reply-To: <20191018134754.16362-2-philmd@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 21 Oct 2019 08:54:57 +0800
Message-ID: <CAKXe6S+hmwVbszWT4ALmh+TnKZ=0hPLQbT+hHiUEG-r8EZM1Nw@mail.gmail.com>
Subject: Re: [PATCH v2 01/20] MAINTAINERS: Keep PIIX4 South Bridge separate
 from PC Chipsets
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000114f4e05956124e5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000114f4e05956124e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2019=E5=B9=B410=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=
=93=EF=BC=9A

> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
> The PIIX4 Southbridge is not used by the PC machine,
> but by the Malta board (MIPS). Add a new section to
> keep it covered.
>
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

Reviewed-by: Li Qiang <liq3ea@163.com>


> ---
>  MAINTAINERS | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fe4dc51b08..c9f625fc2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1230,7 +1230,6 @@ F: hw/pci-host/q35.c
>  F: hw/pci-host/pam.c
>  F: include/hw/pci-host/q35.h
>  F: include/hw/pci-host/pam.h
> -F: hw/isa/piix4.c
>  F: hw/isa/lpc_ich9.c
>  F: hw/i2c/smbus_ich9.c
>  F: hw/acpi/piix4.c
> @@ -1716,6 +1715,12 @@ F: hw/display/edid*
>  F: include/hw/display/edid.h
>  F: qemu-edid.c
>
> +PIIX4 South Bridge (i82371AB)
> +M: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> +S: Maintained
> +F: hw/isa/piix4.c
> +
>  Firmware configuration (fw_cfg)
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  R: Laszlo Ersek <lersek@redhat.com>
> --
> 2.21.0
>
>
>

--000000000000114f4e05956124e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2019=E5=
=B9=B410=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=889:50=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">From: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.o=
rg" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
<br>
The PIIX4 Southbridge is not used by the PC machine,<br>
but by the Malta board (MIPS). Add a new section to<br>
keep it covered.<br>
<br>
Suggested-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com" targ=
et=3D"_blank">mst@redhat.com</a>&gt;<br>
Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp.c=
om" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsa=
t.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br></blockquote><div><br><=
/div><div>Reviewed-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com">liq3e=
a@163.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
---<br>
=C2=A0MAINTAINERS | 7 ++++++-<br>
=C2=A01 file changed, 6 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index fe4dc51b08..c9f625fc2e 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1230,7 +1230,6 @@ F: hw/pci-host/q35.c<br>
=C2=A0F: hw/pci-host/pam.c<br>
=C2=A0F: include/hw/pci-host/q35.h<br>
=C2=A0F: include/hw/pci-host/pam.h<br>
-F: hw/isa/piix4.c<br>
=C2=A0F: hw/isa/lpc_ich9.c<br>
=C2=A0F: hw/i2c/smbus_ich9.c<br>
=C2=A0F: hw/acpi/piix4.c<br>
@@ -1716,6 +1715,12 @@ F: hw/display/edid*<br>
=C2=A0F: include/hw/display/edid.h<br>
=C2=A0F: qemu-edid.c<br>
<br>
+PIIX4 South Bridge (i82371AB)<br>
+M: Herv=C3=A9 Poussineau &lt;<a href=3D"mailto:hpoussin@reactos.org" targe=
t=3D"_blank">hpoussin@reactos.org</a>&gt;<br>
+M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" targ=
et=3D"_blank">f4bug@amsat.org</a>&gt;<br>
+S: Maintained<br>
+F: hw/isa/piix4.c<br>
+<br>
=C2=A0Firmware configuration (fw_cfg)<br>
=C2=A0M: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.co=
m" target=3D"_blank">philmd@redhat.com</a>&gt;<br>
=C2=A0R: Laszlo Ersek &lt;<a href=3D"mailto:lersek@redhat.com" target=3D"_b=
lank">lersek@redhat.com</a>&gt;<br>
-- <br>
2.21.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000114f4e05956124e5--

