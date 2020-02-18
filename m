Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDACC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A421624649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 16:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+QWhSNr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A421624649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j463s-0005lF-T6
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 11:49:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4635-00052q-5c
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:48:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4633-0007oQ-TJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:48:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26781
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4633-0007nv-Px
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 11:48:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582044517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8589sR3fCG8HGTYkPo1CAu7+eGwq7K0+zYEcvFKHaw=;
 b=S+QWhSNrslgAi36HkZ8TS12PkxJxglUty3f36+mnhL9qO26F+K5lJg6xqBxdomvCFSScC4
 yCc8NanP/Ql9NK/A7KZTaGy0Klcv5ZUB55xoedWllhHM5oIK3rU//j6vTpEuQbNUmeHLy/
 JMFdpnobBE3mn8mbMMjsjSoYKfNtywk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-pi_4OR9UOzmHqfBqc9sxvQ-1; Tue, 18 Feb 2020 11:48:35 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 382B713E4;
 Tue, 18 Feb 2020 16:48:33 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0401C1BC6D;
 Tue, 18 Feb 2020 16:48:28 +0000 (UTC)
Date: Tue, 18 Feb 2020 17:48:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH v2 12/13] hw/arm/raspi: Add the Raspberry Pi B+ machine
Message-ID: <20200218174826.16dc7b82@redhat.com>
In-Reply-To: <c56d4f85-b4df-643c-c017-350b7f64aec2@redhat.com>
References: <20200217114533.17779-1-f4bug@amsat.org>
 <20200217114533.17779-13-f4bug@amsat.org>
 <26d85b1f-b2b7-ff9f-1236-43e9cb761c30@greensocs.com>
 <c56d4f85-b4df-643c-c017-350b7f64aec2@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: pi_4OR9UOzmHqfBqc9sxvQ-1
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 10:35:43 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> Cc'ing Eduardo/Igor.
>=20
> On 2/18/20 9:48 AM, Luc Michel wrote:
> > On 2/17/20 12:45 PM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>    $ qemu-system-arm -M raspi1b -serial stdio \
> >>        -kernel raspberrypi/firmware/boot/kernel.img \
> >>        -dtb raspberrypi/firmware/boot/bcm2708-rpi-b.dtb \
> >>        -append 'printk.time=3D0 earlycon=3Dpl011,0x20201000 console=3D=
ttyAMA0'
> >>    [    0.000000] Booting Linux on physical CPU 0x0
> >>    [    0.000000] Linux version 4.19.69+ (dom@buildbot) (gcc version 4=
.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1261 Tue Sep 3 20:21:=
01 BST 2019
> >>    [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision =
7 (ARMv7), cr=3D00c5387d
> >>    [    0.000000] CPU: VIPT aliasing data cache, unknown instruction c=
ache
> >>    [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B
> >>    [    0.000000] earlycon: pl11 at MMIO 0x20201000 (options '')
> >>    [    0.000000] bootconsole [pl11] enabled
> >>    [    0.000000] Memory policy: Data cache writeback
> >>    [    0.000000] cma: Reserved 8 MiB at 0x1b800000
> >>    [    0.000000] random: get_random_bytes called from start_kernel+0x=
8c/0x49c with crng_init=3D0
> >>    [    0.000000] Built 1 zonelists, mobility grouping on.  Total page=
s: 113680
> >>    [    0.000000] Kernel command line: printk.time=3D0 earlycon=3Dpl01=
1,0x20201000 console=3DttyAMA0
> >>    Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> >>    Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> >>    Memory: 434380K/458752K available (6971K kernel code, 635K rwdata, =
2080K rodata, 464K init, 797K bss, 16180K reserved, 8192K cma-reserved)
> >>    ...
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/arm/raspi.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
> >> index 3537a329ac..2d9f4e3085 100644
> >> --- a/hw/arm/raspi.c
> >> +++ b/hw/arm/raspi.c
> >> @@ -324,6 +324,15 @@ static void raspi_machine_class_common_init(Machi=
neClass *mc,
> >>       mc->default_ram_size =3D board_ram_size(board_rev);
> >>   };
> >>  =20
> >> +static void raspi1b_machine_class_init(ObjectClass *oc, void *data)
> >> +{
> >> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >> +    RaspiMachineClass *rmc =3D RASPI_MACHINE_CLASS(oc);
> >> +
> >> +    rmc->board_rev =3D 0x900032;
> >> +    raspi_machine_class_common_init(mc, rmc->board_rev);
> >> +};
> >> +
> >>   static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
> >>   {
> >>       MachineClass *mc =3D MACHINE_CLASS(oc);
> >> @@ -348,6 +357,10 @@ static void raspi3b_machine_class_init(ObjectClas=
s *oc, void *data)
> >>  =20
> >>   static const TypeInfo raspi_machine_types[] =3D {
> >>       {
> >> +        .name           =3D MACHINE_TYPE_NAME("raspi1b"), =20
> > If it's the B+ model, why not call it raspi1b+ ? =20
>=20
> I thought about it (and prefer it), but I'm not sure this can have some=
=20
> side-effect.
>=20
> Eduardo, Igor, is that OK to use a '+' in a machine name?
>=20
> So far the names used match [a-zA-Z0-9-].
That was my impression as well.
How about "raspi1-plus"

=20
> >  =20
> >> +        .parent         =3D TYPE_RASPI_MACHINE,
> >> +        .class_init     =3D raspi1b_machine_class_init,
> >> +    }, {
> >>           .name           =3D MACHINE_TYPE_NAME("raspi2b"),
> >>           .parent         =3D TYPE_RASPI_MACHINE,
> >>           .class_init     =3D raspi2b_machine_class_init,
> >> =20
> >  =20
>=20


