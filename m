Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4BCC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:40:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B1C9206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hW4kPXt9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1C9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv0I-0004z7-FQ
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVuzM-00041i-Si
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:39:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVuzK-0005Dv-Sp
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:39:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so1751352wmc.5
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=iqtoAIU7xIpennD78jpi1MB9eSTq+8xcGcUiNwH/2IM=;
 b=hW4kPXt91P85A/87pP+LGj+xrGPYnLkZN3BQXC57hiHIvNGNUsfxx5oUMzueDF6cog
 Hy0KktPjnjT/RN1UTv15RsHM5jmigoY6aXK/Zvo/WlYqGo54yAQJEJCjm1qjQmsZooMJ
 Ne+nLXVkGG/Nm+yjhxHTAgCT/r3nJVNbl74IE6Ivshw2Qe+Vc9fjccpfzLnIXiStys6H
 DlQyQFun41MbLZ9ouTA8HbmhXrb3+N3IJN0/7zPXIS12Xe3kz9BtxzufIoabwyqtMRux
 Z6Oe+UJ6SXuRHCpsMHKfh0J4XNbgbu1p/VuKUFHgl4vlJq6NjS34F8F5/ts7R7qa/r9v
 xpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=iqtoAIU7xIpennD78jpi1MB9eSTq+8xcGcUiNwH/2IM=;
 b=tsTUONnUm2r9UtAlo39Q6emaQcyJhnhyJ9DDUrmzVTDD+dH81tULpDFWjz883Miqtp
 nbAodQrdQqnyvsJL7C3fot+mvXzKL5U+7UIe8X+TGwAsBV427hRMCJPX9VbIeLYhQWZz
 N0v2JkonsC9oHiNO3Y2YvjXUewB89xrqtOXDhqrbUaVuhVaTC6QojH67yBJlfpEjjfYD
 XN1BRaSDCsv2FU3Ru3n+LnK+L2VLHzOYHCcqRJ297iXI/RnWfBqbOD1vzmcc7H1JlMoV
 YCv3mRAMm2DhSGb/wLS5n8OT874P5ukbspzfrCTqV2/sBj1amrn+k6/ZWt+D4psbSs6B
 5odQ==
X-Gm-Message-State: AGi0PuZUlQNRnuQq7FU7UHLvJf9o3xzC6BE+vWNeJ42ZMK//owsKTzks
 XuFemD/B1A9biC/yl39E2ilrpNF2naX71+RZNxY=
X-Google-Smtp-Source: APiQypJ1gcsNATD8UtVyeyW3iaITo9WSYalAMT5IEzCRecJTrgbAqiR8DooHHIbwxA6hY0Mkxrr7pd1sOq5uEW4nqPc=
X-Received: by 2002:a1c:9a13:: with SMTP id c19mr2652887wme.159.1588675185268; 
 Tue, 05 May 2020 03:39:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:39:44 -0700 (PDT)
In-Reply-To: <20200505101908.6207-9-armbru@redhat.com>
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-9-armbru@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:39:44 +0200
Message-ID: <CAHiYmc70A63di9E_qv0NvW=fn_7kWUNGvKg+djDPJ-c8gsy+NQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/10] mips/boston: Plug memory leak in
 boston_mach_init()
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000014dc3e05a4e4448e"
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000014dc3e05a4e4448e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., Markus =
Armbruster <armbru@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> Fixes: df1d8a1f29f567567b9d20be685a4241282e7005
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/mips/boston.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
Thank you, Markus, for spotting this error.

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

I am fine with you selecting this and another mips-related patch in this
series in your pull request, that will be result of this series.

Truly yours,
Aleksandar




> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 2832dfa6ae..a896056be1 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -426,7 +426,6 @@ static void boston_mach_init(MachineState *machine)
>  {
>      DeviceState *dev;
>      BostonState *s;
> -    Error *err =3D NULL;
>      MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
>      MemoryRegion *sys_mem =3D get_system_memory();
>      XilinxPCIEHost *pcie2;
> @@ -467,7 +466,8 @@ static void boston_mach_init(MachineState *machine)
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>
>      flash =3D  g_new(MemoryRegion, 1);
> -    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err)=
;
> +    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB,
> +                           &error_fatal);
>      memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
>
>      memory_region_add_subregion_overlap(sys_mem, 0x80000000,
> machine->ram, 0);
> --
> 2.21.1
>
>
>

--00000000000014dc3e05a4e4448e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020.,=
 Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.c=
om</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">Fixes: df1d8a1f29f567567b9d20be68=
5a42<wbr>41282e7005<br>
Cc: Paul Burton &lt;<a href=3D"mailto:pburton@wavecomp.com">pburton@wavecom=
p.com</a>&gt;<br>
Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com">al=
eksandar.rikalo@rt-rk.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">a=
rmbru@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/boston.c | 4 ++--<br>
=C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br></blockquote><div><br></div><div>Thank you, Markus, for spotting this e=
rror.</div><div><br></div><div><span style=3D"color:rgb(34,34,34);font-size=
:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic &lt;=
</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_blank"=
 style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.qemu.de=
vel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34);font-size:14px;lin=
e-height:22.1200008392334px">&gt;</span><br></div><div><span style=3D"color=
:rgb(34,34,34);font-size:14px;line-height:22.1200008392334px"><br></span></=
div><div><span style=3D"color:rgb(34,34,34);font-size:14px;line-height:22.1=
200008392334px">I am fine with you selecting this and another mips-related =
patch in this series in your pull request, that will be result of this seri=
es.</span></div><div><br></div><div>Truly yours,</div><div>Aleksandar</div>=
<div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
diff --git a/hw/mips/boston.c b/hw/mips/boston.c<br>
index 2832dfa6ae..a896056be1 100644<br>
--- a/hw/mips/boston.c<br>
+++ b/hw/mips/boston.c<br>
@@ -426,7 +426,6 @@ static void boston_mach_init(MachineState *machine)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0DeviceState *dev;<br>
=C2=A0 =C2=A0 =C2=A0BostonState *s;<br>
-=C2=A0 =C2=A0 Error *err =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;<br=
>
=C2=A0 =C2=A0 =C2=A0MemoryRegion *sys_mem =3D get_system_memory();<br>
=C2=A0 =C2=A0 =C2=A0XilinxPCIEHost *pcie2;<br>
@@ -467,7 +466,8 @@ static void boston_mach_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map_overlap(SYS_<wbr>BUS_DEVICE(&amp;s-&gt;=
cps), 0, 0, 1);<br>
<br>
=C2=A0 =C2=A0 =C2=A0flash =3D=C2=A0 g_new(MemoryRegion, 1);<br>
-=C2=A0 =C2=A0 memory_region_init_rom(flash, NULL, &quot;boston.flash&quot;=
, 128 * MiB, &amp;err);<br>
+=C2=A0 =C2=A0 memory_region_init_rom(flash, NULL, &quot;boston.flash&quot;=
, 128 * MiB,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_<wbr>overlap(sys_mem, 0x180=
00000, flash, 0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0memory_region_add_subregion_<wbr>overlap(sys_mem, 0x800=
00000, machine-&gt;ram, 0);<br>
-- <br>
2.21.1<br>
<br>
<br>
</blockquote>

--00000000000014dc3e05a4e4448e--

