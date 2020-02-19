Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA284C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:46:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 955EE20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeikRWZF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955EE20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Pft-0003tT-PA
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 08:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Pf1-0002Xg-1z
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Pf0-0006sJ-0o
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:45:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44566
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Pez-0006rn-2j
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 08:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582119904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M7QgOwiLJq1vCicN/DuTs3yPLEVTvnmq+ijHRPdO2r8=;
 b=NeikRWZFtSswYwxPrYeQRlQJafAfv+rMJptWP9zpuc9jvEnMyXT6NndQTOTwLyUofB9Z0K
 sftd+W2KdwAOYoxXqRHRhSObV1IWXaMdgZcVAWL11RHy+gnYBkHPt58a9MWfnAMz+Ymxal
 nMPf5tL4l55K+OX2AkzNEETHZo80wjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-nPR9VlvCNdad8PBJMA3v4g-1; Wed, 19 Feb 2020 08:45:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 942FC13FC
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 13:45:01 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC538101D481;
 Wed, 19 Feb 2020 13:44:58 +0000 (UTC)
Date: Wed, 19 Feb 2020 14:44:57 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v5 34/79] arm/xilinx_zynq: drop RAM size fixup
Message-ID: <20200219144457.5ed2367f@redhat.com>
In-Reply-To: <bfc46ad0-fa98-0d1f-b452-be82c7dda85d@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-35-imammedo@redhat.com>
 <bfc46ad0-fa98-0d1f-b452-be82c7dda85d@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nPR9VlvCNdad8PBJMA3v4g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 18:23:47 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/17/20 6:34 PM, Igor Mammedov wrote:
> > If user provided non-sense RAM size, board will complain and
> > continue running with max RAM size supported.
> > Also RAM is going to be allocated by generic code, so it won't be
> > possible for board to fix things up for user.
> >=20
> > Make it error message and exit to force user fix CLI,
> > instead of accepting non-sense CLI values.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   hw/arm/xilinx_zynq.c | 16 ++++++++--------
> >   1 file changed, 8 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> > index 3a0fa5b23f..df950fc400 100644
> > --- a/hw/arm/xilinx_zynq.c
> > +++ b/hw/arm/xilinx_zynq.c
> > @@ -158,7 +158,6 @@ static inline void zynq_init_spi_flashes(uint32_t b=
ase_addr, qemu_irq irq,
> >  =20
> >   static void zynq_init(MachineState *machine)
> >   {
> > -    ram_addr_t ram_size =3D machine->ram_size;
> >       ARMCPU *cpu;
> >       MemoryRegion *address_space_mem =3D get_system_memory();
> >       MemoryRegion *ext_ram =3D g_new(MemoryRegion, 1);
> > @@ -168,6 +167,12 @@ static void zynq_init(MachineState *machine)
> >       qemu_irq pic[64];
> >       int n;
> >  =20
> > +    /* max 2GB ram */
> > +    if (machine->ram_size > 0x80000000) {
> > +        error_report("RAM size more than %d is not supported", 0x80000=
000); =20
>=20
> Eh? Maybe:
>=20
>         if (machine->ram_size > 2 * GiB) {
>             error_report("RAM size more than 2 GiB is not supported");

amended in v6

> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> >       cpu =3D ARM_CPU(object_new(machine->cpu_type));
> >  =20
> >       /* By default A9 CPUs have EL3 enabled.  This board does not
> > @@ -184,14 +189,9 @@ static void zynq_init(MachineState *machine)
> >                               &error_fatal);
> >       object_property_set_bool(OBJECT(cpu), true, "realized", &error_fa=
tal);
> >  =20
> > -    /* max 2GB ram */
> > -    if (ram_size > 0x80000000) {
> > -        ram_size =3D 0x80000000;
> > -    }
> > -
> >       /* DDR remapped to address zero.  */
> >       memory_region_allocate_system_memory(ext_ram, NULL, "zynq.ext_ram=
",
> > -                                         ram_size);
> > +                                         machine->ram_size);
> >       memory_region_add_subregion(address_space_mem, 0, ext_ram);
> >  =20
> >       /* 256K of on-chip memory */
> > @@ -300,7 +300,7 @@ static void zynq_init(MachineState *machine)
> >       sysbus_connect_irq(busdev, 0, pic[40 - IRQ_OFFSET]);
> >       sysbus_mmio_map(busdev, 0, 0xF8007000);
> >  =20
> > -    zynq_binfo.ram_size =3D ram_size;
> > +    zynq_binfo.ram_size =3D machine->ram_size;
> >       zynq_binfo.nb_cpus =3D 1;
> >       zynq_binfo.board_id =3D 0xd32;
> >       zynq_binfo.loader_start =3D 0;
> >  =20
>=20


