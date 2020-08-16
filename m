Return-Path: <SRS0=YAkC=B2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7EC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:33:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178D62067C
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2020 08:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qE692iov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178D62067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7E6c-00051B-Cg
	for qemu-devel@archiver.kernel.org; Sun, 16 Aug 2020 04:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7E5t-0004Vp-UM; Sun, 16 Aug 2020 04:32:45 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:46289)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k7E5s-0002jT-6Z; Sun, 16 Aug 2020 04:32:45 -0400
Received: by mail-oo1-xc43.google.com with SMTP id r6so2804084oon.13;
 Sun, 16 Aug 2020 01:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5RI5ijyuVMd1gitaAQz3IZVWqa9GLmBp9Dfp/d0b0kQ=;
 b=qE692iovFAX1tuW1RSA6DSr90+lT3yDTuk4wQ5Mo8NnDJT7N5uM4tKACq8dYpwaVen
 68dPqUTjqTo6xTz+ZqTAAxamlhicMQHMvrIC8+OgY1s6FZ8/C/KLw5X0oDfCOIJFVxC+
 vwf/xPoQBlHjE8DGxzoqc9/yYK+rpEfVyYDxs9NyQpI8yQ4bITS/bWH3cvODE9vHgLmD
 R+c5SDJqdEUSe3b9uOTqun7bsZBD1IBt20TXmdQY0GRtKykbJ3xUje9PU3clwrByr2Li
 tChlklpipCk6CAcx0OQrH5Wwo2b+6WMZrK3uJSl8ToVl0hE98mWwjxSIabHtxoFtg5VP
 q+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5RI5ijyuVMd1gitaAQz3IZVWqa9GLmBp9Dfp/d0b0kQ=;
 b=O9cSdSe1nKRMtmiOg3FYA0ORcU7jH7cbj6HNXcrDNOOIqwJKiYpBnAa5HVQnHfo1e9
 KzVWnt9oe2f9azTGRcd8BbOneEsWIM1hg7OMoZV5L0mty1Mq+oQQDoP6DSf/XJPD3+zh
 EMR5SO6QE+If/34XcyIJsBv89Jqd9po9q+dttJsNTKjsaJpCilXqoZ4w1h0m0Mxi0t5R
 wGIXYVhinLggHAUokhi5oyX+/MuFyPX0lbtMJv5m6zCBA6g/cZ+o68M0LAqPgPE8FRje
 6DpuUJ8VSWQNIv04SMABvBWZeFW95kV+HzwmV+uaYqF9e6m0d0j6YfI2U8dBx8V6Oz1Y
 v9aA==
X-Gm-Message-State: AOAM532OjheN/RhdncYSXABpd9edjJGzzEbbHAcd/ZaVmawcoQHlhwLz
 dAFDewwfun3NPbWehrE1kEHdOyyfWDIITBMIWps=
X-Google-Smtp-Source: ABdhPJwDET1JD6HS/SW5d/sIy+jn4yjjFDsQ10GUSr2LOeNeuYui92W02foV8VCIlqfJy6apkUOzGVDlfMc5wcDUcc0=
X-Received: by 2002:a4a:c587:: with SMTP id x7mr7311019oop.60.1597566762287;
 Sun, 16 Aug 2020 01:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200812104918.107116-1-stefanha@redhat.com>
 <20200812104918.107116-4-stefanha@redhat.com>
In-Reply-To: <20200812104918.107116-4-stefanha@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sun, 16 Aug 2020 16:32:06 +0800
Message-ID: <CAKXe6SKE+Zmyethcb6KUWxnr6FpieWe=o3O-cupyxreQObVLWA@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-crypto: don't modify elem->in/out_sg
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005f291905acfa7f9a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000005f291905acfa7f9a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stefan Hajnoczi <stefanha@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=9A

> A number of iov_discard_front/back() operations are made by
> virtio-crypto. The elem->in/out_sg iovec arrays are modified by these
> operations, resulting virtqueue_unmap_sg() calls on different addresses
> than were originally mapped.
>
> This is problematic because dirty memory may not be logged correctly,
> MemoryRegion refcounts may be leaked, and the non-RAM bounce buffer can
> be leaked.
>
> Take a copy of the elem->in/out_sg arrays so that the originals are
> preserved. The iov_discard_undo() API could be used instead (with better
> performance) but requires careful auditing of the code, so do the simple
> thing instead.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>

virtio-net also uses this method.

Reviewed-by: Li Qiang <liq3ea@gmail.com>


> ---
>  hw/virtio/virtio-crypto.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c
> index 6da12e315f..54f9bbb789 100644
> --- a/hw/virtio/virtio-crypto.c
> +++ b/hw/virtio/virtio-crypto.c
> @@ -228,6 +228,8 @@ static void virtio_crypto_handle_ctrl(VirtIODevice
> *vdev, VirtQueue *vq)
>      size_t s;
>
>      for (;;) {
> +        g_autofree struct iovec *out_iov_copy =3D NULL;
> +
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
>          if (!elem) {
>              break;
> @@ -240,9 +242,12 @@ static void virtio_crypto_handle_ctrl(VirtIODevice
> *vdev, VirtQueue *vq)
>          }
>
>          out_num =3D elem->out_num;
> -        out_iov =3D elem->out_sg;
> +        out_iov_copy =3D g_memdup(elem->out_sg, sizeof(out_iov[0]) *
> out_num);
> +        out_iov =3D out_iov_copy;
> +
>          in_num =3D elem->in_num;
>          in_iov =3D elem->in_sg;
> +
>          if (unlikely(iov_to_buf(out_iov, out_num, 0, &ctrl, sizeof(ctrl)=
)
>                      !=3D sizeof(ctrl))) {
>              virtio_error(vdev, "virtio-crypto request ctrl_hdr too
> short");
> @@ -582,6 +587,8 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request=
)
>      int queue_index =3D
> virtio_crypto_vq2q(virtio_get_queue_index(request->vq));
>      struct virtio_crypto_op_data_req req;
>      int ret;
> +    g_autofree struct iovec *in_iov_copy =3D NULL;
> +    g_autofree struct iovec *out_iov_copy =3D NULL;
>      struct iovec *in_iov;
>      struct iovec *out_iov;
>      unsigned in_num;
> @@ -598,9 +605,13 @@ virtio_crypto_handle_request(VirtIOCryptoReq *reques=
t)
>      }
>
>      out_num =3D elem->out_num;
> -    out_iov =3D elem->out_sg;
> +    out_iov_copy =3D g_memdup(elem->out_sg, sizeof(out_iov[0]) * out_num=
);
> +    out_iov =3D out_iov_copy;
> +
>      in_num =3D elem->in_num;
> -    in_iov =3D elem->in_sg;
> +    in_iov_copy =3D g_memdup(elem->in_sg, sizeof(in_iov[0]) * in_num);
> +    in_iov =3D in_iov_copy;
> +
>      if (unlikely(iov_to_buf(out_iov, out_num, 0, &req, sizeof(req))
>                  !=3D sizeof(req))) {
>          virtio_error(vdev, "virtio-crypto request outhdr too short");
> --
> 2.26.2
>
>

--0000000000005f291905acfa7f9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Stefan Hajnoczi &lt;<a href=3D"mailto=
:stefanha@redhat.com">stefanha@redhat.com</a>&gt; =E4=BA=8E2020=E5=B9=B48=
=E6=9C=8812=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=886:51=E5=86=99=E9=
=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
A number of iov_discard_front/back() operations are made by<br>
virtio-crypto. The elem-&gt;in/out_sg iovec arrays are modified by these<br=
>
operations, resulting virtqueue_unmap_sg() calls on different addresses<br>
than were originally mapped.<br>
<br>
This is problematic because dirty memory may not be logged correctly,<br>
MemoryRegion refcounts may be leaked, and the non-RAM bounce buffer can<br>
be leaked.<br>
<br>
Take a copy of the elem-&gt;in/out_sg arrays so that the originals are<br>
preserved. The iov_discard_undo() API could be used instead (with better<br=
>
performance) but requires careful auditing of the code, so do the simple<br=
>
thing instead.<br>
<br>
Signed-off-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com" t=
arget=3D"_blank">stefanha@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>virtio-net also uses this method.</div><div><br></div><div>Reviewed-b=
y: Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com" target=3D"_blank">liq3e=
a@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
---<br>
=C2=A0hw/virtio/virtio-crypto.c | 17 ++++++++++++++---<br>
=C2=A01 file changed, 14 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/hw/virtio/virtio-crypto.c b/hw/virtio/virtio-crypto.c<br>
index 6da12e315f..54f9bbb789 100644<br>
--- a/hw/virtio/virtio-crypto.c<br>
+++ b/hw/virtio/virtio-crypto.c<br>
@@ -228,6 +228,8 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vde=
v, VirtQueue *vq)<br>
=C2=A0 =C2=A0 =C2=A0size_t s;<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (;;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_autofree struct iovec *out_iov_copy =3D NULL=
;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0elem =3D virtqueue_pop(vq, sizeof(VirtQue=
ueElement));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!elem) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
@@ -240,9 +242,12 @@ static void virtio_crypto_handle_ctrl(VirtIODevice *vd=
ev, VirtQueue *vq)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0out_num =3D elem-&gt;out_num;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_iov =3D elem-&gt;out_sg;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_iov_copy =3D g_memdup(elem-&gt;out_sg, siz=
eof(out_iov[0]) * out_num);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_iov =3D out_iov_copy;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_num =3D elem-&gt;in_num;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in_iov =3D elem-&gt;in_sg;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(iov_to_buf(out_iov, out_num,=
 0, &amp;ctrl, sizeof(ctrl))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0!=3D sizeof(ctrl))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_error(vdev, &quot;vi=
rtio-crypto request ctrl_hdr too short&quot;);<br>
@@ -582,6 +587,8 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)<=
br>
=C2=A0 =C2=A0 =C2=A0int queue_index =3D virtio_crypto_vq2q(virtio_get_queue=
_index(request-&gt;vq));<br>
=C2=A0 =C2=A0 =C2=A0struct virtio_crypto_op_data_req req;<br>
=C2=A0 =C2=A0 =C2=A0int ret;<br>
+=C2=A0 =C2=A0 g_autofree struct iovec *in_iov_copy =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree struct iovec *out_iov_copy =3D NULL;<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *in_iov;<br>
=C2=A0 =C2=A0 =C2=A0struct iovec *out_iov;<br>
=C2=A0 =C2=A0 =C2=A0unsigned in_num;<br>
@@ -598,9 +605,13 @@ virtio_crypto_handle_request(VirtIOCryptoReq *request)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0out_num =3D elem-&gt;out_num;<br>
-=C2=A0 =C2=A0 out_iov =3D elem-&gt;out_sg;<br>
+=C2=A0 =C2=A0 out_iov_copy =3D g_memdup(elem-&gt;out_sg, sizeof(out_iov[0]=
) * out_num);<br>
+=C2=A0 =C2=A0 out_iov =3D out_iov_copy;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0in_num =3D elem-&gt;in_num;<br>
-=C2=A0 =C2=A0 in_iov =3D elem-&gt;in_sg;<br>
+=C2=A0 =C2=A0 in_iov_copy =3D g_memdup(elem-&gt;in_sg, sizeof(in_iov[0]) *=
 in_num);<br>
+=C2=A0 =C2=A0 in_iov =3D in_iov_copy;<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (unlikely(iov_to_buf(out_iov, out_num, 0, &amp;req, =
sizeof(req))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!=3D sizeof(r=
eq))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_error(vdev, &quot;virtio-crypto re=
quest outhdr too short&quot;);<br>
-- <br>
2.26.2<br>
<br>
</blockquote></div></div>

--0000000000005f291905acfa7f9a--

