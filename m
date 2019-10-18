Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A9ACA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E52412064A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 18:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Clf0rETA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52412064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLWnT-00067g-35
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 14:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWlN-0004hD-Tx
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:14:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iLWlM-0007s6-If
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 14:14:09 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:39090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iLWlM-0007rG-BY; Fri, 18 Oct 2019 14:14:08 -0400
Received: by mail-ot1-x331.google.com with SMTP id s22so5731810otr.6;
 Fri, 18 Oct 2019 11:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=icoFkt0UC+KIgzku9VUJekeCwCj/k6mNAJCSvYVByt0=;
 b=Clf0rETAp6QK8hhJf+DLjn4SOkeLO2cIhxJBklcZum6C+WhhUqL+rWcFagSDimzDzh
 gjG7BjPMgk+k7/7xTjm0LTHg/RI9dMWZ22zgmK2ixeK5/XAnm4sTtBWNZ6+vWlP0oAge
 zjd/pfMsZ1dLyEK9YxlK78AQZPdliW1/Ym636iVhgwl1Kdi8JAnrZOyplnM5aRplfQ3R
 SO4BdMhH1gGJPjz1HP/oyylxVL+VctOr8BMjqhlZSXYqepkR/zktJLAxuOZnjPrG7niu
 eWs30Y94T/PNXhs/OdJHzwEig6nvBUKvy2jSzlbXjPE996R34PvxYahT1qx4t3ZEJxu0
 pihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=icoFkt0UC+KIgzku9VUJekeCwCj/k6mNAJCSvYVByt0=;
 b=Qs/g4elyz77rld56Q4r2pAb8RsS1+1UVChy6TCTyHfDOCCl8ioGZ9l6DNv338tmGb6
 srTDa+GFhbzRuIWktWifX3L61hhNVhSYKdeEViTqjESof1rVuyB3yvTrj2uAJFBVwQUg
 /Wc/pBsQTPQTjla3D4kU3FS+ifMA2YNj0AV30ARzbWF0SZ52bh++jp7i/6iVIJAAtbzh
 8jRG8ZwoieNoJwC2mHwC1hHgN3NDsIS6DEDxQAcTx0FV5rd+38PY67fvz23QVqgQx6Nm
 A5o2pe2jSkWanaDcCctJ0/fNwO/UaPGJaCOUfrfxyQ8W+wZbo/3eqXM1fagyJQPsn01E
 1ldQ==
X-Gm-Message-State: APjAAAWIRAiCB+tSSEw/xY8slubc+7kIks2geihcICHTpPuMvv5oxfQE
 id8teaZx9LPSIEatbqATDu5RH70eo/wUHxKN1pM=
X-Google-Smtp-Source: APXvYqwWZuFhn6Q41MoVJCUwF4JMm1J6p1CTru1qtioy3Q6YrplIM47xpzy7bEGCzf8/elp/ts8LFQtROtNLFn/1TBI=
X-Received: by 2002:a9d:684c:: with SMTP id c12mr9001484oto.341.1571422447563; 
 Fri, 18 Oct 2019 11:14:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP; Fri, 18 Oct 2019 11:14:07
 -0700 (PDT)
In-Reply-To: <20191018154212.13458-6-marcandre.lureau@redhat.com>
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-6-marcandre.lureau@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 18 Oct 2019 20:14:07 +0200
Message-ID: <CAL1e-=hh-OgA-0Ugz=LsQ_cA2hs9aVEf-ZpSmPN4vd4hit_Qww@mail.gmail.com>
Subject: Re: [PATCH 05/14] dp8393x: replace PROP_PTR with PROP_LINK
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c7791c0595334c91"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c7791c0595334c91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Friday, October 18, 2019, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redha=
t.com>
wrote:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/mips/mips_jazz.c | 3 ++-
>  hw/net/dp8393x.c    | 7 +++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
>
Marc-Andre,

Can you put together a paragraph on why we need this patch, and place it in
the commit message?

Thanks,

Aleksandar





> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index 8d010a0b6e..878925a963 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,
>              dev =3D qdev_create(NULL, "dp8393x");
>              qdev_set_nic_properties(dev, nd);
>              qdev_prop_set_uint8(dev, "it_shift", 2);
> -            qdev_prop_set_ptr(dev, "dma_mr", rc4030_dma_mr);
> +            object_property_set_link(OBJECT(dev), OBJECT(rc4030_dma_mr),
> +                                     "dma_mr", &error_abort);
>              qdev_init_nofail(dev);
>              sysbus =3D SYS_BUS_DEVICE(dev);
>              sysbus_mmio_map(sysbus, 0, 0x80001000);
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index a5678e11fa..946c7a8f64 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -173,7 +173,7 @@ typedef struct dp8393xState {
>      int loopback_packet;
>
>      /* Memory access */
> -    void *dma_mr;
> +    MemoryRegion *dma_mr;
>      AddressSpace as;
>  } dp8393xState;
>
> @@ -922,7 +922,8 @@ static const VMStateDescription vmstate_dp8393x =3D {
>
>  static Property dp8393x_properties[] =3D {
>      DEFINE_NIC_PROPERTIES(dp8393xState, conf),
> -    DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
> +    DEFINE_PROP_LINK("dma_mr", dp8393xState, dma_mr,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>      DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> @@ -936,8 +937,6 @@ static void dp8393x_class_init(ObjectClass *klass,
> void *data)
>      dc->reset =3D dp8393x_reset;
>      dc->vmsd =3D &vmstate_dp8393x;
>      dc->props =3D dp8393x_properties;
> -    /* Reason: dma_mr property can't be set */
> -    dc->user_creatable =3D false;
>  }
>
>  static const TypeInfo dp8393x_info =3D {
> --
> 2.23.0.606.g08da6496b6
>
>
>

--000000000000c7791c0595334c91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Friday, October 18, 2019, Marc-Andr=C3=A9 Lureau &lt;<a href=3D"=
mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt; wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Signed-off-by: Marc-Andr=C3=A9 Lureau=
 &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marcandre.lureau@redhat=
.com</a>&gt;<br>
---<br>
=C2=A0hw/mips/mips_jazz.c | 3 ++-<br>
=C2=A0hw/net/dp8393x.c=C2=A0 =C2=A0 | 7 +++----<br>
=C2=A02 files changed, 5 insertions(+), 5 deletions(-)<br>
<br></blockquote><div><br></div><div>Marc-Andre,</div><div><br></div><div>C=
an you put together a paragraph on why we need this patch, and place it in =
the commit message?</div><div><br></div><div>Thanks,</div><div><br></div><d=
iv>Aleksandar</div><div><br></div><div><br></div><div><br></div><div>=C2=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c<br>
index 8d010a0b6e..878925a963 100644<br>
--- a/hw/mips/mips_jazz.c<br>
+++ b/hw/mips/mips_jazz.c<br>
@@ -284,7 +284,8 @@ static void mips_jazz_init(MachineState *machine,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev =3D qdev_create(NULL, &=
quot;dp8393x&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_set_nic_properties(dev=
, nd);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_prop_set_uint8(dev, &q=
uot;it_shift&quot;, 2);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_prop_set_ptr(dev, &quot;dma=
_mr&quot;, rc4030_dma_mr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 object_property_set_link(<wbr>OB=
JECT(dev), OBJECT(rc4030_dma_mr),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;dma_mr&quo=
t;, &amp;error_abort);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qdev_init_nofail(dev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus =3D SYS_BUS_DEVICE(d=
ev);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(sysbus, 0, =
0x80001000);<br>
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c<br>
index a5678e11fa..946c7a8f64 100644<br>
--- a/hw/net/dp8393x.c<br>
+++ b/hw/net/dp8393x.c<br>
@@ -173,7 +173,7 @@ typedef struct dp8393xState {<br>
=C2=A0 =C2=A0 =C2=A0int loopback_packet;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* Memory access */<br>
-=C2=A0 =C2=A0 void *dma_mr;<br>
+=C2=A0 =C2=A0 MemoryRegion *dma_mr;<br>
=C2=A0 =C2=A0 =C2=A0AddressSpace as;<br>
=C2=A0} dp8393xState;<br>
<br>
@@ -922,7 +922,8 @@ static const VMStateDescription vmstate_dp8393x =3D {<b=
r>
<br>
=C2=A0static Property dp8393x_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_NIC_PROPERTIES(<wbr>dp8393xState, conf),<br>
-=C2=A0 =C2=A0 DEFINE_PROP_PTR(&quot;dma_mr&quot;, dp8393xState, dma_mr),<b=
r>
+=C2=A0 =C2=A0 DEFINE_PROP_LINK(&quot;dma_mr&quot;, dp8393xState, dma_mr,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0TYPE_MEMORY_REGION, MemoryRegion *),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UINT8(&quot;it_shift&quot;, dp8393xState, i=
t_shift, 0),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_END_OF_LIST(),<br>
=C2=A0};<br>
@@ -936,8 +937,6 @@ static void dp8393x_class_init(ObjectClass *klass, void=
 *data)<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;reset =3D dp8393x_reset;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;vmsd =3D &amp;vmstate_dp8393x;<br>
=C2=A0 =C2=A0 =C2=A0dc-&gt;props =3D dp8393x_properties;<br>
-=C2=A0 =C2=A0 /* Reason: dma_mr property can&#39;t be set */<br>
-=C2=A0 =C2=A0 dc-&gt;user_creatable =3D false;<br>
=C2=A0}<br>
<br>
=C2=A0static const TypeInfo dp8393x_info =3D {<br>
-- <br>
2.23.0.606.g08da6496b6<br>
<br>
<br>
</blockquote>

--000000000000c7791c0595334c91--

