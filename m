Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED62CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DFD2078B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 16:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoUrXREz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DFD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAyfG-0007qr-TH
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAyeb-00077H-MQ; Wed, 26 Aug 2020 12:52:05 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:42108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAyeZ-0002am-LK; Wed, 26 Aug 2020 12:52:05 -0400
Received: by mail-lj1-x241.google.com with SMTP id t6so3141207ljk.9;
 Wed, 26 Aug 2020 09:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=zuNk7v+IEG1NX946w4US+NnSDslhmTRg4grXH/qysdU=;
 b=RoUrXREz1IAhYdIoE3vYJyfanZuzTqBHkOMfhc8I9YPEW3N87Fj4+VGFSy7EJrXSy2
 rjG9N0mb+/Ke3iMJDopKx7JVtcsfUpjp/1kVyKlxOTdYdY0SIpk4Bu8V1iwKlsYxlCx+
 lU+y9RQk8aib7IFRW98MyU+ViTd8/0SGdfMBXZvKUYHj2nV1dY6za7Xs9Kn7WRqXBlKT
 6mcSl2odua88EaLfTVrky1kaiEYpNED70BOdNZM4jnszr9m6FM095uvkpIZQSEaQecW9
 ZwqcSr5YKZl1hX1neo8QMsqvuWFLOGESXwKj3yYcTrZ1nB1xciINi8R3wNka53geWELM
 oTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=zuNk7v+IEG1NX946w4US+NnSDslhmTRg4grXH/qysdU=;
 b=TFhqeRZx3cA66x/TCX3O756FmbaSWqE4L45wDfJ/acuzXcSyE4BvctgSKCBj9MZ8JU
 rrnF/bYb7tTL9OKdtCfglyfOTwLVvTdErbtCaWW9tE/J3v0XD8JQ3r/d241Aiv4UvUMn
 YT87KbcQQBKwdXp0jYjC0qUW5u4+Eryp4HQENtudqhNRecA4/ePR3QMKzWFUobv+S4JB
 gcWNUT4PqXFJz+nLnbC8lbbQM22ceWX8RmoYzY2gfMoVkOwo4jKU7YEmHhl73jcIsqEm
 HOaXveIylXIITAzy+pzx1IBfvmPIdYxx0sGDx7vkZ2Sy6XrQzeGTF7n+HtI5wI3uHM89
 OLAg==
X-Gm-Message-State: AOAM533jsqTtcu+Q+YMroOFjTvtY9jCqKZFC2RADTPSfb4IGAXjeyqMf
 LXggSuPbBUlNR+ooXwJwv6IEfVkyH3KtEHyOQqU=
X-Google-Smtp-Source: ABdhPJxaBO/UIAe6yxemUUFv81+VfrrCMuo8TAPHXZ2FfWsCSwXHDNrOJkZvjpy+oqCqH7Le8bxbI0f2juscaPw6kyY=
X-Received: by 2002:a2e:7315:: with SMTP id o21mr938830ljc.120.1598460720926; 
 Wed, 26 Aug 2020 09:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <20200826143651.7915-13-eperezma@redhat.com>
In-Reply-To: <20200826143651.7915-13-eperezma@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 27 Aug 2020 00:51:48 +0800
Message-ID: <CAE2XoE9kFuavzHzTWvCony77iHk1_+kjrYj-budDVTdgKfTeaQ@mail.gmail.com>
Subject: Re: [RFC v6 12/13] intel_iommu: Do not notify regular iotlb to
 device-iotlb notifiers
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000755af905adcaa32b"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
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
Reply-To: luoyonggang@gmail.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000755af905adcaa32b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 10:42 PM Eugenio P=C3=A9rez <eperezma@redhat.com> w=
rote:

> This improves performance in case of netperf with vhost-net:
> * TCP_STREAM: From 9049.59Mbit/s to 9049.59Mbit/s (13%)
>
What's improvement ? they are the same


> * TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)
> * UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)
> * UDP_STREAM: No change observed (insignificant 0.1% improvement)
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  hw/i386/intel_iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ddb828da1f..7620a1abbf 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1960,6 +1960,12 @@ static void
> vtd_iotlb_domain_invalidate(IntelIOMMUState *s, uint16_t domain_id)
>      vtd_iommu_unlock(s);
>
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> +        if (vtd_as->iommu.iommu_notify_flags & IOMMU_NOTIFIER_DEVIOTLB) =
{
> +            /* If IOMMU memory region is DEVICE IOTLB type, it does not
> make
> +             * sense to send regular IOMMU notifications. */
> +            continue;
> +        }
> +
>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                        vtd_as->devfn, &ce) &&
>              domain_id =3D=3D vtd_get_domain_id(s, &ce)) {
> --
> 2.18.1
>
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000755af905adcaa32b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 10:42 PM Euge=
nio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.com">eperezma@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">This improves performance in case of netperf with vhost-net:<br>
* TCP_STREAM: From 9049.59Mbit/s to 9049.59Mbit/s (13%)<br></blockquote><di=
v>What&#39;s improvement ? they are the same</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
* TCP_RR: From 8464.73 trans/s to 8932.703333 trans/s (5.5%)<br>
* UDP_RR: From 8562.08 trans/s to 9005.62/s (5.1%)<br>
* UDP_STREAM: No change observed (insignificant 0.1% improvement)<br>
<br>
Signed-off-by: Eugenio P=C3=A9rez &lt;<a href=3D"mailto:eperezma@redhat.com=
" target=3D"_blank">eperezma@redhat.com</a>&gt;<br>
---<br>
=C2=A0hw/i386/intel_iommu.c | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index ddb828da1f..7620a1abbf 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -1960,6 +1960,12 @@ static void vtd_iotlb_domain_invalidate(IntelIOMMUSt=
ate *s, uint16_t domain_id)<br>
=C2=A0 =C2=A0 =C2=A0vtd_iommu_unlock(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0QLIST_FOREACH(vtd_as, &amp;s-&gt;vtd_as_with_notifiers,=
 next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vtd_as-&gt;iommu.iommu_notify_flags &amp; =
IOMMU_NOTIFIER_DEVIOTLB) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* If IOMMU memory region is DEV=
ICE IOTLB type, it does not make<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* sense to send regular IO=
MMU notifications. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!vtd_dev_to_context_entry(s, pci_bus_=
num(vtd_as-&gt;bus),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vtd_as-&g=
t;devfn, &amp;ce) &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0domain_id =3D=3D vtd_get_do=
main_id(s, &amp;ce)) {<br>
-- <br>
2.18.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000755af905adcaa32b--

