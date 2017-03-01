Received: from eggs.gnu.org ([2001:4830:134:3::10]:33909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cjCKY-0003ti-PD
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nutarojj@ornl.gov>) id 1cjCKU-0000mH-4A
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:42 -0500
Received: from mta02.ornl.gov ([128.219.177.136]:31728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <nutarojj@ornl.gov>) id 1cjCKT-0000lk-RJ
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 17:02:38 -0500
From: "Nutaro, James J." <nutarojj@ornl.gov>
Date: Wed, 1 Mar 2017 22:02:32 +0000
Message-ID: <3965b6e8520748b4b80f556f1da35c70@EXCHCS32.ornl.gov>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off does not appear to keep the rtc aligned with the virtual
 clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "'mttcg@listserver.greensocs.com'" <mttcg@listserver.greensocs.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


I'm having trouble with this patch

http://web.ornl.gov/~1qn/adevs/qqq.patch

which worked until I checked out the newest working copy of qemu from the m=
ain branch. The problem manifests itself when the elapsed time between virt=
ual clock events and the time reported by, say, a call to 'date' in the emu=
lator do not agree.=20

I've been digging through the (relevant?) changes but am so far at a loss t=
o explain the new behavior. I thought someone who had worked on the mttsc f=
eatures (the appearance of which seemed to coincide with this behavior) mig=
ht have some notion of what is going on. I'm running in the single threaded=
 tcg mode.

Thanks for any help you can provide,

Jim
