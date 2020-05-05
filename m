Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFDC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA13206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OoOpM/QY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA13206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv2a-0007MW-3A
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVv0Z-0005Tt-Rf
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:41:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36183)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVv0Y-0006Qo-Rb
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:41:03 -0400
Received: by mail-wm1-x343.google.com with SMTP id u127so1775346wmg.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=k5GNuRhr1DdKQtiS/KUWIliVLehzHmkGo8DfNV+5/XQ=;
 b=OoOpM/QYpan2g5EHY9+1/uY8oCO33IRttUM6EDmxetEBwh+dvKCsuLgB3B1S5jPlv4
 gFw9LnNpxRgmesCG1RMEbPFINJU5cDy+MFDOsNNT5ZgsaTPDqCUT7MSMPZ6kj50l1vdJ
 hSsjqfu4p6oQV1W1PGIOSKXRfqXUfm8YguaJ5105p/MOIYqvlPkhz5WglHFQYG8jdvbN
 SkWPgyvrLK7D3x/kBD3ngK1NPf+F3i8grjxdRG9lkXehcnxpz4vrc9IsqBkbqdlW1rW1
 U1XB+q3rMiilmV2UAqZd3LuNv9NCvQF2IBVrhN7S/xnJuxwvl6QmmPbdPJCgEr4oEbqh
 b+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=k5GNuRhr1DdKQtiS/KUWIliVLehzHmkGo8DfNV+5/XQ=;
 b=qicjBv1EiMV/QKR5Q2X+FTWayOAI3ONSyXH94S+Mxyg+s5Eac8N/T0458hYCwhkNhu
 lBwoRAoNjmiLhgzGqRVlYdcA7FfzFhvu8NbjCg2xwGtdFVlynDhlv7BtooRikhfWxHSD
 Joplp9rDAmDx4Vh1qHxc07ldcQebXk64rDfDCIwsLEqxIV36ISjREmiwgh+XaTvdia7N
 SRv7sGsi6XdGmm17BnpBVAvcqS4nydl0wzfQvobA/YORUhtVDC4jIDrwDcXwPcRggAbU
 LnB0HHr6Vb7QmRRjp7yNIi5KZwhJNhjmtKbyC0J4UoOcEjnyCOOpCjqXOMGVUPX6S6FZ
 sglA==
X-Gm-Message-State: AGi0PuY8HSg3ITY4iP3TiORnmOtpmKSFix//GnvdWwE2qU42FKjYADoE
 JujBWdaQKNdATpnrNiN6dsRl3JrvYDLZuVOOlhM=
X-Google-Smtp-Source: APiQypKpLB9C8XHbVTLRDO4muw5XTXi2RxSyrYPORZ3edBP8UN4dv2TowwEC2D5gydKAbCOTg+8d754K3vUP190NI48=
X-Received: by 2002:a1c:f211:: with SMTP id s17mr2862894wmc.168.1588675261453; 
 Tue, 05 May 2020 03:41:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:41:01 -0700 (PDT)
In-Reply-To: <20200505101908.6207-7-armbru@redhat.com>
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-7-armbru@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:41:01 +0200
Message-ID: <CAHiYmc4cY2EDY9zn+1PM0iOH6L=aA0jRxUONQJXzZjUAz1c8BQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mips/malta: Fix create_cps() error handling
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009f59ee05a4e44804"
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009f59ee05a4e44804
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., Markus =
Armbruster <armbru@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
>
> create_cps() is wrong that way.  The last calls treats an error as
> fatal.  Do that for the prior ones, too.
>
> Fixes: bff384a4fbd5d0e86939092e74e766ef0f5f592c
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/mips_malta.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
>
Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..17bf41616b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(MachineState
> *ms,
>  static void create_cps(MachineState *ms, MaltaState *s,
>                         qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
> -    Error *err =3D NULL;
> -
>      sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps),
> sizeof(s->cps),
>                            TYPE_MIPS_CPS);
> -    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
> &err);
> -    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
> &err);
> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -    if (err !=3D NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> -    }
> +    object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type",
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp",
> +                            &error_fatal);
> +    object_property_set_bool(OBJECT(&s->cps), true, "realized",
> +                             &error_fatal);
>
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>
> --
> 2.21.1
>
>

--0000000000009f59ee05a4e44804
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020.,=
 Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@redhat.c=
om</a>&gt; =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=
=D0=B0:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex">The Error ** argument must be NUL=
L, &amp;error_abort, &amp;error_fatal, or a<br>
pointer to a variable containing NULL.=C2=A0 Passing an argument of the<br>
latter kind twice without clearing it in between is wrong: if the<br>
first call sets an error, it no longer points to NULL for the second<br>
<br>
create_cps() is wrong that way.=C2=A0 The last calls treats an error as<br>
fatal.=C2=A0 Do that for the prior ones, too.<br>
<br>
Fixes: bff384a4fbd5d0e86939092e74e766<wbr>ef0f5f592c<br>
Cc: Aleksandar Markovic &lt;<a href=3D"mailto:aleksandar.qemu.devel@gmail.c=
om">aleksandar.qemu.devel@gmail.<wbr>com</a>&gt;<br>
Cc: &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt;<a href=3D"mailto:philmd@re=
dhat.com">philmd@redhat.com</a>&gt;<br>
Cc: Aurelien Jarno &lt;<a href=3D"mailto:aurelien@aurel32.net">aurelien@aur=
el32.net</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">a=
rmbru@redhat.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.=
org">f4bug@amsat.org</a>&gt;<br>
Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.or=
g">f4bug@amsat.org</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_malta.c | 15 ++++++---------<br>
=C2=A01 file changed, 6 insertions(+), 9 deletions(-)<br>
<br></blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);fon=
t-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovi=
c &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_=
blank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.q=
emu.devel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34);font-size:14=
px;line-height:22.1200008392334px">&gt;</span><br></div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c<br>
index e4c4de1b4e..17bf41616b 100644<br>
--- a/hw/mips/mips_malta.c<br>
+++ b/hw/mips/mips_malta.c<br>
@@ -1185,17 +1185,14 @@ static void create_cpu_without_cps(<wbr>MachineStat=
e *ms,<br>
=C2=A0static void create_cps(MachineState *ms, MaltaState *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 qemu_irq *cbus_irq, qemu_irq *i8259_irq)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 Error *err =3D NULL;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(OBJECT(<wbr>s), &quot;cps&quot;, =
OBJECT(&amp;s-&gt;cps), sizeof(s-&gt;cps),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0TYPE_MIPS_CPS);<br>
-=C2=A0 =C2=A0 object_property_set_str(<wbr>OBJECT(&amp;s-&gt;cps), ms-&gt;=
cpu_type, &quot;cpu-type&quot;, &amp;err);<br>
-=C2=A0 =C2=A0 object_property_set_int(<wbr>OBJECT(&amp;s-&gt;cps), ms-&gt;=
smp.cpus, &quot;num-vp&quot;, &amp;err);<br>
-=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cps), true, =
&quot;realized&quot;, &amp;err);<br>
-=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s&quot;, error_get_pretty(=
err));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 object_property_set_str(<wbr>OBJECT(&amp;s-&gt;cps), ms-&gt;=
cpu_type, &quot;cpu-type&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 object_property_set_int(<wbr>OBJECT(&amp;s-&gt;cps), ms-&gt;=
smp.cpus, &quot;num-vp&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cps), true, =
&quot;realized&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;error_fatal);<br>
<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map_overlap(SYS_<wbr>BUS_DEVICE(&amp;s-&gt;=
cps), 0, 0, 1);<br>
=C2=A0<br>
-- <br>
2.21.1<br>
<br>
</blockquote>

--0000000000009f59ee05a4e44804--

