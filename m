Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC0C43446
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:43:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA34F2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXjNnrfX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA34F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvM9Q-0008KP-4S
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvM8C-00070X-CP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:42:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1jvM8A-0002aH-Ei
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:42:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594737720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmzCfYAgK72iFEwcerKYdsq0eA3ZR9uR1nlfPFhwAXA=;
 b=CXjNnrfX4C2pZVU7rD0P+tebUPzdqWu6N/j17eeZ1o75XiTbkuSjuJneFVZSQDis4jzgyo
 E3nGWEZmDgXt0qY5EBLQlXnMB4jXlSbZjTvc03dIhNVoANGPJ766Iu2FRXDqeuj7Q3/yTh
 Vk4czsvO8MUSVH1hAvfb/a20akoYAlo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-UPjSudHgOzi8I0JwRoSzdg-1; Tue, 14 Jul 2020 10:41:59 -0400
X-MC-Unique: UPjSudHgOzi8I0JwRoSzdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09B76800597;
 Tue, 14 Jul 2020 14:41:58 +0000 (UTC)
Received: from localhost (unknown [10.40.208.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7779E60BEC;
 Tue, 14 Jul 2020 14:41:43 +0000 (UTC)
Date: Tue, 14 Jul 2020 16:41:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH 3/4] hw/arm/virt-acpi-build: Only expose flash on older
 machine types
Message-ID: <20200714164141.1ce6b122@redhat.com>
In-Reply-To: <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
References: <20200629140938.17566-1-drjones@redhat.com>
 <20200629140938.17566-4-drjones@redhat.com>
 <20200713104907.335bf762@redhat.com>
 <20200714055109.owrlob6m53notzh3@kamzik.brq.redhat.com>
 <20200714045537-mutt-send-email-mst@kernel.org>
 <20200714092325.5klaeqelu46mhg76@kamzik.brq.redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 01:42:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, lersek@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, ard.biesheuvel@arm.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 11:23:25 +0200
Andrew Jones <drjones@redhat.com> wrote:

> On Tue, Jul 14, 2020 at 04:57:50AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Jul 14, 2020 at 07:51:09AM +0200, Andrew Jones wrote: =20
> > > On Mon, Jul 13, 2020 at 10:49:07AM +0200, Igor Mammedov wrote: =20
> > > > On Mon, 29 Jun 2020 16:09:37 +0200
> > > > Andrew Jones <drjones@redhat.com> wrote:
> > > >  =20
> > > > > The flash device is exclusively for the host-controlled firmware,=
 so
> > > > > we should not expose it to the OS. Exposing it risks the OS messi=
ng
> > > > > with it, which could break firmware runtime services and surprise=
 the
> > > > > OS when all its changes disappear after reboot.
> > > > >=20
> > > > > As firmware needs the device and uses DT, we leave the device exp=
osed
> > > > > there. It's up to firmware to remove the nodes from DT before sen=
ding
> > > > > it on to the OS. However, there's no need to force firmware to re=
move
> > > > > tables from ACPI (which it doesn't know how to do anyway), so we
> > > > > simply don't add the tables in the first place. But, as we've bee=
n
> > > > > adding the tables for quite some time and don't want to change th=
e
> > > > > default hardware exposed to versioned machines, then we only stop
> > > > > exposing the flash device tables for 5.1 and later machine types.
> > > > >=20
> > > > > Suggested-by: Ard Biesheuvel <ard.biesheuvel@arm.com>
> > > > > Suggested-by: Laszlo Ersek <lersek@redhat.com>
> > > > > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > > > > ---
> > > > >  hw/arm/virt-acpi-build.c | 5 ++++-
> > > > >  hw/arm/virt.c            | 3 +++
> > > > >  include/hw/arm/virt.h    | 1 +
> > > > >  3 files changed, 8 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > > > index 1384a2cf2ab4..91f0df7b13a3 100644
> > > > > --- a/hw/arm/virt-acpi-build.c
> > > > > +++ b/hw/arm/virt-acpi-build.c
> > > > > @@ -749,6 +749,7 @@ static void build_fadt_rev5(GArray *table_dat=
a, BIOSLinker *linker,
> > > > >  static void
> > > > >  build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineSt=
ate *vms)
> > > > >  {
> > > > > +    VirtMachineClass *vmc =3D VIRT_MACHINE_GET_CLASS(vms);
> > > > >      Aml *scope, *dsdt;
> > > > >      MachineState *ms =3D MACHINE(vms);
> > > > >      const MemMapEntry *memmap =3D vms->memmap;
> > > > > @@ -767,7 +768,9 @@ build_dsdt(GArray *table_data, BIOSLinker *li=
nker, VirtMachineState *vms)
> > > > >      acpi_dsdt_add_cpus(scope, vms->smp_cpus);
> > > > >      acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
> > > > >                         (irqmap[VIRT_UART] + ARM_SPI_BASE));
> > > > > -    acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > > > +    if (vmc->acpi_expose_flash) {
> > > > > +        acpi_dsdt_add_flash(scope, &memmap[VIRT_FLASH]);
> > > > > +    }
> > > > >      acpi_dsdt_add_fw_cfg(scope, &memmap[VIRT_FW_CFG]);
> > > > >      acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
> > > > >                      (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRT=
IO_TRANSPORTS);
> > > > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > > > index cd0834ce7faf..5adc9ff799ef 100644
> > > > > --- a/hw/arm/virt.c
> > > > > +++ b/hw/arm/virt.c
> > > > > @@ -2482,9 +2482,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
> > > > > =20
> > > > >  static void virt_machine_5_0_options(MachineClass *mc)
> > > > >  {
> > > > > +    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc=
));
> > > > > +
> > > > >      virt_machine_5_1_options(mc);
> > > > >      compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_=
5_0_len);
> > > > >      mc->numa_mem_supported =3D true;
> > > > > +    vmc->acpi_expose_flash =3D true; =20
> > > >=20
> > > > we usually do not version ACPI tables changes
> > > > (unless we have a good reason to do so) =20
> > >=20
> > > Even when the change is to remove the exposure of hardware from the g=
uest?
> > > Before this change, if a guest looked, it had a flash, after this cha=
nge,
> > > if a guest looks, it doesn't. =20
> >=20
> > It's up to the relevant maintainers who know what the semantics are.
> > FYI ACPI tables only change across a reset though.
> > So it's a question of whether guests get confused even if this
> > changes after a reboot. =20
>=20
> Yup, but it's still the same "machine", so a user may wonder why it
> changed.

you can have a different firmware with the same machine type either
and it might look differently to guest OS but don't bother versioning
FW. APCI tables are also part of FW (but generated by QEMU), so the same
usually rule applies.
=20
> > Versioning is generally safer, but it's a good idea to document
> > the motivation for it.
> > =20
>=20
> Well, in this case, we could probably push this change to old machine
> types and nobody would notice. If a guest is using ACPI, then it must
> be using firmware, and if they're using firmware, then they can't be
> using the flash. So the user shouldn't care if it's there or not. The
> only justification for the versioning is because "it's safer". If
> people feel strongly about avoiding versioning when it's not obviously
> necessary, then I can respin without it.

From my pov if it doesn't break anything don't version it, since versioning
adds complexity which cost time during review, so it would be nicer to revi=
ewers
and to future yourself if you can help to keep it as simple as possible.

In this particular case I'd drop versioning.

> Thanks,
> drew
>=20
>=20


