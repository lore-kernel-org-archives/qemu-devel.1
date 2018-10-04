Received: from eggs.gnu.org ([2001:4830:134:3::10]:40910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1g83a8-00022W-Ra
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1g83Tu-00081i-Ev
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:15:56 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:41324)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <artem.k.pisarenko@gmail.com>)
	id 1g83Tt-0007xP-4J
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 09:15:54 -0400
Received: by mail-ot1-x32b.google.com with SMTP id e18-v6so9090941oti.8
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 06:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANzW0mvSX5nWuinDU68W2yJzgoQSGAHPqpz0G36A6NKwRsz_4A@mail.gmail.com>
	<d45bff6c4e472811f01452b5f730c1b6@ispras.ru>
	<CANzW0mthuW0a7LR7DhpvTPnZ5n5DxtYyfYQf756vtyb9g0O7QQ@mail.gmail.com>
	<CANzW0muZaNRtOP6OjXJ11HXL_q2MDOhCxY2dXZc2DzHr5BxqLw@mail.gmail.com>
	<1930792321d9a0b16576359c7cec9f51@ispras.ru>
In-Reply-To: <1930792321d9a0b16576359c7cec9f51@ispras.ru>
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Thu, 4 Oct 2018 19:15:39 +0600
Message-ID: <CANzW0mta+dqVQUEPoXMuhwn+QY0+vBoOjBAj7BPmRL=z72Wxjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/25] Fixing record/replay and adding
 reverse debugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dovgaluk <dovgaluk@ispras.ru>
Cc: Pavel.Dovgaluk@ispras.ru, qemu-devel@nongnu.org

No, it didn't changed test results, at least for
https://github.com/ispras/qemu/tree/rr-180911 . Even step values it stucks
on are same for most runs.
Playing with master and my own branch gives different results for tests
without sleep=3Doff and -rtc base. It seems that patch you mentioned didn't
changed them very much.
The only thing can be said for sure, is that this patch does not fix issues
completely. But MAY fix them partially or in some other specific cases...

=D1=81=D1=80, 3 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 12:47, dovgaluk <do=
vgaluk@ispras.ru>:

> Can you try applying this patch?
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg563798.html
>
> I also encountered the problems with x86_64 replaying and found the
> misprint in
> the code which was fixed later, than sending the series to the mailing
> list.
>
> Pavel Dovgalyuk
>
>
> Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-10-02 10:02:
> > I've added "-monitor stdio" option to command line of Test 1 and
> > repeated entering command during execution:
> >
> >   QEMU 3.0.50 monitor - type 'help' for more information
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 311736195
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 318198367
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 324737211
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 329890795
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 607069789
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 607069789
> >   (qemu) info replay
> >   Replaying execution 'icount_rr_capture.bin': current step =3D
> > 607069789
> >   ...
> >
> > Some notes on value of step it stucks on:
> > - mostly it's same (even across different record-replay pairs);
> > - stressing host during replay may cause it to change even for same
> > record-replay pair (i.e. different replay executions for same file
> > recorded).
> >
> > This specific case seems to be stable to reproduce.
> >
> > =D0=B2=D1=82, 2 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 0:22, Artem Pis=
arenko
> > <artem.k.pisarenko@gmail.com>:
> >
> >> I've posted bug report with extended tests (incl. case without
> >> sleep=3Doff). You may find guest image (kernel) in bug description.
> >> https://bugs.launchpad.net/qemu/+bug/1795369 [1]
> >>
> >> The most annoying thing is that some issues are almost not
> >> reproducible. There are definitely race conditions somewhere in qemu
> >> code. Running 'stress-ng' utility with CPU and I/O stressors in
> >> parallel with qemu execution greatly minimizes amount of attempts
> >> when I'm trying to trigger some of issues I encounter.
> >>
> >> I'll try 'info monitor' command tomorrow, but no guarantees that
> >> I'll be able to reproduce issue again.
> >>
> >> Speaking about '-nographic' and SDL... I've noted that UI greatly
> >> minimizes possibility of hanging (but not avoids it completely) when
> >> using icount in general, so this effect isn't rr-specific. I've
> >> already reported this bug too.
> >>
> >> =D0=BF=D0=BD, 1 =D0=BE=D0=BA=D1=82. 2018 =D0=B3., 20:14 dovgaluk <dovg=
aluk@ispras.ru>:
> >>
> >>> Artem Pisarenko =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2018-09-30 14:01:
> >>>> Feature still broken :(
> >>>
> >>> Thanks for testing.
> >>>
> >>>>
> >>>> Brief description of my tests.
> >>>>
> >>>> Guest image is Linux, which just powers off after kernel boots
> >>>> (instead of proceeding to user-space /init or /sbin/init).
> >>>> Base cmdline:
> >>>> qemu-system-x86_64 -nodefaults -machine pc,accel=3Dtcg -m 2048
> >>> -cpu
> >>>> qemu64 -rtc clock=3Dvm,base=3D2000-01-01T00:00:00 -kernel bzImage
> >>> -initrd
> >>>> rootfs -append 'nokaslr console=3DttyS0 rdinit=3D/init_poweroff'
> >>>> -nographic -serial SERIAL_VALUE -icount
> >>>> 1,sleep=3Doff,rr=3DRR_VALUE,rrfile=3Dicount_rr_capture.bin
> >>>
> >>> I've never tried it with sleep=3Doff. Can you remove it and try
> >>> again?
> >>>
> >>> We also seen a problem with '-nographic'. When we remove this
> >>> option and
> >>> QEMU runs with SDL
> >>> window, everything is ok. There is some problem with main loop
> >>> which may
> >>> sleep when there
> >>> is no GUI to update, or something like that. We couldn't fix it
> >>> yet.
> >>>
> >>>>
> >>>> Test 1. When SERIAL_VALUE=3Dnone
> >>>> Running with RR_VALUE=3Drecord completes successfully.
> >>>> Running with RR_VALUE=3Dreplay doesn't completes. qemu process
> >>> just
> >>>> eating ~100% cpu and memory usage doesn't grow after some
> >>> moment. I
> >>>> don't see what happens because of problem no.2 (see below).
> >>>
> >>> Try 'info replay' monitor command. Does instruction counter
> >>> increases?
> >>>
> >>>>
> >>>> Test 2. When SERIAL_VALUE=3Dstdio
> >>>> Running with RR_VALUE=3Drecord completes successfully.
> >>>>
> >>>> Running with RR_VALUE=3Dreplay caues exit with error:
> >>>>
> >>>> "qemu-system-x86_64: Missing character write event in the replay
> >>> log"
> >>>>
> >>>> These problems are same with qemu 2.12 (both vanilla and with
> >>> previous
> >>>> versions of these patches applied). Furthemore, I consider whole
> >>>> icount mode broken and determinism isn't achievable.
> >>>> The irony is that I actually don't need record/replay feature.
> >>> I've
> >>>> tried to use it only as instrument to debug failing determinism
> >>> in
> >>>> qemu code. But since replay/record feature itself relies on
> >>>> determinism, which is broken, it's no wonder why it fails also
> >>> (I just
> >>>> hoped to bypass it).
> >>>>
> >>>> Contact me if you need more details. I just tired a lot trying
> >>> to get
> >>>> all these things working... Hope is leaving me...
> >>>
> >>> Can you share the kernel in case the icount still broken?
> >>>
> >>> Pavel Dovgalyuk
> >> --
> >>
> >> =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
> >> =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=
=BD=D0=BA=D0=BE
> >  --
> >
> > =D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
> >   =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=
=D0=BD=D0=BA=D0=BE
> >
> > Links:
> > ------
> > [1] https://bugs.launchpad.net/qemu/+bug/1795369
>
> --

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
  =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9F=D0=B8=D1=81=D0=B0=D1=80=D0=B5=D0=BD=
=D0=BA=D0=BE
