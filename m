Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16C9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C35CD22DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C35CD22DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05iJ-0004Qt-LZ
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i05gu-00034x-Q0
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i05gr-0008TW-G2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:04:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i05gq-0008SV-MH
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97627898107;
 Tue, 20 Aug 2019 15:04:51 +0000 (UTC)
Received: from work-vm (ovpn-117-33.ams2.redhat.com [10.36.117.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBFF81001DC2;
 Tue, 20 Aug 2019 15:04:45 +0000 (UTC)
Date: Tue, 20 Aug 2019 16:04:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190820150443.GM2867@work-vm>
References: <fccac7fa-888e-6ac5-458d-688808f3b282@redhat.com>
 <699eee57-3009-4160-a9a2-1070f92b9c20@redhat.com>
 <cc0b5a77-8bc4-070b-31e4-f29d5a174eb8@redhat.com>
 <1a45cee8-66e1-448d-78bc-4f0b9695cab4@redhat.com>
 <20190820143614.GJ2867@work-vm>
 <70fd81a1-08bb-5cc8-616c-68ec2a7472e2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <70fd81a1-08bb-5cc8-616c-68ec2a7472e2@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 20 Aug 2019 15:04:51 +0000 (UTC)
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

* Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> On 8/20/19 4:36 PM, Dr. David Alan Gilbert wrote:
> > * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
> >> On 8/20/19 3:38 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>> On 8/20/19 3:12 PM, John Snow wrote:
> >>>> On 8/20/19 6:25 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> [cross posting QEMU & SeaBIOS]
> >>>>>
> >>>>> Hello,
> >>>>>
> >>>>> I'v been looking at a QEMU bug report [1] which bisection resulte=
d in a
> >>>>> SeaBIOS commit:
> >>>>>
> >>>>> 4a6dbcea3e412fe12effa2f812f50dd7eae90955 is the first bad commit
> >>>>> commit 4a6dbcea3e412fe12effa2f812f50dd7eae90955
> >>>>> Author: Nikolay Nikolov <nickysn@users.sourceforge.net>
> >>>>> Date:   Sun Feb 4 17:27:01 2018 +0200
> >>>>>
> >>>>>     floppy: Use timer_check() in floppy_wait_irq()
> >>>>>
> >>>>>     Use timer_check() instead of using floppy_motor_counter in BD=
A for the
> >>>>>     timeout check in floppy_wait_irq().
> >>>>>
> >>>>>     The problem with using floppy_motor_counter was that, after i=
t reaches
> >>>>>     0, it immediately stops the floppy motors, which is not what =
is
> >>>>>     supposed to happen on real hardware. Instead, after a timeout=
 (like in
> >>>>>     the end of every floppy operation, regardless of the result -=
 success,
> >>>>>     timeout or error), the floppy motors must be kept spinning fo=
r
> >>>>>     additional 2 seconds (the FLOPPY_MOTOR_TICKS). So, now the
> >>>>>     floppy_motor_counter is initialized to 255 (the max value) in=
 the
> >>>>>     beginning of the floppy operation. For IRQ timeouts, a differ=
ent
> >>>>>     timeout is used, specified by the new FLOPPY_IRQ_TIMEOUT cons=
tant
> >>>>>     (currently set to 5 seconds - a fairly conservative value, bu=
t should
> >>>>>     work reliably on most floppies).
> >>>>>
> >>>>>     After the floppy operation, floppy_drive_pio() resets the
> >>>>>     floppy_motor_counter to 2 seconds (FLOPPY_MOTOR_TICKS).
> >>>>>
> >>>>>     This is also consistent with what other PC BIOSes do.
> >>>>>
> >>>>>
> >>>>> This commit improve behavior with real hardware, so maybe QEMU is=
 not
> >>>>> modelling something or modelling it incorrectly?
> [...]
> >> Looking at the fdc timer I noticed it use a static '50 ns' magic val=
ue.
> >=20
> > That's not 50ns
> >=20
> >> Increasing this value allows the floppy image to boot again, using t=
his
> >> snippet:
> >>
> >> -- >8 --
> >> diff --git a/hw/block/fdc.c b/hw/block/fdc.c
> >> index 9b24cb9b85..5fc54073fd 100644
> >> --- a/hw/block/fdc.c
> >> +++ b/hw/block/fdc.c
> >> @@ -2134,7 +2134,7 @@ static void fdctrl_handle_readid(FDCtrl *fdctr=
l,
> >> int direction)
> >>
> >>      cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
> >>      timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VI=
RTUAL) +
> >> -             (NANOSECONDS_PER_SECOND / 50));
> >=20
> > That's 1/50th of a second in ns.
>=20
> Just noticed that too, so we have here 20ms.
>=20
> >> +             (NANOSECONDS_PER_SECOND / 5000));
> >=20
> > I'm not too sure about readid; but assuming we're rotating at 360rpm,
> > that's 6 revolutions/second, and 18 sectors/track =3D 108 sectors/sec=
ond
> > (half of that for a double density disk).
> >=20
> > So, the wait for a sector to spin around and read feels like it shoul=
d
> > be in the region of 1/108 of a second + some latency - so 1/50th of a
> > second would seem to be in the ballpark or being right, where as 1/50=
00
> > of a second is way too fast for a poor old floppy.
>=20
> The first command sent is READ_ID.
>=20
> Reading the Intel 82077AA datasheet:
>=20
>   The READ ID command is used to find the present
>   position of the recording heads. The 82077AA
>   stores the values from the first ID Field it is able to
>   read into its registers. If the 82077AA does not find
>   an ID Address Mark on the diskette after the second
>   occurrence of a pulse on the IDX pin, it then sets the
>   IC code in Status Register 0 to =E2=80=98=E2=80=9801=E2=80=99=E2=80=99=
 (Abnormal ter-
>   mination), sets the MA bit in Status Register 1 to
>   =E2=80=98=E2=80=991=E2=80=99=E2=80=99, and terminates the command.
>=20
> Then later the SPECIFICATIONS table:
>=20
>   nRD/nWR Pulse Width: min 90ns
>   INDEX Pulse Width: min 5 'Internal Clock Period'

Note that's the pulse width, not the gap between the idx pulses.
My understanding is that an index pulse is once per rotation; ie. every
1/60th of a second.

The failure after 2 IDX pin pulses makes sense, that's saying if you've
not found a sector after spinning the disk twice then you fail.

So, your time to deliver a good result to a readid shoukd be the
rotational time for 1 or 2 sectors, where as the time to fail should
be the rotational time for about 2 whole rotations (ie 1/30 of a
second).

Dave

>   The nominal values for the 'internal clock period' for the various
>   data rates are:
>=20
>     1 Mbps:  3 * osc period =3D 125ns
>   500 Kbps:  6 * osc period =3D 250ns
>   300 Kbps: 10 * osc period =3D 420ns
>   250 Kbps: 12 * osc period =3D 500ns
>=20
> IIUC the model we have DATARATE SELECT REGISTER (DSR) =3D 0
>=20
> So DRATESEL=3D0 =3D> datarate =3D 500 Kbps
>=20
> So we should wait at least 250ns.
>=20
> Trying the following snippet it also works:
>=20
> -- >8 --
> @@ -2133,8 +2133,8 @@ static void fdctrl_handle_readid(FDCtrl *fdctrl,
> int direction)
>      FDrive *cur_drv =3D get_cur_drv(fdctrl);
>=20
>      cur_drv->head =3D (fdctrl->fifo[1] >> 2) & 1;
> -    timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL) +
> -             (NANOSECONDS_PER_SECOND / 50));
> +    timer_mod(fdctrl->result_timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTU=
AL)
> +                                    + 250);
>  }
> ---
>=20
> Note this is not the spining-up delay on reset:
>=20
>   Before data can be transferred to or from the disk-
>   ette, the disk drive motor must be brought up to
>   speed. For most 3(/2 =C3=97 disk drives, the spin-up time is
>   300 ms, while the 5(/4 =C3=97 drive usually requires about
>   500 ms due to the increased moment of inertia asso-
>   ciated with the larger diameter diskette.
>=20
> This looks more closer to the 20ms order. So maybe what we miss
> here is a RESET delay (of 500ms?) previous to the READ_ID?
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

