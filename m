Received: from eggs.gnu.org ([2001:4830:134:3::10]:36455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1coWgE-0001yJ-3a
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1coWgA-00048w-4b
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:47:06 -0400
Received: from mail.ispras.ru ([83.149.199.45]:44986)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1coWg9-000483-TW
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 10:47:02 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170307155054.5833-1-alex.bennee@linaro.org>
	<001801d29bf5$dcba37d0$962ea770$@ru> <8760jdqpv2.fsf@linaro.org>
	<000101d29cbc$b8df1ca0$2a9d55e0$@ru> <87tw6vq43b.fsf@linaro.org>
	<000001d29e30$138e5700$3aab0500$@ru> <871stxpdzz.fsf@linaro.org>
In-Reply-To: <871stxpdzz.fsf@linaro.org>
Date: Thu, 16 Mar 2017 17:46:54 +0300
Message-ID: <002501d29e64$27b383c0$771a8b40$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com, qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> >> Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:
> >
> >> I ran the following test on both pre-mttcg-merge and my current =
HEAD
> >> which includes Paolo's fix series:
> >>
> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >>     -net none \
> >>     -icount shift=3D7,rr=3Drecord,rrfile=3Dreplay.bin
> >>
> >> And then:
> >>
> >>  ./arm-softmmu/qemu-system-arm -machine type=3Dvirt \
> >>     -display none -smp 1 -m 4096 -cpu cortex-a15 \
> >>     -kernel ../images/aarch32-current-linux-initrd-guest.img
> >>     -append "console=3DttyAMA0" -serial mon:stdio \
> >>     -net none \
> >>     -icount shift=3D7,rr=3Dreplay,rrfile=3Dreplay.bin
> >>
> >> And they both ran the same. However I kept running into:
> >>
> >>  [    3.542408] RPC: Registered tcp NFSv4.1 backchannel transport =
module.
> >> qemu-system-arm: Missing character write event in the replay log
> >>
> >> This seems to be a pre-existing
> >
> > Does it mean that qemu-arm platform includes some serial devices =
that were
> > not detected by the replay?
>=20
> It's the standard ARM platform serial port. When I read replay.txt is
> said:
>=20
>  * Supports i386, x86_64, and ARM hardware platforms.
>=20
> Should we add some qualifications about which machine types are
> supported? What is you ARM test case for record/replay?

I tested on vexpress-a9 platform with Debian wheezy.

Pavel Dovgalyuk
