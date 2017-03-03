Received: from eggs.gnu.org ([2001:4830:134:3::10]:54904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cjt2S-0001Yv-MI
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cjt2P-0006JI-Kl
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:38:52 -0500
Received: from mta02.ornl.gov ([128.219.177.136]:34825)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cjt2P-0006IM-Bm
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:38:49 -0500
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Fri, 3 Mar 2017 19:38:43 +0000
Message-ID: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'mttcg@listserver.greensocs.com'" <mttcg@listserver.greensocs.com>
Cc: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>

My original problem seems to stem from something that changed in the way th=
at device emulation and instruction execution interact (I'm guessing). To r=
eproduce the issue, I started a linux image with

qemu-system-i386 -rtc clock=3Dvm -monitor none -icount 1,sleep=3Doff jack.i=
mg

After booting, I run

ping localhost

The first round trip time reports look reasonable, being in the millisecond=
 to sub-millisecond range. These occur while the emulator is running slower=
 than real time.=20

After a bit, the emulator speeds up (skipping over idle periods during I/O?=
) and the round trip times jump to hundreds of milliseconds, which I had no=
t expected.

If you want to try this experiment yourself, you can get the disk image tha=
t I used from here:

http://www.ornl.gov/~1qn/qemu-images/jack.img


Jim
