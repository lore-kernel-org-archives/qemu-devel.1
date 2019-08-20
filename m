Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CAC9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:41:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716D022DD3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 20:41:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716D022DD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Aw8-000788-H1
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 16:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i0AtS-0005PM-JM
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i0AtO-00054u-Od
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:38:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i0AtO-00053z-5x
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 16:38:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B02FA2A09D5;
 Tue, 20 Aug 2019 20:38:07 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03DC21DA;
 Tue, 20 Aug 2019 20:37:59 +0000 (UTC)
Date: Tue, 20 Aug 2019 17:37:57 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190820203757.GK3908@habkost.net>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <7f6e8a5c-8262-ae39-333a-e8f18b3174f0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 20 Aug 2019 20:38:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Regression with floppy drive controller
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
Cc: Alex <coderain@sdf.org>, seabios@seabios.org,
 QEMU Developers <qemu-devel@nongnu.org>,
 Nikolay Nikolov <nickysn@users.sourceforge.net>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 06:21:28PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Cc'ing Eduardo, Paolo.
>=20
> On 8/20/19 3:38 PM, Philippe Mathieu-Daud=E9 wrote:
> > On 8/20/19 3:12 PM, John Snow wrote:
> >> On 8/20/19 6:25 AM, Philippe Mathieu-Daud=E9 wrote:
> >>> [cross posting QEMU & SeaBIOS]
> >>>
> >>> Hello,
> >>>
> >>> I'v been looking at a QEMU bug report [1] which bisection resulted =
in a
> >>> SeaBIOS commit:
> >>>
> >>> 4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
> >>> commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
> >>> Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
> >>> Date:   Sun Feb 4 17:27:01 2018 +0200
> >>>
> >>>     floppy: Use timer_check() in floppy_wait_irq()
> >>>
> >>>     Use timer_check() instead of using floppy_motor_counter in BDA =
for the
> >>>     timeout check in floppy_wait_irq().
> >>>
> >>>     The problem with using floppy_motor_counter was that, after it =
reaches
> >>>     0, it immediately stops the floppy motors, which is not what is
> >>>     supposed to happen on real hardware. Instead, after a timeout (=
like in
> >>>     the end of every floppy operation, regardless of the result - s=
uccess,
> >>>     timeout or error), the floppy motors must be kept spinning for
> >>>     additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
> >>>     floppy_motor_counter is initialized to 255 (the max value) in t=
he
> >>>     beginning of the floppy operation. For IRQ timeouts, a differen=
t
> >>>     timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT consta=
nt
> >>>     (currently set to 5 seconds - a fairly conservative value, but =
should
> >>>     work reliably on most floppies).
> >>>
> >>>     After the floppy operation, floppy_drive_pio() resets the
> >>>     floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).
> >>>
> >>>     This is also consistent with what other PC BIOSes do.
> >>>
> >>>
> >>> This commit improve behavior with real hardware, so maybe QEMU is n=
ot
> >>> modelling something or modelling it incorrectly?
> > [...]
> >>
> >> Well, that's unfortunate.
> >>
> >> What version of QEMU shipped the SeaBIOS that caused the regression?
> >=20
> > See https://bugs.launchpad.net/qemu/+bug/1840719/comments/3
> >=20
> > QEMU commit 0b8f74488e, slighly before QEMU v3.1.0
> > (previous tag is v3.0.0).
> >=20
> > But you can use v4.1.0 too, simply change the SeaBIOS bios.bin, i.e.:
> >=20
> >   qemu$ git checkout v4.1.0
> >=20
> >   qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4~) && \
> >         make -C roms bios
> >=20
> > Now pc-bios/bios.bin is built using the last commit working,
> >=20
> >   qemu$ (cd roms/seabios && git checkout 4a6dbcea3e4) && \
> >         make -C roms bios
> >=20
> > And you can reproduce the error.
>=20
> Back from here.
>=20
> So the SeaBIOS patch is:
>=20
> diff --git a/src/hw/floppy.c b/src/hw/floppy.c
> index 77dbade..3012b3a 100644
> --- a/src/hw/floppy.c
> +++ b/src/hw/floppy.c
> @@ -34,6 +34,7 @@
>  #define FLOPPY_GAPLEN 0x1B
>  #define FLOPPY_FORMAT_GAPLEN 0x6c
>  #define FLOPPY_PIO_TIMEOUT 1000
> +#define FLOPPY_IRQ_TIMEOUT 5000
>=20
>  #define FLOPPY_DOR_MOTOR_D     0x80 // Set to turn drive 3's motor ON
>  #define FLOPPY_DOR_MOTOR_C     0x40 // Set to turn drive 2's motor ON
> @@ -221,8 +222,9 @@ floppy_wait_irq(void)
>  {
>      u8 frs =3D GET_BDA(floppy_recalibration_status);
>      SET_BDA(floppy_recalibration_status, frs & ~FRS_IRQ);
> +    u32 end =3D timer_calc(FLOPPY_IRQ_TIMEOUT);
>      for (;;) {
> -        if (!GET_BDA(floppy_motor_counter)) {
> +        if (timer_check(end)) {
>              warn_timeout();
>              floppy_disable_controller();
>              return DISK_RET_ETIMEOUT;
>=20
> timer_calc() unit is milliseconds, so this patch should wait upto
> 5seconds before failing, and it seems the timeout is not used at all.
>=20
> SeaBIOS timer.c:
>=20
> // Return the TSC value that is 'msecs' time in the future.
> u32
> timer_calc(u32 msecs)
> {
>     return timer_read() + (GET_GLOBAL(TimerKHz) * msecs);
> }
>=20
> static u32
> timer_read(void)
> {
>     u16 port =3D GET_GLOBAL(TimerPort);
>     if (CONFIG_TSC_TIMER && !port)
>         // Read from CPU TSC
>         return rdtscll() >> GET_GLOBAL(ShiftTSC);
>     if (CONFIG_PMTIMER && port !=3D PORT_PIT_COUNTER0)
>         // Read from PMTIMER
>         return timer_adjust_bits(inl(port), 0xffffff);
>     // Read from PIT.
>     outb(PM_SEL_READBACK | PM_READ_VALUE | PM_READ_COUNTER0, PORT_PIT_M=
ODE);
>     u16 v =3D inb(PORT_PIT_COUNTER0) | (inb(PORT_PIT_COUNTER0) << 8);
>     return timer_adjust_bits(v, 0xffff);
> }
>=20
> Using the default QEMU config, we build SeaBIOS to use the TSC timer:
>=20
> builds/seabios-128k/.config:CONFIG_TSC_TIMER=3Dy
> builds/seabios-256k/.config:CONFIG_TSC_TIMER=3Dy
>=20
> $ qemu-system-i386 -M isapc -cpu 486 \
>   -fda Windows\ 98\ Second\ Edition\ Boot.img \
>   -chardev stdio,id=3Dseabios \
>   -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios
> Booting from Floppy...
> Floppy_drive_recal 0
> Floppy_enable_controller
> WARNING - Timeout at floppy_wait_irq:228!
> Floppy_disable_controller
> Floppy_enable_controller
> WARNING - Timeout at floppy_wait_irq:228!
> Floppy_disable_controller
> Boot failed: could not read the boot disk
>=20
> Now enabling the TSC feature:
>=20
> $ qemu-system-i386 -M isapc -cpu 486,tsc \
>   -fda Windows\ 98\ Second\ Edition\ Boot.img \
>   -chardev stdio,id=3Dseabios \
>   -device isa-debugcon,iobase=3D0x402,chardev=3Dseabios
> Booting from Floppy...
> Floppy_drive_recal 0
> Floppy_enable_controller
> Floppy_media_sense on drive 0 found rate 0
> Booting from 0000:7c00
> Floppy_disable_controller
> Floppy_enable_controller
> Floppy_drive_recal 0
> Floppy_media_sense on drive 0 found rate 0
>=20
> Do we need a cpu with TSC support to run SeaBIOS?
>=20
> So we should use '-cpu Conroe' or '-cpu core2duo' minimum?

It's probably about time we update qemu64 (the default CPU model)
to provide a more modern set of features.  Once libvirt adapts to
the CPU model alias/version interface we added in 4.1, this will
become easier to do.

--=20
Eduardo

