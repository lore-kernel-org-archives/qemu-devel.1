Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1E6C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9FFD2072D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 15:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cqSKa+f5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FFD2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEwmw-0003sw-QU
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 11:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEwmN-0003Qy-8M
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:08:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEwmL-00010b-Gb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:08:14 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47487)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEwmL-000101-Cx
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 11:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584630492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/mtgzCdv9sKXyH05tbd38LH95LLZVXgjX5yGisTonng=;
 b=cqSKa+f5he9znPhsfOBTZj7Upe1Wl2pY3Ch+O2NVzZVyv3Fkvz+OElaevSqZ0jM9REdMy8
 ovy+WiucIbISh43+WzTYBrMntnL4NbOyUD6Op+tW0cPIxSS9jPqguhJ6VEkWMGKG4Fmldl
 PDzhLDOVpeMyTIQo872WBLJBVZA2RTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-CgnmQsQ6M--FMSGClc5o4w-1; Thu, 19 Mar 2020 11:08:09 -0400
X-MC-Unique: CgnmQsQ6M--FMSGClc5o4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B088F801E6C;
 Thu, 19 Mar 2020 15:08:07 +0000 (UTC)
Received: from localhost (unknown [10.40.208.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD1E7BBBD7;
 Thu, 19 Mar 2020 15:08:01 +0000 (UTC)
Date: Thu, 19 Mar 2020 16:08:00 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Message-ID: <20200319160800.614de5fb@redhat.com>
In-Reply-To: <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <20200319114424.5723e777@office.mammed.net>
 <4d42697e-ba84-e5af-3a17-a2cc52cf0dbc@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Mar 2020 12:04:11 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 3/19/20 11:44 AM, Igor Mammedov wrote:
> > On Wed, 18 Mar 2020 23:15:30 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
> >> function are not documented in the PIIX4 datasheet.
> >> This appears to be a PC-only feature added in commit 5e3cb5347e
> >> ("initialize hot add system / acpi gpe") which was then moved
> >> to the PIIX4 device model in commit 9d5e77a22f ("make
> >> qemu_system_device_hot_add piix independent")
> >> Add a property (default enabled, to not modify the current
> >> behavior) to allow machines wanting to model a simple PIIX4
> >> to disable this feature.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =20
> >=20
> > it's already pretty twisted code and adding one more knob
> > to workaround other compat knobs makes it worse.
> >=20
> > Even though it's not really welcomed approach,
> > we can ifdef all hotplug parts and compile them out for mips
> > dropping along the way linking with not needed dependencies =20
>=20
> We can't use use target-specific poisoned definitions to ifdef out in=20
> generic hw/ code.
>=20
> > or
> > more often used, make stubs from hotplug parts for mips
> > and link with them. =20
>=20
> So the problem is this device doesn't match the hardware datasheet, has=
=20
> extra features helping virtualization, and now we can not simplify it=20
> due to backward compat.
>=20
> Once Michael said he doesn't care about the PIIX4, only the PIIX3=20
> southbridge [1] [2], but then the i440fx pc machine uses a PIIX3 with a=
=20
> pci PM function from PIIX4, and made that PII4_PM Frankenstein.
>=20
> You are asking me to choose between worse versus ugly?
That 'ugly' is typically used within QEMU to deal with such things
probably due to its low complexity.

> The saner outcome I see is make the current PIIX4_PM x86-specific, not=20
> modifying the code, and start a fresh new copy respecting the datasheet.
properly implementing spec would be quite a task
(although if motivation is just for fun, then why not)

>=20
> Note I'm not particularly interested in MIPS here, but having model=20
> respecting the hardware.
>=20
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg504270.html
> [2] https://www.mail-archive.com/qemu-devel@nongnu.org/msg601512.html
>=20
> >  =20
> >> ---
> >> Should I squash this with the next patch and start with
> >> default=3Dfalse, which is closer to the hardware model?
> >> ---
> >>   hw/acpi/piix4.c | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> >> index 964d6f5990..9c970336ac 100644
> >> --- a/hw/acpi/piix4.c
> >> +++ b/hw/acpi/piix4.c
> >> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> >>  =20
> >>       AcpiPciHpState acpi_pci_hotplug;
> >>       bool use_acpi_pci_hotplug;
> >> +    bool use_acpi_system_hotplug;
> >>  =20
> >>       uint8_t disable_s3;
> >>       uint8_t disable_s4;
> >> @@ -503,8 +504,10 @@ static void piix4_pm_realize(PCIDevice *dev, Erro=
r **errp)
> >>       s->machine_ready.notify =3D piix4_pm_machine_ready;
> >>       qemu_add_machine_init_done_notifier(&s->machine_ready);
> >>  =20
> >> -    piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> >> -                                   pci_get_bus(dev), s);
> >> +    if (s->use_acpi_system_hotplug) {
> >> +        piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> >> +                                       pci_get_bus(dev), s);
> >> +    }
> >>       qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &erro=
r_abort);
> >>  =20
> >>       piix4_pm_add_propeties(s);
> >> @@ -635,6 +638,8 @@ static Property piix4_pm_properties[] =3D {
> >>                        use_acpi_pci_hotplug, true),
> >>       DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
> >>                        acpi_memory_hotplug.is_enabled, true),
> >> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
> >> +                     use_acpi_system_hotplug, true),
> >>       DEFINE_PROP_END_OF_LIST(),
> >>   };
> >>    =20
> >  =20
>=20
>=20


