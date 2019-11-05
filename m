Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2417CC1747C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:45:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D419D2190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azitTy8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D419D2190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRz9N-0007IJ-WD
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iRz8c-0006r3-I7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iRz8a-0001Xk-HX
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:44:50 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:39691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iRz8a-0001XY-9b
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:44:48 -0500
Received: by mail-oi1-x22a.google.com with SMTP id v138so17525679oif.6
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 05:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/ts4WNIWc3gjpfUlq4ngqbZ8UpwHaH5X+jpdJ8J99E0=;
 b=azitTy8WSuzVcMsj0pmPUblsusrepwE5DOZcCy4nJj2oC+IYBIIYlGmQs2YQViE6Th
 sR4Yl7j9CwpJqkpdjswVraqTEa3bpHjw1dcyUVvzPF9C6D8JjmmL2P+1XaxjrJv9N8YB
 AlGPYydJvlPQFa1lSddiuTHr4WKjesz5w4h9RoVAyxMqfOHOUI1H9ODuKBalpvU5htmg
 4U7lnAme46cP/xDoP4ZJKIjq0cc7u8BcrM0RpecfFNDlPXkXh99r8GWrDd3ugYYHvyq0
 iZS+9c78ukp0AYwcSNScSRLfOqWtDT7JlOemI1R8DrywCtnw8ALlLYxIfmZoYpbAbznl
 MwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/ts4WNIWc3gjpfUlq4ngqbZ8UpwHaH5X+jpdJ8J99E0=;
 b=NPk5h+PWwYZDqsfapakjy3kjloVmpuRtWJCk9jQKWq+h2/LaG3AzTV5FChwYDPbbp7
 ZezPOFLz/OaixCHbVEgUtc4B5wWjyb6O5XJmQkRyWeraeHD/NokvfOm4eINlVLhgRv7j
 /Tm/ChzqTX+9rgMpisH1s53tW7JlcKwjtSMjZNqmV5PIJv+95hxp328KrTsrF0HbySTC
 CXkCsOkxPy+P/UOBc0V6zQjNDK1XgfjtAzVVbuAQ0nPTFjjC+DW5hEnxvfqVpdiauY1h
 wZu4P7aheaqIv8mR5E0limikfT/QIcbC2rMSzywq6F22wlNzGcLVkItbKRnpBq8tDwNp
 ktvQ==
X-Gm-Message-State: APjAAAX6GuG1h7pPL2sOhf5ZCp57w0k3Z1nH0S9ph180V2/3W2Hungda
 7gg2aWgXXQi2ABl5RSDpH+L9BbxKKGpNUDjNWI0=
X-Google-Smtp-Source: APXvYqxvq2eKrXOuDhyEvipIF4O0psDfTawtCg+J43d650H61DXEbhgoijKAkttUZhjqNNGl+gnivHi/i3K+rbbCh0w=
X-Received: by 2002:aca:42d7:: with SMTP id p206mr4064701oia.129.1572961487351; 
 Tue, 05 Nov 2019 05:44:47 -0800 (PST)
MIME-Version: 1.0
References: <5DC05485.008EAA.00665@m12-12.163.com>
 <20191104114857.74fe9222@x1.home>
 <CAKXe6SJKP94eKw+7w4ucFsDQW0GZ7E4SLNekECyJXm0rZa6GHQ@mail.gmail.com>
 <60808bdc-9b0e-3cf3-df6c-fd9f71ff58c7@redhat.com>
In-Reply-To: <60808bdc-9b0e-3cf3-df6c-fd9f71ff58c7@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 5 Nov 2019 21:44:10 +0800
Message-ID: <CAKXe6SLz6h4=ME4Y96b-5JTu29ec+Oyioui8kTFcayy34juWiQ@mail.gmail.com>
Subject: Re: Questions about the VFIO BAR region
To: Auger Eric <eric.auger@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b2f5a7059699a2e0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Alex Williamson <alex.williamson@redhat.com>, Li Qiang <liq3ea@163.com>,
 Alex Williamson <alex.l.williamson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2f5a7059699a2e0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Auger Eric <eric.auger@redhat.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=885=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:17=E5=86=99=E9=81=93=EF=BC=9A

> Hi Li,
>
> On 11/5/19 2:16 AM, Li Qiang wrote:
> >
> >
> > Alex Williamson <alex.williamson@redhat.com
> > <mailto:alex.williamson@redhat.com>> =E4=BA=8E2019=E5=B9=B411=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:49=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> >     On Tue, 5 Nov 2019 00:40:39 +0800
> >     Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>> wrote:
> >
> >     > Hello Alex, Auger and all,
> >     >
> >     > I have a question about the VFIO virtual device BAR.
> >     >
> >     > In vfio_region_setup, it initialize a =E2=80=98region->mem=E2=80=
=99 MR and set its
> >     ops to =E2=80=98vfio_regions_ops=E2=80=99.
> >     > In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical devic=
e=E2=80=99s MMIO to
> >     QEMU=E2=80=99s virtual address space
> >     > as a raw MR =E2=80=98region->mmaps[i].mem=E2=80=99.
> >     > And also it set the latter MR as a subregion of the first one.
> >     >
> >     > So when the guest accesses the BAR, it will direct go to the
> >     physical device=E2=80=99s BAR.
> >     > My question is here:
> >     > When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to =
read/write the
> BAR?
> >     > Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99=
 we need to call
> >     =E2=80=98vbasedev->ops->vfio_eoi(vbasedev);=E2=80=99?
> >
> >     We support:
> >
> >      a) sparse mmaps where the entire BAR is not covered by an mmap
> >
> >
> > Got.
> >
> >
> >
> >      b) quirks, which layer on top of the mmaps to provide virtualized
> >         access
> >
> >
> > Do you mean like in 'vfio_probe_ati_bar4_quirk', register a high
> > priority subregion of VFIORegion.mem.
> > So when the guest write the BAR, vfio_regions_ops will be used. Here
> > 'quirks' do you mean such things?
> >
> > static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> > {
> >     VFIOQuirk *quirk;
> >     VFIOConfigWindowQuirk *window;
> >
> >     ...
> >     memory_region_init_io(window->addr_mem, OBJECT(vdev),
> >                           &vfio_generic_window_address_quirk, window,
> >                           "vfio-ati-bar4-window-address-quirk", 4);
> >     memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
> >                                         window->address_offset,
> >                                         window->addr_mem, 1);
> >    ...
> > }
> Yes that's it. In that case vfio_generic_window_address_quirk ops get
> called when attempting to access this overlapping region.
> >
> >
> >
> >      c) INTx emulation which disables mmaps MRs in order to detect devi=
ce
> >         access as a generic mechanism for inferring interrupt
> >         acknowledgment.
> >
> >
> > In the above two cases, in 'vfio_region_write/read' we always access th=
e
> > physical device's BAR.
> > So as far as I can understand, the physical device(sometimes) will
> > trigger interrupts. And the responsible of clear it
> > will be by the 'guest'. So I can't understand why there calls
> > 'vbasedev->ops->vfio_eoi'. Could you please give me an
> > example.
> When a physical level sensitive IRQ hits it is signaled through an
> eventfd. The eventfd can be handled by QEMU. In this case,
> vfio_intx_interrupt gets called, for PCI. It turns the mmap off (slow
> path on) and injects the corresponding virtual IRQ into the guest. The
> reason why we turn the mmap off is we need to trap the guest end of
> interrupt to eventually deactivate the IRQ at physical level and unmask
> it (it was auto-masked by the vfio driver). The first access into the
> region is assumed to correspond to the servicing of the pending
> interrupt by the guest handler (pending status clear) and at this point
> we deactivate the physical IRQ. So .vfio_eoi gets called on the first
> read/write BAR access after an INTx gets pending. Note the mmapping
> (fast path) is not immediatly turned on after deactivating the physical
> INTx. See comment before vfio_intx_mmap_enable.
>
> When an irqfd/resamplefd is used we do not need that trick as the guest
> EOI is trapped at KVM level through the virtual interrupt controller.
> when the guest EOI is trapped KVM deactivates the associated physical
> IRQ and notifies the userspace through the resamplefd for this latter to
> unmask the physical IRQ.
>
> Hope this helps.
>


Thank you Auger, very detailed information.

Thanks,
Li Qiang



>
> Thanks
>
> Eric
>
>
>
>
> >
> >
> > Thanks,
> > Li Qiang
> >
> >
> >
> >
> >     The latter being the reason we call vfio_eoi.  Thanks,
> >
> >     Alex
> >
>
>

--000000000000b2f5a7059699a2e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Auger Eric &lt;<a href=3D"mailto:eric=
.auger@redhat.com">eric.auger@redhat.com</a>&gt; =E4=BA=8E2019=E5=B9=B411=
=E6=9C=885=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:17=E5=86=99=E9=81=
=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi =
Li,<br>
<br>
On 11/5/19 2:16 AM, Li Qiang wrote:<br>
&gt; <br>
&gt; <br>
&gt; Alex Williamson &lt;<a href=3D"mailto:alex.williamson@redhat.com" targ=
et=3D"_blank">alex.williamson@redhat.com</a><br>
&gt; &lt;mailto:<a href=3D"mailto:alex.williamson@redhat.com" target=3D"_bl=
ank">alex.williamson@redhat.com</a>&gt;&gt; =E4=BA=8E2019=E5=B9=B411=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:49=E5=86=99=E9=81=93=EF=
=BC=9A<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Tue, 5 Nov 2019 00:40:39 +0800<br>
&gt;=C2=A0 =C2=A0 =C2=A0Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com" targ=
et=3D"_blank">liq3ea@163.com</a> &lt;mailto:<a href=3D"mailto:liq3ea@163.co=
m" target=3D"_blank">liq3ea@163.com</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hello Alex, Auger and all,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I have a question about the VFIO virtual devic=
e BAR.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; In vfio_region_setup, it initialize a =E2=80=
=98region-&gt;mem=E2=80=99 MR and set its<br>
&gt;=C2=A0 =C2=A0 =C2=A0ops to =E2=80=98vfio_regions_ops=E2=80=99.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; In =E2=80=98vfio_region_mmap=E2=80=99, it maps=
 the physical device=E2=80=99s MMIO to<br>
&gt;=C2=A0 =C2=A0 =C2=A0QEMU=E2=80=99s virtual address space<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; as a raw MR =E2=80=98region-&gt;mmaps[i].mem=
=E2=80=99.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; And also it set the latter MR as a subregion o=
f the first one.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So when the guest accesses the BAR, it will di=
rect go to the<br>
&gt;=C2=A0 =C2=A0 =C2=A0physical device=E2=80=99s BAR.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; My question is here:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; When the qemu will use the =E2=80=98vfio_regio=
ns_ops=E2=80=99 to read/write the BAR?<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Also whey in the last of =E2=80=98vfio_region_=
write/read=E2=80=99 we need to call<br>
&gt;=C2=A0 =C2=A0 =C2=A0=E2=80=98vbasedev-&gt;ops-&gt;vfio_eoi(vbasedev);=
=E2=80=99?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0We support:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0a) sparse mmaps where the entire BAR is not c=
overed by an mmap<br>
&gt; <br>
&gt; <br>
&gt; Got.<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0b) quirks, which layer on top of the mmaps to=
 provide virtualized<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 access<br>
&gt; <br>
&gt; <br>
&gt; Do you mean like in &#39;vfio_probe_ati_bar4_quirk&#39;, register a hi=
gh<br>
&gt; priority subregion of VFIORegion.mem.<br>
&gt; So when the guest write the BAR, vfio_regions_ops will be used. Here<b=
r>
&gt; &#39;quirks&#39; do you mean such things?<br>
&gt; <br>
&gt; static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)<br>
&gt; {<br>
&gt; =C2=A0 =C2=A0 VFIOQuirk *quirk;<br>
&gt; =C2=A0 =C2=A0 VFIOConfigWindowQuirk *window;<br>
&gt; <br>
&gt; =C2=A0 =C2=A0 ...<br>
&gt; =C2=A0 =C2=A0 memory_region_init_io(window-&gt;addr_mem, OBJECT(vdev),=
<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &amp;vfio_generic_window_address_quirk, window,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;vfio-ati-bar4-window-address-quirk&quot;, 4);<br=
>
&gt; =C2=A0 =C2=A0 memory_region_add_subregion_overlap(vdev-&gt;bars[nr].re=
gion.mem,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 windo=
w-&gt;address_offset,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 windo=
w-&gt;addr_mem, 1);<br>
&gt; =C2=A0 =C2=A0...<br>
&gt; }<br>
Yes that&#39;s it. In that case vfio_generic_window_address_quirk ops get<b=
r>
called when attempting to access this overlapping region.<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0c) INTx emulation which disables mmaps MRs in=
 order to detect device<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 access as a generic mechanism for inf=
erring interrupt<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 acknowledgment.<br>
&gt; <br>
&gt; <br>
&gt; In the above two cases, in &#39;vfio_region_write/read&#39; we always =
access the<br>
&gt; physical device&#39;s BAR.<br>
&gt; So as far as I can understand, the physical device(sometimes) will<br>
&gt; trigger interrupts. And the responsible of clear it=C2=A0<br>
&gt; will be by the &#39;guest&#39;. So I can&#39;t understand why there ca=
lls<br>
&gt; &#39;vbasedev-&gt;ops-&gt;vfio_eoi&#39;. Could you please give me an<b=
r>
&gt; example.<br>
When a physical level sensitive IRQ hits it is signaled through an<br>
eventfd. The eventfd can be handled by QEMU. In this case,<br>
vfio_intx_interrupt gets called, for PCI. It turns the mmap off (slow<br>
path on) and injects the corresponding virtual IRQ into the guest. The<br>
reason why we turn the mmap off is we need to trap the guest end of<br>
interrupt to eventually deactivate the IRQ at physical level and unmask<br>
it (it was auto-masked by the vfio driver). The first access into the<br>
region is assumed to correspond to the servicing of the pending<br>
interrupt by the guest handler (pending status clear) and at this point<br>
we deactivate the physical IRQ. So .vfio_eoi gets called on the first<br>
read/write BAR access after an INTx gets pending. Note the mmapping<br>
(fast path) is not immediatly turned on after deactivating the physical<br>
INTx. See comment before vfio_intx_mmap_enable.<br>
<br>
When an irqfd/resamplefd is used we do not need that trick as the guest<br>
EOI is trapped at KVM level through the virtual interrupt controller.<br>
when the guest EOI is trapped KVM deactivates the associated physical<br>
IRQ and notifies the userspace through the resamplefd for this latter to<br=
>
unmask the physical IRQ.<br>
<br>
Hope this helps.<br></blockquote><div><br></div><div><br></div><div>Thank y=
ou Auger, very detailed information.</div><div><br></div><div>Thanks,</div>=
<div>Li Qiang</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
<br>
Thanks<br>
<br>
Eric<br>
<br>
<br>
<br>
<br>
&gt; <br>
&gt; <br>
&gt; Thanks,<br>
&gt; Li Qiang<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0The latter being the reason we call vfio_eoi.=C2=A0=
 Thanks,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Alex<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000b2f5a7059699a2e0--

