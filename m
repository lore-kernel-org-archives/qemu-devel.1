Return-Path: <SRS0=KEGy=6R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B8FC28CBC
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 21:12:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB325206F1
	for <qemu-devel@archiver.kernel.org>; Sun,  3 May 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enPEAXad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB325206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVLuU-00041P-1A
	for qemu-devel@archiver.kernel.org; Sun, 03 May 2020 17:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVLtL-0003HR-UU
 for qemu-devel@nongnu.org; Sun, 03 May 2020 17:11:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:37950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVLtK-0001cP-T4
 for qemu-devel@nongnu.org; Sun, 03 May 2020 17:11:15 -0400
Received: by mail-wr1-x42a.google.com with SMTP id x17so18555714wrt.5
 for <qemu-devel@nongnu.org>; Sun, 03 May 2020 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Cj720ZbvdepEPD/uHDc/3/BvE6+LPekWYR9Aj4UtKr4=;
 b=enPEAXadH5SDRe6x0yjDC0yAke3cpj3eLj8e4Lz6AiZCLFpSkj6GBw77u+KfAb4BT2
 KLASJM5l6GhbQsiqmKmnb+CKZ9Oimxa+dKeY0I3eJOl6XX7wpKvNcroUK32gT0ZD1dVY
 eimxczGofn28SyTuiz9FQpUBuZQhHgdrP9GQ3mMYOwIT6cvnh0XUJYGYH7Wdokns1C5P
 NTfhAtIeWIvuTXPJvo+l4RoBgMHs8abew+Dmh9irsE3dz4L2AU2awFgbtbhIFPHHSPRM
 U9N6kJ3HZ8m18FGrenkuDpDm/0RhWLpiiV3YbL/HTCK1V+YK0aEdbRvE53ooF+76Oenf
 KlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Cj720ZbvdepEPD/uHDc/3/BvE6+LPekWYR9Aj4UtKr4=;
 b=mMS0PWidmb17+YJdF1DeuzASjJa8yRapIUyrc6emRANgVWb7t/RHhyoZCWPC/BVQMl
 QB0yNiVUsArsLIQdJVIsCW31GkzA+sVXY8njPPPdeYmdl3N8uv7Z5whrNPlzP7pbgf8J
 Ao7j1j2Cz2U8AAyD4tkAchLT9VsUbnd+IN5Q7DGRWHyZFFJwjNWb4EOBj1kDxVXYggbh
 AWDXz/1LBf6uK6wO1F79fiT/kTv7FV/aqSKfHWsPO2QUzqpb9h02IwIEp3d7q2NJcbsr
 jbJVaD/q86aGLSr75NELEXWRanktqcA+KQjat9u0QtEUQvJAi0dR9ugwDId5iPUGTaXo
 lHkQ==
X-Gm-Message-State: AGi0Pua9+agO87mysNCKZrB8WuYQQuxKtchhpjrZr4zN+ltFzUE3yKS6
 j5QzbncKeREPZtPDIgXj+svGj/jMabFcPbmoAbc=
X-Google-Smtp-Source: APiQypJ0dELl8ATgMPpDn6GtPvGrVdcl16A0IBzU2tfNtsnfViS14OsWonhocksPdgtn5sJ2EwPhcS1q6Y8uKjbWlf8=
X-Received: by 2002:a5d:4443:: with SMTP id x3mr15186552wrr.162.1588540273355; 
 Sun, 03 May 2020 14:11:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Sun, 3 May 2020 14:11:13 -0700 (PDT)
In-Reply-To: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
References: <de5adcb9fd0dd607b98026f4bfb34205432b6002.camel@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 3 May 2020 23:11:13 +0200
Message-ID: <CAHiYmc6CdZh9dB2RzTbO4jcJLg7ynGpN1DDYEZvR1GEGek6S0Q@mail.gmail.com>
Subject: Re: target/mips: Enable Hardware page table walker and CMGCR features
 for P5600
To: "oliveriandrea@gmail.com" <oliveriandrea@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b46fbd05a4c4dad3"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: "aleksandar.rikalo@rt-rk.com" <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b46fbd05a4c4dad3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=83=D0=B1=D0=BE=D1=82=D0=B0, 25. =D0=B0=D0=BF=D1=80=D0=B8=D0=BB 20=
20., <oliveriandrea@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> Hi,
> I have discovered that MIPS hardware page table walker is not enabled
> for any CPU currently available. In this patch I have enable it (and
> also CMGCR feature) for P5600 which supports both but they are not
> enabled.
>
>
Andrea,

Just wanted to tell you that I didn't forget this patch, I was just swamped
with other tasks for last several weeks. I'll get back to you soon.

I appreciate your submitting this patch!

Aleksandar


> This is my first patch to QEMU, I hope it is well formatted and correct.
>
> Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>
> diff --git a/target/mips/translate_init.inc.c
> b/target/mips/translate_init.inc.c
> index 6d145a905a..482cfe2123 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -366,7 +366,7 @@ const mips_def_t mips_defs[] =3D
>      },
>      {
>          /* FIXME:
> -         * Config3: CMGCR, PW, VZ, CTXTC, CDMM, TL
> +         * Config3: VZ, CTXTC, CDMM, TL
>           * Config4: MMUExtDef
>           * Config5: MRP
>           * FIR(FCR0): Has2008
> @@ -380,10 +380,11 @@ const mips_def_t mips_defs[] =3D
>                         (2 << CP0C1_DS) | (4 << CP0C1_DL) | (3 <<
> CP0C1_DA) |
>                         (1 << CP0C1_PC) | (1 << CP0C1_FP),
>          .CP0_Config2 =3D MIPS_CONFIG2,
> -        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MS=
AP)
> |
> +        .CP0_Config3 =3D MIPS_CONFIG3 | (1U << CP0C3_M) |
> +                       (1 << CP0C3_CMGCR) | (1 << CP0C3_MSAP) |
>                         (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 <<
> CP0C3_SC) |
> -                       (1 << CP0C3_ULRI) | (1 << CP0C3_RXI) | (1 <<
> CP0C3_LPA) |
> -                       (1 << CP0C3_VInt),
> +                       (1 << CP0C3_PW) | (1 << CP0C3_ULRI) | (1 <<
> CP0C3_RXI) |
> +                       (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
>          .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE=
) |
>                         (0x1c << CP0C4_KScrExist),
>          .CP0_Config4_rw_bitmask =3D 0,
>
>

--000000000000b46fbd05a4c4dad3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=81=D1=83=D0=B1=D0=BE=D1=82=D0=B0, 25. =D0=B0=D0=BF=D1=80=D0=B8=
=D0=BB 2020.,  &lt;<a href=3D"mailto:oliveriandrea@gmail.com">oliveriandrea=
@gmail.com</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
I have discovered that MIPS hardware page table walker is not enabled<br>
for any CPU currently available. In this patch I have enable it (and<br>
also CMGCR feature) for P5600 which supports both but they are not<br>
enabled.<br>
<br></blockquote><div><br></div><div>Andrea,</div><div><br></div><div>Just =
wanted to tell you that I didn&#39;t forget this patch, I was just swamped =
with other tasks for last several weeks. I&#39;ll get back to you soon.</di=
v><div><br></div><div>I appreciate your submitting this patch!</div><div><b=
r></div><div>Aleksandar</div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
This is my first patch to QEMU, I hope it is well formatted and correct.<br=
>
<br>
Signed-off-by: Andrea Oliveri &lt;<a href=3D"mailto:oliveriandrea@gmail.com=
">oliveriandrea@gmail.com</a>&gt;<br>
diff --git a/target/mips/translate_init.<wbr>inc.c b/target/mips/translate_=
init.<wbr>inc.c<br>
index 6d145a905a..482cfe2123 100644<br>
--- a/target/mips/translate_init.<wbr>inc.c<br>
+++ b/target/mips/translate_init.<wbr>inc.c<br>
@@ -366,7 +366,7 @@ const mips_def_t mips_defs[] =3D<br>
=C2=A0 =C2=A0 =C2=A0},<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Config3: CMGCR, PW, VZ, CTXTC, CDMM, T=
L<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Config3: VZ, CTXTC, CDMM, TL<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Config4: MMUExtDef<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Config5: MRP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * FIR(FCR0): Has2008<br>
@@ -380,10 +380,11 @@ const mips_def_t mips_defs[] =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (2 &lt;&lt; CP0C1_DS) | (4 &lt;&lt; CP0C1_DL) | (3 &lt;&lt; CP0C=
1_DA) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; CP0C1_PC) | (1 &lt;&lt; CP0C1_FP),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_Config2 =3D MIPS_CONFIG2,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config3 =3D MIPS_CONFIG3 | (1U &lt;&lt; C=
P0C3_M) | (1 &lt;&lt; CP0C3_MSAP) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .CP0_Config3 =3D MIPS_CONFIG3 | (1U &lt;&lt; C=
P0C3_M) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; CP0C3_CMGCR) | (1 &lt;&lt; CP0C3_MSAP) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; CP0C3_BP) | (1 &lt;&lt; CP0C3_BI) | (1 &lt;&lt; CP0C=
3_SC) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; CP0C3_ULRI) | (1 &lt;&lt; CP0C3_RXI) | (1 &lt;&lt; CP=
0C3_LPA) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; CP0C3_VInt),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; CP0C3_PW) | (1 &lt;&lt; CP0C3_ULRI) | (1 &lt;&lt; CP0=
C3_RXI) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; CP0C3_LPA) | (1 &lt;&lt; CP0C3_VInt),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_Config4 =3D MIPS_CONFIG4 | (1U &lt;&=
lt; CP0C4_M) | (2 &lt;&lt; CP0C4_IE) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (0x1c &lt;&lt; CP0C4_KScrExist),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.CP0_Config4_rw_bitmask =3D 0,<br>
<br>
</blockquote>

--000000000000b46fbd05a4c4dad3--

