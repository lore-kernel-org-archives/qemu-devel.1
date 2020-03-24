Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A56C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 01:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3E9320714
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 01:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o7H2tFeb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3E9320714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGYPT-0004dS-3V
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 21:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36926)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1jGYOg-0003uP-Hj
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 21:30:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1jGYOe-0003HF-GP
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 21:30:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45277)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1jGYOe-0003H1-9Y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 21:30:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id l22so6142794oii.12
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AS9t+CXcDL7ACp+d4oEvxC7SeBmWyJIIxPINJN4xnb0=;
 b=o7H2tFebs/2h6f2Zekp6ZWmkzhOonR9koGfYn9AC3PM0S0gpkumH78ppOjUJFFcBIp
 ADPpa6qx5qiUPpKV2KWd5vNYTmWVdsb3lWDgkDVofKOkw8wYlr3Aop6Q5BolIEke6ZNP
 82CsWfRVt5iPvzXxYAFreOhPev4LYhzuddlwmsIqNjLjZBpm2RtWmt9ThALocxRHg+Fr
 6zOrkUoGVXDZL4onc3gY79d/FmH0qOXKIbWyEsrVBMr7+VsEIs87xt88zbOF5PwQ6bb/
 /ROiwfLaUdPTCuKU6VPGwbE1sDjqk0hg+VK39yFRitp50ky1jUnpnjPrqlq6dMEK47iZ
 cZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AS9t+CXcDL7ACp+d4oEvxC7SeBmWyJIIxPINJN4xnb0=;
 b=gtoaXYq0nMGy8r2/wPVfblIDdKW9d5e38ZOHnF+KgwS1TfxhzO+QdKYfw0BkJqvGSd
 cE+jPBQ4Y6Swf+OT9neJJ8GLVepeb2TpJ7Nt+mB9fw7dc7YbxA3exAVxpVvKye98xmB0
 UTeZ0sLmuqzNsimOKsLVCbO4BnzMqIcaq030GYR9frDOuYgFVZ0kSPyCUFPD1911Dl4l
 LAs/HZ3jhRynjd50jZ9aTruwdnfQVnR2xGXYjX7955tKruntd164bj2poZRkBQfZvo9K
 VHYWhrr2YP4j44B9yfAAP/+0Nzi7vFSqROsgYnOuE5sfbeVSFWZb4qtI1B5aKIlh77SY
 LbKg==
X-Gm-Message-State: ANhLgQ0Bp1JFnBUNNliBYpws4oxS1XFG+5VRRacV1t49f+l2/HpTLTMF
 HgCzFClZoAAnAgZpA3j9jH+Ba6T/nK8Rp4dHFQE=
X-Google-Smtp-Source: ADFU+vtRSvLO8ZeFyehXlkUcGiDb8akdqa2GyTKXx9HM0EjKBuTw31kjv22K+mdQoLAGO0nKf0sEYqavMtNgrlau7oo=
X-Received: by 2002:aca:ab4b:: with SMTP id u72mr1740460oie.97.1585013423225; 
 Mon, 23 Mar 2020 18:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200323122100.893417-1-ppandit@redhat.com>
 <20200323122100.893417-2-ppandit@redhat.com>
In-Reply-To: <20200323122100.893417-2-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 24 Mar 2020 09:29:47 +0800
Message-ID: <CAKXe6SKtuk7qr1dFVJoHm3LZ40OG8Nfhanj1zqdBVzAQ+Smc0w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] net: tulip: check frame size and r/w data length
To: P J P <ppandit@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000e40f705a18fb238"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000000e40f705a18fb238
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8823=E6=97=A5=E5=
=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:24=E5=86=99=E9=81=93=EF=BC=9A

> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Tulip network driver while copying tx/rx buffers does not check
> frame size against r/w data length. This may lead to OOB buffer
> access. Add check to avoid it.
>
> Limit iterations over descriptors to avoid potential infinite
> loop issue in tulip_xmit_list_update.
>
> Reported-by: Li Qiang <pangpei.lq@antfin.com>
> Reported-by: Ziming Zhang <ezrakiez@gmail.com>
> Reported-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
>


Tested-by: Li Qiang <liq3ea@gmail.com>
But I have a minor question....


> ---
>  hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>
> Update v3: return a value from tulip_copy_tx_buffers() and avoid infinite
> loop
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
>
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index cfac2719d3..fbe40095da 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struc=
t
> tulip_descriptor *desc)
>          } else {
>              len =3D s->rx_frame_len;
>          }
> +
> +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> +            return;
> +        }
>


Why here is '>=3D' instead of '>'.
IIUC the total sending length can reach to sizeof(s->rx_frame).
Same in the other place in this patch.

PS: I have planned to write a qtest case. But my personal qemu dev
environment is broken.
I will try to write it tonight or tomorrow night.

Thanks,
Li Qiang






>          pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
>              (s->rx_frame_size - s->rx_frame_len), len);
>          s->rx_frame_len -=3D len;
> @@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struc=
t
> tulip_descriptor *desc)
>          } else {
>              len =3D s->rx_frame_len;
>          }
> +
> +        if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
> +            return;
> +        }
>          pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
>              (s->rx_frame_size - s->rx_frame_len), len);
>          s->rx_frame_len -=3D len;
> @@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s, const
> uint8_t *buf, size_t size)
>
>      trace_tulip_receive(buf, size);
>
> -    if (size < 14 || size > 2048 || s->rx_frame_len ||
> tulip_rx_stopped(s)) {
> +    if (size < 14 || size > sizeof(s->rx_frame) - 4
> +        || s->rx_frame_len || tulip_rx_stopped(s)) {
>          return 0;
>      }
>
> @@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc(NetClientState *nc,
>      return tulip_receive(qemu_get_nic_opaque(nc), buf, size);
>  }
>
> -
>  static NetClientInfo net_tulip_info =3D {
>      .type =3D NET_CLIENT_DRIVER_NIC,
>      .size =3D sizeof(NICState),
> @@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struct
> tulip_descriptor *desc)
>          if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
>              /* Internal or external Loopback */
>              tulip_receive(s, s->tx_frame, s->tx_frame_len);
> -        } else {
> +        } else if (s->tx_frame_len <=3D sizeof(s->tx_frame)) {
>              qemu_send_packet(qemu_get_queue(s->nic),
>                  s->tx_frame, s->tx_frame_len);
>          }
> @@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s, struct
> tulip_descriptor *desc)
>      }
>  }
>
> -static void tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor
> *desc)
> +static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor
> *desc)
>  {
>      int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) &
> TDES1_BUF1_SIZE_MASK;
>      int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) &
> TDES1_BUF2_SIZE_MASK;
>
> +    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
> +        return -1;
> +    }
>      if (len1) {
>          pci_dma_read(&s->dev, desc->buf_addr1,
>              s->tx_frame + s->tx_frame_len, len1);
>          s->tx_frame_len +=3D len1;
>      }
>
> +    if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
> +        return -1;
> +    }
>      if (len2) {
>          pci_dma_read(&s->dev, desc->buf_addr2,
>              s->tx_frame + s->tx_frame_len, len2);
>          s->tx_frame_len +=3D len2;
>      }
>      desc->status =3D (len1 + len2) ? 0 : 0x7fffffff;
> +
> +    return 0;
>  }
>
>  static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf, int n)
> @@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)
>
>  static void tulip_xmit_list_update(TULIPState *s)
>  {
> +#define TULIP_DESC_MAX 128
> +    uint8_t i =3D 0;
>      struct tulip_descriptor desc;
>
>      if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {
>          return;
>      }
>
> -    for (;;) {
> +    for (i =3D 0; i < TULIP_DESC_MAX; i++) {
>          tulip_desc_read(s, s->current_tx_desc, &desc);
>          tulip_dump_tx_descriptor(s, &desc);
>
> @@ -675,10 +693,10 @@ static void tulip_xmit_list_update(TULIPState *s)
>                  s->tx_frame_len =3D 0;
>              }
>
> -            tulip_copy_tx_buffers(s, &desc);
> -
> -            if (desc.control & TDES1_LS) {
> -                tulip_tx(s, &desc);
> +            if (!tulip_copy_tx_buffers(s, &desc)) {
> +                if (desc.control & TDES1_LS) {
> +                    tulip_tx(s, &desc);
> +                }
>              }
>          }
>          tulip_desc_write(s, s->current_tx_desc, &desc);
> --
> 2.25.1
>
>
>

--0000000000000e40f705a18fb238
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">P J P &lt;<a href=3D"mailto:ppandit@r=
edhat.com" target=3D"_blank">ppandit@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=
=B43=E6=9C=8823=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:24=E5=86=99=
=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">From: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fedoraproject.org" targe=
t=3D"_blank">pjp@fedoraproject.org</a>&gt;<br>
<br>
Tulip network driver while copying tx/rx buffers does not check<br>
frame size against r/w data length. This may lead to OOB buffer<br>
access. Add check to avoid it.<br>
<br>
Limit iterations over descriptors to avoid potential infinite<br>
loop issue in tulip_xmit_list_update.<br>
<br>
Reported-by: Li Qiang &lt;<a href=3D"mailto:pangpei.lq@antfin.com" target=
=3D"_blank">pangpei.lq@antfin.com</a>&gt;<br>
Reported-by: Ziming Zhang &lt;<a href=3D"mailto:ezrakiez@gmail.com" target=
=3D"_blank">ezrakiez@gmail.com</a>&gt;<br>
Reported-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.com" target=
=3D"_blank">jasowang@redhat.com</a>&gt;<br>
Signed-off-by: Prasad J Pandit &lt;<a href=3D"mailto:pjp@fedoraproject.org"=
 target=3D"_blank">pjp@fedoraproject.org</a>&gt;<br></blockquote><div><br><=
/div><div><br></div><div>Tested-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@g=
mail.com">liq3ea@gmail.com</a>&gt;</div><div>But I have a minor question...=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------<br>
=C2=A01 file changed, 27 insertions(+), 9 deletions(-)<br>
<br>
Update v3: return a value from tulip_copy_tx_buffers() and avoid infinite l=
oop<br>
=C2=A0 -&gt; <a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-=
02/msg06275.html" rel=3D"noreferrer" target=3D"_blank">https://lists.gnu.or=
g/archive/html/qemu-devel/2020-02/msg06275.html</a><br>
<br>
diff --git a/hw/net/tulip.c b/hw/net/tulip.c<br>
index cfac2719d3..fbe40095da 100644<br>
--- a/hw/net/tulip.c<br>
+++ b/hw/net/tulip.c<br>
@@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D s-&gt;rx_frame_len;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_frame_len + len &gt;=3D sizeof(s-=
&gt;rx_frame)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div><br></di=
v><div>Why here is &#39;&gt;=3D&#39; instead of &#39;&gt;&#39;.=C2=A0</div>=
<div>IIUC the total sending length can reach to sizeof(s-&gt;rx_frame).</di=
v><div>Same in the other place in this patch.</div><div><br></div><div>PS: =
I have planned to write a qtest case. But my personal qemu dev environment =
is broken.</div><div>I will try to write it tonight or=C2=A0tomorrow night.=
=C2=A0</div><div><br></div><div>Thanks,</div><div>Li Qiang</div><div><br></=
div><div><br></div><div><br></div><div><br></div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&amp;s-&gt;dev, desc-&gt;bu=
f_addr1, s-&gt;rx_frame +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;rx_frame_size - s-&g=
t;rx_frame_len), len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_frame_len -=3D len;<br>
@@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D s-&gt;rx_frame_len;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;rx_frame_len + len &gt;=3D sizeof(s-=
&gt;rx_frame)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(&amp;s-&gt;dev, desc-&gt;bu=
f_addr2, s-&gt;rx_frame +<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;rx_frame_size - s-&g=
t;rx_frame_len), len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;rx_frame_len -=3D len;<br>
@@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_tulip_receive(buf, size);<br>
<br>
-=C2=A0 =C2=A0 if (size &lt; 14 || size &gt; 2048 || s-&gt;rx_frame_len || =
tulip_rx_stopped(s)) {<br>
+=C2=A0 =C2=A0 if (size &lt; 14 || size &gt; sizeof(s-&gt;rx_frame) - 4<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 || s-&gt;rx_frame_len || tulip_rx_stopped(s)) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc(NetClientState *nc,<br>
=C2=A0 =C2=A0 =C2=A0return tulip_receive(qemu_get_nic_opaque(nc), buf, size=
);<br>
=C2=A0}<br>
<br>
-<br>
=C2=A0static NetClientInfo net_tulip_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.type =3D NET_CLIENT_DRIVER_NIC,<br>
=C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),<br>
@@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struct tulip_descri=
ptor *desc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((s-&gt;csr[6] &gt;&gt; CSR6_OM_SHIFT)=
 &amp; CSR6_OM_MASK) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Internal or external Loo=
pback */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_receive(s, s-&gt;tx_f=
rame, s-&gt;tx_frame_len);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (s-&gt;tx_frame_len &lt;=3D sizeof(s=
-&gt;tx_frame)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_send_packet(qemu_get_q=
ueue(s-&gt;nic),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_fram=
e, s-&gt;tx_frame_len);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s, struct tulip_desc=
riptor *desc)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *=
desc)<br>
+static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *d=
esc)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int len1 =3D (desc-&gt;control &gt;&gt; TDES1_BUF1_SIZE=
_SHIFT) &amp; TDES1_BUF1_SIZE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0int len2 =3D (desc-&gt;control &gt;&gt; TDES1_BUF2_SIZE=
_SHIFT) &amp; TDES1_BUF2_SIZE_MASK;<br>
<br>
+=C2=A0 =C2=A0 if (s-&gt;tx_frame_len + len1 &gt;=3D sizeof(s-&gt;tx_frame)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (len1) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&amp;s-&gt;dev, desc-&gt;buf=
_addr1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame + s-&gt;tx_f=
rame_len, len1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame_len +=3D len1;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (s-&gt;tx_frame_len + len2 &gt;=3D sizeof(s-&gt;tx_frame)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0if (len2) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(&amp;s-&gt;dev, desc-&gt;buf=
_addr2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame + s-&gt;tx_f=
rame_len, len2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_frame_len +=3D len2;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0desc-&gt;status =3D (len1 + len2) ? 0 : 0x7fffffff;<br>
+<br>
+=C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
<br>
=C2=A0static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf, int =
n)<br>
@@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)<br>
<br>
=C2=A0static void tulip_xmit_list_update(TULIPState *s)<br>
=C2=A0{<br>
+#define TULIP_DESC_MAX 128<br>
+=C2=A0 =C2=A0 uint8_t i =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0struct tulip_descriptor desc;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 for (;;) {<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; TULIP_DESC_MAX; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_read(s, s-&gt;current_tx_desc,=
 &amp;desc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_dump_tx_descriptor(s, &amp;desc);<b=
r>
<br>
@@ -675,10 +693,10 @@ static void tulip_xmit_list_update(TULIPState *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;tx_fram=
e_len =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_copy_tx_buffers(s, &amp;de=
sc);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.control &amp; TDES1_LS)=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tulip_tx(s, &amp;d=
esc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!tulip_copy_tx_buffers(s, &a=
mp;desc)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (desc.control &=
amp; TDES1_LS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tuli=
p_tx(s, &amp;desc);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tulip_desc_write(s, s-&gt;current_tx_desc=
, &amp;desc);<br>
-- <br>
2.25.1<br>
<br>
<br>
</blockquote></div></div>

--0000000000000e40f705a18fb238--

