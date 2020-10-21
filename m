Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5B2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:40:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A6C22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGNdTbgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A6C22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVDPY-0002ns-RC
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDOC-0001T3-Ql
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:38:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVDOA-0005y0-51
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603283924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qxAnaWJZgPhYRyZWQoaNB72v2+FY8F1NoRwTlyqZ850=;
 b=YGNdTbgB1dfIery1DDnFBFYUqjGvQD4o2obXrhDi6NMbT6G3UKet+N638dLyA6JHF1KuEh
 zm1+2pyCodu8kySAhJLCxckwB+zUh7w6W0vpl2z3dTV4L1wWTCJ127CXBpfina2VuvlBeD
 rfAXwbd1lACy1kbim7J7NSwB3/l1nr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-p6nVvf7cMXCosVBz88Ksjw-1; Wed, 21 Oct 2020 08:38:41 -0400
X-MC-Unique: p6nVvf7cMXCosVBz88Ksjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA500101962C;
 Wed, 21 Oct 2020 12:38:38 +0000 (UTC)
Received: from localhost (unknown [10.40.208.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F81C5D9CA;
 Wed, 21 Oct 2020 12:38:34 +0000 (UTC)
Date: Wed, 21 Oct 2020 14:38:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 12/20] hw/mips/r4k: Explicit CPU frequency is 200 MHz
Message-ID: <20201021143832.30ec99b3@redhat.com>
In-Reply-To: <2c0fde77-4618-d5c2-3281-56ed706a9d2d@amsat.org>
References: <20201010204319.3119239-1-f4bug@amsat.org>
 <20201010204319.3119239-13-f4bug@amsat.org>
 <CABDp7Voq177fvHUJRXqrYtH2etqnKNmhYeVOZAForw=6oY5sTg@mail.gmail.com>
 <2c0fde77-4618-d5c2-3281-56ed706a9d2d@amsat.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 22:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 chen huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, Luc Michel <luc@lmichel.fr>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhc@lemote.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 12 Oct 2020 10:34:48 +0200
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Huacai,
>=20
> On 10/11/20 5:52 AM, chen huacai wrote:
> > Hi, Philippe,
> >=20
> > On Sun, Oct 11, 2020 at 4:43 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsa=
t.org> wrote: =20
> >>
> >> Since its introduction in commit 6af0bf9c7c3,
> >> the 'r4k' machine runs at 200 MHz.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> >> ---
> >>   hw/mips/r4k.c | 8 +++++++-
> >>   1 file changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/mips/r4k.c b/hw/mips/r4k.c
> >> index 3487013a4a1..e64687b505a 100644
> >> --- a/hw/mips/r4k.c
> >> +++ b/hw/mips/r4k.c
> >> @@ -37,6 +37,7 @@
> >>   #include "sysemu/reset.h"
> >>   #include "sysemu/runstate.h"
> >>   #include "qemu/error-report.h"
> >> +#include "hw/qdev-clock.h"
> >>
> >>   #define MAX_IDE_BUS 2
> >>
> >> @@ -184,6 +185,7 @@ void mips_r4k_init(MachineState *machine)
> >>       int bios_size;
> >>       MIPSCPU *cpu;
> >>       CPUMIPSState *env;
> >> +    Clock *cpuclk;
> >>       ResetData *reset_info;
> >>       int i;
> >>       qemu_irq *i8259;
> >> @@ -193,7 +195,11 @@ void mips_r4k_init(MachineState *machine)
> >>       int be;
> >>
> >>       /* init CPUs */
> >> -    cpu =3D MIPS_CPU(cpu_create(machine->cpu_type));
> >> +    cpu =3D MIPS_CPU(object_new(machine->cpu_type));
> >> +    cpuclk =3D clock_new(OBJECT(machine), "cpu-refclk");
> >> +    clock_set_hz(cpuclk, 200000000); /* 200 MHz */
> >> +    qdev_connect_clock_in(DEVICE(cpu), "clk-in", cpuclk);
> >> +    qdev_realize(DEVICE(cpu), NULL, &error_abort); =20
>  >
> > Can we add a new parameter to cpu_create() and set the freq in the core=
 code? =20
>=20
> Adding a new parameter seems a good idea.
>=20
> Both maintainers of the core code are reluctant to add
> a CPU clock to the core code, see:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg747589.html
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg747612.html
> Which is why I restricted that to the MIPS CPUs.
>=20
the reason for that is that it's used only by a handful of devices
and not widespread.

> On ARM, Damien started to use clocks on the Zynq SoC (merged):
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg694604.html
> Luc is working on adding a clock manager to the Broadcom SoC:
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg02840.html
>=20
> I also started converting one UART devices:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg727972.html
>=20
> So IMO the core code will soon require this. Maybe we will add it
> during the next development window.
>=20
> Meanwhile I can add a mips_cpu_create_with_clock() in preparation

boards that need property settings in between object_new() and realize()
typically open code just that and/or use plug/preplug handler(callback)
to set properties. preplug handler should work with cpu_create() just fine.

If you have multiple mips boards that will new clock mechanism,=20
mips_cpu_create_with_clock() wrapper would work as well (it's a bit less
complicated compared to preplug handler but not too much)

> of cpu_create_with_clock().
>=20
> >=20
> > Huacai =20
> >>       env =3D &cpu->env;
> >>
> >>       reset_info =3D g_malloc0(sizeof(ResetData));
> >> --
> >> 2.26.2
> >> =20
> >=20
> >  =20
>=20


