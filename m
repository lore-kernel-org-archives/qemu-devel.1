Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292CECA9ED3
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 01:17:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E687B2080F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 01:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdz0mbNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E687B2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRnTn-0000M9-10
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 20:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iRnSc-0008OZ-68
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 20:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iRnSa-0008SI-Ca
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 20:16:41 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iRnSa-0008Q1-4g
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 20:16:40 -0500
Received: by mail-oi1-x230.google.com with SMTP id y194so16032941oie.4
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2019 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5+VoSIUci//6fhE8bGmL4BERSeWlImzuc2U42mIdSMk=;
 b=qdz0mbNBqFRirIc83RXZywSOLa2PoQvvt6gJyoLOL9sAINknV/1iUyFkO0sPVuR6g8
 TBr3aPUt3Rvbe5U+zwZlFyO8USoYZy0WU25SnhI74DAxqes+nMfsx+S5hUqLvl7/IIdw
 BrtF/dolVEsADcnvV4Sw8++6xHziBSbNK1w//Zd6uOAJRTlLwsUofjyEreVsOV5srQzh
 6MYFwdYFf6mcoRbwEyuKvZhpixd72+euTUtTTBVJt4PxTI+GmMrnYWMUfi0IhQiOeNKP
 hGGGOv+KuYjweKSVid0oM8d59tSq5u5rSK2GcVAPqpUqHeaTONvBE6Ej5R4gjZKeSXIr
 ESFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5+VoSIUci//6fhE8bGmL4BERSeWlImzuc2U42mIdSMk=;
 b=eqG/ocDU9ZGrUILL9l0Oy2vGGH0nuDpWw0YYTP281v3ziG613/L5fct9ffGKoChujP
 506xxyZHM0xS3DZh3pPQMRZa8KoY9hInCNHKfMU0aj4ZJFXxQBkm6tviB/ZaCOoWVBwb
 RybOmFoVEZXdxqGvBPAFTTMLH2Oc7aG9G8CsMtOWfmM572tjo9nP2q2meDmcjP4aa+DR
 1makZX9sEIxW0SpZYlogVi+X7AVPcYxPBi0ximYuUcw1fiHrZD7pW4jTyKUp8wxHL5Nj
 wrfJGzMnL3wifDV7ir0hCw/PnYrrtQCSX9+4dVmf3qhO/ja/50SEbUzOIi5f7m76DcYg
 DuUg==
X-Gm-Message-State: APjAAAWvHUny8asZlV5wIzEEKI+i3eh7itTzmAP9b8j2gKjEIKY/aT+h
 +rdqUgs1vjxkg1Kc1uJFOVn0mGvV5CYWrJHp5Ws=
X-Google-Smtp-Source: APXvYqwdBAqqpEU2Ax4iNnrRCeOvZH3R7oW7MYjqQkOfg2erRp61GuOJi/Xl6EUw8TDHO0ZoD0D26R0ejGORnc1+Vdw=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr1669964oig.157.1572916597912; 
 Mon, 04 Nov 2019 17:16:37 -0800 (PST)
MIME-Version: 1.0
References: <5DC05485.008EAA.00665@m12-12.163.com>
 <20191104114857.74fe9222@x1.home>
In-Reply-To: <20191104114857.74fe9222@x1.home>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 5 Nov 2019 09:16:01 +0800
Message-ID: <CAKXe6SJKP94eKw+7w4ucFsDQW0GZ7E4SLNekECyJXm0rZa6GHQ@mail.gmail.com>
Subject: Re: Questions about the VFIO BAR region
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000147e2a05968f2fcd"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
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
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>, Li Qiang <liq3ea@163.com>,
 Alex Williamson <alex.l.williamson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000147e2a05968f2fcd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Alex Williamson <alex.williamson@redhat.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:49=E5=86=99=E9=81=93=EF=
=BC=9A

> On Tue, 5 Nov 2019 00:40:39 +0800
> Li Qiang <liq3ea@163.com> wrote:
>
> > Hello Alex, Auger and all,
> >
> > I have a question about the VFIO virtual device BAR.
> >
> > In vfio_region_setup, it initialize a =E2=80=98region->mem=E2=80=99 MR =
and set its ops
> to =E2=80=98vfio_regions_ops=E2=80=99.
> > In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical device=E2=
=80=99s MMIO to QEMU=E2=80=99s
> virtual address space
> > as a raw MR =E2=80=98region->mmaps[i].mem=E2=80=99.
> > And also it set the latter MR as a subregion of the first one.
> >
> > So when the guest accesses the BAR, it will direct go to the physical
> device=E2=80=99s BAR.
> > My question is here:
> > When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to read/w=
rite the BAR?
> > Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99 we ne=
ed to call
> =E2=80=98vbasedev->ops->vfio_eoi(vbasedev);=E2=80=99?
>
> We support:
>
>  a) sparse mmaps where the entire BAR is not covered by an mmap
>

Got.



>  b) quirks, which layer on top of the mmaps to provide virtualized
>     access
>

Do you mean like in 'vfio_probe_ati_bar4_quirk', register a high priority
subregion of VFIORegion.mem.
So when the guest write the BAR, vfio_regions_ops will be used. Here
'quirks' do you mean such things?

static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
{
    VFIOQuirk *quirk;
    VFIOConfigWindowQuirk *window;

    ...
    memory_region_init_io(window->addr_mem, OBJECT(vdev),
                          &vfio_generic_window_address_quirk, window,
                          "vfio-ati-bar4-window-address-quirk", 4);
    memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
                                        window->address_offset,
                                        window->addr_mem, 1);
   ...
}



>  c) INTx emulation which disables mmaps MRs in order to detect device
>     access as a generic mechanism for inferring interrupt
>     acknowledgment.
>

In the above two cases, in 'vfio_region_write/read' we always access the
physical device's BAR.
So as far as I can understand, the physical device(sometimes) will trigger
interrupts. And the responsible of clear it
will be by the 'guest'. So I can't understand why there calls
'vbasedev->ops->vfio_eoi'. Could you please give me an
example.


Thanks,
Li Qiang



>
> The latter being the reason we call vfio_eoi.  Thanks,
>
> Alex
>
>

--000000000000147e2a05968f2fcd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Alex Williamson &lt;<a href=3D"mailto=
:alex.williamson@redhat.com">alex.williamson@redhat.com</a>&gt; =E4=BA=8E20=
19=E5=B9=B411=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:49=
=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">On Tue, 5 Nov 2019 00:40:39 +0800<br>
Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com" target=3D"_blank">liq3ea@163=
.com</a>&gt; wrote:<br>
<br>
&gt; Hello Alex, Auger and all,<br>
&gt; <br>
&gt; I have a question about the VFIO virtual device BAR.<br>
&gt; <br>
&gt; In vfio_region_setup, it initialize a =E2=80=98region-&gt;mem=E2=80=99=
 MR and set its ops to =E2=80=98vfio_regions_ops=E2=80=99. <br>
&gt; In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical device=E2=
=80=99s MMIO to QEMU=E2=80=99s virtual address space <br>
&gt; as a raw MR =E2=80=98region-&gt;mmaps[i].mem=E2=80=99. <br>
&gt; And also it set the latter MR as a subregion of the first one.<br>
&gt; <br>
&gt; So when the guest accesses the BAR, it will direct go to the physical =
device=E2=80=99s BAR.<br>
&gt; My question is here:<br>
&gt; When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to read/=
write the BAR?<br>
&gt; Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99 we n=
eed to call =E2=80=98vbasedev-&gt;ops-&gt;vfio_eoi(vbasedev);=E2=80=99?<br>
<br>
We support:<br>
<br>
=C2=A0a) sparse mmaps where the entire BAR is not covered by an mmap<br></b=
lockquote><div><br></div><div>Got.</div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0b) quirks, which layer on top of the mmaps to provide virtualized<br>
=C2=A0 =C2=A0 access<br></blockquote><div><br></div><div>Do you mean like i=
n &#39;vfio_probe_ati_bar4_quirk&#39;, register a high priority subregion o=
f VFIORegion.mem.</div><div>So when the guest write the BAR, vfio_regions_o=
ps will be used. Here &#39;quirks&#39; do you mean such things?</div><div><=
br></div><div>static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, in=
t nr)<br>{<br>=C2=A0 =C2=A0 VFIOQuirk *quirk;<br>=C2=A0 =C2=A0 VFIOConfigWi=
ndowQuirk *window;<br><br>=C2=A0 =C2=A0 ...<br>=C2=A0 =C2=A0 memory_region_=
init_io(window-&gt;addr_mem, OBJECT(vdev),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;vfio_ge=
neric_window_address_quirk, window,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;vfio-ati-bar4=
-window-address-quirk&quot;, 4);<br>=C2=A0 =C2=A0 memory_region_add_subregi=
on_overlap(vdev-&gt;bars[nr].region.mem,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 window-&gt;address_offset,<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 window-&gt;addr_mem=
, 1);<br></div><div>=C2=A0 =C2=A0...</div><div>}</div><div><br></div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0c) INTx emulation which disables mmaps MRs in order to detect device<=
br>
=C2=A0 =C2=A0 access as a generic mechanism for inferring interrupt<br>
=C2=A0 =C2=A0 acknowledgment.<br></blockquote><div><br></div><div>In the ab=
ove two cases, in &#39;vfio_region_write/read&#39; we always access the phy=
sical device&#39;s BAR.</div><div>So as far as I can understand, the physic=
al device(sometimes) will trigger interrupts. And the responsible of clear =
it=C2=A0</div><div>will be by the &#39;guest&#39;. So I can&#39;t understan=
d why there calls &#39;vbasedev-&gt;ops-&gt;vfio_eoi&#39;. Could you please=
 give me an</div><div>example.</div><div><br></div><div><br></div><div>Than=
ks,</div><div>Li Qiang</div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
<br>
The latter being the reason we call vfio_eoi.=C2=A0 Thanks,<br>
<br>
Alex<br>
<br>
</blockquote></div></div>

--000000000000147e2a05968f2fcd--

