Received: from eggs.gnu.org ([2001:4830:134:3::10]:40301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOj4g-0003uA-V9
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOj4c-0001eI-1k
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:54:46 -0500
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:49790
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1gOj4b-0001ds-Nf
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:54:42 -0500
From: balducci@units.it
In-reply-to: Your message of "Mon, 19 Nov 2018 10:43:30 +0000."
	<20181119104330.GA2367@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16965.1542632079.1@dschgrazlin2.units.it>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Nov 2018 13:54:15 +0100
Message-ID: <16966.1542632079@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] 3.1.0-rc{0,1} doesn't start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

hi

thanks for taking the time to reply

Dr. David Alan Gilbert writes:
> > I suspect that this might be some problem on my side, as I couldn't
> > find any similar report (apart some old (qemu-2.8.50) threads, that
> > didn't help)
>
> Not necessarily; can you tell me:
>   a) At what point does it fail - immediately when booting the guest?
>      Some time during the boot? Later?
>   b) What guest does it happen on?

a) the error happens almost immediately; I mean: when I run qemu from an
   xterm, it doesn't even popup its window: it just dumps the error
   message to the terminal and stops
b) the guest is an old windows XP OS; but, as I say above, all goes as
   if qemu doesn't even load the OS image (at least this is my
   impression)

Meantime, I have tried to (quick&dirty) disable the error
catching/asserting in i386/kvm.c:

install:41> diff ./qemu-3.1.0-rc1/target/i386/kvm.c.MSR_HACK ./qemu-3.1.0-=
rc1/target/i386/kvm.c
2205c2205
<     if (ret < cpu->kvm_msr_buf->nmsrs) {
---
>     if (1=3D=3D0) {
2211c2211
<     assert(ret =3D=3D cpu->kvm_msr_buf->nmsrs);
---
>     assert(1=3D=3D1);
2524c2524
<     if (ret < cpu->kvm_msr_buf->nmsrs) {
---
>     if (1=3D=3D0) {
2530c2530
<     assert(ret =3D=3D cpu->kvm_msr_buf->nmsrs);
---
>     assert(1=3D=3D1);

and that makes qemu start and work without apparent problems.
Of course, that is a crude and risky (I guess) workaround...

thanks again

ciao
-gabriele
