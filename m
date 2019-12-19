Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CBBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B3620684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY3oJ07V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B3620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxGn-0001Al-M7
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:59:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ihxFv-0008DT-Qd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ihxFu-0004U8-3M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:58:23 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36194)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ihxFt-0004N0-M3
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:58:21 -0500
Received: by mail-wr1-x441.google.com with SMTP id z3so6308670wru.3
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 06:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=iWxIA9v3JBKdGB24qiv57BiWb+aWm2DNvPVi7odlH5I=;
 b=kY3oJ07V2xRC6Ov/NR1uVipi85eqoTEvmGm47lOxJosfFESHDJFPg80q8c6mJ8ttJ8
 b3q6sDZ8V+p1l0aqAjTO3pj6GZvpGYiiBSrYuCOcvk3fHRwPZE3I7rP0sAXpIWdDFTd2
 wbgZeiJYArRK/ttZMLdsuilVm4hBaaG4ISNajXIelwUEEIeweJIwrCDcifqb89QprFJG
 HQgQTTWN6O4BxXPlwH1zFRYk3m0X0JOYGaC3V3exZd8mheFYLCTSkSIHaEkGFmyE3GPq
 y0cCTaLJ3eq0vnXlARmSOVRf6YLxLmoUX4q95VqsIzPgmBxl2vfXdDTiFgHJrk39jo2m
 cnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=iWxIA9v3JBKdGB24qiv57BiWb+aWm2DNvPVi7odlH5I=;
 b=g8c7JkQsca4cRCDUK+79TNWwUvZvyUzAZj0lO8/10W+uuJ7K2UNJVz46U2t97wShPt
 XoaKE+KKjVrxmzzAHTwkxi1pnfZSsxEdIEJ5LPQI3PPy5GHGtyXw/7jVrQjPLhI8wSdi
 rmOyNEx8RTiNgsmeem66N8RPU4/DWgQEwszFx9y4aNNOeSNgoPlf3ADVOFJHRs1UHaRW
 o9B/UklgT95YIcdDr9WchZXk5fxL0v9oJAqMuFxGJi2c2jlck/9GrF5zvA4SPjthnaK7
 T6zI3gINtav1DyJkwHGeQq85kiU/hLa8rKxV/Ql+6uYbrPpphU0UbOEVfSl47XJ4I7Cf
 bSew==
X-Gm-Message-State: APjAAAXTj/0748jMkx7YoX6JNh36qjaQqK7FqVh777nDiKhPgXMU517E
 ynHe3PlIPkqOn+M3M5pMIA0=
X-Google-Smtp-Source: APXvYqzMmpnF81DUnnKGm4R+vvvfuGWmX4rP1gKU36S2XbJyZaRXmYpR3XeEpBk8ZcAKyb+u/jbNUg==
X-Received: by 2002:a5d:53c1:: with SMTP id a1mr9441761wrw.373.1576767500130; 
 Thu, 19 Dec 2019 06:58:20 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id n10sm6524540wrt.14.2019.12.19.06.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 06:58:18 -0800 (PST)
Date: Thu, 19 Dec 2019 14:58:17 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: ASM <asm@asm.pp.ru>
Subject: Re: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
Message-ID: <20191219145817.GG1624084@stefanha-x1.localdomain>
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
 <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
 <20191121140502.GX439743@stefanha-x1.localdomain>
 <CAMmAVbW5a+v_dJ6NM3erwouOqpXyTzL36_W566SL1KuPFPFSEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <CAMmAVbW5a+v_dJ6NM3erwouOqpXyTzL36_W566SL1KuPFPFSEw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, dmitry.fleytman@gmail.com,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2019 at 03:39:03PM +0300, ASM wrote:
> When the packet is received, e1000 writes it to memory directrly
> without any RCU.
> The address of memory for writing is set by the driver from dpdk driver.
> Driver writes to RDBA (RDBAH,RDBAL) base address of ring.
>=20
> It turns out that MMIO RCU (mentioned from e1000_mmio_setup) does not
> protect, and can't protect the ring descriptors.
> The area for protection may be any area of operational memory. And it
> becomes famous when writing to registers RDBA by driver.
> (see datasheet 82574 GbE Controller "7.1.8 Receive Descriptor Queue Struc=
ture")
>=20
> How can this memory be protected? As I understand it, the e1000 should
> track the record in RDBA and enable memory protection in this region.
> But how to do it right?

I misunderstood the issue and you can probably ignore my comments about
coalesced MMIO.  You quoted descriptor DMA code below so coalesced MMIO
shouldn't be relevant since desc->status isn't an MMIO register.

>=20
> Source code qemu:
> hw/net/e1000.c:954 (version master)
>=20
>  954         base =3D rx_desc_base(s) + sizeof(desc) * s->mac_reg[RDH];
> where rx_desc_base -- address RDBAH regs. It address no have RCU protect.
> ...
> 955         pci_dma_read(d, base, &desc, sizeof(desc));
> ...
> 957         desc.status |=3D (vlan_status | E1000_RXD_STAT_DD);
> ...
> 990         pci_dma_write(d, base, &desc, sizeof(desc));
> ->
> exec.c:
> 3111 static MemTxResult flatview_write_continue(FlatView *fv, hwaddr addr,
> 3112                                            MemTxAttrs attrs,
> 3113                                            const uint8_t *buf,
> 3114                                            hwaddr len, hwaddr addr1,
> 3115                                            hwaddr l, MemoryRegion *m=
r)
> 3116 {
> ...
> 3123         if (!memory_access_is_direct(mr, true)) {
> (false)
> 3131         } else {
> 3132             /* RAM case */
> 3133             ptr =3D qemu_ram_ptr_length(mr->ram_block, addr1, &l, fa=
lse);
> 3134             memcpy(ptr, buf, l);
>=20
> where I be seeing weird behavior with KVM due to MMIO write coalescing
>=20
> 3135             invalidate_and_set_dirty(mr, addr1, l);
> 3136         }
> 3137
>=20
> Source code dpdk(e1000): (version dpdk-stable-17.11.9)
> drivers/net/e1000/em_rxtx.c:
>=20
> 699 uint16_t
> 700 eth_em_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
> 701                 uint16_t nb_pkts)
> ...
> 718         rxq =3D rx_queue
> ...
> 722         rx_id =3D rxq->rx_tail;
> 723         rx_ring =3D rxq->rx_ring
> ...
> 734                 rxdp =3D &rx_ring[rx_id];
> 735                 status =3D rxdp->status;
> 736                 if (! (status & E1000_RXD_STAT_DD))
> 737                         break;
> ...
> 807                 rxdp->buffer_addr =3D dma_addr;
> 808                 rxdp->status =3D 0;
> where I be seeing weird behavior with KVM due to MMIO write
> coalescing

It could be a bug in QEMU's e1000 emulation - maybe it's not doing
things in the correct order and causes a race condition with the DPDK
polling driver - or it could be a bug in the DPDK e1000 driver regarding
the order in which the descriptor ring and RX Head/Tail MMIO registers
are updated.

Did you find the root cause?

> P.S.
> > Also, is DPDK accessing the e1000 device from more than 1 vCPU?
>  All tests on single virtual CPU.
>=20
> I created github project for quick reproduction of this error:
> https://github.com/BASM/qemu_dpdk_e1000_test
>=20
> ---
> Best regards,
> Leonid Myravjev
>=20
> On Thu, 21 Nov 2019 at 17:05, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Wed, Nov 20, 2019 at 08:36:32PM +0300, ASM wrote:
> > > I trying solve the problem, with packets stopping (e1000,tap,kvm).
> > > My studies led to the following:
> > > 1. From flatview_write_continue() I see, what e1000 writes the number
> > > "7" to the STAT register.
> > > 2. The driver from target OS reads STAT register with number "7" and
> > > writes to the register the number "0".
> > > 3. From flatview_write_continue() (I make edits):
> > >             memcpy(ptr, buf, l);
> > >             new1=3Dptr[0xc];
> > >             usleep(100);
> > >             new2=3Dptr[0xc];
> > >             invalidate_and_set_dirty(mr, addr1, l);
> > >             new3=3Dptr[0xc];
> > > printf("Old: %i, new1, %i, new2: %i, new3: %i\n", old,new1,new2,new3);
> > >
> > > I see what memory in first printf is "7", but after usleep() is "0".
> > > Do I understand correctly that this should not be? Or RCU lock
> > > suggests the ability to the multiple writers?
> > >
> > > The problem is that qemu(e1000) writes the number 7, after which
> > > target(dpdk driver) reads 7, on the basis of this it writes the number
> > > 0, but as a result (extremely rarely), the value STATUS still remains
> > > 7. Therefore, packet processing is interrupted. This behavior is
> > > observed only on kvm (it is not observed on tcg).
> > >
> > > Please help with advice or ideas.
> >
> > Hi Leonid,
> > Could you be seeing weird behavior with KVM due to MMIO write
> > coalescing?
> >
> >   static void e1000_mmio_setup(E1000State *d)
> >   {
> >       int i;
> >       const uint32_t excluded_regs[] =3D {
> >           E1000_MDIC, E1000_ICR, E1000_ICS, E1000_IMS,
> >           E1000_IMC, E1000_TCTL, E1000_TDT, PNPMMIO_SIZE
> >       };
> >
> >       memory_region_init_io(&d->mmio, OBJECT(d), &e1000_mmio_ops, d,
> >                             "e1000-mmio", PNPMMIO_SIZE);
> >       memory_region_add_coalescing(&d->mmio, 0, excluded_regs[0]);
> >       for (i =3D 0; excluded_regs[i] !=3D PNPMMIO_SIZE; i++)
> >           memory_region_add_coalescing(&d->mmio, excluded_regs[i] + 4,
> >                                        excluded_regs[i+1] - excluded_re=
gs[i] - 4);
> >       memory_region_init_io(&d->io, OBJECT(d), &e1000_io_ops, d, "e1000=
-io", IOPORT_SIZE);
> >   }
> >
> > MMIO write coalescing means that QEMU doesn't see the register writes
> > immediately.  Instead kvm.ko records them into a ring buffer and QEMU
> > processes the ring when the next ioctl(KVM_RUN) exit occurs.
> >
> > See Linux Documentation/virt/kvm/api.txt "4.116
> > KVM_(UN)REGISTER_COALESCED_MMIO" for more details.
> >
> > I don't really understand your printf debugging explanation.  It would
> > help to see the DPDK code and the exact printf() output.
> >
> > Also, is DPDK accessing the e1000 device from more than 1 vCPU?
> >
> > Stefan

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl37kAkACgkQnKSrs4Gr
c8htqAgAsABQPqmdj1DS2NpLYahHjjDR6W4ClGKftRbAfB5xBd/RLKsafFwwQ4Gz
vCtziFttcM7QcZtYPBRxqWlyX3W4ngus20EdqBP0urgjFy2ehW8yB5udvlNrzJwL
efxr7chbv5oF7t3b2IAH8ymvPIi72E62F+6kEcFnSwn5xYQsMTWDjR+RVko34zvy
jCenoADl+xXd3RjnE9eMjp31UKAVmN0r1iZD4TM4a2AyfUWnpOt34ugJG6ehMaFV
WpQ4ThERBha/ytzP9q5V3/vLNZ55nYJHbgb9IEQmXv5arKisbL8Jk14Cun6zhm/B
24gz2LHv8ziB5nwuORfd6rUN0EPwyw==
=E7Y9
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--

