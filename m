Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80C3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1D72071E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1D72071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArvv-0003W2-Sa
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kArv9-0002g3-OP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:40:45 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kArv8-0008Q9-4v
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:40:43 -0400
Received: by mail-ej1-f65.google.com with SMTP id bo3so1909122ejb.11
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=95SklRGHP1ij3vC1NRDi+NjAlUkxEqOeQy6udkNq75c=;
 b=NqsIVfaH+PMqJNXaVlNIU/xd30fU3qpAxwbm647RPSo/M+D+vX1s0tl0BbemggQevc
 xPFhcscCUqbcocaEi4Pnvk02U3792JBJTQAPXHjOX1uQt73LpHWiqSQ2bXL5Mz1keSR7
 pdf6EsVMUg/uOvEeVA2+m+P5r3Fzri0uWdVvdpabkURbpl8xgks1V/NfajUnCIEOJwPg
 NPm8yjBa1tbCzEHFsdlxn99JhSSVSluPtLj3dJcssH4bXNORsqzi6XjFg6uNlRldjfl1
 6FNmTvOLmsgZFhHk8NuBXxH5AOKToDRsdmFSqDfxCWTR7E1fSx4G8Gj3lOu7Tk4ePQbF
 iy6g==
X-Gm-Message-State: AOAM5320xqk4uE8EdmaTKzzs8hwvyehyIKjqkNu2wqJ1DEXnxMmMsj+O
 JKjjCHeOdVaVBLBjWVKpwEAKGqqnGLQETj72rGM=
X-Google-Smtp-Source: ABdhPJyYA8M0pMaDuLV9oCeTKE7SVD9OuUfsc2pF+6ZG6RioVoM/shz7ugsQIVRt2nHN4Xbp0L1WCGKEZuZQm22dypw=
X-Received: by 2002:a17:906:3609:: with SMTP id
 q9mr5987297ejb.138.1598434840722; 
 Wed, 26 Aug 2020 02:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
In-Reply-To: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Aug 2020 11:40:28 +0200
Message-ID: <CAAdtpL7MKX-UAxPWyh-Xgj1xTLmiQat=UgpJ21xeZtpjB-nzPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] core/register: Specify instance_size in the
 TypeInfo
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: multipart/alternative; boundary="000000000000e0c25605adc49cd6"
Received-SPF: pass client-ip=209.85.218.65;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 05:36:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: alistair23@gmail.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e0c25605adc49cd6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 25 ao=C3=BBt 2020 19:42, Alistair Francis <alistair.francis@wdc.com=
> a
=C3=A9crit :

> Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/core/register.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
>
> diff --git a/hw/core/register.c b/hw/core/register.c
> index ddf91eb445..31038bd7cc 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
>      }
>  }
>
> -void register_init(RegisterInfo *reg)
> -{
> -    assert(reg);
> -
> -    if (!reg->data || !reg->access) {
> -        return;
> -    }
> -
> -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
> -}
> -
>  void register_write_memory(void *opaque, hwaddr addr,
>                             uint64_t value, unsigned size)
>  {
> @@ -269,13 +258,18 @@ static RegisterInfoArray
> *register_init_block(DeviceState *owner,
>          int index =3D rae[i].addr / data_size;
>          RegisterInfo *r =3D &ri[index];
>
> -        *r =3D (RegisterInfo) {
> -            .data =3D data + data_size * index,
> -            .data_size =3D data_size,
> -            .access =3D &rae[i],
> -            .opaque =3D owner,
> -        };
> -        register_init(r);
> +        if (data + data_size * index =3D=3D 0 || !&rae[i]) {
> +            continue;
> +        }
> +
> +        /* Init the register, this will zero it. */
> +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
>

Easier to review &ri[index] than that void* cast IMO.
Otherwise:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

+
> +        /* Set the properties of the register */
> +        r->data =3D data + data_size * index;
> +        r->data_size =3D data_size;
> +        r->access =3D &rae[i];
> +        r->opaque =3D owner;
>
>          r_array->r[i] =3D r;
>      }
> @@ -329,6 +323,7 @@ static const TypeInfo register_info =3D {
>      .name  =3D TYPE_REGISTER,
>      .parent =3D TYPE_DEVICE,
>      .class_init =3D register_class_init,
> +    .instance_size =3D sizeof(RegisterInfo),
>  };
>
>  static void register_register_types(void)
> --
> 2.28.0
>
>
>

--000000000000e0c25605adc49cd6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Le mar. 25 ao=C3=BBt 2020 19:42, Alistair Francis &lt;<a href=
=3D"mailto:alistair.francis@wdc.com">alistair.francis@wdc.com</a>&gt; a =C3=
=A9crit=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Reported-by: Eduardo=
 Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank" rel=
=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br>
Signed-off-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.=
com" target=3D"_blank" rel=3D"noreferrer">alistair.francis@wdc.com</a>&gt;<=
br>
---<br>
=C2=A0hw/core/register.c | 31 +++++++++++++------------------<br>
=C2=A01 file changed, 13 insertions(+), 18 deletions(-)<br>
<br>
diff --git a/hw/core/register.c b/hw/core/register.c<br>
index ddf91eb445..31038bd7cc 100644<br>
--- a/hw/core/register.c<br>
+++ b/hw/core/register.c<br>
@@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-void register_init(RegisterInfo *reg)<br>
-{<br>
-=C2=A0 =C2=A0 assert(reg);<br>
-<br>
-=C2=A0 =C2=A0 if (!reg-&gt;data || !reg-&gt;access) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);=
<br>
-}<br>
-<br>
=C2=A0void register_write_memory(void *opaque, hwaddr addr,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 uint64_t value, unsigned size)<br>
=C2=A0{<br>
@@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceS=
tate *owner,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int index =3D rae[i].addr / data_size;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RegisterInfo *r =3D &amp;ri[index];<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *r =3D (RegisterInfo) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data =3D data + data_size * ind=
ex,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .data_size =3D data_size,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .access =3D &amp;rae[i],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .opaque =3D owner,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 };<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 register_init(r);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (data + data_size * index =3D=3D 0 || !&amp=
;rae[i]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Init the register, this will zero it. */<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 object_initialize((void *)r, sizeof(*r), TYPE_=
REGISTER);<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Easier to review &amp;ri[index] than that void* cast IMO.</div><d=
iv dir=3D"auto">Otherwise:</div><div dir=3D"auto"><span style=3D"font-famil=
y:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathieu-Daud=C3=A9 &=
lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-decoration:none;=
color:rgb(66,133,244);font-family:sans-serif;font-size:13.696px">f4bug@amsa=
t.org</a><span style=3D"font-family:sans-serif;font-size:13.696px">&gt;</sp=
an><br></div><div dir=3D"auto"><span style=3D"font-family:sans-serif;font-s=
ize:13.696px"><br></span></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the properties of the register */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;data =3D data + data_size * index;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;data_size =3D data_size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;access =3D &amp;rae[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 r-&gt;opaque =3D owner;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r_array-&gt;r[i] =3D r;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -329,6 +323,7 @@ static const TypeInfo register_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =3D TYPE_REGISTER,<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_DEVICE,<br>
=C2=A0 =C2=A0 =C2=A0.class_init =3D register_class_init,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(RegisterInfo),<br>
=C2=A0};<br>
<br>
=C2=A0static void register_register_types(void)<br>
-- <br>
2.28.0<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000e0c25605adc49cd6--

