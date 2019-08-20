Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A1DC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594D822CF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594D822CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05G9-0006SB-JV
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i05FI-0005tC-MZ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i05FG-0005hE-TB
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41804)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i05FG-0005gx-Lj
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:36:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9FCB30043E1;
 Tue, 20 Aug 2019 14:36:21 +0000 (UTC)
Received: from work-vm (ovpn-117-33.ams2.redhat.com [10.36.117.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A6005D9CD;
 Tue, 20 Aug 2019 14:36:17 +0000 (UTC)
Date: Tue, 20 Aug 2019 15:36:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190820143614.GJ2867@work-vm>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <1a45cee8-66e1-448d-78bc-4f0b9695cab4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1a45cee8-66e1-448d-78bc-4f0b9695cab4@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 20 Aug 2019 14:36:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [SeaBIOS] Re: Regression with floppy drive
 controller
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
Cc: Alex <coderain@sdf.org>, Nikolay Nikolov <nickysn@users.sourceforge.net>,
 seabios@seabios.org, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
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
> Looking at the fdc timer I noticed it use a static '50 ns' magic value.

That's not 50ns

> Increasing this value allows the floppy image to boot again, using this
> snippet:
>=20
> -- >8 --
> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> index 9b24cb9b85..5fc54073fd 100644
> --- a/hw/block/fdc.c
> +++ b/hw/block/fdc.c
> @@ -2134,7 +2134,7 @@ static void fdctrl_handle_readid(FDCtrl *fdctrl,
> int direction)
>=20
>      cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
>      timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) +
> -             (NANOSECONDS_PER_SECOND / 50));

That's 1/50th of a second in ns.

> +             (NANOSECONDS_PER_SECOND / 5000));

I'm not too sure about readid; but assuming we're rotating at 360rpm,
that's 6 revolutions/second, and 18 sectors/track =3D 108 sectors/second
(half of that for a double density disk).

So, the wait for a sector to spin around and read feels like it should
be in the region of 1/108 of a second + some latency - so 1/50th of a
second would seem to be in the ballpark or being right, where as 1/5000
of a second is way too fast for a poor old floppy.

Dave

>  }
>=20
>  static void fdctrl_handle_format_track(FDCtrl *fdctrl, int direction)
> ---
>=20
> Any idea what is the correct value to use here?
>=20
> Regards,
>=20
> Phil.
> _______________________________________________
> SeaBIOS mailing list -- seabios@seabios.org
> To unsubscribe send an email to seabios-leave@seabios.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

