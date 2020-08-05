Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07975C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C674F2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ygw8migY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C674F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MbV-0007IP-42
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k3Maj-0006qK-NN
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:48:37 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1k3Mah-0004LG-Vk
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596646114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otWxQdUUayRBVqCFZWMUPgN+ie96n0JudszxjIyCdDo=;
 b=Ygw8migYfPaW7eUIBsMVliirDaXj+/MxtaTUhAE1LORZyNo7VNqVh87tqPF0jjR8M8MsP7
 H7fPhqFPnuKiYTzSUWpDpz/ncvaMGFBSbK7On09Hs3hG4Qy7nLWzDoh4AvBbvGhg8GwCsc
 cDmxMRdPYCU/Xgl3e1H2NSswGY+LRG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-FMq_2REqMTWQLwUOMO9EyQ-1; Wed, 05 Aug 2020 12:47:27 -0400
X-MC-Unique: FMq_2REqMTWQLwUOMO9EyQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8992179ED4;
 Wed,  5 Aug 2020 16:47:25 +0000 (UTC)
Received: from localhost (unknown [10.40.208.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8895C79CE3;
 Wed,  5 Aug 2020 16:47:19 +0000 (UTC)
Date: Wed, 5 Aug 2020 18:47:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Message-ID: <20200805184717.217593d8@redhat.com>
In-Reply-To: <b4b1b0d4-6a94-3ab7-62a2-fd3e43804d15@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
 <1b61a51a-0419-1bd3-2728-e5c11606f99e@redhat.com>
 <c0ea77ce-bd5f-aa3b-2dd0-e4793800208a@redhat.com>
 <fabf9f04-fbc8-79e5-4ae7-beb9a2a05f16@redhat.com>
 <b4b1b0d4-6a94-3ab7-62a2-fd3e43804d15@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 08:01:24 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 8/5/20 7:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 3/19/20 11:02 AM, Paolo Bonzini wrote: =20
> >> On 19/03/20 10:42, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> On 3/19/20 10:36 AM, Paolo Bonzini wrote: =20
> >>>> On 18/03/20 23:15, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>>>> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
> >>>>> function are not documented in the PIIX4 datasheet.
> >>>>> This appears to be a PC-only feature added in commit 5e3cb5347e
> >>>>> ("initialize hot add system / acpi gpe") which was then moved
> >>>>> to the PIIX4 device model in commit 9d5e77a22f ("make
> >>>>> qemu_system_device_hot_add piix independent")
> >>>>> Add a property (default enabled, to not modify the current
> >>>>> behavior) to allow machines wanting to model a simple PIIX4
> >>>>> to disable this feature. =20
> >>>>
> >>>> Yes, all hotplug stuff (PCI/memory/CPU) are custom additions by QEMU=
.
> >>>> =20
> >>>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("system-hotplug-support", PIIX=
4PMState,
> >>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_acpi_system_hotp=
lug, true), =20
> >>>>
> >>>> Why not cpu-hotplug-support? =20
> >>>
> >>> Because I have no idea what this code is about, and it seems more tha=
n
> >>> cpu (pci, memory): =20
> >>
> >> Right, I should have been more verbose.  You mentioned I/O port 0xaf00
> >> which is CPU hotplug.  Perhaps unless you can also crash with PCI
> >> hotplug (0xae00-0xae0f) it's worth removing only CPU hotplug from MIPS
> >> machines, and keep PCI hotplug. =20
> >=20
> > I am sorry I don't understand what PCI hotplug has to do with PIIX whic=
h
> > is a PCI-slave southbridge... If MIPS or other arch is interested in PC=
I
> > hotplug feature, that would be managed by the northbridge or another PC=
I
> > bridge. =20
>=20
> Ah, writing that comment made me realize the problem might be these
> 'virtualization' features have been implemented in the wrong place.
> Maybe the less disruptive path is to move them to the i440fx
> northbridge.
not sure if this option is on the table atm.
You will need a means to remap migration state to another device to keep mi=
gration working.

>That way we shouldn't need to maintain a piix_hw.c and
> piix_virt_twisted.c (child of piix_hw overloaded with hotplug features).
that's path I'd consider, i.e. split out virt parts out from piix hw
and make virt child that will have our hacks on top of native piix.

Still, You will need to keep typenames on virt part as it's now
for not to break migration stream (but I'm not sure, CCing David).

>=20
> I haven't looked at the history yet, maybe the problem happened when
> i440fx/piix was split.
My guess would be due piix_pm having ACPI hw in spec (like sci/pm) so addin=
g
other related ACPI hw was considered as the least disruptive back then.

>=20
> >  =20
> >>
> >> Paolo
> >> =20
> >>> static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIBus *bus, PIIX4PMState *s)
> >>> {
> >>> =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->io_gpe, OBJECT(s), &piix=
4_gpe_ops, s,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "acpi-gpe0", GPE_LEN);
> >>> =C2=A0=C2=A0=C2=A0 memory_region_add_subregion(parent, GPE_BASE, &s->=
io_gpe);
> >>>
> >>> =C2=A0=C2=A0=C2=A0 acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, b=
us, parent,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->use_acpi_pci_hotplug);
> >>>
> >>> =C2=A0=C2=A0=C2=A0 s->cpu_hotplug_legacy =3D true;
> >>> =C2=A0=C2=A0=C2=A0 object_property_add_bool(OBJECT(s), "cpu-hotplug-l=
egacy",
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 piix4_get_cpu_hotplug_legacy,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 piix4_set_cpu_hotplug_legacy,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 NULL);
> >>> =C2=A0=C2=A0=C2=A0 legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s=
->gpe_cpu,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PIIX4_CPU_HOTPLUG_IO_BASE)=
;
> >>>
> >>> =C2=A0=C2=A0=C2=A0 if (s->acpi_memory_hotplug.is_enabled) {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_memory_hotplug_init(p=
arent, OBJECT(s),
> >>> &s->acpi_memory_hotplug,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_MEMORY_HOTPLUG_BASE);
> >>> =C2=A0=C2=A0=C2=A0 }
> >>> }
> >>> =20
> >> =20
> >  =20
>=20


