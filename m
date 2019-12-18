Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28672C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6DAF20715
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 05:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cx0hwW8j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6DAF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihRtQ-0007Df-4q
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 00:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50119)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihRsT-0006mb-I2
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihRsP-0003C2-8S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:28:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihRsO-00038m-Kf
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 00:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576646878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mf+bo4pTCHHInnjJJGsBrZAqzkyFAFP/ocxxfZC3cfg=;
 b=Cx0hwW8jCKGnRfoL+/XCtWuK2Frv8BEOAVe/B8kDxvBbsk7w57+03/pM5y6dirEnn51ow5
 FVQKefbCyuuwLRpWYwSCA8wLadfb5qo/crkU66VOh99lPaNwIP0tvs7QYrUPsM7AMUGFaD
 F/1Ys8I+k3aXu5rFyhkY3I7pikWpt3o=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137--htE2YhJMviLl_TTB2GETA-1; Wed, 18 Dec 2019 00:27:54 -0500
Received: by mail-qv1-f71.google.com with SMTP id l1so652412qvu.13
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 21:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KghVE9DYER33JoAaIoikRdmM/HUj5yizkCE5FYd5LU4=;
 b=EfR+BLvUklM2nMi0/g4u8bmOTr52xs5+BMBJ6ZT4OPUDrSDZ/svKCpoVg6CTMqHSsM
 4rWBjC8B4uv3BzI1g367MAjYfdn1QUqq77y9RVhjfCAGuEqq28IWXO/TR+QApq9nv+tX
 7dvjXN7XEqZA1HcXRlJt0guiqIHwewJKuDeM3hZTjmLF6ZSf193YvIvxe7hu2dYFX5Vo
 FJW3sgNJyTy9H9P2PlUJ5+XQGWuHhFogDhI6SH3Ruqh6FDMCACd89mZ6hCHtJUmovuEl
 9pTh8o8C6hkhGst3dbmKCmZJ4QeQYF6/e6Q9RZa81A8LZ16XQ3tnh2gm9EXnyC1AO0E1
 Wrxw==
X-Gm-Message-State: APjAAAXIAVzD1cueZvPmA/7cH0SGgxEOmKQIU3BgUzX5tSejxZeFtcxJ
 wAxfQArSyPva+kpNIlsJxSwAkgZSuBpugjBrOXnwCCsYMwirYHCha2eMmxkLaIb8yxpz4mjH+RE
 Z20z592GQ3GNKSEs=
X-Received: by 2002:ad4:49cc:: with SMTP id j12mr690889qvy.188.1576646874032; 
 Tue, 17 Dec 2019 21:27:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzGV6B/TRxagNKGwa0qK1HTzGwT0AExZKP1c7tqjFeZdID009YY2fOk+T2CbL2pqSwwtYz3jA==
X-Received: by 2002:ad4:49cc:: with SMTP id j12mr690880qvy.188.1576646873757; 
 Tue, 17 Dec 2019 21:27:53 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id r20sm406991qtp.41.2019.12.17.21.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2019 21:27:52 -0800 (PST)
Date: Wed, 18 Dec 2019 00:27:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: virtio capabilities
Message-ID: <20191218002721-mutt-send-email-mst@kernel.org>
References: <823b58f1-f17e-6645-11be-406ad1494e06@ozlabs.ru>
 <20191213021820-mutt-send-email-mst@kernel.org>
 <aff36770-9f21-988f-91ea-b106a8d5f1be@ozlabs.ru>
 <20191213033620-mutt-send-email-mst@kernel.org>
 <f3c32495-6fe4-7401-c96b-12e9b90e23d9@ozlabs.ru>
MIME-Version: 1.0
In-Reply-To: <f3c32495-6fe4-7401-c96b-12e9b90e23d9@ozlabs.ru>
X-MC-Unique: -htE2YhJMviLl_TTB2GETA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 04:19:57PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 13/12/2019 19:36, Michael S. Tsirkin wrote:
> > On Fri, Dec 13, 2019 at 07:29:40PM +1100, Alexey Kardashevskiy wrote:
> >>
> >>
> >> On 13/12/2019 18:24, Michael S. Tsirkin wrote:
> >>> On Fri, Dec 13, 2019 at 05:05:05PM +1100, Alexey Kardashevskiy wrote:
> >>>> Hi!
> >>>>
> >>>> I am having an issue with capabilities (hopefully the chunk formatti=
ng
> >>>> won't break).
> >>>>
> >>>> The problem is that when virtio_pci_find_capability() reads
> >>>> pci_find_capability(dev, PCI_CAP_ID_VNDR), 0 is returned; if repeate=
d,
> >>>> it returns a valid number (0x84). Timing seems to matter. pci_cfg_re=
ad
> >>>> trace shows that that first time read does not reach QEMU but others=
 do
> >>>> reach QEMU and return what is expected.
> >>>>
> >>>> How to debug this, any quick ideas?
> >>>> The config space is not a MMIO BAR
> >>>> or KVM memory slot or anything like this, right? :) Thanks,
> >>>
> >>> Depends on the platform.
> >>>
> >>> E.g. on x86, when using cf8/cfc pair, if guest doesn't
> >>
> >>
> >> Is there an easy way to tell if it is this "cf8/cfc" case?
> >>
> >> I have these bars, is any of them related to cf8/cfc? Thanks,
> >>
> >> root@le-dbg:~# (qemu) info mtree -f
> >> FlatView #0
> >>  AS "memory", root: system
> >>  AS "cpu-memory-0", root: system
> >>  Root memory region: system
> >>   0000000000000000-00000000ffffffff (prio 0, ram): ppc_spapr.ram kvm
> >>   0000200080000000-000020008000002f (prio 0, i/o): msix-table
> >>   0000200080000800-0000200080000807 (prio 0, i/o): msix-pba
> >>   0000210000000000-0000210000000fff (prio 0, i/o): virtio-pci-common
> >>   0000210000001000-0000210000001fff (prio 0, i/o): virtio-pci-isr
> >>   0000210000002000-0000210000002fff (prio 0, i/o): virtio-pci-device
> >>   0000210000003000-0000210000003fff (prio 0, i/o): virtio-pci-notify
> >>
> >=20
> >=20
> > No, you want stuff in hw/ppc/spapr_pci.c
>=20
>=20
> The problem was with our firmware, fixing that now.
>=20
> Out of curiosity. I do not see cf8/cfc on x86 either, or I just do not
> recognize those, what is this cf8/cfc?

E.g. i440fx:

static void i440fx_pcihost_realize(DeviceState *dev, Error **errp)
{
    PCIHostState *s =3D PCI_HOST_BRIDGE(dev);
    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);

    sysbus_add_io(sbd, 0xcf8, &s->conf_mem);
    sysbus_init_ioports(sbd, 0xcf8, 4);

    sysbus_add_io(sbd, 0xcfc, &s->data_mem);
    sysbus_init_ioports(sbd, 0xcfc, 4);

    /* register i440fx 0xcf8 port as coalesced pio */
    memory_region_set_flush_coalesced(&s->data_mem);
    memory_region_add_coalescing(&s->conf_mem, 0, 4);
}



> Thanks,
>=20
> FlatView #2
>=20
>  AS "memory", root: system
>=20
>  AS "cpu-memory-0", root: system
>=20
>  AS "piix3-ide", root: bus master container
>=20
>  AS "virtio-net-pci", root: bus master container
>=20
>  Root memory region: system
>=20
>   0000000000000000-00000000000bffff (prio 0, ram): pc.ram kvm
>=20
>   00000000000c0000-00000000000c0fff (prio 0, rom): pc.ram
> @00000000000c0000 kvm
>   00000000000c1000-00000000000c3fff (prio 0, ram): pc.ram
> @00000000000c1000 kvm
>   00000000000c4000-00000000000e7fff (prio 0, rom): pc.ram
> @00000000000c4000 kvm
>   00000000000e8000-00000000000effff (prio 0, ram): pc.ram
> @00000000000e8000 kvm
>   00000000000f0000-00000000000fffff (prio 0, rom): pc.ram
> @00000000000f0000 kvm
>   0000000000100000-000000007fffffff (prio 0, ram): pc.ram
> @0000000000100000 kvm
>   00000000febc0000-00000000febc002f (prio 0, i/o): msix-table
>=20
>   00000000febc0800-00000000febc0807 (prio 0, i/o): msix-pba
>=20
>   00000000febfc000-00000000febfcfff (prio 0, i/o): virtio-pci-common
>=20
>   00000000febfd000-00000000febfdfff (prio 0, i/o): virtio-pci-isr
>=20
>   00000000febfe000-00000000febfefff (prio 0, i/o): virtio-pci-device
>=20
>   00000000febff000-00000000febfffff (prio 0, i/o): virtio-pci-notify
>=20
>   00000000fec00000-00000000fec00fff (prio 0, i/o): kvm-ioapic
>=20
>   00000000fed00000-00000000fed003ff (prio 0, i/o): hpet
>=20
>   00000000fee00000-00000000feefffff (prio 4096, i/o): kvm-apic-msi
>=20
>   00000000fffc0000-00000000ffffffff (prio 0, rom): pc.bios kvm
>=20
>=20
>=20
> --=20
> Alexey


