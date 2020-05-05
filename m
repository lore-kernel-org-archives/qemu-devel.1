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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5378CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:42:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE023206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DASlTnr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE023206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVv1b-0006Sa-QU
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVv05-0004s1-0K
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:40:33 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39350)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jVv03-0005xs-IB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:40:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id l18so2113513wrn.6
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 03:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=hD/JLqFADErQkJP515tM0y6DNh0PbtYg5ibwoTpmL2E=;
 b=DASlTnr+yCoLFuX7i6LyFPhtPTuMf28DWUNT97H7nujQyTml7N1y12DDDJuVjPVdYC
 P6jQDszJespXsLzCTO9db9p0V3wwsugjL+xKNhyAVCa47UeCgB1KaVMpriUT1SeOQpsE
 ZCCvfzOzdJMiznqnChzgWJYI9LkwAt9r2da7dhzGuzBDZryse9VVuwXKfVbgQ67psEYA
 ynMuN8d4oR9tE2S0X4ZXofekp9na6SMfLZv/gCDM6CS5jTakdBwPnNGnYx+P7hGimMUS
 c2td15BPmfuXLkiLeX0F3ImS8kp6x2oqqCxpjDlu2S+3urhEdnE4dYnWOo9r4XB1OzD0
 0BIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=hD/JLqFADErQkJP515tM0y6DNh0PbtYg5ibwoTpmL2E=;
 b=hRKYk1USDyE1I1CBO4LHKurHVZwkohI/Mde3c5a2T4FFyd+XZ/3X1XsKNTlYNzwMj6
 aFw9PFSmmeEtrS5CtrJcN0zSVPQ6VxnEY2Oha5Zgtfgt4l6y6MLRpkmbgW6usBCQzBRj
 6jgyoglCGSsrftSESthcelbfYnJMu4IYTJoGrjbvjk5RFPEe+2vtnLSshHkYFe8U/3XJ
 DmmvGQ2uOWJSAv3zlXdqyhqiGUx8yTVQz1l3uOCX8f81bZ0ASJqOB7V2OQf3tmd4L0HJ
 Hh8rrJKsfmPzMYsPk5gaFXhh/jWe/yVbDe/zvgnLKg0R8FXXKtwGfTXtOqB5WnntTXek
 pSAA==
X-Gm-Message-State: AGi0PubMDcqZ5WteEQ64kc671YQShH1UwBsLzgrV/w89PkRdDbhXj++d
 udzvkhqUGTgUBFaf4DHuYmKRu4qAPIjsjhaWmyZt3hud
X-Google-Smtp-Source: APiQypJfBw1ISqF2JaEeY5148m7KWAS6FDI7ahNAS7FmJjBCL8dtngmFUorcAiM+7ya7++kRr302HDL8gVCScp3V2eQ=
X-Received: by 2002:adf:a2d7:: with SMTP id t23mr2932586wra.402.1588675229915; 
 Tue, 05 May 2020 03:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:28c3:0:0:0:0:0 with HTTP;
 Tue, 5 May 2020 03:40:29 -0700 (PDT)
In-Reply-To: <20200505101908.6207-8-armbru@redhat.com>
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-8-armbru@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 5 May 2020 12:40:29 +0200
Message-ID: <CAHiYmc4xX2T6mSFM1ixoy2TaWDrE17PWooPPf8ScNS3RRDcn1g@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] mips/boston: Fix boston_mach_init() error
 handling
To: Markus Armbruster <armbru@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000be213105a4e4464c"
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x444.google.com
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

--000000000000be213105a4e4464c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=83=D1=82=D0=BE=D1=80=D0=B0=D0=BA, 05. =D0=BC=D0=B0=D1=98 2020., Markus =
Armbruster <armbru@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:

> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> boston_mach_init() is wrong that way.  The last calls treats an error
> as fatal.  Do that for the prior ones, too.
>
> Fixes: df1d8a1f29f567567b9d20be685a4241282e7005
> Cc: Paul Burton <pburton@wavecomp.com>
> Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---


Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>


>  hw/mips/boston.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/hw/mips/boston.c b/hw/mips/boston.c
> index 98ecd25e8e..2832dfa6ae 100644
> --- a/hw/mips/boston.c
> +++ b/hw/mips/boston.c
> @@ -458,14 +458,11 @@ static void boston_mach_init(MachineState *machine)
>      sysbus_init_child_obj(OBJECT(machine), "cps", OBJECT(&s->cps),
>                            sizeof(s->cps), TYPE_MIPS_CPS);
>      object_property_set_str(OBJECT(&s->cps), machine->cpu_type,
> "cpu-type",
> -                            &err);
> -    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus,
> "num-vp", &err);
> -    object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -
> -    if (err !=3D NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> -    }
> +                            &error_fatal);
> +    object_property_set_int(OBJECT(&s->cps), machine->smp.cpus, "num-vp"=
,
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
>

--000000000000be213105a4e4464c
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
call.<br>
<br>
boston_mach_init() is wrong that way.=C2=A0 The last calls treats an error<=
br>
as fatal.=C2=A0 Do that for the prior ones, too.<br>
<br>
Fixes: df1d8a1f29f567567b9d20be685a42<wbr>41282e7005<br>
Cc: Paul Burton &lt;<a href=3D"mailto:pburton@wavecomp.com">pburton@wavecom=
p.com</a>&gt;<br>
Cc: Aleksandar Rikalo &lt;<a href=3D"mailto:aleksandar.rikalo@rt-rk.com">al=
eksandar.rikalo@rt-rk.com</a>&gt;<br>
Signed-off-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">a=
rmbru@redhat.com</a>&gt;<br>
---</blockquote><div><br></div><div><span style=3D"color:rgb(34,34,34);font=
-size:14px;line-height:22.1200008392334px">Reviewed-by: Aleksandar Markovic=
 &lt;</span><a href=3D"mailto:aleksandar.qemu.devel@gmail.com" target=3D"_b=
lank" style=3D"font-size:14px;line-height:22.1200008392334px">aleksandar.qe=
mu.devel@gmail.<wbr>com</a><span style=3D"color:rgb(34,34,34);font-size:14p=
x;line-height:22.1200008392334px">&gt;</span><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex">
=C2=A0hw/mips/boston.c | 13 +++++--------<br>
=C2=A01 file changed, 5 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/hw/mips/boston.c b/hw/mips/boston.c<br>
index 98ecd25e8e..2832dfa6ae 100644<br>
--- a/hw/mips/boston.c<br>
+++ b/hw/mips/boston.c<br>
@@ -458,14 +458,11 @@ static void boston_mach_init(MachineState *machine)<b=
r>
=C2=A0 =C2=A0 =C2=A0sysbus_init_child_obj(OBJECT(<wbr>machine), &quot;cps&q=
uot;, OBJECT(&amp;s-&gt;cps),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sizeof(s-&gt;cps), TYPE_MIPS_CPS);<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_str(<wbr>OBJECT(&amp;s-&gt;cps), ma=
chine-&gt;cpu_type, &quot;cpu-type&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;err);<br>
-=C2=A0 =C2=A0 object_property_set_int(<wbr>OBJECT(&amp;s-&gt;cps), machine=
-&gt;smp.cpus, &quot;num-vp&quot;, &amp;err);<br>
-=C2=A0 =C2=A0 object_property_set_bool(<wbr>OBJECT(&amp;s-&gt;cps), true, =
&quot;realized&quot;, &amp;err);<br>
-<br>
-=C2=A0 =C2=A0 if (err !=3D NULL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;%s&quot;, error_get_pretty(=
err));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;error_fatal);<br>
+=C2=A0 =C2=A0 object_property_set_int(<wbr>OBJECT(&amp;s-&gt;cps), machine=
-&gt;smp.cpus, &quot;num-vp&quot;,<br>
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
<br>
</blockquote>

--000000000000be213105a4e4464c--

