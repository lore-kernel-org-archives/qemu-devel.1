Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A6C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0A9820639
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 21:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A9820639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCrJJ-0002dx-GY
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 17:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9u-0007tb-W3
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:16:11 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41151)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kCr9t-0001EQ-CH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 17:16:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id g72so7052856qke.8
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 14:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T2IJt0HY5ar8kHsx6q901E6vxHdx+vVPkomTRz1zBls=;
 b=My8HpewB2P/j4HqyxN21u27BylNB4ACCx6njWo1lFQiGhMJzvpYFMItQuT/GzPkhjb
 lcIEgpOurYPomHv7WCAJtM7dhIeQHnp4+NkZqjhzzt2QRwpI9PJe4qm4bQN8+cd1yAzS
 vPiZw85EDV9GXzgjlC2ZX4xMRZ6YXhLQ3tk646cp9tCIrSU3vOTgvoOWH20XULZ6TcR3
 gL2MEuGOMPZ56Ura4oN82xYdq79qe5fo5hp+z7DDFZVSAWVmgx3bdxkIDJ/G0FCXAObS
 WC5cxHxaseastk+fUVmrRZnKHps/92E4MIqbIlO8vc6l+Lge1AZf8ItMIU8v9ic0vehg
 E4+g==
X-Gm-Message-State: AOAM5308GUpoE0NJmqhKSusxjk9WDzWKqZ8BilMcvM1jqBK8MWhPUcQO
 2SbO4+Lds3ri2vUD5o+45c12W/uMQRe0K2ZqahoGLP9x
X-Google-Smtp-Source: ABdhPJxu5zBNlf2S6zicD8zGxnDiIGIijpn5bWQlPl1I+90/u7C/dlRJcd2YvUadiyFK1UHm5/o7O20gOkvfDVRp6mw=
X-Received: by 2002:a37:9c57:: with SMTP id f84mr3535042qke.372.1598908568524; 
 Mon, 31 Aug 2020 14:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200826171005.4055015-1-ehabkost@redhat.com>
 <20200826171005.4055015-3-ehabkost@redhat.com>
In-Reply-To: <20200826171005.4055015-3-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 31 Aug 2020 21:44:08 +0200
Message-ID: <CAAdtpL7b0OrHd_zVr=2C_ePeGkvR_oqNrPAtap5x6=Df7NJZfQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hda-audio: Set instance_size at base class
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000415a5705ae32e97b"
Received-SPF: pass client-ip=209.85.222.193;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-qk1-f193.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/31 17:16:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000415a5705ae32e97b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 26 ao=C3=BBt 2020 19:12, Eduardo Habkost <ehabkost@redhat.com> a =
=C3=A9crit :

> Setting instance_size correctly at the base class will help us
> avoid mistakes when declaring new subclasses.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

---
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: qemu-devel@nongnu.org
> ---
>  hw/audio/hda-codec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index cbd92b72f2..2d16448181 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -898,6 +898,7 @@ static void hda_audio_base_class_init(ObjectClass
> *klass, void *data)
>  static const TypeInfo hda_audio_info =3D {
>      .name          =3D TYPE_HDA_AUDIO,
>      .parent        =3D TYPE_HDA_CODEC_DEVICE,
> +    .instance_size =3D sizeof(HDAAudioState),
>      .class_init    =3D hda_audio_base_class_init,
>      .abstract      =3D true,
>  };
> @@ -914,7 +915,6 @@ static void hda_audio_output_class_init(ObjectClass
> *klass, void *data)
>  static const TypeInfo hda_audio_output_info =3D {
>      .name          =3D "hda-output",
>      .parent        =3D TYPE_HDA_AUDIO,
> -    .instance_size =3D sizeof(HDAAudioState),
>      .class_init    =3D hda_audio_output_class_init,
>  };
>
> @@ -930,7 +930,6 @@ static void hda_audio_duplex_class_init(ObjectClass
> *klass, void *data)
>  static const TypeInfo hda_audio_duplex_info =3D {
>      .name          =3D "hda-duplex",
>      .parent        =3D TYPE_HDA_AUDIO,
> -    .instance_size =3D sizeof(HDAAudioState),
>      .class_init    =3D hda_audio_duplex_class_init,
>  };
>
> @@ -946,7 +945,6 @@ static void hda_audio_micro_class_init(ObjectClass
> *klass, void *data)
>  static const TypeInfo hda_audio_micro_info =3D {
>      .name          =3D "hda-micro",
>      .parent        =3D TYPE_HDA_AUDIO,
> -    .instance_size =3D sizeof(HDAAudioState),
>      .class_init    =3D hda_audio_micro_class_init,
>  };
>
> --
> 2.26.2
>
>
>

--000000000000415a5705ae32e97b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Le mer. 26 ao=C3=BBt 2020 19:12, Eduardo Habkost &lt;<a hr=
ef=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</a>&gt; a =C3=A9crit=
=C2=A0:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Setting instance_size corre=
ctly at the base class will help us<br>
avoid mistakes when declaring new subclasses.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank" rel=3D"noreferrer">ehabkost@redhat.com</a>&gt;<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><span style=
=3D"font-family:sans-serif;font-size:13.696px">Reviewed-by: Philippe Mathie=
u-Daud=C3=A9 &lt;</span><a href=3D"mailto:f4bug@amsat.org" style=3D"text-de=
coration:none;color:rgb(66,133,244);font-family:sans-serif;font-size:13.696=
px">f4bug@amsat.org</a><span style=3D"font-family:sans-serif;font-size:13.6=
96px">&gt;</span><br></div><div dir=3D"auto"><span style=3D"font-family:san=
s-serif;font-size:13.696px"><br></span></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
---<br>
Cc: Gerd Hoffmann &lt;<a href=3D"mailto:kraxel@redhat.com" target=3D"_blank=
" rel=3D"noreferrer">kraxel@redhat.com</a>&gt;<br>
Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank" rel=3D"noref=
errer">qemu-devel@nongnu.org</a><br>
---<br>
=C2=A0hw/audio/hda-codec.c | 4 +---<br>
=C2=A01 file changed, 1 insertion(+), 3 deletions(-)<br>
<br>
diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c<br>
index cbd92b72f2..2d16448181 100644<br>
--- a/hw/audio/hda-codec.c<br>
+++ b/hw/audio/hda-codec.c<br>
@@ -898,6 +898,7 @@ static void hda_audio_base_class_init(ObjectClass *klas=
s, void *data)<br>
=C2=A0static const TypeInfo hda_audio_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_HDA_AU=
DIO,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_HDA_CODEC_D=
EVICE,<br>
+=C2=A0 =C2=A0 .instance_size =3D sizeof(HDAAudioState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D hda_audio_base_class_init,=
<br>
=C2=A0 =C2=A0 =C2=A0.abstract=C2=A0 =C2=A0 =C2=A0 =3D true,<br>
=C2=A0};<br>
@@ -914,7 +915,6 @@ static void hda_audio_output_class_init(ObjectClass *kl=
ass, void *data)<br>
=C2=A0static const TypeInfo hda_audio_output_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;hda-o=
utput&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_HDA_AUDIO,<=
br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(HDAAudioState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D hda_audio_output_class_ini=
t,<br>
=C2=A0};<br>
<br>
@@ -930,7 +930,6 @@ static void hda_audio_duplex_class_init(ObjectClass *kl=
ass, void *data)<br>
=C2=A0static const TypeInfo hda_audio_duplex_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;hda-d=
uplex&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_HDA_AUDIO,<=
br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(HDAAudioState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D hda_audio_duplex_class_ini=
t,<br>
=C2=A0};<br>
<br>
@@ -946,7 +945,6 @@ static void hda_audio_micro_class_init(ObjectClass *kla=
ss, void *data)<br>
=C2=A0static const TypeInfo hda_audio_micro_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D &quot;hda-m=
icro&quot;,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_HDA_AUDIO,<=
br>
-=C2=A0 =C2=A0 .instance_size =3D sizeof(HDAAudioState),<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D hda_audio_micro_class_init=
,<br>
=C2=A0};<br>
<br>
-- <br>
2.26.2<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000415a5705ae32e97b--

