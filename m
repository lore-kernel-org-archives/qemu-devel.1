Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A271CC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:45:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6314F20724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pcq8ILcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314F20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEsfx-00041I-J9
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1jEsfJ-0003b2-VF
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:44:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1jEsfI-0008De-8S
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:44:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:36938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1jEsfI-0008CA-4s
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584614679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0G4ggsIxgsTQF5+6KzWEw9V9XrZRzCYzW7huAb/pqQ=;
 b=Pcq8ILcTQ0HSuHjzNzZ7WO7H+nyBpW1Qt5IuszkR+xoA1Xypbd6xVgUmhnLorYwkwc3vLx
 PxVnkz42m4yMt4eEB0YLnLQSWDuBGp/UcTQUOuSqyQdwzixfA7RtJDIgVa3F1q4tQIBmVy
 wfi7Kb+lL5Wu9WRedz2Y25aOgo1hnZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-ZnhHTB2mNKiByuCwMlxpfQ-1; Thu, 19 Mar 2020 06:44:38 -0400
X-MC-Unique: ZnhHTB2mNKiByuCwMlxpfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A9DA477;
 Thu, 19 Mar 2020 10:44:37 +0000 (UTC)
Received: from office.mammed.net (unknown [10.40.194.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B883660BEC;
 Thu, 19 Mar 2020 10:44:26 +0000 (UTC)
Date: Thu, 19 Mar 2020 11:44:24 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
Message-ID: <20200319114424.5723e777@office.mammed.net>
In-Reply-To: <20200318221531.22910-2-philmd@redhat.com>
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 23:15:30 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
> function are not documented in the PIIX4 datasheet.
> This appears to be a PC-only feature added in commit 5e3cb5347e
> ("initialize hot add system / acpi gpe") which was then moved
> to the PIIX4 device model in commit 9d5e77a22f ("make
> qemu_system_device_hot_add piix independent")
> Add a property (default enabled, to not modify the current
> behavior) to allow machines wanting to model a simple PIIX4
> to disable this feature.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

it's already pretty twisted code and adding one more knob
to workaround other compat knobs makes it worse.

Even though it's not really welcomed approach,
we can ifdef all hotplug parts and compile them out for mips
dropping along the way linking with not needed dependencies
or
more often used, make stubs from hotplug parts for mips
and link with them.

> ---
> Should I squash this with the next patch and start with
> default=3Dfalse, which is closer to the hardware model?
> ---
>  hw/acpi/piix4.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 964d6f5990..9c970336ac 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -78,6 +78,7 @@ typedef struct PIIX4PMState {
> =20
>      AcpiPciHpState acpi_pci_hotplug;
>      bool use_acpi_pci_hotplug;
> +    bool use_acpi_system_hotplug;
> =20
>      uint8_t disable_s3;
>      uint8_t disable_s4;
> @@ -503,8 +504,10 @@ static void piix4_pm_realize(PCIDevice *dev, Error *=
*errp)
>      s->machine_ready.notify =3D piix4_pm_machine_ready;
>      qemu_add_machine_init_done_notifier(&s->machine_ready);
> =20
> -    piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> -                                   pci_get_bus(dev), s);
> +    if (s->use_acpi_system_hotplug) {
> +        piix4_acpi_system_hot_add_init(pci_address_space_io(dev),
> +                                       pci_get_bus(dev), s);
> +    }
>      qbus_set_hotplug_handler(BUS(pci_get_bus(dev)), OBJECT(s), &error_ab=
ort);
> =20
>      piix4_pm_add_propeties(s);
> @@ -635,6 +638,8 @@ static Property piix4_pm_properties[] =3D {
>                       use_acpi_pci_hotplug, true),
>      DEFINE_PROP_BOOL("memory-hotplug-support", PIIX4PMState,
>                       acpi_memory_hotplug.is_enabled, true),
> +    DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMState,
> +                     use_acpi_system_hotplug, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20


