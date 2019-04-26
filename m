Received: from eggs.gnu.org ([209.51.188.92]:41947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uC-0000V7-FL
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uB-0005Lh-De
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:48 -0400
Received: from dschgrazlin2.univ.trieste.it ([140.105.55.81]:51258
	helo=dschgrazlin2.units.it) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balducci@units.it>) id 1hK1uB-0005L1-49
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 10:32:47 -0400
From: balducci@units.it
Reply-to: balducci@units.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1277.1556289158.1@dschgrazlin2.units.it>
Date: Fri, 26 Apr 2019 16:32:14 +0200
Message-ID: <1278.1556289158@dschgrazlin2.units.it>
Subject: Re: [Qemu-devel] Using --enable-kvm fails with WindowsXP guest on
 an AMD host (works on Intel host)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: antti@fennosys.fi
Cc: qemu-devel@nongnu.org

(apologies if this doesn't get properly threaded into:
http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg03407.html)

> After upgrading host (Gentoo Linux) a Windows XP guest can't boot anymore.
>
> Some findings while testing:
>
> * XP image boots & works OK on an Intel machine (Gentoo Linux)
> ** qemu: 3.1.0-r4
> ** kernel: 5.0.7
> ** CPU: Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz
>
> * XP image FAILS to boot on an AMD machine (Gentoo Linux)
> ** qemu: 3.1.0-r4
> ** kernel: 4.19.34
> ** CPU: AMD FX-6300 Six-Core Processor
> ** image boots OK if NOT using --enable-kvm
>
> * XP image FAILS to boot on an AMD machine (Gentoo Linux)
> ** qemu: 3.1.0-r4 & 3.1.0-r1
> ** kernel: 4.19.34 & 5.0.7
> ** CPU: AMD Opteron(tm) Processor 4170 HE
> ** image boots OK if NOT using --enable-kvm
> ** The image worked OK on this machine with Qemu 2.12.1 & Kernel 4.18.20

Same here, on an AMD Athlon(tm) X4 860K Quad Core Processor

AFAICS, something has gone wrong starting with kernel-5.0.6

For me:
            GOOD      BAD
            4.20.14   5.0.6
            5.0.2     5.0.7
            5.0.3
            5.0.4
            5.0.5

Full details available in my earlier report here
https://bugzilla.kernel.org/show_bug.cgi?id=203327

I've updated my original report with a reference to this one.

ciao
-gabriele
