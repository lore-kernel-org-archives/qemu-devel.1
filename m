Received: from eggs.gnu.org ([2001:4830:134:3::10]:48571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1eZDlR-0006EO-Mg
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:37:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1eZDlN-0001g5-TV
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 05:37:45 -0500
From: luigi burdo <intermediadc@hotmail.com>
Date: Wed, 10 Jan 2018 10:37:37 +0000
Message-ID: <AM5P194MB0132AB1A7F3CE7E09346CDC4C8110@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <20180108055348.20444-1-david@gibson.dropbear.id.au>
	<CAFEAcA_vmTqHdjL6QfKtn-Khg2RHBA7Vs3QxreXwe2J_7mhGAQ@mail.gmail.com>,
	<20180109121653.GN2131@umbus.fritz.box>
In-Reply-To: <20180109121653.GN2131@umbus.fritz.box>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 00/12] ppc-for-2.12 queue 20180108
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, Greg
	Kurz <groug@kaod.org>, "surajjs@au1.ibm.com" <surajjs@au1.ibm.com>

Hi devs sorry if i enter in the discussion about.

gcc gave errors in building this queue.

here i paste my build log.

https://pastebin.com/fXw2Whrq



This is my machine infos and so and so


Architecture:        ppc64
CPU op-mode(s):      32-bit, 64-bit
Byte Order:          Big Endian
CPU(s):              4
On-line CPU(s) list: 0-3
Thread(s) per core:  1
Core(s) per socket:  1
Socket(s):           4
NUMA node(s):        1
Model:               1.1 (pvr 0044 0101)
Model name:          PPC970MP, altivec supported
CPU max MHz:         2500.0000
CPU min MHz:         1250.0000
L1d cache:           32K
L1i cache:           64K
L2 cache:            1024K
NUMA node0 CPU(s):   0-3


uname -a
Linux debian 4.9.67 #1 SMP Sat Dec 9 12:20:20 CET 2017 ppc64 GNU/Linux

gcc --version
gcc (Debian 7.2.0-19) 7.2.0



Regards
Luigi

________________________________
Da: Qemu-ppc <qemu-ppc-bounces+intermediadc=3Dhotmail.com@nongnu.org> per c=
onto di David Gibson <david@gibson.dropbear.id.au>
Inviato: marted=EC 9 gennaio 2018 13:16
A: Peter Maydell
Cc: Michael Roth; QEMU Developers; qemu-ppc@nongnu.org; Greg Kurz; surajjs@=
au1.ibm.com
Oggetto: Re: [Qemu-ppc] [PULL 00/12] ppc-for-2.12 queue 20180108

On Tue, Jan 09, 2018 at 11:46:41AM +0000, Peter Maydell wrote:
> On 8 January 2018 at 05:53, David Gibson <david@gibson.dropbear.id.au> wr=
ote:
> > The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a6=
51b8:
> >
> >   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-=
request' into staging (2017-12-22 00:11:36 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/dgibson/qemu.git tags/ppc-for-2.12-20180108
> >
> > for you to fetch changes up to 9f173585d3f35345b2facce50620ce2cdda05f2f=
:
> >
> >   spapr: Correct compatibility mode setting for hotplugged CPUs (2018-0=
1-08 13:33:17 +1100)
> >
> > ----------------------------------------------------------------
> > ppc patch queue 2018-01-08
> >
> > This pull requests supersedes both ppc-for-2.12-20180103 and
> > ppc-for-2.12-20171219.  We've discovered that some substantial
> > extensions to the proposed capabilities infrastructure will be
> > valuable, amongst other things for managing/advertising workarounds
> > for the dreaded Meltdown/Spectre bugs.
> >
> > Although that could be done as follow on changes, since the caps
> > infrastructure hasn't been merged yet, we might as well pull it out
> > while we rework, and just merge the unrelated bugfixes.
> >
> > The last two pull requests apparently had problems on some arm32
> > systems.  I haven't been able to reproduce those, so I have no idea
> > which patch is causing them.  If we get lucky and it was one of the
> > patches I've removed from this series, this may also serve to unjam
> > the other fixes.
>
> This still hangs on my arm32 setup in the migration test. I'll see
> if I can identify what is going wrong.

Thanks.  Even if you can identify which patch it is and we can
postpone that one would be a bug help.

--
David Gibson                    | I'll have my music baroque, and my code
david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
                                | _way_ _around_!
http://www.ozlabs.org/~dgibson
[http://www.ozlabs.org/~dgibson/dgibson-small.jpg]<http://www.ozlabs.org/~d=
gibson>

David Gibson's Home Page - OzLabs<http://www.ozlabs.org/~dgibson>
www.ozlabs.org
Home; Papers; Junk code; PGP Key; Ozlabs. David Gibson's Home Page. I'm a L=
inux kernel hacker, mostly, though I've also worked on other projects inclu=
ding, recently ...
