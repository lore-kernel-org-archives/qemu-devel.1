Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678EBC17461
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3035121D71
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 13:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/M2TI48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3035121D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyjN-0006Wk-BN
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 08:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37168)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iRyiY-000650-7S
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:17:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iRyiW-0004wq-86
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:17:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31516
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iRyiW-0004vC-3I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 08:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572959868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=njHSL9lZ4KlF5h0HfYCXqB7KQxlUvSyhj2lYrDvrpjY=;
 b=E/M2TI48UbROgvAADRkLAAAbxkzU5noGEH8avKZ9VH/GTJZcUu1tSzEVZoasxDPeGiZA7H
 yeVKrkFFiF1Lwn9dRP7AY1i4GXm1Hiew5RvBI5Og/xRKjVDTCl8xfoZtMgDzxBmuZsz+q2
 HFIqfhBe+ZNygdzVIBxbxsWFMTXIQ3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-wp4AkiavNPuWj1W4Lbijlw-1; Tue, 05 Nov 2019 08:17:45 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57633800C73;
 Tue,  5 Nov 2019 13:17:44 +0000 (UTC)
Received: from [10.36.116.54] (ovpn-116-54.ams2.redhat.com [10.36.116.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5C575D726;
 Tue,  5 Nov 2019 13:17:39 +0000 (UTC)
Subject: Re: Questions about the VFIO BAR region
To: Li Qiang <liq3ea@gmail.com>, Alex Williamson <alex.williamson@redhat.com>
References: <5DC05485.008EAA.00665@m12-12.163.com>
 <20191104114857.74fe9222@x1.home>
 <CAKXe6SJKP94eKw+7w4ucFsDQW0GZ7E4SLNekECyJXm0rZa6GHQ@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <60808bdc-9b0e-3cf3-df6c-fd9f71ff58c7@redhat.com>
Date: Tue, 5 Nov 2019 14:17:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJKP94eKw+7w4ucFsDQW0GZ7E4SLNekECyJXm0rZa6GHQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: wp4AkiavNPuWj1W4Lbijlw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Li Qiang <liq3ea@163.com>, Alex Williamson <alex.l.williamson@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Li,

On 11/5/19 2:16 AM, Li Qiang wrote:
>=20
>=20
> Alex Williamson <alex.williamson@redhat.com
> <mailto:alex.williamson@redhat.com>> =E4=BA=8E2019=E5=B9=B411=E6=9C=885=
=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=882:49=E5=86=99=E9=81=93=EF=BC=
=9A
>=20
>     On Tue, 5 Nov 2019 00:40:39 +0800
>     Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>> wrote:
>=20
>     > Hello Alex, Auger and all,
>     >
>     > I have a question about the VFIO virtual device BAR.
>     >
>     > In vfio_region_setup, it initialize a =E2=80=98region->mem=E2=80=99=
 MR and set its
>     ops to =E2=80=98vfio_regions_ops=E2=80=99.
>     > In =E2=80=98vfio_region_mmap=E2=80=99, it maps the physical device=
=E2=80=99s MMIO to
>     QEMU=E2=80=99s virtual address space
>     > as a raw MR =E2=80=98region->mmaps[i].mem=E2=80=99.
>     > And also it set the latter MR as a subregion of the first one.
>     >
>     > So when the guest accesses the BAR, it will direct go to the
>     physical device=E2=80=99s BAR.
>     > My question is here:
>     > When the qemu will use the =E2=80=98vfio_regions_ops=E2=80=99 to re=
ad/write the BAR?
>     > Also whey in the last of =E2=80=98vfio_region_write/read=E2=80=99 w=
e need to call
>     =E2=80=98vbasedev->ops->vfio_eoi(vbasedev);=E2=80=99?
>=20
>     We support:
>=20
>     =C2=A0a) sparse mmaps where the entire BAR is not covered by an mmap
>=20
>=20
> Got.
>=20
> =C2=A0
>=20
>     =C2=A0b) quirks, which layer on top of the mmaps to provide virtualiz=
ed
>     =C2=A0 =C2=A0 access
>=20
>=20
> Do you mean like in 'vfio_probe_ati_bar4_quirk', register a high
> priority subregion of VFIORegion.mem.
> So when the guest write the BAR, vfio_regions_ops will be used. Here
> 'quirks' do you mean such things?
>=20
> static void vfio_probe_ati_bar4_quirk(VFIOPCIDevice *vdev, int nr)
> {
> =C2=A0 =C2=A0 VFIOQuirk *quirk;
> =C2=A0 =C2=A0 VFIOConfigWindowQuirk *window;
>=20
> =C2=A0 =C2=A0 ...
> =C2=A0 =C2=A0 memory_region_init_io(window->addr_mem, OBJECT(vdev),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &vfio_generic_window_address_quirk, window,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 "vfio-ati-bar4-window-address-quirk", 4);
> =C2=A0 =C2=A0 memory_region_add_subregion_overlap(vdev->bars[nr].region.m=
em,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 window->=
address_offset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 window->=
addr_mem, 1);
> =C2=A0 =C2=A0...
> }
Yes that's it. In that case vfio_generic_window_address_quirk ops get
called when attempting to access this overlapping region.
>=20
> =C2=A0
>=20
>     =C2=A0c) INTx emulation which disables mmaps MRs in order to detect d=
evice
>     =C2=A0 =C2=A0 access as a generic mechanism for inferring interrupt
>     =C2=A0 =C2=A0 acknowledgment.
>=20
>=20
> In the above two cases, in 'vfio_region_write/read' we always access the
> physical device's BAR.
> So as far as I can understand, the physical device(sometimes) will
> trigger interrupts. And the responsible of clear it=C2=A0
> will be by the 'guest'. So I can't understand why there calls
> 'vbasedev->ops->vfio_eoi'. Could you please give me an
> example.
When a physical level sensitive IRQ hits it is signaled through an
eventfd. The eventfd can be handled by QEMU. In this case,
vfio_intx_interrupt gets called, for PCI. It turns the mmap off (slow
path on) and injects the corresponding virtual IRQ into the guest. The
reason why we turn the mmap off is we need to trap the guest end of
interrupt to eventually deactivate the IRQ at physical level and unmask
it (it was auto-masked by the vfio driver). The first access into the
region is assumed to correspond to the servicing of the pending
interrupt by the guest handler (pending status clear) and at this point
we deactivate the physical IRQ. So .vfio_eoi gets called on the first
read/write BAR access after an INTx gets pending. Note the mmapping
(fast path) is not immediatly turned on after deactivating the physical
INTx. See comment before vfio_intx_mmap_enable.

When an irqfd/resamplefd is used we do not need that trick as the guest
EOI is trapped at KVM level through the virtual interrupt controller.
when the guest EOI is trapped KVM deactivates the associated physical
IRQ and notifies the userspace through the resamplefd for this latter to
unmask the physical IRQ.

Hope this helps.

Thanks

Eric




>=20
>=20
> Thanks,
> Li Qiang
>=20
> =C2=A0
>=20
>=20
>     The latter being the reason we call vfio_eoi.=C2=A0 Thanks,
>=20
>     Alex
>=20


